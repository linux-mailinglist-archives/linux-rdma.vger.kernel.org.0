Return-Path: <linux-rdma+bounces-1768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837189759A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7665EB22E00
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56561514CC;
	Wed,  3 Apr 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MLjhxo3f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76914C5B3
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162822; cv=none; b=BHeQC4RecO9yNBTCOlt9PBrP43mfTUZZlQoF283N5X79rv4IdfRTAnvywxP9yHIa9hqtK69HW0LNhRPoajKwTocmglOmbPjX7YiR+LJ4wPtXuQOA5dPMOK5rIOpOLqRAsnlJ/zxGbJXH6s29yXJtt2PvVb60cOGtq3pX9Awsqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162822; c=relaxed/simple;
	bh=omiNQmYLkQ9V8YGVwDTjVq81dCgXsNLZsUPXzwo1BYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sC4E4ApMAT004f9XSamYOVLeJcF53oBW9aoGCEzobMMuNGsfDd/xv9MHrxIWQp20SyR0G40gPL3wHvHLakda3/GpM7Cs8gSkSEpqn0mnnYw6hHqAeURVZC7ylGoOdhu377rKiTuVxwZl/6FhToSLZvM10VfeQGW9rbKdtc8qHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MLjhxo3f; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b16c6b2b-4584-4638-a821-24cf5627623e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712162818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJWddBwiGiuNt7dRQORTiLu62OiUipRTCEahSwqWZ7Y=;
	b=MLjhxo3fQf6dUutCcVwn8QgjIbUxN3ZJGznnxVnn7QXjAdbJZ/NTCAgJpH4+lpcndRUyod
	5gxGV7DcqUZ2mq7ErW9no0Zn+/FVd80hyiIJMRSzeXvoGrRL+C/cn7mDskPEh5j0CwlpY7
	S8Hkb8t/smzKi8OHZ4kmWnm9gRvUjQQ=
Date: Wed, 3 Apr 2024 18:46:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
To: Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
 <20240402174536.GL11187@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240402174536.GL11187@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/4/2 19:45, Leon Romanovsky 写道:
> On Sat, Mar 23, 2024 at 09:31:39AM +0100, Yanjun.Zhu wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> If the definition of pr_fmt is before the header file. The pr_fmt
>> will be overwritten by the header file. So move the definition of
>> pr_fmt to the below of the header file.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.h | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Let's just convert RXE to ibdev*() prints instead.

OK. I will do. But it takes me some time because it seems a big task.^_^

Zhu Yanjun

> 
> Thanks


