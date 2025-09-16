Return-Path: <linux-rdma+bounces-13393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23EBB58F60
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 09:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947631BC2225
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 07:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B852EA476;
	Tue, 16 Sep 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz2x5It+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA722E9EC0
	for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008454; cv=none; b=SivZJKtfNn48F8JBYp329jEpIFh+05fghn3RkaUb7x4H4rGoi1cEkd7rnh2ZOVaHV/zrvbI12bQ8eESNOcI+2ynmpBtVQH43mgB/RlF12wrykZSzMyEePPBYD1fhrdBp2shmX/rrERjjnRGw86hLRuifXLucxdi44RsWfF6qioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008454; c=relaxed/simple;
	bh=GjEkDyLTh7ZDdDZihLiAf2k7iEwy4dac/0RvjEj6FR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLS92Va2hGuLP+J8tHJ4qO5m+NMqIV+d7B57b0dBbDkOd/BeUGaa9L2Z0ohq0l1Jm6eqY6P3snd+Wn9Qr4kahijxVO1DorttHcKRUCWksoP7X2hk0SUqtesPjHqcHEbBrI/Xu/xPyQ4Mbw/GTB00FJMnl0WH0+ErVRfDr6iyLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jz2x5It+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758008451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XC6jQUydWZva3M5eCBceendVdHRZfWZngDNic1d6Rk=;
	b=Jz2x5It+yK0bAp8xGMYqBnImMwowbOxv1CateLdnrky63F23J+AMqYnDXtfJs6BwW7qBbJ
	dvU3eWIwVg8qhew61jYKbDf3ZhkZKr6JWmunw9GXhM4lxFH0KrdOq7LPQurCav3yA1DQrU
	Jmrb1btiIPn2taIwxFAoCnp94ALL5e8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-olEvKvCHPOm-qrNIeRqW7Q-1; Tue, 16 Sep 2025 03:40:48 -0400
X-MC-Unique: olEvKvCHPOm-qrNIeRqW7Q-1
X-Mimecast-MFC-AGG-ID: olEvKvCHPOm-qrNIeRqW7Q_1758008447
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ebbbd9a430so977270f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 00:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008447; x=1758613247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XC6jQUydWZva3M5eCBceendVdHRZfWZngDNic1d6Rk=;
        b=FzytpB5CacNBLerQHQaP08nJFAcL73Z9RDRX3haw9hbCSFYK+VR8KooklZ5bxqsIt4
         Bs75CkKor8EWTUIAsF9qcQaezz0hV1tgCk/l2+3IuEn0p0cxKQRHdGzhH9GKkQXz1KMJ
         RGDxicA4dJwFQFfhCBJRS9a459WKe8jLUNhHCn5PkUqCyTQqKclmR1zuhWxfcyT5lFHO
         aRURJJ/VmQs8IEqGn2y/LpYeiHmvmkjek9BLCMXdZf6BQAX4ealxBzFiooPfac3LbIK6
         E5PaCbBjCgeSwRTZZBx4/o2bwIFQURDXXTQQYeaIiWms4Z9TkSOeKVZ8cENKYbpvLE++
         ZoxA==
X-Forwarded-Encrypted: i=1; AJvYcCXl6QRxx5cs/RaGF7oTeJiAr7gWEIYGUBwAd7opEKvKnezuEwye5B4H1OWjV9jFvJu+KXzr9RaaSZuO@vger.kernel.org
X-Gm-Message-State: AOJu0YzWos4g22sCxDpnyMfzzRSf1ajisnSCDay5crQAVx0qZ42KLOQt
	nXI1lFmpaoMcf3SBrmZAZdMEDsAqQAanl05GlbedmfyrAPyUgIujYDoG92eLA9OcTjtFT4+NnGy
	0W+qNqvRzYRVwq65Vqst+8B7yefZ6Kw7BBuzee/iRz6Gjha0kjLvZ8eI1ltaD0D8=
X-Gm-Gg: ASbGnctuQNEI4aF+VMmGTqPFjVrhbHcONDIEIF9nlogAzqzgLcwSeX69NdRgJlkaKZE
	o/uNcfmE9O2Tm+yNTgy5RBwFSsIFJ1AcX7+8gQnQm7hZN9MQ1dMOwMj+0OuZRIaFZIdlKBQZ1oW
	AE4ZQMfNA0DaoKTreQMlFHKxaNkKKmU2FWEQ4tMzvT8SESbfoc8XY0OaRyYe2cOyB4yFUTR87YD
	d5fdf+ZsF7X5RyFhweSnSLIydQF7FHCufujBwMsCp4oa0TGbjUV1pLCzDoT/18jT0c/YqPevlQC
	lRIfHlHJhR8B5UhKcWr3gT3aafeN9V8wYIUP52OHd0wzQ+HD7vj2owVsnGjEznXJvtqtCX+n6Er
	6Z0g/zN4hN6xd
X-Received: by 2002:a05:6000:290a:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-3e765780a29mr15557504f8f.5.1758008447050;
        Tue, 16 Sep 2025 00:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0GMHGyJ7FIQxjksq4RJy1sc/WZjAzYzFb9xJalmfJ1yzSh00m+77viKw3AXwSQDB7C53Aag==
X-Received: by 2002:a05:6000:290a:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-3e765780a29mr15557462f8f.5.1758008446588;
        Tue, 16 Sep 2025 00:40:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e859a278c1sm13594749f8f.24.2025.09.16.00.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:40:45 -0700 (PDT)
Message-ID: <eda2c052-a917-4d02-becf-2608242d1644@redhat.com>
Date: Tue, 16 Sep 2025 09:40:43 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911194827.844125-5-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 9:48 PM, Alexandra Winter wrote:
> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index ba5e6a2dd2fd..40dd60c1d23f 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config SMC
>  	tristate "SMC socket protocol family"
> -	depends on INET && INFINIBAND
> +	depends on INET && INFINIBAND && DIBS
>  	depends on m || ISM != m
>  	help
>  	  SMC-R provides a "sockets over RDMA" solution making use of

DIBS is tristate, and it looks like SMC build will fail with SMC=y and
DIBS=m. I *think* you additionally need something alike:

	depends on m || DIBS != m
	
/P


