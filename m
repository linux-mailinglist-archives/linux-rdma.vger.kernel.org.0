Return-Path: <linux-rdma+bounces-15110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C47ECD1451
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 19:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E931B3014A0E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F039350A28;
	Fri, 19 Dec 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+JnJKyf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6B350A0A
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167169; cv=none; b=jwdCsWDWKJBcl7ef+L0NWtGDabEc9tTrnBen/hpvoP4nHJc6G26kXdPOE9hf3MIGDDdJM5aNZrLzbjDJSiMJrg8eZJEtjQ44axELGOGOPnIcOVrsigVhNznC/sd+ieHWgnFBYiHPPnBuWgaPMzEWpD+GWrnk69o+qj8TubCB78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167169; c=relaxed/simple;
	bh=Z+75sfAAUbM1hXNU5FIF3FwfZl74/OuVZN+5PVhIKrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQC5Qu5m6uMD8RxdRa2+ZnntVz+jFdQXUrwcZv3PWy8ZKA4uLUR+QHwLBE7Ds5nB41UnpfMqHS8faAkrt+hqLcao+k5CocuYeH9Y7cfxb/DE/ZAZgHe1QjHdCHl+eht6AGl2GzSWeJg0ezTA9yhuUAJjRCNurxnKdAYR46hB0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+JnJKyf; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70fbec5d-1894-4660-a768-62e176e9e421@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766167164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxvPECyzXFaaBiOzUqTvNeDLMAEM4JlgU13vC0Rz1HY=;
	b=C+JnJKyfvEevrBos5owLu8tKXkPwVFnhPGRs+EhV/quxPx+MV+QhME5xGmMfYhYQ9A/Elu
	awyidvNG6WedOb/RF18XiaGQluWA9y43pcssBvcZxhAnDn6aJc+x7QfZTrYrwjgLf1GOt5
	eOCtGCfnCDj6h1dF82/PViq7/L4jyb8=
Date: Fri, 19 Dec 2025 09:59:21 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] rdma_rxe module unload failure with DEBUG_LOCK_ALLOC
 enabled
To: Stefan Metzmacher <metze@samba.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
References: <170e3191-7e15-4af8-948f-14904fe260cc@wdc.com>
 <7affc986-1378-4257-bac6-cd0be4e2f5c8@samba.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <7affc986-1378-4257-bac6-cd0be4e2f5c8@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/19/25 5:45 AM, Stefan Metzmacher wrote:
> Hi Shinichiro,
> 
>> While I evaluate v6.19-rc1 kernel, I found that rdma_rxe module unload 
>> fails.
>> The failure can be recreated by simple two commands below:
>>
>>     $ sudo modprobe rdma_rxe
>>     $ sudo modprobe -r rdma_rxe
>>     modprobe: FATAL: Module rdma_rxe is in use.
>>
>> I bisected and found the trigger commit is this:
>>
>>     80a85a771deb ("RDMA/rxe: reclassify sockets in order to avoid 
>> false positives from lockdep")

Thanks a lot.

https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=7f55eb3373dca97b706e8521705a06d4bf84b0f0

Hi, Shinichiro Kawasaki

Please confirm if the above link can fix the above problem or not.

Best Regards,
Yanjun.Zhu

>>
>> This commit changes the driver behavior when the kconfig 
>> DEBUG_LOCK_ALLOC is
>> enabled, and my kconfig does so.
>>
>> Actions for fix will be appreciated.
> 
> I have a fix for this, see:
> https://git.samba.org/?p=metze/linux/ 
> wip.git;a=commitdiff;h=7f55eb3373dca97b706e8521705a06d4bf84b0f0
> 
> I'll post it to the list later today.
> 
> Sorry for the trouble!
> metze


