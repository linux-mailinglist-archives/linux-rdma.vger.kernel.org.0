Return-Path: <linux-rdma+bounces-4693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF409682BA
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD23B21E93
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07193187356;
	Mon,  2 Sep 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GbRbANgB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198A2D7B8
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268161; cv=none; b=ZuknC8VSDbzc7kTtDdk4An4Mbpm/fyj9xmQNcBWIv/Wc1QNjp841tWee+uWxDCoO9TwHgBaF39H8JIIsmWsaiGQVpfy8ceuN+SQNU059GG9jwr3uJvVEmzLPCnCbvulh0c2Aq+3ir0Jo5TUXtPWWKj+1nQOVn9RjpJNgY/WGyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268161; c=relaxed/simple;
	bh=WVyY5lHcR3ck7ce1CJobDLyvWtcnNUk0Jf/rlIgoHgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCBVuvY9fXiywRLWtZA+4JLMzZ1xs5oyyM5xkcLeH3a3gRhA6ib3gsYiBnjXoDaTk/XO+EEutURgifA8nR487/TT3d4nTLlrCZEVjRBHMXW1cpj+1Ax9dixjrbj1CbWFjzWnLHIPrAAdtPErxK9iy95fRVbHwvh96g50Nj1nUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GbRbANgB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725268151; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5vr6kfoDDTDXWVkQhvq9kfhEjgzFmT+6sV8LRJ4HJ6w=;
	b=GbRbANgB6fQplTDa5v60KkKQEcQstz9Kr3M2joTLMyt2CsaqCK2m8/mm3BwJy0hX93U7zL6qVTkJyMF5nVwX+F8zVDyOiaz8oYYubiAK42THSS4iGWEApMGdgDSoyYJ0clBWkBIhyzDdXIdvvpev/xIy1EMo2CEFbPIJRmp1YFI=
Received: from 30.221.116.166(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WE689iM_1725268149)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 17:09:10 +0800
Message-ID: <9cbb54a2-1929-f3d3-5b4a-3c613e6759a6@linux.alibaba.com>
Date: Mon, 2 Sep 2024 17:09:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next v2 1/4] RDMA/erdma: Make the device probe process
 more robust
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
 <20240828060944.77829-2-chengyou@linux.alibaba.com>
 <20240829100955.GB26654@unreal>
 <e4649d6d-8265-054c-24fb-ca641716856b@linux.alibaba.com>
 <20240902072133.GC4026@unreal>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20240902072133.GC4026@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/2/24 3:21 PM, Leon Romanovsky wrote:
> On Fri, Aug 30, 2024 at 10:34:42AM +0800, Cheng Xu wrote:
>>
>>
>> On 8/29/24 6:09 PM, Leon Romanovsky wrote:
>>> On Wed, Aug 28, 2024 at 02:09:41PM +0800, Cheng Xu wrote:
>>>> Driver may probe again while hardware is destroying the internal
>>>> resources allocated for previous probing
>>>
>>> How is it possible?
>>>
>>
>> The resources I mentioned is totally unseen to driver, it's something related
>> to our device management part in hypervisor, so it won't cause host resources
>> leak, and the cleanup/reset process may take a long time. For these reason,
>> we don't wait the completion of the cleanup/reset in the remove routing.
>> Instead, the driver will wait the device status become ready in probe routing
>> (In most cases, the hardware will have enough time to finish the cleanup/reset
>> before the second probe), so that we can boost the remove process.
> 
> And why don't hypervisor wait for the device to be ready before giving it to VM?

Hypervisor actually does what you described during the first bootup. However, one
scenario is that the erdma driver is unloaded and loaded quickly while the device
always exists in the VM. In this case, there is no opportunity for the hypervisor
to perform that action.

> Why do you need to complicate the probe routine to overcome the hypervisor behavior?
> 

The hardware now requires that the former reset (issued in the remove routine) must be
completed before device init (issued in the probe routine). Waiting the reset completed
either in the remove routine or in the probe routine both can meet the requirement.
This patch chose to wait in the probe routine because it can speed up the remove process.

Actually this is a good question, and inspires me that maybe the requirement in the
hardware/backend may be eliminated, so that simplify the driver process.

I'd like to remove this patch in v3 and leave it for internal discussion.

Thanks very much
Cheng Xu


> Thanks
> 
>>
>> Thanks,
>> Cheng Xu
>>

