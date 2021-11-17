Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104F2454588
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 12:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhKQLY0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 06:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhKQLYZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Nov 2021 06:24:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A3C061570
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 03:21:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id l22so6622945lfg.7
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUymyk7ZQa9hAvOVscIY3mcQkNhHHJJg/pcxaiRKp60=;
        b=E4NFm4kWOtM+9yLPreTF2OqCj58REP65Eu1UqS8WaooweHcH1/GM5E8RvHMeaUMdAK
         HmNZgSPtVsxwFRCPMWNH9YSFrS76DNENyzjkOlxSRCNJvdQYy9hmsyBOyMvlXHBx3cDj
         JQ6N+RV7WvmKAzfPI92D1Zo2+D5K5txlZxi2lU43UeoTG6imN6urxWGcaXEBnDWuVFIB
         HnlV2Ehk98ERG+SKSjruOKdp7v6qkQQNSeRvUj/9HBDWzq3Hswvp2ytYG/P7AFu3GRfW
         j0eeZB8jn+QPju1UJ3viXYlCB6pAVabKishVRjDbjlt8xO4HQVsB/xeTTzoNuhRwBXV1
         5jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUymyk7ZQa9hAvOVscIY3mcQkNhHHJJg/pcxaiRKp60=;
        b=qQm1Yh+tbxwkHV8YC3pTZK/cn5iSGTP/OMBTs7P7NlfvtghpH2S5zcMGRcE8DTTAmk
         Ezb/DWnsvOWneJHZBC0vGzeVi0ioqxTa0ubZqDSFAhDN5QgDclyGtImMYyH7+dH2ojL8
         iRUfHpHpup3fLrSYvAKUuxyi8FGDYErGw/ql55FN2PfCbvPXDcBvC+WCnHNvQoXHNTjo
         6gkXWAFEXH24Q/QiyFHf1mIqj2QuPUhiFXghk4KIItAUvXhZ4TtYYjMs81ss7bdzSt51
         P/nkH0uic/Oo9qEy0JctVUTuDSa7AdgzSphX6WeM8CwC9xaQm+OJJBpOTwuI0Mkbd01j
         eJwQ==
X-Gm-Message-State: AOAM530eSxOJ/XN3jWV1afwu8mRpTBWzbyY+CGOHmaWGkwyW97RVA2W7
        3mWf6p4L38j+7OY63L630p6TG51krX6xZh+BmIGtVQ==
X-Google-Smtp-Source: ABdhPJxt0H9qvxctwMgumP81gl1sToJpHbkLWCeEixFUZALV+tbhIKUwd30QtVLlAuMi9sJCGWaKwaDRxDz3qXSrs5E=
X-Received: by 2002:a2e:9653:: with SMTP id z19mr7008470ljh.29.1637148085120;
 Wed, 17 Nov 2021 03:21:25 -0800 (PST)
MIME-Version: 1.0
References: <CAJpMwyjTggq-q8YQd7iPyp_TA29z5mWcEFAKe_Zg0=Z3a843qA@mail.gmail.com>
 <YZCo5BwbTgKtbImi@unreal>
In-Reply-To: <YZCo5BwbTgKtbImi@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 17 Nov 2021 12:21:14 +0100
Message-ID: <CAJpMwyhcoWf-19KdBeYb_V7asXBKB4dx9pQo7C5rFcCjDAdS5Q@mail.gmail.com>
Subject: Re: Task hung while using RTRS with rxe and using "ip" utility to
 down the interface
