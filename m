Return-Path: <linux-rdma+bounces-1958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A318A69FC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 13:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9C9B2166F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC93C129A93;
	Tue, 16 Apr 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKRdBH2N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E87128361;
	Tue, 16 Apr 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268573; cv=none; b=pQdMgVLynCTvG3yRNpkOMZ4wv545UBYqvZqd8qH2kNAwFO0cT4n/zWMcpbQEmczkYx/MlKwhMaYTTMgQmdiuamdeNBZkoC7s8aTSs17meIn9YvYJXF0ZKVMYcPW1Qj1B1kd+1ff0FXyOV+Zp+qcTyer5xEBfD18LnuW4or4Lb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268573; c=relaxed/simple;
	bh=QIIgZPlU7sCpPuc1DD4+2O4Bt99x0iraayLWZnSrc0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PA1RsGqQMxx/CbCXGtRQuTRdeLXB1eYzIpr3ALwLVk9KIoWqYZQK4RA6hoUrOTm1C9qPjoTQyCHbWAf1x4HMBXKjkoGtSKHRRshSklA+07O6j6rKfv9bOz28kV6G79tQjLD2FEExpU+yX+tSHoI8CbaCeSxEsalR3RFDp1OrrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKRdBH2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852D7C113CE;
	Tue, 16 Apr 2024 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713268573;
	bh=QIIgZPlU7sCpPuc1DD4+2O4Bt99x0iraayLWZnSrc0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bKRdBH2NbW05BHkuRK8VGKFRqdG/cZ0uVqtmx7+tUk0bni6Ee4FbJbrAi4DzaCUhA
	 +eirpN80NVh6fMXycMB21HEaVyCF/8zJfT+38T7hMaZAAX6aWtEgRUz+1lBoEu7Psg
	 1vzub5UxbMKmXguugwVfxQU//1v8c5luga1/hMrtkB5fcZs7SVvi1NvRsfBq/1NErw
	 3m7jR777V+O6LdhU975kvn5D6G81TniOMbckQbCqC9DJMVL9F0R4NY/lVNNocsrdsC
	 n6dzbs9ghfXYXcOTXLflXc7pBVBzoY/8CxxhbDVypOvbSHINXqDyZFYc6gGtWkrgwL
	 qpj/gHJ06i1Gg==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v3 0/6] RDMA/mana_ib: Enable RNIC adapter and
 populate it with GIDs
Message-Id: <171326856734.751269.15693523737204634211.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 14:56:07 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 10 Apr 2024 01:42:25 -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series creates RNIC adapter in mana_ib.
> To create the adapter, we must create one EQ.
> In the future patches, this EQ will be used for fatal RC QP error events.
> In the future patches, we will also add more EQs for CQs.
> 
> [...]

Applied, thanks!

[1/6] RDMA/mana_ib: Add EQ creation for rnic adapter
      https://git.kernel.org/rdma/rdma/c/98b889c43935c4
[2/6] RDMA/mana_ib: Create and destroy rnic adapter
      https://git.kernel.org/rdma/rdma/c/1a79c2b9d4a087
[3/6] RDMA/mana_ib: implement port parameters
      https://git.kernel.org/rdma/rdma/c/4bda1d5332ec1b
[4/6] RDMA/mana_ib: enable RoCE on port 1
      https://git.kernel.org/rdma/rdma/c/8b184e4f1c328d
[5/6] RDMA/mana_ib: adding and deleting GIDs
      https://git.kernel.org/rdma/rdma/c/faafb8b126ad60
[6/6] RDMA/mana_ib: Configure mac address in RNIC
      https://git.kernel.org/rdma/rdma/c/8859f009ace237

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


