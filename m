Return-Path: <linux-rdma+bounces-20790-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLCLBvihB2rP/QIAu9opvQ
	(envelope-from <linux-rdma+bounces-20790-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 00:45:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E59559014
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 00:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E65FA300AB0F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 22:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120853CEB8F;
	Fri, 15 May 2026 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9szwV7h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA0346E6D;
	Fri, 15 May 2026 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885107; cv=none; b=IKGY1orgRGAYWxtil8dgk6PiBGEcObem7mU6OZVDlLNpIfQ+Gt6yC2c5gnIUZccgdY0UY6QyQsAAJAu8nTlPE0hV4o7Y/wp23kTvaPOJlWaRLqa9YWiyVvg870zDUSbOxLXJ8CdOZ2SqI/TxTm6nOZ2Wt1YU/m6RnvVP8ExC6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885107; c=relaxed/simple;
	bh=pvweI+lBh/0POXwvPs5b2Ow91qM++ncUtB8qXSRwzUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qToOABBjAnPxsvcoGt8VO8hepgyhuhv24R+c3i+2r1rLtUcYXuijzjvrWmMVEQxd5RrvAeUZXvLBU6VaKQqbGjev/5B8IDkj4A/IsmMLp48XdsMmn/oQX+CdWK75fX/330HhCdRJIDXH0bPMAaaMkGMJtDD2vxEf+47bBHaS4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9szwV7h; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778885105; x=1810421105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pvweI+lBh/0POXwvPs5b2Ow91qM++ncUtB8qXSRwzUc=;
  b=S9szwV7hUK5Bm0vPT1TfmimRriIrzxd29a3aA40rKG2ZqN1zjtNsqN3A
   tEGzoSWPDoDBhZyn1TbIGe+3W1e7SP/tWzJfH5ZdpVVOi7PpuH+yeAvxn
   qxaA3TLkMxnVo92DqWaNVBUrK0wENuF8vOchLSHDEknCw8zy3J1U6XHgo
   fbp0ht9J13oSuaovaUKV62aSe5O4NHw5uq5Bq4Ty7GPJ83e3IUoGC+hfe
   bmO/4u/3Hjdpu7VU205V5QzrUTr5rzdnIY0KTBf6iSlSd5pChrlUNzZSF
   if0WudPz1h9Scq6BtxEKP7cNFCmys2L529YwBGJYk/tAXCOG06VFeuNjJ
   g==;
X-CSE-ConnectionGUID: uFU6vNp0R06XnoWipoqJrw==
X-CSE-MsgGUID: n77lfWZcSnSLeq03ICkMxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90949157"
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="90949157"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 15:45:03 -0700
X-CSE-ConnectionGUID: cwQkuONcTIm8BunVGM4icg==
X-CSE-MsgGUID: gOx4iFOLS6SSS7qNrlYaxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="243146621"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 15 May 2026 15:45:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Victor Raj <anthony.l.nguyen@intel.com>,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v3 01/14] virtchnl: create 'include/linux/intel' and move necessary header files
Date: Fri, 15 May 2026 15:44:25 -0700
Message-ID: <20260515224443.2772147-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0E59559014
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20790-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Victor Raj <victor.raj@intel.com>

include/linux/net houses a single folder "intel", meanwhile
include/linux/intel is vacant. On top of that, it would be useful to place
all iavf headers together with other intel networking headers,
same goes for virtchnl2 headers which will be used by both idpf and ixd
drivers.

