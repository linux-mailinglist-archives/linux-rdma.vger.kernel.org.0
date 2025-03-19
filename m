Return-Path: <linux-rdma+bounces-8815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9150BA68723
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9765189560E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9A2512F5;
	Wed, 19 Mar 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWPqar6O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57167250C0E
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373808; cv=none; b=VmUtZB0N06WBaUNSNDBEUF6jomqSliI178rvpUUNwJfq0GfP8d2qy21tePhukfMMaKlxNPwiDpgAhnGxuCIB5N+kyPmXwjYGLGUV8I3yu7jSDntFQmXsu1HK5zSb+dx0PsB4GEoWfn4Pb5eYGwWBJ2pwhLKPgO4vafL2XCNszlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373808; c=relaxed/simple;
	bh=QO9nu1g/JOGiUxSFSpI2XDcYefkb8VmJLGotqUgHOlY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tuFeTu6GqEtPjMT62zaY92hbiK7fTSWPg6x9dK2BH7uZ2JA3CXJW07gojo/8Q+bPcIuf/3Hh6q1fv1k47kH4ejYtkVBdnP1BvGE+xsgHMtEkP/4bDej+sXCOik+Um9Cm3sUpWKfTh+vmiTLM4PCIxliXxJtJ+wKnQG68bakbNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWPqar6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A50EC4CEE9;
	Wed, 19 Mar 2025 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373808;
	bh=QO9nu1g/JOGiUxSFSpI2XDcYefkb8VmJLGotqUgHOlY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uWPqar6O7MjF9u+YwdEY+tK7Bmd7L83/R0jblXawBHZRjTx7XK4t9gvDDnDNwrCyU
	 S5GYrneJyfUAidXeiWQHVCSU1/MMb5lnuZJPWVW2/SRDGM+yd6a6xScl5j0D55UJrI
	 3erHubLwzxusaMFI+lI7lO242ZXce0Ij8PU98Ltj3wA9kwJ/iu42/bj3yLUQWXrvKS
	 fEERXglJPk3rZVoz4C8Ebi+9VsxnOt78F8utCJaJai63XMFBV/+qiuLqYzqSxp8jJe
	 sFd9VNx4253GMij64OLLf4XQGjLh8sS5B56mNSyex6eNnM9eeAMYpH6wTWlmO/1SOW
	 utmpRgWJOrsdA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <c4984ba3c3a98a5711a558bccefcad789587ecf1.1741875592.git.leon@kernel.org>
References: <c4984ba3c3a98a5711a558bccefcad789587ecf1.1741875592.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] IB/mad: Check available slots before posting
 receive WRs
Message-Id: <174237380384.150650.478478064602406461.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 04:43:23 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811


On Thu, 13 Mar 2025 16:20:17 +0200, Leon Romanovsky wrote:
> The ib_post_receive_mads() function handles posting receive work
> requests (WRs) to MAD QPs and is called in two cases:
> 1) When a MAD port is opened.
> 2) When a receive WQE is consumed upon receiving a new MAD.
> 
> Whereas, if MADs arrive during the port open phase, a race condition
> might cause an extra WR to be posted, exceeding the QP’s capacity.
> This leads to failures such as:
> infiniband mlx5_0: ib_post_recv failed: -12
> infiniband mlx5_0: Couldn't post receive WRs
> infiniband mlx5_0: Couldn't start port
> infiniband mlx5_0: Couldn't open port 1
> 
> [...]

Applied, thanks!

[1/1] IB/mad: Check available slots before posting receive WRs
      https://git.kernel.org/rdma/rdma/c/37826f0a8c2f6b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


