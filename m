Return-Path: <linux-rdma+bounces-1995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17898ABEF9
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Apr 2024 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C9B2095B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Apr 2024 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3613D53B;
	Sun, 21 Apr 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afx5ZWMz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA7635
	for <linux-rdma@vger.kernel.org>; Sun, 21 Apr 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713697269; cv=none; b=IB4L9LoCce3ox0Dr3QRpl2cRrwcPzKKvhQpp7I4xv34L9pFGOyg5Qm/O2sAvyNq/fLD70gQZCX3OsAh5a8dP3kIutywsEC4rlxG0zw5V3TWpGA2ByfGrxYWeGIQcmyeeRqACiM/hLwToh5R4BaqEdAxRWlzMzaDENso/OcOQSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713697269; c=relaxed/simple;
	bh=m7F13VISs2G88UsWdBqx5Uhj925SYkP6NpxnTL7qMOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EhSvv9nGYYPT0xKA+cdpPieB5coacKzzBUhqRE2zauKNkOIEXl/Ge+5LMilG2YwcPbCpNJWnv2KXDJ/47aBSRXof/RZjMDODy8IhHdBPLKoqT8/kNkzb2ykT6XP7cNU81pB2Omj+hNXSNXktKcuMbYgVKtNi/kP/mvRNV08tPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afx5ZWMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2410C113CE;
	Sun, 21 Apr 2024 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713697269;
	bh=m7F13VISs2G88UsWdBqx5Uhj925SYkP6NpxnTL7qMOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Afx5ZWMzNgRe/cwYIK/sOOwixf7yAJHhVRss/IyaBL0cFrSH5rL9Q2kF7iHPdiEEX
	 HpeGUKLHyRnSAbNkP2FtNQg5vdT/cAumkETJv8zmUZ1L9F2Da7Y6im/F5tRWIqujpL
	 WAwDdM5M53S18H/kGWmc8BIAvtrYMWvOb8Aci5wMuZY4oYMbbF1P7WbBhBTvs0fRVQ
	 AvKX8+5m79HBKBVdWj2oPi1m9GgXZWr7zly+MXfXmheggv4EBXhgEpDK27NzLCVAWo
	 i5WwqQF+hCYA3pq3QiNeo+d0jdfOA5L57A+v8JtaS8eAvkyQxnbgOJelr93WgCAu0F
	 hvyhKlz9350LA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org, 
 Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <7197cb58a7d9e78399008f25036205ceab07fbd5.1713268818.git.leon@kernel.org>
References: <7197cb58a7d9e78399008f25036205ceab07fbd5.1713268818.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v2] IB/core: Implement a limit on UMAD
 receive List
Message-Id: <171369726479.2174091.9538632193898547877.b4-ty@kernel.org>
Date: Sun, 21 Apr 2024 14:01:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 16 Apr 2024 15:01:44 +0300, Leon Romanovsky wrote:
> The existing behavior of ib_umad, which maintains received MAD
> packets in an unbounded list, poses a risk of uncontrolled growth.
> As user-space applications extract packets from this list, the rate
> of extraction may not match the rate of incoming packets, leading
> to potential list overflow.
> 
> To address this, we introduce a limit to the size of the list. After
> considering typical scenarios, such as OpenSM processing, which can
> handle approximately 100k packets per second, and the 1-second retry
> timeout for most packets, we set the list size limit to 200k. Packets
> received beyond this limit are dropped, assuming they are likely timed
> out by the time they are handled by user-space.
> 
> [...]

Applied, thanks!

[1/1] IB/core: Implement a limit on UMAD receive List
      https://git.kernel.org/rdma/rdma/c/ca0b44e20a6f30

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


