Return-Path: <linux-rdma+bounces-3986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107B93C338
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B753F1C217CC
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74119B3D3;
	Thu, 25 Jul 2024 13:43:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529C225D7;
	Thu, 25 Jul 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915029; cv=none; b=IfjgKHHH2Lr3aSPsIty0fjXtmgP0ojwDj4xBKCt5iIMLbOgzZCqTEhlH2nNbLo4kvqIt2rSFpABWpAPf5T7JVlpnzmV7w6fLjWNMZVE9u8ht6BrtTa7Utvq0M4LK/hH8bxSwuCrayQyFqlchI1VtCua5/UnPtAJGgQrI7gbgREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915029; c=relaxed/simple;
	bh=YKUCT0zwIVfetAmiAL7WYXohNFMTbJ9ulBXs00lVIv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMcW3stk9n5r1xBxfcadPYVuVKmYu727t64R2genSjE6p4kwrZORLS1tQrEXKozZJvc4ECoC+9w3xPvag8dAPs8TlFF237AhrKQVNWakIgh4VgsZit5B5v6XgridNDZ2v4Mfry+SBicauVCxhoGXVyOOboZsUgmgPG4l39nsvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962BCC116B1;
	Thu, 25 Jul 2024 13:43:47 +0000 (UTC)
Date: Thu, 25 Jul 2024 09:44:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Jiri Kosina <jikos@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725094407.4b062971@gandalf.local.home>
In-Reply-To: <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	<1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	<20240724200012.GA23293@pendragon.ideasonboard.com>
	<CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
	<20240725122315.GE7022@unreal>
	<CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 15:02:13 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> As a user, and as an open source Distro developer I have a small hint.
> But you could also ask users what they think about not being able to
> use their notebook's cameras. The last time that I could not use some
> basic hardware from a notebook with Linux was 20 years ago.

FYI, I love my Dell XPS 13. But it's old. The battery died once and I had
to replace it. I would love to buy a new one, but the new one's webcam is
not supported by Linux. I'm just waiting for when this will be resolved. :-p

-- Steve