To:     Leon Romanovsky <leon@kernel.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 14, 2021 at 7:12 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Nov 11, 2021 at 05:25:11PM +0100, Haris Iqbal wrote:
> > Hi,
> >
> > We are experiencing a hang while using RTRS with softROCE and
> > transitioning the network interface down using ifdown command.
> >
> > Steps.
> > 1) Map an RNBD/RTRS device through softROCE port.
> > 2) Once mapped, transition the eth interface to down (on which the
> > softROCE interface was created) using command "ifconfig <ethx> down",
> > or "ip link set <ethx> down".
> > 3) The device errors out, and one can see RTRS connection errors in
> > dmesg. So far so good.
> > 4) After a while, we see task hung traces in dmesg.
> >
> > [  550.866462] INFO: task kworker/1:2:170 blocked for more than 184 seconds.
> > [  550.868820]       Tainted: G           O      5.10.42-pserver+ #84
> > [  550.869337] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  550.869963] task:kworker/1:2     state:D stack:    0 pid:  170
> > ppid:     2 flags:0x00004000
> > [  550.870619] Workqueue: rtrs_server_wq rtrs_srv_close_work [rtrs_server]
> > [  550.871134] Call Trace:
> > [  550.871375]  __schedule+0x421/0x810
> > [  550.871683]  schedule+0x46/0xb0
> > [  550.871964]  schedule_timeout+0x20e/0x2a0
> > [  550.872300]  ? internal_add_timer+0x44/0x70
> > [  550.872650]  wait_for_completion+0x86/0xe0
> > [  550.872994]  cm_destroy_id+0x18c/0x5a0 [ib_cm]
> > [  550.873357]  ? _cond_resched+0x15/0x30
> > [  550.873680]  ? wait_for_completion+0x33/0xe0
> > [  550.874036]  _destroy_id+0x57/0x210 [rdma_cm]
> > [  550.874395]  rtrs_srv_close_work+0xcc/0x250 [rtrs_server]
> > [  550.874819]  process_one_work+0x1d4/0x370
> > [  550.875156]  worker_thread+0x4a/0x3b0
> > [  550.875471]  ? process_one_work+0x370/0x370
> > [  550.875817]  kthread+0xfe/0x140
> > [  550.876098]  ? kthread_park+0x90/0x90
> > [  550.876453]  ret_from_fork+0x1f/0x30
> >
> >
> > Our observations till now.
> >
> > 1) Does not occur if we use "ifdown <ethx>" instead. There is a
> > difference between the commands, but we are not sure if the above one
> > should lead to a task hang.
> > https://access.redhat.com/solutions/27166
> > 2) We have verified v5.10 and v.15.1 kernels, and both have this issue.
> > 3) We tried the same test with NvmeOf target and host over softROCE.
> > We get the same task hang after doing "ifconfig .. down".
> >
> > [Tue Nov  9 14:28:51 2021] INFO: task kworker/1:1:34 blocked for more
> > than 184 seconds.
> > [Tue Nov  9 14:28:51 2021]       Tainted: G           O
> > 5.10.42-pserver+ #84
> > [Tue Nov  9 14:28:51 2021] "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [Tue Nov  9 14:28:51 2021] task:kworker/1:1     state:D stack:    0
> > pid:   34 ppid:     2 flags:0x00004000
> > [Tue Nov  9 14:28:51 2021] Workqueue: events
> > nvmet_rdma_release_queue_work [nvmet_rdma]
> > [Tue Nov  9 14:28:51 2021] Call Trace:
> > [Tue Nov  9 14:28:51 2021]  __schedule+0x421/0x810
> > [Tue Nov  9 14:28:51 2021]  schedule+0x46/0xb0
> > [Tue Nov  9 14:28:51 2021]  schedule_timeout+0x20e/0x2a0
> > [Tue Nov  9 14:28:51 2021]  ? internal_add_timer+0x44/0x70
> > [Tue Nov  9 14:28:51 2021]  wait_for_completion+0x86/0xe0
> > [Tue Nov  9 14:28:51 2021]  cm_destroy_id+0x18c/0x5a0 [ib_cm]
> > [Tue Nov  9 14:28:51 2021]  ? _cond_resched+0x15/0x30
> > [Tue Nov  9 14:28:51 2021]  ? wait_for_completion+0x33/0xe0
> > [Tue Nov  9 14:28:51 2021]  _destroy_id+0x57/0x210 [rdma_cm]
> > [Tue Nov  9 14:28:51 2021]  nvmet_rdma_free_queue+0x2e/0xc0 [nvmet_rdma]
> > [Tue Nov  9 14:28:51 2021]  nvmet_rdma_release_queue_work+0x19/0x50 [nvmet_rdma]
> > [Tue Nov  9 14:28:51 2021]  process_one_work+0x1d4/0x370
> > [Tue Nov  9 14:28:51 2021]  worker_thread+0x4a/0x3b0
> > [Tue Nov  9 14:28:51 2021]  ? process_one_work+0x370/0x370
> > [Tue Nov  9 14:28:51 2021]  kthread+0xfe/0x140
> > [Tue Nov  9 14:28:51 2021]  ? kthread_park+0x90/0x90
> > [Tue Nov  9 14:28:51 2021]  ret_from_fork+0x1f/0x30
> >
> > Is this an known issue with ifconfig or the rxe driver? Thoughts?
>
> It doesn't look related to RXE and if to judge by the call trace the
> issue is one of two: missing call to cm_deref_id() or extra call
> to refcount_inc(&cm_id_priv->refcount). Both can be related to the
> callers of rdma-cm interface. For example by not releasing cm_id
> properly.


