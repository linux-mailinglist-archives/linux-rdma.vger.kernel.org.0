Return-Path: <linux-rdma+bounces-735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE183BCFF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6DD1C23D62
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB11B97C;
	Thu, 25 Jan 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s58HA7dq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8EF10A26
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174129; cv=none; b=RFeFdD5edAJFaJLvRoyTOZ7B71xGmpw2MhoI/va54j/bGmDTasjzonyevNNPXD4rllOqi4hJ+MgRGsSZ73rJA/rUwr4/cgGVebJx8UBDkt/PDJNd0hfNnZNpr8aX1XwXAtc3gqGw8EgSbeS1iIpJM6nAjdXB6VV3sPGxvbtGe1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174129; c=relaxed/simple;
	bh=2w1OGbTrgI9I+I1O3B4k7J2KNfEC54g8o923i8QvDHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTA1k/PNhYBSTwWiBXdf+RIkN+rJb3r+U3DrwKOm32RFJ5cw37TbvAco2kFkIvRU4LaAOTc3WRt8cU/KTCX/SPONCYInOKDha1iHvkiRK4nFZNFpoa2B5+ezU1jFoOOFifxmLVmdK833WINvN32FSjWMy0q926OgLIHP00JCJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s58HA7dq; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4496a1e-c7bb-eba3-1095-07b4472786dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706174124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acOsbrvHE1ynlA5zgLwVkqNZMJtUCWVB2ysdelgnevE=;
	b=s58HA7dq5cASUcDdr1nm57gdgAAB7PW1g/vuTiJQNn/5juswsSxnyQqDjJDjsBKsCpbrdn
	szEJq1zWBG00jOB/3umbwKAoVu2Bc8B75f0ioSaqP1YEGrTT4FmJeyCRrsTKjkF3gdEUGe
	HHZyVUr6PxPYtPflZ6wf33W01Eqyz4c=
Date: Thu, 25 Jan 2024 17:15:16 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Trim size of page array to max size needed
To: Bernard Metzler <BMT@zurich.ibm.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
References: <20240119130532.57146-1-bmt@zurich.ibm.com>
 <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
 <BY5PR15MB3602E55D5186E1A241489C8B997B2@BY5PR15MB3602.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <BY5PR15MB3602E55D5186E1A241489C8B997B2@BY5PR15MB3602.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Bernard,

On 1/25/24 03:59, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Sent: Tuesday, January 23, 2024 3:43 AM
>> To: Bernard Metzler <BMT@zurich.ibm.com>; linux-rdma@vger.kernel.org
>> Cc: jgg@ziepe.ca; leon@kernel.org; ionut_n2001@yahoo.com
>> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Trim size of page array to max
>> size needed
>>
>> Hi Bernard,
>>
>> On 1/19/24 21:05, Bernard Metzler wrote:
>>> siw tries sending all parts of an iWarp wire frame in one socket
>>> send operation. If user data can be send without copy, user data
>>> pages for one wire frame are referenced in an fixed size page array.
>>> The size of this array can be made 2 elements smaller, since it
>>> does not reference iWarp header and trailer crc. Trimming
>>> the page array reduces the affected siw_tx_hdt() functions frame
>>> size, staying below 1024 bytes. This avoids the following
>>> compile-time warning:
>>>
>>>    drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
>>>    drivers/infiniband/sw/siw/siw_qp_tx.c:677:1: warning: the frame
>>>    size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> I saw similar warning in my ubuntu 22.04 VM which has below gcc.
>>
>> root@buk:/home/gjiang/linux-mirror# make M=drivers/infiniband/sw/siw/
>> -j16 W=1
>>     CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
>> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
>> drivers/infiniband/sw/siw/siw_qp_tx.c:665:1: warning: the frame size of
>> 1440 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>     665 | }
>>         | ^
>>
> Whew.. that is quite substantially off the target!
> How come different compilers making so much of a difference.
> Guoqing, can you check if the macro computing the maximum number
> of fragments is broken, i.e., computes different values in
> the cases you refer?

Sorry, I was wrong 😅.

The warning is not relevant with compiler, and it also appears with gcc-13.1
after enable KASAN which is used to find out-of-bounds bugs. Also, there
are lots of -Wframe-larger-than warning from other places as well.

> Thanks a lot!
> Bernard
>> # gcc --version
>> gcc (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0
>>
>> And it still appears after apply this patch on top of 6.8-rc1.
>>
>> root@buk:/home/gjiang/linux-mirror# git am
>> ./20240119_bmt_rdma_siw_trim_size_of_page_array_to_max_size_needed.mbx
>> Applying: RDMA/siw: Trim size of page array to max size needed
>> root@buk:/home/gjiang/linux-mirror# make M=drivers/infiniband/sw/siw/
>> -j16 W=1
>>     CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
>> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
>> drivers/infiniband/sw/siw/siw_qp_tx.c:668:1: warning: the frame size of
>> 1408 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>     668 | }
>>         | ^

The patch actually reduced the frame size from 1440 to 1408 though it is
still larger than 1024.

Thanks,
Guoqing


