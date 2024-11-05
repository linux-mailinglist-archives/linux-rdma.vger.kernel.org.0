Return-Path: <linux-rdma+bounces-5761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B639BCBA9
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 12:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174131C22AB8
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741C1D358D;
	Tue,  5 Nov 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvSqOd+F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8031C231D;
	Tue,  5 Nov 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805800; cv=none; b=lqUVei4tEPoD1z36CZglAebRUBTeByvCbbofY4pWuqj5imV0t8UjebdRAQibLjvInUTuU+Fzv/p+3VYH5E0xI/zFXa87vrOCDho2OZJDG70vS464ViABAWjELb4QoF4ps52Y4qp/l/fv/VO1iA6muYNpApEfmhq4SYCZvWP5B8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805800; c=relaxed/simple;
	bh=Q4eFHakxqG1dy0iztrcXVHW6AoWr7/YCu3Tso2wXTes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SksMdnbddaq0QaW5FLPX2CVhVRFMoXN6IxxZRGOH467SXNxQZJceQ1S0G10c+cIdlssUC3/+wT/2DGSBMysIVBX4v6LUvSclGo3+dPh4EfOEmPmU9ONWMwoVOx3PEb9qVpdcLleRTJZ5JjNJwL+AbooVWgiR2fmOfUyNAnOXY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvSqOd+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37746C4CECF;
	Tue,  5 Nov 2024 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730805799;
	bh=Q4eFHakxqG1dy0iztrcXVHW6AoWr7/YCu3Tso2wXTes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvSqOd+FpiQYVvwsnR9O/gyWLdcHj2QAEsch1GsCYnZEKsLfggk7QMRwPMWpqLXzb
	 byx45L3BnNdxMjSd7VqPXJGMCGqbWkpdOuRnMplz9NK1Hj+gU7ttzixvdXnt6C2OPi
	 HL5o47VMSW7FJ5uq0/jE/1inQFqTe0tPagqtRjYjJ0gUL6Z6ViA2PceFEsCgV6pS7Z
	 ZAuEac/TpBfolAonnqg4Me+1LKmLQaH4D8nInbN09OdEEBEtebhJVvlpZTBSg6QeOE
	 HShknlEUbyHR3o5w1TEePyclgcQcBMhOWZWVyY2Co7I0+u0j47D2Ez+1guGHSxrJvh
	 xSAsuPuWQ4mSQ==
Date: Tue, 5 Nov 2024 13:23:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241105112313.GE311159@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>

On Tue, Nov 05, 2024 at 10:50:45AM +0100, Wenjia Zhang wrote:
> 
> 
> On 27.10.24 21:18, Leon Romanovsky wrote:
> > On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:
> > > Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> > > alternative to get_netdev") introduced an API ib_device_get_netdev.
> > > The SMC-R variant of the SMC protocol continued to use the old API
> > > ib_device_ops.get_netdev() to lookup netdev.
> > 
> > I would say that calls to ibdev ops from ULPs was never been right
> > thing to do. The ib_device_set_netdev() was introduced for the drivers.
> > 
> > So the whole commit message is not accurate and better to be rewritten.
> > 
> > > As this commit 8d159eb2117b
> > > ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> > > get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> > > ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> > > device driver.
> > 
> > It is not a correct statement too. All modern drivers (for last 5 years)
> > don't have that .get_netdev() ops, so it is not mlx5 specific, but another
> > justification to say that SMC-R was doing it wrong.
> > 
> > > Thus, using ib_device_set_netdev() now became mandatory.
> > 
> > ib_device_set_netdev() is mandatory for the drivers, it is nothing to do
> > with ULPs.
> > 
> > > 
> > > Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> > 
> > It is too late for me to do proper review for today, but I would say
> > that it is worth to pay attention to multiple dev_put() calls in the
> > functions around the ib_device_get_netdev().
> > 
> > > 
> > > Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> > > Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> > 
> > It is not related to this change Fixes line.
> > 
> 
> Hi Leon,
> 
> Thank you for the review! I agree that SMC could do better. However, we
> should fix it and give enough information and reference on the changes,
> since the code has already existed and didn't work with the old way. 

The code which you change worked by chance and was wrong from day one.

> I can rewrite the commit message.
> 
> What about:
> "
> The SMC-R variant of the SMC protocol still called
> ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device driver
> to run SMC-R, it failed to find a device, because in mlx5_ib the internal
> net device management for retrieving net devices was replaced by a common
> interface ib_device_get_netdev() in commit 8d159eb2117b ("RDMA/mlx5: Use IB
> set_netdev and get_netdev functions"). Thus, replace
> ib_device_ops.get_netdev() with ib_device_get_netdev() in SMC.
> "

 The SMC-R variant of the SMC protocol used direct call to ib_device_ops.get_netdev()
 function to lookup netdev. Such direct accesses are not correct for any
 usage outside of RDMA core code. 

 RDMA subsystem provides ib_device_get_netdev() function that works on
 all RDMA drivers returns valid netdev with proper locking an reference
 counting. The commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev
 functions") exposed that SMC-R didn't use that function.

 So update the SMC-R to use proper API,

Thanks

