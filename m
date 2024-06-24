Return-Path: <linux-rdma+bounces-3441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76A914FB9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95F71C20357
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17C142627;
	Mon, 24 Jun 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyHvZlEj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0D20330
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238735; cv=none; b=RTKo+C8biwGMErnManGRIXcDxZ21Yj22Cq99U+roJSo7u57xn2p+iqGwMTTuR+6ge/fdXprzUdOgyb7X4Lxk5jnGd9OYkKSaOBd4J7jp9Kgat32OhBntqNVw+pD13vOVCj0zR0GXmduI27yOaiXzW3tofa2lsBGhVCf/RNmDpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238735; c=relaxed/simple;
	bh=WKtf9nV6nGucDW1CJXDuHjEEddXp6Q12/6jDbmRBMoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FUCNaOJIitn9bdgknTl8wzQb/N8+X0BhB1yh3XPfGQP5Wkmm00faxXoqYxW+iJMrT4rqV7dE3tH4p4XwTzoCBI5zOBnuWSolaQ94yiJwzfk7+xlH/lLxaogYs1Kips3Gexuwvo9z19uuELjh9ncs33zTzwR++/iPT+ETROKHDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyHvZlEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B7C2BBFC;
	Mon, 24 Jun 2024 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719238734;
	bh=WKtf9nV6nGucDW1CJXDuHjEEddXp6Q12/6jDbmRBMoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XyHvZlEjJni5eRuS2Qep8mww7+hEPialbIi7f9CBqH6Nkvs3LphmZBMYor1J0PiLI
	 AbLf++EeTmDm14RniVeNnegOy6x4ZCml8HdAIumNsNho5fKTae0g0fh8N9mN1H/7EO
	 92aT8HjDYFHh3b8MGyNZ0v8hzY4+4JNVuyWn0G6GPqDcA9h7iGAWltnjn8MV12f6UV
	 OQiTb1zxF2XHnyH59oVVJhpKOmw2zrARigR2I5Rdwb0UDpSDLFaAsH+ULvYmcBSGMb
	 0r+zOcSsH3HhBVXzw5H//aY86jkAMMAgiptc+6zzMyE2WKtNxD3sF4P35a68Yxtjxo
	 teh5DTJE5tfmw==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Honggang LI <honggangli@163.com>
Cc: dledford@redhat.com, kamalh@mellanox.com, amirv@mellanox.com, 
 monis@mellanox.com, haggaie@mellanox.com
In-Reply-To: <20240624020348.494338-1-honggangli@163.com>
References: <20240624020348.494338-1-honggangli@163.com>
Subject: Re: [PATCH] RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs
Message-Id: <171923873138.465691.5079469853127857176.b4-ty@kernel.org>
Date: Mon, 24 Jun 2024 17:18:51 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Mon, 24 Jun 2024 10:03:48 +0800, Honggang LI wrote:
> BTH_ACK_MASK bit is used to indicate that an acknowledge
> (for this packet) should be scheduled by the responder.
> Both UC and UD QPs are unacknowledged, so don't set
> BTH_ACK_MASK for UC or UD QPs.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs
      https://git.kernel.org/rdma/rdma/c/371c54bca36fb5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


