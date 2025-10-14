Return-Path: <linux-rdma+bounces-13855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE172BD8172
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1951921DC8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4655E30F555;
	Tue, 14 Oct 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TcHYuTsS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53630F550
	for <linux-rdma@vger.kernel.org>; Tue, 14 Oct 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429055; cv=none; b=i331hhTrTtEJ8MgLf7mYGao2xA944woGWNXfvcsjVZzs/QvulNb310esV7R++InmWOjrmRqzan9ZxjKTbBOtnQHZQkr80Vd2ycyeVtR0vxycwZK5FTbbL+9XwIW13Wdy38S6aHhk9AyR9nmBM8a4/XS3EBaG0QG5Mzc+sNbqclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429055; c=relaxed/simple;
	bh=eXT6M1f/uIPzBBkvssFzqVr/aymVHDldyCzP/GjWdOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNOSMhuGRcUSk9+RMkwvoX+lRyLh/x7ihT0U3J9Sb65XuII/Zy/WqBmGeGdMmvfZoZgBW9Bt7xybUQF17M54oBxiPYgK7wqkwcdt8prGu+DmjX/mTfuWomd+rKrqx6WPbrtm/HPLVMTVaBjzMZeJUmR+lYar64fUctQWyolo1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TcHYuTsS; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b63148d25c3so3310680a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Oct 2025 01:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429053; x=1761033853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g24KueK7AUw6ZvKugnBgLNWEy9JBUuV/fSDetxtx368=;
        b=F4ujI2vOEx+BIbjzdgYwBvxNewXoPNXywETH/qlkw5yFDCuWrPi9KEbOLk9I6+DjyW
         glcsrHjXpMZR1q16MuJ3tJoK40xMpWe3s4yjLwNPSTjKQGHDjZVKf1osGRCCbaQ6M7+A
         BkSMKqDbpUsSnf5uGM252fqfPx47XlAH4DUtszi6B3S9tIto5eqKlcRnQ4LPLsZfdZOf
         Bzdj5hDKhBL36PDEtnfo3Hk1Ya4J5zN1immN3QkgfC9IViJ2OGPaGl31A61TOpAklrC2
         KHZFh2iLqm9A2h1Dr5vQ6dEPeIwhox/PYsbe+wNCpsL20NC4M+6gihcOseAPD7k7TJXW
         P7aw==
X-Forwarded-Encrypted: i=1; AJvYcCXFQqsylx1PIRFFoxCzJWlVUs+Oia/Z2mRZIh/QEJzhvO7H6k0u0vWvglEaoi8VHvL3bpLNrPjO3tCJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfw2KBg2R+44L5/iaVOZvVdj+zbUkA0CC1LyHS0gowOhBpqYYU
	a5P5XpE7SnpZbohIEoGmOfmx/fqs41tn2n+T2ulygERx0ureZQYLJkJrH3Sx9MQKfzG/4XsrCjj
	mll5tySY/nFD5fbHq/R+h9+VevfkDLh8SBvL2u5cDVn53jPnmjp+1mB+IlQwCAeMfWivZQpZ45p
	jOZAZRfWPD6TOBYAgiOE/+Ipmx2dHQ0n7Je35woDAd338kJBO/L+0ACLiU5SAVhAmX+fOoOBmcL
	cs5xXEOxZjZLJHJZmU=
X-Gm-Gg: ASbGncuOM5GBVCYO29i53AzPwObFrq3cAG4euxZom5LHuPFhtuh5h+KvwTp5i+UnWoy
	0RhW3b9grPxUBykrS5BVLtGVOfafjUgXbq/7a/mOsVez2o9NP1Bz+nWnm7Xb4OFSqrh5c6bjYC6
	pMxCOSfjKYVv5pDZq1cY6biv7RoQuYQQSlo/qMCMnUURasUeZ4bhwqPwJO8cqI8j0A68BDwmjFS
	i1FswJ5WZQ+FuSvB09hulL7c2Xp/TzO/NnNwysGR0eigML9x485VCvupikB64cYt/e2ZA52ll1h
	wK+eVqX++aElY3ov1qoiDuf+Amr0bN3CXZWDKHO6YyVeNNfGiTeiM6I9zx0PKGYDzvU3BBRlBDX
	yasAUfTc8hs5Xp9hT6JVQ+FCTGoXnNJOGVT3NXQMxh6hZ5kqWD5K6WmrWCTI39TdMx1klUC5dQn
	/+Hg==
X-Google-Smtp-Source: AGHT+IGoAoGY5e2iPQ+Bu+19NkC0fgu8NktjY2V31hr1i9+k4T1LpMGd5ryQJ9wCOjjXvWoFBTZfpxxvphLu
X-Received: by 2002:a17:902:c410:b0:249:71f5:4e5a with SMTP id d9443c01a7336-29027f3e32emr338311665ad.26.1760429052716;
        Tue, 14 Oct 2025 01:04:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29034efa708sm12997995ad.37.2025.10.14.01.04.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:04:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso719864b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Oct 2025 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760429051; x=1761033851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g24KueK7AUw6ZvKugnBgLNWEy9JBUuV/fSDetxtx368=;
        b=TcHYuTsS0bg9HwFfvDRL1aoMCD0Ut+T+RqE3YJgCib4BxAqMQXIxlTX+f9sh7BPTgK
         NZ91pU9zmxJrkEY5LMeWhSacOze5Eqc1/uS9MNYSV/JAB9180+eCLR9kWrFrTKZIFeMV
         Z5zE7GvAsDRjNoRVy7DzCxnr0lcI5mj+fsk/Q=
X-Forwarded-Encrypted: i=1; AJvYcCXD53bU7l1bBXhA0CnOxqvc8V/LLmkwJzJS6Z1d75u3YTascHBvVPvnMhWxhOzY5Oew7o7VQqAhQIRO@vger.kernel.org
X-Received: by 2002:aa7:8291:0:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7922fab2513mr27388903b3a.1.1760429050874;
        Tue, 14 Oct 2025 01:04:10 -0700 (PDT)
X-Received: by 2002:aa7:8291:0:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7922fab2513mr27388879b3a.1.1760429050429;
        Tue, 14 Oct 2025 01:04:10 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a14sm14329716b3a.0.2025.10.14.01.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:04:10 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/5] bnxt_en: Move common definitions to include/linux/bnxt/
Date: Tue, 14 Oct 2025 01:10:29 -0700
Message-Id: <20251014081033.1175053-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
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
index be5e9b5ca2f0..d72c1693c57f 100644
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
index b13810572c2e..0fca523873b8 100644
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
index ce90d3d834d4..9e97d67de1be 100644
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
index 3fc33b1b4dfb..34fef6b15ce1 100644
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
index 41686a6f84b5..818bd0fa0a7d 100644
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
index f8c2c72b382d..56a35c65d193 100644
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


