Return-Path: <linux-rdma+bounces-4928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462C39777DA
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 06:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4741C2446B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 04:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2481B12EC;
	Fri, 13 Sep 2024 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yr5S2qoN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B6189F2D
	for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201595; cv=none; b=LJWQzK7T92a1IKAsc1VkPY8WpvsSV/OeXX4kxKjgQQGKBl4fh59okm7ck+ewpkI+lbbcpdmSdY8jC5Pk3h+pcS0zxq4t2MXcILEKzu0mPQPHVmxg1dl5zDOxVQA5k1xVUX2eJxc4P3U73UBN/pOE1I+VUCxfJC4o6S30r3lYfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201595; c=relaxed/simple;
	bh=4ozaCDzClqErF8lCajw4j/Glb9p81yktSO6KXN65QvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgl1DvKlMccjapzwbG8ELrz7i+XVqbQ+e3QTx5lYbqIiGM81qugHlpXHE2k5B9WnYSgv5sQmaqSnnouSzSmck2w0bq5xJk12B4nUbO1Nz7iqzrBUL4TTDIY80sXjT/xR0j7gG/USOpKBvlnaXxPZgLEUY8u0Sh2QXQ5BAmm/Ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yr5S2qoN; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9c4e2a6-cbf6-4c21-a29a-58b02b10edf8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726201589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smerIwVdCKtcmUtvmcjE5fKTmq09siUJ9LT1J+NY75U=;
	b=Yr5S2qoND4B/swe3EQQnDqU4GXMa3n++S2W/GKNMhL0jF4i+ZZxVC2UmBa3ABCd2a+kzf9
	mYod+zCFIKUBzrH5hkeMdQMIj4sQg5NhPGmjV0djYwABxO42yEuRlRqjniMoClTl33cHv2
	OJHQIjw95i1zHLoCXEIPmjrONi96PgI=
Date: Fri, 13 Sep 2024 12:26:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] RDMA/bnxt_re: synchronize the qp-handle table array
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com
References: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
 <1726079379-19272-5-git-send-email-selvin.xavier@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1726079379-19272-5-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/12 2:29, Selvin Xavier 写道:
> There is a race between the CREQ tasklet and destroy
> qp when accessing the qp-handle table. There is
> a chance of reading a valid qp-handle in the
> CREQ tasklet handler while the QP is already moving
> ahead with the destruction.
> 
> Fixing this race by implementing a table-lock to
> synchronize the access.
> 
> Fixes: f218d67ef004 ("RDMA/bnxt_re: Allow posting when QPs are in error")
> Fixes: 84cf229f4001 ("RDMA/bnxt_re: Fix the qp table indexing")
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>   drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  5 +++++
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 12 ++++++++----
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
>   3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 42e98e5..5d36216 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -1524,12 +1524,15 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
>   	struct creq_destroy_qp_resp resp = {};
>   	struct bnxt_qplib_cmdqmsg msg = {};
>   	struct cmdq_destroy_qp req = {};
> +	unsigned long flags;
>   	u32 tbl_indx;
>   	int rc;
>   
> +	spin_lock_irqsave(&rcfw->tbl_lock, flags);
>   	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
>   	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
>   	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
> +	spin_unlock_irqrestore(&rcfw->tbl_lock, flags);
>   
>   	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
>   				 CMDQ_BASE_OPCODE_DESTROY_QP,
> @@ -1540,8 +1543,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
>   				sizeof(resp), 0);
>   	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
>   	if (rc) {
> +		spin_lock_irqsave(&rcfw->tbl_lock, flags);
>   		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
>   		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
> +		spin_unlock_irqrestore(&rcfw->tbl_lock, flags);
>   		return rc;
>   	}
>   
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 3ffaef0c..993c356 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -637,17 +637,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
>   	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
>   		err_event = (struct creq_qp_error_notification *)qp_event;
>   		qp_id = le32_to_cpu(err_event->xid);
> +		spin_lock(&rcfw->tbl_lock);
>   		tbl_indx = map_qp_id_to_tbl_indx(qp_id, rcfw);
>   		qp = rcfw->qp_tbl[tbl_indx].qp_handle;
> +		if (!qp) {
> +			spin_unlock(&rcfw->tbl_lock);
> +			break;
> +		}
> +		bnxt_qplib_mark_qp_error(qp);
> +		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
> +		spin_unlock(&rcfw->tbl_lock);
>   		dev_dbg(&pdev->dev, "Received QP error notification\n");
>   		dev_dbg(&pdev->dev,
>   			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
>   			qp_id, err_event->req_err_state_reason,
>   			err_event->res_err_state_reason);
> -		if (!qp)
> -			break;
> -		bnxt_qplib_mark_qp_error(qp);
> -		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
>   		break;
>   	default:
>   		/*
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> index 45996e6..07779ae 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> @@ -224,6 +224,8 @@ struct bnxt_qplib_rcfw {
>   	struct bnxt_qplib_crsqe		*crsqe_tbl;
>   	int qp_tbl_size;
>   	struct bnxt_qplib_qp_node *qp_tbl;
> +	/* To synchronize the qp-handle hash table */
> +	spinlock_t			tbl_lock;

missing spin_lock_init?

In this commit, spin_lock_init is not found, maybe this function is 
called in other commit?

Or now spin_lock_init is not used again?

Zhu Yanjun
>   	u64 oos_prev;
>   	u32 init_oos_stats;
>   	u32 cmdq_depth;


