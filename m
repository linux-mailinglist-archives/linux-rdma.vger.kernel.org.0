Return-Path: <linux-rdma+bounces-7465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90EA29988
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3595D3A3C3E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E1201278;
	Wed,  5 Feb 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4hozw0p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD41FF7CD;
	Wed,  5 Feb 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781729; cv=none; b=enNwLGnQ2XzJcVxn38qcmqsp0VhSti5YlGmw6qUftMvmmaZEHaBs9f9bzew6sKxDvBJRXoagHrVgSWFUHe7jiHkRNmauGClUQ0yxJVrJP5j1WJW/tQemGUlTZRJWF732jVqO4Bs+FZLjdDUNZaAfTMwfV3SE0Q5GVx+d5TIpW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781729; c=relaxed/simple;
	bh=BhG/NGZBMIaRV8/8Yz3MraraiL/ZQT4rEE/zVBwz/so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz1EWHGHnoG2LwGlog/9GRFwgGGXU6l1wZBfqtmZRQUWLYgJ0VqEVE/ApyWA7oFHDZ3g6KYMVm8VIMVr1NIwT0dLU4KXVIp7Fn0rSDgF/UzBoiICwM7Ufs725wHbWU7pznHnmazbixJwaxoyU1q527PsKtqf+2kDjm2nGXKPmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4hozw0p; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738781728; x=1770317728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BhG/NGZBMIaRV8/8Yz3MraraiL/ZQT4rEE/zVBwz/so=;
  b=R4hozw0pkfuA2FXMJb6BZlW9b8ybKXLuStvm65Ri3iZrpm2QHf2VJreK
   oNLYQMSPzXDiAcTHjiHx+Y6wdibHztp4tJeSuFbo9yK0S3UOiwF6HLwWl
   6WUp/zDWH3bxqphDMwF1gpt7cqPCqmCKqfAdG+6mAK6ne0McK7Gq87Dhy
   YbpnVuk2Z1LgVPuspDSfrd5J8BQXFFy4RYDUPfeKRgWhNdYmDcrGMo8+I
   UcCWCR2QH8LnNQKjv37FD2WTftxBx04wI2hqfm4iasjLrNKZEfE1BhEgx
   G5CUULRdDC+95xD3TI+C070W3MPLBIukCFhAqofPpfDIpYdTxGK+oLacZ
   w==;
X-CSE-ConnectionGUID: rTJaTAp8RxCi5M6C3U2jdQ==
X-CSE-MsgGUID: nghLuFTZTeKpYiiuicI4qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61834447"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="61834447"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:55:27 -0800
X-CSE-ConnectionGUID: BSSTIalhRcS+MQpmECnH0g==
X-CSE-MsgGUID: I0mcLq8kRtq3psebEza4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="111515283"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 10:55:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com,
	tatyana.e.nikolova@intel.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 4/9] ice: get rid of num_lan_msix field
