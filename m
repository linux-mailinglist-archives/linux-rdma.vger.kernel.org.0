Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F385F1D6DEF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 00:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgEQW5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 18:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgEQW5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 18:57:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FA3C061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:57:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c24so6678410qtw.7
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NfKJvdcpbojykgSWjQaTs1OulvP31aE/ip/4Uss/Cs=;
        b=CV/ecqyk1Ql5cFQpeHaSM8d2bh9DAD29FZiypUnO+CUDXMGWyMOFwSpck2rqGt5GnB
         5W4pmNb2Mt6mpH9loFHKejlU9PQz+mqS3tpAg2RSqrXJHFqSpAjU4knllENvtcD8L2h3
         gjVFFsM1v/3STL1/kIh+rnlXYnKGv3j7ULjFuljAlPdYdBE0gY5kIZu+HMT90ZGD+zOS
         QD2aBGSbN1r3A8cavWos6uNlcTATjK0u8Il0ObQDvvSkkFS3FTdy1mFL2cVYW3R6DUI7
         NtfvU8c3ePgi70Nwj8ml0CPo0YJpKfvmwudf5ZsX5jVlXP8xMSxE6lWX75XpPdKj2skd
         Q6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NfKJvdcpbojykgSWjQaTs1OulvP31aE/ip/4Uss/Cs=;
        b=Tn/lW0uwI1Fs+u2WO3qVpTImzh9EEzP4Gew4UP0zCHmctI4cv1vOBlevUF7wXifoAf
         GiaypXKOCQtvUcRISsdvoWy7AYvKXKyV4PNl2koH0qjnwy5VO0+Hp5DdFByycs1utBf/
         hGWcdI8ltmEpTH8n6wtnKD+8S8f2bon6xGA1l6noHNScwbI/amfyEFuBpNWd1d+CkDRj
         TUeM6B7xv8cOwSKN/QZ8hfh/n5f+LvNjFoQ6oAdT0BwRCvDgHflMibjy3ySryiLZ0VqV
         Mf5lJIHw5Aal+lrB0CGiWemLOXI5STQVKHhVG1TMo//OdCUw/ihBjIp/9Ipa9UdkQuty
         +WXg==
X-Gm-Message-State: AOAM5329eaA7zmswHIMmQZ2Qs78uu88wFMKNC+3m28shcPKv7uR1v/F7
        mWFKYSwo9JVynP4witP4QoDfHw==
X-Google-Smtp-Source: ABdhPJwdM6E/bY/Dv2cimFVLwZrgxPsjnoVgtL7W2nz/aaNStPiZkb+doVRyJeqHtVVNk4FP8A02UA==
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr13560205qtk.192.1589756268414;
        Sun, 17 May 2020 15:57:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z50sm8234084qta.18.2020.05.17.15.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 15:57:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSE7-0008EK-DE; Sun, 17 May 2020 19:57:47 -0300
Date:   Sun, 17 May 2020 19:57:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 06/10] IB/uverbs: Move QP, SRQ, WQ type and
 flags to UAPI
Message-ID: <20200517225747.GA31510@ziepe.ca>
References: <20200506082444.14502-1-leon@kernel.org>
 <20200506082444.14502-7-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506082444.14502-7-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 11:24:40AM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> These constants are going to be used in the ioctl interface in coming
