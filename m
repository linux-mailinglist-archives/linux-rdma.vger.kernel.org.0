Return-Path: <linux-rdma+bounces-11099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D67BAD21FC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jun 2025 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C123B1DCB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jun 2025 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7BF21B192;
	Mon,  9 Jun 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TAGz925s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EA1A2C0B
	for <linux-rdma@vger.kernel.org>; Mon,  9 Jun 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481426; cv=none; b=WSDUhptA3b7PsolhH6DgXF9xyKNR80xHSnvhacu5JoZ4hiiFpPSxRVKL+wRlWe4GTjq8QNg5HbtxPwt2CakFVwh1bBYq560Dvb6gMUBogsnmY5klRcDBCPQno707zkoreounKoy2IlQZnz3MGok3kj+jSttf7uAGX7/uiEkJHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481426; c=relaxed/simple;
	bh=jZD9YF/rqj0sE4oZrg1j6Tte0F5iZ9HdpG9ZM4zA0EI=;
	h=Subject:Message-ID:Date:MIME-Version:From:To:CC:References:
	 In-Reply-To:Content-Type; b=cEwqrHciWK+p0JLqM7yZL/vFS4PRYywb8qhju+lviHKRlA4mKHvxdCyyMmjzNSvKHx3reuQTbe6CKJqPH+6TSxFrt2CSUdHCJVnPl83cINgfLOocH5m4mKFW6m8gCCS1x0X1NTkOT4EluL5/GiL216+LLZIKT15gCcEOW8ZWHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TAGz925s; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749481425; x=1781017425;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=YUShQivZ4+5u2RwsGUd2cBSMBmaaHPLaJvCFz3PlBkU=;
  b=TAGz925sdRQuCI3OszkM6mmSih62k+G0Xm6/SlbheYR5t7G6F5P+nK6V
   Unv3/0lb2d6qT8np5IaQIideh4HwhSZKQ0WICfAoqIZPqaNtWCc/Niz9B
   Z96jrx0EzBdaPPJvoG38Kz4rqtfvns21ON+rWvW30B7gAf8WXswOPdFCC
   9nzJwKR8bVROyLcjMxabj/MevyxMiUJvfnLW/jPoe+hUL+Pt9YgXqoi96
   NIxSo+PC51p19zDpKQ41iZO0tseXt0NYnwpbA7ZM3IjXLvPmKPhGHq93W
   FzXLFPpVZWf5hy+i455MyGlqlWw/M1410waogOkSKH2A6aDUwsld+oG8E
   g==;
X-IronPort-AV: E=Sophos;i="6.16,222,1744070400"; 
   d="scan'208";a="59412295"
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 15:03:42 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:16496]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.164:2525] with esmtp (Farcaster)
 id 3999e068-e7b3-4b0b-b08b-9519c48900fc; Mon, 9 Jun 2025 15:03:41 +0000 (UTC)
X-Farcaster-Flow-ID: 3999e068-e7b3-4b0b-b08b-9519c48900fc
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 9 Jun 2025 15:03:41 +0000
Received: from [192.168.122.212] (10.85.143.175) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 9 Jun 2025 15:03:37 +0000
Message-ID: <83eb7ecd-ac1e-4472-a688-bc3f22900546@amazon.com>
Date: Mon, 9 Jun 2025 18:03:32 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Margolin, Michael" <mrgolin@amazon.com>
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
Content-Language: en-US
In-Reply-To: <cb06d3d2-a8c2-459a-af32-bcbbdaa297b6@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 5/26/2025 7:17 PM, Margolin, Michael wrote:
>
> On 5/26/2025 7:08 PM, Jason Gunthorpe wrote:
>> CAUTION: This email originated from outside of the organization. Do 
>> not click links or open attachments unless you can confirm the sender 
>> and know the content is safe.
>>
>>
>>
>> On Mon, May 26, 2025 at 06:45:59PM +0300, Margolin, Michael wrote:
>>
>>> Are you suggesting turning mlx5dv_devx_umem_reg into a common verb 
>>> including
>>> the kernel part or some kind of rdma-core level abstraction for passing
>>> dmabuf+offset+length / address+length to a create CQ/QP function?
>> I think Leon was, but I'm not sure that is so worthwhile.
>>
>> I was thinking more of having the ioctls for things like QP/CQ/MR
>> accept a more standard common set of attributes to describe the buffer
>> memory and then making it simpler for the driver to get a umem from
>> those common attributes.
>>
>> But EFA is alread sort of different because it normally uses a kernel
>> allocated buffer, right?
>>
>> Jason
>
> Yes, EFA is an example for a driver that doesn't need this on the 
> "standard" flow.
>
> Michael
>
How can we move forward with this patch? It's possible to add additional 
attributes to the common create CQ ioctl and use it for EFA direct verbs 
but it won't be easy to move existing drivers to use it.


Michael


