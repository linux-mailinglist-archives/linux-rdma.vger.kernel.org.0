Return-Path: <linux-rdma+bounces-15673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9E0D394FC
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 13:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A99300DBB4
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692032B9BE;
	Sun, 18 Jan 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M+MSbCl8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCF322B63
	for <linux-rdma@vger.kernel.org>; Sun, 18 Jan 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768740013; cv=none; b=Y/AP+oyESOaKVG+N35xvwvZnid/1Zw1QW3Bs307618uZSmsJBb+7kqae0Hu2KE+CVovDffgT+NWUH9hKoH8ZrwguW6gO8Pv12WSAx5dgwH+BQA8W2rPJXUsKhsDb21Z/q4u86N5Rz0rNxreE+7ijBHUJuHl3z2Vn+IrrN4z2dMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768740013; c=relaxed/simple;
	bh=qRzJzBx/RwBa0LNHNV5uj3EwIEAoqjsZQbqjP2dlWRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7GK7VEfcqgT/7DudkopnEEcdqQhnSjMbBXAb8h+E7RjNmJB2O2LjCyxQ6zTuBN/e8HuYrPqR4z6LNw3p+MEuIStK6udRAgoZa0FYIZk7uhghsC0AHgsyFoRdOe+RJFCxHNlJuZs8i+4LcbKMYhmU3RMckm6ewOv1HkTUMxIIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M+MSbCl8; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-81f416c0473so2956696b3a.3
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jan 2026 04:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768740011; x=1769344811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipxYQ6lajVVVhDpOFxNg/pK0dQuceg7/qSITiJBtMVI=;
        b=UC0YaSLj32x2FoeKBRpkIiMdoqoE2N3nbuJyDcW04OGjUYDamOkl7xqjySHeCSHf6x
         Pli8OnjHayNmeDwOiuX6ylAsvqU5n3ylcKftcR6aHt7FAX4xvPfE6PayrPH4Qind42iA
         ZpPaDJ1KLsPU9S61RKZ/kXqz2LVq8yCdpbqU+YXtvRWF8JDr7awmWpfF8W9tsTSOvc8z
         SWKx8goZNwlf6B6zpZJL1HUguZIWa3g5Doh0rBjK7xT87q629BWl3C+u/09f0U4C5Omc
         whiiTiyF/IET6Nx0EVjP8Z1W/D1iUxtJu1py1Jv1d3tyY0A1YuOHUVlDYDuA6uwAQ/yf
         W8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBDOGDR52akqztZ7srz1dC1cGIWMU1z2dGtcEgG8IZcqH0tIEwg8HUFEg1hOlWAbnmdiNaekId9TsI@vger.kernel.org
X-Gm-Message-State: AOJu0YydVdkpUDsbmtkJQa6MXguboiB6PI8yYm5CUUiHOcfWUH/wIvHf
	jhHg6Zq8LeWsZN0NvNWXutWD9VMPZ44k9jM+yeXGSuSIgyvWAvGKyUaTtdjQWP9WPCKmCpfjm8o
	0Qrqb0gliiWtymClpk7Jkxuvvy2sBT6Uav1oKo111B3p+7i99s4lv7Wb/TnJAyhgCkxu3F8Aiz3
	BVdobeurw0R/Qd3gGFSAdZdEBhwM8taCNosH6MpweQ6HZB20ErWPlgSPHxhU5N1sHiS9LfxilN9
	DP4GtkHafcCQGo/
X-Gm-Gg: AY/fxX7UoEArS38TmuOAZK4AIecPN5lMBsSsPsOQQdvH1AY+CQWSC4zBb0qxJDmm9BF
	SimdS4cs/XoLT7+nJEfL2XTY0RsxYyTuPzv9q7lLRWsTrqZCxxNiqnXxySMBBU12q5Gce/a/6Cl
	eVVke2wa8fJFjb/TZghBd1UqqlsHrsiYUXkcVdlsuEvQus2R4Omk31/zc/IzvaSBB2eLLF2nTM8
	sWr4oIxhCdNWYRWRL6c0grqtFBZUtIkWtMZZZUm7OU+mTG+GP9aIl3EeYbVvUnlR8tjvPe+bli7
	QzLJmUE49I9WFpK9GHwtVjY1TI6s09O/lAZ5GQucg6F0IF87Rrh2mcalOcpLG96QqN3J6tTADgQ
	E2jc0jDjbt2Q2ZROncroUgs0RI46fE0CWBYxLSn18O2EHMZwYlZALSJNoT9FAAhHTjWHhmqtP/5
	VkuW94XbcY1AwDKn74u+TbjII58jH6OzoxYcBgl3qySavT12g=
X-Received: by 2002:a05:6a21:4d8c:b0:389:8f3f:50d0 with SMTP id adf61e73a8af0-38dfe7c28c7mr7336591637.60.1768740011595;
        Sun, 18 Jan 2026 04:40:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190b673esm11026775ad.17.2026.01.18.04.40.11
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jan 2026 04:40:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ac814f308so5457461a91.3
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jan 2026 04:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768740010; x=1769344810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipxYQ6lajVVVhDpOFxNg/pK0dQuceg7/qSITiJBtMVI=;
        b=M+MSbCl8wW5ed1HCHIPHoQrz69DhtubVE7+rNwnz8xKDt0fmljf71YxNCXAQSY+vLu
         em7of2cLD3Wq+gbDjfpaNoKkVXrE+yqDJMJRpq6Nwlh4QyF/4OszayBdmaRF1uzp3nNf
         ucdgkvDliO3FpNhH5tDGiG6IvULr9aJd2GKOc=
