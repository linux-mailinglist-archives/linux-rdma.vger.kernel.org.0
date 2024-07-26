Return-Path: <linux-rdma+bounces-4031-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13393D7DD
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 19:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA2280D85
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9E017C7AD;
	Fri, 26 Jul 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PNcjKj2x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5517623E;
	Fri, 26 Jul 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016616; cv=none; b=Z7tTtUDy3Mk4Q1C2plP5IlU37ar90UC+mvvG8JPWSkEI5GNB/lfKSUlPYvbwbvhIqRNB5+qF27lLGxFtOgYFVTY+c9NKuHh9gqXfg3ErOsfXWaFdbKR1Q0UtPsQIor5Wg1+9+md9D7y9ixAyql2Kz/NJnzM8jtnxmNProZJ+vjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016616; c=relaxed/simple;
	bh=Vb6TdxLXCEMbvYGaarnLF0tJk7RSaAlMSzr7nZ+xvxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHeLJqBsR03Z6qhCaHY3IvO99Xc6QHXUBaDpLMi3UzCqOS5siAo4tSF0uKbpptVYdD2uZz4st3aa4FJb9IP0rTjXzrt0fPoH3YNwtLLnmrjmGvzImddXre8VjgsZks/I1aJgRde2PNcDpM3goc+NpG4rr3VWaunYlcHOLw4aKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PNcjKj2x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 515C383F;
	Fri, 26 Jul 2024 19:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722016568;
	bh=Vb6TdxLXCEMbvYGaarnLF0tJk7RSaAlMSzr7nZ+xvxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNcjKj2xkUM0C/IxqfxYc+NrimiB9/hV/OWUT7kKC0J9ewRR94beT329a5yMU/AYC
	 uPeIC6bFIl9XVPgrOUQ8WaNSa4t0zSwRoJkHRxJ0T+TM9kmst8/UMhjBRDceBKu0vQ
	 gaWLITNF2htEudcFV4ANVQA/PVFhox/yeTOzkTQc=
Date: Fri, 26 Jul 2024 20:56:33 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Leon Romanovsky <leon@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240726175633.GA12773@pendragon.ideasonboard.com>
References: <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
 <20240725132035.GF7022@unreal>
 <20240725194202.GE14252@pendragon.ideasonboard.com>
 <CAPybu_3T8JNkZxf3pgCo4E4VJ3AZvY7NzeXdd7w9Qqe8=eV=9A@mail.gmail.com>
 <20240726131110.GD28621@pendragon.ideasonboard.com>
 <8d83a9a69c10bab0e4e39994c58c290f6dc5586b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d83a9a69c10bab0e4e39994c58c290f6dc5586b.camel@HansenPartnership.com>

On Fri, Jul 26, 2024 at 12:01:00PM -0400, James Bottomley wrote:
> On Fri, 2024-07-26 at 16:11 +0300, Laurent Pinchart wrote:
> > On Fri, Jul 26, 2024 at 10:02:27AM +0200, Ricardo Ribalda Delgado wrote:
> [...]
> > > Describing how they implement those algorithms is a patent
> > > minefield and their differentiating factor.
> 
> Just on this argument: The Patent Shield around Linux provided by OIN
> is pretty strong and allows us (and entities that contribute to Linux)
> to ignore most patent problems because someone else is looking out for
> them.  OIN is actually free to join if any company would like to
> benefit directly from the Linux Patent Shield:
> 
> https://openinventionnetwork.com/about-us/member-benefits/
> 
> > Those are also arguments I've heard many times before. The
> > differentiating factor for cameras today is mostly in userspace ISP
> > control algorithms, and nobody is telling vendors they need to open
> > all that.
> > 
> > When it comes to patents, we all know how software patents is a
> > minefield, and hardware is also affected. I can't have much sympathy
> > for this argument though, those patents mostly benefit the largest
> > players in the market, and those are the ones who currently claim
> > they can't open anything due to patents.
> 
> In order to get a patent, the claimed invention has to be made public,
> so if they hold the patent there should be no problem.  If there is a
> problem opening something because it infringes on someone else's patent
> and they might see it, then OIN, above, is usually a good answer if the
> patent is owned by another ecosystem contributor or an OIN signatory. 
> For patent contortia (like MPEG) and patent trolls, it's more
> problematic, but, again, OIN can provide help.

While I agree with the above in theory, in practice the patent argument
is raised by large SoC vendors. There's one particular company well
known for having engineering managed by lawyers...

As I said, I don't sympathize with their arguments. The patent mess has
been mostly created by those large actors who benefit the most from it.
They can't at the same time claim that they can't disclose anything due
to fear of patent infringement.

-- 
Regards,

Laurent Pinchart

