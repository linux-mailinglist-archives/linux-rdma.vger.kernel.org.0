Return-Path: <linux-rdma+bounces-9957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8647AA81C2
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42459175CF7
	for <lists+linux-rdma@lfdr.de>; Sat,  3 May 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAD2AD2C;
	Sat,  3 May 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBTrSVlQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D094B666
	for <linux-rdma@vger.kernel.org>; Sat,  3 May 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746292151; cv=none; b=gAG3O2i2PNimg4QCJ8uYC2OmEppXGqP5kfMGHovPA9l/20MQnDyZzAYKkGetcbx9mzECgheN3EbbXkQP6SO9L/Q70FLjkK+kRxAI1SpaXFeriaAUda+cZSPxV/qyQkGZ8uhM+1XxTeo4MkCse/hMUMYR6p5QMjDkwtQMLwSfWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746292151; c=relaxed/simple;
	bh=FleqDfiObPr8jP+5s/PoHluFECmo3SPNCYvz28dRJME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dr4ujyZyH4TFuOKh3AuWdxS3gODBb2/VsnpTEvq2HsgM0OR4qsRjWoddBUObVFDjKI6xEiwhBzhe+FciGfH9E2mWhR3JGxgFXdjtPt2pWtDln+lLrTaTsh+zRMeLm7fMrO0kmj2PW3nDDoirxXYseu1Z6aUtEMuqyirIH9WDnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DBTrSVlQ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <526be00d-98e6-45fb-a5d3-eb26fd7a88d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746292141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V94ddVQ1zhWCBXX5FZkArsyB/+5j2pO6MRwYFNaWc2Y=;
	b=DBTrSVlQIYONaN+kW+hqnk/Vub5FuXhLBccaTA1HMUCyZHqn4hIKnm7CuC03vV+K1c9SDT
	MNV623GFY6Vbdft4VzGrmMfYMPs+gs333QZ7hnKrXmCjrCrab6UJgm6PadeCBaeYcL1DMV
	T1bx2XAHIU00a01/zy2KPKWU/tt7leI=
Date: Sat, 3 May 2025 19:08:53 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 0/2] RDMA/rxe: Prefetching pages with explicit
 ODP
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250503134224.4867-1-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/3 15:42, Daisuke Matsuda 写道:
> There is ibv_advise_mr(3) that can be used by applications to optimize
> memory access. This series enables the feature on rxe driver, which has
> already been available in mlx5.
> 
> There is a tiny change on the rdma-core util.
> cf. https://github.com/linux-rdma/rdma-core/pull/1605

Hi, Daisuke

Thanks a lot for your efforts to this patch series. It is very nice. 
With this patch series, we can make prefetch for ODP MRs of RXE.

I read through this patch series. And it seems fine with me.^_^

IIRC, you have added ODP testcases in rdma-core. To verify this prefetch 
work well for ODP MRs, can you add this synchronous/asynchronous 
prefetch to the ODP testcases in rdma-core?

Thus, we can verify this patch series. And in the future, we can use 
these testcases to confirm this prefetch feature work well.

To now, it seems that no tool can verify this prefetch feature.

Thanks a lot.
Zhu Yanjun

> 
> Daisuke Matsuda (2):
>    RDMA/rxe: Implement synchronous prefetch for ODP MRs
>    RDMA/rxe: Enable asynchronous prefetch for ODP MRs
> 
>   drivers/infiniband/sw/rxe/rxe.c     |   7 ++
>   drivers/infiniband/sw/rxe/rxe_loc.h |  10 ++
>   drivers/infiniband/sw/rxe/rxe_odp.c | 165 ++++++++++++++++++++++++++++
>   3 files changed, 182 insertions(+)
> 