Move abovementioned intel header files into new folder include/linux/intel.
Also, assign new folder to both intel and general networking maintainers.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 MAINTAINERS                                                 | 6 +++---
 drivers/infiniband/hw/irdma/i40iw_if.c                      | 2 +-
 drivers/infiniband/hw/irdma/icrdma_if.c                     | 2 +-
 drivers/infiniband/hw/irdma/ig3rdma_if.c                    | 2 +-
 drivers/infiniband/hw/irdma/main.c                          | 2 +-
 drivers/infiniband/hw/irdma/main.h                          | 2 +-
 drivers/net/ethernet/intel/i40e/i40e.h                      | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h           | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c               | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c               | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c              | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c                 | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h            | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                 | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h                 | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h          | 2 +-
 drivers/net/ethernet/intel/iavf/iavf.h                      | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h           | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c               | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c                 | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h            | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c                 | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h                 | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h                | 4 +---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c             | 2 +-
 drivers/net/ethernet/intel/ice/ice.h                        | 2 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h             | 2 +-
 drivers/net/ethernet/intel/ice/ice_base.c                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_common.h                 | 2 +-
 drivers/net/ethernet/intel/ice/ice_flow.h                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_idc_int.h                | 4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c               | 2 +-
 drivers/net/ethernet/intel/ice/ice_type.h                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                 | 2 +-
 drivers/net/ethernet/intel/ice/virt/virtchnl.h              | 2 +-
 drivers/net/ethernet/intel/idpf/idpf.h                      | 6 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                 | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h             | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h               | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h          | 2 +-
 drivers/net/ethernet/intel/libie/adminq.c                   | 2 +-
 drivers/net/ethernet/intel/libie/fwlog.c                    | 2 +-
 drivers/net/ethernet/intel/libie/rx.c                       | 2 +-
 include/linux/{net => }/intel/i40e_client.h                 | 0
 include/linux/{net => }/intel/iidc_rdma.h                   | 0
 include/linux/{net => }/intel/iidc_rdma_ice.h               | 0
 include/linux/{net => }/intel/iidc_rdma_idpf.h              | 0
 include/linux/{net => }/intel/libie/adminq.h                | 0
 include/linux/{net => }/intel/libie/fwlog.h                 | 2 +-
 include/linux/{net => }/intel/libie/pctype.h                | 0
 include/linux/{net => }/intel/libie/rx.h                    | 0
 include/linux/{avf => intel}/virtchnl.h                     | 0
 .../ethernet/intel/idpf => include/linux/intel}/virtchnl2.h | 0
 .../intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h | 0
 55 files changed, 52 insertions(+), 54 deletions(-)
 rename include/linux/{net => }/intel/i40e_client.h (100%)
 rename include/linux/{net => }/intel/iidc_rdma.h (100%)
 rename include/linux/{net => }/intel/iidc_rdma_ice.h (100%)
 rename include/linux/{net => }/intel/iidc_rdma_idpf.h (100%)
 rename include/linux/{net => }/intel/libie/adminq.h (100%)
 rename include/linux/{net => }/intel/libie/fwlog.h (98%)
 rename include/linux/{net => }/intel/libie/pctype.h (100%)
 rename include/linux/{net => }/intel/libie/rx.h (100%)
 rename include/linux/{avf => intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index edd161f2c62d..f002b08709e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12906,8 +12906,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
 F:	Documentation/networking/device_drivers/ethernet/intel/
 F:	drivers/net/ethernet/intel/
 F:	drivers/net/ethernet/intel/*/
-F:	include/linux/avf/virtchnl.h
-F:	include/linux/net/intel/*/
+F:	include/linux/intel/
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
 M:	Krzysztof Czurylo <krzysztof.czurylo@intel.com>
@@ -14661,7 +14660,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/alobakin/linux.git
 F:	drivers/net/ethernet/intel/libie/
-F:	include/linux/net/intel/libie/
+F:	include/linux/intel/libie/
 K:	libie
 
 LIBNVDIMM BTT: BLOCK TRANSLATION TABLE
@@ -18480,6 +18479,7 @@ F:	include/linux/fcdevice.h
 F:	include/linux/fddidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
+F:	include/linux/intel/
 F:	include/linux/netdev*
 F:	include/linux/platform_data/wiznet.h
 F:	include/uapi/linux/cn_proc.h
diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index 4ff3ad7856aa..b084c01714ee 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 #include "i40iw_hw.h"
-#include <linux/net/intel/i40e_client.h>
+#include <linux/intel/i40e_client.h>
 
 static struct i40e_client i40iw_client;
 
diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 2172a2092e3f..3f37029acdd3 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2015 - 2024 Intel Corporation */
 
 #include "main.h"
-#include <linux/net/intel/iidc_rdma_ice.h>
+#include <linux/intel/iidc_rdma_ice.h>
 
 static void icrdma_prep_tc_change(struct irdma_device *iwdev)
 {
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_if.c b/drivers/infiniband/hw/irdma/ig3rdma_if.c
index b3e49e5bef10..035b421f0934 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_if.c
+++ b/drivers/infiniband/hw/irdma/ig3rdma_if.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2023 - 2024 Intel Corporation */
 
 #include "main.h"
-#include <linux/net/intel/iidc_rdma_idpf.h>
+#include <linux/intel/iidc_rdma_idpf.h>
 #include "ig3rdma_hw.h"
 
 static void ig3rdma_idc_core_event_handler(struct iidc_rdma_core_dev_info *cdev_info,
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 95957d52883d..9781699ad57c 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
-#include <linux/net/intel/iidc_rdma_idpf.h>
+#include <linux/intel/iidc_rdma_idpf.h>
 
 MODULE_ALIAS("i40iw");
 MODULE_DESCRIPTION("Intel(R) Ethernet Protocol Driver for RDMA");
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 3d49bd57bae7..9936eae528ba 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -30,7 +30,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #endif
 #include <linux/auxiliary_bus.h>
-#include <linux/net/intel/iidc_rdma.h>
+#include <linux/intel/iidc_rdma.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 83e780919ac9..935fcd3e7349 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -8,8 +8,8 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
-#include <linux/avf/virtchnl.h>
-#include <linux/net/intel/i40e_client.h>
+#include <linux/intel/virtchnl.h>
+#include <linux/intel/i40e_client.h>
 #include <net/devlink.h>
 #include <net/pkt_cls.h>
 #include <net/udp_tunnel.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index cc02a85ad42b..e70f0aa728b1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_ADMINQ_CMD_H_
 #define _I40E_ADMINQ_CMD_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 #include <linux/bits.h>
 #include <linux/types.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 84a97ca8a6d8..b6cf1f666c89 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -3,7 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/errno.h>
-#include <linux/net/intel/i40e_client.h>
+#include <linux/intel/i40e_client.h>
 
 #include "i40e.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 59f5c1e810eb..dab9dfcf7bda 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec49cc74..94e6d411e6b8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3,7 +3,7 @@
 
 /* ethtool support for i40e */
 
-#include <linux/net/intel/libie/pctype.h>
+#include <linux/intel/libie/pctype.h>
 #include "i40e_devids.h"
 #include "i40e_diag.h"
 #include "i40e_txrx_common.h"
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..42586e61cedb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3,7 +3,7 @@
 
 #include <generated/utsrelease.h>
 #include <linux/crash_dump.h>
-#include <linux/net/intel/libie/pctype.h>
+#include <linux/intel/libie/pctype.h>
 #include <linux/if_bridge.h>
 #include <linux/if_macvlan.h>
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 26bb7bffe361..9d0cd6aabdcb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -5,7 +5,7 @@
 #define _I40E_PROTOTYPE_H_
 
 #include <linux/ethtool.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "i40e_debug.h"
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 894f2d06d39d..4ffdb007c41a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2,8 +2,8 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
-#include <linux/net/intel/libie/pctype.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/pctype.h>
+#include <linux/intel/libie/rx.h>
 #include <linux/prefetch.h>
 #include <linux/sctp.h>
 #include <net/mpls.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 1e5fd63d47f4..e630493e9139 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_TXRX_H_
 #define _I40E_TXRX_H_
 
-#include <linux/net/intel/libie/pctype.h>
+#include <linux/intel/libie/pctype.h>
 #include <net/xdp.h>
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index f558b45725c8..a03ecddfb956 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -4,7 +4,7 @@
 #ifndef _I40E_VIRTCHNL_PF_H_
 #define _I40E_VIRTCHNL_PF_H_
 
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/netdevice.h>
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 050f8241ef5e..1a1a66b3311e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -37,7 +37,7 @@
 #include <net/net_shaper.h>
 
 #include "iavf_type.h"
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "iavf_txrx.h"
 #include "iavf_fdir.h"
 #include "iavf_adv_rss.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h b/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
index 0482c9ce9b9c..12e84e1e971b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h
@@ -4,7 +4,7 @@
 #ifndef _IAVF_ADMINQ_CMD_H_
 #define _IAVF_ADMINQ_CMD_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 /* This header file defines the iavf Admin Queue commands and is shared between
  * iavf Firmware and Software.
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 614a886bca99..9bc8bdc339c7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/bitfield.h>
 #include "iavf_type.h"
 #include "iavf_adminq.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8b53ffb75650..52efeaace7f8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include <net/netdev_lock.h>
 
 #include "iavf.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 7f9f9dbf959a..a3348b063723 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -6,7 +6,7 @@
 
 #include "iavf_type.h"
 #include "iavf_alloc.h"
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 363c42bf3dcf..275b11dd0c60 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/bitfield.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include <linux/prefetch.h>
 
 #include "iavf.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index df49b0b1d54a..bc8a6068461d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -4,7 +4,7 @@
 #ifndef _IAVF_TXRX_H_
 #define _IAVF_TXRX_H_
 
-#include <linux/net/intel/libie/pctype.h>
+#include <linux/intel/libie/pctype.h>
 
 /* Interrupt Throttling and Rate Limiting Goodies */
 #define IAVF_DEFAULT_IRQ_WORK      256
diff --git a/drivers/net/ethernet/intel/iavf/iavf_types.h b/drivers/net/ethernet/intel/iavf/iavf_types.h
index a095855122bf..270bc35f933d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_types.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_types.h
@@ -4,9 +4,7 @@
 #ifndef _IAVF_TYPES_H_
 #define _IAVF_TYPES_H_
 
-#include "iavf_types.h"
-
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/ptp_clock_kernel.h>
 
 /* structure used to queue PTP commands for processing */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4f2defd2331b..a4ad3880e00f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 
 #include "iavf.h"
 #include "iavf_ptp.h"
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 725b130dd3a2..804f5aa8e9f5 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -36,7 +36,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/auxiliary_bus.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 3cbb1b0582e3..eeffbcf9480d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -4,7 +4,7 @@
 #ifndef _ICE_ADMINQ_CMD_H_
 #define _ICE_ADMINQ_CMD_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 /* This header file defines the Admin Queue commands, error codes and
  * descriptor format. It is shared between Firmware and Software.
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..957280613e02 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2019, Intel Corporation. */
 
 #include <net/xdp_sock_drv.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include "ice_base.h"
 #include "ice_lib.h"
 #include "ice_dcb_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e700ac0dc347..ff6393e9be0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -11,7 +11,7 @@
 #include "ice_nvm.h"
 #include "ice_flex_pipe.h"
 #include "ice_parser.h"
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "ice_switch.h"
 #include "ice_fdir.h"
 
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index 6c6cdc8addb1..7323e26afc0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -4,7 +4,7 @@
 #ifndef _ICE_FLOW_H_
 #define _ICE_FLOW_H_
 
-#include <linux/net/intel/libie/pctype.h>
+#include <linux/intel/libie/pctype.h>
 
 #include "ice_flex_type.h"
 #include "ice_parser.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 17dbfcfb6a2a..abe91f313441 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -4,8 +4,8 @@
 #ifndef _ICE_IDC_INT_H_
 #define _ICE_IDC_INT_H_
 
-#include <linux/net/intel/iidc_rdma.h>
-#include <linux/net/intel/iidc_rdma_ice.h>
+#include <linux/intel/iidc_rdma.h>
+#include <linux/intel/iidc_rdma_ice.h>
 
 struct ice_pf;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4ca1a0602307..5bd540972ace 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -7,7 +7,7 @@
 #include <linux/netdevice.h>
 #include <linux/prefetch.h>
 #include <linux/bpf_trace.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include <net/libeth/xdp.h>
 #include <net/dsfield.h>
 #include <net/mpls.h>
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..66d211aa0833 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2019, Intel Corporation. */
 
 #include <linux/filter.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 #include <net/libeth/xdp.h>
 
 #include "ice_txrx_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1e82f4c40b32..6e6dd0aa515e 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -17,7 +17,7 @@
 #include "ice_protocol_type.h"
 #include "ice_sbq_cmd.h"
 #include "ice_vlan_mode.h"
-#include <linux/net/intel/libie/fwlog.h>
+#include <linux/intel/libie/fwlog.h>
 #include <linux/wait.h>
 #include <net/dscp.h>
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 7a9c75d1d07c..c520e22e3d0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -10,7 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <net/devlink.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "ice_type.h"
 #include "ice_flow.h"
 #include "virt/fdir.h"
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.h b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
index 71bb456e2d71..f7f909424098 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
-#include <linux/avf/virtchnl.h>
+#include <linux/intel/virtchnl.h>
 #include "ice_vf_lib.h"
 
 /* Restrict number of MAC Addr and VLAN that non-trusted VF can programmed */
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ec1b75f039bb..3a3dc9892d16 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -21,10 +21,10 @@ struct idpf_rss_data;
 #include <linux/ethtool_netlink.h>
 #include <net/gro.h>
 
-#include <linux/net/intel/iidc_rdma.h>
-#include <linux/net/intel/iidc_rdma_idpf.h>
+#include <linux/intel/iidc_rdma.h>
+#include <linux/intel/iidc_rdma_idpf.h>
+#include <linux/intel/virtchnl2.h>
 
-#include "virtchnl2.h"
 #include "idpf_txrx.h"
 #include "idpf_controlq.h"
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..e101ffb20ae0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -13,7 +13,7 @@
 #include <net/xdp.h>
 
 #include "idpf_lan_txrx.h"
-#include "virtchnl2_lan_desc.h"
+#include <linux/intel/virtchnl2_lan_desc.h>
 
 #define IDPF_LARGE_MAX_Q			256
 #define IDPF_MAX_Q				16
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6876e3ed9d1b..6992b768cef4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -4,7 +4,7 @@
 #ifndef _IDPF_VIRTCHNL_H_
 #define _IDPF_VIRTCHNL_H_
 
-#include "virtchnl2.h"
+#include <linux/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
 #define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index a461b6542f96..593fc62a38ee 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/mdio.h>
 #include <linux/netdevice.h>
-#include <linux/net/intel/libie/fwlog.h>
+#include <linux/intel/libie/fwlog.h>
 #include "ixgbe_type_e610.h"
 
 /* Device IDs */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 959cacecae49..4b18241450b8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -4,7 +4,7 @@
 #ifndef _IXGBE_TYPE_E610_H_
 #define _IXGBE_TYPE_E610_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 #define BYTES_PER_DWORD	4
 
diff --git a/drivers/net/ethernet/intel/libie/adminq.c b/drivers/net/ethernet/intel/libie/adminq.c
index 7b4ff479e7e5..5a3ea8eb45c2 100644
--- a/drivers/net/ethernet/intel/libie/adminq.c
+++ b/drivers/net/ethernet/intel/libie/adminq.c
@@ -2,7 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include <linux/module.h>
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 static const char * const libie_aq_str_arr[] = {
 #define LIBIE_AQ_STR(x)					\
diff --git a/drivers/net/ethernet/intel/libie/fwlog.c b/drivers/net/ethernet/intel/libie/fwlog.c
index 96bba57c8a5b..0af13f6eabaa 100644
--- a/drivers/net/ethernet/intel/libie/fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -4,7 +4,7 @@
 #include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/fs.h>
-#include <linux/net/intel/libie/fwlog.h>
+#include <linux/intel/libie/fwlog.h>
 #include <linux/pci.h>
 #include <linux/random.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index 6fda656afa9c..e163b8a66aea 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -4,7 +4,7 @@
 #define DEFAULT_SYMBOL_NAMESPACE	"LIBIE"
 
 #include <linux/export.h>
-#include <linux/net/intel/libie/rx.h>
+#include <linux/intel/libie/rx.h>
 
 /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
  * bitfield struct.
diff --git a/include/linux/net/intel/i40e_client.h b/include/linux/intel/i40e_client.h
similarity index 100%
rename from include/linux/net/intel/i40e_client.h
rename to include/linux/intel/i40e_client.h
diff --git a/include/linux/net/intel/iidc_rdma.h b/include/linux/intel/iidc_rdma.h
similarity index 100%
rename from include/linux/net/intel/iidc_rdma.h
rename to include/linux/intel/iidc_rdma.h
diff --git a/include/linux/net/intel/iidc_rdma_ice.h b/include/linux/intel/iidc_rdma_ice.h
similarity index 100%
rename from include/linux/net/intel/iidc_rdma_ice.h
rename to include/linux/intel/iidc_rdma_ice.h
diff --git a/include/linux/net/intel/iidc_rdma_idpf.h b/include/linux/intel/iidc_rdma_idpf.h
similarity index 100%
rename from include/linux/net/intel/iidc_rdma_idpf.h
rename to include/linux/intel/iidc_rdma_idpf.h
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/intel/libie/adminq.h
similarity index 100%
rename from include/linux/net/intel/libie/adminq.h
rename to include/linux/intel/libie/adminq.h
diff --git a/include/linux/net/intel/libie/fwlog.h b/include/linux/intel/libie/fwlog.h
similarity index 98%
rename from include/linux/net/intel/libie/fwlog.h
rename to include/linux/intel/libie/fwlog.h
index 7273c78c826b..de3d7e89b768 100644
--- a/include/linux/net/intel/libie/fwlog.h
+++ b/include/linux/intel/libie/fwlog.h
@@ -4,7 +4,7 @@
 #ifndef _LIBIE_FWLOG_H_
 #define _LIBIE_FWLOG_H_
 
-#include <linux/net/intel/libie/adminq.h>
+#include <linux/intel/libie/adminq.h>
 
 /* Only a single log level should be set and all log levels under the set value
  * are enabled, e.g. if log level is set to LIBIE_FW_LOG_LEVEL_VERBOSE, then all
diff --git a/include/linux/net/intel/libie/pctype.h b/include/linux/intel/libie/pctype.h
similarity index 100%
rename from include/linux/net/intel/libie/pctype.h
rename to include/linux/intel/libie/pctype.h
diff --git a/include/linux/net/intel/libie/rx.h b/include/linux/intel/libie/rx.h
similarity index 100%
rename from include/linux/net/intel/libie/rx.h
rename to include/linux/intel/libie/rx.h
diff --git a/include/linux/avf/virtchnl.h b/include/linux/intel/virtchnl.h
similarity index 100%
rename from include/linux/avf/virtchnl.h
rename to include/linux/intel/virtchnl.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/include/linux/intel/virtchnl2.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2.h
rename to include/linux/intel/virtchnl2.h
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h b/include/linux/intel/virtchnl2_lan_desc.h
similarity index 100%
rename from drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h
rename to include/linux/intel/virtchnl2_lan_desc.h
-- 
2.47.1


