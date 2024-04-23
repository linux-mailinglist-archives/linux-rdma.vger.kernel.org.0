Return-Path: <linux-rdma+bounces-2024-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7E8AEB58
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EBB1C226DE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6CE13C3F1;
	Tue, 23 Apr 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTzUk5Hj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73413CA81
	for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887003; cv=none; b=URCM2ORjYe7kIst8L177SMJxQsixp5JhKZjvjRFLEvuD0mUR7/8PSgGgtdalUN6kCZoXLgiZa/+PmII6QEHNJ1TjHlZJyRkBN69WkhrAK9kzgkZVLNrmoiwTQ9ZRftGSl9vKxSOM5E2Nu5KGIr/kUrCB2mBB+J/1K+1uyFrGV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887003; c=relaxed/simple;
	bh=v1PT5V2VFfOIzHM2b0UI6Kj4hOA6F5PdHj0GbZwm7t4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZKw/7o72nauY/th2pFBge+qh8IFRsc0AicztSX1bZPP4pw55FUXl7q242S3iaVf/EGlIEHLMFJ1yO4yBN/cO45W4QXNAXR1PvrP01PRU7SDcSjRSUZU4L4PgBXpx2D7FnxrGYbhAApKUX8myhUqLnR/Hkev5wW13SYubAh+0tnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTzUk5Hj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso31345055e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Apr 2024 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713886999; x=1714491799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFuDF28RY8gJYKHf8kDrkH8zdRH5gP/Ap9W+QWMQ2eU=;
        b=iTzUk5HjnRB/SoR6LLwN7W1H8gmHaZlNLxj2jldnUbG9WKVOXl+81EgvieCfjQXTLS
         E6HvFMAA1VX43uxQ5KORveLLgAIDSTIheIB6p0/pCVPlj0wzw9ORfOMW8TJPQRj+gZgI
         JGxXiE8rzMxAGggLe1ODrV+1PRKIjx+IRmqvrBkaTDOSQEKbV2yS99dBSoGaoOxJFJzj
         odpJ76sOw8VSBMFh8tN1iJ5itoz9PCdx3f9m4RgD4G7KwF7qPFjuBqF1bd4HEuYnutpo
         /cE1Ajzr0EBgUAwVBqWLJDQAHX/u+zGcgh/pwrgzCIc/4sJhOcKrXF20dOQBCtw2XKHz
         yzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886999; x=1714491799;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFuDF28RY8gJYKHf8kDrkH8zdRH5gP/Ap9W+QWMQ2eU=;
        b=llbzOFDrpH3rdjHq9E2R09Cw5b8IJjaSckok7tcKVkX2N7WCE9sLbWiYZ303xIni0R
         LEn6NbYNQZ99FxGrCI/kKyt0KLHeAWjNXy1+iY9I8WR6VPIXR7lEEwb03NBbvQoOPh1t
         ncE8rZBQYMhFSe9n89NyjveHmEiIUM+teMXnvL9sFBtD8NpvsprLW40LYOTeJHuSbfsr
         QhclrSwaP1sv7MAt/PsejufV/oME602Ba5/99Oh2i8tzR6HRcKmoRZEk9wiVoALpOLo1
         sKOIvasaYjRIvqxpJgaqfhWeuIK71Lqtl9RQO0yAQWtbl0IQJauef+Xpf66HcUgArEuK
         iHMw==
X-Gm-Message-State: AOJu0Yz6nys/Gy+0+apAmBdFUlTjwPEZSNT075f/LrossI33w72NXRfC
	7D66f3Y1L9kCxWfDCQtY4U4wE2/GpIvIf+f74jaWqrJPOsNIA+zB
X-Google-Smtp-Source: AGHT+IFcn4/GVOsEGIi6kDiZ5qJk2Ck0bGRZrc9ItMVVRDQNV1ZvjS4/bH6KVyU/nwPnl16bLxPk+Q==
X-Received: by 2002:a05:600c:4691:b0:417:d4f6:1aa2 with SMTP id p17-20020a05600c469100b00417d4f61aa2mr11761425wmo.4.1713886999289;
        Tue, 23 Apr 2024 08:43:19 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b0041a9a6a2bebsm1807164wmo.1.2024.04.23.08.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:42:58 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <700c19e8-ae4f-42f0-a604-9e33a9a94dd3@linux.dev>
Date: Tue, 23 Apr 2024 17:42:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v2] IB/cma: Define option to set max CM retries
To: Etienne AUJAMES <eaujames@ddn.com>, jgg@ziepe.ca, leon@kernel.org,
 markzhang@nvidia.com, shefty@nvidia.com
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
 "guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>,
 Serguei Smirnov <ssmirnov@whamcloud.com>,
 Cyril Bordage <cbordage@whamcloud.com>
References: <Zh_IGG3chXtjK3Nu@eaujamesDDN>
Content-Language: en-US
In-Reply-To: <Zh_IGG3chXtjK3Nu@eaujamesDDN>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.04.24 15:01, Etienne AUJAMES wrote:
> Define new options in 'rdma_set_option' to override default CM retries
> ("Max CM retries").
> 
> This option can be useful for RoCE networks (no SM) to decrease the
> overall connection timeout with an unreachable node.
> 
> With a default of 15 retries, the CM can take several minutes to
> return an UNREACHABLE event.
> 
> With Infiniband, the SM returns an empty path record for an
> unreachable node (error returned in rdma_resolve_route()). So, the
> application will not send the connection requests.
> 
> Signed-off-by: Etienne AUJAMES <eaujames@ddn.com>
> ---
>   drivers/infiniband/core/cma.c      | 40 +++++++++++++++++++++++++++---
>   drivers/infiniband/core/cma_priv.h |  2 ++
>   drivers/infiniband/core/ucma.c     |  7 ++++++
>   include/rdma/rdma_cm.h             |  3 +++
>   include/uapi/rdma/rdma_user_cm.h   |  3 ++-
>   5 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 1e2cd7c8716e..b6a73c7307ea 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1002,6 +1002,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
>   	id_priv->tos_set = false;
>   	id_priv->timeout_set = false;
>   	id_priv->min_rnr_timer_set = false;
> +	id_priv->max_cm_retries = false;

