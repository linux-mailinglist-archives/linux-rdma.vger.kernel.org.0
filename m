Return-Path: <linux-rdma+bounces-8600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42FA5D9B5
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C340176BF7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC323BD18;
	Wed, 12 Mar 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="dQzQJwpY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241ED23BCF7
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772410; cv=none; b=bBT9rEAtjahfDeww//sYcj0Uj0BBuA9XwJQI4T8CU1YWe9Kz+a3r2BzK6bLMcXYU7aOAdem08t2Iz+OgrLdjHTANrVURiAYiTjvWTY4iSyEA63/hYrGszsDybR5RATJUQZZDBQlZ3dgzcPi/bhzloJFsh0KF/KtRgRqxCaSPyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772410; c=relaxed/simple;
	bh=2dfhfOYEZya2F/+8TXgINOUG/sPDfgWSkt185LIIP64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDaudRhGdJEUyuj3p3WuIWXTlaKIWo35s3ob0PvFdzMsFx9yasMFUSmnlcX7QlRWUgcL8evWOLqfpt5797IOoTOjdkpY4XZ9CLMYEHTP56k5aPsAkXj29bHp5ocIvQeTVCj5Au/Y7BM784TCQNLxeYsVy3s/tc7PZfDu1f65p6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=dQzQJwpY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47688ae873fso32287001cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741772408; x=1742377208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udjj9fCl9LBtiIbmOdyvcIwBX67qERUexr1e4MBTcnM=;
        b=dQzQJwpY3EeKT8Empz3/22mps+rvNL4hSkdtlY7Mm4m/aO1MU60Fl/2NQByT14owj/
         7PZvim3p8xqwk74L+rMQNvIiHYNpsrq9wLLES/yhBPVJQ4nh2VaWYmtHZjiKEEsN5G82
         qK9MPxfSTI9Efi5ezknpKPnvfSAFtQKqbcoNw9TETVH6BbKPT6ESL3Q3WZ0rj9QCXE8M
         cDPobMnleWLRaIf1e9KptZYXIHwAKYrXunvzWYTEWkudchaJgAhXC1Nz0ijgFYs2WwyQ
         ipXaf4vSwmTzJCzUv2JSCrq3KG6+lPCC5I+EX3e8gXKaTdgjSAWSgja1lT8UZd42N0rA
         Hnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741772408; x=1742377208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udjj9fCl9LBtiIbmOdyvcIwBX67qERUexr1e4MBTcnM=;
        b=eOTyfsS/Fv/7xHzciHxlZvGkWSgaA+TCzz8mFLpvy0jJPCnYGiglAKO5uBGICc13hW
         wrLCIzwdgC1OPGsSqB+NBP8/kPZ3FphOgsAechNSeElx7jNWOlY1bsgzO6IURqJJ0N3+
         0fYp5bJYd/G+fEe/kGTzWnBts69g8ND2IJcYjcGmK9Sh7UTfo1AmUVYQSWkx9bpOJnDQ
         TyeznJE/dYVG1WALDO1qkDrMgTO5OfCUbKmx4hPPwfhierrHZfgcvS+WIrLEE9Mdytbu
         BkfX1sNqfbEfcRakzkWtRU5X98FPITxUvHoM8UVoRo5DV1NAYYgAhf1znLs3ghs6tCNj
         OAyw==
X-Forwarded-Encrypted: i=1; AJvYcCUw0lpFhX42xWUIKg/StglbVC9xFNmtcmdzp1OjsQG/rSv/GDMgbocus4JTBMAbQzCvSS2e+KcTESb9@vger.kernel.org
X-Gm-Message-State: AOJu0YwCyNrg5MrBi+pXwgNWJ1SUfvAatrXKedJVI4ilgoasW+H/o0jp
	rAcI1BZ0p+ZKcboO+SiE1xVHCJWQl3kx9kNfH8MKTErlEWOzU9QgpnJZgcY97C4=
X-Gm-Gg: ASbGnctA1tGdamdAMS71ybKG+yWS5lF9w/HJ+wrrpvoNm8kqRxQpjAn5Cp9QBHkoZ5v
	LZfmYDr3C02WmHquU2q7hRWWEBwhI+GpqAVz4NzOItXodvSRV8B4zC6sCLSRe+tGQzAQGWka9s8
	DIOpoZPgFVCiaNL9ny/qurgquUXSXhNWEz7icDa0muleT9D7sw+MiHd1KzCQyQP0tfSkvIh/aZ+
	0MTA77mSPwqQkTZoT0TAl3Tezrry17mUf1e86IHcZ8R9wztF8RBimM0O2VgWpvfTlpBJkSMsWET
	TKjgXhmsxZRCqeMb9UPjZQVJ41whw8T8WzoD0WcLyTT0sFMWPGDO
X-Google-Smtp-Source: AGHT+IFZF4mdG/bEmIMD8dAADQJR8NHoCAL3S+neVFwZEscYnba7g81wnhrW7ciHRjjCuTX7gr/vOw==
X-Received: by 2002:a05:6214:226f:b0:6e4:4331:aae0 with SMTP id 6a1803df08f44-6e9005b6680mr265863526d6.1.1741772407942;
        Wed, 12 Mar 2025 02:40:07 -0700 (PDT)
Received: from [172.19.251.166] ([195.29.54.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f8aasm9486244a12.5.2025.03.12.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 02:40:07 -0700 (PDT)
Message-ID: <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
Date: Wed, 12 Mar 2025 11:40:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, shrijeet@enfabrica.net, alex.badea@keysight.com,
 eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
 bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
 dan.mihailescu@keysight.com, kheib@redhat.com, parth.v.parikh@keysight.com,
 davem@redhat.com, ian.ziemba@hpe.com, andrew.tauferner@cornelisnetworks.com,
 welch@hpe.com, rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
 linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <20250308184650.GV1955273@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
>> Hi all,
> 
> <...>
> 
>> Ultra Ethernet is a new RDMA transport.
> > Awesome, and now please explain why new subsystem is needed when
> drivers/infiniband already supports at least 5 different RDMA
> transports (OmniPath, iWARP, Infiniband, RoCE v1 and RoCE v2).
> 

As Bernard commented, we're not trying to add a new subsystem, but
start a discussion on where UEC should live because it has multiple
objects and semantics that don't map well to the  current
infrastructure. For example from this set - managing contexts, jobs and
fabric endpoints. Also we have the ephemeral PDC connections
that come and go as needed. There more such objects coming with more
state, configuration and lifecycle management. That is why we added a
separate netlink family to cleanly manage them without trying to fit
a square peg in a round hole so to speak. In the next version I'll make
sure to expand much more on this topic. By the way I believe Sean is
working on the verbs mapping for parts of UEC, he can probably also
share more details.
We definitely want to re-use as much as possible from the current
infrastructure, noone is trying to reinvent the wheel.

> Maybe after this discussion it will be very clear that new subsystem
> is needed, but at least it needs to be stated clearly.
> 
> An please CC RDMA maintainers to any Ultra Ethernet related discussions
> as it is more RDMA than Ethernet.
> 

Of course it's RDMA, that's stated in the first few sentences, I made a
mistake with the "To", but I did add linux-rdma@ to the recipient list.
I'll make sure to also add the rdma maintainers personally for the next
version and change the "to".

> Thanks

Cheers,
 Nik


