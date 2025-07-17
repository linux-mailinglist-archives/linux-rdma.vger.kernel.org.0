Return-Path: <linux-rdma+bounces-12268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03CB08F9E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34C43BC5E9
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887A2F7CE6;
	Thu, 17 Jul 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Uq1UgY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FE2F6FBC;
	Thu, 17 Jul 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763047; cv=none; b=PR/hT2ScJB6J5BnnuWIxhMe2r5QGvguHkeHYVeeXTchfvdHmcRfMnqi59ZOqm2f3MMRq3qfHxwfdkLZMy9KJlaDZS3bBJsL6SGmCENDxlugXchF/1Zlbvo90aAhB1ABlMzfSOqdodYVo75tGaep1v0szdtk8U5+Bdb0IFih7nvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763047; c=relaxed/simple;
	bh=NjRdCSZO/uPQxgocn9cXFyu7EG120tinqZsskyrda6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKfvJPIvDc1XCygFkPmtW3TZgSqSmL7Eozmdo8d+EssIynNRJOrGPeCoFhJwZUGQPx79wS2JPU37ErOor5OYfLtrHVRRVFMLFSg4kuC42GJyXaxfjtf8kHNm7Yi5/GnVnJUZuVveo6INfWmlKccx4oxyVVtvdoOBNgga28wO62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7Uq1UgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E87C4CEE3;
	Thu, 17 Jul 2025 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763047;
	bh=NjRdCSZO/uPQxgocn9cXFyu7EG120tinqZsskyrda6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i7Uq1UgY8CtIBqS9v0SBNN3XUSCQH21Ouqh34HAJbzo2CPofKn14HHqHnPrLkW1p3
	 LcCpWLF3Bn8ZF1CWMkmWSVPr1ZnNYpdihTJqjMBbVX3YykiCwjQ+A9+VQdC0ZgzdcU
	 UmehBu4/yJ27G1nsj1BXkYVn31xAtB5VjqJNt9Vb6eV9PEvsjbru/8r/njH92oxEEQ
	 5OyxS/8wDhgCTaAyx49CeshhWVI+8Kw8RitqIOwzRI/9ij11llhXBAfjYJFQuJmePZ
	 +i4yBAL99ayWeVf5sHRUK/+e7FmvF7h99X3tasMLLDkOzi7KvIQGKSn/gRAhvfJRYK
	 NdFejXGXY1YBg==
Date: Thu, 17 Jul 2025 07:37:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Update the list of the PCI supported
 devices
Message-ID: <20250717073725.4e302fe4@kernel.org>
In-Reply-To: <1752650969-148501-1-git-send-email-tariqt@nvidia.com>
References: <1752650969-148501-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 10:29:29 +0300 Tariq Toukan wrote:
> Fixes: 7472d157cb80 ("net/mlx5: Update the list of the PCI supported devices")

I find the Fixes tag a bit odd, I'll swap it for a cc stable, let's see
if Greg complains

