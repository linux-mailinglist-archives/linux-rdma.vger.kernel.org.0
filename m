Return-Path: <linux-rdma+bounces-6768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6F19FEA12
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614123A0F66
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8122186607;
	Mon, 30 Dec 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7UT4++O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ABFEAD0
	for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735584114; cv=none; b=WwOuWkZiWrajJ3rR3CdXJ7Cpo/PVCmMdCyW5FMZwlrVJR3ra+RE65FqSSAHUiPGUgXI8Y72xccQXXA89SHAh3NhXTJIHVCFjWDbo32ibytdCVr5KCYyfUeCRqw3V0j1+bJboR6FITq3eF7kRkfRABIgAW02ZoISKQwbMUq5m+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735584114; c=relaxed/simple;
	bh=9bCPPLWjYVyf7JS8peGzskwSjDzld2YccuXauTNEhK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XYK4tSoGLxzyfnReEHdKz02By7GZPlI8urxVDdiyw7jYdZWG78i1vzXD4YRfgB5JOocfnI8lNFfQY+GPb0qG+un/5iVQKobCCG6lo7Oc8edA2MW5YolE2QMeudSuoZ/r20BLss2znf4x8ynYrscYEDYhFPVU/9ZXfmjB+I2JgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7UT4++O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A730BC4CED0;
	Mon, 30 Dec 2024 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735584114;
	bh=9bCPPLWjYVyf7JS8peGzskwSjDzld2YccuXauTNEhK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N7UT4++OWem0vXUeKNqvXOkGWcmHb/PoozjdQhQdhNugIg7a9OhDUx204NCBTOZB3
	 ci+kHvsyPnIhQOWIaQ8B9RBZmh3w5GffDHXHHR/mvQhyk9g9+pn1SLizD4Qpa8zKld
	 6grUcd560+yQ4J8H/eKh6n1/eSFBBv626z3/FQxOjFU6fllk7pVaiACsL0gcDt6kbV
	 SaOjXrJxIdkjXxUod1zu5jX0uaYiY7aKseebQNzoeaTsou/fbI1x/6eC3no27iW8vg
	 FcbuHRJaPe+m5KrN1XoKcUoKUiu6hxry+kTIL/GHzu0NzkNljWqNtwPtBCMv35MigP
	 SYgeEW9kZNw7Q==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Firas Jahjah <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
In-Reply-To: <20241225131548.15155-1-mrgolin@amazon.com>
References: <20241225131548.15155-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Reset device on probe failure
Message-Id: <173558411063.95823.1274325128325651766.b4-ty@kernel.org>
Date: Mon, 30 Dec 2024 13:41:50 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 25 Dec 2024 13:15:48 +0000, Michael Margolin wrote:
> Make sure the device is being reset on driver exit whatever the reason
> is, to keep the device aligned and allow it to close shared resources
> (e.g. admin queue).
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Reset device on probe failure
      https://git.kernel.org/rdma/rdma/c/123c13f10ed362

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


