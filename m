Return-Path: <linux-rdma+bounces-15678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB678D39815
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFF0B3009544
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F467224B14;
	Sun, 18 Jan 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X465xldk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FB1C84C0;
	Sun, 18 Jan 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768754791; cv=none; b=g8appopEvbndNCeOpnt2VlEMg74ReMMakkt06ShcoOuzT5LdT+K4Jq9dQNQ4aqBZIB06z6fFbYqKOtWeCQmCvnsTalwjqlDeK5uNgEGTy+7wL0B9ixPCopPYR9uoBjWrpx2TOpc+y9CBYHTQy8amsNKmEUAQKwS1XC5wb+V/IEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768754791; c=relaxed/simple;
	bh=AqE0Joj3MzXxDoGWqsatzZ9Q25noHpPO4dQuZaI4vic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XCxBZ2d5WK2yWV9mfLK/gsulHTkOU064f6MBQr88XytaG58bcVtKnIJFEtMORkD70kNAPha5yWKiM7LB4bVBIY4mp3BGlGuebnyQYsoJz2pjLytGorYw88HJLGpJvsgfi/DVw4r+yNR9CEPUGqOuOALD+5fBLDnNLhZGB2JCxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X465xldk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A151C116D0;
	Sun, 18 Jan 2026 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768754790;
	bh=AqE0Joj3MzXxDoGWqsatzZ9Q25noHpPO4dQuZaI4vic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X465xldkkBUJvr5WQFZI1c2OP+hkVwJr/7lpzTQ6nVENKIJJqaKCOggk5M1TrqxUH
	 9UT9LtHxmmJxPusN92vdCMxU5zzcbYf/+YNVGpPNVYin6JOJFepbj2nfyrR6h5K7Ac
	 U8SKHJFD+KbTkCB7SWojZFCScnZkpfD1pwTOVB3RhCDl56nCobN+wVeWg8c42l+GPF
	 DRDWwtEhnTGx4tOah8qwpkdZCQOSQySYeiDnCHr1P9tmKzR6ZMyA7UZKEvAwlm4lLU
	 NMtu35MbNBwyqkMrBV2yS9A7LqPCvlAO9kT09RoToMCpXaXvWXLXzaBDNelxjkdJHK
	 GLaawOLhuHcjQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca
In-Reply-To: <20260116032833.2574627-1-lizhijian@fujitsu.com>
References: <20260116032833.2574627-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] RDMA/rxe: Remove unused page_offset member
Message-Id: <176875478780.526071.8487588326607672668.b4-ty@kernel.org>
Date: Sun, 18 Jan 2026 11:46:27 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Fri, 16 Jan 2026 11:28:33 +0800, Li Zhijian wrote:
> In rxe_map_mr_sg(), the `page_offset` member of the `rxe_mr` struct
> was initialized based on `ibmr.iova`, which will be updated inside
> ib_sg_to_pages() later.
> 
> Consequently, the value assigned to `page_offset` was incorrect. However,
> since `page_offset` was never utilized throughout the code, it can be safely
> removed to clean up the codebase and avoid future confusion.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Remove unused page_offset member
      https://git.kernel.org/rdma/rdma/c/d3922f6dad69b3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


