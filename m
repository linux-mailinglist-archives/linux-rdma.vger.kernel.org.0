Return-Path: <linux-rdma+bounces-1831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FEB89BB57
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 11:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74495B22A24
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCAA3FE48;
	Mon,  8 Apr 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I/1NHMIc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A696446B7;
	Mon,  8 Apr 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567662; cv=none; b=fmpIACqpx2GwL4gJDqs+yKSvFIpbmydYAnMDFTODIRBZLUye8a+BwZsa6Xh8E1anqtnsbR4aVi0EKLs9EHWr/LfNuHKtTm98P7yQyFvL5dSrlmttBr3Eo+jK+KORu7tk+Zoj3jLGu0S/Ts5HZe0wVQwOdkoqohBUlrujDDZ8xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567662; c=relaxed/simple;
	bh=MdZ0uX/SN5I+7Rk9N5NLVGUpBmvC9Mp310Sh65sVcbM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=p13GO3wJ78cmzVeosIdi94abcX1eADdRra69grn1FlJl/G3lMhM1cXRaU3YZJK/NyN1VFEth9/+gFMU6bx1F8FNjmInpstsz7ZdtunpvPHlHsd2YXjP0B9f/pZy+/dzgGoVnzx6FQGFagfmTlLrI5VJez86DbsoSAPt08AhTS54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I/1NHMIc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 78F7220EA430;
	Mon,  8 Apr 2024 02:14:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78F7220EA430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712567655;
	bh=uyx+17NQbYDx2S0u8DJ8Vod3JMP7Po52Tht1yNaGGxg=;
	h=From:To:Cc:Subject:Date:From;
	b=I/1NHMIc0FjDIS/+aB4s01PcfupY3dhhKPQZKanVQkQMLLnHmRTRAD7Su4lZZzfZH
	 N3lWpczrp9Mk4xUjKZPJizjDpB9+oyMFV10JHU0sYa61zg3+lePQfN1fcz2HaUSlvr
	 d22/Rf6whhSwIWkDVJpnmipDWWwEH+EHWU70D3K0=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v4 0/4] Define and use mana queues for CQs and WQs
Date: Mon,  8 Apr 2024 02:14:02 -0700
Message-Id: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
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

v3->v4:
* Removed debug prints in patches, as asked by Leon

v2->v3:
* [in 4/4] Do not define an additional struct for a raw qp

v1->v2:
* [in 1/4] Added a comment about the ignored return value
* [in 2/4] Replaced RDMA:mana_ib to RDMA/mana_ib in the subject
* [in 4/4] Renamed mana_ib_raw_qp to mana_ib_raw_sq

Konstantin Taranov (4):
  RDMA/mana_ib: Introduce helpers to create and destroy mana queues
  RDMA/mana_ib: Use struct mana_ib_queue for CQs
  RDMA/mana_ib: Use struct mana_ib_queue for WQs
  RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs

 drivers/infiniband/hw/mana/cq.c      | 52 +++-------------
 drivers/infiniband/hw/mana/main.c    | 39 ++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 26 ++++----
 drivers/infiniband/hw/mana/qp.c      | 93 +++++++++-------------------
 drivers/infiniband/hw/mana/wq.c      | 33 ++--------
 5 files changed, 96 insertions(+), 147 deletions(-)


base-commit: 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa
-- 
2.43.0


