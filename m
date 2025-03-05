Return-Path: <linux-rdma+bounces-8373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E019A5097F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 19:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89013A6E53
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6F253B6E;
	Wed,  5 Mar 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6zIwFjV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4E253344;
	Wed,  5 Mar 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198641; cv=none; b=e1mnLNcoJxhDv1xLoJm3lbQuYiCRUKx393Bpe1krPn2MbBFpbXkP2FEkRxz8WHTB5AGpzW8gd/4eJQkgFQrde35bBgHko8VB6zVvZ1Oc4tfPU3doFzxGNNzS7lXFl3alIEASaGZuhGDQWW5LNkQsHQrURMKKpnXt03+xm+xcb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198641; c=relaxed/simple;
	bh=GPQLv6kstfDvBboWvitF+UykNqX7q2xOlqE2DA/uovQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCL4DP6ZQ+3ZPcgGvZQF540HT/u/dupkgHro4MkNp864bI1p0zJqVQxVmxgCMFZq7lDcaMdrB+0x+4vCRlYRubNChnSgna9ulHz7uukHoZT0eNnR2vuG2OjYz5iCR/CritsHZ3bSgaG7FMxHFdFiF80YytuLEbn15SLYZLbR8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6zIwFjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA041C4CED1;
	Wed,  5 Mar 2025 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198641;
	bh=GPQLv6kstfDvBboWvitF+UykNqX7q2xOlqE2DA/uovQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U6zIwFjV5wqtixzdkKTpofFlbyP4Wj/W5GyYH3vn6Uh5c9DxDzrOl/AUy5WGi9KpZ
	 GXB51LqG/zPrfGGexpxHjQNgOej69OcOLaeKONElxEBadn+wnFkTsSXUh05t9+ni5p
	 K+kPIUONnYLKUl9cpwyVLfznGBUYgmPhG3P8k30nSAHYSj5b2tORNaCOumZkDbAeHf
	 xovtvCTARGEAK2MeOJTtj/lDATryLC2tpWQo5QDkuShAKybwootirwCnRYy1y2vHXB
	 hlS2Cz2HnBVVC+zMprgNaNYw+UgkESQR5ojk3DQTwG0cfikMY96Dsx14+7dFn/OwgP
	 C98mI27Gt5iww==
Message-ID: <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
Date: Wed, 5 Mar 2025 11:17:19 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "Nelson, Shannon"
 <shannon.nelson@amd.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org> <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 8:08 AM, Jiri Pirko wrote:
> Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
>> On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
>>> I thought you were arguing that me opposing the addition was
>>> "maintainer overreach". As in me telling other parts of the kernel
>>> what is and isn't allowed. Do I not get a say what gets merged under
>>> drivers/net/ now?
>>
>> The PCI core drivers are a shared resource jointly maintained by all
>> the subsytems that use them. They are maintained by their respective
>> maintainers. Saeed/etc in this case.
>>
>> It would be inappropriate for your preferences to supersede Saeed's
>> when he is a maintainer of the mlx5_core driver and fwctl. Please try
>> and get Saeed on board with your plan.
>>
>> If the placement under drivers/net makes this confusing then we can
>> certainly change the directory names.
> 
> According to how mlx5 driver is structured, and the rest of the advanced
> drivers in the same area are becoming as well, it would make sense to me
> to have mlx5 core in separate core directory, maintained directly by driver
> maintainer:
> drivers/core/mlx5/
> then each of the protocol auxiliary device lands in appropriate
> subsystem directory.

+1

This is how I have structured our drivers -- core driver for owning the
PCI device and hosting the APIs to communicate with hardware, an aux bus
and then smaller subsystem focused drivers for the aux devices that make
the device usable from different contexts.

I think we are ready to start upstreaming, but I am waiting to see how
this falls out - to see if our core driver can land in a non-subsystem
specific location (e.g., drivers/core) or if it needs to go with fwctl
as a generic location.




