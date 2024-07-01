Return-Path: <linux-rdma+bounces-3578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5684A91DBE6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 12:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CEE280E97
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8612BF32;
	Mon,  1 Jul 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qh7oMyl8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5F12B169
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827883; cv=none; b=V9WaLKkKWrGvfNCvU+MjDTMfZqZbOlHoZyXQ+o3r75cGvrx1kbHr2vnUJqUNg6kydF+Y+dBoBnvnesDQi9RrtgRvenPGJShCfoki9n3r292lgU+Gpi7FR1y54w86vl8613zVfVW3+ZB+sxEvoRjm0cB3wlINdm7FS8J31i5v44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827883; c=relaxed/simple;
	bh=1MuC5y1JDTx49Tfo2D0ymOMMIMAFcPQ7y/8jh5j6DdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HXbXtFREEab0yqOLO8RvsE0GODwnpZ+VnanrhXJi4WPyBd64XqGY2Qjd64ixLxzsgoHdv18K7L9EsR0UZPiWxlin64u07HpGb827HjH1jjLX5Y8go0OjA8iqPRj+7TGlu5kwMFDmK3D/2ptnJVOp3qDKMXOw6Li0uFUqzz2DKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qh7oMyl8; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719827882; x=1751363882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FtjAJQaP1mDFDjfLCwVaJujzerG4eRFs9kr6KipDEwg=;
  b=Qh7oMyl86FYwcOiQnQ5N3BI3HfQucBXuM5YuxkCVXLPAmazGigY77YCN
   vmqJXPbOA9tJee/xnzRuqUTjiMnYb/FsGb902wG/ZpA8gYiEwBpoHhL1i
   wsmf5k5sAUGdp13MfWQO+x45kp5J7yfPZsq+m9wfCHhc1ajX+WoZD3YUR
   c=;
X-IronPort-AV: E=Sophos;i="6.09,175,1716249600"; 
   d="scan'208";a="736925158"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:57:56 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:42284]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.226:2525] with esmtp (Farcaster)
 id e6b30cb1-fa03-42b6-bb2f-d3a409009482; Mon, 1 Jul 2024 09:57:54 +0000 (UTC)
X-Farcaster-Flow-ID: e6b30cb1-fa03-42b6-bb2f-d3a409009482
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 1 Jul 2024 09:57:54 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D002EUA002.ant.amazon.com (10.252.50.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 1 Jul 2024 09:57:53 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Mon, 1 Jul 2024 09:57:53
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Add EFA 0xefa3 PCI ID
Date: Mon, 1 Jul 2024 09:57:52 +0000
Message-ID: <20240701095752.20246-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for 0xefa3 devices.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 99f9ac23c721..1a777791bea3 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -16,11 +16,13 @@
 #define PCI_DEV_ID_EFA0_VF 0xefa0
 #define PCI_DEV_ID_EFA1_VF 0xefa1
 #define PCI_DEV_ID_EFA2_VF 0xefa2
+#define PCI_DEV_ID_EFA3_VF 0xefa3
 
 static const struct pci_device_id efa_pci_tbl[] = {
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA0_VF) },
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA1_VF) },
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA2_VF) },
+	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA3_VF) },
 	{ }
 };
 
-- 
2.40.1


