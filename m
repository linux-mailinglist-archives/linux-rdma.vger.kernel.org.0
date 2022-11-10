Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B5623E2C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 10:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKJJAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 04:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKJJAv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 04:00:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131D263F;
        Thu, 10 Nov 2022 01:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9FC4B82113;
        Thu, 10 Nov 2022 09:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E458C433C1;
        Thu, 10 Nov 2022 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668070848;
        bh=lmAo6D7yt1n6CLC/D6badZUNXJiAPTTAowMvYzfQBmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGnMq7rJ4QsbZAVAt4yPhSm0t19/XSlUN2OLt0DpEcCWtRpkpU8NykfsT9CIjD8ta
         zjmUcg32ft/aNwnrT/uLw0nyYpiKP/Vg5gKzGkg1qvgNED7KfV+6AGm0XHRKMx9Vak
         UYKrUswogO5E4M1PdrjUZMFm/Ph1akIioJjmebXCvdikbT8PYhc9BfUKr36QLP4p7K
         /zkyvu9z8zJGhvwpCh3PDSZB/NIJXifqabknd0QBtQ3/RjMAH9ULE7xGnUK7rZGz06
         DUYc+Xim3jqEkqksgv7OeniDM1JupLg8mDxgWDfVl14zbOfKg+CHVJOM35SDew3BZ9
         U3/DGtU8w2VPw==
Date:   Thu, 10 Nov 2022 11:00:43 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Leonid Ravich <lravich@gmail.com>
Cc:     jgg@ziepe.ca, mhiramat@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/MAD: fix might sleep in atomic
Message-ID: <Y2y9u7Lz7bxYUOqJ@unreal>
References: <Y2t5feomyznrVj7V@leonid-Inspiron-3421>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2t5feomyznrVj7V@leonid-Inspiron-3421>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 09, 2022 at 11:57:17AM +0200, Leonid Ravich wrote:
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
> Signed-off-by: Leonid Ravich <lravich@gmail.com>
> ---
>  drivers/infiniband/core/mad.c |  3 ---
>  include/trace/events/ib_mad.h | 13 ++++---------
>  2 files changed, 4 insertions(+), 12 deletions(-)

make[4]: *** [scripts/Makefile.build:250: drivers/infiniband/core/mad.o] Error 1
drivers/infiniband/core/mad.c:62:20: error: unused variable 'dev' [-Werror,-Wunused-variable]
        struct ib_device *dev = qp_info->port_priv->device;
                          ^
drivers/infiniband/core/mad.c:63:6: error: unused variable 'pnum' [-Werror,-Wunused-variable]
        u32 pnum = qp_info->port_priv->port_num;
            ^
2 errors generated.

I fixed it together with commit message and applied.

Thanks
