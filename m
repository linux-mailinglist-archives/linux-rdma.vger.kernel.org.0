Return-Path: <linux-rdma+bounces-1580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5744888CC96
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CC51F284EB
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE313C9BA;
	Tue, 26 Mar 2024 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZ7T1SMg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14E129E88
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479714; cv=none; b=aK0conEn13s+7N2MQ45ilNrIdG41gpfVZClwbyoJSzgsQJY4ioaHOvEIzt3fEtp8Hoo9V5g1io59nmSPmttSMRpSC6BzGu9JhMGUOfUY+kdCNjV30g8m6pdwMfn+HmVsfANIq4WLM7LHWS2DoxqllJHjkZPHwGOxLVcE1we/m+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479714; c=relaxed/simple;
	bh=Pa3intbb8USGbz9hSbU2UIvuz0BKA0+5uMxp4W9+Tqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gLsXxAzwHNKcvUeWCpPDXVQYRHlt90vMWXhXa0bKczZYxYKw887cMdXuyOzYt5attLAtG+CvKX2ThAV21gxf5lVG2oGSLQp5M5zY/Gf1c2GQ6mr0ANX5NAEN62+tV4BQXEOdxdcdGTMxPLOdNdwfKsp2qq8FZwMyvMfmxylkEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZ7T1SMg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8996ca5-4607-4339-9847-6101e446194c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711479709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLiwf39agtTbC6rcl/WxtLl3ZASW10oKdesI8JiV8m8=;
	b=MZ7T1SMgnpkSQdNtuE21h6VU/gHQrJ2ftTz7WMnA/Mf6IUUfoZl6XE7NzhHJT0EBKRdeMY
	sixuGP1//ZNEU49TZ4HboNh6CpLCP5OCRi8NlDJ+8qs2Y/VXxfAd3pGf3z1jBl7lMNvxIW
	lY293ho9F4lWqeyiqiiusO6gAROqNN0=
Date: Tue, 26 Mar 2024 20:01:45 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 00/11] RDMA/rxe: Various fixes and cleanups
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240326174325.300849-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/26 18:43, Bob Pearson 写道:
> This series of patches is the result of high scale testing on a large
> HPC system with a large attached Lustre file system. Several errors
> were found which had not been previously seen at smaller scales. In
> this case up to 1600 QPs on 1024 compute nodes attached to about 100
> flash storage nodes. Each patch has it's own description.

Thanks a lot. I never thought that RXE can act as an important role in a 
system up to 1600 QPs on 1024 compute nodes attached to about 100
flash storage nodes.

It is my honor to review these patches.

Thanks Bob for sharing these patches.

Zhu Yanjun

> 
> Bob Pearson (11):
>    RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
>    RDMA/rxe: Allow good work requests to be executed
>    RDMA/rxe: Remove redundant scheduling of rxe_completer
>    RDMA/rxe: Merge request and complete tasks
>    RDMA/rxe: Remove save/rollback_state in rxe_requester
>    RDMA/rxe: Don't schedule rxe_completer() in rxe_requester()
>    RDMA/rxe: Don't call rxe_requester from rxe_completer
>    RDMA/rxe: Don't call direct between tasks
>    RDMA/rxe: Fix incorrect rxe_put in error path
>    RDMA/rxe: Make rxe_loopback match rxe_send behavior
>    RDMA/rxe: Get rid of pkt resend on err
> 
>   drivers/infiniband/sw/rxe/rxe_comp.c        | 34 ++++-----
>   drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +-
>   drivers/infiniband/sw/rxe/rxe_hw_counters.h |  2 +-
>   drivers/infiniband/sw/rxe/rxe_loc.h         |  3 +-
>   drivers/infiniband/sw/rxe/rxe_net.c         | 22 +++---
>   drivers/infiniband/sw/rxe/rxe_qp.c          | 44 +++++-------
>   drivers/infiniband/sw/rxe/rxe_req.c         | 80 ++++++---------------
>   drivers/infiniband/sw/rxe/rxe_resp.c        | 14 +---
>   drivers/infiniband/sw/rxe/rxe_verbs.c       | 17 +++--
>   drivers/infiniband/sw/rxe/rxe_verbs.h       |  6 +-
>   10 files changed, 81 insertions(+), 143 deletions(-)
> 


