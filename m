Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4042B0DA
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 02:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhJMAJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 20:09:46 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:44826 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbhJMAJa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 20:09:30 -0400
Received: by mail-pj1-f46.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so881724pjb.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 17:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CW4ac1qz2DdP4nMqXxrXSe1X1mW4KdP1sWPWdYt3htQ=;
        b=D8mZF1XLXAbGyovN4QgJDbE+mAgq4X4IEuiLI5oHhHYBs7dNAMILBOVJIe31BMDrkK
         EOQ0lBbI+QHMsLFB3AWJEFgYJIBaWsPG7og76yQUuldMz8Z8HDbTYDXn3I8o5cK88MI8
         rF5TIe8COyeYDZbBCBAt1LMi0WtjsQn11R9evOxhO5gv209VS5U0PdRInW3vseRxi4Ah
         1iSlBnPf1KJZoGyAu7o+zhDAuRV+hQWuS0LaclEBO8TpwxQcpSvvu6BaQQVTkgo5LLXz
         LvWjRhNlbVFue3Ib7IOo9FU0xiFFqy7hUd4oV08bHmqN6fr/MBfIReNN+hDJbg+AO+BW
         gFkw==
X-Gm-Message-State: AOAM530Li/8n5yOj6vs/2YfmZFobS0nUejYoIheNt4KbCXwHuhvkMFO9
        S7rSfio+RJuTrOBCrmyhZQU=
X-Google-Smtp-Source: ABdhPJzYZLEWlHWJCijPFH+cuI428SiiKLizH57PZhA72+lwycivzUmprzSRNmDAc8IucPKa7dm0Mw==
X-Received: by 2002:a17:90a:a60c:: with SMTP id c12mr9855424pjq.28.1634083644957;
        Tue, 12 Oct 2021 17:07:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8c1a:acb2:4eff:5d13])
        by smtp.gmail.com with ESMTPSA id y22sm3858294pjj.33.2021.10.12.17.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 17:07:24 -0700 (PDT)
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Kernel warning at drivers/infiniband/core/rw.c:349
Message-ID: <996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org>
Date:   Tue, 12 Oct 2021 17:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

If I run the SRP tests against the for-next branch of the RDMA git tree
then the following warning appears (commit 2a152512a155 ("RDMA/efa: CQ 
notifications")):

------------[ cut here ]------------
WARNING: CPU: 69 PID: 838 at drivers/infiniband/core/rw.c:349 
rdma_rw_ctx_init+0x63b/0x690 [ib_core]
CPU: 69 PID: 838 Comm: kworker/69:1H Tainted: G    E   5.15.0-rc4-dbg+ #2
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
RIP: 0010:rdma_rw_ctx_init+0x63b/0x690 [ib_core]
Code: 8b 45 10 49 8d 7e 48 49 89 46 40 e8 cf 32 ca e0 8b 45 18 49 8d 7e 
04 41 89 46 48 e8 df 30 ca e0 41 c6 46 04 00 e9 61 fe ff ff <0f> 0b 41 
bc fb ff ff ff e9 3e fe ff ff 48 8b 9d 70 ff ff ff 48 8d
RSP: 0018:ffff88810b867968 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000024 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffff888169ee9a40 RDI: ffff888169ee9a58
RBP: ffff88810b867a20 R08: ffffffffa081b01b R09: 0000000000000000
R10: ffffed1085d2e3f1 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888169ee9a58 R15: ffff888169ee9a40
FS:  0000000000000000(0000) GS:ffff88842e940000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4720169e88 CR3: 00000001895d9006 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
  srpt_alloc_rw_ctxs+0x2f2/0x560 [ib_srpt]
  srpt_get_desc_tbl.constprop.0+0x289/0x2e0 [ib_srpt]
  srpt_handle_cmd+0x17f/0x2b0 [ib_srpt]
  srpt_handle_new_iu+0x27e/0x520 [ib_srpt]
  srpt_recv_done+0x9b/0xd0 [ib_srpt]
  __ib_process_cq+0x121/0x3d0 [ib_core]
  ib_cq_poll_work+0x37/0xb0 [ib_core]
  process_one_work+0x585/0xae0
  worker_thread+0x2e7/0x700
  kthread+0x1f6/0x220
  ret_from_fork+0x1f/0x30
irq event stamp: 1255
hardirqs last  enabled at (1263): [<ffffffff811ab2c8>] 
__up_console_sem+0x58/0x60
hardirqs last disabled at (1270): [<ffffffff811ab2ad>] 
__up_console_sem+0x3d/0x60
softirqs last  enabled at (1290): [<ffffffff82200473>] 
__do_softirq+0x473/0x6ed
softirqs last disabled at (1279): [<ffffffff810e2152>] 
__irq_exit_rcu+0xf2/0x140
---[ end trace 81a8636fba7e1a77 ]---

Does this perhaps indicate a regression in the RDMA rw code?

Thanks,

Bart.
