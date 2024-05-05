Return-Path: <linux-rdma+bounces-2268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9FB8BC05F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 14:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9581C20F24
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796618E3F;
	Sun,  5 May 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kROg64Tp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BEC2CA2;
	Sun,  5 May 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714912161; cv=none; b=Qw/TI8MBDwZ5khN+U2NwJQtV88a0oJ6TTNPoH8hVlTgBt120G87PTzsusHjnjohJGE0na8ELX0WzJGC17IoNsBjSZ7AHVUiS7M/YHrOYm6YYc/7M/ad2mz82AZ3Do7zSxGynbu4hdGcKyKes2JFwmsNHZak2VisWQHZ3w4PY4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714912161; c=relaxed/simple;
	bh=/irFgxvZZTynsMIK93PerHbkx0cMZamXMzAnFG9Rbbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eD5qSZI7ATZuXzLPjBM+dlSf6tw3sLE7Flrc6CbEIsvdV0Am3a4+RKJN8wM1SJXWaDmGgl7pan2VGggwfjYDTg+0GzySYYsqi3gYaV7le/hUCm7UtK0t6ELd0Iad0+TJxeQ0Z3fLaQVHZmQZTaavvhgqVnGVININe9NLw61bbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kROg64Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84AEC113CC;
	Sun,  5 May 2024 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714912161;
	bh=/irFgxvZZTynsMIK93PerHbkx0cMZamXMzAnFG9Rbbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kROg64TpBS1kSFHzGVvXbWTkij/1MScYJQD7vdvjRivvrKKag9lnO5UAaMf9VaM6/
	 wfiR2mPlI0PWc9wV8Z9hoAW4GVie7RrD3U8fIHX9HtY6GRGg/TNqiDCPXc/Z+RIVEh
	 HNu1ll9BtBU6PCtv+RaLYQ8h7cKx8DCVFyy8ZkI4sQzjBx50BTI2+4lE2RhXnoVda2
	 YITZaIjj7Mnu22lD6+vTxUwk6hK7j2A9VGRJs1fetpjI03Bp8eLhvpI7BHAvfuwdAe
	 mOKpN2BiDagrlrrV9LuTi/AEm0lXZmKnc/cdb0iVEIznPs5Y4Ngh5jMEHGuK+GRk0L
	 s/70EiauwvO6Q==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 0/5] RDMA/mana_ib: Implement RNIC CQs
Message-Id: <171491215713.187140.5431455540383097773.b4-ty@kernel.org>
Date: Sun, 05 May 2024 15:29:17 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 26 Apr 2024 06:12:35 -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series implements creation and destruction of CQs
> which can be used with RC QPs.
> 
> Patches with RC QPs will be sent in the next patch series.
> 
> [...]

Applied, thanks!

[1/5] RDMA/mana_ib: create EQs for RNIC CQs
      https://git.kernel.org/rdma/rdma/c/e73c882f0a0149
[2/5] RDMA/mana_ib: create and destroy RNIC cqs
      https://git.kernel.org/rdma/rdma/c/58434159168529
[3/5] RDMA/mana_ib: introduce a helper to remove cq callbacks
      https://git.kernel.org/rdma/rdma/c/3e41105263d5d7
[4/5] RDMA/mana_ib: boundary check before installing cq callbacks
      https://git.kernel.org/rdma/rdma/c/f79edef79b6a21
[5/5] RDMA/mana_ib: implement uapi for creation of rnic cq
      https://git.kernel.org/rdma/rdma/c/44b607ad4cdf23

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


