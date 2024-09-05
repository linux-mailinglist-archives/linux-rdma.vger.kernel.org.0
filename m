Return-Path: <linux-rdma+bounces-4766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2596CFCD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 08:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF891F22686
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 06:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064121922C7;
	Thu,  5 Sep 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v8/Y0bR5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7B15624C
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519279; cv=none; b=SP5nTWOLPwWtyxPs7ZdNJdPSVxiHqwgEI23ZfAO8vjwxEhGpxL9Gc93Z1hhzlUqxtsPD/FOsHMslQkgjj3d1AjUBY8MndK1edxgQDT8sewN+i1C1PJbxo/8iZrmigwJAZpvq7UEWBsPm3bZpEWc6vQsgHYb2xoTMFTTrnQ2ZFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519279; c=relaxed/simple;
	bh=E722aN98qoIluMjkBW9ldX1LQnnjFZh+OKguYPNtw1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoFO3NIzaz4O5e5oJE0AJ0WYzUomiBH5bE9qEHWt1xRgQYCQPgaU1PXhiSFK3S3nF6duDObNlPmp3iLHBQb9alSCDhYJidNBWRflHB6m1PmWE5Rms+WqsuiJiNLfmUkOq3Yua+DTj3+sBfZynpdLk2y+CzT2XYpm53joCrmF3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v8/Y0bR5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df0c32a0-87d5-4d87-b994-16a34c584f68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725519274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rah4wDDRJNXpGnG/55+rQgrFLtgH2VsGB24jI882TI=;
	b=v8/Y0bR5InksC0ifRasyyNEgcvqz8eyi10IcxpbXWqOT3YB2x1+OEAOgJ7Xpt4dowmbdqa
	V+QiskvKfAvmCuAzrtT6yCNqeG3ijdhSFteg93AH+fuZLhmpeRKOZPEASpjxhfIAuIMRn7
	6T5koRHmS7trA+6vSrecaWNeiw+7Pz0=
Date: Thu, 5 Sep 2024 14:54:26 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next] RDMA/core: Skip initialized but not leaked GID
 entries
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com
References: <7cce156160c4da8062e3cc8c5e9d5b7880feaafd.1725284500.git.leonro@nvidia.com>
 <20240904143113.GG3915968@nvidia.com> <20240904153457.GO4026@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240904153457.GO4026@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/4 23:34, Leon Romanovsky 写道:
> On Wed, Sep 04, 2024 at 11:31:13AM -0300, Jason Gunthorpe wrote:
>> On Mon, Sep 02, 2024 at 04:42:52PM +0300, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Failure in driver initialization can lead to a situation where the GID
>>> entries are set but not used yet. In this case, the kref will be equal to 1,
>>> which will trigger a false positive leak detection.
>>
>> Why does that happen??
>>
>>
>>> For example, these messages are printed during the driver initialization
>>> and followed by release_gid_table() call:
>>>
>>>   infiniband syz1: ib_query_port failed (-19)
>>>   infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache
>>
>> Okay, but who set the ref=1?
>>
>>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>>> index b7c078b7f7cf..c6aec2e04d4c 100644
>>> --- a/drivers/infiniband/core/cache.c
>>> +++ b/drivers/infiniband/core/cache.c
>>> @@ -800,13 +800,15 @@ static void release_gid_table(struct ib_device *device,
>>>   		return;
>>>   
>>>   	for (i = 0; i < table->sz; i++) {
>>> +		int gid_kref;
>>> +
>>>   		if (is_gid_entry_free(table->data_vec[i]))
>>>   			continue;
>>>   
>>> -		WARN_ONCE(true,
>>> +		gid_kref = kref_read(&table->data_vec[i]->kref);
>>> +		WARN_ONCE(gid_kref > 1,
>>>   			  "GID entry ref leak for dev %s index %d ref=%u\n",
>>> -			  dev_name(&device->dev), i,
>>> -			  kref_read(&table->data_vec[i]->kref));
>>> +			  dev_name(&device->dev), i, gid_kref);
>>>   	}
>>
>> I'm not convinced, I think the bug here is something wrong on the
>> refcounting side not the freeing side. Ref should not be 1. Seems like
>> missing error unwinding in the init side.
> 
> I dropped this patch as the real fix is here 1403c8b14765 ("IB/core: Fix ib_cache_setup_one error flow cleanup")

The commit 1403c8b14765 ("IB/core: Fix ib_cache_setup_one error flow 
cleanup") is in the link 
https://patchwork.kernel.org/project/linux-rdma/patch/79137687d829899b0b1c9835fcb4b258004c439a.1725273354.git.leon@kernel.org/

Zhu Yanjun

> 
> Thanks
> 
>>
>> Jason
>>


