Return-Path: <linux-rdma+bounces-1127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB78D866A9E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 08:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ED21F231F9
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA43F1BDF4;
	Mon, 26 Feb 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B9yQ65D8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A531BDCB;
	Mon, 26 Feb 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932358; cv=none; b=dkoNxVyLZm+MAxDyZAO/h2JICFg51i4BbKfMnPNYeY8kLxweaXWYRVLI3ZGUdT33BCLF1NDBhR/V0vh+J7D2IJTQmjvw4EqLR1DzL1znHl8kGLxRfOJ7tjfF3ANdvMNYLE6bHiSgCmvVRjyrhsEOWTQ+rDDBXgAEy0/Q/8u0K7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932358; c=relaxed/simple;
	bh=j/WvZZmHqEGXLDJR+LSDPYr4O53m2FFIi6ta1CkoiFM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=A8v1N6oZ8p2VHdNyek5X/nuKAvuLXnYaMOlwiXo+UUowJwvMUoDUcszedS98nTjOxfO+l+S8CX+niJcNKOz+36KlouyKiQlp+nN4jHPpy0ZqoNUoQJ0Wj2gs5d4s1bFNJL/Lj8zVxagY3WjZbblmnFjk3J5HCnVYBsOZyV20dQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B9yQ65D8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32D6820B74C0;
	Sun, 25 Feb 2024 23:25:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32D6820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708932351;
	bh=SxyinpW0yk9+bqJt1cMFV0DPsJ9Z5M3jgCQINCRy5/0=;
	h=From:To:Cc:Subject:Date:From;
	b=B9yQ65D8rPvbFvIOgbpI1kzv/ckuSTgQLD/Qy3C2tHenZhdN+0CZYb/5fg6nKv/iV
	 hPKayd8OhoWhp2cvOW8UKsfV5g5OpwYlWfd5sb5oFckn74RUKGCKDaMAWotuHQKd4P
	 ZvqGn+zgZNaOJmG9foCt8UNPTDuWk2+476/F2CBI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 0/2] RDMA/mana_ib: Improve dma region creation
Date: Sun, 25 Feb 2024 23:25:37 -0800
Message-Id: <1708932339-27914-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series fixes an incorrect offset calculation for dma
regions and adds new functions to create dma regions:
1)  with iova
2)  without iova but with zero dma offset

Konstantin Taranov (2):
  RDMA/mana_ib: Fix bug in creation of dma regions
  RDMA/mana_ib: Use virtual address in dma regions for MRs

 drivers/infiniband/hw/mana/cq.c      |  4 +--
 drivers/infiniband/hw/mana/main.c    | 42 +++++++++++++++++++++-------
 drivers/infiniband/hw/mana/mana_ib.h |  7 +++--
 drivers/infiniband/hw/mana/mr.c      |  4 +--
 drivers/infiniband/hw/mana/qp.c      |  6 ++--
 drivers/infiniband/hw/mana/wq.c      |  4 +--
 6 files changed, 46 insertions(+), 21 deletions(-)


base-commit: 14b526f55ba5916856126f9793309fd6de5c5e7e
-- 
2.43.0


