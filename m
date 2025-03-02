Return-Path: <linux-rdma+bounces-8236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF5FA4B198
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF616BDD2
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD31E32A3;
	Sun,  2 Mar 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1lhB1CZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8381DF733
	for <linux-rdma@vger.kernel.org>; Sun,  2 Mar 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919161; cv=none; b=IsdXcmyf++ASNE4cvoxdTM31fYmtFLAGDEphkRRA2XmViRIGgkEtzLSeti//3IIbcB0BkiX5T5a0GFxi9SFQNa9GD2aoPyIniI6OLNZPnmfFenH2hUBzBhRgvR+ywUDARwZ+EQ1tipLdfbuQ5BiY8oU6L0tfRS0cTsrdLFQJ7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919161; c=relaxed/simple;
	bh=/aCMbTY1I+5FUXSs/ZYooFxiFlZFKhsyY/TkVN1/CRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/ah+bW0NzVoDOZjZtGum2zu2FSPxLTvtbJIWD2Z/PY8kZ9WGzpHC/5iEdaxWm5JLnfvdfwwuyUDrybzbhNV/7iqCeq/Rafw1W14EHSUpoUXKO6FNMZEpaqbOlWDOQqhCglet5DeLiqBxJSaWub6klV1O2SK9kA+0FOc5shwSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1lhB1CZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D2AC4CEE7;
	Sun,  2 Mar 2025 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740919160;
	bh=/aCMbTY1I+5FUXSs/ZYooFxiFlZFKhsyY/TkVN1/CRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1lhB1CZ5BKjh1In2BsEscpuk7H4unDaEN1EE1TkN5dntpE6Ulv78+tLkPgnJuG7B
	 ItHf/aA791OBYk94nn7JSYqnzj07DRkbMcoLsel7FnupkFau/lhrylVGBRAN9MeQNb
	 MxZHbdn91PlERibCkJMGU7a9Idpjv+awJgCZbues61I5v1An1aXqz1+Q5bwh//lklK
	 UM397lpXCmiP/dI/qGtMy9m2Z4taBxQVeb4pXozDQf5mmeEcz7mVmkG0phwByDiqE3
	 F2bXbm+gwNhSZn5cEjMmrmPQDmg8ZpDVzgKormTrGSLThIUkY0ngyT7mVJJs5KMWdh
	 8wC01TdnnQqtQ==
Date: Sun, 2 Mar 2025 14:39:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-upstream 1/1] RDMA/rxe: Replace netdev dev addr with
 raw_gid
Message-ID: <20250302123915.GE1539246@unreal>
References: <20250301193351.901749-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301193351.901749-1-yanjun.zhu@linux.dev>

On Sat, Mar 01, 2025 at 08:33:51PM +0100, Zhu Yanjun wrote:
> Because TUN device does not have dev_addr, but a gid in rdma is needed,
> as such, a raw_gid is generated to act as the gid. The similar commit
> also exists in SIW. This commit learns from the similar commit
> bad5b6e34ffb ("RDMA/siw: Fabricate a GID on tun and loopback devices")
> in SIW.
> 
> Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 20 ++++----------------
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  4 +++-
>  3 files changed, 8 insertions(+), 18 deletions(-)

This patch doesn't apply. It should be based on rdma-rc or rdma-next.

Thanks

