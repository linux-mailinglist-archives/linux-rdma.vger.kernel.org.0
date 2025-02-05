Return-Path: <linux-rdma+bounces-7462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA653A29981
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB8188431E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0A1FF1B3;
	Wed,  5 Feb 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJdopC8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC631885BE;
	Wed,  5 Feb 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781726; cv=none; b=cGr4uW0i/tv0QasMLbkRrKyWU0+aJfWxdW5N/ZX516udg8pbkW+45gK5QF7N8hQWck5GcQIepvt8KZPy1vqROmTndVRqKBcDEXplH3hOILYg3A8UKLKJ0HvixIsQbZFW64CsoU10qw4thhjv/5AMN4TAs8k9PR2M8F5MuwWXr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781726; c=relaxed/simple;
	bh=pRLXMsvT9GDZEFL0HopyNJlnmiyFvlTo66OcQT/WZxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYZCKaVsBndYfs72/mOEXrovl+ZsGpB3dz1vHUDaolYBRtTbjBEQzneIfrGJI+cQDUyxgJhox38I5Ma8ixyYhqhGQ9EQi9AF81KxY+dgFXbrqsah5xTevOuB1TpNBEsbG3mSurw+s+IEUL0P+BbY7egvHfzV0+ErZ5edBp9qxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJdopC8O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738781724; x=1770317724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pRLXMsvT9GDZEFL0HopyNJlnmiyFvlTo66OcQT/WZxY=;
  b=KJdopC8OK8w2F1Wh4rusONJTPVxT5O2ni7s2MiJ0ai6vPWYuN2ToIan8
   LSBZeBG8hi7zaCIXCvZbM5dDN5o6d267+deNpqWDGfo9ctFyH6WXPi+pl
   bZYwoJy5Qiku9VN9KMOFcj9yWNGM6byPes0dIvMUzCv9L7C7EAKVX7VdR
   ghasxnBFL07tXFl6nHgrlwT4x7WEAeq/Vh+IErR5NHmJSLXs4xR1IQ3zw
   I8hPJ3n3hKFPgDGilqF9VtGWi04AU64gVAuq+rA8CnHCp9nlJl2MJ3pZM
   wP0O+641BUJTds7FGiO0wLPhTakFD+K2NEnZY04z95nP4SY5UJpBruU1i
   w==;
X-CSE-ConnectionGUID: NLYZP9+sSTyFuWppNo+Jzw==
X-CSE-MsgGUID: rjzZtPjWQHqWEKn7oLAIcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61834396"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="61834396"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:55:24 -0800
X-CSE-ConnectionGUID: 14Kq/bCMTS6zs0U4qKydBw==
X-CSE-MsgGUID: xB2H9zHRTpuEg2+wZ1k9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="111515251"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 10:55:22 -0800
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
Subject: [PATCH net-next v2 1/9] ice: count combined queues using Rx/Tx count
Date: Wed,  5 Feb 2025 10:55:01 -0800
Message-ID: <20250205185512.895887-2-anthony.l.nguyen@intel.com>
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

Previous implementation assumes that there is 1:1 matching between
vectors and queues. It isn't always true.

Get minimum value from Rx/Tx queues to determine combined queues number.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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


