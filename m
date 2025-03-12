Return-Path: <linux-rdma+bounces-8599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9808A5D97D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 10:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051C91786C7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799323497B;
	Wed, 12 Mar 2025 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcQTqom4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06BA17BB6;
	Wed, 12 Mar 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771919; cv=none; b=NgbenV7+L/XWCAgtWKGBiQkbhSRcmt30qGgm5yoUT/rU88zMnSXZv6dIv28EQOihTD2Qlrpxkl8b+5U3bLzLPEtZkbTaECI2twR9gBYfdy1hVnY5PiFXKb8mJyDVyeb54+tndFTpSKGfib4cudH+soPU2sJvDiOTYg4M6+KXa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771919; c=relaxed/simple;
	bh=a8la2ZObEdG8OdZGXYDKwin8N4HvmajFwbUHnUuC4ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWZuFsj4MUDf4p7b/5rEC7zFOxOcLaonG/bzlo72+vgR0vrOYQNBODCAb1IHB1hnjdgX0R6HFFtatIfQVeOORSqjh3ifknzxKrRZRqAjM43jmkgldXzoROIec4M5e6oj9QVizOU/4Ot2epFOpmbW6KAsYtUo9qRazz6iA4kKzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcQTqom4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6DFC4CEED;
	Wed, 12 Mar 2025 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741771918;
	bh=a8la2ZObEdG8OdZGXYDKwin8N4HvmajFwbUHnUuC4ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fcQTqom47KIERjVZAwkC7vNZuA57ejpLyDrP/gzthj3C0Ruk3ux1Q81fFkjp7fp1d
	 1cfez12QBRYhJbR7ajeVDcsW7ZEc0hzP5kGS0iSSm2PaEzo5T2CA53+OpFQ/k2dcqs
	 +8HTOs43DxVD3dEEpeEFGbvhRuj4g7ziRRtSXm8iT7uSmJN6vNa+TDjOr8lY2wa5ei
	 ArTf1F1TsH3gTvJnFeTgWwmN6i5ofmoqz3dPhvKpW3cvyZmTMbFoGc/dBm359C5Y4u
	 hIDNgLJOYfHCMk3REJ3thgNBgjdxbmoQlxbRGdBXPF7EbuQn3Gf2ZmL8iwOUJi8RGV
	 cEUAUKJ06kBmw==
Message-ID: <4c55e1ae-8cc1-463e-b81f-2bbae4ae4eed@kernel.org>
Date: Wed, 12 Mar 2025 10:31:51 +0100
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
Cc: Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeed@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
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
References: <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com> <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal> <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
 <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
 <20250311135921.GF7027@unreal>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250311135921.GF7027@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 2:59 PM, Leon Romanovsky wrote:
> On Tue, Mar 11, 2025 at 12:23:19PM +0100, David Ahern wrote:
>> On 3/6/25 12:21 AM, Jason Gunthorpe wrote:
>>> On Wed, Mar 05, 2025 at 12:41:35PM -0800, Saeed Mahameed wrote:
>>>
>>>> How do you imagine this driver/core structure should look like? Who
>>>> will be the top dir maintainer?
>>>
>>> I would set something like this up more like DRM. Every driver
>>> maintainer gets commit rights, some rules about no uAPIs, or at least
>>> other acks before merging uAPI. Use the tree for staging shared
>>> branches.
>>
>> why no uapi? Core driver can have knowledge of h/w resources across all
>> use cases. For example, our core driver supports a generid netlink based
>> dump (no set operations; get and dump only so maybe that should be the
>> restriction?) of all objects regardless of how created -- netdev, ib,
>> etc. -- and with much more detail.
> 
> Because, we want to make sure that UAPI will be aligned with relevant
> subsystems without any way to bypass them.
> 
> Thanks

I hope there will be an open mind on get / dump style introspection apis
here. Devices can work support and work within limited subsystem APIs
and also allow the dumping of full essential and relevant contexts for a
device.

More specifically, I do not see netdev APIs ever recognizing RDMA
concepts like domains and memory regions. For us, everything is relative
to a domain and a region - e.g., whether a queue is created for a netdev
device or an IB QP both use the same common internal APIs.  I would
prefer not to use fwctl for something so basic.

