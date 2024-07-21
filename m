Return-Path: <linux-rdma+bounces-3918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7879385ED
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 21:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A757EB20C98
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76016A95F;
	Sun, 21 Jul 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EM/o0nGi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AFA1667F6;
	Sun, 21 Jul 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721589951; cv=none; b=VNtWXruyQaIT0HpGUZhUt3OhmfdlcPFZ5UAQL0wiJrX901gCPtFV7hN5oDrPuuwyWd1LM9ztRVVK3n6H1pWnABnxO0+ZFLaWY2UVRnJkeNb0R9y6fM6en0prjcJjfKAyiJOs0UExRx8UThvKrz2pdvV0sSZNAOtIpv7xKUuDJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721589951; c=relaxed/simple;
	bh=lpwpH5jRM4NpKfFV7k4ZqvII+1jk44QJ4kC8lDa7xFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMI+zPv+EPUAMCSpBwT0ntVrOuIZeraL0ked9u5yDf+7+mA8T/FQQJtTLhQIg9rZG1nxYzyBOljkSHyUv2Fa+LzJK6RugliBsnQYpGhVDZArc+qmcV11sckmeyJ/Gv/vKI/nP9V4T+mb+M8Abn3/l0+4hcGjulgDj6Kp+sNrVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EM/o0nGi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D13D821E;
	Sun, 21 Jul 2024 21:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721589907;
	bh=lpwpH5jRM4NpKfFV7k4ZqvII+1jk44QJ4kC8lDa7xFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EM/o0nGiRNgTQfGa5nahpNo+G+nfHz2mqZCHhQPtvVNTP4hzrel3xJq/uPIJd7G5W
	 2zWc/5minYzzOuIQG2gTGz6XXS3WnlrP3MNEn+Mjt+tHRdR7WzZ02TGqlrH2CFYxVV
	 ek+zwI6IaTmUFTnLtt5l6gcT1s/3u+8tIXBqb7Jo=
Date: Sun, 21 Jul 2024 22:25:30 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240721192530.GD23783@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wrote:
> James Bottomley wrote:
> > > The upstream discussion has yielded the full spectrum of positions on
> > > device specific functionality, and it is a topic that needs cross-
> > > kernel consensus as hardware increasingly spans cross-subsystem
> > > concerns. Please consider it for a Maintainers Summit discussion.
> > 
> > I'm with Greg on this ... can you point to some of the contrary
> > positions?
> 
> This thread has that discussion:
> 
> http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> 
> I do not want to speak for others on the saliency of their points, all I
> can say is that the contrary positions have so far not moved me to drop
> consideration of fwctl for CXL.
> 
> Where CXL has a Command Effects Log that is a reasonable protocol for
> making decisions about opaque command codes, and that CXL already has a
> few years of experience with the commands that *do* need a Linux-command
> wrapper.
> 
> Some open questions from that thread are: what does it mean for the fate
> of a proposal if one subsystem Acks the ABI and another Naks it for a
> device that crosses subsystem functionality? Would a cynical hardware
> response just lead to plumbing an NVME admin queue, or CXL mailbox to
> get device-specific commands past another subsystem's objection?

My default answer would be to trust the maintainers of the relevant
subsystems (or try to convince them when you disagree :-)). Not only
should they know the technical implications best, they should also have
a good view of the whole vertical stack, and the implications of
pass-through for their ecosystem. This may result in a single NAK
overriding ACKs, but we could also try to find technical solutions when
we'll face such issues, to enforce different sets of rules for the
different functions of a device.

Subsystem hopping is something we're recently noticed for camera ISPs,
where a vendor wanted to move from V4L2 to DRM. Technical reasons for
doing so were given, and they were (in my opinion) rather excuses. The
unspoken real (again in my opinion) reason was to avoid documenting the
firmware interface and ship userspace binary blobs with no way for free
software to use all the device's features. That's something we have been
fighting against for years, trying to convince vendors that they can
provide better and more open camera support without the world
collapsing, with increasing success recently. Saying amen to
pass-through in this case would be a huge step back that would hurt
users and the whole ecosystem in the short and long term.

> My reconsideration of the "debug-build only" policy for CXL
> device-specific commands was influenced by a conversation with a distro
> developer where they asserted, paraphrasing: "at what point is a device
> vendor incentivized to ship an out-of-tree module just to restore their
> passthrough functionality?. At that point upstream has lost out on
> collaboration and distro kernel ABI has gained another out-of-tree
> consumer."
> 
> So the tension is healthy, but it has diminishing returns past a certain
> point.

-- 
Regards,

Laurent Pinchart

