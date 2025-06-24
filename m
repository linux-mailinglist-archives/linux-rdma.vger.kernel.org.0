Return-Path: <linux-rdma+bounces-11596-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F556AE6C9B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073EE188C7EC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B872E2EFA;
	Tue, 24 Jun 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="D+NOoI9C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBD286430
	for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783212; cv=none; b=VbSYTeoZtiiW9jSd2fqnwbSwIDIHEp0isK8PrNq+ILJyRlNPv2xbsfIe0fV/Zrg1VkBwV21N2nbbtP3dEKDvThV1HmOhF+s9vo7A3XeNtcvm5bENCmxZa2hv7FIPrb7qJGm9dVLman9is1f5j+OakGdtbR6JuCw1g6jL1zqxwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783212; c=relaxed/simple;
	bh=e42GuHCoogDpKUTM7QW3cC47N4b2HeFGwtjNei7XhRE=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PAN8EK+rrajRCoPg1DYcteCC7Ro+237bOnvELWqoPXuYzJSFFvBDZDwX/M2dXycK4jtqSmJVxJk/l7odT1IsPoBIdhwMD7gG2llpnRQH5ojDzpzn9ybZ8dOjg9xeJCLvRLrQV9lTy3XMYS29iKi7yf6Kl2MgyHpwcTmpiTYh4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=D+NOoI9C; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750783211; x=1782319211;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=CGsUuGRI37NB0AwBnWjfux5nELtKMnA0L3+d9Ky4dqw=;
  b=D+NOoI9CMSpAGyJpRPq46k66mWU3rc/Em60MIJfCzfAUzPTkm3lKrXCI
   M03Gjjl1dYChljWhufwByMGsE1vs38HA1fU51G7XOz3Iag1cJq6CfU8JK
   riWZkEluf7Ha86ZOtgfk38KiXcMRJZ6oLdhVvGf4kUhm6LBjfAdwU5ZCr
   aECt+qWN7g8EJ5OuTt2j+pSdpLejl6A2yzonnzk14/S5jjdWHMKTkr6cg
   ntYzRUMqPo0Hi09XKtYDEkApvzwPQ92VuEQgWOlUwPxTM35wIv3E78mpe
   1wgnbSAtCcZubFrr4hRBbUEv8GJtYTV3a+bNs/tWcdW/rmi523vA+Qi8I
   g==;
X-IronPort-AV: E=Sophos;i="6.16,262,1744070400"; 
   d="scan'208";a="736642600"
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 16:40:08 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:27561]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.132:2525] with esmtp (Farcaster)
 id 569e6927-d649-4201-bfff-f7b0ebc89338; Tue, 24 Jun 2025 16:40:07 +0000 (UTC)
X-Farcaster-Flow-ID: 569e6927-d649-4201-bfff-f7b0ebc89338
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 24 Jun 2025 16:40:02 +0000
Received: from [192.168.138.203] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 24 Jun 2025 16:39:59 +0000
Message-ID: <c7d312ac-19a0-45e3-9f40-3e6f81500f83@amazon.com>
Date: Tue, 24 Jun 2025 19:39:53 +0300
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
 <5a2c3ffd-bdcb-4ad2-b163-3c1db7b3b671@amazon.com>
 <20250526160816.GA61950@nvidia.com>
 <cb06d3d2-a8c2-459a-af32-bcbbdaa297b6@amazon.com>
 <83eb7ecd-ac1e-4472-a688-bc3f22900546@amazon.com>
 <20250611194704.GQ543171@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250611194704.GQ543171@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 6/11/2025 10:47 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Jun 09, 2025 at 06:03:32PM +0300, Margolin, Michael wrote:
>> On 5/26/2025 7:17 PM, Margolin, Michael wrote:
>>> On 5/26/2025 7:08 PM, Jason Gunthorpe wrote:
>>>> On Mon, May 26, 2025 at 06:45:59PM +0300, Margolin, Michael wrote:
>>>>
>>>>> Are you suggesting turning mlx5dv_devx_umem_reg into a common
>>>>> verb including
>>>>> the kernel part or some kind of rdma-core level abstraction for passing
>>>>> dmabuf+offset+length / address+length to a create CQ/QP function?
>>>> I think Leon was, but I'm not sure that is so worthwhile.
>>>>
>>>> I was thinking more of having the ioctls for things like QP/CQ/MR
>>>> accept a more standard common set of attributes to describe the buffer
>>>> memory and then making it simpler for the driver to get a umem from
>>>> those common attributes.
>>>>
>>>> But EFA is alread sort of different because it normally uses a kernel
>>>> allocated buffer, right?
>>>>
>>>> Jason
>>> Yes, EFA is an example for a driver that doesn't need this on the
>>> "standard" flow.
>>>
>>> Michael
>>>
>> How can we move forward with this patch? It's possible to add additional
>> attributes to the common create CQ ioctl and use it for EFA direct verbs but
>> it won't be easy to move existing drivers to use it.
> Then it becomes hard to make the other drivers reject those new common
> attributes :\
>
> Maybe what you have here is the best, but it really does seem
> unsatisfying from a kernel POV..
>
> Jason

Apologies for a delayed response, I want to make sure we are aligned on 
the solution.

I'm going to add a common option in libibverbs for providers to pass 
buffer info for create CQ ioctl and when the new ioctl attributes are 
set to the kernel, handle it in core code by creating a umem object and 
storing it in CQ context for drivers use.

Does this make sense?


Michael


