Return-Path: <linux-rdma+bounces-3979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0AC93C142
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB741B223A4
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A14199241;
	Thu, 25 Jul 2024 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XO0ILVhZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F103C3C
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908696; cv=none; b=T0IMzDN5c2zsARK6naPbzSez+AZrqq8KfKk6w8OTW3PxDWgdJOc9zoO8T2k8N62PvQi3mt+hHqsW7ZqDMsw5wca1zGs0DZOHH3b5d6dg7YMvlVmAIIUfX6q+J5hxXWxDAApqQg8V2fNoLJ2fF/2s4sBBDwb6j7P7hML3RgiOs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908696; c=relaxed/simple;
	bh=4PIJtUpRJsMKsRR8z7qX6XJVwrx90YjwOoizrkEy50M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4TkCkfE3Rcat13eECeU81XZ3bWp+hV+6AwFQ+O/7mOD9xJklBzIpLuUzapgGx2Fgnr1QS67vZ7vjeIxp9YfaMDrSbF/uPjjEPdYh2QDPv5m7nWO3t3OKQ550NFwjiP66daJxE9FJ8LSMUgqNSDL7e1dPDKLqdZBUibZMrMGFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XO0ILVhZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f585f4ba-a204-4d29-b0ae-ed80e128a359@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721908691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXLCm5LFeNef2Y8wof+fTl1kUis2cMQ9QiWVAQ6kRM4=;
	b=XO0ILVhZ8/SY7m873M0tG+OYXp8cSNWIacvMVNXykUgC8N89Wnyp+q58nMSsr5cg7m4Aei
	JalAnGwZX5uzAy+DaZuP1HDw1s+L+AgP0wfzZKcg8tVHV7p4H2mQI0evbLscAt5agn4DD5
	0HQDvkejlfZo4RmPV2KhxlssuHvdpRI=
Date: Thu, 25 Jul 2024 13:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] infiniband/hw/hfi1/tid_rdma: use kmalloc_array_node()
To: flyingpenghao@gmail.com, dennis.dalessandro@cornelisnetworks.com,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Peng Hao <flyingpeng@tencent.com>
References: <20240725071716.26136-1-flyingpeng@tencent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240725071716.26136-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/25 9:17, flyingpenghao@gmail.com 写道:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> kmalloc_array_node() is a NUMA-aware version of kmalloc_array that
> has overflow checking and can be used as a replacement for kmalloc_node.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>   drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-

drivers/infiniband/sw/rdmavt/mmap.c:124:

ip = kmalloc_node(sizeof(*ip), GFP_KERNEL, rdi->dparms.node);

In the above file, not sure if this kmalloc_node needs to be replaced 
with kmalloc_array_node or not.

Zhu Yanjun

>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
> index c465966a1d9c..6b1921f6280b 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -1636,7 +1636,7 @@ static int hfi1_kern_exp_rcv_alloc_flows(struct tid_rdma_request *req,
>   
>   	if (likely(req->flows))
>   		return 0;
> -	flows = kmalloc_node(MAX_FLOWS * sizeof(*flows), gfp,
> +	flows = kmalloc_array_node(MAX_FLOWS, sizeof(*flows), gfp,
>   			     req->rcd->numa_id);
>   	if (!flows)
>   		return -ENOMEM;


