Return-Path: <linux-rdma+bounces-6653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEEF9F7B07
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 13:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258B97A2BAE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B64221D8E;
	Thu, 19 Dec 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIyvd9+e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F8218EB4;
	Thu, 19 Dec 2024 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610621; cv=none; b=kqlo7H9JVwFbKimhVyk/dnYjMcQfiq4z/P3PgZCdaMRtGkrX/9G2kOIqEaA6PO7wWw640QnGpBDsR9lLGFZ9Q/cxKXpL+Pe7WaLdP9KfLDSivMnthWwMm6M96g/Wi5vfCfCFPlwk+ZKUrljonbRboG16KJjQ4pf7RqCLK499eB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610621; c=relaxed/simple;
	bh=Xt6l9hCFcAZOu0vZVVc2LxSIJxwrGuC9d+R6ow64clI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wrfi4xEtCcjxS5KZSpYyl0Wo+c/KtVXlLmfsbH8kZO70THGeqWK9DmeNEHK9l7p5Xid1kyeCbuPRkM5sWKJYeCUrCAI89zxCrIWG0vJWlkIhOs/HCrxBRzRrCfCEiI3ThUbV/vXWNeECzLx7OY6TO98aol1RoFV7YTKu4w30yHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIyvd9+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB85C4CECE;
	Thu, 19 Dec 2024 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734610620;
	bh=Xt6l9hCFcAZOu0vZVVc2LxSIJxwrGuC9d+R6ow64clI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iIyvd9+elDXvFAK4YYdJ7QP3FGj2drdlWRLyYGbrRc8pXiF3bq7EcDkx40nJbHDez
	 k6drsBXeS4cpiJbeS5YUihbP/wX4GGYeKUd4Sd6w5NZW0p/68kGLTV6Vw29/kEtAFq
	 l0TYJkU77rIQ3lgc97Nq28hJ/6csl/D4dDZcOGMSFgMtXAW2E18BkYnM4fN61dq1/+
	 Sy5onYF4ZIjpDuMQk1jtyP5pgAmvbs2OPaSIFfePpXj7ONgFfc7TZyiT04UzrSgXZ0
	 URP3iCYfDrzE/1Iz95fDVRfVJ639WracwLqmAmXp5vz2u9Z22nrkny4Cb8nJt/h+Wp
	 KcUORm7pmEPYg==
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>, 
 Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241219043939.10344-1-advaitdhamorikar@gmail.com>
References: <20241219043939.10344-1-advaitdhamorikar@gmail.com>
Subject: Re: [PATCH-next] RDMA/erdma: Fix opcode conditional check
Message-Id: <173461061730.349703.2739528249042727020.b4-ty@kernel.org>
Date: Thu, 19 Dec 2024 07:16:57 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 19 Dec 2024 10:09:39 +0530, Advait Dhamorikar wrote:
> Fix conditional if else check by checking with wr->opcode.
> The indicated dead code may have performed some action; that
> action will never occur as op is pre-assigned a different value.
> 
> 

Applied, thanks!

[1/1] RDMA/erdma: Fix opcode conditional check
      https://git.kernel.org/rdma/rdma/c/c57c76498a895a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


