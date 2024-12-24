Return-Path: <linux-rdma+bounces-6722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871229FBBF2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 11:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0904188C992
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC551B0F2D;
	Tue, 24 Dec 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De1KYgTW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B140188587;
	Tue, 24 Dec 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034460; cv=none; b=lyAJPuzaFuhsmLKAC3WpSpApwbmjNf5/dY0XfFZvdkzxQPg+gX4LuFduNYnX6okigrFEuzqsJO4GUM7xtG/D+9U8j9CMMoaU5kJgVcdkZb+QJDoa6+UKGpFV3on7nDONFWFUDMulYdVmkduwPLtvINSsPK8P2VfZNcmZdjvgZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034460; c=relaxed/simple;
	bh=iO4LzxnMWCKR9th1fIUmGTz32Awx/ELCS3WYCKskj+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gnS9A2Cdqesc7Usi6VJs1tjgANQhp/kFOK9fnFDscct/q7Pmksl0evhzLe4O9jQcd+wtoh+h6s85xOgwyDSWUhGt5ZxHMezLXO8pep8eCNOARo1+EOEJhrkNW8TlkH0z1hU3HD5X9jUzYZOTl5HwzG/y1Hp+JcS1z84JaYP+KVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De1KYgTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7F0C4CED0;
	Tue, 24 Dec 2024 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735034459;
	bh=iO4LzxnMWCKR9th1fIUmGTz32Awx/ELCS3WYCKskj+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=De1KYgTWb4TKjhf0CFKlVNjD7FOPGhzy8nZCRDXAh0Cz3Ox5fKJN58MqYq53l3ZhO
	 rT0s47ZY0ydnqjEDWNYIl+un3nUEMiSHLLgvzl6DSTQ4sLPtxA0ISHPq7KhTlUUT1c
	 +2clBXWzUAqmYRxYZvYj5mtTcu5iQIWb7ddhDh8ZPg/Gx6TDR5l7dIfEAG+oEjqIdo
	 vsrFwiOLWj7PuANsgXs+QPc6KpQcQ8L2jcFn5ZhEBUfFkgrasDhZpZz/vByPVwKN/0
	 Gxug+CHfCwOmSkTeY2WzrAjQB62IwL31F6pvW052FoAfppZOeQgmj9ifQVTwu5w9V0
	 cekMQD0B1m5FA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux@treblig.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241221014021.343979-1-linux@treblig.org>
References: <20241221014021.343979-1-linux@treblig.org>
Subject: Re: [PATCH 0/4] RDMA deadcode
Message-Id: <173503445650.413911.301360503970776645.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 05:00:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 21 Dec 2024 01:40:17 +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> A small collection of function deadcoding, for functions that
> haven't been used for between 5 and 20 years.
> 
> These are all entire function removals, and are build tested
> only.
> 
> [...]

Applied, thanks!

[1/4] RDMA/core: Remove unused ib_ud_header_unpack
      https://git.kernel.org/rdma/rdma/c/30dd62fa3954cb
[2/4] RDMA/core: Remove unused ib_find_exact_cached_pkey
      https://git.kernel.org/rdma/rdma/c/ddc8fab40b9ae3
[3/4] RDMA/core: Remove unused ibdev_printk
      https://git.kernel.org/rdma/rdma/c/750efbb9c307f7
[4/4] RDMA/core: Remove unused ib_copy_path_rec_from_user
      https://git.kernel.org/rdma/rdma/c/2028c2958775c4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


