Return-Path: <linux-rdma+bounces-4014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5E93D4AA
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DE6B20E6C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579E17BB2A;
	Fri, 26 Jul 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pn75K4Lc";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pn75K4Lc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769691E529;
	Fri, 26 Jul 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002338; cv=none; b=EhBA+BSFqA6C729D2cZWgt+auDa5b/bXtFTvv51Gl1oHgIDUQukdtSneaea+e4CMfeRLanjdLWVHh/NDquCGbjpozEhIv2yzsmz7N9a6kvZGnLQ/G8oMQr2uyU52LpjIXoXeAqA7OUR+qW3uUuMrSDk+hTq02PWfREhHAK1QT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002338; c=relaxed/simple;
	bh=IgVVy2WVwsAraM+Rp5aPTJu7ZEu6aedeG0qOGkyuGgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ti1sl2OuMhcJjPfzp+5mOkhpyviOwAUHJpUrMuYN3dVq7JpkpPN1O9wffDbty4hLnDut5H5cegTg8PplGNgeSXMyvzpcNT4Zz6vvDdM+GYLokcqzxN5UweQkroP2KyufxLGPP8cmrpuAsVv2ptVAuBxuWE98GK6MRK2Ras9i0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=pn75K4Lc; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=pn75K4Lc; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722002334;
	bh=IgVVy2WVwsAraM+Rp5aPTJu7ZEu6aedeG0qOGkyuGgI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pn75K4LcKcXoXjtHT6myJ6OyySvarsD9/2BLueR/aYg3uPXMGqViHbhD4xm7QZyfm
	 F+tzpccklCEVtlk1UEKH5fpmBz/nX8W34uDsO2VNvvDwT3/gKFADpZQMCrEmPyXi3U
	 Kmr7CdXxeCB5DyCUSPbq7uL/yKeGSHIWxMgLIPz0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CAD51128100C;
	Fri, 26 Jul 2024 09:58:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ajY5E7Q8xTT2; Fri, 26 Jul 2024 09:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722002334;
	bh=IgVVy2WVwsAraM+Rp5aPTJu7ZEu6aedeG0qOGkyuGgI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pn75K4LcKcXoXjtHT6myJ6OyySvarsD9/2BLueR/aYg3uPXMGqViHbhD4xm7QZyfm
	 F+tzpccklCEVtlk1UEKH5fpmBz/nX8W34uDsO2VNvvDwT3/gKFADpZQMCrEmPyXi3U
	 Kmr7CdXxeCB5DyCUSPbq7uL/yKeGSHIWxMgLIPz0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B09311280BA5;
	Fri, 26 Jul 2024 09:58:53 -0400 (EDT)
Message-ID: <c5d0233dbaf0a3a77dae4b9636fff08f56ef7bff.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Ricardo Ribalda Delgado
 <ricardo.ribalda@gmail.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jiri Kosina <jikos@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
 linux-cxl@vger.kernel.org,  linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
Date: Fri, 26 Jul 2024 09:58:52 -0400
In-Reply-To: <20240725173747.GH7022@unreal>
References: <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	 <20240724200012.GA23293@pendragon.ideasonboard.com>
	 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
	 <20240725122315.GE7022@unreal>
	 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
	 <20240725132035.GF7022@unreal>
	 <1d7a4437-d072-42c4-b5fe-21e097eb5b9c@sirena.org.uk>
	 <20240725141856.GG7022@unreal>
	 <b30aa2afd015a4f957a6c0b2353ef7b99716d240.camel@HansenPartnership.com>
	 <20240725173747.GH7022@unreal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-07-25 at 20:37 +0300, Leon Romanovsky wrote:
> I don't want to hijack this thread, but I tried now my two Jabra
> speakers (one is used and another is brand new which I got from IT)
> and both don't work on my FC40 laptop.

Bring it to Plumbers and we'll try it on a variety of systems ... just
in case it's a fluke that the Jabras we use work (would be embarrassing
for us to buy the wrong ones next time).

Regards,

James


