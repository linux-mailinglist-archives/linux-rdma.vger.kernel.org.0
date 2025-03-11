Return-Path: <linux-rdma+bounces-8578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C4CA5BED8
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 12:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F42C3B1E73
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCE253B46;
	Tue, 11 Mar 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fegP+FAF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90442512C9;
	Tue, 11 Mar 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692207; cv=none; b=NWpjXPHoaOE8UnxvACL6mpg25NAu2R3kIvaUhUs+oF7XAf4pH0tNWuKrW3BTlO/Bcihtu0Qo2KWkCb2XNSYz7uZ+1mljMXECjMzohAvw5lSOEq0/Mav6iLoKCWSB3pYGVTjTOJDMvwJb85d2eWIjnXCdmBfCSq+VFhgwCP76Y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692207; c=relaxed/simple;
	bh=j3dY8JEj49BUDjlILsGdzU2dMHu1fR7oCnu9tJ5XMew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/YO5aK/mx0POctuZB8qVmJm0B70rgMrpdcswlCpdSbERSi/gqgQS/IuO89wQr/CDN3o/jNxag+vmGuR/trzaLG+Idb2V0PmZITN+7JUaeUejlC6wdIIqaT+Pd853cnjQXURJV4icforKNCTku2MUHM9Fo36vCuLWfv7w6KXGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fegP+FAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE689C4CEEB;
	Tue, 11 Mar 2025 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741692207;
	bh=j3dY8JEj49BUDjlILsGdzU2dMHu1fR7oCnu9tJ5XMew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fegP+FAF9d3QJy/e2qB1EOF1A9Dan7OuagnmCb9ppnF3e328TM/DojAWy0gd8okW2
	 fJGWzGBWT8AQj/HDE9U6YnSXdexDIeDURqESTnBzxsso45wTYjyxRMVCs3PzloSfnL
	 GDnUc94IU7SBx3JYqjis+Hc4a2BNTXvlK7lT1Mlrgi7JPx3pHSXhEb3XbMRUZKbwMb
	 kJfWuAxNSa0XNHF1vGeGI8vj/nzbpDxv7WSU2xkO8KUK1j/Sdnjv2enCyZmiN2VBzi
	 aCGnvuSFmZCUb/NSAYjwE07KXByUhjRqIHDAHOzNajmMnT4jiajxzhVVv1T4HsfUh1
	 JkZGI+iCnRaTA==
Message-ID: <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
Date: Tue, 11 Mar 2025 12:23:19 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeed@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
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
 "Nelson, Shannon" <shannon.nelson@amd.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org> <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal> <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250305232154.GB354511@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 12:21 AM, Jason Gunthorpe wrote:
> On Wed, Mar 05, 2025 at 12:41:35PM -0800, Saeed Mahameed wrote:
> 
>> How do you imagine this driver/core structure should look like? Who
>> will be the top dir maintainer?
> 
> I would set something like this up more like DRM. Every driver
> maintainer gets commit rights, some rules about no uAPIs, or at least
> other acks before merging uAPI. Use the tree for staging shared
> branches.

why no uapi? Core driver can have knowledge of h/w resources across all
use cases. For example, our core driver supports a generid netlink based
dump (no set operations; get and dump only so maybe that should be the
restriction?) of all objects regardless of how created -- netdev, ib,
etc. -- and with much more detail.

> 
> Driver maintainers with the most commits per cycle does the PR or
> something like that.
> 
> There is no subsystem or cross-driver entanglement so there is no real
> need for gatekeeping.
> 
> It would be a good opportunity to help more people engage with the
> kernel process and learn the full maintainer flow.
> 
>> It should be something that is tightly coupled with aux, currently
>> aux is under drivers/base/auxiliary.c I think it should move to
>> drivers/aux/auxiliary.c and device drivers should implement their
>> own aux buses, WH access APIs and probing/init logic under that
>> directory e.g: drivers/aux/mlx5/..
> 
> That makes sense to me. I would expect everything in this collection
> to be PCI drivers spawing aux devices.
> 
> drivers/aux_core/ or something like that, perhaps?
> 

drivers/aux_core works for me; removes the 'pci' assumption and makes it
clear the real attribute here is use of the aux bus with subsystem
specific devices. I am still not clear on how such a branch will work -
e.g. We will want multi-vendor review, not just merge the PR and go.


