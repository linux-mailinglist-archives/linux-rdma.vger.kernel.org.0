Return-Path: <linux-rdma+bounces-1581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDF88CDDB
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 21:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA2A1F319BD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638813D29C;
	Tue, 26 Mar 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OOq79//s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6353DABE1;
	Tue, 26 Mar 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483706; cv=none; b=eQ3EU1/L100cHzUOEq2reAQ9dGJrhQFJHYRrRmKeq4FQvWX/dyFjuajD39Ofcb06f4UL17hG7p1F7PFZO0HAYPpBeyuiazWE17irQDbpIJYTykRTCcL5YUztTDEwMOcqQ7+MWImC2XByoy0QQXX/RxwKFw+fPEaBFukEyRzswJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483706; c=relaxed/simple;
	bh=uwmKiJB2Wmwz4BiJOeNxPxIyAK58IG/E6fg2OdHTkXs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OknQZCcz1jSFYcTkQsWWvShL9z9+xv1dPUgOr+RBnfrHUWns/cO1aH4qED85MVr3kkSuRtCwxT7sHpSfoqZBd1mr+kv1QQH2A1w+lFoBhuk+0neMs2Fj15/+oJKlDjFnlRNmYhvYZXUjdHS/myl34G38ebRRJZ8ph0Lr5XGEIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OOq79//s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id EAFBB20835EA;
	Tue, 26 Mar 2024 13:08:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAFBB20835EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711483698;
	bh=dNoH+DszInVYNcoZvU/lWKrSqlI+a5th9uvaZyDr1dQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OOq79//s9C33iYBVNg3jX/bYveiqICN+8WBp6FxNZLLzqwp6iAeRb1U62QO9vdEhH
	 iH0m/pnPUD12Y7WDYtfCwd9oXI7Z3bi1eaxIvQH6+AdrYM2anPfS7Bpkx3kgPzGSin
	 ahTkuB9Y/HIwtKoKXh0e03A/ftfzWTjKKWWR1UCE=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 0/4] Define and use mana queues for CQs and WQs
Date: Tue, 26 Mar 2024 13:08:04 -0700
Message-Id: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
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

 drivers/infiniband/hw/mana/cq.c      | 52 ++++------------
 drivers/infiniband/hw/mana/main.c    | 43 ++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 26 ++++----
 drivers/infiniband/hw/mana/qp.c      | 88 ++++++++++------------------
 drivers/infiniband/hw/mana/wq.c      | 31 ++--------
 5 files changed, 103 insertions(+), 137 deletions(-)


base-commit: 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa
-- 
2.43.0


