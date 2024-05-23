Return-Path: <linux-rdma+bounces-2596-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5912B8CD2F0
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2591F21D9A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073714AD36;
	Thu, 23 May 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hchj5BtQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4A14A4E7;
	Thu, 23 May 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469145; cv=none; b=rLXx1pnFe/LYoc+SSo2MwRxmjK/uxaWs5pgudgV9QBus0nxEe7FzjAOOo2nGr3NOG5cxpHaFNnWo8bjREfQP3LBDSBfLabhy6LIi5eSJgK3oJNGKODglioldgpchp2eL0BB+o4lJTmW//fBL8Fb3TnzIwfV3jehVcbGQ2IxOzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469145; c=relaxed/simple;
	bh=hcftNYsddadnCv048GeLawzgKXG7zWe4Ir3rA4XXvNE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CF5byKLDo7bFN5Zj4SGme9BoZaqF+MgA2I5Etfb/czT61WQ2ZMtTiSioXoPbR7/2CW+hhxqINEVnvtrvL/RZIO8JeZwPji/5zjriHyQEdKnKuLTpjM8BVAamoHs4yVR+mZ8KljmPFUp+lkmZcR5/Thmx+M8KEDNhzWXCJzsM0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hchj5BtQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A63C20B915B;
	Thu, 23 May 2024 05:59:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A63C20B915B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716469143;
	bh=AZEYm5GuhW1ZsBqFWlHzvoubnwpJ3VMSyRQiDDS9XOM=;
	h=From:To:Cc:Subject:Date:From;
	b=hchj5BtQg1EZf2QFbV0PSfyyssMZRES/bDhzFQIbX/mZxc2amHrqU5ksn4oexkAGq
	 CePgfLtoMmgXCDegUq3L/+XIzpN8/NCRQIirm+BJphjg+NOXT2NndaOrJI0unJmm/F
	 /FFLytXWLoNN8bCZ1IOKbKTY/przN2yMKGFiDqJI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/2] Fill in capabilities and guid
Date: Thu, 23 May 2024 05:58:55 -0700
Message-Id: <1716469137-16844-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series fills in GUID and device properties.
Most of these properties are required for CM.

Konstantin Taranov (2):
  RDMA/mana_ib: set node_guid
  RDMA/mana_ib: extend query device

 drivers/infiniband/hw/mana/device.c  |  2 ++
 drivers/infiniband/hw/mana/main.c    | 19 ++++++++++++++++---
 drivers/infiniband/hw/mana/mana_ib.h |  5 +++++
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.43.0


