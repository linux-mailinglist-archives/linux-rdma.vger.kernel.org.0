Return-Path: <linux-rdma+bounces-4027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945293D67D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0EC1F2497F
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA905588B;
	Fri, 26 Jul 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uLap637h";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uLap637h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFD171D2;
	Fri, 26 Jul 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009666; cv=none; b=AGNhLYU/MxwrmpVg4LwFJq0RdsGlSvwWYSG6xL6h5LEoc/CaGMcPUTmlrkqAgsbXXvNWWhTGuT2JA8bJD3xJWY+QtDBZBH/4zbn4YbJ3OqpohOLsG73VTsrdCqe4+GC0VlIS7b//vqZhaTvPowzL3KK4ofIdH8hEn4mfMGu3ayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009666; c=relaxed/simple;
	bh=Tv3TBmL5BT+pg1MAcmQYJ2QDHFzbbexc+bWPaNIiilM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJNLlmBD8Qop4S8FgFAlb7wDjJ8RlGnkeV3yHKKmwBwIJYKmtR2Oq+6LtFENmRPbaDRLB9Pxj9el73utR/QYO4uTKfdLsF74mfrmry7b2N/5tjZHYCjkyZWYyWST0mfyzvlWGsGpZ+O1ERr3XDVCMAAPyr185sjZCNoqJkMc86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uLap637h; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uLap637h; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722009662;
	bh=Tv3TBmL5BT+pg1MAcmQYJ2QDHFzbbexc+bWPaNIiilM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uLap637hrWspXnBsZ3D18mz5GC0+zSXBSApI2ngq/Sqagbcf4L8aRaGe+dEjwZ5ig
	 3H7KrxPqZbIYT8+eTsLQ1Th+lP+NIJPa/qkfw6mtdutN39JbDuA51VttqVnX0tSDGC
	 TQVavPGqMw+Unj12xEMGywB7O5lbm1k0YBU6ReiQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 91CAA128100C;
	Fri, 26 Jul 2024 12:01:02 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ZnBJzhnOvYyV; Fri, 26 Jul 2024 12:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722009662;
	bh=Tv3TBmL5BT+pg1MAcmQYJ2QDHFzbbexc+bWPaNIiilM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uLap637hrWspXnBsZ3D18mz5GC0+zSXBSApI2ngq/Sqagbcf4L8aRaGe+dEjwZ5ig
	 3H7KrxPqZbIYT8+eTsLQ1Th+lP+NIJPa/qkfw6mtdutN39JbDuA51VttqVnX0tSDGC
	 TQVavPGqMw+Unj12xEMGywB7O5lbm1k0YBU6ReiQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6F5D51280B86;
	Fri, 26 Jul 2024 12:01:01 -0400 (EDT)
Message-ID: <8d83a9a69c10bab0e4e39994c58c290f6dc5586b.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ricardo Ribalda
	Delgado <ricardo.ribalda@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jiri Kosina <jikos@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
 linux-cxl@vger.kernel.org,  linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
Date: Fri, 26 Jul 2024 12:01:00 -0400
In-Reply-To: <20240726131110.GD28621@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	 <20240724200012.GA23293@pendragon.ideasonboard.com>
	 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
	 <20240725122315.GE7022@unreal>
	 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
	 <20240725132035.GF7022@unreal>
	 <20240725194202.GE14252@pendragon.ideasonboard.com>
	 <CAPybu_3T8JNkZxf3pgCo4E4VJ3AZvY7NzeXdd7w9Qqe8=eV=9A@mail.gmail.com>
	 <20240726131110.GD28621@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-07-26 at 16:11 +0300, Laurent Pinchart wrote:
> On Fri, Jul 26, 2024 at 10:02:27AM +0200, Ricardo Ribalda Delgado
> wrote:
[...]
> > Describing how they implement those algorithms is a patent
> > minefield and their differentiating factor.

Just on this argument: The Patent Shield around Linux provided by OIN
is pretty strong and allows us (and entities that contribute to Linux)
to ignore most patent problems because someone else is looking out for
them.  OIN is actually free to join if any company would like to
benefit directly from the Linux Patent Shield:

https://openinventionnetwork.com/about-us/member-benefits/


> Those are also arguments I've heard many times before. The
> differentiating factor for cameras today is mostly in userspace ISP
> control algorithms, and nobody is telling vendors they need to open
> all that.
> 
> When it comes to patents, we all know how software patents is a
> minefield, and hardware is also affected. I can't have much sympathy
> for this argument though, those patents mostly benefit the largest
> players in the market, and those are the ones who currently claim
> they can't open anything due to patents.

In order to get a patent, the claimed invention has to be made public,
so if they hold the patent there should be no problem.  If there is a
problem opening something because it infringes on someone else's patent
and they might see it, then OIN, above, is usually a good answer if the
patent is owned by another ecosystem contributor or an OIN signatory. 
For patent contortia (like MPEG) and patent trolls, it's more
problematic, but, again, OIN can provide help.

Regards,

James


