Return-Path: <linux-rdma+bounces-10534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CF7AC0CE3
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0CE1BC48D2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CED288C0C;
	Thu, 22 May 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTZgpFEI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AF221D9E
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920935; cv=none; b=TWvM9GJ4llKPUuClGkMNM/DkfI97IHl4u2ZceezmkWvAyHf0xuT/jUHK08VDmhdm0li9NEpiuOaXOlPXx4NxKvD+Xbenti5WIrQ4AfFhFnkSU/nljvM9WYv33PLkOpeAoQq5LllkMvUTbdicxW/WjtK5cpXhjF4vT2SiKkRWYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920935; c=relaxed/simple;
	bh=E6GMisCJFiYthZlxJKZw4HwAw+Js/4NhY29NzqXCh4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EUjsoWMe1OV6Qf8UD8eIdvzaSPAchUpJf7Cdn90T3OGg7zEFrayuJ2uigpv9K/SbcNi7LHGndezLbDvD9KzYcv2gPHhDV56nGYLxz9T1+uaHwRG2y4vrytq2IK7AYOn1UAA5Rszc6iLrFF+uszKK7yqR6GKFoR4LzG8iwU5Gzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTZgpFEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553B5C4CEE4;
	Thu, 22 May 2025 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747920934;
	bh=E6GMisCJFiYthZlxJKZw4HwAw+Js/4NhY29NzqXCh4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lTZgpFEIIUSg3MZWb2M4xCNSo3xL8r4u1txrzwccajzkQifQm5vcENTS50ROoV4c8
	 FGYB9lUHbugSoROvrFuT6Xwf9fPLUeXSe3534fDTXmeM9lwrV2g76+7FlEz3ki1f24
	 rW1zrjzR/swuevUE87VC7euSkjetqDB7J0dlN26eMyvE7KXP15Hohzg7jKniZVxA8p
	 qF2pEXKj25jqLvsy3Qx0Pmaud6K/wG7yGLlA2J51aQRo9/NiAR/bjgv/agTxr0lOae
	 PGEv6hcHENzedCe5ury+ghc8TYY52CzQSEcx9OPdZCbothlugwcniX261JPjBtKMGQ
	 u29jSu5nQSUWQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Daisuke Matsuda <dskmtsd@gmail.com>, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for
 RO pages
Message-Id: <174792093131.648528.9142432937592148882.b4-ty@kernel.org>
Date: Thu, 22 May 2025 09:35:31 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 22 May 2025 14:36:18 +0300, Leon Romanovsky wrote:
> RO pages has "perm" equal to 0, that caused to the situation
> where such pages were marked as needed to have fault and caused
> to infinite loop.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Break endless pagefault loop for RO pages
      https://git.kernel.org/rdma/rdma/c/01ec1d8feaf938

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


