Return-Path: <linux-rdma+bounces-4998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C497C5D5
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5281C211D3
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E1198A3B;
	Thu, 19 Sep 2024 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoqD0XcQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1131990DB
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734509; cv=none; b=powNNQ46saYnm1WEE6DsLt9jVYaAIphq+tuwLG6wuUtythAGk1if7K2Y/nflALhL57xoDSn2rLcPZ5dswn5Hq4eattjIdG760sWoB/Nt99oQ8/9ae4Zz5G7h2kv90Q9pxhucQ7qcJwRC6CDzDWL0llKtQrFfotF9Su/Kh1IrDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734509; c=relaxed/simple;
	bh=/WPwUykYTgBA1nDDmS8p7cXr+hp3iNjsJ8LunUDUfpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNVPGNONQRLkq+RSIFttK+qTVVDx82rXKGqNpkYWm65sKTArEVCWkdixguuQWEK5qFMJC00iS111dCPJFHctmUXJc14jb8Aoi5ZjptXOzG0LpjeB4Y0S5XI2Yc0l42iV9l0DRMBZr9Xhndn3M1BieTPYP7qBknyhltxbgieAweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoqD0XcQ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb568e6f-b972-457b-8dc4-bf564acb1ab4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726734502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddv4atkOoe7mGzuGqB5HkZO94a5BMVIaGDP03/WxweA=;
	b=QoqD0XcQij0Z5bxY3XMJGJePQnJbaEdBCjb6n2pOHByQXB4vCvCRy7wsCAJLV+dUUae0hk
	rhZfJoZql965p8NTR/SvRBJKw9XZMARa9Fs/JXgJdIeVQHbRAhSal3nYNtO/8TGcGX+IXP
	i8aOnXQNZrh7gLqEuztzl41Nh/Hub0s=
Date: Thu, 19 Sep 2024 16:28:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 for-rc 5/6] RDMA/bnxt_re: synchronize the qp-handle
 table array
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
 <1726715161-18941-6-git-send-email-selvin.xavier@broadcom.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1726715161-18941-6-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/19 11:06, Selvin Xavier 写道:
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
>   drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  4 ++++
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 +++++++++----
>   drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
>   3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 42e98e5..bc358bd 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -1527,9 +1527,11 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
>   	u32 tbl_indx;
>   	int rc;
>   
> +	spin_lock_bh(&rcfw->tbl_lock);
>   	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
>   	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
>   	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
> +	spin_unlock_bh(&rcfw->tbl_lock);
>   
>   	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
>   				 CMDQ_BASE_OPCODE_DESTROY_QP,
> @@ -1540,8 +1542,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
>   				sizeof(resp), 0);
>   	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
>   	if (rc) {
> +		spin_lock_bh(&rcfw->tbl_lock);
>   		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
>   		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
> +		spin_unlock_bh(&rcfw->tbl_lock);
>   		return rc;
>   	}
>   
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 5bef9b4..85bfedc 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -634,17 +634,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
>   	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
>   		err_event = (struct creq_qp_error_notification *)qp_event;
>   		qp_id = le32_to_cpu(err_event->xid);
> +		spin_lock_nested(&rcfw->tbl_lock, SINGLE_DEPTH_NESTING);
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
> @@ -973,6 +977,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
>   			       GFP_KERNEL);
>   	if (!rcfw->qp_tbl)
>   		goto fail;
> +	spin_lock_init(&rcfw->tbl_lock);

Thanks. I am fine with this spin_lock_bh and spin_lock_init.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   
>   	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
>   
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
>   	u64 oos_prev;
>   	u32 init_oos_stats;
>   	u32 cmdq_depth;


