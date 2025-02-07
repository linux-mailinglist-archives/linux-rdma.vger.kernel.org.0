Return-Path: <linux-rdma+bounces-7563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83430A2D007
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 22:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950CE3A18D0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E751B3953;
	Fri,  7 Feb 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnQJA/fD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A0198E81;
	Fri,  7 Feb 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965073; cv=none; b=jW126DzWMjFoadKpKDpnJgE+4JRq7ygj2kbWUoKjUftmSApHzGwz9kfCbGW9c06ZAXQ0DUNvMf5ljtp6eihO3mi3llLVaegazebC8BHTYPCt4ZSAm3pDrs7e5pYIZ2c709NCZSHnjYb2+5gENy0525yDuRN4p3sTf+e2yjLSifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965073; c=relaxed/simple;
	bh=Xd9l4BkgkbMgLlaNm12ePVFNk6xlFav2cKgpU5NaF4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeSkc3B+Tec5LEeuXIkkjRokShalnFpOBdLEAA8xXbyIa7UmOQf5AvhMCstgCgtbWN6fTxS/X2eSBofsOwURIU12/SI15ssofjfdQOwvyhyR6dMjbQeaz920qb6Vi3AA5rUQhZ8mACqe7kH3o/gzRGCokCpddwQO08awkpmfTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnQJA/fD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C03FC4CED1;
	Fri,  7 Feb 2025 21:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965072;
	bh=Xd9l4BkgkbMgLlaNm12ePVFNk6xlFav2cKgpU5NaF4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jnQJA/fDotJQ+xSTIXNPxG3KDffavGdkcPxXohISPPuZUQeUng6ViLGAvNmZYDmyp
	 qIFndNIeorH/CHDmFL0dh4hSkEVz6PHq7b/rHZcOiyIJ4CcR12EK5nFYZrjSGPhDTA
	 rj0lOsC2KCoKmVXS9AK4Ykc7yV1nualxPFCgKC2XPmUaIIM+Psk7odcrbKlbJJntoO
	 3AMaUCB8JKBshELq3JUl6dKkeGjpXG+6q9RcaREUUZe4mNO3vas9Sbs1/6RQikGI66
	 6ljAhzwOtjqSbHWPoOjYTrGfZkWY8rAlYoztylijIYbypZQuOKhaAXhLDXIQOVu0RJ
	 DHrcT/YiKJ3GA==
Date: Fri, 7 Feb 2025 13:51:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>, Dan Williams
 <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave
 Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, Andy
 Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, "Nelson, Shannon"
 <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for
 fwctl_bnxt
Message-ID: <20250207135111.6e4e10b9@kernel.org>
In-Reply-To: <Z6ZsOMLq7tt3ijX_@x130>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<20250206164449.52b2dfef@kernel.org>
	<CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
	<20250207073648.1f0bad47@kernel.org>
	<Z6ZsOMLq7tt3ijX_@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 12:25:28 -0800 Saeed Mahameed wrote:
> >nVidia is already refusing to add basic minoring features to their
> >upstream driver, and keeps asking its customers to migrate to libdoca.  
>
> nVidia is one of the top contributers to netdev,

That's inaccurate. I can't think of a single meaningful contribution
from nVidia's NIC team outside of your own driver in the last 2 years.

> we submit patches on weekly bases and due to netdev mailing list
> review backlog and policy we barely make quota,

Luckily we have development statistics so we don't have to argue:

Top reviewers (cs):                  Top reviewers (msg):                
   1 ( +1) [27] Meta                    1 ( +1) [68] Meta                
   2 ( -1) [25] RedHat                  2 ( -1) [57] RedHat              
   3 ( +1) [19] Intel                   3 ( +2) [49] Intel               
   4 ( -1) [15] Andrew Lunn             4 (   ) [43] Andrew Lunn         
   5 (   ) [12] Google                  5 ( -2) [32] Google              
   6 ( +2) [ 5] Linaro                  6 ( +3) [13] NXP                 
   7 ( +3) [ 4] Oracle                  7 ( +5) [13] Oracle              

Top authors (cs):                    Top authors (msg):                  
   1 (   ) [9] RedHat                   1 (   ) [48] Intel               
   2 ( +2) [8] Google                   2 (   ) [42] RedHat              
   3 ( -1) [7] Intel                    3 ( +1) [39] Meta                
   4 ( -1) [7] Meta                     4 ( -1) [31] Huawei              
   5 ( +2) [5] nVidia                   5 (   ) [31] nVidia              
   6 ( +7) [3] Oracle                   6 (+11) [28] Oracle              
   7 ( +9) [2] Linaro                   7 (+15) [23] Pengutronix         
        
Top scores (positive):               Top scores (negative):              
   1 ( +1) [329] Meta                   1 (   ) [92] Huawei              
   2 ( +1) [265] Andrew Lunn            2 ( +1) [76] OpenVPN             
   3 ( -2) [238] RedHat                 3 (***) [54] Pengutronix         
   4 ( +3) [125] Intel                  4 ( +2) [53] Marvell             
   5 ( -1) [116] Google                 5 ( +5) [50] Dent                
   6 ( -1) [ 70] Linaro                 6 (***) [45] nVidia              
   7 ( -1) [ 39] Broadcom               7 (+12) [43] AMD            

https://lore.kernel.org/all/20250121200710.19126f7d@kernel.org/

nVidia has a negative review vs authorship score. It'd probably 
be much worse if it wasn't for the work of the switch team.

> so please elaborate on what features we are refusing to do ??

nVidia likes to send these threads to my management so I need 
to be careful. An issue was discovered during new platform evaluation.
That's all I'm gonna say.

> As explained above, netdev doesn't need it, but netdev subsystem also
> hosts the pci base drivers, so you are going to see fwctl patches the
> same as you see rdma and other non netdev patches flowing through
> netdev ML.

Sure, but we're deadlocked here. It may be a slight inconvenience to
redo the interface so that its not a standalone aux bus driver. But if
you agree the netdev doesn't need it seems like a fairly straightforward
way to unblock your progress.

I am glad that you at least agree now that nedev doesn't need it.

