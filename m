Return-Path: <linux-rdma+bounces-13669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2467BA3044
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 10:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04D14A3AB0
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE829B79A;
	Fri, 26 Sep 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ROYU4YKE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726E29B214
	for <linux-rdma@vger.kernel.org>; Fri, 26 Sep 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876690; cv=none; b=f0Wf2R2WG1V30nQ54wlaLXHTUrJLZ8vRzEyk1JPI/q3nAbvx6X9sweZ3x4IlTWCmZRvLPSoMZr1IwZs+hWadFAFLRugjUcHo3eHR82SVVOzhWJq2As50LUz0Y/SKG2lJBXMqI8ADseoLNPEgIYi9l16ZWL3ZXLbIXBcc9yVsNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876690; c=relaxed/simple;
	bh=PqVmoBJ3n9FUfPcb+ahelooKl/SQ3J98XS1MbbnNCPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUj17Z4ubae9yihETkxqKf/ODFjxCVqWCsFpnJW/lB6lgmiZ5x4V6Bb8FZq60esrfQuuvvt8e7kRdvwVlopcpcfHyTZPZIriF0gpKx7Z3V+EszOz5ci0R38CUyuM8E0GBx/+TDJ/yV++jj9uVusB71V8FFMwkpd98SUR3TYaCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ROYU4YKE; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2680cf68265so16721285ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 26 Sep 2025 01:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876688; x=1759481488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WTwptKJB4wsOQ5ZpYNmlcHWB6JYf0nt/4QKdcm94TA=;
        b=NttiDUH/GCptnhDtuWpkHshjn84yI3A7is5cvtSH3IRa1vzA2bPXo51dTeUF4Tl00P
         a9YSYO4MpIN9WaXwZoRSuRW5MV+hcJGyHwrcQrczLWN/huBjf2RyZ6UbFM74PwdSuvCS
         7cYQwXTdsDN1DSggy3X0nPSimIlVPGmOJ1ieIzgGZXcadiVpvnpvRrGo3aZWzzM4+eFs
         KUPuUiRAzsLLSZ96fMVnZ3RKD0ueBqbJAUPwKvu6sZ5F5K2QNkTAzu5PvpEocpsNxSVj
         w4p+v7Tb9o6Ax2WvxoV3KrISJe9Zo5foKcgJUBGEpnO+KtVmAibJM6N8j8mWIiJufwkh
         JM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0lIE4aOkKQtcmCZ+y6mVIXJR4K7X2/z/zjM/362Wgci9i8+7NrQKHDkj3dtUGWD/RRwjcgwyNRZuv@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzIIc4Mlj8zP7P7y9NXzYDxZOJobzJYhzSE6wUZdUKKwgFAjb
	uHetzc4s6fA0nMas0m8DKj8PrnwTBMEPFfqFvxzGVHxQ2dWMPwuNlfFaQsFbtSeDOBuZsd0kI/Q
	dSI4/ElHgsMIbge07lfCMHCh5vp8nKk7/O+Jz1EAcYNtK7WhM1JeIFAE8rIjIIXnaTyctZMMKvd
	Zqg2eWsI+xFVtzROo2puXkoydA8tNACmec1mDralR4U4L14GZtwAl11w3h8n7xzHGJ+spV75Zdm
	54AT2V24vw7mXyX
X-Gm-Gg: ASbGncsa+lZ9x61/vPOETVPcF5BINkFzZ/mCkERW+srkWzB9IZFxzA78ijwi7yY+upr
	qyXMK4znaegIWmgOhfXWczt9mnh4rhA3TL7zs4tExYCF8CDm4g50tZdZ91SKXBfolrB22vnYSdR
	cfeRovOUdndYd/2ZiMem7BwmA9aeKmmZGb5mDjOBbafgnorEfEauFNyCLysgj2cxFh0gK5Lj8/s
	sHPgQ/bTJzTHioQ9cwQkkdajpocYUOKDtim22YSCxKWHYY0KUBbguTkiUf4AwIUm8jvppdwbfDO
	ENj/7KUlfptTzsDHql5leyFy22MWwxyVsbEeO773F+tD9bIPdIWmbm/moOZ0vKD9HyjSIAjDH5V
	2ZIXbplKS/Yf5PrZSN6iuqs/sObT2/5C4Ia8gH98lqLF58h6eV99/kO9rA/P2rnKAaPNRfEsV/A
	pRQg==
