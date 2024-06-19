Return-Path: <linux-rdma+bounces-3299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E87990E68D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453AF1F21F72
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A67BB15;
	Wed, 19 Jun 2024 09:09:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B674770F5
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788155; cv=none; b=EnbMi8XNe/rSdqI3Ey0liJuF0vUBt+6PrdcyPmFkgPtfckMVXN6KNe64iPrTKTVeyQ2ybUBZgE4gpa9+UtER/Nxx7KVcnCBv4k+S7FF/97LDT01tYpDacZ+fRPnkHNPWchzu5nV8RAsNWzvkOLFo4jhDSamoCfS/0xfjecKofDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788155; c=relaxed/simple;
	bh=WMNzIyAt/H9rC6xpqRoTLnQiUTtoGKhusyryCKNoFI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnZViwZ2sODBNMbB4hqYg+Qjuc2dTK/uTNuzyVt9VT09D2K8qhf5XFw+RXs8HbAVzd22pCloOyM5kl53NCLuIeiiTUtaHKYHZFHQtyHbgoTRZe52qhRut02PmY+/1tuWMU5z99joLxXkSq1PCP1vqKp02vkawf5xwjxkMyrD0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaea316481so7705921fa.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 02:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788151; x=1719392951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gza6J2jaZmWLNj09RMdVw66yl8FVHQjujLyaQCc4YZ4=;
        b=dUjcEa5dSw6MkY80dT7mzXeQAGj/xUwysM6u0fH9nC83lAE27sgDICdXbhrkhYUYxO
         vMterq2SFhtyt7cr4lrz4n1YGcUNUjmulVIt63YANQDxUQBFarZjvOYgao4x9O+z2OT4
         Fhp4bxl5rcRW1FXZ6F1h3IJUqlChccZ4gLFbcDn+o4KvqsrybWUh4YrZ8HfYK7suM+5d
         TWlLaYDqiKmTKJL+7KI7EI4nz5TKrWKj3dg0Jo/D6tTMR2L4WTKizQmcHCKnNVZh83Ez
         1nwNPAYDgpVSYxQCnXXKUF3kAgmmp1AJ+9J2TFXEldkCyYN0XEdigwIruUL+VHr5IA0h
         +UQw==
X-Forwarded-Encrypted: i=1; AJvYcCVy2ziA/KyI0xeO3FFnAOtHFbq7rASvYTN3b+IZw0C7l1wYrpxw3bg1BqC7f07qk4VexM4/o3yZANwMC6w2hUtAkr7daqKAzmiGOA==
X-Gm-Message-State: AOJu0Yw5AhXoNafKYwRoYn3HwUukjxodNh7gLoUSs8XW52ljg8FFrqsu
	gs+pZdJuw1md4g9RrNhVrzQ7cCr7oDYRPY8iBrFa6MUO7c1I2RTp
X-Google-Smtp-Source: AGHT+IFs/yVKw+Tezqx4eP51oFbndGSd3kv7nf/zGQVhk8gXf7XoqiLkR4Z+KMeSTY5zlsJ4gJF4UA==
X-Received: by 2002:a2e:3c10:0:b0:2ec:17e6:f9d0 with SMTP id 38308e7fff4ca-2ec3d015449mr10676761fa.5.1718788151166;
        Wed, 19 Jun 2024 02:09:11 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4246b67f0aesm88873305e9.45.2024.06.19.02.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:09:10 -0700 (PDT)
Message-ID: <d12f32f0-ac4a-4bb1-a3e6-a1a606d4f89b@grimberg.me>
Date: Wed, 19 Jun 2024 12:09:09 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/06/2024 3:10, Max Gurtovoy wrote:
> To avoid leakage for QPs assocoated with SRQ, according to IB spec
> (section 10.3.1):
>
> "Note, for QPs that are associated with an SRQ, the Consumer should take
> the QP through the Error State before invoking a Destroy QP or a Modify
> QP to the Reset State. The Consumer may invoke the Destroy QP without
> first performing a Modify QP to the Error State and waiting for the Affiliated
> Asynchronous Last WQE Reached Event. However, if the Consumer
> does not wait for the Affiliated Asynchronous Last WQE Reached Event,
> then WQE and Data Segment leakage may occur. Therefore, it is good
> programming practice to teardown a QP that is associated with an SRQ
> by using the following process:
>   - Put the QP in the Error State;
>   - wait for the Affiliated Asynchronous Last WQE Reached Event;
>   - either:
>     - drain the CQ by invoking the Poll CQ verb and either wait for CQ
>       to be empty or the number of Poll CQ operations has exceeded
>       CQ capacity size; or
>     - post another WR that completes on the same CQ and wait for this
>       WR to return as a WC;
>   - and then invoke a Destroy QP or Reset QP."
>
> Catch the Last WQE Reached Event in the core layer without involving the
> ULP drivers with extra logic during drain and destroy QP flows.
>
> The "Last WQE Reached" event will only be send on the errant QP, for
> signaling that the SRQ flushed all the WQEs that have been dequeued from
> the SRQ for processing by the associated QP.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/infiniband/core/verbs.c | 83 ++++++++++++++++++++++++++++++++-
>   include/rdma/ib_verbs.h         |  2 +
>   2 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 94a7f3b0c71c..9e4df7d40e0c 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1101,6 +1101,16 @@ EXPORT_SYMBOL(ib_destroy_srq_user);
>   
>   /* Queue pairs */
>   
> +static void __ib_qp_event_handler(struct ib_event *event, void *context)
> +{
> +	struct ib_qp *qp = event->element.qp;
> +
> +	if (event->event == IB_EVENT_QP_LAST_WQE_REACHED)
> +		complete(&qp->srq_completion);
> +	else if (qp->registered_event_handler)
> +		qp->registered_event_handler(event, qp->qp_context);

There is no reason what-so-ever to withhold the LAST_WQE_REACHED from 
the ulp.
The ULP may be interested in consuming this event.

This should become:

+static void __ib_qp_event_handler(struct ib_event *event, void *context)
+{
+	struct ib_qp *qp = event->element.qp;
+
+	if (event->event == IB_EVENT_QP_LAST_WQE_REACHED)
+		complete(&qp->srq_completion);
+	if (qp->registered_event_handler)
+		qp->registered_event_handler(event, qp->qp_context);




> +}
> +
>   static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
>   {
>   	struct ib_qp *qp = context;
> @@ -1221,7 +1231,10 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
>   	qp->qp_type = attr->qp_type;
>   	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
>   	qp->srq = attr->srq;
> -	qp->event_handler = attr->event_handler;
> +	if (qp->srq)
> +		init_completion(&qp->srq_completion);

I think that if you unconditionally complete, you should also 
unconditionally initialize.

