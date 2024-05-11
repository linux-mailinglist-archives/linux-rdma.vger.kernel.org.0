Return-Path: <linux-rdma+bounces-2419-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93698C31A8
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE8A2818D6
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867575101A;
	Sat, 11 May 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH0MGIGT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D877F6
	for <linux-rdma@vger.kernel.org>; Sat, 11 May 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715434666; cv=none; b=n9+s0BRk2sZwusrdZEe7GqbwcpohwLWqQd5BK2YCp9+IM9laz2aaLF5r/DY3S6B/Idv6xNuqbZ/rn6V8EebtegWL6dlzlOER4l8yIrr5AiQeGfV9ljvpOi0OVzpdqJPTv1Bmq1dZ7Qt/1BDNfIPce9qdpvppVQ/9nhes/017Y6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715434666; c=relaxed/simple;
	bh=VifzIFRA+BEbaT9pFfwQ8KyZAusZTBxSglBOaWu2LCE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mmC/9rD9Dq6mDmeIyfjK30JpO+3MiC2mpo7AwzganKeS2mStzTkR85LTRr8Dw5N3uCEi7BwRsUEkeP/c+aubDxjFMvcgFRBkvkXXRQO2vNCHNZYNfVk01wkgXwtd5tcw9YcKXg5uoxSU5L2FNkDTkJ5DfhCaRwFCgFasl6iAQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH0MGIGT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34d8f6cfe5bso2318349f8f.3
        for <linux-rdma@vger.kernel.org>; Sat, 11 May 2024 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715434663; x=1716039463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uat2Dj1cITjTbKKvQqWtKvWPd9HUyQRdF4JpVO3ysGQ=;
        b=kH0MGIGTA4QUIa3NK6fTrf9WlihyG4/+MABWCxwTmpEAAIqMzJrFHfHAaF2YpmJCSp
         2xetMMxldzWlBuYs1yjPSfJBV/uDP3vWt9FFvYEgopa82YK9OVPiPkIyKV0aFce45WC5
         8zqSOpLBBulTJ4dkH/JNmDO4GmSV5GR0+kchEP1Y5qLDeE9x5bUrZJHNQVqkblNiQ30/
         EkVEDY/ODHG58QBZfiZa7MYKU2lJ6cqhV5GVG+uSsW4/RvLlUwCyLkMi45lmb4NKG09t
         eO+p6/zfiy+BinB5ESxCp20PksUySrkbi//BxunOo0tEnj4wEXIg9dr0P3UsXyltCPuA
         9Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715434663; x=1716039463;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uat2Dj1cITjTbKKvQqWtKvWPd9HUyQRdF4JpVO3ysGQ=;
        b=J2+mj7ezHMxQIc2JsknZalnCxGlP3a9VM99yiYx0kr3zJhTrNYr0exSl+Dyird5XTu
         yRexeiLvLyMgERBcVua0xSjuscEeu1WfDVzNnKD5GwxFOlewq/CeFQ0rspmfjeDLM2hd
         UZUb3fQ9uS4FpJDDl56nNGv+XdHIsKPhgY3wGeoUWozKIXbWk0Zr2osVjOddOh8AIl6g
         /8lxAUJ9kcyc+0K0kA1WxUC7EYZEAYeCnznUtmba8DDb2q2fsE+JSn21o8Ko61ptamYs
         B+9XGte/m76+vzPTGU3sbIZwB+l742ghfN/+bhPX9BZ7oeDNyI9IFV8Ac0mcin632ez9
         QDXw==
X-Gm-Message-State: AOJu0YzZAbtGpJIzOs2U820g0aXwO6wk8k+ogR7PuyJhwCZvWobq1w2Y
	njtpFfB0E3NeooTNACkXV0J9gU80bu7VmUqIYAPllq9jSShncgvonQxtZw==
X-Google-Smtp-Source: AGHT+IFv8wN1Oe5/Aofm+4o9gti7/PAxrYp/lNIwIbtTxsstuenYstbCsJuWnmZiat8APQAXqf/Zyw==
X-Received: by 2002:adf:e009:0:b0:351:b554:9667 with SMTP id ffacd0b85a97d-351b5549824mr53373f8f.19.1715434662302;
        Sat, 11 May 2024 06:37:42 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b895731sm6994934f8f.42.2024.05.11.06.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 06:37:41 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <7c0b4fff-def4-4f71-a30f-44f01d7c5461@linux.dev>
Date: Sat, 11 May 2024 15:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-next 1/2] RDMA/bnxt_re: Allow MSN table capability
 check
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
References: <1715402190-28657-1-git-send-email-selvin.xavier@broadcom.com>
 <1715402190-28657-2-git-send-email-selvin.xavier@broadcom.com>
