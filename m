Return-Path: <linux-rdma+bounces-6237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1C9E3C8F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0428E164615
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD39204F7E;
	Wed,  4 Dec 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz/rnWsP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680B202F86;
	Wed,  4 Dec 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322006; cv=none; b=gmSiNW+NRoI0sRkeC1Rydicf8cwai7pkWh+wanj53aPPeJlq0Og2PhWWk31aKNq4A0C8dNKM5Amm8XpLcPwqq+Pt5IWwxivErN2VEbykv0UUGTWcZ0SEh3Rzm2TGUoZHqyoZI8Q3WYakUIP/PeqXPbO5DYCIuUHqzGypYsTD994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322006; c=relaxed/simple;
	bh=cEygodlCSSsgOR0tv+jvn3he8R1XlxXoXaAakKJ9YMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=URdiEShtBmP3cO+nASrmsV7oLVrjxA/N4Px+2WgFjdJsY6vXGf//viFo+RK9liMIprlEm87givICL8wwFPjA08MYu7nB8Y6FhyNKlVclUWWZ/ASv0M8GXLdVUzhxwWLJRWltNGBXnitdJ0X5Z1QN5uFQm/MeEB5+EqZ68JQ0c8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz/rnWsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD51C4CED2;
	Wed,  4 Dec 2024 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733322006;
	bh=cEygodlCSSsgOR0tv+jvn3he8R1XlxXoXaAakKJ9YMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rz/rnWsPyZtuZBCKWKrPhno8G1wFCyERRdoDOIc3DemTdnDeTzODjs2hcGrzeU6ll
	 q/YRFdBZPn1mm9hTbmoDk8GkTRBpqOYlOAN8RMpEtxPM7oAmLLsI4VYNkMDSPCyaqj
	 HBP/CFDSdB2X0YFGjPfbMvq9F9UU366dzkfDqPmbrY3IhczgUtiUuY/p73/KZslv2b
	 RB2D/NXMCru3FDHRgI3M/jJ6T65SzDzseuCCtp6r12gcsUss4ilPMMK/qB0mIFBgQX
	 VuWim3E5gDRuhuffCrfmjsaxAmgcHehv19g6WxVHyFJElNW0GGsFkAoY+ctZF9ZMko
	 go4jh94C9yDTA==
From: Leon Romanovsky <leon@kernel.org>
To: Roland Dreier <roland@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christian Brauner <brauner@kernel.org>, 
 Erick Archer <erick.archer@gmx.com>, 
 Akiva Goldberger <agoldberger@nvidia.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <b8765ab3-c2da-4611-aae0-ddd6ba173d23@stanley.mountain>
References: <b8765ab3-c2da-4611-aae0-ddd6ba173d23@stanley.mountain>
Subject: Re: [PATCH] RDMA/uverbs: Prevent integer overflow issue
Message-Id: <173332200266.3892997.8099565115676880659.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 09:20:02 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 30 Nov 2024 13:06:41 +0300, Dan Carpenter wrote:
> In the expression "cmd.wqe_size * cmd.wr_count", both variables are u32
> values that come from the user so the multiplication can lead to integer
> wrapping.  Then we pass the result to uverbs_request_next_ptr() which also
> could potentially wrap.  The "cmd.sge_count * sizeof(struct ib_uverbs_sge)"
> multiplication can also overflow on 32bit systems although it's fine on
> 64bit systems.
> 
> [...]

Applied, thanks!

[1/1] RDMA/uverbs: Prevent integer overflow issue
      https://git.kernel.org/rdma/rdma/c/d0257e089d1bbd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


