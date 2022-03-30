Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA74EBF9E
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbiC3LOc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiC3LOb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 07:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160789A984
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 04:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A43BE6150C
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 11:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BACFC340EC;
        Wed, 30 Mar 2022 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648638766;
        bh=JQcYe/iTdNLm+Y1jeWIF2xswuf8/iAWxhTxUAfA3ULg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3JWXjLhySNivIakKkW1nw5g3hZKG/Ws/x0RpQF14UBoeCUUdL0OaF5fsdWahUunE
         nhWbtmpjLM4HhBfYhglaY9SqbaPPPOgniFDMey+PAhS0IFrtg/yC9uypineTDfH4yu
         HYHEjYvp5et/xOgIb5iUK+pruQ53a4+J6HkceEk5OAgLpaWm0CThVbsVk0x0G+69hl
         Hp16S4+6BgjFD7dVXaBMuyqf8mrH0B5V/E3Z1O/hSUdw63Zsm78Oow+RaSOqaqWbpr
         D6HBLm/1xEC2nkRNubmfQry/2v2d/5Z+HH3KrujhW5fCuhKn3uVlLkxgOlKuIehTIV
         YDk8vQitZq2Cg==
Date:   Wed, 30 Mar 2022 14:12:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Subject: Re: [PATCH v3 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Message-ID: <YkQ7KnGtLvKmeID+@unreal>
References: <20220328154511.305319-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328154511.305319-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 28, 2022 at 11:45:10PM +0800, Xiao Yang wrote:
> This enum is used by ibv_query_device_ex(3) so it should be defined
> in include/uapi/rdma/ib_user_verbs.h.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  include/rdma/ib_verbs.h           | 19 ++++++++++++-------
>  include/uapi/rdma/ib_user_verbs.h |  7 +++++++
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 69d883f7fb41..e3ed65920558 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1620,20 +1620,25 @@ struct ib_srq {
>  	struct rdma_restrack_entry res;
>  };
>  
> +/* This enum is shared with userspace */

This comment is not correct, because you are not using these values
directly in userspace. Your new ib_uverbs_raw_packet_caps is shared
and located in uapi folder.

>  enum ib_raw_packet_caps {
> -	/* Strip cvlan from incoming packet and report it in the matching work
> +	/*
> +	 * Strip cvlan from incoming packet and report it in the matching work
>  	 * completion is supported.
>  	 */
> -	IB_RAW_PACKET_CAP_CVLAN_STRIPPING	= (1 << 0),
> -	/* Scatter FCS field of an incoming packet to host memory is supported.
> +	IB_RAW_PACKET_CAP_CVLAN_STRIPPING =
> +		IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING,
> +	/*
> +	 * Scatter FCS field of an incoming packet to host memory is supported.
>  	 */
> -	IB_RAW_PACKET_CAP_SCATTER_FCS		= (1 << 1),
> +	IB_RAW_PACKET_CAP_SCATTER_FCS = IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS,
>  	/* Checksum offloads are supported (for both send and receive). */
> -	IB_RAW_PACKET_CAP_IP_CSUM		= (1 << 2),
> -	/* When a packet is received for an RQ with no receive WQEs, the
> +	IB_RAW_PACKET_CAP_IP_CSUM = IB_UVERBS_RAW_PACKET_CAP_IP_CSUM,
> +	/*
> +	 * When a packet is received for an RQ with no receive WQEs, the
>  	 * packet processing is delayed.
>  	 */
> -	IB_RAW_PACKET_CAP_DELAY_DROP		= (1 << 3),
> +	IB_RAW_PACKET_CAP_DELAY_DROP = IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP,
>  };
>  
>  enum ib_wq_type {
> diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
> index 7ee73a0652f1..ff549695f1ba 100644
> --- a/include/uapi/rdma/ib_user_verbs.h
> +++ b/include/uapi/rdma/ib_user_verbs.h
> @@ -1298,4 +1298,11 @@ struct ib_uverbs_ex_modify_cq {
>  
>  #define IB_DEVICE_NAME_MAX 64
>  
> +enum ib_uverbs_raw_packet_caps {
> +	IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING = 1 << 0,
> +	IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS = 1 << 1,
> +	IB_UVERBS_RAW_PACKET_CAP_IP_CSUM = 1 << 2,
> +	IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP = 1 << 3,
> +};
> +
>  #endif /* IB_USER_VERBS_H */
> -- 
> 2.34.1
> 
> 
> 
