Return-Path: <linux-rdma+bounces-2881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965718FC94C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 12:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D679E1F23C4D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F8191487;
	Wed,  5 Jun 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ3pMLoH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C8191493
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584176; cv=none; b=nRvCtUHpgT7CCMk/w6oaFRCpdEjRK36epN2jJoY9tKCm/84ijnOWwhzTLe9GseirxrMAnMkS14oq/qCoJrYhZmc2Sp5WyPw5RA9tb1yp7AOGL4O4laDBp/EEDhasC2P4Tpi1ZEpJIZE5JDkni9joarqDKnjtDb72NB8c3FWkPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584176; c=relaxed/simple;
	bh=MSMZ3wK3vvFsWytWYLYRKi/YWzUjtDbKLBKyyw1LAUI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=AWWN5er9RMS6XxB3aveEkQrGHgFN71TftpxQolOjZ0jpr5zYrwc8JdBUfjXVWAa8YDh6cMzxkQYgVqNh0Ptz8KcFvVeIwoq75Dk8WzC/5Jhy+M0ATzqS4mzqvzQuiADkm5dCCVE9S4hCxPJKE1Jx6E8lmDky2Yf+DMwmcB9HJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ3pMLoH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42135a45e2aso35366595e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2024 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717584173; x=1718188973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP47OKYMzvMGrMSiEB9F9Jm+VXE6TdqJpa1siJ56Wrs=;
        b=dJ3pMLoHP5UEYU53YN5gQHXD35xlRMuzzMjHAswUGkZuwsvvKlO8l4GeljkO7EjWUK
         jgUYNCgvObts/g8wI+v72P+9PdNrVwawIAufIyjjhdlDf7pYJggf+lhlElQPUHFJPINC
         EuwCHQL8zfI0Nc4xiMiKWcTAuDxVzbspGGR83wADPp3JdmTiFBLMVTyOkm6RqaI9PWO3
         KqpsFT4Fff3xJRQyC1AwSnJZtuiQH0cTqFXiKBYJYd+facZ7DmM+0xKITOQwfGUIUZys
         6WvCB+aFssDMGOQddDdK0PxhXJVfPw8YhAsLFmeIZHvu9pOSygIiWr6ZlWMU7tD80xSk
         nVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717584173; x=1718188973;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP47OKYMzvMGrMSiEB9F9Jm+VXE6TdqJpa1siJ56Wrs=;
        b=aqUNlGk+D1uvOyEKPSAguIpowVsoCM9IPpKZ1z+Gr9b8zyd56Soq2Mqn9ghMV4zVww
         m7qSaIm44swpaCTCnR2Cm8sEVcJOm802bg/Q4B9yGzTOsRc2yeZE4XvONQ6hLAKANxIt
         Hirb6j7pXm1k01U0MCLVJ6YboXfU75lg6TWkfwA1CWtb+P9snMoCFr1xRHAI33iDYsNx
         X7V3Hy6M8E50UqUlCcAQ/3hI57dDxkU3XEz1O1YveFYmSm4KtuxxYpHoz8/5CWDlu8TY
         i0daCfhGke+eMlV7KM+3ebc8QdxzjWboPpVgq4Vx58NqOdT4cp+9ibGlxDG8YExKfist
         zNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0vIfUc1HWoFSx7VkkJ8PRkfwW65XMRCR4thLmqBd/hN6jOtc8fe7II7zJGF85gaSWuQdtBc2BTpHMgwygNu2k3jpaKYSPz5oLyw==
X-Gm-Message-State: AOJu0Yxs+mL71EPspXvf8qQoa9tHixU3fovl01YAHz9oCZ51VmZraK/T
	EoquZ71g4kJpQ0TU9Hb6Y5tCZ0xlas8ioGET9qAFaE00cOu0aH5h
X-Google-Smtp-Source: AGHT+IGumIDYr3ojEageCFIdNbfA3sXOFCLRBEGDOxSb99dM/j/70MpsWNdKs4Ac1jUvKb6VDqTOJA==
X-Received: by 2002:a05:600c:4fd6:b0:420:29dd:84d0 with SMTP id 5b1f17b1804b1-42156351b60mr17026765e9.29.1717584172875;
        Wed, 05 Jun 2024 03:42:52 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813d0a7sm16493505e9.45.2024.06.05.03.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 03:42:52 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <2a8ba947-ccb4-4c33-bc60-7833291eb61f@linux.dev>
