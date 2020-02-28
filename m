Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E80173BB8
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgB1PlB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 10:41:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45416 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgB1PlA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 10:41:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id y3so1782626qtv.12
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 07:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rGwQ0yy9HpT+b9+whE+HPTAEvWg9+eVnNUsSlRPPiNI=;
        b=NcTFVqZJgsZ3avBK/mGaQp3lbFGWjGIfRTraK0MbyUfCXUbMferCh6YAHbep0cxnKA
         Pmn8OIuP8Kd0ib1kb6a+ca4p23dh4dFOZOg+HphGytkF8WI2raIViz/4aIxWct2unriz
         uzC10rjSPluKDI32nvrV6IuloEWmjacrT42QVKB3Uuz6xgdsQexnO+sfTKzghniTu12q
         DyLKnxqvvAu/tpbetUclrFM9wZjV2uNlVRiKXlhttZbLZ7EbSrUmMsVCuCIKVrtYJ439
         1laDBOnd/SeNXGqQXm/AbkZVFXXXKQuSMpiCMb6ICSWVNFLo3vcrdX6EC1MXv2si585x
         Q49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rGwQ0yy9HpT+b9+whE+HPTAEvWg9+eVnNUsSlRPPiNI=;
        b=MDrFV414XaondXuZxNsGyQHab8jx///LtWrjs6teIFqii1fD5JQ2n+F8Ekrrrr8bF1
         FCT3yLwOtxEatumAeuwuGHrKqm90SDB3UZh6RxItYMB5idroh+EWza6d8BYALErT2aOV
         6xreixyY4h7YbhOUtj6ueFsPH+aR0Z6T+l578eUfmUmj+fKRb4ojU2S/navFEW0C+Db8
         hnwP0+X7PsdyH+DO9xUJHocHsqH2/tqg1b4jI4WzI2zEta3/I69ytmc128118F3AZhZi
         PVQLN2f3V/UGAeDgdVrTDMdtpaQUJ/FFXZInyPVevBP0U7u5RQ+kGhM6aQug7wf33Q55
         ukSA==
X-Gm-Message-State: APjAAAXHAwLrODcZdvXnPiCHLsx1vAfcwwL7MWitFbFEoC8P3CeXR+Zb
        lhf7mlPaPlTHu32Y40LMxBG5qQ==
X-Google-Smtp-Source: APXvYqx/AeaO0eChzNi0L0DLLNaItM7A/VQMXxYfUc+JfhYonS91Kc3NREDBMFVCk/SwAg6O4A2g7Q==
X-Received: by 2002:aed:35d4:: with SMTP id d20mr4796436qte.181.1582904458496;
        Fri, 28 Feb 2020 07:40:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o10sm5174199qtp.38.2020.02.28.07.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 07:40:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7hl3-0002BL-HB; Fri, 28 Feb 2020 11:40:57 -0400
Date:   Fri, 28 Feb 2020 11:40:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        "Sindhu, Devale" <sindhu.devale@intel.com>,
        Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH rdma-next] i40iw: Report correct firmware version
Message-ID: <20200228154057.GA8304@ziepe.ca>
References: <20200225004918.890-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225004918.890-1-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 06:49:18PM -0600, Shiraz Saleem wrote:
> +/**
> + * i40iw_get_rdma_features - get RDMA features
> + * @dev - sc device struct
> + */
> +enum i40iw_status_code i40iw_get_rdma_features(struct i40iw_sc_dev *dev)
> +{
> +	enum i40iw_status_code ret_code;
> +	struct i40iw_dma_mem feat_buf;
> +	u64 temp;
> +	u16 byte_idx, feat_type, feat_cnt;
> +
> +	ret_code = i40iw_allocate_dma_mem(dev->hw,
> +					  &feat_buf,
> +					  I40IW_FEATURE_BUF_SIZE,
> +					  I40IW_FEATURE_BUF_ALIGNMENT);
> +
> +	if (ret_code)
> +		return I40IW_ERR_NO_MEMORY;
> +
> +	ret_code = i40iw_sc_query_rdma_features(dev->cqp, &feat_buf, 0);
> +	if (!ret_code)
> +		ret_code = i40iw_sc_query_rdma_features_done(dev->cqp);
> +
> +	if (ret_code)
> +		goto exit;
> +
> +	get_64bit_val(feat_buf.va, 0, &temp);
> +	feat_cnt = (u16)RS_64(temp, I40IW_FEATURE_CNT);

Please don't include these casts, demotion to u16 is implicit.

> +++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
> @@ -370,6 +370,13 @@
>  #define I40IW_AEQE_VALID_SHIFT 63
>  #define I40IW_AEQE_VALID_MASK (1ULL << I40IW_AEQE_VALID_SHIFT)
>  
> +#define FW_MAJOR_VER(dev) \
> +	((u16)RS_64((dev)->feature_info[I40IW_FEATURE_FW_INFO], \
> +		    I40IW_FW_VER_MAJOR))
> +#define FW_MINOR_VER(dev) \
> +	((u16)RS_64((dev)->feature_info[I40IW_FEATURE_FW_INFO], \
> +		    I40IW_FW_VER_MINOR))

Use static inline for function like things.

> +
>  /* CQP SQ WQES */
>  #define I40IW_QP_TYPE_IWARP     1
>  #define I40IW_QP_TYPE_UDA       2
> @@ -403,7 +410,7 @@
>  #define I40IW_CQP_OP_MANAGE_ARP                 0x0f
>  #define I40IW_CQP_OP_MANAGE_VF_PBLE_BP          0x10
>  #define I40IW_CQP_OP_MANAGE_PUSH_PAGES          0x11
> -#define I40IW_CQP_OP_MANAGE_PE_TEAM             0x12
> +#define I40IW_CQP_OP_QUERY_RDMA_FEATURES	0x12
>  #define I40IW_CQP_OP_UPLOAD_CONTEXT             0x13
>  #define I40IW_CQP_OP_ALLOCATE_LOC_MAC_IP_TABLE_ENTRY 0x14
>  #define I40IW_CQP_OP_MANAGE_HMC_PM_FUNC_TABLE   0x15
> @@ -431,6 +438,24 @@
>  #define I40IW_CQP_OP_SHMC_PAGES_ALLOCATED       0x2b
>  #define I40IW_CQP_OP_SET_HMC_RESOURCE_PROFILE   0x2d
>  
> +#define I40IW_FEATURE_BUF_SIZE                  (8 * I40IW_MAX_FEATURES)
> +
> +#define I40IW_FW_VER_MINOR_SHIFT        0
> +#define I40IW_FW_VER_MINOR_MASK         \
> +	(0xffffULL << I40IW_FW_VER_MINOR_SHIFT)
> +
> +#define I40IW_FW_VER_MAJOR_SHIFT        16
> +#define I40IW_FW_VER_MAJOR_MASK	        \
> +	(0xffffULL << I40IW_FW_VER_MAJOR_SHIFT)
> +
> +#define I40IW_FEATURE_INFO_SHIFT        0
> +#define I40IW_FEATURE_INFO_MASK         \
> +	(0xffffULL << I40IW_FEATURE_INFO_SHIFT)
> +
> +#define I40IW_FEATURE_CNT_SHIFT         32
> +#define I40IW_FEATURE_CNT_MASK          \
> +	(0xffffULL << I40IW_FEATURE_CNT_SHIFT)

Can you make sure to use the generic GENMASK/etc in your new driver
please? See the recent EFA series for how this should look.

Jason
