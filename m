Return-Path: <linux-rdma+bounces-2551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108A8CAA70
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 11:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0BA1B22422
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43DE4776A;
	Tue, 21 May 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktcy8cgE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196E8C05;
	Tue, 21 May 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282150; cv=none; b=Wkn+XZ/LR4FdZdjLg58v4xl8l4I8UyLFt+qvln1ObP8hlW+xdWVOfP1sMqwr+T6yj0jli3WEa0W7L9yy9zFi8i0zhGwATusTpJSZV5oNQunk7prVPU8PB5qEEMdl1MXGBPKTNHaLNXcUHOK68RPH+fxGtURwvxX3SOFGG5Z8vyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282150; c=relaxed/simple;
	bh=RwE9G1AHX7ZjXVbyV9XVN52DNEC9+ZEfHiWdMHcDgTA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lw+yHP9VMjDj8ZWrmu96hg+kX5zx+WDgmRUMj4NjcTjas05hrg+7ktJYdNoQ2TAclWew1CntGF7NBUamP8pQplFGrCQXfx7/I130RIVvW7bt6WtL8IKqZi1k12Qg7SSXdXH//UvUwiQcSJHVkQHrKM2TjY4RO2zZEDjXZq96Vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktcy8cgE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-351d79b56cdso2542245f8f.1;
        Tue, 21 May 2024 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716282147; x=1716886947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZogKwDOYNbRUIvcc+8rJh/bCHgcSMtWaJCVVcFKFVEc=;
        b=ktcy8cgEMjPT/gvRHmYUo/5zxlL9ojpGG+ZzKRxZ6PsSkIcmdbmSe3Tpf3vPAUlPD1
         0pOqIGJBC0AxC6MtXegyQX/vTeA3c27yvLyNJa029HxwKlD/Ro8nj92ToabJ2wT2bdEG
         gBOQvcUY3Vig3b7A9RGd2rF4aG4BYr3d9PnAkA8QFmEKkyZuV+NFrROAGTp1jmh0poaO
         GqX8SdHb43mNSeoxag8uFYWD+UdEE34nvq0Va6nt8sT9zw7LSyKxudTQAvBodeU25HgN
         VEm7KF0vlG8Z+gWWF870gq5XBsh52/wKa49mIwIeGLE9JSPFIJZkw1STUJUVy5qE+RVT
         iNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282147; x=1716886947;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZogKwDOYNbRUIvcc+8rJh/bCHgcSMtWaJCVVcFKFVEc=;
        b=NjGGdjRHWPtrH2tHr8OU8nBBzah6KS6OOH0H0pzDd4e8pwEds4h3XdWjn1TKAv2MiD
         wa+BZkMiviL9OJzTYhVanKd8aXA9E0b+GTAKj8sg3wjwLAMJK+M7FmaGAQ+nPXmmeflt
         46qQS+qGn8m+jENeyFBpKX7jq23guTqj+I8tbnWKWngWRIsSVXAWMtsiNKJsm7Mzh2cC
         adfj9fi4LIzUExXvYeYqb3ArlzadYUJ+YHn+/Z+vw3uS3Yl5mKqUPMWb6k06x1jIHDLV
         co+gsGDwXdtmmxiKX6th5nOrREJ/PQsUX9czQx+uvryiY3ffv5Ewn0FPS3ip+flBbQbj
         RcpA==
X-Forwarded-Encrypted: i=1; AJvYcCWRWCN+p9kP0WzGzlzK8NKpRJg9l0BQ0XQYCeEZnKfeL5Be9QXkFavQOzYDcegx/6X/Yh1XgrZ8qnmVAIkVAzU+8yqc1Y/RnzDjY642
X-Gm-Message-State: AOJu0YwofWKbejeAwUPkXgFxw77IQE71jq5iwOtTSTgNvp7Cv5Hqu9P3
	epIF3l5U83rUte5Ga44GdnJGiUpC8XIzIHn35Qj6PXy6jX6hU0KokwkZYQ==
X-Google-Smtp-Source: AGHT+IFDKrLIZtRdbQTwK/AStvRmrcyQHx8BagEty4XCcPMcA15y0xt0wqHWsXhWwel6lOfVALoGwA==
X-Received: by 2002:a05:6000:502:b0:34c:b483:4f56 with SMTP id ffacd0b85a97d-3504a73753amr19224044f8f.31.1716282146910;
        Tue, 21 May 2024 02:02:26 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a78cdsm31293804f8f.58.2024.05.21.02.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:02:26 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <5e6917de-53e2-467e-aa95-fa52eda9cd2c@linux.dev>
Date: Tue, 21 May 2024 11:02:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v2 2/3] RDMA/mana_ib: Implement uapi to create
 and destroy RC QP
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1716280453-24387-1-git-send-email-kotaranov@linux.microsoft.com>
 <1716280453-24387-3-git-send-email-kotaranov@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1716280453-24387-3-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.24 10:34, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement user requests to create and destroy an RC QP.
