Return-Path: <linux-rdma+bounces-9833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF3A9E2D9
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046041895198
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57AA2512FE;
	Sun, 27 Apr 2025 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLsdIxq6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCD1F8AC0;
	Sun, 27 Apr 2025 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745754697; cv=none; b=t49Dmb9LuPuJDszebo/5tuSJYtSv9b9XgDxAOZTmmK/KshHqKVPo2HU6r2oVp4PSzb7kJJcp8uN50D3H5SomDrXvazebTlqRvIbgA9KXu+d+9QcUvWZRV21CeKF6uh8KW2Ty1QJC8qXsY3/+uKmw6GH/6K6DociBPTKdV2zg2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745754697; c=relaxed/simple;
	bh=WYNqKMfimdJk40p5rXyhb8hk5bNYLagOGxQA8elAMAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N4we/1lXEHEXNyip2PdUf+cWeg8R/t/TxxGyV0QBsG415xXxLKoSH1LPQvPCHYiY3adozX2HScpcRDZO2JaL1SSsKwpkaDoV81sho+YUZ+s1GA4dQV8SDiihy/MSaa3Rcmxd50KG6/ks06W0L4TPNfjxkhE62Rpjwu4LL+UrukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLsdIxq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DFDC4CEE3;
	Sun, 27 Apr 2025 11:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745754697;
	bh=WYNqKMfimdJk40p5rXyhb8hk5bNYLagOGxQA8elAMAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qLsdIxq6a+OVk88MBp4fBIoh49emWT6UtRj3vbaufZyFBh0EkQf22ffJQ9kPaZkck
	 y33u/oeXswaliN/tlUderj3fXNF3kMv37scpGmYswy75WnKOBdGbTjBCKRrA1KOtN+
	 D1UWa5JR+MwiF9Oa3VZqe+iH2o5odOxkdw5JrhTd5kYf+EAhLKyHlhYsH+p4Ml27IN
	 OcAA4v3qBLZTmJ5Spv/GhzvdGHViLq6ciYrK9J2aivruxfWtDgCjt4dKSKVJAl+X7d
	 9CBNsCeiGhfobWgvxhFv1xwBvp0IyD6+P3tMyvmExM9oty7iu+P8gN+2x0I+LtSavZ
	 bUK759+GIWTSQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <kees@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20250426061208.work.000-kees@kernel.org>
References: <20250426061208.work.000-kees@kernel.org>
Subject: Re: [PATCH] IB/mthca: Adjust buddy->bits allocation type
Message-Id: <174575469294.624502.10507958701914399928.b4-ty@kernel.org>
Date: Sun, 27 Apr 2025 07:51:32 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 25 Apr 2025 23:12:09 -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "unsigned long **", but the returned type will be
> "long **". These are the same allocation size (pointer size), but the
> types do not match. Adjust the allocation type to match the assignment.
> 
> [...]

Applied, thanks!

[1/1] IB/mthca: Adjust buddy->bits allocation type
      https://git.kernel.org/rdma/rdma/c/7c04bc97171780

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


