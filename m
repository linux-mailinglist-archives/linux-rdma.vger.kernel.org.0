Return-Path: <linux-rdma+bounces-8239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B0A4B3AA
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EE216CCF5
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A351E32A3;
	Sun,  2 Mar 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMwnra/9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB21D7995
	for <linux-rdma@vger.kernel.org>; Sun,  2 Mar 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740935173; cv=none; b=sE0/GEaayiQOblIYHHfQC3YFO1ZWc20fs+6uXtfYu2Rf2A/uGk8gFpggaboywG8UK0lHOqrWjcRF3PYpYFG7zSyFLa1f4i3wutkizlDg0Bl6nLfXCPumYnlMIKrn7GQ+uU3Immw/V/GsIeC1xkvs8lK7ftf5/ehyLxA7NHkGgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740935173; c=relaxed/simple;
	bh=hvgSuB44YkK/xPelZYtIpqy2qrlmcfrX0ZvBA6mGNYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1s7Ipv0hDi8kM9HADejcCRBu12/EPFBbGq6zbiWQnFeq3cdXePrdaFrBA3zSSHrmbUH/2M61O86jJF+rnr3aei/s29Wi62Wx9RZ4nbGn8LGW0wmmS13sXb8rpns3Q1rsXhwxM6VYw59qNlzgCxKFJWiqZ58MQFGgX+qa83Sabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMwnra/9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd748914-1add-46b2-ab36-c005518ab4f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740935167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KqmXcWdfznldu3re6yX7gMQIU/KFYrwGBstxKkub3k=;
	b=vMwnra/9stm9hlY8hfSd0x3RwwWWV7UtvSZ2dUuZSdxAUv3EizAm868E9QKpLC7F74Jexw
	C6rVsQhHa0u8cnvZe8RTeK6/eygqdAOy1/2mLAW50xBxgJEhbvZX1h08wMXl/Qui2uIuE+
	aKbBEItHqEqwOfDgmVkz7i/RRSzNCKc=
Date: Sun, 2 Mar 2025 18:05:59 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-upstream 1/1] RDMA/rxe: Replace netdev dev addr with
 raw_gid
To: Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20250301193351.901749-1-yanjun.zhu@linux.dev>
 <20250302123915.GE1539246@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250302123915.GE1539246@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/2 13:39, Leon Romanovsky 写道:
> On Sat, Mar 01, 2025 at 08:33:51PM +0100, Zhu Yanjun wrote:
>> Because TUN device does not have dev_addr, but a gid in rdma is needed,
>> as such, a raw_gid is generated to act as the gid. The similar commit
>> also exists in SIW. This commit learns from the similar commit
>> bad5b6e34ffb ("RDMA/siw: Fabricate a GID on tun and loopback devices")
>> in SIW.
>>
>> Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c       | 20 ++++----------------
>>   drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  4 +++-
>>   3 files changed, 8 insertions(+), 18 deletions(-)
> This patch doesn't apply. It should be based on rdma-rc or rdma-next.

Got you. I will send out a new patch for rdma-rc or rdma-next.

Best Regards,

Zhu Yanjun

>
> Thanks

-- 
Best Regards,
Yanjun.Zhu


