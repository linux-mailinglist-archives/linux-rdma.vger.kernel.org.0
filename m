Return-Path: <linux-rdma+bounces-4425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B629577F3
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 00:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AFD1C21326
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6A1DF676;
	Mon, 19 Aug 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y8N/XUZI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630615956C
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107352; cv=none; b=nc9q9+9hBm8nn3dmy7Tt237/8IVfamZxIiZBFOz1xmKeUQ/RvQ9dhGHEVW+bp4WG5eIaMg+/ifOaU8rtLyVIxaD4WBphaPk8TSgCPYjAxkeNtEy5ZA8Z+GwWP7cosxmBvAQ4H4t0wuYiRJbKB4Bmz0Kr+q+S8q2bCzkGchujubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107352; c=relaxed/simple;
	bh=AHTuqfbG/XK2n0skvO2LiaiJiwkIbe9ePCOFPmgyxko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/RRhNPbzGWW2UUS7o7r2S2CGa10i8pdsTrNeJtivrRR8Cvjc70I9d+ggBA1MzhBcXrcUV3ePk47VzZIReA0nZZz8Xw0MON1leN+zRoACzzkpWmQvvVxEE9oLL2rBXftKMFwaGqN81d18J/XtUCm3SV49SuI/jyEKGqWLLPmlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y8N/XUZI; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95060a8e-d155-4dad-9aac-4d14e4190537@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724107348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3tyUjoiRnHGO+bLq3MQLnFvSFWniwFbctqLUsWYaTg=;
	b=Y8N/XUZIULBz/NiC+SiXA6hFubLnZfThYYPyhVAafA3hy8bhgjl+xlPENr0+izuZYd+6l1
	WHJyiFpfyl8E+6uO/34QxpvK12NSKoz3izUAjvxOswWfgxj8wAIbZov9/0AKFXadirkJN6
	TuiIdYbiP7eJKZF/vTiftKRn+h8owyo=
Date: Tue, 20 Aug 2024 06:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/iwcm: Fix
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Bart Van Assche <bvanassche@acm.org>, leon@kernel.org,
 linux-rdma@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: kernel test robot <oliver.sang@intel.com>
References: <20240817084244.536397-1-yanjun.zhu@linux.dev>
 <092913a6-c898-4258-90ca-926d6864d005@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <092913a6-c898-4258-90ca-926d6864d005@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/20 3:28, Bart Van Assche 写道:
> On 8/17/24 1:42 AM, Zhu Yanjun wrote:
>> When workqueue_flush is invoked, WQ_MEM_RECLAIM is checked to avoid
>> errors.
>
> This description is too brief and not entirely correct. In the
> description of this patch it should be explained that WQ_MEM_RECLAIM 
> must be set for workqueues that are flushed from a work item queued on
> a WQ_MEM_RECLAIM workqueue or from a memory reclaim context. Otherwise a
> deadlock can occur. From kernel/workqueue.c:

Yeah. I will make changes to the commit logs based on the above comments.

Thanks for your advice.

>
> /**
>  * check_flush_dependency - check for flush dependency sanity
>  * @target_wq: workqueue being flushed
>  * @target_work: work item being flushed (NULL for workqueue flushes)
>  *
>  * %current is trying to flush the whole @target_wq or @target_work on 
> it.
>  * If @target_wq doesn't have %WQ_MEM_RECLAIM, verify that %current is 
> not
>  * reclaiming memory or running on a workqueue which doesn't have
>  * %WQ_MEM_RECLAIM as that can break forward-progress guarantee 
> leading to
>  * a deadlock.
>  */
>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: 
>> https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Since this is a fix, please include a "Fixes:" tag.

Got it. I will add a "Fixes:" tag.

Best Regards,

Zhu Yanjun

>
> Thanks,
>
> Bart.
>
-- 
Best Regards,
Yanjun.Zhu


