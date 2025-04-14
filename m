Return-Path: <linux-rdma+bounces-9398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47392A87B36
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D434166196
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5EB25D525;
	Mon, 14 Apr 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZSA/xw0i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F91EF38E;
	Mon, 14 Apr 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621241; cv=none; b=h68QmIb0/SCvAXphGsvS+4d69pVfxZH7rBeDMiYigdAOCKir7CG5VWxmO7HssS1Fl4joYwD8Nb93ggjYatG3N0DJEFRf0igo78aOYiOLdsKJRfiu5SCbyshQMTiSMRNQRG2Y2XTX0zEZGZ/1nL1nTJbpgyOYLm2u30XI3zGJOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621241; c=relaxed/simple;
	bh=xjQl33EJkEQ14aiPSHEJqBAw3w3vfy0BVJEWDWidJf0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rhNq8u4nr0x5TNfSpZJ+LnKFUhQXJHfO8UPIeGNISgMFjLAmqEWF/t1D+vDNcf657V5dBHN80HPZrGT2oHes/6v5BGiBBtfdgYkkMtE2xvcPfUIWsg8g0oubpFlC0oO60qMu99Ddut2SYC4HxR46AF6/AnkSykUpNbyv229pzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZSA/xw0i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id A841D21180CF; Mon, 14 Apr 2025 02:00:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A841D21180CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744621234;
	bh=X/Z97iQXcms05hZ6nBJt6ZGbGsOl8wndZCF7MpZGYMc=;
	h=From:To:Cc:Subject:Date:From;
	b=ZSA/xw0i9Mi9nVGWQGhkXNU2NodHoHsuFjMwNoXWGC+OANdpvsI6VT18pfLzYZvzz
	 Q1UIeQ4S1X6JgApu2sNdyTqZ2cLzl0znFZKES2RrBKGqgsc4VJtfpcH65xrAwp8fEv
	 /pxlDlS2zZQPcnq/zL7wnPrLRUjOdzAzorQLo7XU=
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
Subject: [PATCH rdma-next v2 0/3] RDMA/mana_ib: extend MR support
Date: Mon, 14 Apr 2025 02:00:31 -0700
Message-Id: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
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

v1->v2:
- removed unused enum values for page sizes

Konstantin Taranov (3):
  RDMA/mana_ib: Access remote atomic for MRs
  RDMA/mana_ib: support of the zero based MRs
  RDMA/mana_ib: Add support of 4M, 1G, and 2G pages

 drivers/infiniband/hw/mana/main.c             | 10 +++++--
 drivers/infiniband/hw/mana/mana_ib.h          |  1 +
 drivers/infiniband/hw/mana/mr.c               | 29 ++++++++++++++-----
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 include/net/mana/gdma.h                       | 28 +++++++++---------
 5 files changed, 43 insertions(+), 26 deletions(-)

-- 
2.43.0


