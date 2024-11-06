Return-Path: <linux-rdma+bounces-5813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD29BEFB1
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 14:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE131B233EA
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1A20126D;
	Wed,  6 Nov 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az+W8Gto"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEF201116;
	Wed,  6 Nov 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901556; cv=none; b=K9gvn5VuvYcrMTf2awaGAPfjrG/q3BIAv249A6OZq28i7WoamAExUegQNKmB5Te6RS0ZHd1rX/Es2MCT9NXJYkh8bcHYTLIQdMsX+5T6wpSdsksdKyHY18psQqCJpBh7IScTlYTIUHv9sZu8lnFHNSLocvp7yzyGQSLoqWCPjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901556; c=relaxed/simple;
	bh=Ypi8TKGo3g8F9OHU6rjov6A0/pgWfbKDn7l6s0WRkKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiocB2Za9xISfnFPhMCkXSmP4uWLAA5xf+LwQG0fcEyVvW+Rcjv24VN0sEhu6Ftm4RRn+g4DbH42CHckqTfoBwyIhpYgCGNYErL359gwclOEtiM1g3xNnUtWT55tBqAF8QOmIQFxbklVxwVdkjym3LEBVjh5SRyQaxMy0WZfRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az+W8Gto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728BEC4CECC;
	Wed,  6 Nov 2024 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730901556;
	bh=Ypi8TKGo3g8F9OHU6rjov6A0/pgWfbKDn7l6s0WRkKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=az+W8GtoQJLib+LwIbWagqpPHea2qAsKjvw8b4waSSwTtKu6rFS1MEVnXdNnvERvq
	 IT7+AnmSpbR9dosbMJ+sucPwchYywY/VkfeogYxHnzb/mPzChyRfg46e0E5muoTQrv
	 Rpcmmw2IV/PhXP+V/YywfBoyANHJGGpsj9smONbEXESMO3g7AsyJUUhVGsoJXJwJnl
	 TvuAClXYG2adXtJ5R2lT9W/hzOWKVn8FPkVxIIrfwfD4FAqntk1FVhKpvrP9yzo9wy
	 f7Zxmu8RXPTJxY6uk33vD4GLbY0MnG9ZY7wGI4VWFaWA9/9Gv5Yd4TfN6565YqRuIz
	 AAIqKg92auG7A==
Date: Wed, 6 Nov 2024 15:59:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241106135910.GF5006@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
 <20241105112313.GE311159@unreal>
 <20241106102439.4ca5effc.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106102439.4ca5effc.pasic@linux.ibm.com>

