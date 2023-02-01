Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282ED686378
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjBAKL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 05:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBAKLY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 05:11:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120BB30FA
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 02:11:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A93666174E
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 10:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF10C4339B;
        Wed,  1 Feb 2023 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675246283;
        bh=KjYIJPVPZ5W91flRIsAfLFA7GPCNnlsxa51MeheQe4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvR2PWsdAtY2m8O2WOX1/fnnssrG9ezzkZn5kthDzcm63bYX5DkHmTqPcwbi6fpEw
         oQTAbmx41/+pC2p4UW1n7ciFjvLoyd1y7DM2P5QQwZ55T+tHCBH6nvnHghMDBDpSZR
         OIFRBSJnsIZL6VPI1y114ZW0zolkxnwBhcDboxEfaM0Ury8gqJ15eORHcO5ZHlFqd0
         BsVPf2+QTfNNKUNfGCdUeSQUsUudFo4CdmAbEuNQNPWlDHSe5zfA10EB4CLWXkqSas
         zxHNbhL/KailVnQUCLAYvP1Ir21ymNiCSCM1FO/QubiKNuSZYKAWtnZ2vYNFa98ssQ
         dKdfkKyh3AouQ==
Date:   Wed, 1 Feb 2023 12:11:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Vogel <jack.vogel@oracle.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Move variable into switch case
Message-ID: <Y9o6xnalM+R4DE3D@unreal>
References: <20230201012823.105150-1-jack.vogel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201012823.105150-1-jack.vogel@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 31, 2023 at 05:28:23PM -0800, Jack Vogel wrote:
> Fix build warnings when CONFIG_INIT_STACK_ALL_ZERO is enabled.

Which warnings do you see? What is you compiler version?

The code is perfectly fine.

> 
> Signed-off-by: Jack Vogel <jack.vogel@oracle.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index ab246447520b..e3c639a0d920 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -272,8 +272,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
>  		}
>  
>  		switch (info->ae_id) {
> +		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED: {
>  			struct irdma_cm_node *cm_node;
> -		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED:
>  			cm_node = iwqp->cm_node;
>  			if (cm_node->accept_pend) {
>  				atomic_dec(&cm_node->listener->pend_accepts_cnt);
> @@ -281,7 +281,7 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
>  			}
>  			iwqp->rts_ae_rcvd = 1;
>  			wake_up_interruptible(&iwqp->waitq);
> -			break;
> +		} break;
>  		case IRDMA_AE_LLP_FIN_RECEIVED:
>  		case IRDMA_AE_RDMAP_ROE_BAD_LLP_CLOSE:
>  			if (qp->term_flags)
> -- 
> 2.39.1
> 
