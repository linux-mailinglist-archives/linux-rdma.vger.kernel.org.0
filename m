Return-Path: <linux-rdma+bounces-18161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJk9DqR+tWmK1AAAu9opvQ
	(envelope-from <linux-rdma+bounces-18161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 16:28:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D1728DAD1
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A8073012539
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5B2E3AEA;
	Sat, 14 Mar 2026 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OX9mmF5M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E02BCF5D
	for <linux-rdma@vger.kernel.org>; Sat, 14 Mar 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502113; cv=none; b=LlXl+4EOoL8nwzGwXSyE72TkVrzxuxDBRUd/+sa9ZxNcktq9b6nD2y1ZRCfSyEfdW/9Lz94XafzINZ92a8NSKi4H+wea7xkLCjxWx9Z5BM2mPkqOD2n63YDKduv2c8twSgfjgCiZDKQC2HRzNrmkt9hgi3dGJfBS+ymArzVSeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502113; c=relaxed/simple;
	bh=+iN1rohm5oTBEN+zBKGTbTVpZAOG58p3+ywcASNGZjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/jFzULxOIG9gF2TpcQeB0NdZZf6cCjTipEepVMYq4+Yqv5HIz/bHWeGFQsJRvOh0IYlQ8bbfZgKFZx/G0+lwwOkbv9ZxIoHls3lQqVPQhvyOmMBrAvnWdQttc1IOT+CA3GBzNS5975lDfpNA4H1ohwWkN+04FhiLc0S1CXTHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OX9mmF5M; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-79495b1aaa7so30483417b3.1
        for <linux-rdma@vger.kernel.org>; Sat, 14 Mar 2026 08:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773502111; x=1774106911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOuPUvwWjW73SQs+yQxWlv6kcLW1ogmfpTTeHiGOcCQ=;
        b=SAu4fy9jzyrf571HTAygiZGsfafpD3Jbkicok++p7iyMFxcvPq9mEA1Z4WN8AenvPe
         uvDUF32aSbX+JoMoGVImNfUGpU1CbqmZKNvPQ1msl20YhuEvVDqP+TeaIWvuPNGfC0u9
         EhczzlXkVwXYs4erhIvT2iUtnOjjRmry6IXMV9VTtPw0ekaMrJsWmMjUoxzn5a10K2tL
         b9SZ7ieqy+VgA9t8V8CBLWgqddMtWhBgro4qUcdG0rKAzsFvfuYmG5j+96njCfTEpv7+
         L5BJPRdXk9VBI0uz+vjCO3pA/54c9Ex214x2FMJzMiLCTcEE2qKZNKe3xCfL4UGK9eiG
         nlzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYDa11EUyGFVN5w6COtkY233xOSTVP2AxbXGm8cI0mlCbsPrJKMU+Hl7uaYZX8zpaApktbIBZqWNkM@vger.kernel.org
X-Gm-Message-State: AOJu0YwZegEe5OG27uDqS/38SfAFl0e3jtwtBIwcT0Oz6uYZ7U49uiGg
	u9sdndW6DVr6ZP6sFuN620LHEKpXHUIvkZVJXDoMMZSmAIchzHkiNU7xfWGi7SM78xUxKCE6/rV
	g19K5ZrPU7oIV6Fj//kSX+Vxahk8ovPepvpV0Pz7OAlohzPT4Tun6BqHQheORaCdhdQOQyWOKMY
	0h9dBAa5HTo8stkhinFx/zr92uJQuipcbFhfmiUZrZRh+GQ6srdtMt9B0JiobUzfPTdMemC1X1O
	Iy5iPXOgTbZdxU9
X-Gm-Gg: ATEYQzy9jUnPv//hvX1Jdcjfn8JHC/AcAABdVtboA3znH5NLAriMjx+wd03eQ6Z/lvW
	FIbctOIN7YalxvvkRT2s4qwCbGpj1mJliRwfEmgTJb+jSFcJWKjBxH1Ojs4oFq9sYibOQpy3KY5
	qnvjmdJwuMSl3iwRkvYkzbKbC2fmuDbL0Yjqfl+qi1br18zbxVCXA1GkxSyeD8u8uK1v56444AA
	VM+2VRwKnYQH8g9uymIMDkcx8H6DfaXLozHmqseQRrgkDWIWGPOqkYbSGS7dzcJSqAf+UZZH4gx
	IgZ2viPXkzzE8Sox67Ak2ezbQwf7vb8KcxaRWzkCWKbK9GiPauTUAqJr+XwLF7BrjTKobnKbLSA
	4ISSzRG6Ppnlw3RBrmRCDD6BMgpfMRmO4h7oHa59S60/M7ZWNkLGOp6vlUfiBOvILHek14NaQ0x
	kqki7+SMdrDKr4rib+m/cFrjpgOLpqnL9qT74S327814KZhuWIjSMg6uTC
X-Received: by 2002:a05:690c:930d:20b0:799:1fa3:c92e with SMTP id 00721157ae682-79a1c090a8emr58162117b3.4.1773502110724;
        Sat, 14 Mar 2026 08:28:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79917edb3c4sm10724777b3.21.2026.03.14.08.28.30
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Mar 2026 08:28:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354490889b6so14107906a91.3
        for <linux-rdma@vger.kernel.org>; Sat, 14 Mar 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773502109; x=1774106909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOuPUvwWjW73SQs+yQxWlv6kcLW1ogmfpTTeHiGOcCQ=;
        b=OX9mmF5M/TfLpca+xxnQW059cfbPbuPx/MVH8e3TxXYJz5Js/GaoJ4GXK3SB+WW7BX
         32A/r9ZmkRIW4voIU6ZNKWbzjcENnUpYR4moIZF6VrF1FF4Hi7ARmH2REpe8qVH2M78b
         AFfgdNH33V1HVVNv5PU4dcMAgn+LFTsqQtnQs=
X-Forwarded-Encrypted: i=1; AJvYcCWEFo+p8tCju6qdnafGenV1+wpy3fc5Sq99Kh3I57kI1c3i8QKfG+WY05LxkeswOr3vlidJB50njz7L@vger.kernel.org
X-Received: by 2002:a05:6a20:c79b:b0:398:9574:a1b1 with SMTP id adf61e73a8af0-398eca12f96mr6424580637.1.1773502109438;
        Sat, 14 Mar 2026 08:28:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:c79b:b0:398:9574:a1b1 with SMTP id adf61e73a8af0-398eca12f96mr6424559637.1.1773502108985;
        Sat, 14 Mar 2026 08:28:28 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb7f2basm4338579a12.29.2026.03.14.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 08:28:28 -0700 (PDT)
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
Subject: [PATCH v6 fwctl 1/5] fwctl/bnxt_en: Move common definitions to include/linux/bnxt/
Date: Sat, 14 Mar 2026 08:16:01 -0700
Message-Id: <20260314151605.932749-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260314151605.932749-1-pavan.chebbi@broadcom.com>
References: <20260314151605.932749-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
	TAGGED_FROM(0.00)[bounces-18161-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: D4D1728DAD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index a2ad79c3bbd0..5fed2cf66be3 100644
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
index b576f05e3b26..47afccddf55e 100644
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
index 2d7932b3c492..b4c7b8f582ba 100644
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
index 9a5dcf97b6f4..0a4a03efeb0b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -39,7 +39,7 @@
 #ifndef __BNXT_QPLIB_RES_H__
 #define __BNXT_QPLIB_RES_H__
 
-#include "bnxt_ulp.h"
+#include <linux/bnxt/ulp.h>
 
 extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c426a41c3663..618c6b66458b 100644
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
index ba47e8294fff..043e872a8880 100644
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
index 7f9829287c49..edcc002e4ca3 100644
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
index e1e82a72cf1b..11ced44ead29 100644
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


