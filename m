Return-Path: <linux-rdma+bounces-495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93C81E5FD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 09:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4931C21849
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17F84CB4A;
	Tue, 26 Dec 2023 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcdrZBRG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62041C63;
	Tue, 26 Dec 2023 08:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0CAC433C8;
	Tue, 26 Dec 2023 08:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703580081;
	bh=y+AhMMhWk9ELYNhYWdEm1wRhQn+YIKM1qXzUThxbiZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FcdrZBRGwIqsyVh29lEh+FBgQAP0meix3KOIWxzJxhHpIE3JyufPEPl6HWXST9749
	 fS9YMlHixu2lYnz4h+BU0cR18DX7Nn850J7COoFMsLiigF83Xa0Tcc1J8f+7L/Z0Wm
	 Be40mVNzaGRM4rB4HldPqNeVx7mBLWW+AWRslAoy47JlnC5UzYWAcp0GmNYWlw0uif
	 BzLFAI0c8GlPFdty8dgQZ50CNjqP3Wt3PYGXSrGPcraMVDmy7FMCwIa3f35L5FkSDR
	 paQoFtta/ydKYVVHtyLSGQ06lqcJJAiOs0Oidzq3k41vEWsuSKzc+nW8ngGUGTDyXD
	 K7tMImR5Vj0pw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20231222234623.25231-1-rdunlap@infradead.org>
References: <20231222234623.25231-1-rdunlap@infradead.org>
Subject: Re: [PATCH] IB/iser: iscsi_iser.h: fix kernel-doc warning and spellos
Message-Id: <170358007630.15777.18406654613924942699.b4-ty@kernel.org>
Date: Tue, 26 Dec 2023 10:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 22 Dec 2023 15:46:23 -0800, Randy Dunlap wrote:
> Drop one kernel-doc comment to prevent a warning:
> 
> iscsi_iser.h:313: warning: Excess struct member 'mr' description in 'iser_device'
> 
> and spell 2 words correctly (buffer and deferred).
> 
> 
> [...]

Applied, thanks!

[1/1] IB/iser: iscsi_iser.h: fix kernel-doc warning and spellos
      https://git.kernel.org/rdma/rdma/c/d42fafb895246e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

