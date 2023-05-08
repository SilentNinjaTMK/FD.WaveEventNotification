global function WaveEventNotification_Init
// global function CreateCarePackage
const int ANNOUNCEMENT_STYLE_BIG = 0
const int ANNOUNCEMENT_STYLE_QUICK = 1
const int ANNOUNCEMENT_STYLE_PLAYER_LEVEL = 2
const int ANNOUNCEMENT_STYLE_WEAPON_LEVEL = 3
const int ANNOUNCEMENT_STYLE_SWEEP = 5
const int ANNOUNCEMENT_STYLE_RESULT = 6
const int ANNOUNCEMENT_STYLE_OBJECTIVE = 7

// WAVE_STATE_BREAK 回合休息
// WAVE_STATE_COMPLETE 回合完成
// WAVE_STATE_IN_PROGRESS 回合开始

void function WaveEventNotification_Init()
{
    //eGameState.Playing（即游戏开始时）调用下面的StartWaveStateLoop函数
    AddCallback_GameStateEnter(eGameState.Playing, StartWaveStateLoop)
}

void function StartWaveStateLoop()
{
    //thread就是开始新的线程使执行可以同时执行
    thread StartWaveStateLoop_Threaded()
}

//定义一个发送信息的函数
void function SendMessageToAllPlayers_AnnouncementMessage( string title, string subtitle, vector color, int priority, int style )
{
    foreach ( entity player in GetPlayerArray() )
        NSSendAnnouncementMessageToPlayer( player, title, subtitle, color, priority, style )
}

void function SendMessageToAllPlayers_PopUpMessage( string title, int priority )
{
    foreach ( entity player in GetPlayerArray() )
        NSSendPopUpMessageToPlayer( player, title );
}

void function StartWaveStateLoop_Threaded()
{
    int lastWaveState //用于存上一个tick中的波次状态，要卸载while外面，防止下一次循环开始时被清空
    bool firstLoop = true
    while(true)
    {
        int currentWaveState = GetGlobalNetInt("FD_waveState") //当前tick的波次状态
        bool waveStateChanged = currentWaveState != lastWaveState //检查波次是否更新

        //回合即将开始判定
        if(currentWaveState == WAVE_STATE_IN_PROGRESS)
        {
            if(waveStateChanged && !firstLoop)
            {
                int waveCount = GetGlobalNetInt("FD_currentWave")
                switch (waveCount) { //根据波次输出信息 0-5
                    case 0:
                        print("")
                        SendMessageToAllPlayers_AnnouncementMessage("偵測到重力異常","test",<1,1,0>, 1, 5)
                        // SendMessageToAllPlayers_PopUpMessage("test", 2)
                        ServerCommand( "sv_gravity 375" )
                        break;
                    case 1:
                        print("")
                        break;
                    case 2:
                        print("")
                        break;
                    case 3:
                        print("")
                        SendMessageToAllPlayers_AnnouncementMessage("偵測到高價值目標","擊毀一架高價值目標可獲得$200",<1,1,0>, 1, 5)
                        break;
                    case 4:
                        print("")
                        // SendMessageToAllPlayers_AnnouncementMessage("偵測到敵方補給單位","駕駛泰坦擊毀目標可為泰坦回復護盾能量和生命值",<1,1,0>, 1, 6)
                        break;
                    case 5:
                        print("")
                        break;
                }
            }
        }

        //回合完成判定
        if(currentWaveState == WAVE_STATE_COMPLETE)
        {
            if(waveStateChanged && !firstLoop)
            {
                int waveCount = GetGlobalNetInt("FD_currentWave")
                switch (waveCount) { //根据波次输出信息 0-5
                    case 0:
                        print("第一波次完成")
                        break;
                    case 1:
                        print("第二波次完成")
                        break;
                    case 2:
                        print("第三波次完成")
                        break;
                    case 3:
                        print("第四波次完成")
                        break;
                    case 4:
                        print("第五波次完成")
                        break;
                    case 5:
                        print("第六波次完成")
                        break;
                }
            }
        }

        // 回合休息判定
        if(currentWaveState == WAVE_STATE_BREAK)
        {
            if(waveStateChanged && !firstLoop)
            {
                int waveCount = GetGlobalNetInt("FD_currentWave")
                switch (waveCount) { //根据波次输出信息 0-5
                    case 0:
                        print("")
                        break;
                    case 1:
                        print("")
                        break;
                    case 2:
                        print("")
                        break;
                    case 3:
                        print("")
                        break;
                    case 4:
                        print("")
                        break;
                    case 5:
                        print("")
                        break;
                }
            }
        }

        firstLoop= false
        lastWaveState = GetGlobalNetInt("FD_waveState") //更新tick

        WaitFrame() //等待1tick直到下一个tick开始
    }
}

// void function CreateCarePackage()
// {

// }