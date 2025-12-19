Return-Path: <linux-rdma+bounces-15106-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFECCD01B5
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74AFC3009486
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2969330EF80;
	Fri, 19 Dec 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="IB/fASHN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85ABBA45
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766151944; cv=none; b=d7y3sQrdxtQshI2krFgiUo8bLJXFpef5ZucBL7ztDIFP0mceW2W4z1uTDwZYClO1zVqc/xl7wbtIyvkEH3I+emv/2eolKHyH9Z343rsaKsTiX16dypTRoZ4Q6jdHeg1SDYptlNVXe9d9CKbjpN9XVELeT2aaFGXKukVZ+AMaJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766151944; c=relaxed/simple;
	bh=+r5QFRBb0peoYxYIfHdasLzLbceBX2iot/TtIQikiAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG/c9G/LlHtvTAghJvqqlVOcXiRkEt6h7UlX4zDrRbhn/MrITe2ApoRpg2PD7iFDP5jQp8KuSB4aTjBTfjqV1S3PS174s+zk5OeodNt9PHYgc2zAlnX6UKVPTsQ0n1fSxn8wWgtmFlyNi5+NfN949c9DwgUTUzmYwkttSSI8WoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=IB/fASHN; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=uSrpppImmQ5UlZBXnV0/tYsMdFnYHfXKb4Y4aYjH1pU=; b=IB/fASHNmCV3Kg4fKqI7pEdixx
	VUAlsBvNxWcbsb2gWtgULrWIhRPIAgazIXU2n9SRkevKtM0HUxoxulpx9n9nE3K9IX3akRP3gND8M
	1Qs90CT3MnOZsprFaBJNBNhRgC5oKV+7hmmpZQQ4HPzrkoqShPXudtVzrJ5QL02ShUrxfMzenNU9p
	jmaic2V+JoDjwbZs5HOAdZYtGmE44G9g+93NxK2nPKkA4WDORUS0+Mtpu6IcIuqgA6/n6BfqReOq5
	n/8890YOGZ+k0KkizWzaHyyBoutWN39a6jSUfBEQnFsjueS1dkV2mQ1oki6skwy36opyyODyp6+Ir
	yrYQD7i35OOC01mO7bp1dZVMLgzlQxph/YcpEY6f2WiOTLDxUuCiQleM0xY/KQMwM8y/5w192o5zm
	LmF2YL53cpCa6Vn/EhQe8S6Tn/iCkKQ8v41IVCaMJz8Qa4Kzlnxgks/izhwq5OI/k/o2skEvnvzkM
	tbMZjIx93YVXu5Wy1okxHvJ8;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vWanX-001MjL-0k;
	Fri, 19 Dec 2025 13:45:35 +0000
Message-ID: <7affc986-1378-4257-bac6-cd0be4e2f5c8@samba.org>
Date: Fri, 19 Dec 2025 14:45:34 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] rdma_rxe module unload failure with DEBUG_LOCK_ALLOC
 enabled
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
References: <170e3191-7e15-4af8-948f-14904fe260cc@wdc.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <170e3191-7e15-4af8-948f-14904fe260cc@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shinichiro,

> While I evaluate v6.19-rc1 kernel, I found that rdma_rxe module unload fails.
> The failure can be recreated by simple two commands below:
> 
>     $ sudo modprobe rdma_rxe
>     $ sudo modprobe -r rdma_rxe
>     modprobe: FATAL: Module rdma_rxe is in use.
> 
> I bisected and found the trigger commit is this:
> 
>     80a85a771deb ("RDMA/rxe: reclassify sockets in order to avoid false positives from lockdep")
> 
> This commit changes the driver behavior when the kconfig DEBUG_LOCK_ALLOC is
> enabled, and my kconfig does so.
> 
> Actions for fix will be appreciated.

I have a fix for this, see:
https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=7f55eb3373dca97b706e8521705a06d4bf84b0f0

I'll post it to the list later today.

Sorry for the trouble!
metze

