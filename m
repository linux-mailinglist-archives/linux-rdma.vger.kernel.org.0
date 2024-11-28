Return-Path: <linux-rdma+bounces-6139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2759DB4B3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445E6B21B79
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3B15535A;
	Thu, 28 Nov 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wv2wOJE2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7147145A11
	for <linux-rdma@vger.kernel.org>; Thu, 28 Nov 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785708; cv=none; b=Q6XfIhEwaTFPtjgvOUN4Ke/Tqb2RYQ3QI9VXOfqCe2KOeLCUChqWNgtY0PSTHzvqCaMvXlKR+At0PE2/dxJZPgtYP98KnyLn7mPQ3Lo2ljWhPzTsA48sFBmTf5fBfaTD5HEAVRJ1rbZNNlK/5iwiwno9d78UHjciOEj2Z4kOAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785708; c=relaxed/simple;
	bh=N8DNgkwqra6DA63OZCYEC8tZLPgK2+BP8874CYOZbJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrbGlfCIkHgy7zIaa48juuCpkLg+lw0JrPW+CSmXD69nloMCPHutbQOwIsFYNNuxoYCDg8hlFeXtBIu/aPgfxHC7vkSF1wQXWwdi0xUfpMFKr2puXhgrmSRps3RpjNWfGnLxA6hO9PeXA7KaUdIEslpUo3OL9ITX0q5DOlWdlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wv2wOJE2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21207f0d949so5223805ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 28 Nov 2024 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732785706; x=1733390506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRY9/nbaetflrw1NbbLkku9KMkAtiSyxcjPtENsmXIQ=;
        b=Wv2wOJE2TUMhy0mVMkhXyfsMk2i4vWNoP1tLECNnSONXOu6KujsdzCqkv0Ycarn3dF
         aAokYBsvTmZzdL4DT1/enMtoYPYIHRGtHIq/qSLWj0WADsCpYsI6dwX+X7ZMthChD0Ug
         87uZM7G+4M6Zp8uet6rDEQNLQ9JbRuFzFYSB3VoOVfA30mWjttVV8ntEHXToywDciWNC
         GuXOrJf128mHGOidSkf8tuc1aqHAM7/NPWFSjQjvSOAT3zDOn5hOgFOrFFGxpGfPp82z
         cwnn63PFyfPy6xxPuiuQu4lquR+pWSvcXNYoXXPvpoodqjw06DklTGz0IRvzVtR7IlA7
         K8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732785706; x=1733390506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CRY9/nbaetflrw1NbbLkku9KMkAtiSyxcjPtENsmXIQ=;
        b=ZH4XeZi6BoY2z1fwK4ZCxJuj+obE0UQWDvrzptiMVkQC+UXGGz+dipLgn5MkMvLVJp
         8/owQY0wZ47Q5Bc/c3/hUo4fNzH4OzBAqpyDVPSiWipQbMIX6G9/TJgG6TaUOTd5Zufq
         ixnYa9/rP5/WoQiAYHoFEzy7wLI9CwP7faoWuLs6KXZvEylpYADmGGj2D7lFhZWsybUJ
         GVqCBt7y9DZVqr0Exclo++WZEHtYXe+uvZh2ZTMHnnqGC0kxwKv3PyPoOlq6R+l+GjX9
         rIDWAfR84xsQyOS7RwxYabwwaL+fXMIqfLCrbKdVW05HlrIqWG4zQTTPPl5MwcIWefdW
         Usug==
X-Forwarded-Encrypted: i=1; AJvYcCWX1kACrsP4G+xhBMnEqI3TLYHP69WqbJntLok+ZehhP0D1Rq4nQ2kYNGalfW6pAI5EBQjOPONnVG5J@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/xnoseDzkcDXDMKDqZzCmDYMqg0kUJj1YFVG5m9wsrRC+0xq
	taT3j6wSpl4P1L37xQvoDSj7Go6ZC3+FRu8N7lpqi6SUfhSAhnNhLkx8XH5eNvIKZDgsh0a5azC
	mhYFnZEjt
X-Gm-Gg: ASbGnct4if6Rp7bEIvxrujsk2Dn0Lo1DsfI9YJ6uJYQiPCVPCd1V9Z2EdtKx+d8LjLr
	Z2sLg40Li0VnVLM36t5tQvevenhxGJvPFwCJtUdyMzfZFdpxmKjc149OZ5mgZqnDY9fyO8fkCgD
	fVLToxD7ietZaCfjBHHmleG4WhwYoDBvB3MjWhuKOOB+hRaN8/LmCkdQcw4Gnll/g/80GFdAIaG
	ne26R9cexGpZK2hx5H2iKA3iAeT6kVRfr6UcnSL2Wg+ghYgVRIzcyIQg1klj3MVglPPPqVQckBO
	6d3b5aTpEbIsS/DRgQ==
