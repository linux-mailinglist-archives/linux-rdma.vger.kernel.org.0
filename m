Return-Path: <linux-rdma+bounces-15187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D7BCD99F8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 15:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4A7303EF77
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC732AAAE;
	Tue, 23 Dec 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVgWg1V5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4F2E7BB4
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499952; cv=none; b=b0QXkWo2P5J19/W9iY0VOajBSAPx8MGhVuGIz+ELGlv6EmkkalcgJBVMDI4YBGEWKQC0cnMUbstueuUSHfKJySrAH0ZhkdYFNmVQMnw0lUzxBkIY6sS4tZwqv0tTnCQi10Tc8tQbnmDab+tBXmC22Yes2lSGA+nFAuclOH+RBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499952; c=relaxed/simple;
	bh=y24Lycrewii2f1RUA4XWrfM/3NxknaLRIfbq2Zc5Lbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lrYuzNfipgNiT0KpyB1Er+/gEPg/oVsEUbBb08XCfUa29TnmHwgUo0NBtLY2gKfopSPW0eGtHuiULqjPArRNNeMpwSFKchaGik4UBxl1LeIo95xAsefLXBTJhyU7rHFm+klPpzwHZX8voJNh6jrORkeNIF/8BCC+TMkLR5lAel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVgWg1V5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A4FC113D0;
	Tue, 23 Dec 2025 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766499948;
	bh=y24Lycrewii2f1RUA4XWrfM/3NxknaLRIfbq2Zc5Lbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EVgWg1V5Z4nBORkO7U17Y43TRLCAl7vKRQ1ZaCvlAu2mqj6WKhSFJfjV5lMHd0EOB
	 FcuKFo+v1UAlToE0unYQWm9gDS66DEySWaiQU5/CzJd9fIwicXuGz1pddOVJIHWM+2
	 iGooQBlO0bPjt9W57qbJhlinW6Bm3KqIR+4hOaH6Kg9AV4Mt6KkYa0Vc/kycABskLd
	 ogWOWHlLagPk6sJKbqR0npo/874uKGCRwl7grd1JqW1WpmZW6jfx/BEzKUCnPRh59F
	 oDx8vDnkwpkGUNaKDUOojLMMEN9s9A2YYEatNV6z1FP+T+xx5lcIR0EsGwORtNDEQa
	 3qrzQmIdgp2GA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com, 
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
In-Reply-To: <20251223131855.145955-1-kalesh-anakkur.purayil@broadcom.com>
References: <20251223131855.145955-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Fix to use correct page size for
 PDE table
Message-Id: <176649994548.74865.17612734930864098512.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 09:25:45 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Tue, 23 Dec 2025 18:48:55 +0530, Kalesh AP wrote:
> In bnxt_qplib_alloc_init_hwq(), while allocating memory for PDE table
> driver incorrectly is using the "pg_size" value passed to the function.
> Fixed to use the right value 4K. Also, fixed the allocation size for
> PBL table.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix to use correct page size for PDE table
      https://git.kernel.org/rdma/rdma/c/3d70e0fb0f289b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


