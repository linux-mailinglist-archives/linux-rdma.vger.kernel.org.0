Return-Path: <linux-rdma+bounces-6378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A09EAB72
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 10:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ACA287604
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B41231CBB;
	Tue, 10 Dec 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXkJUmS6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824A232784
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821769; cv=none; b=cL+jE+4eF0zitElZnvHM3MDBUxoqgJtkOVW4e3IZnJTaDX0xH8aIUv0mYTnTXce1zAdOoBigG3kDD1lPUqin2oYlE58v1VmKt59T5Za8+xYOl/bv2tjSvHqrKRjcpEpL3Jzvzghk7JSLqspLt6rwOWDObJgy+Q7X1qz3nYiHDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821769; c=relaxed/simple;
	bh=eQsK4rNVMfY5sUQu7FHorbQz4qsBPh5NnqvuucqpCfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AI/axcCr03lxLPrz94Mm2tU5cJlxO8cxclnoKThUuedYfv3Ko1e8Tz+HfA44yd1zGEK4zmuXWLqzcPf9857w/DiZnQj+kNMEB3aoBI+ehXLFmsPfyzkf8YU5sdjP598XpaIIDpGe2jgdrYs74QbnCOL179piVtjmwRjGck8+6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXkJUmS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7295C4CED6;
	Tue, 10 Dec 2024 09:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733821769;
	bh=eQsK4rNVMfY5sUQu7FHorbQz4qsBPh5NnqvuucqpCfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OXkJUmS6GGYQycSVX7Envin5OLktbOFCLHPa4Etgv4i9kfjwYklrNW+DWtEzXWgGJ
	 qUr0AiXx2F3bBd1e64fPD29C8+WDIWsxcPZvtOWvtLHhvMy3Be7nf65GGjW7NQQomp
	 N0K3TGuQo7Bno3+WPWJ/FHbl4q3sfi+anW8ELe8b+S0rMelmVrFUM9dZPVQcTo0C0K
	 YM2azto0yTl7Lc4eDUQ6mAniAllckKD59OMrMV1HoDqpWQVFkTZv8uDzG1e9xt5V0q
	 vECL0UjRvTQnRjN/soQQpyqIs92ZGFi5HWeO2UFM1JhN+bKQXc3JMAhCOIs9FrRuMk
	 +wERO7IEpDY7w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <b18f29ed1392996ade66e9e6c45f018925253f6a.1733234165.git.leonro@nvidia.com>
References: <b18f29ed1392996ade66e9e6c45f018925253f6a.1733234165.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Extend ODP statistics with
 operation count
Message-Id: <173382176604.4112442.9509917218990601500.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 04:09:26 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 03 Dec 2024 15:57:11 +0200, Leon Romanovsky wrote:
> The current ODP counters represent the total number of pages
> handled, but it is not enough to understand the effectiveness
> of these operations.
> 
> Extend the ODP counters to include the number of times page fault
> and invalidation events were handled.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Extend ODP statistics with operation count
      https://git.kernel.org/rdma/rdma/c/fbef60de6c7532

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