Date: Wed,  5 Feb 2025 10:55:04 -0800
Message-ID: <20250205185512.895887-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205185512.895887-1-anthony.l.nguyen@intel.com>
References: <20250205185512.895887-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Remove the field to allow having more queues than MSI-X on VSI. As
default the number will be the same, but if there won't be more MSI-X
available VSI can run with at least one MSI-X.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_base.c    | 10 ++++----
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 ++---
 drivers/net/ethernet/intel/ice/ice_irq.c     | 11 ++++-----
 drivers/net/ethernet/intel/ice/ice_lib.c     | 25 +++++++++++---------
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index c78bd45cf016..ad61dd688871 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -617,7 +617,6 @@ struct ice_pf {
 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
 	struct ice_pf_msix msix;
-	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
 	u16 num_lan_tx;		/* num LAN Tx queues setup */
 	u16 num_lan_rx;		/* num LAN Rx queues setup */
 	u16 next_vsi;		/* Next free slot in pf->vsi[] - 0-based! */
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b2af8e3586f7..0e862f20427a 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -801,13 +801,11 @@ int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
 	return 0;
 
 err_out:
-	while (v_idx--)
-		ice_free_q_vector(vsi, v_idx);
 
-	dev_err(dev, "Failed to allocate %d q_vector for VSI %d, ret=%d\n",
-		vsi->num_q_vectors, vsi->vsi_num, err);
-	vsi->num_q_vectors = 0;
-	return err;
+	dev_info(dev, "Failed to allocate %d q_vectors for VSI %d, new value %d",
+		 vsi->num_q_vectors, vsi->vsi_num, v_idx);
+	vsi->num_q_vectors = v_idx;
+	return v_idx ? 0 : err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 6bbb304ad9ab..b0805704834d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3788,8 +3788,7 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
  */
 static int ice_get_max_txq(struct ice_pf *pf)
 {
-	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
-		    (u16)pf->hw.func_caps.common_cap.num_txq);
+	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
 }
 
 /**
@@ -3798,8 +3797,7 @@ static int ice_get_max_txq(struct ice_pf *pf)
  */
 static int ice_get_max_rxq(struct ice_pf *pf)
 {
-	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
-		    (u16)pf->hw.func_caps.common_cap.num_rxq);
+	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 4a50a6dc817e..1a7d446ab5f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -108,7 +108,7 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
 int ice_init_interrupt_scheme(struct ice_pf *pf)
 {
 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
-	int vectors, max_vectors;
+	int vectors;
 
 	/* load default PF MSI-X range */
 	if (!pf->msix.min)
@@ -118,20 +118,17 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 		pf->msix.max = min(total_vectors,
 				   ice_get_default_msix_amount(pf));
 
-	if (pci_msix_can_alloc_dyn(pf->pdev)) {
+	if (pci_msix_can_alloc_dyn(pf->pdev))
 		vectors = pf->msix.min;
-		max_vectors = total_vectors;
-	} else {
+	else
 		vectors = pf->msix.max;
-		max_vectors = vectors;
-	}
 
 	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
 					PCI_IRQ_MSIX);
 	if (vectors < pf->msix.min)
 		return -ENOMEM;
 
-	ice_init_irq_tracker(pf, max_vectors, vectors);
+	ice_init_irq_tracker(pf, pf->msix.max, vectors);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 38a1c8372180..4b8d7aa7b1bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -157,6 +157,16 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 	}
 }
 
+static u16 ice_get_rxq_count(struct ice_pf *pf)
+{
+	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
+}
+
+static u16 ice_get_txq_count(struct ice_pf *pf)
+{
+	return min(ice_get_avail_txq_count(pf), num_online_cpus());
+}
+
 /**
  * ice_vsi_set_num_qs - Set number of queues, descriptors and vectors for a VSI
  * @vsi: the VSI being configured
@@ -178,9 +188,7 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 			vsi->alloc_txq = vsi->req_txq;
 			vsi->num_txq = vsi->req_txq;
 		} else {
-			vsi->alloc_txq = min3(pf->num_lan_msix,
-					      ice_get_avail_txq_count(pf),
-					      (u16)num_online_cpus());
+			vsi->alloc_txq = ice_get_txq_count(pf);
 		}
 
 		pf->num_lan_tx = vsi->alloc_txq;
@@ -193,17 +201,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 				vsi->alloc_rxq = vsi->req_rxq;
 				vsi->num_rxq = vsi->req_rxq;
 			} else {
-				vsi->alloc_rxq = min3(pf->num_lan_msix,
-						      ice_get_avail_rxq_count(pf),
-						      (u16)num_online_cpus());
+				vsi->alloc_rxq = ice_get_rxq_count(pf);
 			}
 		}
 
 		pf->num_lan_rx = vsi->alloc_rxq;
 
-		vsi->num_q_vectors = min_t(int, pf->num_lan_msix,
-					   max_t(int, vsi->alloc_rxq,
-						 vsi->alloc_txq));
+		vsi->num_q_vectors = max(vsi->alloc_rxq, vsi->alloc_txq);
 		break;
 	case ICE_VSI_SF:
 		vsi->alloc_txq = 1;
@@ -1173,12 +1177,11 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 static void
 ice_chnl_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
 {
-	struct ice_pf *pf = vsi->back;
 	u16 qcount, qmap;
 	u8 offset = 0;
 	int pow;
 
-	qcount = min_t(int, vsi->num_rxq, pf->num_lan_msix);
+	qcount = vsi->num_rxq;
 
 	pow = order_base_2(qcount);
 	qmap = FIELD_PREP(ICE_AQ_VSI_TC_Q_OFFSET_M, offset);
-- 
2.47.1


