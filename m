Return-Path: <linux-rdma+bounces-2320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604458BE75F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E1AB21DE6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D991635BB;
	Tue,  7 May 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXpt7VoD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB215E801
	for <linux-rdma@vger.kernel.org>; Tue,  7 May 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095498; cv=none; b=WZFwN4WWBPhTZbjj7WfudUBeaqNM1I4L/xboIehBYJIepRIH3jXqLm7Lj/jJh3Kxvjmzhh42bSxS5/rCT+QS5dsqBqER40SvYXPLVpwu5JfkHJ0bKi5rB2HygzIYGN7PZDRDA8GG4GtRUyNuMUt59byhKxPmSF5Ei3Pbm0bGh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095498; c=relaxed/simple;
	bh=wqk9kva6Z468fnzR4dhmllrDiCYNXiexDSOPYNO459Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfzUE9jp1yJGbvXGTNr/UJELl2wz6YZdmcDtkBZS8LkERkfw1tnh2ftThphAkmbZWfgBN07MYh493abClhIjbYWGlLgAUUCMsCM/q13VHYgGh7ABZhodm0eL9ZkaQw1RJE+QAQC5CPp553gQn8KeWzZDBJInAZDhamMPR6yydSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXpt7VoD; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa606d14-c35b-4d27-95fe-93e2192f1f52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715095495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IpRWdMlVP/9sg2sRxny0HoNTCrMVdhtZN7f2dJNDTE=;
	b=vXpt7VoDsziyTOU19E1lKXsYOxJXnsOT90C0F4jXgonZfGkJybH9/+FLAJ9C3OikcF3Sag
	sT3LTwRQc5/sMbhHXEMUOa9jKaJmGtVzL9WiXjJRL3EjZA1p6H0t0hNkRQ8YbJdN8bj506
	e1QUk69/JcQsrfsTB0sab8b3PGBCQtY=
Date: Tue, 7 May 2024 17:24:51 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Excessive memory usage when infiniband config is enabled
To: Konstantin Taranov <kotaranov@microsoft.com>,
 Brian Baboch <brian.baboch@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "florent.fourcot@wifirst.fr" <florent.fourcot@wifirst.fr>,
 "brian.baboch@wifirst.fr" <brian.baboch@wifirst.fr>
References: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>
 <20240507112730.GB78961@unreal>
 <8992c811-f8d9-4c95-8931-ee4a836d757e@gmail.com>
 <PAXPR83MB0557451B4EA24A7D2800DF6AB4E42@PAXPR83MB0557.EURPRD83.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <PAXPR83MB0557451B4EA24A7D2800DF6AB4E42@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/7 15:32, Konstantin Taranov 写道:
>> Hello Leon,
>>
>> I feel that it's a bug because I don't understand why is this module/option
>> allocating 6GB of RAM without any explicit configuration or usage from us.
>> It's also worth mentioning that we are using the default linux-image from
>> Debian bookworm, and it took us a long time to understand the reason
>> behind this memory increase by bisecting the kernel's config file.
>> Moreover the documentation of the module doesn't mention anything
>> regarding additional memory usage, we're talking about an increase of 6Gb
>> which is huge since we're not using the option.
>> So is that an expected behavior, to have this much increase in the memory
>> consumption, when activating the RDMA option even if we're not using it ? If
>> that's the case, perhaps it would be good to mention this in the
>> documentation.
>>
>> Thank you
>>
> 
> Hi Brian,
> 
> I do not think it is a bug. The high memory usage seems to come from these lines:
> 	rsrc_size = irdma_calc_mem_rsrc_size(rf);
> 	rf->mem_rsrc = vzalloc(rsrc_size);

Exactly. The memory usage is related with the number of QP.
When on irdma, the Queue Pairs is 4092, Completion Queues is 8189, the 
memory usage is about 4194302.

The command "modprobe irdma limits_sel" will change QP numbers.
0 means minimum, up to 124 QPs.

Please use the command "modprobe irdma limits_sel=0" to make tests.
Please let us know the test results.

Zhu Yanjun

> 
> inside of irdma_initialize_hw_rsrc function. You can read the code of
> irdma_calc_mem_rsrc_size to understand the 6GB memory usage.
> 
> You can ask developers of irdma to optimize memory usage.
> Btw., module is loaded == module is used. There is no "loaded and unused".
> 
> Konstantin