> As the user does not have an FMR queue, it is skipped and NO_FMR flag
> is used.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>   drivers/infiniband/hw/mana/mana_ib.h |  4 ++
>   drivers/infiniband/hw/mana/qp.c      | 94 +++++++++++++++++++++++++++-
>   include/uapi/rdma/mana-abi.h         |  9 +++
>   3 files changed, 105 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
> index a3e229c83..5cccbe397 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -248,6 +248,10 @@ struct mana_rnic_destroy_cq_resp {
>   	struct gdma_resp_hdr hdr;
>   }; /* HW Data */
>   
> +enum mana_rnic_create_rc_flags {
> +	MANA_RC_FLAG_NO_FMR = 2,
> +};
> +
>   struct mana_rnic_create_qp_req {
>   	struct gdma_req_hdr hdr;
>   	mana_handle_t adapter;
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index ba13c5abf..e04e5e778 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -398,6 +398,78 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
>   	return err;
>   }
>   
> +static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
> +				struct ib_qp_init_attr *attr, struct ib_udata *udata)
> +{
> +	struct mana_ib_dev *mdev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
> +	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
> +	struct mana_ib_create_rc_qp_resp resp = {};
> +	struct mana_ib_ucontext *mana_ucontext;
> +	struct mana_ib_create_rc_qp ucmd = {};
> +	int i, err, j;
> +	u64 flags = 0;
> +	u32 doorbell;
> +
> +	if (!udata || udata->inlen < sizeof(ucmd))
> +		return -EINVAL;
> +
> +	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext, ibucontext);
> +	doorbell = mana_ucontext->doorbell;
> +	flags = MANA_RC_FLAG_NO_FMR;
> +	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> +	if (err) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to copy from udata, %d\n", err);
> +		return err;
> +	}
> +
> +	for (i = 0, j = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
> +		// skip FMR for user-level RC QPs

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/checkpatch.rst?h=v6.9#n497

"
   **C99_COMMENTS**
     C99 style single line comments (//) should not be used.
     Prefer the block comment style instead.

     See: 
https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
"

Zhu Yanjun

> +		if (i == MANA_RC_SEND_QUEUE_FMR) {
> +			qp->rc_qp.queues[i].id = INVALID_QUEUE_ID;
> +			qp->rc_qp.queues[i].gdma_region = GDMA_INVALID_DMA_REGION;
> +			continue;
> +		}
> +		err = mana_ib_create_queue(mdev, ucmd.queue_buf[j], ucmd.queue_size[j],
> +					   &qp->rc_qp.queues[i]);
> +		if (err) {
> +			ibdev_err(&mdev->ib_dev, "Failed to create queue %d, err %d\n", i, err);
> +			goto destroy_queues;
> +		}
> +		j++;
> +	}
> +
> +	err = mana_ib_gd_create_rc_qp(mdev, qp, attr, doorbell, flags);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create rc qp  %d\n", err);
> +		goto destroy_queues;
> +	}
> +	qp->ibqp.qp_num = qp->rc_qp.queues[MANA_RC_RECV_QUEUE_RESPONDER].id;
> +	qp->port = attr->port_num;
> +
> +	if (udata) {
> +		for (i = 0, j = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
> +			if (i == MANA_RC_SEND_QUEUE_FMR)
> +				continue;
> +			resp.queue_id[j] = qp->rc_qp.queues[i].id;
> +			j++;
> +		}
> +		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
> +		if (err) {
> +			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
> +			goto destroy_qp;
> +		}
> +	}
> +
> +	return 0;
> +
> +destroy_qp:
> +	mana_ib_gd_destroy_rc_qp(mdev, qp);
> +destroy_queues:
> +	while (i-- > 0)
> +		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
> +	return err;
> +}
> +
>   int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>   		      struct ib_udata *udata)
>   {
> @@ -409,8 +481,9 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>   						     udata);
>   
>   		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
> +	case IB_QPT_RC:
> +		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
>   	default:
> -		/* Creating QP other than IB_QPT_RAW_PACKET is not supported */
>   		ibdev_dbg(ibqp->device, "Creating QP type %u not supported\n",
>   			  attr->qp_type);
>   	}
> @@ -473,6 +546,22 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
>   	return 0;
>   }
>   
> +static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
> +{
> +	struct mana_ib_dev *mdev =
> +		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> +	int i;
> +
> +	/* Ignore return code as there is not much we can do about it.
> +	 * The error message is printed inside.
> +	 */
> +	mana_ib_gd_destroy_rc_qp(mdev, qp);
> +	for (i = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i)
> +		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
> +
> +	return 0;
> +}
> +
>   int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   {
>   	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
> @@ -484,7 +573,8 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   						      udata);
>   
>   		return mana_ib_destroy_qp_raw(qp, udata);
> -
> +	case IB_QPT_RC:
> +		return mana_ib_destroy_rc_qp(qp, udata);
>   	default:
>   		ibdev_dbg(ibqp->device, "Unexpected QP type %u\n",
>   			  ibqp->qp_type);
> diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
> index 2c41cc315..45c2df619 100644
> --- a/include/uapi/rdma/mana-abi.h
> +++ b/include/uapi/rdma/mana-abi.h
> @@ -45,6 +45,15 @@ struct mana_ib_create_qp_resp {
>   	__u32 reserved;
>   };
>   
> +struct mana_ib_create_rc_qp {
> +	__aligned_u64 queue_buf[4];
> +	__u32 queue_size[4];
> +};
> +
> +struct mana_ib_create_rc_qp_resp {
> +	__u32 queue_id[4];
> +};
> +
>   struct mana_ib_create_wq {
>   	__aligned_u64 wq_buf_addr;
>   	__u32 wq_buf_size;


