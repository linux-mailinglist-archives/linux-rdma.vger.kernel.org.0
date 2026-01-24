Return-Path: <linux-rdma+bounces-15944-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AEdJVsNdWnTAAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15944-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 19:20:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 382567E720
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ADF330065FB
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6D19D093;
	Sat, 24 Jan 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XJi+b+Ms"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C207E0E4
	for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769278806; cv=none; b=K3p7DFfOD5dI1EMfLa+ziO7Bmden7yyBMTzhzPOe2uXOnw/WSgDbS0goHhPNno+0VfA52mr/9tGgDaYe4naSRLktMJNj1W6BAxcA+spXBwWx86beZLGrz4c+/uHxxl7o7WdXB/hn1c4bOF+8sGPtNFDznpkcNhbVHrfhlVETLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769278806; c=relaxed/simple;
	bh=+IWuDoH5ujWHp5FkJnvyvd8wvu1bU54JhaW4mGt6dQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA95RFFraZxscy13Y4jwGT/YU8IPQb26tlE9xyv7qeWODL/jPi1YqWn9LRvBPuJNmwdugosSXaRUZFzzIRWo0TEIyICa/h7qlLXsn6PZQHrRsA1hatejqz0q6qegnF2OrfRnuchXzkNxafd8QvqAtFsCxWXsbGrrmqScTvFrQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XJi+b+Ms; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6e3b0ade-6b45-4597-b065-9148c2c5e0ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769278793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23WA4bZaC9Vmd3U8ccN3qNWEee3xLFqy4xjAmNr+GxM=;
	b=XJi+b+MsSE0HsKgkJ+Gbdo3TI8J59yOTa0MH8kWFtfDPL64VxeBaM3vc1cjNn57QqM3iSz
	n6Ujne68dyZ1t/iX0jcPXsYXnQ+iEtAiMNkea1668NJ1HDPSGdPFwecmwqRT/rsGySmYcj
	6zSRu1bU3Vdh60OUGU2w3B2NMXPUWng=
Date: Sat, 24 Jan 2026 10:19:44 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/5] Add a bio_vec based API to core/rw.c
To: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260122220401.1143331-1-cel@kernel.org>
 <c02ab348-5243-4e97-b916-6bd59ffe769a@linux.dev>
 <d67a30a0-5ff1-4e31-a168-81f8b7bee97f@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <d67a30a0-5ff1-4e31-a168-81f8b7bee97f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15944-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 382567E720
X-Rspamd-Action: no action

在 2026/1/23 6:13, Chuck Lever 写道:
> On 1/23/26 1:04 AM, Zhu Yanjun wrote:
>> 在 2026/1/22 14:03, Chuck Lever 写道:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> This series introduces a bio_vec based API for RDMA read and write
>>> operations in the RDMA core, eliminating unnecessary scatterlist
>>> conversions for callers that already work with bvecs.
>>>
>>> Current users of rdma_rw_ctx_init() must convert their native data
>>> structures into scatterlists. For subsystems like svcrdma that
>>> maintain data in bvec format, this conversion adds overhead both in
>>> CPU cycles and memory footprint. The new API accepts bvec arrays
>>> directly.
>>>
>>> For hardware RDMA devices, the implementation uses the IOVA-based
>>> DMA mapping API to reduce IOTLB synchronization overhead from O(n)
>>> per-page syncs to a single O(1) sync after all mappings complete.
>>> Software RDMA devices (rxe, siw) continue using virtual addressing.
>>>
>>> The series includes MR registration support for bvec arrays,
>>> enabling iWARP devices and the force_mr debug parameter. The MR
>>> path reuses existing ib_map_mr_sg() infrastructure by constructing
>>> a synthetic scatterlist from the bvec DMA addresses.
>>
>> Hi, Chuck Lever
>>
>> I’ve read through the patch series. As I understand it, the new bio_vec–
>> based RDMA read/write API allows callers that already operate on bvecs
>> (for example, svcrdma and potentially NVMe-oF) to avoid converting their
>> data into scatterlists, which should reduce CPU overhead and memory
>> usage in the data path.
>>
>> For hardware RDMA devices, the use of the IOVA-based DMA mapping API
>> also seems likely to reduce IOTLB synchronization overhead compared to
>> the existing per-page approach, while software devices (rxe, siw) retain
>> the current virtual-addressing model.
>>
>> Do you happen to have any performance or functional test results you
>> could share for this series, in particular:
>>
>> Hardware RDMA devices (e.g., latency, bandwidth, or CPU utilization
>> changes), and/or
> 
> Functional tests with CX-5 Infiniband and NFS/RDMA show no regression.
> 
> Performance tests are difficult to evaluate because I don't have a
> multi-client set-up here to drive a heavy workload, plus filesystems
> bottleneck long before the network transport does. The changes are
> designed to improve scalability (eg lower CPU utilization for the same
> workload and less interaction between host and RNIC) more than improve
> raw throughput. So far I have seen no throughput regression and perhaps
> a bit of improvement for tail latencies.

Thanks a lot. Based on the code changes, this patch series should 
improve performance. Unfortunately, due to various limitations, we are 
unable to provide performance test results.

Best Regards,
Zhu Yanjun

> 
> The main purpose of the series, however, is part of an effort to enable
> kernel-wide replacement of the use of scatter-gather lists, which are
> technical debt. Socket APIs already support struct bio_vec.
> 
> 
>> Software RDMA devices such as rxe or siw?
> 
> Software providers are not likely to see much change. However, you will
> need to test the series with your own preferred configuration and
> workload to assess performance and scalability delta.
> 
> 


