Return-Path: <linux-rdma+bounces-959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41B84D090
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 19:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D22F1C21152
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CB12F38B;
	Wed,  7 Feb 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWYSLVLb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBE12EBC5;
	Wed,  7 Feb 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328756; cv=none; b=AXvjfQSYVZVyVoLWOgA0ShWtnmP4VZg+nuTwgqGrryNHO80od3gC8w6yJd5OT4ydtVJKPK/IbP81VHuwPliLpMaqJvnJ5oFAgXPWqyLQOmALStpG7wnZhwCHGYLZ1addvh2PpQA+yUp4Wr1hvLz/xj0ToBngdJPo37LbDrS7Z1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328756; c=relaxed/simple;
	bh=sNzlfsT83iJFrdxwBX4Eu5qqxqZ9Kf+anBvZHLzk7+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nd1OmH3l2f1PIe3zGBRFEq1RO7POeDdUlEyaGIJ5fMg23wOjGUMqlQp3B5KcP1DaOu29hFbMbAI5rCAWzOegF6lX5sch5K1tck+rk0BXgVkEpIVRMmPPM01yBwRdAunk4fYuO9GHSt/j+bwfjGFuTqEBAA9tSl70X7u9QQhhwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWYSLVLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FA0C43390;
	Wed,  7 Feb 2024 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707328755;
	bh=sNzlfsT83iJFrdxwBX4Eu5qqxqZ9Kf+anBvZHLzk7+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FWYSLVLbFkuiVSNb9cRLW6PAaezCDOz7bbA9IwDGR7b1RsNIyX4G7dROcZb/EZ9zr
	 pX1N48KGdtTW/0GxdIAP2w68AD9wdjFqBgGhwrRC+RnmZNPIiqXrwid94G1pmCD2Xp
	 fPv3ePzPS/E01qzzRw7KblxojBEKWTUTkC29yoNnURs6C640UT7NVevwxJuoNfeMXC
	 YnDpy8ZPgaeGt3ma+sg/09Mlts/riaDG8UQZuQN+Kkux0fLVBGZG+KF2DKLPIGUj+u
	 XguDNkut/OE+rfhl5VGphKVZC5EJTwvTD69GGEchdtwIO4aTTR13iHzORZoJt99SH1
	 7MvhYxnwF9/sg==
Date: Wed, 7 Feb 2024 09:59:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, Santosh Shilimkar
 <santosh.shilimkar@oracle.com>, "edumazet@google.com"
 <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] net:rds: Fix possible deadlock in
 rds_message_put
Message-ID: <20240207095914.49ba5293@kernel.org>
In-Reply-To: <6c63549d6771bfb1ab410338b2dcea3e3fedb415.camel@oracle.com>
References: <20240131175417.19715-1-allison.henderson@oracle.com>
	<20240206184809.1a245236@kernel.org>
	<6c63549d6771bfb1ab410338b2dcea3e3fedb415.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 17:23:53 +0000 Allison Henderson wrote:
> > This is not a correct Fixes tag. Please look at git history  
> 
> Sorry, the fixes tag identifies the offending commit?  I think it's an
> existing bug since the code was introduced.  Which would be:
> 
> Fixes: bdbe6fbc6a2f (RDS: recv.c)
> 
> If that's not a useful tag, I can remove it too.  The syzbot bisect
> points to a virtio commit 1628c6877f37, but that doesn't look correct
> to me.  Let me know what you would prefer.  Thank you!

The initial commit for the code base is very useful to backporters!
It tells them "you have to backport this all the way down".
Lack of a Fixes tag says "I don't know where the bug was added".

Fixes tags are more about telling backporters how far to backport
than about blame.

