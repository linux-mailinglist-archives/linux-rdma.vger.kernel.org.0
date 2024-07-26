Return-Path: <linux-rdma+bounces-4021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88DE93D632
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142C01C23124
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B617838E;
	Fri, 26 Jul 2024 15:34:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7017A580;
	Fri, 26 Jul 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008076; cv=none; b=PE9cYx61TAyV+WYvIARw0LrS67OKwT5HHw2cVOy8v6VCpO++jZZFtOJDta+XaM4BxzQjPqqdlQEoAshJCz848W/NMY+eikngGQLVf6lQWl/cyMhZ254QKvBK0cau3IJQxtQa1pK4/H6PWwfpsDYwRO7a8Y15Giz250lmiYpxreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008076; c=relaxed/simple;
	bh=e7JdzU9Jz5TN++CYUI5dG+nwOf6bA0h8sa4L65QcPcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDytCr92mc/ctUy51wb8omzKlBg3VSU47ayr2bwBr77SNrtHaOJrTgDGNmAHYFG+PX3mT7MeHSuhpIqg2R1TSIQp6hM17HbbWjRIkyWar9StzceEOUo824WPg7FtKBg3HZj7WW8IV2WUlYCFKL2vVQrSC1I7iexs1YaNa5KMVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60112C32786;
	Fri, 26 Jul 2024 15:34:35 +0000 (UTC)
Date: Fri, 26 Jul 2024 11:34:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240726113434.56200a0e@rorschach.local.home>
In-Reply-To: <20240726142731.GG28621@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<20240726142731.GG28621@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 17:27:31 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> I know this is a topic proposed for the maintainers summit, but given
> the number of people who seem to have an opinion and be interested in
> dicussing it, would a session at LPC be a better candidate ? I don't
> expect the maintainer summit to invite all relevant experts from all
> subsystems, that would likely overflow the room.
> 
> The downside of an LPC session is that it could easily turn into a
> heated stage fight, and there are probably also quite a few arguments
> that can't really be made in the open :-S
> 

You can always submit a BoF. We have also had last minute BoFs made if
there's rooms available.

-- Steve

