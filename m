Return-Path: <linux-rdma+bounces-825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF2843DBE
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 12:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565D5B3011D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE426EB4E;
	Wed, 31 Jan 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G8MMrpEU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641869E0A;
	Wed, 31 Jan 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698559; cv=none; b=XBO40BLAE1ELt1nw4EnuIujVfz9/783kqTZe2yzYrN10rqY2KwQqlHQLnhP0kLCDqQ5L5H3rT0uvBdX/B0iD485UNY/At1HCxHGCuHT21/jWOjeADUxp+8DPXeHkqsjrWJ/YokWJjbBPQgX66zIfwf1YBGCRbdsBX6rBHJsuChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698559; c=relaxed/simple;
	bh=frqd03oMwryAVYOMjuhoxNgEPtVwWiXGm8JhLGkkWjM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LE+MInpXic59sAv/CjTFvcwK5c0WcQSVhuUWAIpB5DU9JhbhyUV4S3T/SCm7AzdBqG7MAwjruejZ6Q1eafKBty6Pc75dzXp+IvHSXZDB0TC/C77Cd5OXvtYB39TyGBo7iNrAI+nNXv4Iy2mhMfABjxRWs5pfxPh/+8BurRFYCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G8MMrpEU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90C2C20B2000;
	Wed, 31 Jan 2024 02:55:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90C2C20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706698557;
	bh=KuYMJ+KtPcMpYaHpCQD6at9/ZkKaQhJhxkcrHAaAz5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=G8MMrpEUYNwKezWt0+XL+V2iOx7qrmPPI1Hzv7f2rknXSRL1q2Bb7iDikR0y+DNGf
	 LLrPpgEumCEVyEYkdaxeebwtVqix1aNAMI4otjHtVUJtNgF05JCzgo8zGPk7NLyIDi
	 3Zz996xwwKFNxWHiWf5HgiNONhbBVhpalwpDDTBM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v1 0/5] RDMA/mana_ib: Enable RNIC adapter and populate it with GIDs
Date: Wed, 31 Jan 2024 02:55:47 -0800
Message-Id: <1706698552-25383-1-git-send-email-kotaranov@linux.microsoft.com>
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

Konstantin Taranov (5):
  RDMA/mana_ib: Add EQ creation for rnic adapter
  RDMA/mana_ib: Create and destroy rnic adapter
  RDMA/mana_ib: Implement port parameters
  RDMA/mana_ib: Enable RoCE on port 1
  RDMA/mana_ib: Adding and deleting GIDs

 drivers/infiniband/hw/mana/device.c  |  27 ++++-
 drivers/infiniband/hw/mana/main.c    | 203 ++++++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  75 +++++++++++++
 3 files changed, 297 insertions(+), 8 deletions(-)

-- 
1.8.3.1


