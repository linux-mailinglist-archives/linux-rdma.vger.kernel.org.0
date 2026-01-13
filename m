Return-Path: <linux-rdma+bounces-15508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF4AD193C2
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FE273096707
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59F38FEF9;
	Tue, 13 Jan 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnVUTaBP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD0255F5E
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312373; cv=none; b=dmrpGl9DYyk/zTmWtpDbl04Y2y+qhk+3vUYqOj7a7WmnYicRkXk2epYR9zQ8rI/pukrwC9Z0HmfuRGRD83fgEKOHipeXCxwnKHHOy7JOFFRQDJhXcjy6k3dirI6+hVSAinUrdYMxl4fW27+M4JNv8pnpMa24p0cIL5bjFH9eSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312373; c=relaxed/simple;
	bh=mPpdb3hfz/pbMPknLcbv1g0oL1d/wfKXFylYRGHUGPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jcN4I2PKMECSJDRZBgMODPEuBxtPf8qfMimYuqqbWKak+YRrxstdaOcQxQrGKVhw3rEWFjv5WH3byTIF8Zfxka2N1v6psyrD0vHLeBumlj5coE7tBXPK4t6wTBEcoJhEjTRR8Y3qMx1IlAyRpk19L0YnBbtqKywUBQCDUnn7LPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnVUTaBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74FAC116C6;
	Tue, 13 Jan 2026 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312373;
	bh=mPpdb3hfz/pbMPknLcbv1g0oL1d/wfKXFylYRGHUGPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QnVUTaBP3WFsT2qszDMZoWQRAD3jN4HAk/MyeTx4GiYJwX3e9mLFvC9CCql5MsFdn
	 dile3OhCb7R/upAtBhzwTnoyNQI38WQi2jukDR56U8mIERveW4tHDzAkNInyuHK1GN
	 nrz5rZDwhgXkYGqn04ZlJcbf+Ausaw3e2rpDRIXYkcktw0s5Q0/ct4+Vf312PJjkxW
	 Kl+B6DG7OSqyC4SyLy9uUoqc6Zenn33qL5t5l1JZFLB37dyRnJbq46P1r724wymwXM
	 OGdqZ0QPCNPSKmtBLO11FvDAduPtAbBqGtagxFj/wz59+p0n9gs3oEIDxejmhJchCx
	 Dr9O6orpCxxww==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20260108113032.856306-1-huangjunxian6@hisilicon.com>
References: <20260108113032.856306-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Support drain SQ and RQ
Message-Id: <176831237038.425757.1087660193485923896.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 08:52:50 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 08 Jan 2026 19:30:32 +0800, Junxian Huang wrote:
> Some ULPs, e.g. rpcrdma, rely on drain_qp() to ensure all outstanding
> requests are completed before releasing related memory. If drain_qp()
> fails, ULPs may release memory directly, and in-flight WRs may later be
> flushed after the memory is freed, potentially leading to UAF.
> 
> drain_qp() failures can happen when HW enters an error state or is
> reset. Add support to drain SQ and RQ in such cases by posting a
> fake WR during reset, so the driver can process all remaining WRs in
> sequence and generate corresponding completions.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Support drain SQ and RQ
      https://git.kernel.org/rdma/rdma/c/cfa74ad31baad3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


