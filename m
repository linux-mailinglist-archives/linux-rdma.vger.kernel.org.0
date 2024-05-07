Return-Path: <linux-rdma+bounces-2309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 591AC8BDEFD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 11:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C22AB254E4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613414E2D9;
	Tue,  7 May 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dcdIJOCa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EBB14D428;
	Tue,  7 May 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075608; cv=none; b=rThWGttNiiDNAjQitIaXsTX6WzYHZDZpYR8FrYYKv6g6seNjeCN/eBoaHnfY/jdsRW8M+uIpun3UKuuSlCf1d2q5DZCpY3V82rIfgmIjeqpoGbedXS569eMe+uzojNomZsKypIrz155LswWuBpMm66NrpjNIEGQHX1K056hW0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075608; c=relaxed/simple;
	bh=vSVNXtPMzlR8FQr73nSL5d4D/Y1fpR7I40Ru5of3Kus=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H3Zdu1JjVdCinVuh4pOErfyvFQ4F9wUVXNivZR9ObY2d3zNZgTrpVoY7p28N8X1Jy9xunaxIvH3jwxdn4Elfvbi45s4j1l2aSovRGGNx2+5xdBnYcwvoqID+iIXDFkrpG2w9YGNOUqXU6aIwDHSzQwZHu2n6Ue9/fu+M76LyIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dcdIJOCa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C019220B2C82;
	Tue,  7 May 2024 02:53:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C019220B2C82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715075600;
	bh=DRjxzGa9W7827S8JDXAB+pSXZUdM8d1xIl3Dmk5c4MU=;
	h=From:To:Cc:Subject:Date:From;
	b=dcdIJOCaYZ7+ELv65LP6paXcf8lyNqGnHiRJqNScrnNCgMWouTpjPRB0CmCpcRKen
	 UW2U2jgEvo4BeeMFEVABaerBWhBPyFElg3lc+ImdsQRN60cGBk6lNMMru7/ZdqK/cd
	 Sp5EOCU0pPGOpj9kRVzCM+oMtijhGBjbaYAAznIc=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/3] RDMA/mana_ib: Add support of RC QPs
Date: Tue,  7 May 2024 02:53:12 -0700
Message-Id: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series enables creation and destruction of RC QPs.
The RC QP can be transitioned to RTS and be used by rdma-core.

Later I will submit rdma-core patches with fully working RC QPs.

Konstantin Taranov (3):
  RDMA/mana_ib: Create and destroy RC QP
  RDMA/mana_ib: Implement uapi to create and destroy RC QP
  RDMA/mana_ib: Modify QP state

 drivers/infiniband/hw/mana/main.c    |  59 ++++++++++
 drivers/infiniband/hw/mana/mana_ib.h |  99 +++++++++++++++-
 drivers/infiniband/hw/mana/qp.c      | 165 ++++++++++++++++++++++++++-
 include/uapi/rdma/mana-abi.h         |   9 ++
 4 files changed, 328 insertions(+), 4 deletions(-)

-- 
2.43.0


