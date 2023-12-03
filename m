Return-Path: <linux-rdma+bounces-183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F08C80222D
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E77F1F20F55
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A36FB9;
	Sun,  3 Dec 2023 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZYSaXAq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269ACD
	for <linux-rdma@vger.kernel.org>; Sun,  3 Dec 2023 01:15:38 -0800 (PST)
Message-ID: <1d9842b1-76b1-636d-cb71-87d2becf552c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701594935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZuFEVGZeVZAulyZzSnoDuiiGMju7wOvAj1PIpgzQ3Q=;
	b=IZYSaXAqPTAYUizsVmmf0a4W65rCFZoGXVii8Owq+Mgw4d/f0R+vsTvDh622CUgtZt+Cgc
	ohRUMv8pFstEqlwa5orJnF8svKRcdLryjXKS1dgyQo1oOllxpf5VE3Wh88EFI/p7RHjExx
	eJzo3okRGSEdTEEenqbEQbkQDklqmt0=
Date: Sun, 3 Dec 2023 17:15:03 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] RDMA/siw: Call orq_get_current if possible
To: Bernard Metzler <BMT@zurich.ibm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "leon@kernel.org" <leon@kernel.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
 <20231129032418.26705-5-guoqing.jiang@linux.dev>
 <BY5PR15MB3602DEB9CA3010A31907C67D9981A@BY5PR15MB3602.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <BY5PR15MB3602DEB9CA3010A31907C67D9981A@BY5PR15MB3602.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/1/23 23:47, Bernard Metzler wrote:
>
>> -----Original Message-----
>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Sent: Wednesday, November 29, 2023 4:24 AM
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
>> Cc: linux-rdma@vger.kernel.org; guoqing.jiang@linux.dev
>> Subject: [EXTERNAL] [PATCH 4/4] RDMA/siw: Call orq_get_current if possible
>>
>> We can call it in siw_orq_empty.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw.h
>> b/drivers/infiniband/sw/siw/siw.h
>> index 2edba2a864bb..75253f2b3e3d 100644
>> --- a/drivers/infiniband/sw/siw/siw.h
>> +++ b/drivers/infiniband/sw/siw/siw.h
>> @@ -657,7 +657,7 @@ static inline struct siw_sqe *orq_get_free(struct
>> siw_qp *qp)
>>
>>   static inline int siw_orq_empty(struct siw_qp *qp)
>>   {
>> -	return qp->orq[qp->orq_get % qp->attrs.orq_size].flags == 0 ? 1 : 0;
>> +	return orq_get_current(qp)->flags == 0 ? 1 : 0;
>>   }
>>
>>   static inline struct siw_sqe *irq_alloc_free(struct siw_qp *qp)
>> --
>> 2.35.3
> Please change the commit message. Something like
> 'Use orq_get_current() in siw_orq_empty()'.

Ok, will do.

> Otherwise looks good!
>
> Acked-by: Bernard Metzler <bmt@zurich.ibm.com>

Thanks for your review!

Guoqing