X-Google-Smtp-Source: AGHT+IHXpaWB/WdBRJZ1WOYTG6gxa8Iy7jHZIHIxO39imryAFyaZS8pc21WRztC0LBP2MEq1f6NUhw==
X-Received: by 2002:a17:902:d2c5:b0:212:4d01:d43a with SMTP id d9443c01a7336-21501d5d3c8mr99415995ad.48.1732785705916;
        Thu, 28 Nov 2024 01:21:45 -0800 (PST)
Received: from [10.88.242.212] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521967acasm9148085ad.133.2024.11.28.01.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 01:21:45 -0800 (PST)
Message-ID: <ab960175-d1f8-402e-9200-d47a7761315c@bytedance.com>
Date: Thu, 28 Nov 2024 17:21:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/core: Fix IPv6 loopback dst MAC address lookup logic
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241110123532.37831-1-yuezelong@bytedance.com>
 <b044faad-1e3f-4c65-b2e6-fc418aebd22e@bytedance.com>
 <20241121135332.GB773835@ziepe.ca>
From: Zelong Yue <yuezelong@bytedance.com>
In-Reply-To: <20241121135332.GB773835@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/21/24 9:53 PM, Jason Gunthorpe wrote:
> On Thu, Nov 21, 2024 at 05:22:36PM +0800, Zelong Yue wrote:
>> Gently ping. Do I need to provide more detailed information on how to
>> reproduce the issue?
>>
>> On 11/10/24 8:35 PM, yuezelong wrote:
>>> Imagine we have two RNICs on a single machine, named eth1 and eth2, with
>>>
>>> - IPv4 addresses: 192.168.1.2, 192.168.1.3
>>> - IPv6 addresses (scope global): fdbd::beef:2, fdbd::beef:3
>>> - MAC addresses: 11:11:11:11:11:02, 11:11:11:11:11:03,
>>>
>>> they all connnected to a gateway with MAC address 22:22:22:22:22:02.
>>>
>>> If we want to setup connections between these two RNICs, with RC QP, we
>>> would go through `rdma_resolve_ip` for looking up dst MAC addresses. The
>>> procedure it's the same as using command
>>>
>>> `ip route get dst_addr from src_addr oif src_dev`
>>>
>>> In IPv4 scenario, you would likely get
>>>
>>> ```
>>> $ ip route get 192.168.1.2 from 192.168.1.3 oif eth2
>>>
>>> 192.168.1.2 from 192.168.1.3 via 192.168.1.1 dev eth2 ...
>>> ```
>>>
>>> Looks reasonable as it would go through the gateway.
>>>
>>> But in IPv6 scenario, you would likely get
>>>
>>> ```
>>> $ ip route get fdbd::beef:2 from fdbd::beef:3 oif eth2
>>>
>>> local fdbd::beef:2 from fdbd::beed:3 dev lo table local proto kernel src fdbd::beef:2 metric 0 pref medium
>>> ```
>>>
>>> This would lead to the RDMA route lookup procedure filling the dst MAC
>>> address with src net device's MAC address (11:11:11:11:11:03),  but
>>> filling the dst IP address with dst net device's IPv6 address
>>> (fdbd::beef:2), src net device would drop this packet, and we would fail
>>> to setup the connection.
>>>
>>> To make setting up loopback connections like this possible, we need to
>>> send packets to the gateway and let the gateway send it back (actually,
>>> the IPv4 lookup result would lead to this, so there is no problem in IPv4
>>> scenario), so we need to adjust current lookup procedure, if we find out
>>> the src device and dst device is on the same machine (same namespace),
>>> we need to send the packets to the gateway instead of the src device
>>> itself.
> We can't just override the routing like this, if you want that kind of
> routing you need to setup the routing table to deliver it. For ipv4
> these configurations almost always come with policy routing
> configurations that avoid returning lo as a route. I assume ipv6 is
> the same.
>
Thank you for the feedback, Jason. It's absolutely right that we need 
policy routing.
Let me clarify our findings:

We've successfully configured IPv4 policy routing to avoid 'lo', but the 
IPv6 scenario
has proven more challenging. While we found a way to make IPv6 RDMA 
loopback work through
policy routing, it comes with significant constraints:

1. IPv6 addresses must be in the same subnet
2. The 'local' routing table must have lower priority than our custom 
policy routes
3. When IPv6 addresses are in different subnets, enabling RDMA loopback 
breaks TCP loopback
    functionality unless packet forwarding is enabled (which isn't 
feasible in our DC
    environment). We're still investigating a more elegant solution that 
wouldn't require
    packet forwarding or impact TCP loopback functionality.

Given that RDMA loopback has different requirements from TCP/UDP 
loopback, maybe they
should follow distinct routing logic.

> I'm not sure why your ipv4 example doesn't use lo either, by default
> it should have. It suggests to me there is alread some routing
> overrides present.
>
> Jason

