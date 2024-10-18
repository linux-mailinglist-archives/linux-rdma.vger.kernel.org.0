Return-Path: <linux-rdma+bounces-5453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E39A371E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2024 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D074D281C45
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1E18B482;
	Fri, 18 Oct 2024 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fQLOosMG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11218A955
	for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236418; cv=none; b=kf+QprUnrJSzT4haHBQ4pzEsheHiV4Ivc+eQN1gtfl5XPNbAvDBcQx+SXXmOXfJ+8MCJEnvTptBeTDGfMcGhCcib7kInJCF1S08EBqJ/OsI4QxPNSJBxOAP9iRfzEKmj268abwdurRgYKDYJ3azmAPYDRFDJVm95fObOIM9VFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236418; c=relaxed/simple;
	bh=dJkcyFCfdw4XMhCX1tHVLniqjmkGISQAbTfuiB8fQxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwwWmmSXTT85sM5Btw+FREWu+qS/2DwmIeXuXjobMjACIk3xwEDQMtWckBN4ttuFbIoXqXyPqcsPrC3ZAqKeDIZTGRTowsa05sbW3JZKrC5j0JRMDe3WjsRtK/IGfGIpgzMJqxlZApqXG3HbPEVlBc/1iQ29vn5MOoCEbBzCWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fQLOosMG; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5472cead-7965-47f5-9ee1-77d40062b897@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729236414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KFpx6VixP9yy4xxFaQWd//8YairifxkNNvdJP3idU4=;
	b=fQLOosMGk8sWYTwotPFATSnDYfULW8a0uCJnY30ZtcfNdCsMB5EATE3nlPA0a+C8iJY8es
	W/e5tK6eElVFajiqDZZAKZ4FmXKYVDdsRrCdUW8hdsfSZ3vuZ+Jo7n72a9QjCXEidgvLyI
	3o9J+t3+AmK2JRJXLr9N8F6P5mgjlRw=
Date: Fri, 18 Oct 2024 09:26:50 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/4] GPU Direct RDMA (P2P DMA) for Device Private Pages
To: Yonatan Maman <ymaman@nvidia.com>, Christoph Hellwig <hch@infradead.org>
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-mm@kvack.org, herbst@redhat.com,
 lyude@redhat.com, dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 jgg@ziepe.ca, leon@kernel.org, jglisse@redhat.com,
 akpm@linux-foundation.org, dri-devel@lists.freedesktop.org,
 apopple@nvidia.com, bskeggs@nvidia.com
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <Zw8_x0Tvux9IMbly@infradead.org>
 <1a667504-72bd-445b-8bf8-a6604b7beb2b@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1a667504-72bd-445b-8bf8-a6604b7beb2b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/16 17:16, Yonatan Maman 写道:
> 
> 
> On 16/10/2024 7:23, Christoph Hellwig wrote:
>> On Tue, Oct 15, 2024 at 06:23:44PM +0300, Yonatan Maman wrote:
>>> From: Yonatan Maman <Ymaman@Nvidia.com>
>>>
>>> This patch series aims to enable Peer-to-Peer (P2P) DMA access in
>>> GPU-centric applications that utilize RDMA and private device pages. 
>>> This
>>> enhancement is crucial for minimizing data transfer overhead by allowing
>>> the GPU to directly expose device private page data to devices such as
>>> NICs, eliminating the need to traverse system RAM, which is the native
>>> method for exposing device private page data.
>>
>> Please tone down your marketing language and explain your factual
>> changes.  If you make performance claims back them by numbers.
>>
> 
> Got it, thanks! I'll fix that. Regarding performance, we’re achieving 
> over 10x higher bandwidth and 10x lower latency using perftest-rdma, 
> especially (with a high rate of GPU memory access).

If I got this patch series correctly, this is based on ODP (On Demand 
Paging). And a way also exists which is based on non-ODP. From the 
following links, this way is implemented on efa, irdma and mlx5.
1. iRDMA
https://lore.kernel.org/all/20230217011425.498847-1-yanjun.zhu@intel.com/

2. efa
https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/

3. mlx5
https://lore.kernel.org/all/1608067636-98073-5-git-send-email-jianxin.xiong@intel.com/

Because these 2 methods are both implemented on mlx5, have you compared 
the test results with the 2 methods on mlx5?

The most important results should be latency and bandwidth. Please let 
us know the test results.

Thanks a lot.
Zhu Yanjun




