Return-Path: <linux-rdma+bounces-17208-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFd/LHcFoGl/fQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17208-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:33:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B81A2A07
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B409A30219D9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A93939B3;
	Thu, 26 Feb 2026 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HEdFl7Sa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB893393DDA
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094836; cv=none; b=lHuTHBwEQ6LVNXrSICST7HL8AfhFwlK8n3o5XLB+hmUjAbWSFUT+j4UiCL1/9VHYog+UCHHlCbTWYK5blIZ+kSCPpDPif/pqlHZF/Zn1aD0EjjhoZ0IhnKFWZiknfCWakEkxMZ9E32+4WSkJNYcT2zbcaSD+QOjVRtlcr2koeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094836; c=relaxed/simple;
	bh=+WUzpV3PbPElxR0d/PLjyo4kLJ+uKzOD75MwINZpAmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEnxJAdAkiIKm7Ywb9N8MNa3uywNk7aVoj1cBXwNnDHkdc58vsxkROYREhiFa4+MVky8imdCUHIkz+WZitAKf8FREGZhzCUEyrf235VujxYkzn5J7z99NSRrA5rUKVgykuqEK4bFw4K3F5wZ2zUp24Ek2J4Ja46oFjoTFTsXReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HEdFl7Sa; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c6e5998f90dso203044a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 00:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094834; x=1772699634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aUFXob2xzBSFhsX/0qnIN28cjguocYoYmX9AhWUVHs=;
        b=r/wNKcChSxeKwR4OyE6CZEN2cfuiCmZlgU0rxpVS0QYHtNvDnlka3k7mlY9Tw7qhv4
         C5Se4JjNSd1XfpBC/eaSng/GnD+80KkI6uJojDdjVQA0kOWSrgL60Di6JOVdVkT4KaAV
         pO/Qx3nq23mgrMnoHm89OZB60sYV1mc/4Xt1DFhnj4A81hAQ9i/mQY+5hQXjZ6x/DARA
         ouUbFFXONOTzrrCS9OJONiTkZ8/VF80/gAJMhrVbxG7g4f5i/ouXZxuCsqqywxF+PF75
         NMAirK7rSgo+SaCDSa5Y7hQuPhoA0HkTI1DQ85jiXoLl5xgj+ZslOhMmuHWln5xAP+Mf
         fN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7pntRIRUD3MkDBMj0tiVgfvrwc82hj1jCS4WUtmtR6aVkYVXkBzN3PLOMJES0sM/e4X7eOQW2pYQN@vger.kernel.org
X-Gm-Message-State: AOJu0YxudtTnup4k+tu3ohjB49kqjrNtnoOJSwzAgAqD5wMGv+ZK6T2I
	7GHiqQKg2iFetCjPNs/OfiV91NjVShGbSRnq+cR7WmyJXJcVD/peRXZo9EKv0zm34Qg9JYcZkpe
	Ul2OjwPgS2CkQbakrJ/vRmOQur2PdrNvR9A2JlnhXlZuAtG5IKUJLIjDh/pNeFiWJhYhYh6cr/0
	IdWrow4fMeCfxNloC/YPI4BBgRmspAZoks+IdAQIoYzj6aSIk/YmBSDebglsrmh4oDG0Ks/FMI8
	PGCrjkUtwdH9VwbwvA=
X-Gm-Gg: ATEYQzyA7pHoMywBbyxoDDdqyUrfEX5383HtxrcYo4MyxBXt8FaLrIuivqTzTRCbNZW
	5QTucGtQ7Jn0Bga+GFc6vyyfKj14YxdVpQbGfS0bZ49aPu/7gmdLITpkjWgDZoBSMIBtKUrk1rH
	V8CuoQOQfigo2EXJGkjJJW1rP5VgNgSeWWEQgsQNn4te0QdLa166pGHjYQ/4u0voD14kFEFomJa
	NBXCBezRNuEgeOwagTms6ryBeMr0Juj7aW83sZkfjolYx7zvvNSq2k7Da2INbN25oanDbz6zdqz
	odHmfRhGxXSeYySjRfNdtJ02tY0PvqB3QIal6WgwMJaO+u1/KJBLhwW15XCKXwrsIPNISq3IWvr
	5rbiZ5vVPevd6AH1/VridOtzjOlyq17uKR8H35xn7sJ28ds+h5OjnLEd/Jl8FZakDcRagucHjcr
	GVEhAWM3Y/faUG2vwNtI9K6TCAuAiFeSb1XEHvKb5HRcQ1v4Wu6hVNNkmwarw=
X-Received: by 2002:a17:90b:388c:b0:356:7b41:d355 with SMTP id 98e67ed59e1d1-3593dab83f5mr1494054a91.1.1772094834034;
        Thu, 26 Feb 2026 00:33:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35900db9555sm718465a91.2.2026.02.26.00.33.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 00:33:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6e78c4aa50so364968a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772094832; x=1772699632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aUFXob2xzBSFhsX/0qnIN28cjguocYoYmX9AhWUVHs=;
        b=HEdFl7SaC78TY+dSIkXdzSZPvIMqcjOC9c57zfVcYJc6qU/3KDA4uTKY0TAkVsT6UA
         z1ZSlkglMW0KQZ+h8W9SFodYAL6X+vrX/z/jxUAEg0C7pwzPcY0yeQreoeWjp91jmgY8
         PBVGM/mZQjPXrXlR5+W+75AgjrFC0Xe3/6Drc=
X-Forwarded-Encrypted: i=1; AJvYcCV2mlRyTxxBAXMng3F4lOGXx0QhJiLOrShqLs2XBDwH4xQ0UoJyzM8p4g94fmGrcke00Wh62NVqZnPt@vger.kernel.org
X-Received: by 2002:aa7:8884:0:b0:823:f96:63bb with SMTP id d2e1a72fcca58-8273c077551mr1657038b3a.52.1772094831910;
        Thu, 26 Feb 2026 00:33:51 -0800 (PST)
X-Received: by 2002:aa7:8884:0:b0:823:f96:63bb with SMTP id d2e1a72fcca58-8273c077551mr1657014b3a.52.1772094831431;
        Thu, 26 Feb 2026 00:33:51 -0800 (PST)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c9b5sm1661613b3a.9.2026.02.26.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:33:50 -0800 (PST)
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
Subject: [PATCH v5 fwctl 1/5] fwctl/bnxt_en: Move common definitions to include/linux/bnxt/
Date: Thu, 26 Feb 2026 00:23:14 -0800
Message-Id: <20260226082318.525518-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260226082318.525518-1-pavan.chebbi@broadcom.com>
References: <20260226082318.525518-1-pavan.chebbi@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17208-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C3B81A2A07
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


