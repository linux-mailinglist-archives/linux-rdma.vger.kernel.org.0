Return-Path: <linux-rdma+bounces-6457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B79EDDB4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 03:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43C1282B7F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CBB13D8A0;
	Thu, 12 Dec 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNni2L3k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF518643;
	Thu, 12 Dec 2024 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733971022; cv=none; b=KDhGIJVSgvjwkUJP7GAjQ01PSgF/G6t9EVnmijBqWIjkZJY4y9A18pkW8LpjIh7LQr79LQnCEpBF9DM6xfSH88tVpuJovaWMYRGt+pw84jHUrVSNJqyV5JpV+S/u6M9wDw1UWSfN0y9qjuV0allHwHvMphKyMJ9Nja15dSHzWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733971022; c=relaxed/simple;
	bh=DRclRfHEitaK10C0WBuLlWgcfYHfKPNDcjpntNVUWCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6O2nPjnf2CMTn+bEWAoOq9M+z6/zqacsqfuluFMe/tSSHIjajo9COIqNVfGIqAl24umH/UXbK7QpMID8oYaGBNz7pIRDS4WK4rEC+0AgTOwYoidAXPQOCsHNbWG2GGGAI4Sf5VwL+6uQKQeoO6uFBmICU1wYQeQq4j2k1QeF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNni2L3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68498C4CED2;
	Thu, 12 Dec 2024 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733971021;
	bh=DRclRfHEitaK10C0WBuLlWgcfYHfKPNDcjpntNVUWCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SNni2L3kqNkeHb4Q2KanH+1K7uRMb2m3dNsaK363SMWE5GU768G4IR2FKnmi2kjQg
	 KCU6T08m/vjKoLp8SxKK1VKGmjP8tAjDJRezPR4zPqKBUSk7KQaA4Y0hVjH2aCiGY2
	 wVm+HSlUZ9hRPLfwZnTjs93u1uEStIh90k8icclt4axuU9nfwlnI1EO5cedpZ9QJUi
	 JzD82c39pmujhoVE+A7JG8oR+XgtAx3gelhcYY/L9q8WKfZ+u0l29Qw02Fvn+DRC79
	 CIke2ZQGvTRpbxV3+a3idJYktB2CTHYHuY/z6zALXRLg7GEtKzfeOOmTTDOV2dCdQr
	 F2TBh0J+xcVTw==
Date: Wed, 11 Dec 2024 18:37:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
 leon@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com,
 syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
Message-ID: <20241211183700.1dff156f@kernel.org>
In-Reply-To: <20241211160055.GM1888283@ziepe.ca>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
	<20241210145627.GH1888283@ziepe.ca>
	<20241210175237.3342a9eb@kernel.org>
	<20241211160055.GM1888283@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 12:00:55 -0400 Jason Gunthorpe wrote:
> > > ifindex is only stable so long as you are holding a reference on the
> > > netdev..  
> > 
> > Does not compute. Can you elaborate what you mean, Jason?  
> 
> I mean you can't replace a netdev pointer with an ifindex, you can't
> reliably get back to the same netdev from ifindex alone.

With the right use of locking and the netdev notifier the ifindex
is as good as a pointer. I just wanted to point out that taking 
a reference makes no difference here.

