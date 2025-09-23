Return-Path: <linux-rdma+bounces-13590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72AB95281
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 11:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D72E5798
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4025320CAC;
	Tue, 23 Sep 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys92Rp9v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF54320A1D
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618573; cv=none; b=B2vp78+ezYvMFYAIvJvHZsrkdlP6O2Ejw+HPWqCchagG/IowauG+Be0673oQijE5XwEMdSrw2ebMywu38OSakpX3xbxkg25n8lu3EKoqnxA5aAF/maowqlVCg8jqydFZENTyzK9THuP/yDK48HWRyI9kThoVT8c1yRJcVAK4c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618573; c=relaxed/simple;
	bh=wLVoGbMjHEEU5mMoyG82PjioU0/lNcciOqJIt/sYfog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj/S+vG82Q3/qRxRDJP9Y+XtDcii56C5KKduppnpDGCsfej+MaTD/cBsX+qAUpAZ41QjGqfcfUQWYgMZlLhcyWGitA75PAwZCz4sLLBjc+w4VwCnRzYXHiIh53fu1S+XkmI1k1pvTkMHqxIyfRlimWIHEPzpONBfh4c6fnKGG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ys92Rp9v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758618570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvjnjFcm0RtjMmGMf5UkMcwY2Aol25xIkMv4rlwpYQI=;
	b=Ys92Rp9vbQmzPxHhaeE40Q/8DxG7cHcjE/1fNnBlAlGGpEqPhGID1T1OLZ4pc1n9/Bdkx+
	J3AAuB74b4rRukQUc3JHNj2zcnJEcePitCl1gyfCSkOSCPLPaIPZcTKytsRXcR70lfYkur
	bzF9DRilBK1UvOckWsvptcUpWmPYmHI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-MntH_G8aPrmXsZwJ33By8A-1; Tue, 23 Sep 2025 05:09:28 -0400
X-MC-Unique: MntH_G8aPrmXsZwJ33By8A-1
X-Mimecast-MFC-AGG-ID: MntH_G8aPrmXsZwJ33By8A_1758618568
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so1629540f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 02:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618568; x=1759223368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvjnjFcm0RtjMmGMf5UkMcwY2Aol25xIkMv4rlwpYQI=;
        b=dszRDR38QFXTEjm9+e7gYkOHzKGttbVqAGzdpSCjACxWoM6SSZideTTfju9YZcUP+O
         QGPWiFq3VzG2ZEyxFDsS3kBrGlw4Qog+tqGUqcBWEwB5sSCVyS8DndNo0JSdBO6Szs38
         nr5dApRcegTh4l4dPt8/Sj2W0tXmigys3whYU9pQJPast+RLOsVMmjz42x3sSQlOodj/
         0sU4DoY7Fwx9ZN3smUrfGptv+xHWXKPav/5Vlg6VVbOWElSq+FMtl7Hld4BG+NNHJ91s
         AR1Ht7R0fuIibNZBGinG4maeGflIT2SngLuwftvTwNsJgMhH51hceTrmUyU5QdPn5Qid
         r1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWKUqGDDmUcAxdITLmZHT085lSfDuCQk5KPQdVIln3rGCbTx6xq3ofJmRJbfkm4iMNJhe6jYF42PKHi@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgLKFMqobplKiR3f/SZG5MI8vWXKwC53G3MsWDrZ6YCGGyxrt
	d5nklwVJjJOrfUGV725v6sHeQF3LY2NvZ4ULY5cryZRF5Un7ACJ8Pm6CE47QhSkWUEpzUYai3Ny
	SPxfmhVvYzslT6ukIzNsCH9q67RcDBCqQ+0ww+qSuORN26/icd0sx3i+EA938jgQ=
X-Gm-Gg: ASbGnct2Tqvt5GGiX3k+4+Z3EaLrTWdEAsrSwFFWhXZUvAE7n1O9dceKC6BQL8Ap9kY
	GaOgbalOCn6gLhlCxL+lfhwz8/0ozt75gjyGau76LTSOJlSzRmS2MRYHNrYmejiN7+dGPfFoEGt
	N+d+AMoo0CK4cAG1LJsiYxj4FS2TCAxoUr2fRAjmvwiEAJN+9nxl+RFLnX7UdHJWv8elY+Fdljg
	1meYI5C6eSju4ENubCmD/3uSg11Lri21OxDeYQ9y7Q1r4Ct/piopTk4Knjchb+JKwzrCm8IHF0J
	yST+EsFJ1R4cUUyZsFMq1qQqaaotz3qVjv8DruNRLIGlkEygAogbWpuFqe5SnnYOpIkdSxUag0m
	8IUNx0SUNQT8G
X-Received: by 2002:a05:6000:1a85:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-405cc33ac0cmr1415191f8f.13.1758618567544;
        Tue, 23 Sep 2025 02:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw0fShgkZVnRNXqun3DQnacnjRxnLgbPH5kDta0TCodIeo80eSQ2lM+5j5xgO2Pt7lz4Uk3w==
X-Received: by 2002:a05:6000:1a85:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-405cc33ac0cmr1415138f8f.13.1758618566921;
        Tue, 23 Sep 2025 02:09:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1dc48378sm8665135e9.8.2025.09.23.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:09:26 -0700 (PDT)
Message-ID: <94bfc71a-178d-435d-b54a-117e8265f532@redhat.com>
Date: Tue, 23 Sep 2025 11:09:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/14] dibs: Register smc as dibs_client
To: Alexandra Winter <wintera@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-5-wintera@linux.ibm.com>
 <eda2c052-a917-4d02-becf-2608242d1644@redhat.com>
 <f785ff05-acfd-4544-84b8-39f0c2d8e5ee@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f785ff05-acfd-4544-84b8-39f0c2d8e5ee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:37 AM, Alexandra Winter wrote:
> On 16.09.25 09:40, Paolo Abeni wrote:
>> On 9/11/25 9:48 PM, Alexandra Winter wrote:
>>> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>>> index ba5e6a2dd2fd..40dd60c1d23f 100644
>>> --- a/net/smc/Kconfig
>>> +++ b/net/smc/Kconfig
>>> @@ -1,7 +1,7 @@
>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>  config SMC
>>>  	tristate "SMC socket protocol family"
>>> -	depends on INET && INFINIBAND
>>> +	depends on INET && INFINIBAND && DIBS
>>>  	depends on m || ISM != m
>>>  	help
>>>  	  SMC-R provides a "sockets over RDMA" solution making use of
>>
>> DIBS is tristate, and it looks like SMC build will fail with SMC=y and
>> DIBS=m. I *think* you additionally need something alike:
>>
>> 	depends on m || DIBS != m
>> 	
>> /P
>>
> 
> 
> My understanding of 'SMC depends on DIBS' is that DIBS has to have
> a higher or equal state than SMC (with y > m > n).

You are right, I got lost in dependency hell, sorry.

LGTM!

/P


