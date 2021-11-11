Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9129444DA51
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Nov 2021 17:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhKKQ2N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Nov 2021 11:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhKKQ2N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Nov 2021 11:28:13 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F0C061766
        for <linux-rdma@vger.kernel.org>; Thu, 11 Nov 2021 08:25:23 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t11so12988507ljh.6
        for <linux-rdma@vger.kernel.org>; Thu, 11 Nov 2021 08:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M7smNyJOF/yPulcGrZwHJLuNjGCtvYvBxX8m2Xpwb6s=;
        b=L+r5Vy2tt1W/naU9m7aWd/5mYPWQWd39VHFIlyUZuF6EXFPeoeFnn1Ntksg6bJ69CM
         qjbvtjtYxuOhiBhe9NDYl5cQKvbPEV26UubXWCxv4sqTfNxOF23RCKEvg+fUk/OCYMPh
         eQjjhqBC0XSWMtzZezKEy0tk0uKPUSD1zUGQknzaa3sM3qHeG88SN3zlLKkKgvjZEfGB
         rRMKTn3zvCOn9Ia3Ao0TIZXVNF0HD2CQ70Xg39e+jt96Dhb8Vn4oMrpH3ukrKOIisVMP
         cVD9oWlRFaxGtdwzDS8YQricNHIIpDVRqtncgJrgxr2J6b/8xXrjk5yLIhcspS0T6KiQ
         ZVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M7smNyJOF/yPulcGrZwHJLuNjGCtvYvBxX8m2Xpwb6s=;
        b=16iAj7CSIWAIsIi1fTWDnBhXCchiNSDRQAHmzzLE+yoBOQiPa4sw1ElWmjeZHsikdE
         IbWTFY+5NMWwfyilYhLEH9jL/STbG263TcYXMWMnrPfrQIpGr8rPU5dI7Vv+sgT6RaQ7
         RJbxwAHuS/ZKO2JNnujUN4xIVcmmrw70CiBNijgOVFLvUdnW/pCV7MrOPiMkzhSmwxPZ
         0DxTJuYDacyA3yS/ulvkCo/1KvVbovqB3gUq818sWPw08CkG3oBOFQQ4jvYA9Z0z1wqW
         +sciCv2BFjzA7aHACcu77VTjEoOXgWO+RPRn8bTa3Mj5UYFXhj2dFgbjran4EKUrsYO4
         3uyg==
X-Gm-Message-State: AOAM530VfVtOftx/MmeIJoefT0yW3z5dq4AbqKDCHcFBgkLEQqpUp6/e
        sUicL16uvZNCyrmsSSk5avQebVXnXWdf0i2F1WFBciBColOeFw==
X-Google-Smtp-Source: ABdhPJzk8q/dMGkq/KsAjvVaprXSGTtkFWH/8etX0NQ0TIV1AwBtHOyrqPuqVeCSgzqWIp4P7sW2CYcZ93AWssvYhkw=
X-Received: by 2002:a05:651c:50c:: with SMTP id o12mr7506640ljp.88.1636647921868;
 Thu, 11 Nov 2021 08:25:21 -0800 (PST)
MIME-Version: 1.0
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 11 Nov 2021 17:25:11 +0100
Message-ID: <CAJpMwyjTggq-q8YQd7iPyp_TA29z5mWcEFAKe_Zg0=Z3a843qA@mail.gmail.com>
Subject: Task hung while using RTRS with rxe and using "ip" utility to down
 the interface
To:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

We are experiencing a hang while using RTRS with softROCE and
transitioning the network interface down using ifdown command.

Steps.
1) Map an RNBD/RTRS device through softROCE port.
2) Once mapped, transition the eth interface to down (on which the
softROCE interface was created) using command "ifconfig <ethx> down",
or "ip link set <ethx> down".
3) The device errors out, and one can see RTRS connection errors in
dmesg. So far so good.
4) After a while, we see task hung traces in dmesg.

