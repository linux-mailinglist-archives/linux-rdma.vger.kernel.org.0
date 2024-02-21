Return-Path: <linux-rdma+bounces-1089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DCF85E1F6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 16:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798411F245A9
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5CF811E7;
	Wed, 21 Feb 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j8KJjF+c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47B80C0F
	for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530777; cv=none; b=DqkseXVqnsiO0KjlLzzifXOW7VLGBiaEMTxJTtKvkhvmHpU2cOT2BzDfE4jOHqDXjCgyEVHdQE4Ru6stXEccx6LpN9xS3LpDzT8AGqOcwkQqKYJsaxfkfS6Tm5Nyv465MzZOUevL0phu6rqZZmktyFNuWT6PfUHoESrg2L0blOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530777; c=relaxed/simple;
	bh=coBFWklfp35Z+JdM7euyFOYo+eFWVoqEv4dPHniFQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxPvjnyEdpnuntloUDQW+4JH0GR9+2SBiCFUySqPXKq3iJ5B7GgH13gPPrj9LBzc1kU+ZKxvoXECCHtoHpZYp+MoejLUKlUBYmuVu7883OI8bmjL1IUTpQFy4CIl8z8mKTEdtCTZvfgK/arfbjFqVCSxp6uMG0dTYcPTSu9zaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j8KJjF+c; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-429de32dad9so42254101cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 07:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708530769; x=1709135569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5xm/gfWVf+yQyyplDkQQ3yLQGTBRkbE8RnRBTOW/pY=;
        b=j8KJjF+cyFwMYxXIA+9ZHEzJEGxFjqBszvhz1tJSZGg6cFbCDY/DxhZJTdEPEt86Tt
         YJqZrTMGxOcJTNuZQG0kwsiduyU0xFQH5cafbVeX56qJHGwNrq0gCR51/J4cotIcPBzb
         28jDvYaJotlU7pRGvsWo5BodKQWrmtDI81JOXC4rgGYYL7Hu/BpXF1v98u/9bHVyXkMw
         ZRo3xUVr/mivagGlebnvSlXhqqaVsLpU7ACVt8BIE15DAwbkWXvr6i63EnzRNzW1Pwzu
         GDIjFrI0voaJgQRnnQcXCOiuT+QY+C4WePBAG2vo0BUDod1kZjzUQDJ6OzLXMx0aAQHV
         zdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530769; x=1709135569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5xm/gfWVf+yQyyplDkQQ3yLQGTBRkbE8RnRBTOW/pY=;
        b=mW0rjzqeJ+b5tqkBIjDaik957aKz1Us4ScZBZnTrqieMFkBeXOol2/7GmEG2rQMW1v
         uXO8D2b+ig1vHIxWbFKK4JfvcZzsB9FMwCmRT0Qp3rkqsSGRXgsoDCC7XNzDI7apNYey
         aTgLTz2DTZGDkR8F4YwNhfAK+iEAvmqYfcyHGocajwjTh9lRQDK3V2I0FmwZPAGkvrUL
         SBTTvXCWsKZ/iPVEUEXM5fPFbhH6iusrAJI7cZhU2752O94WK59JP7tpQegsIiUVmsd7
         Nel8Q12xv2Xjdp7biWUfYdb+U/wtm4Pp/Rm21fSRvXV8amYGX7wil/P6b1eDl4u9qWLl
         qE2g==
X-Forwarded-Encrypted: i=1; AJvYcCXd4TyoVwb84s8/MNTomsNNxDqpJKYhgXCn0IYHTeP5kFs4kIpsmIADIU7SogtN4TRcWptpOMOweHw3uHPOejQcHsUtCsKHpwFgqA==
X-Gm-Message-State: AOJu0YwR0dGn+aaqhkJSrOw9C1ouvAACmSM64SHB4J6p6hfxunIeKq/K
	SmNFyz+wCF5rLEgsWhVetM8ZwkDfqmxC2cy0xbMb0vVH0PwTBhG1yCqGHj67VkU=
X-Google-Smtp-Source: AGHT+IHEXM5Xk/tyhRt23EDIsII7eBZHRn5QmdQcw1RJCwwFXppN8d5gsDI2w/tJA5DLQBqG/XH8iA==
X-Received: by 2002:a05:622a:4c6:b0:42e:1812:cacf with SMTP id q6-20020a05622a04c600b0042e1812cacfmr7954234qtx.57.1708530769617;
        Wed, 21 Feb 2024 07:52:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id t13-20020a05622a180d00b0042d0995a040sm4461281qtc.62.2024.02.21.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:52:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcots-00BTYw-LI;
	Wed, 21 Feb 2024 11:52:48 -0400
