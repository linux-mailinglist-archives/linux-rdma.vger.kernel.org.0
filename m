Return-Path: <linux-rdma+bounces-8775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F497A6710D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 11:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7279A19A03F1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9C3204F7E;
	Tue, 18 Mar 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joRrQ25A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA506169AE6;
	Tue, 18 Mar 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293175; cv=none; b=GbbUV2DN4GNqP+TvojlLMVPI1R6+FiUOqww87CyZNdHxUwiOYX4Mif7Hdkri7gI5z/CsmI0msf0msN4BdbRsIbqXmW1o66GoRsIrheDCKxTMLZJn44XKgfnGbe7qdUrzl49FJgOZkDj9o/cvDE3XtsGusz2Ul3IBjE+odj0KafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293175; c=relaxed/simple;
	bh=njKqtxkqzWwiu8RDMpY+iXZo7MtsjtAiZwHijw43jz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PmrdW5ejouiESwnmNtWgMY9G6N9srfYS0WCuDEwM/A67zbObiO5dXzzGPWIjtcOtTt7afkkyUsYp7Ht6ZT8ML7219aLvK0w5BYF8paqU1ErHqafEdOWUC95QgYq3bjCF4Ha/w/QdS84ctjX3WkgAJcTj05VJZnrw2oHxO5YuC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joRrQ25A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06715C4CEE3;
	Tue, 18 Mar 2025 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742293174;
	bh=njKqtxkqzWwiu8RDMpY+iXZo7MtsjtAiZwHijw43jz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=joRrQ25AXBUoT+dK0sOv5KkcU/6zsikgut+9JGFafbL5AD0jxmTcflN7mpm2IKVag
	 P4rzQjbJ1DPLzKaFGmkKVsxF7Ng5BRZIb/HqgYSsUyz3nqLCgps4dCVfPy9q88GGzP
	 3DB3yE2CzSJzr3x0ZHrDoZLC84rubSuo3wkG2s0zYDA15J/GXigx8GQ173TYtyRL0S
	 XNfRMCVUc1DwrXOsg8dFWpgVPB/zY+Cb04HH8E93ylTVBsO3zKwe6a3ZgjIOEMFdRC
	 v0zDmtOB9Ozpx6xDiH059uwOcu47AC+PjlA54yQ2s4MTNObIZ1hB6S65aP6+4rRsvS
	 alm5HX+4btLBg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
 netdev@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <cover.1741875070.git.leon@kernel.org>
References: <cover.1741875070.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v1 0/6] Add optional-counters binding support
Message-Id: <174229317080.141803.10081314337429150468.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 06:19:30 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 13 Mar 2025 16:18:40 +0200, Leon Romanovsky wrote:
> Changelog:
> v1:
>  * Added new patch which removed dependency of
>    CONFIG_INFINIBAND_USER_ACCESS fron fs.c
> v0: https://lore.kernel.org/linux-rdma/cover.1741097408.git.leonro@nvidia.com/
> 
> --------------------------------------------------------------------------------
> From Patrisious,
> 
> [...]

Applied, thanks!

[1/6] RDMA/mlx5: Add optional counters for RDMA_TX/RX_packets/bytes
      https://git.kernel.org/rdma/rdma/c/d375db42a8effd
[2/6] RDMA/core: Create and destroy rdma_counter using rdma_zalloc_drv_obj()
      https://git.kernel.org/rdma/rdma/c/7e53b31acc7f97
[3/6] RDMA/core: Add support to optional-counters binding configuration
      https://git.kernel.org/rdma/rdma/c/da3711074f5252
[4/6] RDMA/core: Pass port to counter bind/unbind operations
      https://git.kernel.org/rdma/rdma/c/88ae02feda84f0
[5/6] RDMA/mlx5: Compile fs.c regardless of INFINIBAND_USER_ACCESS config
      https://git.kernel.org/rdma/rdma/c/36e0d433672f1e
[6/6] RDMA/mlx5: Support optional-counters binding for QPs
      https://git.kernel.org/rdma/rdma/c/fd24c9ef6c8f12

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


