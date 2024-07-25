Return-Path: <linux-rdma+bounces-3989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799393C3EF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 16:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B6F1F22B7A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEFD19D085;
	Thu, 25 Jul 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRnAfZ8i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C323FB3B;
	Thu, 25 Jul 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917143; cv=none; b=fH4cQgwSYjrm0AOKnp9kQJP5KFFoLwUNkVUq521JDTZYQJ0kqnzWcmBykHVidnxYDf6JzdVv15i2VM4+RF4+/ek4fQOEK/CFdtlaSSkkVnYJJrVv5MDKlvVQobIdWsHG2wQSc50GqdLGc5X+9OxopOF/5ZL6A4jdao0Cdyr2Htg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917143; c=relaxed/simple;
	bh=QXojYiaC9BA8ofaaXe/KVyq+I/rsgjSEzyijj1VO2QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEkUpeB1ggMdj7+zO+OrSP/fw+9HhfeMRHcFJLFarHm8pYqgRO9WiTGIXy80lM1Av21EN1k4Uq9gO6XSJUwJkdZcb6k4iHOYjtCxkPvSpzJQx5oInYMrpkGePvkJQ0ta9OGAepyt3JAut0OWCuzNhvGjHYS+IvlMX4bDER2gqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRnAfZ8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE0C116B1;
	Thu, 25 Jul 2024 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917142;
	bh=QXojYiaC9BA8ofaaXe/KVyq+I/rsgjSEzyijj1VO2QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRnAfZ8iJ26bRhUJ/jnMyz/tTFeEuK/7auc4YAa8tygoTFw/O+Za6uW5SCBYRb/KF
	 HZxCrEiOZY1ppZHSX+MC6Gby3MvYbeu2779XjIh/IBc3Y0sSigZer3AoUgfDjIK+4R
	 yxistHFehC77oV03O/klpEdTpVK6cOxQnh6lxmTpumCZn/ras0T1dq2LLzCukGAFoO
	 c7yOSiMEWSuA035BtLnw9TILSctGWxsTYutHJltkEFtAEVMD7vZAD0iUVklxiYeU02
	 rKj/L7T7JDrV1aIAG5zAPEzIx3lKGxhDrbaGOWd4ehw2SDm8ZqcO7Jlfnuc/5dqNHP
	 JOW8ZbBg/o7bQ==
Date: Thu, 25 Jul 2024 17:18:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725141856.GG7022@unreal>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
 <20240725132035.GF7022@unreal>
 <1d7a4437-d072-42c4-b5fe-21e097eb5b9c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7a4437-d072-42c4-b5fe-21e097eb5b9c@sirena.org.uk>

On Thu, Jul 25, 2024 at 02:29:36PM +0100, Mark Brown wrote:
> On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> > On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado wrote:
> 
> > > As a user, and as an open source Distro developer I have a small hint.
> > > But you could also ask users what they think about not being able to
> > > use their notebook's cameras. The last time that I could not use some
> > > basic hardware from a notebook with Linux was 20 years ago.
> 
> > Lucky you, I still have consumer hardware (speaker) that doesn't work
> > with Linux, and even now, there is basic hardware in my current
> > laptop (HP docking station) that doesn't work reliably in Linux.
> 
> FWIW for most audio issues (especially built in stuff) with laptops if
> you report it upstream it'll generally be relatively easy to quirk.
> Unfortunately it's idiomatic for ACPI systems to quirk off DMI
> information for almost everything which means a constant stream of per
> system quirks for subsystems like audio.

It is Jabra USB speaker. One day, I will have time to debug it :).

Thanks

