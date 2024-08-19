Return-Path: <linux-rdma+bounces-4424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22B9577B2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 00:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B26EB236EE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C71E213C;
	Mon, 19 Aug 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lljopScz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1513EEA5
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107125; cv=none; b=krmO9lKJ5/7NfGwwYimlpKe8CqI9brUPdghGHNtC5TfECbSZkKMNU7kOyUjJgLNILkgB+U3L28y/hkQeQFLhFGIvQas6Q5MLUANYeleFVx4utrUNE3ica0vDZ1Wo5KNaW6n8Js7pXGllY8vjrIc5jxzgSZ8nbBEEtKJskz7gIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107125; c=relaxed/simple;
	bh=HKHKfrqRKrp3pwub7bbP6Pf4bATI42In7187JN6nl1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzVJ0IcoN07c/k3IZKTKsyymvWFoYWKvTK6WFuPHm2ZkjngUfZWWJ194drR2hrVWjNpSE8h7x6M3FgRkBBmVOm9tzGKK1Dy6pxCJFDngs+6tOm6X/WACyWi4U6Y4w3E3CAE2kxh9/VYtqqbN93sA3tOQYWk6hMZaftlvjDLr2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lljopScz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c42d5bd0-3e67-4950-9a35-ba1d77e9b4d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724107121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8tNBuqbwadg1n3Js6vqDyqqna6QTqNl8AO1Qwx7SdA=;
	b=lljopScz619yaHAj49fQR8FGtLJlclu1JOP0U/PGjxsDVlI6MZJzVFWjRu3uf75L7s6i60
	+2DdhGfc/CmWYGdQ3Q9eaTkvej6hYLu/lroEegP86hPoYftzyAPanILOOc34f/8/PgcPj7
	/mqofPh1YYHNaXOEBKYMG/a+hB5qyIY=
Date: Tue, 20 Aug 2024 06:38:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/iwcm: Fix
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bvanassche@acm.org, leon@kernel.org, linux-rdma@vger.kernel.org,
 shinichiro.kawasaki@wdc.com, kernel test robot <oliver.sang@intel.com>
References: <20240817084244.536397-1-yanjun.zhu@linux.dev>
 <20240819183821.GA3487760@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240819183821.GA3487760@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/20 2:38, Jason Gunthorpe 写道:
> On Sat, Aug 17, 2024 at 10:42:44AM +0200, Zhu Yanjun wrote:
>> When workqueue_flush is invoked, WQ_MEM_RECLAIM is checked to avoid
>> errors.
> Include backtraces please, these things are tricky and we often have
> to go back and figure out why.
>
> Explaine exactly why it is needed with traces in the commit message
> and summarize in a comment.

Got it. I will make changes in the commit log and add backtraces.

Zhu Yanjun

>
> Jason

-- 
Best Regards,
Yanjun.Zhu


