Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3687C591FA4
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Aug 2022 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiHNLjC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Aug 2022 07:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHNLjC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Aug 2022 07:39:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA70523161
        for <linux-rdma@vger.kernel.org>; Sun, 14 Aug 2022 04:39:00 -0700 (PDT)
Message-ID: <36725261-998d-63c2-bc0e-115157acb061@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660477139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOUYc6ZqMNjFZLssorWfXhOvKN0s8/lhR1NwF5bg5aA=;
        b=XKnVF6ofxoYjOt/G+AVsiW2cw4k+0DK+bPdkJKA7KEH3Qre4rugj+s98WgSXEcCHuXiUXO
        Z4ijS0ezmCeHq8BHiT8N6UzgRQ1b2hWwRvGty5rFBQ377g11HZZGuoZAdiGvU1ece48eUO
        gWgywi2QW1KqyO+u63T05h7qSPQu52Q=
Date:   Sun, 14 Aug 2022 14:38:57 +0300
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Support CQ receive entries with source
 GID
Content-Language: en-US
To:     Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>
References: <20220809151636.788-1-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20220809151636.788-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/08/2022 18:16, Michael Margolin wrote:
> Add a parameter for create CQ admin command to set source address on
> receive completion descriptors. Report capability for this feature
> through query device verb.
>
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c         | 5 ++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
>  drivers/infiniband/hw/efa/efa_verbs.c           | 4 +++-
>  include/uapi/rdma/efa-abi.h                     | 4 +++-
>  5 files changed, 16 insertions(+), 4 deletions(-)
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

Don't you need to validate the CQE size requested by the user somewhere?
I assume you must use 32 bytes completions for this.
