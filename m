Return-Path: <linux-rdma+bounces-7484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5D9A2A3E5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 10:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503F3188798E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93EC225A38;
	Thu,  6 Feb 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF01gPs0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA915B10D;
	Thu,  6 Feb 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833128; cv=none; b=bwQjZ6hVnyK1m369jezj6/Dh/VUKy5ON3Gn5cZWAjYc2xx9cDvKSA01K580dTM6pdH2H77Qzb8yPp5NDzH6my2558oY+Ib47SIxG+wXz0qiFARfmBvj8V893IZX0YjTdFGGVvekqbJmihsqVSP7ehFKS6YsD60486uYcpCCpVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833128; c=relaxed/simple;
	bh=HZ2BzLNJ9wGoyMfAgKKZJY98EFtz7L2cUvH+QTGuEVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WMj/iOE5k+NENqX/URVxWo9eTL5jZwUsX6gESh6wK8CBGQY6YG2yrKstM/hB1Jk6iuTWeN+jUmf+Oknzbx6ij6uQf9GHqpUa1MzW1dmgwVsCiZx5ceeYwRSArZygYAgEdlhZz7djt1F3ED9X5cpxn1fsh65cjFOGSCwYjnfw8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF01gPs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE243C4CEDD;
	Thu,  6 Feb 2025 09:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738833128;
	bh=HZ2BzLNJ9wGoyMfAgKKZJY98EFtz7L2cUvH+QTGuEVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QF01gPs0eleVb2WB9ZNncVGlGInP4Ie3xgm69dhuKjX3GXHwS+WyvKr+WbMkVcY6K
	 RHPjL0e75bT8A1dKeg8jqLYMYdO+FCZzgHpEiWTb1luQloQnOSyhs25HbEEPyEeHM0
	 ezPo9hb5VQv0Sgnz7pOyVnA5bWjOiNAzURXRXXmx008LN/VE1PtC2yrFrzYUnHdSZQ
	 QLi3uAO4iB0iNjE5vRBl2TxtiSG+iMf19Pz1f/xzyWeVbj5EN65G4vuGJb3bk3JJjz
	 kcCRGN1wvNMYVyAIkS93WyR6k1akwYORRfcN7+rcF2Wh8IUkOi5uGXcjfqXr43xthP
	 9Lxxi7rTAmY6g==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1738751527-15517-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1738751527-15517-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Add port statistics
 support
Message-Id: <173883312475.839954.15938395488865633566.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 04:12:04 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 05 Feb 2025 02:32:07 -0800, Konstantin Taranov wrote:
> Implement alloc_hw_port_stats and get_hw_stats APIs to support querying
> MANA VF port level statistics from rdma stat tool.
> 
> Example output from rdma stat tool:
> 
> $rdma statistic show link mana_0/1 -p
> link mana_0/1
>     requester_timeout 45
>     requester_oos_nak 0
>     requester_rnr_nak 0
>     responder_rnr_nak 0
>     responder_oos 0
>     responder_dup_request 0
>     requester_implicit_nak 0
>     requester_readresp_psn_mismatch 0
>     nak_inv_req 0
>     nak_access_error 0
>     nak_opp_error 0
>     nak_inv_read 0
>     responder_local_len_error 0
>     requestor_local_prot_error 0
>     responder_rem_access_error 0
>     responder_local_qp_error 0
>     responder_malformed_wqe 0
>     general_hw_error 6
>     requester_rnr_nak_retries_exceeded 0
>     requester_retries_exceeded 5
>     total_fatal_error 6
>     received_cnps 0
>     num_qps_congested 0
>     rate_inc_events 0
>     num_qps_recovered 0
>     current_rate 100000
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: Add port statistics support
      https://git.kernel.org/rdma/rdma/c/79bccd746132af

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


