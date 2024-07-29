Return-Path: <linux-rdma+bounces-4072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0C93F8C9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5291F22BCE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFC15538C;
	Mon, 29 Jul 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbkXG6U6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02E1534EC;
	Mon, 29 Jul 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264969; cv=none; b=F+ZCiGCecvNWOUVgAsyJ9KBv8pxJutk4eOBjFZEGJmOiOHAxG6uBbZjKWfr8RE//Sfxu1YSfuZW5tfAUTU7gw2rlZLfSy8bZLMo/G4+kUP8QgfZwt9hUdFSf81RDHuv0rN+tfV/+Rb29qKMXzhVmpauY7s9LnmL1avtIfnEDBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264969; c=relaxed/simple;
	bh=EJcJUuQRZXR3rf8lFMt6F/i5OksdABevOMJW7PKpBZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P44r+ogVT+uOdbUu3tjzhs+2OS/B9d9SPX8w/mJwHqLU5WNUwmnwDqDiL2QRz7/ewJ3nD91yefVbe9WivSeopilQrHmZI0Qg+Jp97RQNFZjrit7dxTq7/sWcC9f2S5fuk+TesEMVCGWainLyctLg573RbssdkU704imsJkenWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbkXG6U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B09C32786;
	Mon, 29 Jul 2024 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264969;
	bh=EJcJUuQRZXR3rf8lFMt6F/i5OksdABevOMJW7PKpBZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jbkXG6U6nH4UA+G7ZfU70c0ljD+B1u2nDArdVs8uhB+F5Yd4orXP5uiYEYbcvOE2H
	 eoMmmchEb7HmRJ/Ptgmtvfpg5JWq7gg4f9hYaVjM6poY4H4X6KV8aITwOC4Wm3tpVu
	 OFzR3zGhD1gEkm90iW6saiWmnWAlq5rCGC2GS1x5d/DJTwKF4AUKnRQSkc0aKXS7oQ
	 EIgVa9PRYC2XkxsexIvKtjYikNAA3rREFzcRBKXdFT8t9Hmkf0Av5TRyQ3shSwNI4z
	 EqBfW9Kmvta8lbXM3Plm6VoFZiiMQyZkMufUERafs1FHwHLXjcWhyvjHQoEK2bZXgp
	 RoARF17Dljgsg==
Date: Mon, 29 Jul 2024 07:56:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Laurent Pinchart 
 <laurent.pinchart@ideasonboard.com>, Dan Williams
 <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729075607.71ca5150@kernel.org>
In-Reply-To: <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<20240726142731.GG28621@pendragon.ideasonboard.com>
	<66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240728111826.GA30973@pendragon.ideasonboard.com>
	<2024072802-amendable-unwatched-e656@gregkh>
	<2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 11:49:44 -0400 James Bottomley wrote:
> cross subsystem NAKs

Could y'all please stop saying "cross subsystem NAKs"..
It makes it sound like networking is nacking an addition to RDMA 
or storage. The problem is that nVidia insists on making their
proprietary gateway a "misc driver" usable in all subsystems.

If they want to add something at the top level, all affected
subsystems should have a say.

