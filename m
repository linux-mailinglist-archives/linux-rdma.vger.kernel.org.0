Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5871C59B2EF
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiHUJfa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiHUJfa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 05:35:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2491403C
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 02:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADAF560DDA
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 09:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88729C433C1;
        Sun, 21 Aug 2022 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661074528;
        bh=Q6CduLaPV4V2ykEoxLGVPRA1I4p/MjrCdnxy7F7iiyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Db36EVDqVz4gnxiYxh7CwvXgWdAaN4oqMKiRB9K1OXK06/QKyMSX2pLiCAegJaoaV
         4YmmuZuMyA86RuYpjgJfvTSPAUeuh9nrshyKj3S+8O2PXpyaUlkkjAXt5OXe4N2fxA
         q70uOXc2uTvwiAgN5MR/d9B/z1kyJA8zKIGKoGlSV7PqLX3tTWypX7XeLgTNFN8tmY
         +2D1Wd6p9CObh0ra/V7uztNalueREq4haMe6ec7War6Z1y9ubIKDq5sNzTkyELmlND
         Fa23/X1ANFJKxRUtQS5vNszEM4tOyh/qS1mrbSjsxQVrangRsRW0vENfyHZ0qs64kx
         XQvYiPUWO7grg==
Date:   Sun, 21 Aug 2022 12:35:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michael Margolin <mrgolin@amazon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Support CQ receive entries with
 source GID
Message-ID: <YwH8WyQZZ/Bzk80h@unreal>
References: <20220818140449.414-1-mrgolin@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818140449.414-1-mrgolin@amazon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 18, 2022 at 05:04:49PM +0300, Michael Margolin wrote:
> Add a parameter for create CQ admin command to set source address on
> receive completion descriptors. Report capability for this feature
> through query device verb.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
> v1 -> v2:
> - Add check for CQE size request correctness in efa_create_cq() 
> 	(comment from Gal Pressman)
> - Use bitfields for bool struct members
> 	(comment from Leon Romanovsky and Jason Gunthorpe)
> 
>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h   |   6 +-
>  drivers/infiniband/hw/efa/efa_com_cmd.c           |   5 +-
>  drivers/infiniband/hw/efa/efa_com_cmd.h           |   3 +-
>  drivers/infiniband/hw/efa/efa_io_defs.h           | 289 ++++++++++++++++++
>  drivers/infiniband/hw/efa/efa_verbs.c             |  10 +-
>  include/uapi/rdma/efa-abi.h                       |   4 +-
>  6 files changed, 311 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/infiniband/hw/efa/efa_io_defs.h
> 
> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> index 0b0b93b529f3..d4b9226088bd 100644
> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> @@ -444,7 +444,10 @@ struct efa_admin_create_cq_cmd {
>  	/*
>  	 * 4:0 : cq_entry_size_words - size of CQ entry in
>  	 *    32-bit words, valid values: 4, 8.
> -	 * 7:5 : reserved7 - MBZ
> +	 * 5 : set_src_addr - If set, source address will be
> +	 *    filled on RX completions from unknown senders.
> +	 *    Requires 8 words CQ entry size.
> +	 * 7:6 : reserved7 - MBZ
>  	 */
>  	u8 cq_caps_2;
>  
> @@ -980,6 +983,7 @@ struct efa_admin_host_info {
>  #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
>  #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
>  #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
> +#define EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR_MASK           BIT(5)
>  
>  /* create_cq_resp */
>  #define EFA_ADMIN_CREATE_CQ_RESP_DB_VALID_MASK              BIT(0)
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
> index fb405da4e1db..8f8885e002ba 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
> @@ -168,7 +168,10 @@ int efa_com_create_cq(struct efa_com_dev *edev,
>  			EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED, 1);
>  		create_cmd.eqn = params->eqn;
>  	}
> -
> +	if (params->set_src_addr) {
> +		EFA_SET(&create_cmd.cq_caps_2,
> +			EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR, 1);
> +	}
>  	efa_com_set_dma_addr(params->dma_addr,
>  			     &create_cmd.cq_ba.mem_addr_high,
>  			     &create_cmd.cq_ba.mem_addr_low);
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
> index c33010bbf9e8..671a04d69fc2 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.h
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
> @@ -75,7 +75,8 @@ struct efa_com_create_cq_params {
>  	u16 uarn;
>  	u16 eqn;
>  	u8 entry_size_in_bytes;
> -	bool interrupt_mode_enabled;
> +	bool interrupt_mode_enabled : 1;
> +	bool set_src_addr : 1;

It should be u8 xxx : 1 and not bool ...
Fixes locally and applied.

Thanks
