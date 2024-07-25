Return-Path: <linux-rdma+bounces-3980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC72A93C1E6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191DE1C21FDF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FA199E91;
	Thu, 25 Jul 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C27wov5X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E7196C9B;
	Thu, 25 Jul 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910200; cv=none; b=NPALNlslUojKwVmAPlmqjgB70b877KR6hvfwUfzi/WG72UuGdBlLaQKUhkovAcZiwlFdebtAdbtFkSLqz2OTxJjebUHkxXDtyAMYUDzpkNoKED8NxNMpk1SROws+uh3wfXQ140DF7qC9N+kDE0IemPfdBFix4ftr2Xq7ET8jmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910200; c=relaxed/simple;
	bh=64+hUnVy0NKoapIiCoKNtU5rvBGP1zE+T3iwlINVO1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjnHdw5q6/j5GfDkOCphBnnvUR+ylgUE5D3rIgww0MF/26NrLzJ9Qc/Kog3SZ+IqirFVEyTezmNBfUlRZLMzzISVZfmR6XqhY3e+wM1nye1V9kn14URIig2FIqIT1uzVKkVd59CIoAfpP/Wh3qSR7H3EaOEExq0o3imxTMjZ4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C27wov5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E21C116B1;
	Thu, 25 Jul 2024 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721910200;
	bh=64+hUnVy0NKoapIiCoKNtU5rvBGP1zE+T3iwlINVO1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C27wov5XJ5qpQV1VaWB49Tt8WgyETWOcs/y8jCsYuRfBcxUnRg2of2ZSdiUJRpEdG
	 luuuDWzjiKYtXOzJAT8GnAhM7sKZzl081ZB0Yn7qNnlk93ObN7ApHucGB55+9baAV5
	 xVaZRYLOqvkhzohJCwf77iIHcnJSb+U/o/g0ikx5wqrQ8GdDwY0WIEq5JV2LKV2xY5
	 8x+4c59bRkIIIhjs+y1r+cAAUkpkMgWTJvROBfsZjcSpBNi9DT5lzYW4eNUco7XEkj
	 etWnddvzbJ4wS+Tp3lYqGVsEq/M5gFOXPmLjsCPZXQZSt8xqNqYglQw0B7VNODC2P7
	 dgmVLHwgCnNvQ==
Date: Thu, 25 Jul 2024 15:23:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725122315.GE7022@unreal>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>

On Thu, Jul 25, 2024 at 11:26:38AM +0200, Ricardo Ribalda Delgado wrote:
> On Wed, Jul 24, 2024 at 10:02 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:

<...>

> 
> It would be great to define what are the free software communities
> here. Distros and final users are also "free software communities" and
> they do not care about niche use cases covered by proprietary
> software.

Are you certain about that?

> They only care (and should care) about normal workflows.

What is a normal workflow?
Does it mean that if user bought something very expensive he
should not be able to use it with free software, because his
usage is different from yours?

Thanks