max_cm_retries is u8 type. Not sure if it is good to set it as false.

Zhu Yanjun

>   	id_priv->gid_type = IB_GID_TYPE_IB;
>   	spin_lock_init(&id_priv->lock);
>   	mutex_init(&id_priv->qp_mutex);
> @@ -2845,6 +2846,38 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
>   }
>   EXPORT_SYMBOL(rdma_set_min_rnr_timer);
>   
> +/**
> + * rdma_set_cm_retries() - Configure CM retries to establish an active
> + *                         connection.
> + * @id: Connection identifier to connect.
> + * @max_cm_retries: 4-bit value defined as "Max CM Retries" REQ field
> + *		    (Table 99 "REQ Message Contents" in the IBTA specification).
> + *
> + * This function should be called before rdma_connect() on active side.
> + * The value will determine the maximum number of times the CM should
> + * resend a connection request or reply (REQ/REP) before giving up (UNREACHABLE
> + * event).
> + *
> + * Return: 0 for success
> + */
> +int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries)
> +{
> +	struct rdma_id_private *id_priv;
> +
> +	/* It is a 4-bit value */
> +	if (max_cm_retries & 0xf0)
> +		return -EINVAL;
> +
> +	id_priv = container_of(id, struct rdma_id_private, id);
> +	mutex_lock(&id_priv->qp_mutex);
> +	id_priv->max_cm_retries = max_cm_retries;
> +	id_priv->max_cm_retries_set = true;
> +	mutex_unlock(&id_priv->qp_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rdma_set_cm_retries);
> +
>   static int route_set_path_rec_inbound(struct cma_work *work,
>   				      struct sa_path_rec *path_rec)
>   {
> @@ -4295,8 +4328,8 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
>   	req.path = id_priv->id.route.path_rec;
>   	req.sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
>   	req.service_id = rdma_get_service_id(&id_priv->id, cma_dst_addr(id_priv));
> -	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
> -	req.max_cm_retries = CMA_MAX_CM_RETRIES;
> +	req.max_cm_retries = id_priv->max_cm_retries_set ?
> +		id_priv->max_cm_retries : CMA_MAX_CM_RETRIES;
>   
>   	trace_cm_send_sidr_req(id_priv);
>   	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
> @@ -4370,7 +4403,8 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
>   	req.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
>   	req.remote_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
>   	req.local_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
> -	req.max_cm_retries = CMA_MAX_CM_RETRIES;
> +	req.max_cm_retries = id_priv->max_cm_retries_set ?
> +		id_priv->max_cm_retries : CMA_MAX_CM_RETRIES;
>   	req.srq = id_priv->srq ? 1 : 0;
>   	req.ece.vendor_id = id_priv->ece.vendor_id;
>   	req.ece.attr_mod = id_priv->ece.attr_mod;
> diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
> index b7354c94cf1b..4c41e5d7e848 100644
> --- a/drivers/infiniband/core/cma_priv.h
> +++ b/drivers/infiniband/core/cma_priv.h
> @@ -95,10 +95,12 @@ struct rdma_id_private {
>   	u8			tos_set:1;
>   	u8                      timeout_set:1;
>   	u8			min_rnr_timer_set:1;
> +	u8			max_cm_retries_set:1;
>   	u8			reuseaddr;
>   	u8			afonly;
>   	u8			timeout;
>   	u8			min_rnr_timer;
> +	u8			max_cm_retries;
>   	u8 used_resolve_ip;
>   	enum ib_gid_type	gid_type;
>   
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 5f5ad8faf86e..27c165de7eff 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1284,6 +1284,13 @@ static int ucma_set_option_id(struct ucma_context *ctx, int optname,
>   		}
>   		ret = rdma_set_ack_timeout(ctx->cm_id, *((u8 *)optval));
>   		break;
> +	case RDMA_OPTION_ID_CM_RETRIES:
> +		if (optlen != sizeof(u8)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		ret = rdma_set_cm_retries(ctx->cm_id, *((u8 *)optval));
> +		break;
>   	default:
>   		ret = -ENOSYS;
>   	}
> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> index 8a8ab2f793ab..1d7404e2d81e 100644
> --- a/include/rdma/rdma_cm.h
> +++ b/include/rdma/rdma_cm.h
> @@ -344,6 +344,9 @@ int rdma_set_afonly(struct rdma_cm_id *id, int afonly);
>   int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout);
>   
>   int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer);
> +
> +int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries);
> +
>    /**
>    * rdma_get_service_id - Return the IB service ID for a specified address.
>    * @id: Communication identifier associated with the address.
> diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
> index 7cea03581f79..f00eb05006b0 100644
> --- a/include/uapi/rdma/rdma_user_cm.h
> +++ b/include/uapi/rdma/rdma_user_cm.h
> @@ -313,7 +313,8 @@ enum {
>   	RDMA_OPTION_ID_TOS	 = 0,
>   	RDMA_OPTION_ID_REUSEADDR = 1,
>   	RDMA_OPTION_ID_AFONLY	 = 2,
> -	RDMA_OPTION_ID_ACK_TIMEOUT = 3
> +	RDMA_OPTION_ID_ACK_TIMEOUT = 3,
> +	RDMA_OPTION_ID_CM_RETRIES = 4,
>   };
>   
>   enum {


