Return-Path: <linux-rdma+bounces-883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BFD848C95
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE901F2232C
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5EC19452;
	Sun,  4 Feb 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpVu/BWh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F851AAC4;
	Sun,  4 Feb 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707040005; cv=none; b=grYthYq38kGoK3+kAXhM1TFwxh8rvTKanWngTGA3izjecVV6LX7icYPaKPKWJogc/CAYmzkPIvPM5OG04h8SfyJoq85Ol6m7wexEhe/WlkrmTEqrEw0qzwuI6/cLO32VvvLsh132RcaJ7SNsOXdDGQ6ok4dPKwMciS2CQBiz+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707040005; c=relaxed/simple;
	bh=poCm4eNqLnI3tFNwsWul+Ys5I6bL2/0VpCLXBfHXU1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwZfU4EKw6sIZLaOT3gyCQU2S5XKKTnQD+SxCatriAQAoCBGjYrQhui14T2vy6I3rkcuyO81xpdQf3NAtkCSTfjELjQTDDyn/MM/GRsb0dyWEiI+BHokWfg9jOTAsQhsS5sIdgLJo9YsdJ1unV9fx6KKnEF3F/wtQDmFNdM+Crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpVu/BWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07383C433C7;
	Sun,  4 Feb 2024 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707040004;
	bh=poCm4eNqLnI3tFNwsWul+Ys5I6bL2/0VpCLXBfHXU1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpVu/BWhwSh57JiLIH4o+8OQTNIEXUcgvhUIhT9EZHpABulx8iDgQm+pm9u8tXrbH
	 Qz26y/IK/hlJN4YeGhLHL0GdP2OkYhRQSdx87ZkMFoCr+EztfDHIFhTD0Z1RR1mA3Z
	 5jz48E/4Rx3GGv2mNF7EQJAFVa9003oT0G7PMxL1vfU0LrTWjiRssO+53092qUjQjs
	 anYxHaz5/sS7opo30N006gbpq00s1PooO2ANHaQvU23TyAyZw84fpQM64MHkEf/MWU
	 rnJ51lbLkXq9Tg89olBHzkT8M4lvuAToZqFb0v1JD4PPHPcWuTbYU/EZHNPbX82cbO
	 r3I/8IDDZjWCw==
Date: Sun, 4 Feb 2024 11:46:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: William Kucharski <william.kucharski@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] RDMA/srpt: Do not register event handler until
 srpt device is fully setup
Message-ID: <20240204094640.GB5400@unreal>
References: <20240202091549.991784-1-william.kucharski@oracle.com>
 <20240202091549.991784-2-william.kucharski@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202091549.991784-2-william.kucharski@oracle.com>

On Fri, Feb 02, 2024 at 02:15:49AM -0700, William Kucharski wrote:
> Upon rare occasions, KASAN reports a use-after-free Write
> in srpt_refresh_port().
> 
> This seems to be because an event handler is registered before the
> srpt device is fully setup and a race condition upon error may leave a
> partially setup event handler in place.
> 
> Instead, only register the event handler after srpt device initialization
> is complete.
> 
> Fixes: dcc9881e6767 ("RDMA/(core, ulp): Convert register/unregister event handler to be void")

This is wrong line, the issues is much older.
Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")

> Signed-off-by: William Kucharski <william.kucharski@oracle.com>

Please keep Reviewed-by tags provided by Bart.

Thanks

