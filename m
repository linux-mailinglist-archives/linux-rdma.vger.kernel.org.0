Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37519231BB3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgG2I51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 04:57:27 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:45313 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2I50 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 04:57:26 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 06T8vDop008213;
        Wed, 29 Jul 2020 01:57:14 -0700
Date:   Wed, 29 Jul 2020 14:27:13 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
Subject: Re: Hang at NVME Host caused by Controller reset
Message-ID: <20200729085711.GA5762@chelsio.com>
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
 <20200728174224.GA5497@chelsio.com>
 <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
 <54cc5ecf-bd04-538c-fa97-7c4d2afd92d7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cc5ecf-bd04-538c-fa97-7c4d2afd92d7@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, July 07/28/20, 2020 at 13:20:38 -0700, Sagi Grimberg wrote:
> 
> >>This time, with "nvme-fabrics: allow to queue requests for live queues"
> >>patch applied, I see hang only at blk_queue_enter():
> >
> >Interesting, does the reset loop hang? or is it able to make forward
> >progress?
> 
> Looks like the freeze depth is messed up with the timeout handler.
> We shouldn't call nvme_tcp_teardown_io_queues in the timeout handler
> because it messes with the freeze depth, causing the unfreeze to not
> wake the waiter (blk_queue_enter). We should simply stop the queue
> and complete the I/O, and the condition was wrong too, because we
> need to do it only for the connect command (which cannot reset the
> timer). So we should check for reserved in the timeout handler.
> 
> Can you please try this patch?
Even with this patch I see hangs, as shown below:
[  +0.000174] nvme nvme0: creating 1 I/O queues.
[  +0.001145] nvme nvme0: mapped 1/0/0 default/read/poll queues.
[ +24.026614] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +0.553164] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.000933] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[Jul29 07:17] nvme nvme0: queue 0: timeout request 0xe type 4
[ +13.816015] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +1.782975] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.000882] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[Jul29 07:18] nvme nvme0: queue 0: timeout request 0xe type 4
[  +4.413969] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +0.555863] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.001006] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[Jul29 07:19] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +0.617088] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.000864] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[  +4.369233] nvme nvme0: queue 0: timeout request 0xe type 4
[ +12.288452] INFO: task bash:2749 blocked for more than 122 seconds.
[  +0.000125]       Not tainted 5.8.0-rc7ekr+ #2
[  +0.000115] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000181] bash            D13600  2749   2748 0x00000000
[  +0.000123] Call Trace:
[  +0.000122]  __schedule+0x32b/0x670
[  +0.000117]  schedule+0x45/0xb0
[  +0.000137]  schedule_timeout+0x216/0x330
[  +0.000157]  ? enqueue_task_fair+0x196/0x7e0
[  +0.000150]  wait_for_completion+0x81/0xe0
[  +0.000164]  __flush_work+0x114/0x1c0
[  +0.000121]  ? flush_workqueue_prep_pwqs+0x130/0x130
[  +0.000129]  nvme_reset_ctrl_sync+0x25/0x40 [nvme_core]
[  +0.000146]  nvme_sysfs_reset+0xd/0x20 [nvme_core]
[  +0.000133]  kernfs_fop_write+0xbc/0x1a0
[  +0.000122]  vfs_write+0xc2/0x1f0
[  +0.000115]  ksys_write+0x5a/0xd0
[  +0.000117]  do_syscall_64+0x3e/0x70
[  +0.000117]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000119] RIP: 0033:0x7f37701ca317
[  +0.000113] Code: Bad RIP value.
[  +0.000112] RSP: 002b:00007fff64bb25e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  +0.000212] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
00007f37701ca317
[  +0.000132] RDX: 0000000000000002 RSI: 000055b0821a8140 RDI:
0000000000000001
[  +0.000121] RBP: 000055b0821a8140 R08: 000000000000000a R09:
0000000000000001
[  +0.000120] R10: 000055b081b4d471 R11: 0000000000000246 R12:
0000000000000002
[  +0.000148] R13: 00007f37702a46a0 R14: 00007f37702a54a0 R15:
00007f37702a48a0
[  +0.000124] INFO: task nvme:21284 blocked for more than 122 seconds.
[  +0.000119]       Not tainted 5.8.0-rc7ekr+ #2
[  +0.000115] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000219] nvme            D14392 21284   2740 0x00004000
[  +0.000121] Call Trace:
[  +0.000123]  __schedule+0x32b/0x670
[  +0.000136]  schedule+0x45/0xb0
[  +0.000130]  blk_queue_enter+0x1e9/0x250
[  +0.000118]  ? wait_woken+0x70/0x70
[  +0.000117]  blk_mq_alloc_request+0x53/0xc0
[  +0.000142]  nvme_alloc_request+0x61/0x70 [nvme_core]
[  +0.000125]  nvme_submit_user_cmd+0x50/0x310 [nvme_core]
[  +0.000128]  nvme_user_cmd+0x12e/0x1c0 [nvme_core]
[  +0.000126]  ? _copy_to_user+0x22/0x30
[  +0.000118]  blkdev_ioctl+0x100/0x250
[  +0.000119]  block_ioctl+0x34/0x40
[  +0.000118]  ksys_ioctl+0x82/0xc0
[  +0.000117]  __x64_sys_ioctl+0x11/0x20
[  +0.000125]  do_syscall_64+0x3e/0x70
[  +0.000143]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000125] RIP: 0033:0x7f954ee8567b
[  +0.000134] Code: Bad RIP value.
[  +0.000138] RSP: 002b:00007ffcd9be20a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  +0.000184] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f954ee8567b
[  +0.000121] RDX: 00007ffcd9be20b0 RSI: 00000000c0484e43 RDI:
0000000000000003
[  +0.000120] RBP: 0000000000000000 R08: 0000000000000001 R09:
0000000000000000
[  +0.000151] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffcd9be3219
[  +0.000128] R13: 0000000000000006 R14: 00007ffcd9be2760 R15:
000055aad89024a0


> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 62fbaecdc960..c3288dd2c92f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -464,6 +464,7 @@ static void nvme_tcp_error_recovery(struct
> nvme_ctrl *ctrl)
>         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>                 return;
> 
> +       dev_warn(ctrl->device, "starting error recovery\n");
>         queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
>  }
> 
> @@ -2156,33 +2157,37 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
>         struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
>         struct nvme_tcp_cmd_pdu *pdu = req->pdu;
> 
> -       /*
> -        * Restart the timer if a controller reset is already scheduled. Any
> -        * timed out commands would be handled before entering the
> connecting
> -        * state.
> -        */
> -       if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
> -               return BLK_EH_RESET_TIMER;
> -
>         dev_warn(ctrl->ctrl.device,
>                 "queue %d: timeout request %#x type %d\n",
>                 nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
> 
> -       if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
> +       switch (ctrl->ctrl.state) {
> +       case NVME_CTRL_RESETTING:
>                 /*
> -                * Teardown immediately if controller times out
> while starting
> -                * or we are already started error recovery. all outstanding
> -                * requests are completed on shutdown, so we return
> BLK_EH_DONE.
> +                * Restart the timer if a controller reset is
> already scheduled.
> +                * Any timed out commands would be handled before
> entering the
> +                * connecting state.
>                  */
> -               flush_work(&ctrl->err_work);
> -               nvme_tcp_teardown_io_queues(&ctrl->ctrl, false);
> -               nvme_tcp_teardown_admin_queue(&ctrl->ctrl, false);
> -               return BLK_EH_DONE;
> +               return BLK_EH_RESET_TIMER;
> +       case NVME_CTRL_CONNECTING:
> +               if (reserved) {
> +                       /*
> +                        * stop queue immediately if controller
> times out while connecting
> +                        * or we are already started error recovery.
> all outstanding
> +                        * requests are completed on shutdown, so we
> return BLK_EH_DONE.
> +                        */
> +                       nvme_tcp_stop_queue(&ctrl->ctrl,
> nvme_tcp_queue_id(req->queue));
> +                       nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
> +                       nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +                       blk_mq_complete_request(rq);
> +                       return BLK_EH_DONE;
> +               }
> +               /* fallthru */
> +       default:
> +       case NVME_CTRL_LIVE:
> +               nvme_tcp_error_recovery(&ctrl->ctrl);
>         }
> 
> -       dev_warn(ctrl->ctrl.device, "starting error recovery\n");
> -       nvme_tcp_error_recovery(&ctrl->ctrl);
> -
>         return BLK_EH_RESET_TIMER;
>  }
> --
