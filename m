Return-Path: <linux-rdma+bounces-8655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DFA5F487
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D104919C233B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D17C2676F3;
	Thu, 13 Mar 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERQXSeyR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621F267392;
	Thu, 13 Mar 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869063; cv=none; b=KLO7G5IdgUeDyfWEXtvaa0PukZR0DgaPdk0SYtDU3FLAcFtfztQFjD4J0p5/Glwm+cbw9JYNzknU9QkWUGtXleCzVdOho69QTotuaElUqBody4Or3qkY+8px7iD3Tj1jmff0sKoKMXVh+65omrf+DTKZ8V/mI7eIsB6qQClcuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869063; c=relaxed/simple;
	bh=QgE87WHgL2/gqEFScRfoLhAuXcv2irxjXM40eLEwnIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB9XZVLUJxu+QHA74SL77SxhtTDQjrrpLV3sMFUkkNfoKWs7whkB+DN8qJ6UIacp/EudASas7xWsoRq741VwkKbTDrsNVufyBIsqE3rVoORYDCwFM3LZ1CGF59IiyeZhvWc+V3x6Pu8i/1Ed6Wo74ta191E7lYI9TOBlRFqBgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERQXSeyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABE5C4CEDD;
	Thu, 13 Mar 2025 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869062;
	bh=QgE87WHgL2/gqEFScRfoLhAuXcv2irxjXM40eLEwnIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ERQXSeyRE9t28Z4oqh6LIcVzuMe7PveKvj/B9Jfn9xgkwKMQ0VgYB67mQyHBOqrDO
	 Xj+WHhYlBXSEweu22HgblRQTWSVamuIupvMhWQxOD0uHT2xLIiZVo68tNDi4oT2LAi
	 Lu8q5nBvjgtog41OTrk86HpKkFVjByFVItHOlRO1VDjaYtdTGBTthhbZhm8oQ2I+ZO
	 7KuuomW955duKW0XkrCVFJAMfVBp9I1mTeQXv5v1Rwq6PGOxePjZqH4M3HT4hLytV2
	 somtbxUVY7Vb9DHi3wt59LflIw9uYBFDYkKMoTh+D3QIeAyF0pCAsXm3NHYBQDoEn3
	 Nlc1D69nv8iKQ==
Message-ID: <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
Date: Thu, 13 Mar 2025 13:30:52 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 "Nelson, Shannon" <shannon.nelson@amd.com>,
 "Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org> <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250305182853.GO1955273@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/25 7:28 PM, Leon Romanovsky wrote:
> On Wed, Mar 05, 2025 at 11:17:19AM -0700, David Ahern wrote:
>> On 3/5/25 8:08 AM, Jiri Pirko wrote:
>>> Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
>>>> On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
>>>>> I thought you were arguing that me opposing the addition was
>>>>> "maintainer overreach". As in me telling other parts of the kernel
>>>>> what is and isn't allowed. Do I not get a say what gets merged under
>>>>> drivers/net/ now?
>>>>
>>>> The PCI core drivers are a shared resource jointly maintained by all
>>>> the subsytems that use them. They are maintained by their respective
>>>> maintainers. Saeed/etc in this case.
>>>>
>>>> It would be inappropriate for your preferences to supersede Saeed's
>>>> when he is a maintainer of the mlx5_core driver and fwctl. Please try
>>>> and get Saeed on board with your plan.
>>>>
>>>> If the placement under drivers/net makes this confusing then we can
>>>> certainly change the directory names.
>>>
>>> According to how mlx5 driver is structured, and the rest of the advanced
>>> drivers in the same area are becoming as well, it would make sense to me
>>> to have mlx5 core in separate core directory, maintained directly by driver
>>> maintainer:
>>> drivers/core/mlx5/
>>> then each of the protocol auxiliary device lands in appropriate
>>> subsystem directory.
>>
>> +1
>>
>> This is how I have structured our drivers -- core driver for owning the
>> PCI device and hosting the APIs to communicate with hardware, an aux bus
>> and then smaller subsystem focused drivers for the aux devices that make
>> the device usable from different contexts.
>>
>> I think we are ready to start upstreaming, but I am waiting to see how
>> this falls out - to see if our core driver can land in a non-subsystem
>> specific location (e.g., drivers/core) or if it needs to go with fwctl
>> as a generic location.
> 
> Do it right, and push it to drivers/core. I'm aware of at least one
> driver from huge company (not Nvidia) which is in preparation phase
> before upstreaming, and will fit nicely into this model.
> 
> They have separated blocks for PCI, eth, RDMA and GPU.
> 

Adding that group here after an offlist discussion with that team. If I
understand correctly, their preferred driver breakout is:


      ┌───────────────────────────────────────────────────────────┐
      │                      Platform Driver                      │
      │                      habanalabs                           │
      └────────▲───────────────────▲────────────────────▲─────────┘
               │AUX                │AUX                 │AUX
      ┌────────┴────────┐ ┌────────┴────────┐ ┌─────────┴─────────┐
      │ Accel Driver    │ │ Ethernet Driver │ │ InfiniBand Driver │
      │ habanalabs_accel│ │ habanalabs_en   │ │ habanalabs_ib     │
      └─────────────────┘ └─────────────────┘ └───────────────────┘

So that means 3 different vendors and 3 different devices looking for a
similar auxbus based hierarchy with a core driver not buried within one
of the subsystems.

I guess at this point we just need to move forward with the proposal and
start sending patches.

Seems like drivers/core is the consensus for the core driver?


