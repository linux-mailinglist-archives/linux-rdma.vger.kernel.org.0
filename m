Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791CE623E2F
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 10:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKJJBM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 04:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKJJBK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 04:01:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9661277A;
        Thu, 10 Nov 2022 01:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 781BEB82114;
        Thu, 10 Nov 2022 09:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934A9C433D6;
        Thu, 10 Nov 2022 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668070867;
        bh=bwZxApbwQPyWL7EgpzVCY+Xs2569ep+Xi+vB0ETIhfk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QRrFKiT/k3M0g+nWZO9OjFbF9w+58XL02K8VB5cXkT01H/s1S98P+GnrS8wM7fc1Z
         RmBlSuS1pp7js5YenQuDQNCBMwueH97q4LDwE9Jbr9N253a/avTAJdgW2EbUjcYZyq
         htjCZMDtPnlPCuyiPPWO/xPFljQ8V4BYC/XEAHVHEm0qH2XGpwRh8bvcaF5a2fhrfr
         2fpswKxOvmQRSDycB0SfjjntCH/T37n4DziDu9Mr4PK37Ay23xYIkF5J44KPFQPSvD
         M4h0XJ8fid6MkaVU4d6JEOFA8dyb77oqKyqvLWWd+YBEh3CR0QUUfp4YRtSHdeXjAf
         +9Di5HDwT+gkQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Leonid Ravich <lravich@gmail.com>, mhiramat@kernel.org,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <Y2t5feomyznrVj7V@leonid-Inspiron-3421>
References: <Y2t5feomyznrVj7V@leonid-Inspiron-3421>
Subject: Re: [PATCH] IB/MAD: fix might sleep in atomic
Message-Id: <166807086256.536401.9653051259980801150.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 11:01:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 9 Nov 2022 11:57:17 +0200, Leonid Ravich wrote:
> Sleep in TR_assign not allowd
> 
> WARNING: CPU: 0 PID: 1888000 at kernel/trace/ring_buffer.c:2492 rb_commit+0xc1/0x220
> CPU: 0 PID: 1888000 Comm: kworker/u9:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.3.1.el8.x86_64 #1
> l: Hardware name: Red Hat KVM, BIOS 1.13.0-2.module_el8.3.0+555+a55c8938 04/01/2014
> l: Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
> l: RIP: 0010:rb_commit+0xc1/0x220
> l: RSP: 0000:ffffa8ac80f9bca0 EFLAGS: 00010202
> l: RAX: ffff8951c7c01300 RBX: ffff8951c7c14a00 RCX: 0000000000000246
> l: RDX: ffff8951c707c000 RSI: ffff8951c707c57c RDI: ffff8951c7c14a00
> l: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> l: R10: ffff8951c7c01300 R11: 0000000000000001 R12: 0000000000000246
> l: R13: 0000000000000000 R14: ffffffff964c70c0 R15: 0000000000000000
> l: FS:  0000000000000000(0000) GS:ffff8951fbc00000(0000) knlGS:0000000000000000
> l: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> l: CR2: 00007f20e8f39010 CR3: 000000002ca10005 CR4: 0000000000170ef0
> l: Call Trace:
> l:  ring_buffer_unlock_commit+0x1d/0xa0
> l:  trace_buffer_unlock_commit_regs+0x3b/0x1b0
> l:  trace_event_buffer_commit+0x67/0x1d0
> l:  trace_event_raw_event_ib_mad_recv_done_handler+0x11c/0x160 [ib_core]
> l:  ib_mad_recv_done+0x48b/0xc10 [ib_core]
> l:  ? trace_event_raw_event_cq_poll+0x6f/0xb0 [ib_core]
> l:  __ib_process_cq+0x91/0x1c0 [ib_core]
> l:  ib_cq_poll_work+0x26/0x80 [ib_core]
> l:  process_one_work+0x1a7/0x360
> l:  ? create_worker+0x1a0/0x1a0
> l:  worker_thread+0x30/0x390
> l:  ? create_worker+0x1a0/0x1a0
> l:  kthread+0x116/0x130
> l:  ? kthread_flush_work_fn+0x10/0x10
> l:  ret_from_fork+0x35/0x40
> l: ---[ end trace 78ba8509d3830a16 ]---
> 
> [...]

Applied, thanks!

[1/1] IB/MAD: fix might sleep in atomic
      https://git.kernel.org/rdma/rdma/c/5c20311d76cbae

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
