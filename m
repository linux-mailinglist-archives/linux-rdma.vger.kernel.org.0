Return-Path: <linux-rdma+bounces-9610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A980A94789
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C11188F487
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B507A1E5210;
	Sun, 20 Apr 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2DrbTfN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AD1E377F
	for <linux-rdma@vger.kernel.org>; Sun, 20 Apr 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146583; cv=none; b=MFK2Ux9gOBxEixQ5CdKz0q/D2bSpp+G3dlFIMtBRJhii3rARxo3xMpxxPi5La4jbrdXXncvipKVip+Rn0wP+TdewSSH/KSwQa2yvxvvzObFh0KNYBodo0e0WWv1sDDYzuaafC5p3hVl1cxU9gymj3alLfo1C+yKH3Pk7XE3mD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146583; c=relaxed/simple;
	bh=8KhVkIfbGDuiJWHQJ99cdU1m8dleZWC7LUBZWWe/K9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HvLHciQc+iymHINJW98LcP1k3/+96T1ZvLMwEV15IOMai3yhCZ0xj/wK8kwwdydnfTNTD/CmNp2k7ZNJjlH/z0pr8vCWT64CIEufGouVcP2/Cr9Xid6hIkhQn+fQ5leRkvMR6RAjLwcn3QlLL47pFl6lgQBWygw01ZrRlxpw3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2DrbTfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDEBC4CEE2;
	Sun, 20 Apr 2025 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745146583;
	bh=8KhVkIfbGDuiJWHQJ99cdU1m8dleZWC7LUBZWWe/K9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X2DrbTfNBtDXbDEQPEJP+XUyNaO/LxN1Gjuf3xiAtqcvE0mDCyRvHyufs45e7/1b/
	 SHLAny2DlbHvP8RPn0D/2BmYoxM0ng7VWfvV5dnJVh3xOP9EMAgtFkE09pqbbykM/S
	 upwrV03MiJTPjjtlp0c4SlNBOxBq7sYZO9mLpnzgnA8q8caXkTnCOrpXi8Dj+nsMyn
	 MPiyftyC8cqDv/SlEE8scPntUahpilz2QDRRCh9+5Htxq4dDCHCKkzESRz6pazxFRA
	 AjR3jsg+jHs2fY9oUGlZiVrEHpWwyxBJw1nkyFh1Evx01f23tGQxJ8aaQY6om5nttL
	 PuSC+iotCm4/A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20250414234231.523-1-tatyana.e.nikolova@intel.com>
References: <20250414234231.523-1-tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH for-rc 1/2] irdma: free iwdev->rf after removing MSI-X
Message-Id: <174514658010.719262.13870226048967432907.b4-ty@kernel.org>
Date: Sun, 20 Apr 2025 06:56:20 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 14 Apr 2025 18:42:30 -0500, Tatyana Nikolova wrote:
> Currently iwdev->rf is allocated in irdma_probe(), but free in
> irdma_ib_dealloc_device(). It can be misleading. Move the free to
> irdma_remove() to be more obvious.
> 
> Freeing in irdma_ib_dealloc_device() leads to KASAN use-after-free
> issue. Which can also lead to NULL pointer dereference. Fix this.
> 
> [...]

Applied, thanks!

[1/2] irdma: free iwdev->rf after removing MSI-X
      https://git.kernel.org/rdma/rdma/c/80f2ab46c2ee16
[2/2] ice, irdma: fix an off by one in error handling code
      https://git.kernel.org/rdma/rdma/c/4bcc063939a560

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


