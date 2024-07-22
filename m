Return-Path: <linux-rdma+bounces-3935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7849394D7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 22:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61481F21FAB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C63770D;
	Mon, 22 Jul 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ymsfcAQz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BD17BD5;
	Mon, 22 Jul 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680831; cv=none; b=qJkhxImFORyzLzqhDKHktO5SnY6MJTO11VlyfEDMMM3oTx7LM0ScvykJqfcBmZDZdjqzM+BVezYnEbevnFl3ubcCEdNtmjs71WgHNvPnvi0K3FLB5tYthG2SFlTwR0B69oFP9S87gf/hyf8DKzKS9K6ypAo2DpDQZMoDlNCqHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680831; c=relaxed/simple;
	bh=ZM0TEKHIPTb9upIze52L+kcVfI1EmrENKGNYYSecqTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTBIMEL9XT8pk1TXlQxkqzXeAt0jcZxsbcxmz6Lgniy5OaQkDkpOsIAulwKvtcuGYcUexGWY2kaKeAhf0TJ4DCvNxR+vB6d/9zapmVQaBSbnoR4J+F64/Q0oz1JNX0ZGoIpnD9Bq4TWohCJHI9JKv83v+bE7i1KSED94vNg86Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ymsfcAQz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+GiUc2WmyvgkUASQSnB2Oz3syL/kRQ02gJ1uI6Lrwko=; b=ymsfcAQzaJhIg7/WsKWlP+nAAu
	JWd8mlnq+xTX2yQ07mTgWQaujGtdVS/TtZ09hW3xc9F0yCLSWALGdnpK5NATRyYcjYjZVdombE83z
	t/Hh77YIzpwCwaSNGgFd3mXfvP226OgerVrKrBIwmCnfxCn6V+/bH6V3d0HDvyRA5jw6AfUdmVdo0
	I0FQg6RUdfeqt5QPSwxAdNxoPbJ5o41YacI+dQFRqaYKP5MS+K7NTVsX50maNGEU/fQbFtUD9ylly
	3tzMNSFQFAj91Fa0Sm0jaYZMk0QBWcbTJGBAiy1TVi4ZOYW2bENmTO9iO3IJl74ynnmU2TVU9y+Ab
	hbN5Bqtw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVzpb-0000000AVjU-2qib;
	Mon, 22 Jul 2024 20:40:27 +0000
Message-ID: <4e02ac87-2e00-4399-9f6c-a10ef828592b@infradead.org>
Date: Mon, 22 Jul 2024 13:40:26 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] fwctl: Add documentation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <c1a2b518-f258-41f2-8b0c-173f32756f49@infradead.org>
 <20240722161818.GK3371438@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240722161818.GK3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/22/24 9:18 AM, Jason Gunthorpe wrote:
> On Tue, Jun 25, 2024 at 03:04:42PM -0700, Randy Dunlap wrote:
>>> +There are many things this interface must not allow user space to do (without a
>>> +Taint or CAP), broadly derived from the principles of kernel lockdown. Some
>>> +examples:
>>> +
>>> + 1. DMA to/from arbitrary memory, hang the system, run code in the device, or
>>
>> An RPC message is going to run code in the device. Should this say something instead
>> like:
>>
>> download [or load] code to be executed in the device,
> 
> Yeah, it is a hard concept. It is kind of murky as even today's
> devlink flash will let you load untrusted code into the device under
> lockdown AFAICR.
> 
> How about:
> 
>  1. DMA to/from arbitrary memory, hang the system, compromise FW integrity with
>     untrusted code, or otherwise compromise device or system security and
>     integrity.
> 
> Which is a little broader I suppose.

OK, somewhat better.

>>> +The kernel remains the gatekeeper for this interface. If violations of the
>>> +scopes, security or isolation principles are found, we have options to let
>>> +devices fix them with a FW update, push a kernel patch to parse and block RPC
>>
>> fwctl does not do FW updates, is that correct?
> 
> I think it is up to the specific RPCs the device supports. Given there
> is currently no way to marshal a large amount of data it is not a good
> interface for FW update.
> 
> I'd encourage people to use devlink flash more broadly, but I also
> wouldn't go out of the way to block FW update RPCs that might exist
> from here.
> 
> I certainly wouldn't want people to make their own FW update ioctls
> (as still seems to be happening) out of fear they shouldn't use
> fwctl :\

fair enough.

> Looking particularly at mlx5, we've had devlink flash for a long time
> now, but it hasn't suceeded to displace the mlx5 specific tools, for
> whatever reason.
> 
> I grabbed all the changes here thanks!


-- 
~Randy