Date: Wed, 5 Jun 2024 12:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
 <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
 <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
Content-Language: en-US
In-Reply-To: <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.06.24 22:15, Bart Van Assche wrote:
> On 6/4/24 03:26, Zhu Yanjun wrote:
>>
>> On 04.06.24 09:25, Shinichiro Kawasaki wrote:
>>> As I noted in another thread [1], KASAN slab-use-after-free is 
>>> observed when
>>> I repeat the blktests test case srp/002 with the siw driver [2]. The 
>>> kernel
>>> version was v6.10-rc2. The failure is recreated in stable manner when 
>>> the test
>>> case is repeated around 30 times. It was not observed with the rxe 
>>> driver.
>>>
>>> I think this failure is same as that I reported in Jun/2023 [3]. The 
>>> Call Trace
>>> reported is quite similar. Also, I confirmed that the trial fix patch 
>>> that I
>>> created in Jun/2023 avoided the KASAN failure at srp/002.
>>
>> "the trial fix patch that I created in Jun/2023" that you mentioned is 
>> the commit in the link?
>>
>> https://lore.kernel.org/linux-rdma/20230612054237.1855292-1-shinichiro.kawasaki@wdc.com/
> 
> To me that patch doesn't seem correct. Jason and Leon, is my understanding
> correct that you are the maintainers for the iwcm code? Can you please help
> with reviewing this patch?
> 
> Thanks,
> 
> Bart.
> 
>  From 879ca4e5f9ab8c4ce522b4edc144a3938a2f4afb Mon Sep 17 00:00:00 2001
> From: Bart Van Assche <bvanassche@acm.org>
> Date: Tue, 4 Jun 2024 12:49:44 -0700
> Subject: [PATCH] RDMA/iwcm: Fix a use-after-free related to destroying 
> CM IDs
> 
> iw_conn_req_handler() associates a new struct rdma_id_private (conn_id) 
> with
> an existing struct iw_cm_id (cm_id) as follows:
> 
>          conn_id->cm_id.iw = cm_id;
>          cm_id->context = conn_id;
>          cm_id->cm_handler = cma_iw_handler;
> 
> rdma_destroy_id() frees both the cm_id and the struct rdma_id_private. Make
> sure that cm_work_handler() does not trigger a use-after-free by delaing
> freeing of the struct rdma_id_private until all pending work has finished.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/core/iwcm.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/iwcm.c 
> b/drivers/infiniband/core/iwcm.c
> index d608952c6e8e..ea9dc26bf563 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -368,8 +368,10 @@ EXPORT_SYMBOL(iw_cm_disconnect);
>    *
>    * Clean up all resources associated with the connection and release
>    * the initial reference taken by iw_create_cm_id.
> + *
> + * Returns true if and only if the last cm_id_priv reference has been 
> dropped.
>    */
> -static void destroy_cm_id(struct iw_cm_id *cm_id)
> +static bool destroy_cm_id(struct iw_cm_id *cm_id)

Now the type of destroy_cm_id is changed from void to bool.

>   {
>       struct iwcm_id_private *cm_id_priv;
>       struct ib_qp *qp;
> @@ -439,7 +441,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>           iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
>       }
> 
> -    (void)iwcm_deref_id(cm_id_priv);
> +    return iwcm_deref_id(cm_id_priv);

static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)

The type of iwcm_deref_id is int.

Not sure if we should make iwcm_deref_id and destroy_cm_id have the 
different type or not. We can make them use one of the 2 types: int and 
bool.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   }
> 
>   /*
> @@ -450,7 +452,8 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>    */
>   void iw_destroy_cm_id(struct iw_cm_id *cm_id)
>   {
> -    destroy_cm_id(cm_id);
> +    if (!destroy_cm_id(cm_id))
> +        flush_workqueue(iwcm_wq);
>   }
>   EXPORT_SYMBOL(iw_destroy_cm_id);
> 
> @@ -1031,7 +1034,7 @@ static void cm_work_handler(struct work_struct 
> *_work)
>           if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
>               ret = process_event(cm_id_priv, &levent);
>               if (ret)
> -                destroy_cm_id(&cm_id_priv->id);
> +                WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
>           } else
>               pr_debug("dropping event %d\n", levent.event);
>           if (iwcm_deref_id(cm_id_priv))
> 