Hi,

@Aleksei did some more investigation and found out the cause of the hang.

1. enabled traces for rdma_cma and ib_cma events.
2. When we call ifdown (the one that does not hung) the following
trace can be observed

kworker/1:2-100     [001] ....    98.191532: cm_disconnect: cm.id=2
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0
kworker/1:2-100     [001] dN..    98.208935: icm_send_drep_err:
local_id=3791663578 remote_id=2340456478 state=TIMEWAIT
lap_state=LAP_UNINIT
kworker/1:2-100     [001] .N..    98.213924: cm_disconnect: cm.id=3
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0
kworker/1:2-100     [001] dN..    98.218595: icm_send_drep_err:
local_id=3808440794 remote_id=2323679262 state=TIMEWAIT
lap_state=LAP_UNINIT
kworker/1:2-100     [001] .N..    98.219583: cm_disconnect: cm.id=4
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0
kworker/1:2-100     [001] dN..    98.228200: icm_send_drep_err:
local_id=3758109146 remote_id=2306902046 state=TIMEWAIT
lap_state=LAP_UNINIT
kworker/1:2-100     [001] ....    98.322883: cm_qp_destroy: cm.id=2
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0 qp_num=17
kworker/1:2-100     [001] ....    98.322913: cm_id_destroy: cm.id=2
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0
kworker/1:2-100     [001] ....    98.332065: cm_qp_destroy: cm.id=3
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0 qp_num=18
kworker/1:2-100     [001] ....    98.332115: cm_id_destroy: cm.id=3
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0
kworker/1:2-100     [001] ....    98.340362: cm_qp_destroy: cm.id=4
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0 qp_num=19
kworker/1:2-100     [001] ....    98.340400: cm_id_destroy: cm.id=4
src=10.154.0.1:1234 dst=10.154.0.3:53749 tos=0


Explanation:
In this example we have 3 cm.id (2,3,4) for each of them we call
rdma_disconnect() that calls ib_send_cm_dreq which calls
cm_send_dreq_locked
but there we call

ret = cm_alloc_msg(cm_id_priv, &msg);
if (ret) {
    cm_enter_timewait(cm_id_priv);
    return ret;
}

which returns with the error before doing
refcount_inc(&cm_id_priv->refcount); inside cm_alloc_msg. Since the
error returns from rdma_create_ah.
so the refcount for each cm.id is 1 after calling rdma_disconnect.
Hence in cm_destroy_id we call once more cm_deref_id and do NOT hung
on

wait_for_completion(&cm_id_priv->comp);

because refcount is 0.

3. In case of ifconfig down (the one that hung) the trace is following

