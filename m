Return-Path: <linux-rdma+bounces-10727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B310AAC428D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A2C179F21
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243B8187554;
	Mon, 26 May 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NbTUWQQF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877EC120
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274374; cv=none; b=mus4/9KdiOruZ1LPSE5dKOG3vHLl3NvfD6+yzuFDku2eC0hZpDUR1pBKfTpNYrBHx/576mLqt9f+jdmpDA/KWhMMAj5TGvjpY61AgVSSZY97PF3xDxodoOGYFuuGWcyLDeUZ94HULUfS8CXakSnXrSATRAhV0T5TXQcETd/wHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274374; c=relaxed/simple;
	bh=t0rKUe7XrEmmiYJ/XpgQZxznI2cBnxpYOIMHYi0X03k=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mTR7E11cxDy+ZMz6p2XLmOPhdjeMcsV/E4R/HppdPYAy2muyK1ee9onsffcR/ksD29bqBhBbUuFRoptqvjeN0ccTfiV0B5nnDk4rLRKqx6PDs1KkzGeS+akMm1YD2s+19DuKsT8I6e79F2fLmF/juHdSXKkGJqQp/F4qmdtCu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NbTUWQQF; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748274374; x=1779810374;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=/tsY+oDu5xpZbgmwfBYtca3vdyl/U0LSL0itePH5Sbw=;
  b=NbTUWQQFro8vr09qKLzEHnAtsBNhMCHVw+KMfqUZ2qA6gREgNOQh82Lj
   CGY1vE/Gtz1Jo5VW+JwKniIkoNhewMS3WAU5NEFm1Ou9Yjfdt+1f7yAmC
   333kepB35qYStZchSguIYe5PcaJhJIHMMtRNpNaQdyJJzW/2X2qWme4xB
   u87tUcv5k+rOM0kqP6e62x+mUd9vAOGalyySAbpJrPkDyCQ4AvAbiCXw7
   tfGpxynkAI4YJ8VCMd/srkAIa+FAYq8oS7762K5FoyxSj+3vtlV+vpo52
   80OMVEkYA0qykbBxg0XPnHVAiTb9oqHlLcPyqpyKasRk63uib9re6Vl0w
   A==;
X-IronPort-AV: E=Sophos;i="6.15,316,1739836800"; 
   d="scan'208";a="301801620"
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 15:46:11 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:65186]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.132:2525] with esmtp (Farcaster)
 id 08b34370-89c3-4dcc-b1ab-2ef605206ee6; Mon, 26 May 2025 15:46:09 +0000 (UTC)
X-Farcaster-Flow-ID: 08b34370-89c3-4dcc-b1ab-2ef605206ee6
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 15:46:08 +0000
Received: from [192.168.137.81] (10.85.143.178) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 15:46:04 +0000
Message-ID: <5a2c3ffd-bdcb-4ad2-b163-3c1db7b3b671@amazon.com>
Date: Mon, 26 May 2025 18:45:59 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
 <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
 <20250520091638.GF7435@unreal>
 <9ae80a03-e31b-4f33-8900-541a27e30eac@amazon.com>
 <20250525175210.GA9786@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250525175210.GA9786@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 5/25/2025 8:52 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Wed, May 21, 2025 at 06:19:51PM +0300, Margolin, Michael wrote:
>> On 5/20/2025 12:16 PM, Leon Romanovsky wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Sun, May 18, 2025 at 11:56:56AM +0300, Margolin, Michael wrote:
>>>> On 5/18/2025 9:42 AM, Leon Romanovsky wrote:
>>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>>>
>>>>>
>>>>>
>>>>> On Thu, May 15, 2025 at 02:50:40PM +0000, Michael Margolin wrote:
>>>>>> Add an option to create CQ using external memory instead of allocating
>>>>>> in the driver. The memory can be passed from userspace by dmabuf fd and
>>>>>> an offset.
>>>>> EFA is unique here. This patch is missing description of why it is
>>>>> needed, and why existing solutions if any exist, can't be used.
>>>>>
>>>>> Thanks
>>>> I probably should have explained more, the purpose is creating CQs that
>>>> reside in GPU HBM enabling low latency polling directly by the GPU. EFA
>>>> isn't unique in receiving pre-allocated memory from userspace, the extension
>>>> here is the use of dmabuf for that purpose as a general mechanism that
>>>> allows using memory independent of its source. I will add more info in the
>>>> commit message.
>>> I think that this functionality is worth to have as general verb and not DV.
>>> mlx5 has something similar and now EFA needs it too.
>>>
>>> Let's wait for Jason's response before rushing to implement it.
>>>
>>> Thanks
>> Jason, any thoughts on this?
>>
>> We can probably add optional attributes to create CQ command, but most of
>> the handling will remain vendor specific. I'm not convinced it's beneficial
>> enough.
> I don't know how a general verb would work, CQs in non-dv are polled
> in software in userspace and the userspace will have trouble reaching
> into a dmabuf. Plus the entire point of this is usually to write the
> polling code in a GPU language and run it on a GPU processor.
>
> Meaning I think all users of this will want to use a DV interface from
> verbs.
>
> At that point, is it worth adding more common verbs support?
>
> Though it is becoming a bit messy that drivers are all open coding
> creating normal or dmabuf umems. That part might be worth generalizing
> some more, and then doing QP as well.
>
> Jason

Are you suggesting turning mlx5dv_devx_umem_reg into a common verb 
including the kernel part or some kind of rdma-core level abstraction 
for passing dmabuf+offset+length / address+length to a create CQ/QP 
function?

Michael