> patches so they are part of the UAPI, place them in the correct header
> for clarity.
> 
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  include/rdma/ib_verbs.h                 | 43 ++++++++++++++-----------
>  include/uapi/rdma/ib_user_ioctl_verbs.h | 34 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index b8b5b5310529..9cf2d9d05c06 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -1012,9 +1012,9 @@ enum ib_cq_notify_flags {
>  };
>  
>  enum ib_srq_type {
> -	IB_SRQT_BASIC,
> -	IB_SRQT_XRC,
> -	IB_SRQT_TM,
> +	IB_SRQT_BASIC = IB_UVERBS_SRQT_BASIC,
> +	IB_SRQT_XRC = IB_UVERBS_SRQT_XRC,
> +	IB_SRQT_TM = IB_UVERBS_SRQT_TM,
>  };
>  
>  static inline bool ib_srq_has_cq(enum ib_srq_type srq_type)
> @@ -1083,16 +1083,16 @@ enum ib_qp_type {
>  	IB_QPT_SMI,
>  	IB_QPT_GSI,
>  
> -	IB_QPT_RC,
> -	IB_QPT_UC,
> -	IB_QPT_UD,
> +	IB_QPT_RC = IB_UVERBS_QPT_RC,
> +	IB_QPT_UC = IB_UVERBS_QPT_UC,
> +	IB_QPT_UD = IB_UVERBS_QPT_UD,
>  	IB_QPT_RAW_IPV6,
>  	IB_QPT_RAW_ETHERTYPE,
> -	IB_QPT_RAW_PACKET = 8,
> -	IB_QPT_XRC_INI = 9,
> -	IB_QPT_XRC_TGT,
> +	IB_QPT_RAW_PACKET = IB_UVERBS_QPT_RAW_PACKET,
> +	IB_QPT_XRC_INI = IB_UVERBS_QPT_XRC_INI,
> +	IB_QPT_XRC_TGT = IB_UVERBS_QPT_XRC_TGT,
>  	IB_QPT_MAX,
> -	IB_QPT_DRIVER = 0xFF,
> +	IB_QPT_DRIVER = IB_UVERBS_QPT_DRIVER,
>  	/* Reserve a range for qp types internal to the low level driver.
>  	 * These qp types will not be visible at the IB core layer, so the
>  	 * IB_QPT_MAX usages should not be affected in the core layer
> @@ -1111,17 +1111,21 @@ enum ib_qp_type {
>  
>  enum ib_qp_create_flags {
>  	IB_QP_CREATE_IPOIB_UD_LSO		= 1 << 0,
> -	IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK	= 1 << 1,
> +	IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK	=
> +		IB_UVERBS_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
>  	IB_QP_CREATE_CROSS_CHANNEL              = 1 << 2,
>  	IB_QP_CREATE_MANAGED_SEND               = 1 << 3,
>  	IB_QP_CREATE_MANAGED_RECV               = 1 << 4,
>  	IB_QP_CREATE_NETIF_QP			= 1 << 5,
>  	IB_QP_CREATE_INTEGRITY_EN		= 1 << 6,
>  	/* FREE					= 1 << 7, */
> -	IB_QP_CREATE_SCATTER_FCS		= 1 << 8,
> -	IB_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
> +	IB_QP_CREATE_SCATTER_FCS		=
> +		IB_UVERBS_QP_CREATE_SCATTER_FCS,
> +	IB_QP_CREATE_CVLAN_STRIPPING		=
> +		IB_UVERBS_QP_CREATE_CVLAN_STRIPPING,
>  	IB_QP_CREATE_SOURCE_QPN			= 1 << 10,
> -	IB_QP_CREATE_PCI_WRITE_END_PADDING	= 1 << 11,
> +	IB_QP_CREATE_PCI_WRITE_END_PADDING	=
> +		IB_UVERBS_QP_CREATE_PCI_WRITE_END_PADDING,
>  	/* reserve bits 26-31 for low level drivers' internal use */
>  	IB_QP_CREATE_RESERVED_START		= 1 << 26,
>  	IB_QP_CREATE_RESERVED_END		= 1 << 31,
> @@ -1626,7 +1630,7 @@ enum ib_raw_packet_caps {
>  };
>  
>  enum ib_wq_type {
> -	IB_WQT_RQ
> +	IB_WQT_RQ = IB_UVERBS_WQT_RQ,
>  };
>  
>  enum ib_wq_state {
> @@ -1649,10 +1653,11 @@ struct ib_wq {
>  };
>  
>  enum ib_wq_flags {
> -	IB_WQ_FLAGS_CVLAN_STRIPPING	= 1 << 0,
> -	IB_WQ_FLAGS_SCATTER_FCS		= 1 << 1,
> -	IB_WQ_FLAGS_DELAY_DROP		= 1 << 2,
> -	IB_WQ_FLAGS_PCI_WRITE_END_PADDING = 1 << 3,
> +	IB_WQ_FLAGS_CVLAN_STRIPPING	= IB_UVERBS_WQ_FLAGS_CVLAN_STRIPPING,
> +	IB_WQ_FLAGS_SCATTER_FCS		= IB_UVERBS_WQ_FLAGS_SCATTER_FCS,
> +	IB_WQ_FLAGS_DELAY_DROP		= IB_UVERBS_WQ_FLAGS_DELAY_DROP,
> +	IB_WQ_FLAGS_PCI_WRITE_END_PADDING =
> +				IB_UVERBS_WQ_FLAGS_PCI_WRITE_END_PADDING,

For flags that are not used by kernel ULPs, like these, it makes more
sense to have the driver refer to the IB_UVERBS_* constant and remove
this stuff from the ULP facing header. Probably as individual patches

Same above from the create flags I suppose

Jason