kworker/1:0-19      [001] ....   289.211230: cm_disconnect: cm.id=5
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0
kworker/1:0-19      [001] d...   289.222918: icm_send_dreq:
local_id=3636223036 remote_id=2994969923 state=ESTABLISHED
lap_state=LAP_UNINIT
kworker/1:0-19      [001] .N..   289.224789: cm_sent_dreq: cm.id=5
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0
kworker/u5:0-63      [001] d...   289.224820: icm_mad_send_err:
state=DREQ_SENT completion status=LOC_PROT_ERR
kworker/u5:0-63      [001] ....   289.224821: cm_event_handler:
cm.id=5 src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0 DISCONNECTED
(10/-110)
kworker/u5:0-63      [001] ....   289.224822: cm_event_done: cm.id=5
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0 DISCONNECTED consumer
returns 0
kworker/1:0-19      [001] .N..   289.226797: cm_disconnect: cm.id=6
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0
kworker/1:0-19      [001] dN..   289.238556: icm_send_dreq:
local_id=3619445820 remote_id=3045301571 state=ESTABLISHED
lap_state=LAP_UNINIT
kworker/1:0-19      [001] .N..   289.240126: cm_sent_dreq: cm.id=6
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0
kworker/1:0-19      [001] .N..   289.241162: cm_disconnect: cm.id=7
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0
kworker/1:0-19      [001] dN..   289.251148: icm_send_dreq:
local_id=3602668604 remote_id=3028524355 state=ESTABLISHED
lap_state=LAP_UNINIT
kworker/1:0-19      [001] .N..   289.252624: cm_sent_dreq: cm.id=7
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0
kworker/1:0-19      [001] ....   289.340055: cm_qp_destroy: cm.id=5
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0 qp_num=19
kworker/1:0-19      [001] ....   289.340159: cm_id_destroy: cm.id=5
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0
kworker/1:0-19      [001] ....   289.367393: cm_qp_destroy: cm.id=6
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0 qp_num=20
kworker/1:0-19      [001] ....   289.367445: cm_id_destroy: cm.id=6
src=10.154.0.1:1234 dst=10.154.0.3:60177 tos=0

Explanation:
In this example we have 3 cm.id (5,6,7). for each of them we call
rdma_disconnect() that calls ib_send_cm_dreq which calls
cm_send_dreq_locked which calls cm_alloc_msg but in this case
cm_alloc_msg does not return the error and increase the refcount for
each cm.id to 2. And we do send dreq.
But later only for cm.id=5 the send_handler is called with LOC_PROT_ERR

icm_mad_send_err: state=DREQ_SENT completion status=LOC_PROT_ERR

which triggers cm_process_send_error -> cm_free_msg -> cm_deref_id
which decrease the refcount for cm.id=5 to 1.


For other cm.id (6,7) the refcounts are 2 since the dreq were sent but
nor completed nor timed out. Nothing happens with those dreq sent to
cm.id=6,7
So later, when cm_id_destroy is called for cm.id=5 (refcount=1) we
call once more cm_deref_id and do not hung on

wait_for_completion(&cm_id_priv->comp);

because refcount is 0.
but for cm.i=6,7 we do cm_deref_id but refcount goes from 2 to 1 and
we wait_for_completion forever, because those sent dreqs are still
somewhere.

4. The reason why cm_alloc_msg in one case (ifdown "interface")
returns with an error without refcount increase and in other case
(ifconfig down "interface") increase refcount and return 0 is what
happens in cm_alloc_msg. ( gid entry state in ib_gid_table. )

Explanation:
The cm_alloc_msg calls the following functions:
cm_alloc_msg -> rdma_create_ah -> rdma_lag_get_ah_roce_slave ->
rdma_read_gid_attr_ndev_rcu -> is_gid_entry_valid
which

return entry && entry->state == GID_TABLE_ENTRY_VALID;

In case of ifdown entry is either NULL or in the state
GID_TABLE_ENTRY_PENDING_DEL so the function returns false. and
cm_alloc_msg fails without refcount increase.
In case of ifconfig down entry is in the state GID_TABLE_ENTRY_VALID
so the function returns true. and cm_alloc_msg increase the refcount
for cm.id.


We think one of the below questions is the problem,

1. why cm_process_send_error was triggered only for 1 of 3 sent dreq?
Why the cm_send_handler is not called for others?
2. When RTRS receives an error and starts closing the network, during
which rdma_disconnect is called, shouldnt cm_alloc_msg fail in such a
case?

the same behavior is observed for RTRS and for NVMEof targets.



>
> Thanks
>
> >
> > Regards
> > -Haris