X-Google-Smtp-Source: AGHT+IHPPg7InMZdWdSBObFqcs6kfjFUOgWBiRLbnOwbp/qbSCnJin6OVQsIKGFSz2yTHd9AkQI4Hwky9+3n
X-Received: by 2002:a17:903:3884:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27ed4a76e00mr66270855ad.37.1758876687815;
        Fri, 26 Sep 2025 01:51:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed68131dcsm3269135ad.58.2025.09.26.01.51.27
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:51:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so1614550b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 26 Sep 2025 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758876686; x=1759481486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WTwptKJB4wsOQ5ZpYNmlcHWB6JYf0nt/4QKdcm94TA=;
        b=ROYU4YKEtlZjZQf+uI3oVnikjdeZ1XkEKPOpSd0SDOyEjZrDe5bEypwgf3AfDsYsCr
         Ja5AmdTKj26M34YG3oPuMw+HnRwvVUEuT20X79ri0z+yZfxDO9xJnsAE4CETQ0EtZMpR
         ++FeUxKQGzNNStm4YUbvpD3jrku+yRIQFpu2Q=
X-Forwarded-Encrypted: i=1; AJvYcCWNtEB0HIwPb7jywY0jtGo1dVshdvwgFpPvpk5wkfu5Qzhz35A+a3tHVvskKg8QFNITTo1sQMJQhHT3@vger.kernel.org
X-Received: by 2002:a05:6a21:6d95:b0:262:d265:a3c with SMTP id adf61e73a8af0-2e7ceeee4a2mr8684564637.32.1758876685961;
        Fri, 26 Sep 2025 01:51:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d95:b0:262:d265:a3c with SMTP id adf61e73a8af0-2e7ceeee4a2mr8684521637.32.1758876685537;
        Fri, 26 Sep 2025 01:51:25 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm3959896b3a.92.2025.09.26.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:51:25 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: jgg@ziepe.ca,
	michael.chan@broadcom.com
Cc: dave.jiang@intel.com,
	saeedm@nvidia.com,
	Jonathan.Cameron@huawei.com,
	davem@davemloft.net,
	corbet@lwn.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	selvin.xavier@broadcom.com,
	leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 1/5] bnxt_en: Move common definitions to include/linux/bnxt/
Date: Fri, 26 Sep 2025 01:59:07 -0700
Message-Id: <20250926085911.354947-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
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
index e632f1661b92..a9dd3597cfbc 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -9,8 +9,8 @@
 #include <linux/debugfs.h>
 #include <linux/pci.h>
 #include <rdma/ib_addr.h>
+#include <linux/bnxt/ulp.h>
 
-#include "bnxt_ulp.h"
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index df7cf8d68e27..b773556fc5e9 100644
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
index ee36b3d82cc0..bb252cd8509b 100644
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
index 6a13927674b4..7cdddf921b48 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -39,7 +39,7 @@
 #ifndef __BNXT_QPLIB_RES_H__
 #define __BNXT_QPLIB_RES_H__
 
-#include "bnxt_ulp.h"
+#include <linux/bnxt/ulp.h>
 
 extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1d0e0e7362bd..785a6146b968 100644
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
index 02961d93ed35..cfcd3335a2d3 100644
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
index be32ef8f5c96..3231d3c022dc 100644
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
index 80fed2c07b9e..84c43f83193a 100644
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
index 61cf201bb0dc..992eec874345 100644
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


