Return-Path: <linux-rdma+bounces-9156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46416A7BFD6
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41A517D1B6
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D131F5823;
	Fri,  4 Apr 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bRFHUbyn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDD41F3D30;
	Fri,  4 Apr 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777966; cv=none; b=NwEVwu1zwgqEILbBnWKuGg7Ws/oIt47LlVc4geRdQXW2GX0SfjI/VBAi0I2idyILVx4DaRp+CkmJm9O+Cw2h06U3cNoQYIRsZDVoBgIbDU2GKCGyFQl649r8Y1wDI6b4eowP5xK+s51uuo5+/2V9dn3bXM8e3Mfa5WBxiWjgfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777966; c=relaxed/simple;
	bh=xPFVRt788Qsp3YL2n04ma/bCI0gARlpdz79oVPXfql0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n0BE7kfkEJJ1CpkgvlO38FKcnY1/aHaZrUwpQBmmHU0YkU/BRkfQIrnZQdWhAV5jD3ohgJzWNOX6eDVjjv8jl3HpTk0kPScskTQEYXtd0knpyXWDRi8BnOeoGOsIBLYGX9xnOl6Ji/CeoTeyhFUSuqtiuI/rdR4+DkIgIIbeH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bRFHUbyn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id D47802027E0C; Fri,  4 Apr 2025 07:45:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D47802027E0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743777955;
	bh=pLzCsKARlSRbSYmVAexhuOJP5JxRTDsKiASP/81BSeE=;
	h=From:To:Cc:Subject:Date:From;
	b=bRFHUbynXaxSaQsOdx92ib+QYfSipGbNQpthrKQ1rzjefi1FiDYsCKWhcSHyPH/Wb
	 EcIm29nUV83lkk3l6Hl3zYTdQGHEoUVBYZOPPeZGewzKBD9RWdbTJ8/c9z4Ai00y5i
	 WlO1+PnziwGf8O7rd3/7wRCnY5bS5NP8iJ4HyoQ0=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next 0/3] RDMA/mana_ib: extend MR support
Date: Fri,  4 Apr 2025 07:45:52 -0700
Message-Id: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series extends MR support for mana.
It implements two flags for MRs: REMOTE_ATOMIC and ZERO_BASED
It also adds support for large page sizes.

Konstantin Taranov (3):
  RDMA/mana_ib: Access remote atomic for MRs
  RDMA/mana_ib: support of the zero based MRs
  RDMA/mana_ib: Add support of 4M, 1G, and 2G pages

 drivers/infiniband/hw/mana/main.c             | 10 +++--
 drivers/infiniband/hw/mana/mana_ib.h          |  1 +
 drivers/infiniband/hw/mana/mr.c               | 29 +++++++++----
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 include/net/mana/gdma.h                       | 41 ++++++++++++-------
 5 files changed, 56 insertions(+), 26 deletions(-)

-- 
2.43.0


