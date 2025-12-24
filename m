Return-Path: <linux-rdma+bounces-15209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AE2CDBC81
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C8E2300D4F2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152A2DAFBD;
	Wed, 24 Dec 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feHAF658"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7322A4FC;
	Wed, 24 Dec 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568273; cv=none; b=RyDJwht96JU1Dcly69J6efivc7OEXG/ZSNDM2ZNZDoT/yW9x+A/CcfK+uTPz1d+DXaObpOvstOxPvTxAdwDk/wGhGh2B06Wos8juUg8wMtc8l+lOmlWyMaTv7JrjjWa2+lzvFgwILjcDqkquSH4xXWUDLBpCBhcsXlkWUn0jD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568273; c=relaxed/simple;
	bh=NYVBAiDMGDYYzlWYqicp1JkTyIMfOF69KF3MZR5zP6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dtt0mqqgIr2vL8QzjgWuodRAFGAgvtBnu59xtrbq01Jod/dRczsw4+pfzgPjF0SonWzRU+u+E7OB26jiKyA4y7j+vAlWsbm4TtHia4Ojwt9WbyqmsL3CGJZyvN4VjedfmvgRwxhqbwKgS86+tWTb6JSgpy9zU23XQ0xgco6p/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feHAF658; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60190C4CEFB;
	Wed, 24 Dec 2025 09:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766568271;
	bh=NYVBAiDMGDYYzlWYqicp1JkTyIMfOF69KF3MZR5zP6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=feHAF658VG2pdAOoIFYdEFr/rpOwHqF3OkOQalxyMbJ/F9UAoh4fw0jChe94NBR8c
	 L7GVxs2x+u/MQJbHq7/Vi3pbRGPjgs44C652GUmnTJwAa8EvaulatrXnZgaoiRtPyd
	 loqh93sqcBwUS6gTrlwbk6kcf9WOOjACashe+P3JJgvG5sN1X/Bu8urg2oALd2sBuV
	 dmDTweCMiMmw6RZH09Uq1KQXQaHPviTFsxvR0eLl9xGIs6jhc6aU8uB6qaGR7QJ8S+
	 on+MXjmvR87pX/NjDcygRJ1K/TbrDgj3Fq3NnuNgcLjau/B+4IEbG/IrM9kZJzWM94
	 q7TXKeiEHHENA==
From: Leon Romanovsky <leon@kernel.org>
To: haris.iqbal@ionos.com, jinpu.wang@ionos.com, 
 Honggang LI <honggangli@163.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251224023819.138846-1-honggangli@163.com>
References: <20251224023819.138846-1-honggangli@163.com>
Subject: Re: [PATCH v2] RDMA/rtrs: server: remove dead code
Message-Id: <176656826889.278710.253172226684493807.b4-ty@kernel.org>
Date: Wed, 24 Dec 2025 04:24:28 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 24 Dec 2025 10:38:19 +0800, Honggang LI wrote:
> As rkey had been initialized to zero, the WARN_ON_ONCE should never been
> triggered. Remove it.
> 
> v2 -> v1:
> Remove 'rkey' as Leon Romanovsky suggested.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: server: remove dead code
      https://git.kernel.org/rdma/rdma/c/a3572bdc3a028c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


