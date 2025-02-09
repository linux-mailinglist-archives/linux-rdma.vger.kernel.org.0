Return-Path: <linux-rdma+bounces-7589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374CA2DBE7
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 10:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC32C163FC0
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9551509A0;
	Sun,  9 Feb 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1IQlq5m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E83146D53
	for <linux-rdma@vger.kernel.org>; Sun,  9 Feb 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095081; cv=none; b=uR0sArfaA0CcATg8UIw1ZjVwzUGYwgBuZixy3ZUurnG1XgwLpPTeIsL3aRpEbmUzYnN71vU7CAfP6loknuuBfuodb/RiEsbTpl0sBA8kB2XXIHpGFHXy+EYeBsaOSJWkNeXmI7VvPCkX7VfZnHuhVeqRVl+bh7BWVYbm+TK9xLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095081; c=relaxed/simple;
	bh=YMkbRnTU1enxvYCVCwnwwoC1fiCruAx2WsRJ2d+pP1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bOAUagcg9ylP6FY3sITA5Jqelu93W6er+Sj8cDC8+O6dCKsgxVR/P9sMUtu2OLfAVvWZvwRJ5Ur+jklyVbThEKS768WD813iL+qZRP9JrMYrG4jF5nOCVeJJE+HgOKYL9t9/gwJcRdd19aIQfjYVL0KZS2QGall9vgKmWGgdUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1IQlq5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B30C4CEDD;
	Sun,  9 Feb 2025 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095080;
	bh=YMkbRnTU1enxvYCVCwnwwoC1fiCruAx2WsRJ2d+pP1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G1IQlq5mySdzmlycCGEmnwjDZkokQuIhsw0qqE06yAmmCifLaLkGWpJlHdNF968ZS
	 n3kyaK0UTzTHCLXwnBJC1s6qvYjxDgPZWnVwfxI83wJ+xKR1qdvVX0+/GMEPsAkzwu
	 +bCctWQ4sPCS/74+Us0IUnbZdxrG2yd25i9/pQ3OoSFUDD6QcbO7rrhhF+0D4Ihm/O
	 vgivNvEa2zWlcp403cHyZGEGSYWqMHab9BtA6OcZC2tm65AH/9/YMV2pg8qM4v9SXD
	 kAt4+tV7MMuN3xNekGtaJCUErgZy1olMyn8PJwsues4NRA+qOumVt0U44eD7UBxHLe
	 YEzqMdjg3AO6Q==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250208105930.522796-1-huangjunxian6@hisilicon.com>
References: <20250208105930.522796-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix mbox timing out by adding
 retry mechanism
Message-Id: <173909507691.39402.10463277555179910962.b4-ty@kernel.org>
Date: Sun, 09 Feb 2025 04:57:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 08 Feb 2025 18:59:30 +0800, Junxian Huang wrote:
> If a QP is modified to error state and a flush CQE process is triggered,
> the subsequent QP destruction mbox can still be successfully posted but
> will be blocked in HW until the flush CQE process finishes. This causes
> further mbox posting timeouts in driver. The blocking time is related
> to QP depth. Considering an extreme case where SQ depth and RQ depth
> are both 32K, the blocking time can reach about 135ms.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Fix mbox timing out by adding retry mechanism
      https://git.kernel.org/rdma/rdma/c/9747c0c7791d4a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


