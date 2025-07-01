Return-Path: <linux-rdma+bounces-11791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5DAEF326
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 11:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802C43AFAAE
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142BB26B948;
	Tue,  1 Jul 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAcmSlU7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6961248F42
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361760; cv=none; b=ZKg/dFsq5T4QZx7YESPVMdFPhLxJfUaAuiUpXwKiXKNEEnj0NVfZheew/xXGWJjtZ3RMd69QruBh8JPJNbJzyB8Pql1k36JSkyJvfTr4NZEQrCIyL20EYiIXGIs/AXmBbKDAVIrRDzc3Zy2RSeFngT8Qzk6y4AJaPfPAFhiGlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361760; c=relaxed/simple;
	bh=Q6hbfopP+aJWpNhB26UbaMJyuEEeoXFNSDqROaiuURw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ssEhXoyY4jnXXS1Lmw/ojQ/5FHlU0CeAlzVZVTxXZksIzgbxiOMIh04IhvJp9xOzVGfOnZChlgiNoTHpNG/aWy9RtNt+TCMbUugaoPnjPdiiT//UhjJ9T/KyGJIxbdzdcYwhazAtB8ywSP6wHAO/eVfcYmdL6xbKWwRaLfZtdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAcmSlU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5D7C4CEEF;
	Tue,  1 Jul 2025 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751361760;
	bh=Q6hbfopP+aJWpNhB26UbaMJyuEEeoXFNSDqROaiuURw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PAcmSlU7bT4byd1keJyNqRHH3bWtESWIzIbADBV7hI4vI5XmLIrxlpIhMVRZlAgHN
	 BwjiXmsm8kG3nMixAZwL1FD5+KaAkb4BEjD3rooPehr32YjOWMKZLZpI00/CxNKWle
	 iqlgcc8lDqVC4BXNr3n2lOe+2x+U4ieJVlYhu8QF3IKeLp7cVPfV8LJOEATcyNJfBf
	 cTwBhq2Ex6Wt10+eUYPklHFPVCISvohRpxoY+NfWHV3p+6ITO8S3zLWwW1UZxd3gNT
	 fxR8r7Et3DaUkS2rBcGUPSFNbK6cDoolcUxgqJ8xHgHQUbTX7wLAWZSVag0Ay6R0bQ
	 iuoMfwS5TwEyQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, 
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>
In-Reply-To: <cover.1750963874.git.leon@kernel.org>
References: <cover.1750963874.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v2 0/9] Check CAP_NET_RAW in right namespace
Message-Id: <175136175703.403328.5352219442772888831.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 05:22:37 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 26 Jun 2025 21:58:03 +0300, Leon Romanovsky wrote:
> Changelog:
> v2:
>  * Resend right series
>  * Split "RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create"
>  * to three small patches. Maybe I should squash them when I'll  apply.
> v1: https://lore.kernel.org/all/cover.1750938869.git.leon@kernel.org
>  * Moved QP checks to be earlier.
> v0: https://lore.kernel.org/all/cover.1750148509.git.leon@kernel.org
> 
> [...]

Applied, thanks!

[1/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
      https://git.kernel.org/rdma/rdma/c/f458ccd2aa2c5a
[2/9] RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
      https://git.kernel.org/rdma/rdma/c/95a89ec304c38f
[3/9] RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
      https://git.kernel.org/rdma/rdma/c/14957e8125e767
[4/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
      https://git.kernel.org/rdma/rdma/c/0498c2d9984ed2
[5/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
      https://git.kernel.org/rdma/rdma/c/c961a341c2c2c2
[6/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
      https://git.kernel.org/rdma/rdma/c/c961a341c2c2c2
[7/9] RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
      https://git.kernel.org/rdma/rdma/c/b5911befe2f910
[8/9] RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify
      https://git.kernel.org/rdma/rdma/c/282742fd826ba5
[9/9] RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA counters
      https://git.kernel.org/rdma/rdma/c/d7d403f74f236d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


