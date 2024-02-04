Return-Path: <linux-rdma+bounces-885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4402F848D06
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 12:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE15E283532
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2A2137E;
	Sun,  4 Feb 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jihpw/iG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FCC8F4D
	for <linux-rdma@vger.kernel.org>; Sun,  4 Feb 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707044783; cv=none; b=lnvsBmoC9m9OCKCgMgIw6hdUDaPPxIxbp9VNQJCxMh1t43j7SmId7O+Sp+BAxNpVbOIhxKYBiL/KXUK62dtto4fcLeHjRpCUI3XzNa+f/G1V8J8QziTdR3J2zFHGaxK1jlhK8tpKNfC8RrHn2drJNL0+oG+eDANWMaDXn+8mt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707044783; c=relaxed/simple;
	bh=udi2VvkUFv6XZobyoneeJmc9ZKX9s6hSb41Cxvziwyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=keqTCqtRwOe9gg0LWUV309hcJQ0gzweV3eHaJFuw/zCvHoD3VDIYsYvRuLvvkPxa1wr7MkDwETM4+lKspy/07Lx5meb/SsA7NrOKSf3mugKaW3iphwJWnlbXdxYbUgduEONTJrhKYX0bv/LhJE1eJbQk9C8tVhIVUyLLJ7me4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jihpw/iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821D0C433F1;
	Sun,  4 Feb 2024 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707044783;
	bh=udi2VvkUFv6XZobyoneeJmc9ZKX9s6hSb41Cxvziwyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jihpw/iGRAZbLDe3vjPTa86bPfQdi4ft84/gnvleRQaYalFEa25CADY42tIKR76Ka
	 n/oAm1qx6ncS72+7Et8oruH3jFaBcxle8l3edg0Ebo3t6118ifWluljsUAfXlrlROr
	 9AhUvRRY6ARyhpudC3C1n3KxzzkrMnqnlfv/1bZsL/cfNr0UUUH6zB9kcitsopSPn3
	 8nHUOiUi2kQs1DKPIavO9ST1M65x+PZYAD/mAmOGTWwaN7QclmLTMEfYWZvALSihKw
	 Gv8wKshUjk6DWlDTAGVtd683NHKYBTCX/5yHow7JQhRChwmiUZ3XjN9Uy+x4npGD5q
	 e6hio7MsfJV3g==
From: Leon Romanovsky <leon@kernel.org>
To:
 zyjzyj2000@gmail.com, jgg@ziepe.ca, Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20240202124144.16033-1-guoqing.jiang@linux.dev>
References: <20240202124144.16033-1-guoqing.jiang@linux.dev>
Subject:
 Re: [PATCH v2] RDMA/rxe: Remove unused 'iova' parameter from rxe_mr_init_user
Message-Id: <170704477884.25972.5184707711138048242.b4-ty@kernel.org>
Date: Sun, 04 Feb 2024 13:06:18 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 02 Feb 2024 20:41:44 +0800, Guoqing Jiang wrote:
> This one is not needed since commit 954afc5a8fd8 ("RDMA/rxe:
> Use members of generic struct in rxe_mr").
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Remove unused 'iova' parameter from rxe_mr_init_user
      https://git.kernel.org/rdma/rdma/c/aafe4cc5096996

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

