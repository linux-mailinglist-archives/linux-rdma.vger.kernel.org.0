Return-Path: <linux-rdma+bounces-4039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFE93E4BC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 13:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0566282089
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AD38FB0;
	Sun, 28 Jul 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vmZOIyAw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF329CEC;
	Sun, 28 Jul 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722165536; cv=none; b=r7DU4Dlf8rl4yho/n33+LfC6vEnc0PTo3nehgQ35ya0xeMEfW5gZkg8blG33x0JzR2CSI7gquR6UNm4SSp/KS/FYqiGvRwxegnnk8KkW+GHlfI4PGHrINXXo1fklK7fRs+i1BgSbVsKYDQTzUomswDdudKlKgmjlAvGw+nTm0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722165536; c=relaxed/simple;
	bh=T663exKYveMqk6rqHd1mdTsDA7s1HK5JOAmMCg4oWvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwKGf9wPSzhm7imW/fcBqLipbYm5XstvoT3PR/vpw8hoB/+QJegaaExdB8RME4D2ML4eJgS1KuonnkhYOJvgLY2lnjMfRdTyZe7PUWcFultRBSFucoLXwKV+5MlXyyLfVcwBv9G6vdV2tDM1DGPWDSkl7bEYsuzBUOLj6TXmL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vmZOIyAw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A0AA963F;
	Sun, 28 Jul 2024 13:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722165480;
	bh=T663exKYveMqk6rqHd1mdTsDA7s1HK5JOAmMCg4oWvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vmZOIyAwBz185AAZMyCDcCmbwiIOXHBY+y/Ws+nI2bj/nSDWzAwoxvNu713sdPeOE
	 uO2PNrKlB4+oJkKXEIhF65u9gPcmic/ACzSmGt/SyJm3LCP6GLuwNp7JA+MynLOltO
	 G1bjoCWPPF0IyoO1U9UKYbzEbsfJ0Q3gPtREqMG4=
Date: Sun, 28 Jul 2024 14:18:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240728111826.GA30973@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>

Hi Dan,

On Fri, Jul 26, 2024 at 05:16:08PM -0700, Dan Williams wrote:
> Laurent Pinchart wrote:
> > I know this is a topic proposed for the maintainers summit, but given
> > the number of people who seem to have an opinion and be interested in
> > dicussing it, would a session at LPC be a better candidate ? I don't
> > expect the maintainer summit to invite all relevant experts from all
> > subsystems, that would likely overflow the room.
> > 
> > The downside of an LPC session is that it could easily turn into a
> > heated stage fight, and there are probably also quite a few arguments
> > that can't really be made in the open :-S
> 
> A separate LPC session for a subsystem or set of subsystems to explore
> local passthrough policy makes sense, but that is not the primary
> motivation for also requesting a Maintainer Summit topic slot. The
> primary motivation is discussing the provenance and navigation of
> cross-subsystem NAKs especially in an environment where the lines
> between net, mem, and storage are increasingly blurry at the device
> level.

Would there be enough space at the maintainers' summit for all the
relevant people to join the discussion ?

-- 
Regards,

Laurent Pinchart

