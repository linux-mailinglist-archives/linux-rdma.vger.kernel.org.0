Return-Path: <linux-rdma+bounces-7371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1578A2654F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 22:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417C5188617E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1520FA99;
	Mon,  3 Feb 2025 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIlpUy6w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E920E6FC;
	Mon,  3 Feb 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616991; cv=none; b=QXd60Mt05liMyis53MtkOW3so9r78aRVYTE4527DAW9VrHzPfU3cd1aItRLt8fJEmDxHmgQTJnckJsKwFoB2YTSerQ76GHbumEDdDrnJHmWcafAbWnS+DHQnFys4xbVlqeJZlvn/7X3Hc39Dpbi68737DiG5qUvZtRDC5VmNLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616991; c=relaxed/simple;
	bh=LnTYVvSMByy7MbH8fk+vOXREUb3carw82OXCUV+JZUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZALA78Ih+9kk3LrYNN2GF1ZuKylBwLRaCr0qKuIylnrbNkwjBLMjy/oI4iUOd3tbNehnBaLphCFw2uwSw1s6iGNtSirANpD7XWqbmWzrj7N7G7lWFh/GIOgOFTtHUW3t2Rhc4mmiocF+24+hEhC0OcQgcAlaqqdMGxCZv3kbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIlpUy6w; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738616990; x=1770152990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LnTYVvSMByy7MbH8fk+vOXREUb3carw82OXCUV+JZUA=;
  b=QIlpUy6wrn5NDFa++lVdEmvB3mmpoKxZ1LNdWhJBSKWTS7bpQ9QLuM95
   hHcjkW232jRbSDYPgaUDnaWwy2+GHKiPa+2R1t5oqq/1FItlOOOTNUU39
   S2KrJL6Pyb/ACY1FZX3uenBEEw4LQJj/UqEnv5id6+GaekkSANSn8sjc1
   W9SSSUnkhHQhkUz1ggMNQJ2Lds3vU18BCZgNW3kkv/EDF6s+utvmN9ew8
   N4SEwrNuoD4sbasUke5H0Qso+dckAKbPKTI3qng2t0Pvq1oKflyD7QP4s
   4K9sG3poE9ko5bvZSmaNyUUB3jRaZBvUbl9Ln6dgAPogpRpLc8xOOCsqh
   w==;
X-CSE-ConnectionGUID: ErdyX167THSIrEpAaVCDUA==
X-CSE-MsgGUID: 35sosVZlS1eY02vIRUVwYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49735561"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="49735561"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 13:09:48 -0800
X-CSE-ConnectionGUID: S+QDboqwTc6Qz5L5oZqo2Q==
X-CSE-MsgGUID: l/jW00XZTDenWZWxfBIq4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="141273300"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Feb 2025 13:09:48 -0800
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
Subject: [PATCH net-next 1/9] ice: count combined queues using Rx/Tx count
Date: Mon,  3 Feb 2025 13:09:30 -0800
Message-ID: <20250203210940.328608-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Previous implementation assumes that there is 1:1 matching between
vectors and queues. It isn't always true.

Get minimum value from Rx/Tx queues to determine combined queues number.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f241493a6ac8..6bbb304ad9ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3817,8 +3817,7 @@ static u32 ice_get_combined_cnt(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, q_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
-		if (q_vector->rx.rx_ring && q_vector->tx.tx_ring)
-			combined++;
+		combined += min(q_vector->num_ring_tx, q_vector->num_ring_rx);
 	}
 
 	return combined;
-- 
2.47.1


