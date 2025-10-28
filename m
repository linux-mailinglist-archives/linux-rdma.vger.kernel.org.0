Return-Path: <linux-rdma+bounces-14094-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777BC136E4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 09:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AF81A23C89
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9832D73A5;
	Tue, 28 Oct 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh2f6spK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9752D739C
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638678; cv=none; b=plVGr9jlnPamCChDxdoN6W4iyronbBESkTiGdMGOL7jLAZLPpcueVSkvIiTlBgU9kbqb0sd3zgnobIhy5Q+X9NA6pIQPd8FWj380cSaDUIireQxXUnNSLuwMz0FIIP1zPHxroupDy+cGNyjlNH/LAQv4ZbMZWzlgxWl77aYLUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638678; c=relaxed/simple;
	bh=JUa7dVJFZ5bY/nwLhs1SJ70HhMlHGtomTEH36ZbWAz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qyzhd7l9HbYwiYPwtMU+uA9FJP+vcfSBd6OsTmrXGcP+xbXmH2ET4bi3+4aCbvkFm/qIeMgsIT9wGAuprfwY4992ZbU4oSMNespduGFUsaqnXd9WcngoyaxppqzdmtNeOPiRCyvtGCWJp3Mb3eWfMS8VcwDAnh7up1O057uxPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh2f6spK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA609C116B1;
	Tue, 28 Oct 2025 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761638678;
	bh=JUa7dVJFZ5bY/nwLhs1SJ70HhMlHGtomTEH36ZbWAz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bh2f6spKyD8CjB8sNljKuN+6PCrsnPkc9hnwEahet+bSpMWKxTwI3Lfa3JruJrnpg
	 Avnkk4j4031wYjz2rYdUADL0/QUyTFlp2PTCgwWKU4fwG+ZrzRmeG2olbHEjjHGby/
	 3MgXjGAXoITX+QFGcL4/gPTLqaHBuJSJDPR8AhoaSckLTUJJn/NVWNqdSNVMDBpvas
	 tNQO+VaWTnTT/sWRkL38HXgQZ8fPAZu//G7T/ujii0td/bc9KF6g4mw45AfTKTk1Jn
	 R2o5wIQuKGvzM7j2DPcwcZe6CUgK0kAYKXP6/XQjHusR98w20jtjrToKd3CknEvGOd
	 tKIS8MbVGdvmQ==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Liu Yi <asatsuyu.liu@gmail.com>
In-Reply-To: <20251027215203.1321-1-yanjun.zhu@linux.dev>
References: <20251027215203.1321-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH RDMA V2 1/1] RDMA/rxe: Fix null deref on srq->rq.queue
 after resize failure
Message-Id: <176163867488.528671.1864063074227149797.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 04:04:34 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Mon, 27 Oct 2025 14:52:03 -0700, Zhu Yanjun wrote:
> A NULL pointer dereference can occur in rxe_srq_chk_attr() when
> ibv_modify_srq() is invoked twice in succession under certain error
> conditions. The first call may fail in rxe_queue_resize(), which leads
> rxe_srq_from_attr() to set srq->rq.queue = NULL. The second call then
> triggers a crash (null deref) when accessing
> srq->rq.queue->buf->index_mask.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix null deref on srq->rq.queue after resize failure
      https://git.kernel.org/rdma/rdma/c/503a5e4690ae14

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


