Return-Path: <linux-rdma+bounces-869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B884729A
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 16:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626061C278A0
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C889145B05;
	Fri,  2 Feb 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GRuk4gka"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD214533A;
	Fri,  2 Feb 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886412; cv=none; b=sMmkcEdHyTIOOPiiBXNZ6i0IOrOYBc4RnixWDVndZ3l9YDhUMSP59G6Hl7FzrRwIaENC2pMFc+VSb6SqCaAnzZ7MG71WMRIMyC9OKpUapHe4XYF2olR15A32gopihAae9StaeYDNuiSAXab4xhugJHX50NelfHV+8BF9RwIoCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886412; c=relaxed/simple;
	bh=Qva0FZXc/on/qqAMm5pFDLtP0E/Z78ZXF145dajsZKQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MzJ3pHTsDW7pDpDLdSMEdPr6LSsn2DEvgUNYEobuHPRbbtvSj8tEkSl6RisT7rz6ItjFXJpXWIIx+jW9Ipg1dzjuuZq7foePuxGw98mRJVUJUzkWjozm3S4Mw74CF10VTXFNl4Gu5EtMR1iyz/OYEicc98iAfLXkIboEct+fuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GRuk4gka; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B4C920B2000;
	Fri,  2 Feb 2024 07:06:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B4C920B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706886405;
	bh=Dws5qYPXtDgA7IQskAdnTtqBb3IDbT46m4xR7ZECJfA=;
	h=From:To:Cc:Subject:Date:From;
	b=GRuk4gkadbBY2haBlHy17sLtkVNHWxlWjzX/34e0CMqOeagt6bcLb9Myh0L6xP5e3
	 zqWk5nAYOwNVxbYMX66s1wWL/fEv6lIZ1mGtnouoMeH42pgGXPgTIopT/Dguv7rqmk
	 KmITOQhNWxpuwK1++TGtTlkUzWRLxCdCE2JjYLw8=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 0/5] RDMA/mana_ib: Enable RNIC adapter and populate it with GIDs
Date: Fri,  2 Feb 2024 07:06:32 -0800
Message-Id: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

This patch series creates RNIC adapter in mana_ib.
To create the adapter, we must create one EQ.
In the future patches, this EQ will be used for fatal RC QP error events.
In the future patches, we will also add more EQs for CQs.

mana_ib is served by mana ethernet for RAW QPs and by RNIC for RC QPs.
If RNIC is not available in the HW, we do not fail mana_ib and keep only RAW QP
support. RNIC is availale only for port 1.

As a minimal usage, this patch series brings adding and removing RoCEv2 GIDs.
For this, we set master netdev to the ib device and set required port parameters
to get GIDs. RNIC of mana supports IPv6 and IPv4 addresses that are stored in the HW.

v1->v2:
* Fixed rcu_read_unlock() and updated commit message in "Enable RoCE on port 1"

Konstantin Taranov (5):
  RDMA/mana_ib: Add EQ creation for rnic adapter
  RDMA/mana_ib: Create and destroy rnic adapter
  RDMA/mana_ib: Implement port parameters
  RDMA/mana_ib: Enable RoCE on port 1
  RDMA/mana_ib: Adding and deleting GIDs

 drivers/infiniband/hw/mana/device.c  |  28 ++++-
 drivers/infiniband/hw/mana/main.c    | 203 ++++++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  75 +++++++++++++
 3 files changed, 298 insertions(+), 8 deletions(-)

-- 
1.8.3.1


