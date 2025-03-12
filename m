Return-Path: <linux-rdma+bounces-8614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E2A5DEC3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 15:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6391894FE3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591B24E001;
	Wed, 12 Mar 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="OvoGhgcA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E580198E8C
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789212; cv=none; b=FhE4RltXK8LP1qR9iwBKUirojeKtWL8LeVQ4d1K8mI5u/szkmWOk6zKvUb75Wpcwy4co/NXu/YhQF67IB/rtSF4sWh/eiKi3vsnFf52+IZ7CvhIL359pIfHgcESPvW1D8U51EVopQBNLdZ97DdgxjIHnnyf9OS0EILK/lyU9ybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789212; c=relaxed/simple;
	bh=d36XfEjHsb/LASvwjZhgKztn+JaRVGnRgzRhjuVi9n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/dO73ml2Uf6eKCb+3NO854uBy+MpSMj9yLhlkvtN4tvbmBFHRuyseEPuizEokqrcF/G71a55cMlFtemaOFRan7cjRWJcm+GsS71n4avkK0CMca5Wmt90kY0X1wbkFloO1jutl5/0KER/mntS68UpoIGf+3hduyyEyaEYFPdX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=OvoGhgcA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3c4ff7d31so781582285a.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741789210; x=1742394010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxjEW2IK1lZmdC3Aka9pG0G7KKs2I3DMM01JAI0Qo+M=;
        b=OvoGhgcAh7P0ADiuB1b6XPjEexSmI7Hxr6KuyHS7LkZ4h2NpQSJ60vypNLLfk5j665
         MVhRV+5Qi71E5H1op3C40uWhdTp1Kj0NeoMifX05vIXyCsmYe7UCU472LWcTKwX5zvFz
         dlEW8ii6xlPDxPDOMRs5iGheCZMYL0/Sr3lf21qSGyicJteRM4GbKuQpTav+YJz9fnOa
         afPBJcu0zcR30rdJX66svwNseg+F1dsZcDKPvcamHy1rCGGGusbfsGOyWrhgP5RF+nL6
         BT6tcFqPcwj67tbO4zcMUXSOzDq1IRmDk8s37hWTrsqopG0AS83Kol7coXgQYuMJpnYS
         Xmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789210; x=1742394010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxjEW2IK1lZmdC3Aka9pG0G7KKs2I3DMM01JAI0Qo+M=;
        b=pf3TKXWxNZ5GGJa6uh2DZqRc3oPapco5tIKiKpuEKsU5wIaDF9MxzE62zaxKRq+7hN
         afFld1AV7VD9UxLzqUBShFOMFfPyPK/r91/0ByPlhcMHZ/vYcEg1K0vfWCrblyhrhWky
         Rgl8ge/hfUFJV71oRdJYmNZawGNNLIjf8rf3IMstBzxnHGrccBNrgoZzhKVo44h5sUJh
         436yoOmFDcMpPQrgHJyEb/P0vYu9SKYGAs0G1qyqkRpIXKXRNV07TTiW7nOqjiWMWQ0u
         uVjV8YrJgabAc2vplHYSk1spaVAXuAyTGVVdsMN5NoYYXHkUj7GwNayEthfTKQdPsmVV
         bx3w==
X-Forwarded-Encrypted: i=1; AJvYcCV7r+t/FwQc+4P4HHkrZVVO3bQkL/fEvXlSCh8nStofx2eEGnSuQEu7/b927s9Yhy/QY3dw3cysReSH@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHIViqwZ6bWTXyJbqyYHUQid1qjzOGOAynslrdvP5ayFShFmp
	vYFqKUHwp6WwqFl/9s94+njAFMLv4PCJOz4joLJJ9tdY0pSqXpru+TwgsBQIPAmik9Jf941w54J
	CT7s=
X-Gm-Gg: ASbGnctutaPnhFsfD9OL/ol/M26d3mdCL9yvy9J+E0OvfoFDyw8r233otT6r5SbPPyQ
	Uwd/EjPJMhQBgBDN0WuJNkBJgXPThpgP2X+FghwPxkgpdqMVdSKIWuWrFNE38puJ/fIwEKAESIY
	VFnRt0ty19V0ZOiGKSPNOcYniZvs0N+tKZQNEUmywYSGXkyAvOT1gEphHsrfaRLT4FUpi0Tp4S8
	LE4xwfGNQEslrRnPLQt2LEsmx96bnkVTTU4q1HZ8BnxjXzrZ4obbfqVnsEPv/2g6GP3W9VrSz+O
	zWo4Wb0rBjm2TTkM/mtW+NAOzcabk3BUJXbUQGyQ96ATmYLTZ/Gb
X-Google-Smtp-Source: AGHT+IE9rBvVo4fWQGgmfzUj48CSmR8hVtF8QFZrxBGYAeYwyU2dpXL8gA/GGMkix24jg6jxPXvkxQ==
X-Received: by 2002:a05:620a:6410:b0:7c5:6e5d:301d with SMTP id af79cd13be357-7c56e5d30a8mr268787385a.1.1741789210067;
        Wed, 12 Mar 2025 07:20:10 -0700 (PDT)
Received: from [172.19.251.166] ([195.29.54.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a028sm9659269a12.50.2025.03.12.07.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 07:20:09 -0700 (PDT)
Message-ID: <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
Date: Wed, 12 Mar 2025 16:20:08 +0200
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
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <20250312112921.GA1322339@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
>> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
>>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
[snip]
>> Also we have the ephemeral PDC connections>> that come and go as
needed. There more such objects coming with more
>> state, configuration and lifecycle management. That is why we added a
>> separate netlink family to cleanly manage them without trying to fit
>> a square peg in a round hole so to speak.
> 
> Yeah, I saw that you are planning to use netlink to manage objects,
> which is very questionable. It is slow, unreliable, requires sockets,
> needs more parsing logic e.t.c
> 
> To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> fits better for object configurations.
> 
> Thanks

We'd definitely like to keep using netlink for control path object
management. Also please note we're talking about genetlink family. It is
fast and reliable enough for us, very easily extensible,
has a nice precise object definition with policies to enforce various
limitations, has extensive tooling (e.g. ynl), communication can be
monitored in realtime for debugging (e.g. nlmon), has a nice human
readable error reporting, gives the ability to easily dump large object
groups with filters applied, YAML family definitions and so on.
Having sockets or parsing are not issues.

Cheers,
 Nik



