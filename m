Return-Path: <linux-rdma+bounces-3452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465A915330
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA5128166F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5619D892;
	Mon, 24 Jun 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="miYQEI9x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1912FF84
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245465; cv=none; b=eb9VBwg/xppZ2EHbjma9B86RFo058VQswsaTr7GmF95sTU2b0f4Ar2WnyNHvrKVWzBnuep0s6V8VlTCSgGnDXaJGD/wpCy183IQJbV99PAdOlKpm4/h9YiwH0U8oHpbNJUeTdMs/xeYwqJJYxT/+iCLlByHC7/BArw/TmeZQ3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245465; c=relaxed/simple;
	bh=85LRKdUo71x9kUpJ3q0A60fViF/4rCLKaf/C/4jkddc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnew3HMLZ2ptllPJCVjy8/rJCftZqwXe2h6ICKdhbu3vNEG1oyRUgY5i/pebPedTijRrgtPC3GbxWZlNVQ9yHQwkOvVCQlyhVqZ26aaHSICNLBGEuxu1kzwskY0ME8Sx/5vyqUgaKx8NsQ6tBn3PNA/C+ysjcl/C57IEZSoFzG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=miYQEI9x; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719245464; x=1750781464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ig1/5Dz9cfq8ZyAjw36658AzuAcDY+Nr48HPH3TYuM=;
  b=miYQEI9x6gmu7dQPWlOqFfepr3EOudDVNbAoIhaW4Je7pHBvhHFhLaKL
   XQDFrIlEYezWL0wkH95SnjOfvKZmL0hxolEvQvh/QFKwkol0hiUNr3Uk2
   OE5oZW6RjWS6E2i3ZjSV8x8RmSPvzMztaZ3pH1qmKKGx97OBLRfDPL8rE
   s=;
X-IronPort-AV: E=Sophos;i="6.08,262,1712620800"; 
   d="scan'208";a="662631179"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:09:24 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:15362]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.97:2525] with esmtp (Farcaster)
 id 314b78e8-4a46-46a1-92aa-f0810b59e997; Mon, 24 Jun 2024 16:09:23 +0000 (UTC)
X-Farcaster-Flow-ID: 314b78e8-4a46-46a1-92aa-f0810b59e997
Received: from EX19D013EUA001.ant.amazon.com (10.252.50.140) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:23 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D013EUA001.ant.amazon.com (10.252.50.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:22 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Mon, 24 Jun 2024 16:09:22
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next 2/5] RDMA/efa: Remove duplicate aenq enable macro
Date: Mon, 24 Jun 2024 16:09:15 +0000
Message-ID: <20240624160918.27060-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240624160918.27060-1-mrgolin@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Yonatan Nachum <ynachum@amazon.com>

We have the same macro in main and verbs files and we don't use the
macro in the verbs file, remove it.

Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index eee2ae215414..cd1f735d08a7 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -26,10 +26,6 @@ enum {
 	EFA_MMAP_IO_NC,
 };
 
-#define EFA_AENQ_ENABLED_GROUPS \
-	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
-	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
-
 struct efa_user_mmap_entry {
 	struct rdma_user_mmap_entry rdma_entry;
 	u64 address;
-- 
2.40.1


