Return-Path: <linux-rdma+bounces-12350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE203B0BC80
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 08:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533633B3936
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CFA26E700;
	Mon, 21 Jul 2025 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCzpbokU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92662241669
	for <linux-rdma@vger.kernel.org>; Mon, 21 Jul 2025 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079331; cv=none; b=IWL7cS3ccr0IeKDBWiYZijTfWASzSBHFxq+X1PxWtApGNiy7WihiAfnN33oeyasxz2OUCXu/IBC6M8q2kw976/ynKtm+gg15eJhjwRha+z1rgW1h0dj86u9jSEqOFDa5PJgaH3mep0f3DC21zsHP9MMH1ufKTd8+gSVcrWnNdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079331; c=relaxed/simple;
	bh=5Gb9VfWwYhyc2SVRGAc/Zg+FN0twAyWv8B2FE8UOZ6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BAAuTr+iQYw4NNCXey6+TQ3Vzmjpq+8DfG3c835vHQwHdhcSBt7k/mZ6/DbaYMpjgLj7xbhSuLLOhW2FDgwpdabiGF41WHxAfNhR7tys1nE1GUdlnIP9YHQVAztN/BcmXmhSB6Lb/4ucilmaURRfsQxEDGGvsCyJWAUZoOZnILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCzpbokU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9561AC4CEED;
	Mon, 21 Jul 2025 06:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753079331;
	bh=5Gb9VfWwYhyc2SVRGAc/Zg+FN0twAyWv8B2FE8UOZ6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MCzpbokUCcLvE7yex8R/XHwyIL4oRuBsjTH4bzRms9+kXk4A8vy6NhxQSTRAPUxWO
	 6EVLfr+jxBFNomR23XqAmep1HOCHlBiHuOuiW6Xtdq+a72rB10xpG7RhDBTLt8pL71
	 ISNoOzZfZ8fZiaJZO9qx5ygn/nc5KG4LkxqSbgrESGxfn17lJQenFWt9cim4FEfrSg
	 yVefL0E1AJ3XGi6mGFaPPbPlZNOOBDNiats5e+YHGYr0Ge+yiaIh7iJpj5ZMiuZZ7f
	 bur3xrWnoUXl26Rh6k50RUcnYwkfsjLZPz1kv1S6rEdFOSmdo9hFuslRf8+TA8cCqO
	 iSHLvhkKfNVFA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: "Colin King (gmail)" <colin.i.king@gmail.com>, 
 Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <71d8ea208ac7eaa4438af683b9afaed78625e419.1753003467.git.leon@kernel.org>
References: <71d8ea208ac7eaa4438af683b9afaed78625e419.1753003467.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Fix returned type from
 _mlx5r_umr_zap_mkey()
Message-Id: <175307932726.1017652.1060677183695337318.b4-ty@kernel.org>
Date: Mon, 21 Jul 2025 02:28:47 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 20 Jul 2025 12:25:34 +0300, Leon Romanovsky wrote:
> As Colin reported:
>  "The variable zapped_blocks is a size_t type and is being assigned a int
>   return value from the call to _mlx5r_umr_zap_mkey. Since zapped_blocks is an
>   unsigned type, the error check for zapped_blocks < 0 will never be true."
> 
> So separate return error and nblocks assignment.
> 
> [...]

Applied, thanks!

[1/2] RDMA/mlx5: Fix returned type from _mlx5r_umr_zap_mkey()
      https://git.kernel.org/rdma/rdma/c/d59ebb4549ff9b
[2/2] RDMA/mlx5: Fix incorrect MKEY masking
      https://git.kernel.org/rdma/rdma/c/b83440736864ad

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