Date: Wed, 21 Feb 2024 11:52:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next 2/2] RDMA/hns: Support userspace configuring
 congestion control algorithm with QP granularity
Message-ID: <20240221155248.GD13491@ziepe.ca>
References: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
 <20240208035038.94668-3-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208035038.94668-3-huangjunxian6@hisilicon.com>

On Thu, Feb 08, 2024 at 11:50:38AM +0800, Junxian Huang wrote:
> Support userspace configuring congestion control algorithm with
> QP granularity. If the algorithm is not specified in userspace,
> use the default one.
> 
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 23 +++++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 14 +---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
>  include/uapi/rdma/hns-abi.h                 | 17 +++++
>  6 files changed, 112 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index c88ba7e053bf..55f2f54e15fb 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -594,11 +594,19 @@ struct hns_roce_work {
>  	u32 queue_num;
>  };
>  
> -enum cong_type {
> -	CONG_TYPE_DCQCN,
> -	CONG_TYPE_LDCP,
> -	CONG_TYPE_HC3,
> -	CONG_TYPE_DIP,
> +enum hns_roce_scc_algo {
> +	HNS_ROCE_SCC_ALGO_DCQCN = 0,
> +	HNS_ROCE_SCC_ALGO_LDCP,
> +	HNS_ROCE_SCC_ALGO_HC3,
> +	HNS_ROCE_SCC_ALGO_DIP,
> +	HNS_ROCE_SCC_ALGO_TOTAL,
> +};
> +
> +enum hns_roce_cong_type {
> +	CONG_TYPE_DCQCN = 1 << HNS_ROCE_SCC_ALGO_DCQCN,
> +	CONG_TYPE_LDCP = 1 << HNS_ROCE_SCC_ALGO_LDCP,
> +	CONG_TYPE_HC3 = 1 << HNS_ROCE_SCC_ALGO_HC3,
> +	CONG_TYPE_DIP = 1 << HNS_ROCE_SCC_ALGO_DIP,
>  };
>  
>  struct hns_roce_qp {
> @@ -644,7 +652,7 @@ struct hns_roce_qp {
>  	struct list_head	sq_node; /* all send qps are on a list */
>  	struct hns_user_mmap_entry *dwqe_mmap_entry;
>  	u32			config;
> -	enum cong_type		cong_type;
> +	enum hns_roce_cong_type	cong_type;
>  };
>  
>  struct hns_roce_ib_iboe {
> @@ -845,7 +853,8 @@ struct hns_roce_caps {
>  	u16		default_aeq_period;
>  	u16		default_aeq_arm_st;
>  	u16		default_ceq_arm_st;
> -	enum cong_type	cong_type;
> +	u8		cong_cap;
> +	enum hns_roce_cong_type	default_cong_type;
>  };
>  
>  enum hns_roce_device_state {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 42e28586cefa..21532f213b0f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -2209,11 +2209,12 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
>  	caps->max_wqes = 1 << le16_to_cpu(resp_c->sq_depth);
>  
>  	caps->num_srqs = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_SRQS);
> -	caps->cong_type = hr_reg_read(resp_d, PF_CAPS_D_CONG_TYPE);
> +	caps->cong_cap = hr_reg_read(resp_d, PF_CAPS_D_CONG_CAP);
>  	caps->max_srq_wrs = 1 << le16_to_cpu(resp_d->srq_depth);
>  	caps->ceqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_CEQ_DEPTH);
>  	caps->num_comp_vectors = hr_reg_read(resp_d, PF_CAPS_D_NUM_CEQS);
>  	caps->aeqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_AEQ_DEPTH);
> +	caps->default_cong_type = hr_reg_read(resp_d, PF_CAPS_D_DEFAULT_ALG);
>  	caps->reserved_pds = hr_reg_read(resp_d, PF_CAPS_D_RSV_PDS);
>  	caps->num_uars = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_UARS);
>  	caps->reserved_qps = hr_reg_read(resp_d, PF_CAPS_D_RSV_QPS);
> @@ -4737,14 +4738,8 @@ enum {
>  static int check_cong_type(struct ib_qp *ibqp,
>  			   struct hns_roce_congestion_algorithm *cong_alg)
>  {
> -	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>  	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
>  
> -	if (ibqp->qp_type == IB_QPT_UD || ibqp->qp_type == IB_QPT_GSI)
> -		hr_qp->cong_type = CONG_TYPE_DCQCN;
> -	else
> -		hr_qp->cong_type = hr_dev->caps.cong_type;
> -
>  	/* different congestion types match different configurations */
>  	switch (hr_qp->cong_type) {
>  	case CONG_TYPE_DCQCN:
> @@ -4772,9 +4767,6 @@ static int check_cong_type(struct ib_qp *ibqp,
>  		cong_alg->wnd_mode_sel = WND_LIMIT;
>  		break;
>  	default:
> -		ibdev_warn(&hr_dev->ib_dev,
> -			   "invalid type(%u) for congestion selection.\n",
> -			   hr_qp->cong_type);
>  		hr_qp->cong_type = CONG_TYPE_DCQCN;
>  		cong_alg->alg_sel = CONG_DCQCN;
>  		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
> @@ -4807,7 +4799,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
>  		return ret;
>  
>  	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
> -		     hr_qp->cong_type * HNS_ROCE_CONG_SIZE);
> +		     ilog2(hr_qp->cong_type) * HNS_ROCE_CONG_SIZE);
>  	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
>  	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
>  	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index cd97cbee682a..359a74672ba1 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -1214,12 +1214,13 @@ struct hns_roce_query_pf_caps_d {
>  #define PF_CAPS_D_RQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(21, 20)
>  #define PF_CAPS_D_EX_SGE_HOP_NUM PF_CAPS_D_FIELD_LOC(23, 22)
>  #define PF_CAPS_D_SQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(25, 24)
> -#define PF_CAPS_D_CONG_TYPE PF_CAPS_D_FIELD_LOC(29, 26)
> +#define PF_CAPS_D_CONG_CAP PF_CAPS_D_FIELD_LOC(29, 26)
>  #define PF_CAPS_D_CEQ_DEPTH PF_CAPS_D_FIELD_LOC(85, 64)
>  #define PF_CAPS_D_NUM_CEQS PF_CAPS_D_FIELD_LOC(95, 86)
>  #define PF_CAPS_D_AEQ_DEPTH PF_CAPS_D_FIELD_LOC(117, 96)
>  #define PF_CAPS_D_AEQ_ARM_ST PF_CAPS_D_FIELD_LOC(119, 118)
>  #define PF_CAPS_D_CEQ_ARM_ST PF_CAPS_D_FIELD_LOC(121, 120)
> +#define PF_CAPS_D_DEFAULT_ALG PF_CAPS_D_FIELD_LOC(127, 122)
>  #define PF_CAPS_D_RSV_PDS PF_CAPS_D_FIELD_LOC(147, 128)
>  #define PF_CAPS_D_NUM_UARS PF_CAPS_D_FIELD_LOC(155, 148)
>  #define PF_CAPS_D_RSV_QPS PF_CAPS_D_FIELD_LOC(179, 160)
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index b55fe6911f9f..e5b678814f58 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -394,6 +394,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>  			resp.config |= HNS_ROCE_RSP_CQE_INLINE_FLAGS;
>  	}
>  
> +	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
> +		resp.congest_type  = hr_dev->caps.cong_cap;
> +
>  	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
>  	if (ret)
>  		goto error_out;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 31b147210688..e22911d6b6a9 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -1004,6 +1004,70 @@ static void free_kernel_wrid(struct hns_roce_qp *hr_qp)
>  	kfree(hr_qp->sq.wrid);
>  }
>  
> +static void default_congest_type(struct hns_roce_dev *hr_dev,
> +				 struct hns_roce_qp *hr_qp)
> +{
> +	struct hns_roce_caps *caps = &hr_dev->caps;
> +
> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD ||
> +	    hr_qp->ibqp.qp_type == IB_QPT_GSI)
> +		hr_qp->cong_type = CONG_TYPE_DCQCN;
> +	else
> +		hr_qp->cong_type = 1 << caps->default_cong_type;
> +}
> +
> +static int set_congest_type(struct hns_roce_qp *hr_qp,
> +			    struct hns_roce_ib_create_qp *ucmd)
> +{
> +	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
> +
> +	switch (ucmd->cong_type_flags) {
> +	case HNS_ROCE_CREATE_QP_FLAGS_DCQCN:
> +		hr_qp->cong_type = CONG_TYPE_DCQCN;
> +		break;
> +	case HNS_ROCE_CREATE_QP_FLAGS_LDCP:
> +		hr_qp->cong_type = CONG_TYPE_LDCP;
> +		break;
> +	case HNS_ROCE_CREATE_QP_FLAGS_HC3:
> +		hr_qp->cong_type = CONG_TYPE_HC3;
> +		break;
> +	case HNS_ROCE_CREATE_QP_FLAGS_DIP:
> +		hr_qp->cong_type = CONG_TYPE_DIP;
> +		break;
> +	default:
> +		hr_qp->cong_type = 0;
> +	}
> +
> +	if (!(hr_qp->cong_type & hr_dev->caps.cong_cap)) {
> +		ibdev_err_ratelimited(&hr_dev->ib_dev,
> +				      "Unsupported congest type 0x%x, cong_cap = 0x%x.\n",
> +				      hr_qp->cong_type, hr_dev->caps.cong_cap);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD &&
> +	    !(hr_qp->cong_type & CONG_TYPE_DCQCN)) {
> +		ibdev_err_ratelimited(&hr_dev->ib_dev,
> +				      "Only DCQCN supported for UD. Unsupported congest type 0x%x.\n",
> +				      hr_qp->cong_type);

Do not print kernel messages triggered by bad userspace input.

Jason

> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int set_congest_param(struct hns_roce_dev *hr_dev,
> +			     struct hns_roce_qp *hr_qp,
> +			     struct hns_roce_ib_create_qp *ucmd)
> +{
> +	if (ucmd->comp_mask & HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE)
> +		return set_congest_type(hr_qp, ucmd);
> +
> +	default_congest_type(hr_dev, hr_qp);
> +
> +	return 0;
> +}
> +
>  static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>  			struct ib_qp_init_attr *init_attr,
>  			struct ib_udata *udata,
> @@ -1026,6 +1090,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>  		return ret;
>  	}
>  
> +	if (init_attr->qp_type == IB_QPT_XRC_TGT)
> +		default_congest_type(hr_dev, hr_qp);
> +
>  	if (udata) {
>  		ret = ib_copy_from_udata(ucmd, udata,
>  					 min(udata->inlen, sizeof(*ucmd)));
> @@ -1043,6 +1110,10 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>  			ibdev_err(ibdev,
>  				  "failed to set user SQ size, ret = %d.\n",
>  				  ret);
> +
> +		ret = set_congest_param(hr_dev, hr_qp, ucmd);
> +		if (ret)
> +			return ret;
>  	} else {
>  		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
>  			hr_qp->config = HNS_ROCE_EXSGE_FLAGS;
> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index c996e151081e..757095a6c6fc 100644
> --- a/include/uapi/rdma/hns-abi.h
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -81,6 +81,9 @@ struct hns_roce_ib_create_qp {
>  	__u8    sq_no_prefetch;
>  	__u8    reserved[5];
>  	__aligned_u64 sdb_addr;
> +	__aligned_u64 comp_mask; /* Use enum hns_roce_create_qp_comp_mask */
> +	__aligned_u64 create_flags;
> +	__aligned_u64 cong_type_flags;
>  };
>  
>  enum hns_roce_qp_cap_flags {
> @@ -107,6 +110,17 @@ enum {
>  	HNS_ROCE_RSP_CQE_INLINE_FLAGS = 1 << 2,
>  };
>  
> +enum hns_roce_congest_type_flags {
> +	HNS_ROCE_CREATE_QP_FLAGS_DCQCN = 1 << 0,
> +	HNS_ROCE_CREATE_QP_FLAGS_LDCP = 1 << 1,
> +	HNS_ROCE_CREATE_QP_FLAGS_HC3 = 1 << 2,
> +	HNS_ROCE_CREATE_QP_FLAGS_DIP = 1 << 3,
> +};

Why are these bit flags if they are exclusive?

> +
> +enum hns_roce_create_qp_comp_mask {
> +	HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE = 1 << 1,

Why 1<<1 not 1<<0?

These are in the wrong order in the file too, they should be before
their first "use", ie move above struct hns_roce_ib_create_qp

> @@ -114,6 +128,9 @@ struct hns_roce_ib_alloc_ucontext_resp {
>  	__u32	reserved;
>  	__u32	config;
>  	__u32	max_inline_data;
> +	__u8	reserved0;
> +	__u8	congest_type;

Why this layout?

Jason

