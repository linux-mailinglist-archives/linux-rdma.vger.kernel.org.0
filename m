Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5A781D3A
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Aug 2023 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjHTJrB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Aug 2023 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjHTJq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Aug 2023 05:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2CE4E
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 02:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C498160BBD
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 09:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2959C433C8;
        Sun, 20 Aug 2023 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692524644;
        bh=FkZj774J/jB/Rq3XlpiRlivOQUdaSatCoRawqI0EgVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWSx6nFhQe7XbqAZj+dc5oC3Zwn0kW76ayZKOwRzEElGzpqEQgcRfemN0tTSF3lMd
         p6PzUzkOWTm+m3V4Q5qFaZ8T9ocZQcqpvewVNOqbjspors6vw9jmZzfcSt2DhD6AC5
         TbCf7P7Ecjntnv0a5GlCLdD503ebqN3WeGbxgiMgEf7c96OgKRz2Fa79aquZKOFf7j
         auxYujZi7oWhFT/CSRH9GtiE+3Ei4GB/fvJW4vYa3p3UY4EP/AVr40CTqL2hfGLW1M
         pbXgYi2iYX3Bd1eUGTlMcj00YHJzsK/+uY3xoPqmmCmmKyRU6t+M7YqXL+PMtpDP0H
         0ps2hUjaWtq4A==
Date:   Sun, 20 Aug 2023 12:43:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     bmt@zurich.ibm.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] Misc changes for siw
Message-ID: <20230820094359.GC1562474@unreal>
References: <20230818082318.17489-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818082318.17489-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 18, 2023 at 04:23:15PM +0800, Guoqing Jiang wrote:
> Hi,
> 
> The first one fix below calltrace which could happen if siw_connect
> goto error (I manually set rv to -1 after siw_send_mpareqrep to trigger
> it) after cep is allocated.
> 
> [   97.341035] ------------[ cut here ]------------
> [   97.341037] WARNING: CPU: 0 PID: 143 at drivers/infiniband/sw/siw/siw_cm.c:444 siw_cep_put+0x1c5/0x1e0 [siw]
> ...
> [   97.341126] CPU: 0 PID: 143 Comm: kworker/u4:4 Tainted: G           OE      6.5.0-rc3+ #16
> [   97.341128] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
> [   97.341130] Workqueue: rdma_cm cma_work_handler [rdma_cm]
> [   97.341137] RIP: 0010:siw_cep_put+0x1c5/0x1e0 [siw]
> ...
> [   97.341159] Call Trace:
> [   97.341160]  <TASK>
> [   97.341162]  ? show_regs+0x72/0x90
> [   97.341166]  ? siw_cep_put+0x1c5/0x1e0 [siw]
> [   97.341170]  ? __warn+0x8d/0x1a0
> [   97.341175]  ? siw_cep_put+0x1c5/0x1e0 [siw]
> [   97.341180]  ? report_bug+0x1f9/0x250
> [   97.341185]  ? handle_bug+0x46/0x90
> [   97.341188]  ? exc_invalid_op+0x19/0x80
> [   97.341190]  ? asm_exc_invalid_op+0x1b/0x20
> [   97.341196]  ? siw_cep_put+0x1c5/0x1e0 [siw]
> [   97.341204]  siw_connect+0x474/0x780 [siw]
> [   97.341211]  iw_cm_connect+0x1ca/0x250 [iw_cm]
> [   97.341216]  rdma_connect_locked+0x1bf/0x940 [rdma_cm]
> [   97.341227]  nvme_rdma_cm_handler+0x5d7/0x9c0 [nvme_rdma]
> [   97.341235]  cma_cm_event_handler+0x4f/0x170 [rdma_cm]
> [   97.341241]  cma_work_handler+0x6a/0xe0 [rdma_cm]
> [   97.341247]  process_one_work+0x2bd/0x590
> ...
> 
> The second one make the debug message consistent with the condition,
> and the last one cleanup code a bit. Pls help to review them.
> 
> Thanks,
> Guoqing
> 
> Guoqing Jiang (3):
>   RDMA/siw: Balance the reference of cep->kref in the error path
>   RDMA/siw: Correct wrong debug message
>   RDMA/siw: Call llist_reverse_order in siw_run_sq

All of these patches need to be with Fixes lines.

Thanks

> 
>  drivers/infiniband/sw/siw/siw_cm.c    |  1 -
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +-----------
>  drivers/infiniband/sw/siw/siw_verbs.c |  2 +-
>  3 files changed, 2 insertions(+), 13 deletions(-)
> 
> -- 
> 2.35.3
> 
