Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D061F747EA2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGEHyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEHyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 03:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF766E2;
        Wed,  5 Jul 2023 00:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D60961408;
        Wed,  5 Jul 2023 07:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3EC433C8;
        Wed,  5 Jul 2023 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688543647;
        bh=YWfxi/xZnE3bJaiOHq81mY4QNBuZCJ6nAJGjGfLnkhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4HXUcmVzNBi7NvgetIMhOEL+Cvbn6Dz90QrbEWiojEgZM1rVHFxLuNmcw3eTzHm2
         4P1VTVqZ/z37S/RHNVfolcI7c8GcHuFMmWJXmDX/6jD/Bd8McbppLMggZ3ixd4PsTp
         X1vuO5BN1O4Wy5QG6JPSDihiewPtEGHUZzxiL+8UIMgyQ4azrMY2LEvW0XMdsyfWQD
         vrn+5/WOO99AGX7Va3qYIJEAuQuR2dFxrzUwgzTyK4rRbAxazY5k4IBOfV7fNvy2bx
         hNvW3BSoJ/4JSkASK6kmGfVQ5QSsnbHru1MfpYoy0Do/MgIAI+bPHWDyLLMjazzqoI
         xGhiLo2Ja9utw==
Date:   Wed, 5 Jul 2023 10:54:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     lihongweizz <lihongweizz@inspur.com>
Cc:     sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/iser: Protect tasks cleanup in case iser connection
 was stopped
Message-ID: <20230705075403.GI6455@unreal>
References: <20230704005144.1172-1-lihongweizz@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704005144.1172-1-lihongweizz@inspur.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 08:51:44AM +0800, lihongweizz wrote:
> From: Rock Li <lihongweizz@inspur.com>
> 
> We met a crash issue as below:
> ...
>  #7 [ff61b991f6f63d10] page_fault at ffffffffab80111e
>     [exception RIP: iscsi_iser_cleanup_task+13]
>     RIP: ffffffffc046c04d RSP: ff61b991f6f63dc0 RFLAGS: 00010246
>     RAX: 0000000000000000 RBX: ff4bd0aalf7a5610 RCX: ff61b991f6f63dc8
>     RDX: ff61b991f6f63d68 RSI: ff61b991f6f63d58 RDI: ff4bd0aalf6cdc00
>     RBP: 0000000000000005 R8: 0000000000000073 R9: 0000000000000005
>     R10: 0000000000000000 R11: 00000ccde3e0f5c0 R12: ff4bd08c0e0631f8
>     R13: ff4bd0a95ffd3c78 R14: ff4bd0a95ffd3c78 R15: ff4bd0aalf6cdc00
>     ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
>  #8 [ff616991f6f63dc0] __iscsi_put_task at ffffffffc0bd3652 [libiscsi]
>  #9 [ff61b991f6f63e00] iscsi_put_task at ffffffffc0bd36e9 [libiscsi]
> ...
> 
> After analysing the vmcore, we find that the iser connection was already
> stopped before abort handler running. The iser_conn is already unbindded
> and released. So we add iser connection validation check inside cleanup
> task to fix this corner case.
> 
> Signed-off-by: Rock Li <lihongweizz@inspur.com>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index bb9aaff92ca3..35dfbf41fc40 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -366,7 +366,12 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
>  	struct iscsi_iser_task *iser_task = task->dd_data;
>  	struct iser_tx_desc *tx_desc = &iser_task->desc;
>  	struct iser_conn *iser_conn = task->conn->dd_data;
> -	struct iser_device *device = iser_conn->ib_conn.device;
> +	struct iser_device *device;
> +
> +	/* stop connection might happens before iser cleanup work */
> +	if (!iser_conn)
> +		return;

And what prevents from iser_conn being not valid here?
For example, in the flow:
1. Start iscsi_iser_cleanup_task
2. Get valid task->conn->dd_data
3. Pass this if (..) check
4. Context switch and release connection
5. iser_conn now points to released memory.

Thanks

> +	device = iser_conn->ib_conn.device;
>  
>  	/* DEVICE_REMOVAL event might have already released the device */
>  	if (!device)
> -- 
> 2.27.0
> 
