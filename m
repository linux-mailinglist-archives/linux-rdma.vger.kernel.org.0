Return-Path: <linux-rdma+bounces-8381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A5A50CAF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 21:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192D716FA2A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC4254AEC;
	Wed,  5 Mar 2025 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqVQF5do"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F216426;
	Wed,  5 Mar 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207297; cv=none; b=VaIqJByYeGQ6+R8IUKm3ju1/4t6SryA8bo/bh1bq6P+2BATPGc+D5L0+0uwnbwcDT19gGZPk/KAiNGx/a8oEAAzsEJv8Hb1I5YlUqE8w4ocFPM9+QmlYqpc9OXVhhLTblUlA3Xea//nHAdDhEXDXnNJpXS1oamzqu6tTgYxXxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207297; c=relaxed/simple;
	bh=A39m//OQ/IH5GlT3VMR17M5XQFlQF1vBGczLPvzKayo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6yaP3q0QK+UUdew+/fIXYnyIH6cIoTEJuvhzzTZ2Owj1UHoU/jroyrflimul3uYrxllz3b0AnptWAP40tfqn029rnM5S3hAcbGALflR0ewg3vR7MRSNVLhK55EYNmdiNM0TmOZBBUkcyoKZUHKHu8wUqKmfLC5QwOJrsPiAnfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqVQF5do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE03C4CED1;
	Wed,  5 Mar 2025 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741207296;
	bh=A39m//OQ/IH5GlT3VMR17M5XQFlQF1vBGczLPvzKayo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqVQF5do4DlvHhKJWfrfVYRi2pyew+zez5m3e0KrRDJsb5NdEzuRzMxn0GQrrMERn
	 hK5AQy74UQuvl2p4fqJsxARf2D0VXYVxhqiAPyNnCk6QT8U+Zqssszb6bVSYG6EW3r
	 lc2y33HPiTj+ZROEiS/8CSHhLddi/0fC7QrWA8oy1fUSwUZqkkM8kPy4tfbIV9eono
	 gc5AgIbV+pKCDx3ONBdl7Nb5jXwnBTUqsKyON/vzB+/XeTCC58xyjKw1iNlJ+QQPvK
	 9QlnDwFqkV2ydVJjporDzGUkDQZeo+OHgTid/20aLHTESgG2SFzIYJ0B9ztzcZR7Pp
	 gprr9JI/pgmYg==
Date: Wed, 5 Mar 2025 12:41:35 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <Z8i2_9G86z14KbpB@x130>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250305182853.GO1955273@unreal>

On 05 Mar 20:28, Leon Romanovsky wrote:
>On Wed, Mar 05, 2025 at 11:17:19AM -0700, David Ahern wrote:
>> On 3/5/25 8:08 AM, Jiri Pirko wrote:
>> > Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
>> >> On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
>> >>> I thought you were arguing that me opposing the addition was
>> >>> "maintainer overreach". As in me telling other parts of the kernel
>> >>> what is and isn't allowed. Do I not get a say what gets merged under
>> >>> drivers/net/ now?
>> >>
>> >> The PCI core drivers are a shared resource jointly maintained by all
>> >> the subsytems that use them. They are maintained by their respective
>> >> maintainers. Saeed/etc in this case.
>> >>
>> >> It would be inappropriate for your preferences to supersede Saeed's
>> >> when he is a maintainer of the mlx5_core driver and fwctl. Please try
>> >> and get Saeed on board with your plan.
>> >>
>> >> If the placement under drivers/net makes this confusing then we can
>> >> certainly change the directory names.
>> >
>> > According to how mlx5 driver is structured, and the rest of the advanced
>> > drivers in the same area are becoming as well, it would make sense to me
>> > to have mlx5 core in separate core directory, maintained directly by driver
>> > maintainer:
>> > drivers/core/mlx5/
>> > then each of the protocol auxiliary device lands in appropriate
>> > subsystem directory.
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
>Do it right, and push it to drivers/core. I'm aware of at least one
>driver from huge company (not Nvidia) which is in preparation phase
>before upstreaming, and will fit nicely into this model.
>

How do you imagine this driver/core structure should look like? Who will be
the top dir maintainer? It should be something that is tightly coupled with
aux, currently aux is under drivers/base/auxiliary.c I think it should move 
to drivers/aux/auxiliary.c and device drivers should implement their own
aux buses, WH access APIs and probing/init logic under that directory
e.g: drivers/aux/mlx5/..


