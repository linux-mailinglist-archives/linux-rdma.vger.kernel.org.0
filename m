Return-Path: <linux-rdma+bounces-8720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5EA6320B
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 20:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F163B61F9
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4E19993B;
	Sat, 15 Mar 2025 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpcKrtLS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906024D131
	for <linux-rdma@vger.kernel.org>; Sat, 15 Mar 2025 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742066486; cv=none; b=ZFj+haf7RRKkZwrmBq87rBLigL02cTU37GGvcPByv1I+LfayhMtUttqTs5aM5gesZ2YykMH62RYKzhz9HURe9snJyf4WM5ClopijdeIw4T7Am03nagrL0VvznvQ0NNp+OHPS5jPjuEipB/+UuWPLRNt4QnQuAgoU5Y0WISC/LSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742066486; c=relaxed/simple;
	bh=bh3U+xnxsBGs/nSZ0bQOXEt6hakUOSEhni3z8Q9d+tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNZoyjvfU2UP0kD3ctHEKW8t7Obz13cYYsoJ0MaS5D/jHEJumqe+L1wKlct3tj+r7rIZOexX/fAazl2n8aZov+cavW5KV+KNuMHv9J2P7/IFcBVPle+vJjBJRLC+Z+Uc258VgwNvdpLAzPd/pGJvIbO/B6uB/w6E/W2WExC3w7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpcKrtLS; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e4e16ab-4db4-471b-8c80-aae2e8886093@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742066480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mziRzp22PhOiPBsTkuDTcWByswFr2G7Sic1lz7FTIiw=;
	b=jpcKrtLSxlYGWojDhh5Gz7/rBiyhI/aJg7gcReL3t2H8H1HMgv85KIAfaJcAJuLT77Obvs
	QmlBEqtMZun1GmXCnZ+cSJSoWNo62WIgPUATyWHSd/uKFUNl0HkHPIIhBY9vwJF+WcifAh
	DFoFOsd3dX+cWTmNmXJICE1txBn7EZc=
Date: Sat, 15 Mar 2025 20:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v1 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com
References: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/14 9:10, Daisuke Matsuda 写道:
> RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they cannot run
> in the ODP mode as of now. This series is for the kernel-side enablement.
> 
> There are also minor changes in libibverbs and pyverbs. The rdma-core tests
> are also added so that people can test the features.
> PR: https://github.com/linux-rdma/rdma-core/pull/1580
> 
> You can try the patches with the tree below:
> https://github.com/ddmatsu/linux/tree/odp-extension
> 
> Note that the tree is a bit old (6.13-rc1), because there was an issue[3]
> in the for-next tree that disabled ibv_query_device_ex(), which is used to
> query ODP capabilities. However, there is already a fix[4], and it is to be
> resolved in the next release. I will update the tree once it is ready.
> 
> [1] [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation
> https://lore.kernel.org/lkml/20221206130201.30986-1-lizhijian@fujitsu.com/
> 
> [2] [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
> https://lore.kernel.org/linux-rdma/1669905432-14-1-git-send-email-yangx.jy@fujitsu.com/
> 
> [3] [bug report] RDMA/rxe: Failure of ibv_query_device() and ibv_query_device_ex() tests in rdma-core
> https://lore.kernel.org/all/1b9d6286-62fc-4b42-b304-0054c4ebee02@linux.dev/T/
> 
> [4] [PATCH rdma-rc 1/1] RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests
> https://lore.kernel.org/linux-rdma/174102882930.42565.11864314726635251412.b4-ty@kernel.org/T/#t

Today I read these commits carefully. The 2 commits introduces 
ATOMIC_WRITE and ATOMIC_FLUSH operations with ODP enabled. In the 
rdma-core, the corresponding test cases are also added. I am fine with 
these 2 commits.

But I notice that there are no perftest results with the 2 operations. 
Perftest is a stress-test tools. With this tool, it can test the 2 
commits with some stress.

Anyway, I am fine with the 2 commits. It is better if the perftest 
results are attached.

Zhu Yanjun


> 
> Daisuke Matsuda (2):
>    RDMA/rxe: Enable ODP in RDMA FLUSH operation
>    RDMA/rxe: Enable ODP in ATOMIC WRITE operation
> 
>   drivers/infiniband/sw/rxe/rxe.c      |   2 +
>   drivers/infiniband/sw/rxe/rxe_loc.h  |  12 +++
>   drivers/infiniband/sw/rxe/rxe_mr.c   |   4 -
>   drivers/infiniband/sw/rxe/rxe_odp.c  | 132 ++++++++++++++++++++++++++-
>   drivers/infiniband/sw/rxe/rxe_resp.c |  18 ++--
>   include/rdma/ib_verbs.h              |   2 +
>   6 files changed, 155 insertions(+), 15 deletions(-)
> 


