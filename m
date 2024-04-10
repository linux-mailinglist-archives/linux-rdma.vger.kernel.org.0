Return-Path: <linux-rdma+bounces-1880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F789EDD2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF831F21E8F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7411552E8;
	Wed, 10 Apr 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lpliEnRO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD73D154BF4;
	Wed, 10 Apr 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738559; cv=none; b=BVNJxlw5Qor0Hgn8pKU6OqbK1Cd4wISXv7bdJ920K/Ea4vh5d9rqJJSXzBj2G8xJQ43nDf0Y+ZByvTJtqIV/gSTgxhiNUpkboxJKPQKtyVZ0VuVT/EZXTNduKjlETfzXLDqvbBqv98H2Z9Zsr2XtqznYHq5Dc9d87wFSnT1mkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738559; c=relaxed/simple;
	bh=Yxhj2QU/d6qrh4o6eH0w4rVq36i5UlU5Fr599bWgSMg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=A7YFkYm37mnCHs6IXZHHV5m4rbOxneKJvdQkngdZwZxDXbh/mrxgn4KC5c8S2dhyYXdmINiYT3l6FQcU/ZsAp2tZymCqVSm9JPHkGRj63PRNnWmLgnFZMkPCNQtbc77W6esyUTOvIeMYVC2OtfzyTs+iIwR7Rw9RocaiHsg57DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lpliEnRO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 67BA120EB0E5;
	Wed, 10 Apr 2024 01:42:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67BA120EB0E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712738557;
	bh=gJL9fOp+AoRunoPP2v7x/w9hunUPmLbH6MhXye6CacA=;
	h=From:To:Cc:Subject:Date:From;
	b=lpliEnROXXnK4D2aWC/OJayaArZnh88d06hulonHalaPLXQ5w0XVXXWZAHUrLO6vf
	 xLxYokP6BM/l8PnAvc5FzcR/F0SctC1EcnbJ1XuFrK0OL/cLCNE4X2qeyuR1jCN64u
	 x/9d56FBE/P5Pgxlz1CvneeR6F6rfwkyqEHvHbq8=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 0/6] RDMA/mana_ib: Enable RNIC adapter and populate it with GIDs
Date: Wed, 10 Apr 2024 01:42:25 -0700
Message-Id: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series creates RNIC adapter in mana_ib.
To create the adapter, we must create one EQ.
In the future patches, this EQ will be used for fatal RC QP error events.
In the future patches, we will also add more EQs for CQs.

mana_ib is served by mana ethernet for RAW QPs and by RNIC for RC QPs.
If RNIC adapter cannot be created in the HW, we fail loading mana_ib.
RNIC is available only for port 1.

As a minimal usage, this patch series brings adding and removing GIDs.
For this, we set master netdev to the ib device and set required port
parameters to get GIDs. RNIC of mana supports IPv6 and IPv4 addresses
that are stored in the HW. The MAC address is also stored in the RNIC.

v2->v3:
* On RNIC creation errors, we fail the loading. Removed corresponding checks.
* Revised commit messages.
* Removed unused members of new enums.
* Added a patch to set mac address to the series

v1->v2:
* Fixed rcu_read_unlock() and updated commit message in "Enable RoCE on port 1"

Konstantin Taranov (6):
  RDMA/mana_ib: Add EQ creation for rnic adapter
  RDMA/mana_ib: Create and destroy rnic adapter
  RDMA/mana_ib: implement port parameters
  RDMA/mana_ib: enable RoCE on port 1
  RDMA/mana_ib: adding and deleting GIDs
  RDMA/mana_ib: Configure mac address in RNIC

 drivers/infiniband/hw/mana/device.c  |  48 ++++++-
 drivers/infiniband/hw/mana/main.c    | 203 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  87 ++++++++++++
 3 files changed, 330 insertions(+), 8 deletions(-)


base-commit: f10242b3da908dc9d4bfa040e6511a5b86522499
-- 
2.43.0


