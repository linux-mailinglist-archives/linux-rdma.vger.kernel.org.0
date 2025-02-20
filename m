Return-Path: <linux-rdma+bounces-7875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B26A3D177
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8F416C02B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021021DE4EF;
	Thu, 20 Feb 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3clhziG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2118C322
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033745; cv=none; b=Nhok4puWDXU9JKJi4+VPWik4DT9x3kLp6wozIDJS0vyVIHFjz5FNdxnNOjLOIPrVuTBE6neVFHpCc4z5q7xp9i+XgquKeKddPSFoKsdkCtcxCqHWuC4Se971HasLvUKWigstSwqM6owgOdVLkplqphpZnJhQX9hQ9WtLdqD7a3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033745; c=relaxed/simple;
	bh=Awwgyez1nfCCqXNG64P004zLfTAuZ3D4WoE1b62sm+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iwA84oFXxxjK2KMMXSrg5L4Kqoltbruq/z+T0VCAZrutIIk4xxUYU25K+ZRXvtOCqCChe+MtCPD6xCEkDHSV9mIWT8YJRjORh5jY9JwHbqm16vSLGnHZy7fQdNy8TlmHUMdBpFt1C9UnTbNZeDUwKdjX8/8r78SCeCylzi4PrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3clhziG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF95C4CED1;
	Thu, 20 Feb 2025 06:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740033745;
	bh=Awwgyez1nfCCqXNG64P004zLfTAuZ3D4WoE1b62sm+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p3clhziGqJViTYSDEcU67qeHDqMBhiv0NSrrSHqhuukdAJ4wYZ4bgGhVVro6Aa1gD
	 QCu761YLI0UeSahp316HASuOfb9ThbUe6yo8sdBvCSpTAskt+8KgUog9lGbkXC9OY+
	 xKsKWZacikKn5uYX6hz9lWqteZrqcJbnR7QbtnB4J/X8/InqqEGhX+Z4Dbn5mBkIjr
	 Tr6Wr4kDJu6+1/OvDAzlETJ9P5Ybf41gyPG58N5D2DujlAzMdjf71RIaHm+jtxsEBY
	 Iw7G2t2qo+EZ6EGCao4Vlm316CxLNiJQoG4dsMvSUPKXGUy16dcsLU1OJ4XPDVRY3J
	 50Ypvo951jF1g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, 
 Artemy Kovalyov <artemyko@nvidia.com>, linux-rdma@vger.kernel.org, 
 Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <80f2fcd19952dfa7d9981d93fd6359b4471f8278.1739186929.git.leon@kernel.org>
References: <80f2fcd19952dfa7d9981d93fd6359b4471f8278.1739186929.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix implicit ODP hang on parent
 deregistration
Message-Id: <174003374190.429204.18405288054975982732.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 01:42:21 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 10 Feb 2025 13:31:11 +0200, Leon Romanovsky wrote:
> Fix the destroy_unused_implicit_child_mr() to prevent hanging during
> parent deregistration as of below [1].
> 
> Upon entering destroy_unused_implicit_child_mr(), the reference count
> for the implicit MR parent is incremented using:
> refcount_inc_not_zero().
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix implicit ODP hang on parent deregistration
      https://git.kernel.org/rdma/rdma/c/3e2ced4fcbbdfe

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