[  550.866462] INFO: task kworker/1:2:170 blocked for more than 184 seconds.
[  550.868820]       Tainted: G           O      5.10.42-pserver+ #84
[  550.869337] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  550.869963] task:kworker/1:2     state:D stack:    0 pid:  170
ppid:     2 flags:0x00004000
[  550.870619] Workqueue: rtrs_server_wq rtrs_srv_close_work [rtrs_server]
[  550.871134] Call Trace:
[  550.871375]  __schedule+0x421/0x810
[  550.871683]  schedule+0x46/0xb0
[  550.871964]  schedule_timeout+0x20e/0x2a0
[  550.872300]  ? internal_add_timer+0x44/0x70
[  550.872650]  wait_for_completion+0x86/0xe0
[  550.872994]  cm_destroy_id+0x18c/0x5a0 [ib_cm]
[  550.873357]  ? _cond_resched+0x15/0x30
[  550.873680]  ? wait_for_completion+0x33/0xe0
[  550.874036]  _destroy_id+0x57/0x210 [rdma_cm]
[  550.874395]  rtrs_srv_close_work+0xcc/0x250 [rtrs_server]
[  550.874819]  process_one_work+0x1d4/0x370
[  550.875156]  worker_thread+0x4a/0x3b0
[  550.875471]  ? process_one_work+0x370/0x370
[  550.875817]  kthread+0xfe/0x140
[  550.876098]  ? kthread_park+0x90/0x90
[  550.876453]  ret_from_fork+0x1f/0x30


Our observations till now.

1) Does not occur if we use "ifdown <ethx>" instead. There is a
difference between the commands, but we are not sure if the above one
should lead to a task hang.
https://access.redhat.com/solutions/27166
2) We have verified v5.10 and v.15.1 kernels, and both have this issue.
3) We tried the same test with NvmeOf target and host over softROCE.
We get the same task hang after doing "ifconfig .. down".

[Tue Nov  9 14:28:51 2021] INFO: task kworker/1:1:34 blocked for more
than 184 seconds.
[Tue Nov  9 14:28:51 2021]       Tainted: G           O
5.10.42-pserver+ #84
[Tue Nov  9 14:28:51 2021] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Tue Nov  9 14:28:51 2021] task:kworker/1:1     state:D stack:    0
pid:   34 ppid:     2 flags:0x00004000
[Tue Nov  9 14:28:51 2021] Workqueue: events
nvmet_rdma_release_queue_work [nvmet_rdma]
[Tue Nov  9 14:28:51 2021] Call Trace:
[Tue Nov  9 14:28:51 2021]  __schedule+0x421/0x810
[Tue Nov  9 14:28:51 2021]  schedule+0x46/0xb0
[Tue Nov  9 14:28:51 2021]  schedule_timeout+0x20e/0x2a0
[Tue Nov  9 14:28:51 2021]  ? internal_add_timer+0x44/0x70
[Tue Nov  9 14:28:51 2021]  wait_for_completion+0x86/0xe0
[Tue Nov  9 14:28:51 2021]  cm_destroy_id+0x18c/0x5a0 [ib_cm]
[Tue Nov  9 14:28:51 2021]  ? _cond_resched+0x15/0x30
[Tue Nov  9 14:28:51 2021]  ? wait_for_completion+0x33/0xe0
[Tue Nov  9 14:28:51 2021]  _destroy_id+0x57/0x210 [rdma_cm]
[Tue Nov  9 14:28:51 2021]  nvmet_rdma_free_queue+0x2e/0xc0 [nvmet_rdma]
[Tue Nov  9 14:28:51 2021]  nvmet_rdma_release_queue_work+0x19/0x50 [nvmet_rdma]
[Tue Nov  9 14:28:51 2021]  process_one_work+0x1d4/0x370
[Tue Nov  9 14:28:51 2021]  worker_thread+0x4a/0x3b0
[Tue Nov  9 14:28:51 2021]  ? process_one_work+0x370/0x370
[Tue Nov  9 14:28:51 2021]  kthread+0xfe/0x140
[Tue Nov  9 14:28:51 2021]  ? kthread_park+0x90/0x90
[Tue Nov  9 14:28:51 2021]  ret_from_fork+0x1f/0x30

Is this an known issue with ifconfig or the rxe driver? Thoughts?

Regards
-Haris