Content-Language: en-US
In-Reply-To: <1715402190-28657-2-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.05.24 06:36, Selvin Xavier wrote:
> FW reports the HW capability to use PSN table or MSN table and
> driver/library need to select it based on this capability.
> Use the new capability instead of the older capability check for HW
> retransmission while handling the MSN/PSN table. FW report
> zero (PSN table) for older adapters to maintain backward compatibility.
> 
> Also, Updated the FW interface structures to handle the new fields.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>   drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++------
>   drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 +-
>   drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
>   drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  1 +
>   drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  1 +
>   drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 30 +++++++++++++++++++++++++++++-
>   6 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 439d0c7..3c961a8 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -984,7 +984,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>   	u16 nsge;
>   
>   	if (res->dattr)
> -		qp->dev_cap_flags = res->dattr->dev_cap_flags;
> +		qp->is_host_msn_tbl = _is_host_msn_table(res->dattr->dev_cap_flags2);
>   
>   	sq->dbinfo.flags = 0;
>   	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
> @@ -1002,7 +1002,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>   			 sizeof(struct sq_psn_search_ext) :
>   			 sizeof(struct sq_psn_search);
>   
> -		if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
> +		if (qp->is_host_msn_tbl) {
>   			psn_sz = sizeof(struct sq_msn_search);
>   			qp->msn = 0;
>   		}
> @@ -1015,7 +1015,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>   	hwq_attr.aux_stride = psn_sz;
>   	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
>   	/* Update msn tbl size */
> -	if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
> +	if (qp->is_host_msn_tbl && psn_sz) {
>   		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
>   		qp->msn_tbl_sz = hwq_attr.aux_depth;
>   		qp->msn = 0;
> @@ -1636,7 +1636,7 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
>   	if (!swq->psn_search)
>   		return;
>   	/* Handle MSN differently on cap flags  */
> -	if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
> +	if (qp->is_host_msn_tbl) {
>   		bnxt_qplib_fill_msn_search(qp, wqe, swq);
>   		return;
>   	}
> @@ -1818,7 +1818,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
>   	}
>   
>   	swq = bnxt_qplib_get_swqe(sq, &wqe_idx);
> -	bnxt_qplib_pull_psn_buff(qp, sq, swq, BNXT_RE_HW_RETX(qp->dev_cap_flags));
> +	bnxt_qplib_pull_psn_buff(qp, sq, swq, qp->is_host_msn_tbl);
>   
>   	idx = 0;
>   	swq->slot_idx = hwq->prod;
> @@ -2008,7 +2008,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
>   		rc = -EINVAL;
>   		goto done;
>   	}
> -	if (!BNXT_RE_HW_RETX(qp->dev_cap_flags) || msn_update) {
> +	if (!qp->is_host_msn_tbl || msn_update) {
>   		swq->next_psn = sq->psn & BTH_PSN_MASK;
>   		bnxt_qplib_fill_psn_search(qp, wqe, swq);
>   	}
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> index 7fd4506..5b8d097 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -340,7 +340,7 @@ struct bnxt_qplib_qp {
>   	struct list_head		rq_flush;
>   	u32				msn;
>   	u32				msn_tbl_sz;
> -	u16				dev_cap_flags;
> +	u16				is_host_msn_tbl;

Because qp->is_host_msn_tbl is set to 
_is_host_msn_table(res->dattr->dev_cap_flags2);


is_host_msn_tbl is also declared as bool type?

Zhu Yanjun

>   };
>   
>   #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> index 61628f7..a0f78cd 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> @@ -554,6 +554,12 @@ static inline bool _is_hw_retx_supported(u16 dev_cap_flags)
>   
>   #define BNXT_RE_HW_RETX(a) _is_hw_retx_supported((a))
>   
> +static inline bool _is_host_msn_table(u16 dev_cap_ext_flags2)
> +{
> +	return (dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK) ==
> +		CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_MSN_TABLE;
> +}
> +
>   static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
>   {
>   	return cctx->modes.dbr_pacing;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index 8beeedd..9328db9 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -156,6 +156,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
>   				    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
>   	attr->max_sgid = BNXT_QPLIB_NUM_GIDS_SUPPORTED;
>   	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
> +	attr->dev_cap_flags2 = le16_to_cpu(sb->dev_cap_ext_flags_2);
>   
>   	bnxt_qplib_query_version(rcfw, attr->fw_ver);
>   
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> index d33c78b..16a67d7 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> @@ -72,6 +72,7 @@ struct bnxt_qplib_dev_attr {
>   	u8				tqm_alloc_reqs[MAX_TQM_ALLOC_REQ];
>   	bool				is_atomic;
>   	u16                             dev_cap_flags;
> +	u16                             dev_cap_flags2;
>   	u32                             max_dpi;
>   };
>   
> diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> index 605c946..0425309 100644
> --- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> +++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> @@ -2157,8 +2157,36 @@ struct creq_query_func_resp_sb {
>   	__le32	tqm_alloc_reqs[12];
>   	__le32	max_dpi;
>   	u8	max_sge_var_wqe;
> -	u8	reserved_8;
> +	u8	dev_cap_ext_flags;
> +	#define CREQ_QUERY_FUNC_RESP_SB_ATOMIC_OPS_NOT_SUPPORTED         0x1UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_DRV_VERSION_RGTR_SUPPORTED       0x2UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_QP_BATCH_SUPPORTED        0x4UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_DESTROY_QP_BATCH_SUPPORTED       0x8UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_ROCE_STATS_EXT_CTX_SUPPORTED     0x10UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_SRQ_SGE_SUPPORTED         0x20UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_FIXED_SIZE_WQE_DISABLED          0x40UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_DCN_SUPPORTED                    0x80UL
>   	__le16	max_inline_data_var_wqe;
> +	__le32	start_qid;
> +	u8	max_msn_table_size;
> +	u8	reserved8_1;
> +	__le16	dev_cap_ext_flags_2;
> +	#define CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED             0x1UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CHANGE_UDP_SRC_PORT_WQE_SUPPORTED        0x2UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED                  0x4UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_MEMORY_REGION_RO_SUPPORTED               0x8UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK          0x30UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_SFT           4
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_PSN_TABLE  (0x0UL << 4)
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_MSN_TABLE  (0x1UL << 4)
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE   (0x2UL << 4)
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST	\
> +			CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
> +	__le16	max_xp_qp_size;
> +	__le16	create_qp_batch_size;
> +	__le16	destroy_qp_batch_size;
> +	__le16	reserved16;
> +	__le64	reserved64;
>   };
>   
>   /* cmdq_set_func_resources (size:448b/56B) */


