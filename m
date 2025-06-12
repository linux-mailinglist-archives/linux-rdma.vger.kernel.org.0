Return-Path: <linux-rdma+bounces-11252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E530AD6BD5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 11:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD693B00A0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E04224AF1;
	Thu, 12 Jun 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD3cqVu9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7361F3D56;
	Thu, 12 Jun 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719400; cv=none; b=OOnEQX5w6e2dTKMULbOhQ5i7PcgvapluuHqVCmnfD+QebrOw22r8fwyj77IAidyqRLcZsKl3kZxqts1rnFEnxV00JIQO26Lqo1cASd2YQGwsLq5y7WkAbJ9Cn1nHu12HlFUik9tyucwx1f24QvYd6iZE7jFDwXHjHUezWA64nVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719400; c=relaxed/simple;
	bh=z0RTtK9r5ywIYC7VEDioMum2J35lkVubMtpFRXbBLsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I0SPs6bgWwSsn4NzB3qHMepWN7CjlbLxKuLfGahVxOW2UKLc0u8qXDSBB2JnbGzVeLH4NB0urmKxEd1VAH9Rb3pAQTHI8WICj/FWTea4p6Qpwb8hzXiufbrIVo4UC5Gd7l3eQjesFSfJMfxU5Bnt2qhuhSv5lUN3MZAYXXAR8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD3cqVu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D990FC4CEEA;
	Thu, 12 Jun 2025 09:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749719400;
	bh=z0RTtK9r5ywIYC7VEDioMum2J35lkVubMtpFRXbBLsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bD3cqVu9zuklH3UrhpzeRg6yzOlDU5IAYvOYfQvc7Ad7hLLZBANti9EyKIWIBSwWI
	 ay5NGfMfwKMCW7+hKuwJcvISWi734dxC56QzkeNtZrPtVDbWO8g0djXmwpVmBgRmHb
	 JGuaEi057WDNRNuBQDlkrjDDdr+/oDuKCOmeomKAaS3xq7szdE8JTj4rJuEJWNK1OP
	 MILhNY7z3o7gWdno5dYJ0NISGipDfBf6PAHH6uxksm9HKkDAwesMOPBBDy08kSSa+m
	 5JYanq0+0ggETTAwNb3hcAv4GFKu1W6EZKB7jnHXkcFUNBgWjvxG2c42Js54TDDgOB
	 bG6Q/EggatGWw==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1749559717-3424-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1749559717-3424-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Add device statistics
 support
Message-Id: <174971939753.3921946.3677169893703464160.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 05:09:57 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 10 Jun 2025 05:48:37 -0700, Konstantin Taranov wrote:
> Add support for mana device level statistics.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: Add device statistics support
      https://git.kernel.org/rdma/rdma/c/baa640d924e55e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