On Wed, Nov 06, 2024 at 10:24:39AM +0100, Halil Pasic wrote:
> On Tue, 5 Nov 2024 13:23:13 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Tue, Nov 05, 2024 at 10:50:45AM +0100, Wenjia Zhang wrote:
> > > 
> > > 
> > > On 27.10.24 21:18, Leon Romanovsky wrote:  
> > > > On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:  
> > > > > Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as
> > > > > an alternative to get_netdev") introduced an API
> > > > > ib_device_get_netdev. The SMC-R variant of the SMC protocol
> > > > > continued to use the old API ib_device_ops.get_netdev() to
> > > > > lookup netdev.  
> > > > 
> > > > I would say that calls to ibdev ops from ULPs was never been right
> > > > thing to do. The ib_device_set_netdev() was introduced for the
> > > > drivers.
> > > > 
> > > > So the whole commit message is not accurate and better to be
> > > > rewritten. 
> > > > > As this commit 8d159eb2117b
> > > > > ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> > > > > removed the get_netdev callback from
> > > > > mlx5_ib_dev_common_roce_ops, calling ib_device_ops.get_netdev
> > > > > didn't work any more at least by using a mlx5 device driver.  
> > > > 
> > > > It is not a correct statement too. All modern drivers (for last 5
> > > > years) don't have that .get_netdev() ops, so it is not mlx5
> > > > specific, but another justification to say that SMC-R was doing it
> > > > wrong. 
> > > > > Thus, using ib_device_set_netdev() now became mandatory.  
> > > > 
> > > > ib_device_set_netdev() is mandatory for the drivers, it is nothing
> > > > to do with ULPs.
> > > >   
> > > > > 
> > > > > Replace ib_device_ops.get_netdev() with ib_device_get_netdev().  
> > > > 
> > > > It is too late for me to do proper review for today, but I would
> > > > say that it is worth to pay attention to multiple dev_put() calls
> > > > in the functions around the ib_device_get_netdev().
> > > >   
> > > > > 
> > > > > Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> > > > > Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and
> > > > > get_netdev functions")  
> > > > 
> > > > It is not related to this change Fixes line.
> > > >   
> > > 
> > > Hi Leon,
> > > 
> > > Thank you for the review! I agree that SMC could do better. However,
> > > we should fix it and give enough information and reference on the
> > > changes, since the code has already existed and didn't work with the
> > > old way.   
> > 
> > The code which you change worked by chance and was wrong from day one.
> 
> I absolutely agree with that statement. But please notice that the
> commit date of commit c2261dd76b54 ("RDMA/device: Add
> ib_device_set_netdev() as an alternative to get_netdev") predates the
> commit date of commit 54903572c23c ("net/smc: allow pnetid-less
> configuration") only by 9 days. And before commit c2261dd76b54
> ("RDMA/device: Add ib_device_set_netdev() as an alternative to
> get_netdev") there was no 
> ib_device_get_netdev() AFAICT.

It doesn't make it right.

1. While commit c2261dd76b54 was submitted and discussed, RDMA was not CCed.
2. Author didn't try to add his version of ib_device_get_netdev() as it
is done for all APIs exposed by RDMA core.

> 
> Maybe the two patches crossed mid air so to say.
> 
> > 
> > > I can rewrite the commit message.
> > > 
> > > What about:
> > > "
> > > The SMC-R variant of the SMC protocol still called
> > > ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device
> > > driver to run SMC-R, it failed to find a device, because in mlx5_ib
> > > the internal net device management for retrieving net devices was
> > > replaced by a common interface ib_device_get_netdev() in commit
> > > 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev
> > > functions"). Thus, replace ib_device_ops.get_netdev() with
> > > ib_device_get_netdev() in SMC. "  
> > 
> >  The SMC-R variant of the SMC protocol used direct call to
> > ib_device_ops.get_netdev() function to lookup netdev. Such direct
> > accesses are not correct for any usage outside of RDMA core code. 
> > 
> 
> I agree, it is not correct since c2261dd76b54 ("RDMA/device: Add
> ib_device_set_netdev() as an alternative to get_netdev").
> 
> Does fs/smb/server/transport_rdma.c qualify as inside of RDMA core code?

RDMA core code is drivers/infiniband/core/*.

> I would guess it is not, and I would not actually mind sending a patch
> but I have trouble figuring out the logic behind  commit ecce70cf17d9
> ("ksmbd: fix missing RDMA-capable flag for IPoIB device in
> ksmbd_rdma_capable_netdev()").

It is strange version of RDMA-CM. All other ULPs use RDMA-CM to avoid
GID, netdev and fabric complexity.

> 
> 
> >  RDMA subsystem provides ib_device_get_netdev() function that works on
> >  all RDMA drivers returns valid netdev with proper locking an reference
> >  counting. The commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and
> > get_netdev functions") exposed that SMC-R didn't use that function.
> > 
> 
> I believe the intention was this all along. I think the commit message
> was written with the idea that 54903572c23c happened before c2261dd76b54
> which is not the case.
> 
> >  So update the SMC-R to use proper API,
> > 
> 
> I believe this is exactly what the patch does! And I agree we need to
> improve on the commit message.
> 
> Regards,
> Halil

