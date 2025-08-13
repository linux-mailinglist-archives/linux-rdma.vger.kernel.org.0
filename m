Return-Path: <linux-rdma+bounces-12698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10035B24772
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B703417EB3B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CBD2F6560;
	Wed, 13 Aug 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMWvG8Gr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0E2F290A
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081282; cv=none; b=hi5i3DQqsMsS4Xq1sI1FUzTUA5t7uMamZ65etyAPxGhwbwCWdxd/p0qAsyzqm2BASSHTnNrOnAM5r1jsh9tmFA5R0nD92o4p2pfE8KpQzyF5kHz2r69+g5ARyM7iZdGcnrvZJzJCXyTfjqc+W3Amtw6dK0PGtvBHYfNg4VeP430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081282; c=relaxed/simple;
	bh=G5946Xb33NNshiWp/k3pFu6/sp6UjdKDwUaAcs+zgaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cs2tV2H9hOs0Yvqk9qF2FNM/U2vjIvb78VeZ31A4G6O2GeTMO8m18lrRiuNeHyTuc51RQ+FuME22PjJTQ1EpDIlwi8Nog8rBnIb46O3EZZN8wIrR7hDinXBZMOwdv1D9gGVlfdRx5YnfGfP1yMwVl5luTJdwQiarBL4C8eSkRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMWvG8Gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07391C4CEEB;
	Wed, 13 Aug 2025 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081282;
	bh=G5946Xb33NNshiWp/k3pFu6/sp6UjdKDwUaAcs+zgaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WMWvG8GrtqhWlndKiVCpf/+uavtBR7IAARSCoqMJaIuAJZdkgpPOvA5Jq8XSDDTV6
	 EL3wtd/F8DB8Rch57EGC91J7haCgEXHbQQgGaZ222mdcpP0JsDZWLaBh6iqnVdLGu8
	 yProgxNCHOHs4OV+fb9t/uHPPciUnysC+z7Yf4LDaluyQ4xE6kb/tE6gmjMt7M3gXW
	 /6kHZjb4AA7Dgs/n7HriksbUMC9XMb9wLwnlwtmU3h9khpYUDPTJqvZNE5K6d8gqim
	 c5tJCeevva/EYI6WtCiBMZPoJeGos4F48+Lz9OG+7VZ9fc5HmH8ShJdOcR0J2qpgJI
	 yRAyQn1pyR6WA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250726075345.846957-1-huangjunxian6@hisilicon.com>
References: <20250726075345.846957-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix querying wrong SCC context for
 DIP algorithm
Message-Id: <175508127906.199154.13480195826653546354.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 06:34:39 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 26 Jul 2025 15:53:45 +0800, Junxian Huang wrote:
> When using DIP algorithm, all QPs establishing connections with
> the same destination IP share the same SCC, which is indexed by
> dip_idx, but dip_idx isn't necessarily equal to qpn. Therefore,
> dip_idx should be used to query SCC context instead of qpn.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Fix querying wrong SCC context for DIP algorithm
      https://git.kernel.org/rdma/rdma/c/085a1b42e52750

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


