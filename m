Return-Path: <linux-rdma+bounces-15511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2FDD1951E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 15:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9850F3062B12
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEDA38FEF9;
	Tue, 13 Jan 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+T9Y50z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0468259C9C;
	Tue, 13 Jan 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313272; cv=none; b=tOghqxxYYqHWoFsZqd6z9OdlUYaLEB6kIA9pygTsdKCAXq/eKOJdzDd/qHwu8jNUBsMdqekyULl/PIkUFlLjKuDtX+Oc8rLvptlQTTBXHdLNjb4gVXziGdVNKDdXjtPYLDvW5LM0okOiNC6u5b5OoqIpD5BgUsNJLkwcuf4oCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313272; c=relaxed/simple;
	bh=tf7VjSu0IpoV3D/dKKNBxPq01NpdmZ6jhmht6sF3+AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rbqn6oDLoNMogXM+bG/R2lK7ytMRhwxqBIJdaGxYycgnKhC9T0JjH4SN5OuzqAmSP1dpLnh/i9jLJpKNiiH0nJspujw/N/i+xyIcu4XlpvHVEj4TBX51dUZrp61hjyJAEFNBaUnk9JB5FhB80bieypBTRJZghxJTP5ysQrdGEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+T9Y50z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2715C116C6;
	Tue, 13 Jan 2026 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768313272;
	bh=tf7VjSu0IpoV3D/dKKNBxPq01NpdmZ6jhmht6sF3+AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+T9Y50zl5cSQ5yb1OUqCiek/oLQJouQzDWA/FSSDg4UjQcbQpYTVjdit7iguFwli
	 ySksVrIV5YdvqviDpTiZCiizHFxEG/gUBv4pLxasvjvaj27Sx1nc/TbATL0YOkqCTB
	 e085V2Qf2p78J/FC4osBejVRG0j868QtY+cHi015aFm09mM03NPGX704OJWqyXp8Pm
	 0RMDwddEIMdTgY883Bxm8vwRkTqBcK9z/gp920y4PC5MogExldwfLlHQtUUsR6ATEU
	 uJzo2cUonlv9hd2a6TympZ6CqumW70LxkJw+Voj0PX7HzBIxc4jU7EpxHjwuvYtoAp
	 FbFGwdeTz6dmw==
Date: Tue, 13 Jan 2026 16:07:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type
 from the device type
Message-ID: <20260113140747.GB179508@unreal>
References: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>
 <20260112075233.GB14378@unreal>
 <DU8PR83MB0975AC89F5149C284751B0A4B48EA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU8PR83MB0975AC89F5149C284751B0A4B48EA@DU8PR83MB0975.EURPRD83.prod.outlook.com>

On Tue, Jan 13, 2026 at 12:27:57PM +0000, Konstantin Taranov wrote:
> > >
> > > -		is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
> > 
> > You need to add code which prohibits future use of this BIT(0) in ucmd.flags
> > for backward compatibility and maybe delete MANA_IB_CREATE_RNIC_CQ
> > from UAPI too.
> > 
> > Thanks
> > 
> 
> Hi Leon. I thought that my proposed change is backward and forward compatible.
> If I add code that prohibits this flag, then the older rdma-core will fail to create CQ,
> as it sets this flag. Add rdma-core should set the flag to support older kernels.
> 
> So, the current solution is as follows:
> rdma-core always sends the flag. The kernels without this patch still use this flag.
> Newer kernels just ignore the flag and create the CQ according to the client.
> It is not fully possible to retire this flag now, as we want to be backwards compatible and
> support older kernels and older rdma-core.
> Or did you mean something else? Or do I miss something?

There needs to be a way to document in the code that this bit is reserved and
must not be used.

Thanks

> 
> Thanks

