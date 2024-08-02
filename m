Return-Path: <linux-rdma+bounces-4191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6C2946126
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5244E281B1D
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522381A34A0;
	Fri,  2 Aug 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV/dypFC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C21A34D2;
	Fri,  2 Aug 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614260; cv=none; b=rHgbRnEO6hKtVrKjwSx1GGbT/S1+n27DD3dJ9/1SNzYWAQbG8bKX56dmyOKlkRd5zOxNlKCoFlKkMMSUMzzBcixuS8uflxHHwUEm9IzcsWr4ZUVNc0RShPHnELeyWeovreFMc4XIhzBKwO8eCuHZhxIYS+s53aMAQIr/9du78CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614260; c=relaxed/simple;
	bh=SygGhejwtugE49KfkjCbD9EIloYT99XipGcKa/8Qp3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8emdCg5Sy8QlvYi8CJ/bMu46XSTdtKMhy0HaEgKMQrajZ2p8Dbmva6m0qfMDDoLS9XyVUEuR6H4Fgi6in+JP+o4rqhcEWwlxvLL4nYtXChimzFXL/xeyP1yd/OW7zcsiC6QESGRsFpe1dpHlCGRH8owSwsFCrTNsoZPwnQG/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV/dypFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA571C32782;
	Fri,  2 Aug 2024 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722614259;
	bh=SygGhejwtugE49KfkjCbD9EIloYT99XipGcKa/8Qp3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YV/dypFCvqgZ0QSl5sAYt59iH5qph/Em1mQCDHFp5p1EXgVTccPJze54MVp9Zr+/I
	 JO8rEQ6tU+2BC7I4+NOVw53jOxNHRZ/LkzvFq8XpQzGw5LpzM6YVwTcKeFxDjjj/oJ
	 IWwoJYKN4Ms3W2TVg8ro4CdBtyY3mIPUjpt6VFeFLEgDiyUttDt/NpVbFODhzh7l7q
	 uAF2iOAUUaXBmjHcqwpa+PCo+a9VHO0vqV+xBgLijA/+2dIMbBiHfxE+klmdgCKqVE
	 z/UKQx7S2bXzi4xvlL8fEnnVdEaVbH+aJoWCwsKAtoAfXYlolgjk/X29WsHcb9vDTK
	 70B1ZSmRoiV7w==
Date: Fri, 2 Aug 2024 18:57:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240802155734.GJ4209@unreal>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240730080038.GA4209@unreal>
 <20240801125829.GA2809814@nvidia.com>
 <20240801172631.GI4209@unreal>
 <20240802145946.000002e7@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802145946.000002e7@Huawei.com>

On Fri, Aug 02, 2024 at 02:59:46PM +0100, Jonathan Cameron wrote:
> On Thu, 1 Aug 2024 20:26:31 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Thu, Aug 01, 2024 at 09:58:29AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 30, 2024 at 11:00:38AM +0300, Leon Romanovsky wrote:  
> > > > > +
> > > > > +	void *inbuf __free(kvfree) =
> > > > > +		kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);  
> > > > 
> > > > 
> > > > <...>
> > > >   
> > > > > +	out_len = cmd->out_len;
> > > > > +	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(
> > > > > +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);  
> > > > 
> > > > I was under impression that declaration of variables in C should be at the beginning
> > > > of block. Was it changed for the kernel?  
> > > 
> > > Yes, the compiler check blocking variables in the body was disabled to
> > > allow cleanup.h
> > > 
> > > Jonathan said this is the agreed coding style to use for this  
> > 
> > I'm said to hear that.
> 
> Was passing on a statement Linus made (not digging it out right now)
> that he really wanted to be able see constructors and destructors
> together.

The thing is that we are talking about the same thing. I and Linus want
to keep locality of variables declaration and initialization. I don't
know the Linus's stance on it, but I'm sad that to achieve that for
cleanup.h, very useful feature of GCC (keep variables at the beginning
of the block) was disabled.

Right now, you can declare variables in any place and it is harder to
review the code now. It is a matter of time when we will see code like
this and start to chase bugs introduced by this pattern:

int f()
{
	<some code>
	int i;
	<some code>
	return something;
}

Thanks

> 
> The other part is that in some cases you can end up with non
> obvious ordering bugs because the cleanup is the reverse of the
> declarations, not the constructors being called.
> Whilst it is fairly easy to review for this, future code reorganization
> may well lead to subtle bugs, typically in error paths etc.
> 
> Putting the declaration inline avoids this potential problem
> 
> Dan wrote a style guide proposal.
> https://lore.kernel.org/all/171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com/
> [PATCH v3] cleanup: Add usage and style documentation
> 
> seems it died out without anyone applying it.  I've poked.
> 
> Jonathan
> 
> > 
> > Thanks
> > 
> > > 
> > > Jason  
> > 
> 
> 

