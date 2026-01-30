Return-Path: <linux-rdma+bounces-16259-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIXFIgPhfGmpPAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16259-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 17:49:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02295BCA22
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 17:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFDB1300DA77
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B7335093;
	Fri, 30 Jan 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TSD1XAks"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B02FCBE3
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791742; cv=none; b=mdGwr0z6b5EpzbG8fY9Ub7QC7Zf5hcYyWbfFF6775IBtkL618ljhrro2eL+gCLpMRBRI7ZBKy9BaZpc05+mm4qL98nhSgkIsB6t1m3Wuq0V3ifuq1EpOpdlakwW/oYh9syS5Xw8AkOgCbzIAAui/c+ITokfPnNUdEMyTI/bPK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791742; c=relaxed/simple;
	bh=+WUzpV3PbPElxR0d/PLjyo4kLJ+uKzOD75MwINZpAmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEnfFis05xKQTtiWM+haVV3sDnNZSKzOPbJDARkoVv/VpHNJXLSWJUQ3Vu3fXo0kUrfgLoy0mJo0gZgwee1DFHYLEydN2gzI85BAI7rjtg5rOBhLWk+AqnnUaRotJF030y4fObzZpvfzS4NrTbEIm0y36u/vs3LqCucOkA2i6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TSD1XAks; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8947ddce09fso18732446d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 08:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769791739; x=1770396539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aUFXob2xzBSFhsX/0qnIN28cjguocYoYmX9AhWUVHs=;
        b=ly7eqA/YQWfxZyANQNFdRx0Fp5EUH5uo+l4pwuaT6m8OOUI06i+ChrAYUhdWGubf3j
         g3y/Jq0RNbFf+8r5nwamFndjvPeZX4TdLm9ZAap7w7PK61p8JZrRYRitbVjKVkC/O6UI
         TgLI/NTYL3amo5UlCp+72ZiJEkCLHk2kRUQ7IogwP9Z/y+fQwLEJ2dku1zCDZ0LNmgue
         azRkXsOq9FsPtnmpUKoYXG5LT0vfXNXt1U+c5o2EgNk9Sc6AksB3J8ru19+aFg7tCMVA
         OAtf5oLJiK//FJTRy2tsN/3qhBy8+ItaPpmqHlp0z9WYLtw/ldEX0MIn/z/6VJ8uo4FQ
         ampg==
X-Forwarded-Encrypted: i=1; AJvYcCUoJbZw4k+Gyu5cUWvgDw4oudxQfn8YiqmDaAUsu8JApqJGOKwhF2feBEqx3Kjsdb5+Hqq8tc48OzhO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mPhBHFgHz5y/AyxEyLGBhv4ytHQigXmlyW7MvsoFAkkq+TpS
	CafZQSmNKMSULAyWnYn5GwVHSIasOFjtjdh/VH5ZHByJL1FadiQojuem/kK0Vd4A+UgaCUAj98l
	R9BETH7bGkDXBtHC7vX5Cp1nDxiO9d7u5Iqk3MLEoFFzhlwcPNkvtJz3/LBj9q4SSOVL6uxzlOh
	82H/9qfETE8R2RSrssUu+zi1bVCwIwHWzrDWrX3KStyJ+x9uEohAz0I+zZXf97b6XALQ/f4GZPi
	m5ckcPuumQ8jQYo
X-Gm-Gg: AZuq6aJ7CnewSyvgYqTyHjRdGzDv3YCKcT9FLRLfNvGFZfkUkj544JeJ9cVDYImg6m1
	lHp127aEa6Gte5Z1mCm6XG+6OTwiB+m/pc24kZPNSWG62WEkPi8YT62nMqxqxVuHgRJRs1A4/jT
	QVaJq0F+d8UF6qz1+fjQAlYqBRvp9UyZsKyrG3kbjJsHCS1dveZ2ClRUqEqoXhTNEnXbokbB8RX
	Eamas4+IV03Hjo5OskDVdoaCgzxWUq/oudhB9wp4UFeIbtzyrX4nZTvsHdf6TxP1PU8aI7qgE6L
	5enYXjQQdy67fcnYbFR4IBVxHGIw9FsTnY09BHxEJYAGeiKMZ9YSn5+S9I8lby9LFHr61Hq3rFT
	SBUnX9+MhvDUccqtMHLzGfaUtUJvsZFQpBuQd2mhiIyEsqNznU4NQEY1sGc9iBnp3Vai90qFNS0
	tryTQ6Ho7XGS2vMqk2iCreGGrLWpReF/IwJgxt/aqF6g==
X-Received: by 2002:a05:6214:27c9:b0:890:7329:4cc8 with SMTP id 6a1803df08f44-894e9f42dd9mr47839096d6.8.1769791739332;
        Fri, 30 Jan 2026 08:48:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d36a9edcsm11210306d6.3.2026.01.30.08.48.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jan 2026 08:48:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0e952f153so59974475ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 08:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769791738; x=1770396538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aUFXob2xzBSFhsX/0qnIN28cjguocYoYmX9AhWUVHs=;
        b=TSD1XAks+UMqSiOW2uz9/cBbOvHNp9dYb5h+vkzc1cnK7QsgDMvc4Fe6yvklzmhKD/
         MTUV34UxOq6BunfKnPt8N3QGJm4m4BDKalQ1N6feVBgXymjaRnQcB9OPoywTPQiELUx7
         J4/Hw9LdUVNcZB3oQ3aIfGRsmdKr8UBuHsnNE=
X-Forwarded-Encrypted: i=1; AJvYcCVvii8WdSv3uyU60uXvacgqpWBNwL0+a3BlVBmGg1BaGde7JY+8jPvSxfsakInjoEVEMA6g1F9UWGLk@vger.kernel.org
X-Received: by 2002:a17:903:388e:b0:295:596f:8507 with SMTP id d9443c01a7336-2a8d89464b3mr41442245ad.0.1769791738071;
        Fri, 30 Jan 2026 08:48:58 -0800 (PST)
X-Received: by 2002:a17:903:388e:b0:295:596f:8507 with SMTP id d9443c01a7336-2a8d89464b3mr41441935ad.0.1769791737656;
        Fri, 30 Jan 2026 08:48:57 -0800 (PST)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm80193085ad.79.2026.01.30.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:48:57 -0800 (PST)
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
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH v4 fwctl 1/5] fwctl/bnxt_en: Move common definitions to include/linux/bnxt/
Date: Fri, 30 Jan 2026 08:41:42 -0800
Message-Id: <20260130164146.3752166-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260130164146.3752166-1-pavan.chebbi@broadcom.com>
References: <20260130164146.3752166-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16259-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 02295BCA22
X-Rspamd-Action: no action

We have common definitions that are now going to be used
by more than one component outside of bnxt (bnxt_re and
fwctl)

Move bnxt_ulp.h to include/linux/bnxt/ as ulp.h.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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