X-Forwarded-Encrypted: i=1; AJvYcCXtpf+V8CYnEA0B8hN3lTF93HGKs0GREkTYu3CWC4kTOfKIfClTfcwRMhInvW7QYXZezjt29FLVP9ci@vger.kernel.org
X-Received: by 2002:a05:6a20:938a:b0:38d:eeb9:8f6f with SMTP id adf61e73a8af0-38dfe80be52mr7079524637.72.1768740009911;
        Sun, 18 Jan 2026 04:40:09 -0800 (PST)
X-Received: by 2002:a05:6a20:938a:b0:38d:eeb9:8f6f with SMTP id adf61e73a8af0-38dfe80be52mr7079512637.72.1768740009545;
        Sun, 18 Jan 2026 04:40:09 -0800 (PST)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf249c24sm6761246a12.11.2026.01.18.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:40:09 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: jgg@ziepe.ca,
	michael.chan@broadcom.com
Cc: linux-kernel@vger.kernel.org,
	dave.jiang@intel.com,
	saeedm@nvidia.com,
	Jonathan.Cameron@huawei.com,
	gospo@broadcom.com,
	selvin.xavier@broadcom.com,
	leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH fwctl 1/5] fwctl/bnxt_en: Move common definitions to include/linux/bnxt/
Date: Sun, 18 Jan 2026 04:33:57 -0800
Message-Id: <20260118123401.3188438-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260118123401.3188438-1-pavan.chebbi@broadcom.com>
References: <20260118123401.3188438-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

We have common definitions that are now going to be used
by more than one component outside of bnxt (bnxt_re and
fwctl)

Move bnxt_ulp.h to include/linux/bnxt/ as ulp.h.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c                         | 2 +-
 drivers/infiniband/hw/bnxt_re/main.c                            | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                        | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h                       | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c               | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c               | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                 | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                   | 2 +-
 .../broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h        | 0
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (100%)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index 88817c86ae24..c57bbe3492a8 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -10,8 +10,8 @@
 #include <linux/pci.h>
 #include <linux/seq_file.h>
 #include <rdma/ib_addr.h>
+#include <linux/bnxt/ulp.h>
 
-#include "bnxt_ulp.h"
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..79ca734a1377 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -55,8 +55,8 @@
 #include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <linux/hashtable.h>
+#include <linux/bnxt/ulp.h>
 
-#include "bnxt_ulp.h"
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index c88f049136fc..5a28946e4668 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/prefetch.h>
 #include <linux/if_ether.h>
+#include <linux/bnxt/ulp.h>
 #include <rdma/ib_mad.h>
 
 #include "roce_hsi.h"
@@ -55,7 +56,6 @@
 #include "qplib_sp.h"
 #include "qplib_fp.h"
 #include <rdma/ib_addr.h>
-#include "bnxt_ulp.h"
 #include "bnxt_re.h"
 #include "ib_verbs.h"
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 2ea3b7f232a3..ebe8893937f6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -39,7 +39,7 @@
 #ifndef __BNXT_QPLIB_RES_H__
 #define __BNXT_QPLIB_RES_H__
 
-#include "bnxt_ulp.h"
+#include <linux/bnxt/ulp.h>
 
 extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..4481d80cdfc2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -59,10 +59,10 @@
 #include <net/netdev_rx_queue.h>
 #include <linux/pci-tph.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 #include "bnxt_sriov.h"
 #include "bnxt_ethtool.h"
 #include "bnxt_dcb.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 15de802bbac4..230cd95d30a2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -13,12 +13,12 @@
 #include <net/devlink.h>
 #include <net/netdev_lock.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_vfr.h"
 #include "bnxt_devlink.h"
 #include "bnxt_ethtool.h"
-#include "bnxt_ulp.h"
 #include "bnxt_ptp.h"
 #include "bnxt_coredump.h"
 #include "bnxt_nvm_defs.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 068e191ede19..8cad7b982664 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -27,9 +27,9 @@
 #include <net/netdev_queues.h>
 #include <net/netlink.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 #include "bnxt_xdp.h"
 #include "bnxt_ptp.h"
 #include "bnxt_ethtool.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index be7deb9cc410..83884af32249 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -17,9 +17,9 @@
 #include <linux/etherdevice.h>
 #include <net/dcbnl.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 #include "bnxt_sriov.h"
 #include "bnxt_vfr.h"
 #include "bnxt_ethtool.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 927971c362f1..fa513892db50 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -22,10 +22,10 @@
 #include <linux/auxiliary_bus.h>
 #include <net/netdev_lock.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 
 static DEFINE_IDA(bnxt_aux_dev_ids);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/include/linux/bnxt/ulp.h
similarity index 100%
rename from drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
rename to include/linux/bnxt/ulp.h
-- 
2.39.1


