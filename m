Return-Path: <linux-rdma+bounces-4074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A893F938
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C68FB22197
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B91155CBF;
	Mon, 29 Jul 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Id0owCRU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BD1E4A2;
	Mon, 29 Jul 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266198; cv=none; b=TrPYlpIhiXVtjTEA0LZn05+Uvt+RF/DVB/YPJAb+nBMLnawr8vlRT4rMsLjML/WxiR0MuXV+/5XQhq4dGkMUo/f2UPmrOs24VwElUoj22Yu9EmWWZdYLunftymSSMSSB3epakdi5kq5hgkgEAEHKjZE9RnG8Brd1w26D6/3B7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266198; c=relaxed/simple;
	bh=AiAQTt2g0SacEgBRXmGh0/vw2yrQYDrMGirQg/MYj2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGAxT4i7sZ5IoJHWhaqWil/PoSnC2pDGgEkyvfmJ+DC8LK6wLKQZ9lt8BQDvrLQRT4izw393AjF8yZDbfoArIph+49+CIxpBftgCRMYYb9qXebvITzCU5rP/nlWkj9t+++1gHyZYkcGnmpO/9NhdAolbON2vlMN7l2lv8Df8XAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Id0owCRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB16C4AF0A;
	Mon, 29 Jul 2024 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722266197;
	bh=AiAQTt2g0SacEgBRXmGh0/vw2yrQYDrMGirQg/MYj2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Id0owCRUZDCMAPG6946QpFMgQb76ZgEnuyNLzqWAY7UGUPKqNCdWxZv+CBI6+hahf
	 ZY4+zUoPA6Qch/SolqCys4VBlvOG93CEu8CIPPJpFw+Pbhx+R1chviDLRDakJoxnNb
	 ZgcUj6rVJ3qgi0/2ZPAefnflWiK+gLhFoJua0ZsA=
Date: Mon, 29 Jul 2024 17:16:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <2024072931-carnival-dumpling-57fa@gregkh>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
 <20240729075607.71ca5150@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729075607.71ca5150@kernel.org>

On Mon, Jul 29, 2024 at 07:56:07AM -0700, Jakub Kicinski wrote:
> On Sun, 28 Jul 2024 11:49:44 -0400 James Bottomley wrote:
> > cross subsystem NAKs
> 
> Could y'all please stop saying "cross subsystem NAKs"..
> It makes it sound like networking is nacking an addition to RDMA 
> or storage. The problem is that nVidia insists on making their
> proprietary gateway a "misc driver" usable in all subsystems.
> 
> If they want to add something at the top level, all affected
> subsystems should have a say.
> 

Also, the misc driver maintainer (i.e. me), explicitly asked for the
review by the networking maintainer here.  It wasn't a drive-by-nak at
all.

greg k-h

