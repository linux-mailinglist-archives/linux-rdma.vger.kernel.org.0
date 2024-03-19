Return-Path: <linux-rdma+bounces-1484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5083E8802D9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C1B1F21D3C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47FFC11;
	Tue, 19 Mar 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OLhyahVU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604F2209B;
	Tue, 19 Mar 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867626; cv=none; b=PzP0YueEd3sna/JjgHIEVEx55YrDH5Rk4e5e/7eKomgyrXCVPLKMfXslvgkKDcyiyZIzcn7tdOQuSHbwUbV4Xv0/5TPP2CRUY7UkQ9N0auWQFpKuy8si4r3B+JavOyLfp6/4lbBLIaoFkxJyEomV91O0zO8ZlyMknD3VcMdd3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867626; c=relaxed/simple;
	bh=CNCxoIE+1gPOmlDVw3CbyXIXXBCrmO7yEk/7ckcCOQ0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dghpXQE5yLt2jblfOZWQKFDM5pW3d0O0Cz+0g9vVRXh4QDThbxqD8lSWvyZ7dPURg9YMVDv48mGvceSNlh5/TGENCdry/+VCzihux60D1tsd//3y56/ShIfZHhFK9YGv5cD9kQdWGFjaLtVQlppaf1WRPtaDKISAyri1LQ2PH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OLhyahVU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BF0120B74C0;
	Tue, 19 Mar 2024 10:00:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BF0120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710867625;
	bh=l15ZMQHRWNCIqM+/Lh6WWvV8nS7fyimXjy0U0UdXknE=;
	h=From:To:Cc:Subject:Date:From;
	b=OLhyahVUc44J92zxgPICtslFoYLMrP1WEDqe7EimgUIpkdN8p+3fVzsXK39Z/VTvW
	 uxaVh2oaEOVOk4SqhVCNooGaGHvPMeETZGW4IJVmbtY5Wjyys2X2tNR6/zof21rW9P
	 0uhOGlnBgEOquSWFN77v7y5bhFnRFT52ZbRb60qg=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 0/4] Define and use mana queues for CQs and WQs
Date: Tue, 19 Mar 2024 10:00:09 -0700
Message-Id: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series aims to reduce code duplication by
introducing a notion of mana ib queues and corresponding helpers
to create and destroy them.

v1->v2:
* [in 1/4] Added a comment about the ignored return value
* [in 2/4] Replaced RDMA:mana_ib to RDMA/mana_ib in the subject
* [in 4/4] Renamed mana_ib_raw_qp to mana_ib_raw_sq

Konstantin Taranov (4):
  RDMA/mana_ib: Introduce helpers to create and destroy mana queues
  RDMA/mana_ib: Use struct mana_ib_queue for CQs
  RDMA/mana_ib: Use struct mana_ib_queue for WQs
  RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs

 drivers/infiniband/hw/mana/cq.c      | 52 ++++-------------
 drivers/infiniband/hw/mana/main.c    | 43 ++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 31 ++++++----
 drivers/infiniband/hw/mana/qp.c      | 86 ++++++++++------------------
 drivers/infiniband/hw/mana/wq.c      | 31 ++--------
 5 files changed, 107 insertions(+), 136 deletions(-)


base-commit: 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa
-- 
2.43.0


