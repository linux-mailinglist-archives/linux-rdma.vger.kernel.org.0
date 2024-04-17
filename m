Return-Path: <linux-rdma+bounces-1967-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4458A85D7
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 16:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7369A2830F0
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517711411E8;
	Wed, 17 Apr 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pa2QQAKm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A3B12FF9E;
	Wed, 17 Apr 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363668; cv=none; b=BZ/Pu4zfK020zGjkAGqW2R0ciq42FZfeac5GUI3XhJaD4z/c0DoC1ZJph5wrgl1aJMz6x6kRu+gftJGmRB1YnvpBqdGbxezF2lVqSyZb5Q5gk3EP75UJM6Tc4hFNMvKcd8q+quqL3MvsL07Y1yPNcccQfbMCEuX2X9eY2iUOXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363668; c=relaxed/simple;
	bh=ZJXSkz1rO9WT5zRGJQNKkyWtPJBwT6JgkOLkwq4bR7k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eq/E4GnDMXBqJsGt+NyvGslxWZpJJN+o6B5Nzp+S1RZCpOVxq2bCg7rWHWMr0mWYHtj4+4of5n2lqMW2romC2GLKmRl86b9pApoAFpn0SECdOx3XCR5nMGywLJC2SV/Ca+Y28zmYosf+KyvUnwVEa4A8x7dJNTWNftI5sbQluEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pa2QQAKm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9543920FD4BB;
	Wed, 17 Apr 2024 07:21:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9543920FD4BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713363666;
	bh=CYFttZcwUiWm32MEP5rpm4pRz0cJ6RONEbmfW0uYpa4=;
	h=From:To:Cc:Subject:Date:From;
	b=pa2QQAKmac4jTEl3Hs7vcisRAFA4Y9NHLzfX6UAzWebaFUxEFyd6cK1IRXWKf+3sq
	 COjOQ994ZBdw6oeJMhqlgcq8bA0Mdx6Y2ouU5EJov/NwpYSc+Lon4PxhJDXorUSNt1
	 IIXz/nFYksu83DIXeUVEVO0ef3uztlRkB+6YGUGE=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/2] RDMA/mana_ib: Enable DMA-mapped memory regions
Date: Wed, 17 Apr 2024 07:20:57 -0700
Message-Id: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series enables creation of DMA-mapped memory regions.
It allows GPA creation in kernel-level PDs and implements get_dma_mr().
Note, mana_ib_get_dma_mr was already declared, but not implemented.

Konstantin Taranov (2):
  RDMA/mana_ib: Allow registration of DMA-mapped memory in PDs
  RDMA/mana_ib: Implement get_dma_mr

 drivers/infiniband/hw/mana/device.c |  1 +
 drivers/infiniband/hw/mana/main.c   |  3 +++
 drivers/infiniband/hw/mana/mr.c     | 36 +++++++++++++++++++++++++++++
 include/net/mana/gdma.h             |  6 +++++
 4 files changed, 46 insertions(+)


base-commit: dfcdb38b21e4fb92a49acdbdf6afa82c07c8eba0
-- 
2.43.0


