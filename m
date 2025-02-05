Return-Path: <linux-rdma+bounces-7470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C17A29992
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919837A2489
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8365F212D86;
	Wed,  5 Feb 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUjz9FKo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE91FECD4;
	Wed,  5 Feb 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781735; cv=none; b=GRvW8JXCxSYFRx7mCmq+xOHUgUB3qjPjjX9WPI6OQj18DiErFGa2AtZF6gO1asG8TC5nvYpK73MdkA98xhvEDFSe1qnn89QQEmXDItqqEkaywGURU06umGRyGjlnQ8gHC4+oE4uiBBtEbn27QxpVzvfRG2TuZspJL+DGeiyU+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781735; c=relaxed/simple;
	bh=A/yBatS3y92cPv+UkMkp9tdQHn4D/u+c6hDwwx4ml1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNYVmqZ31cp61mupo205ctuJycJlxsZWiUPvIlXUGCKXo+ASryzImkDe+sh06f4tY4rJPSwnkTCXf4jqgRzzSFVICnwFstYxMTsXyzc+TFugLVVnVGEn+W1/+wX6Z7LgL1t4uIos3CnAALodQ/IFboswqn6qNHGnhpauzU1/Rqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUjz9FKo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738781734; x=1770317734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/yBatS3y92cPv+UkMkp9tdQHn4D/u+c6hDwwx4ml1s=;
  b=WUjz9FKoAdDpjnOFANX+vkfJQe7LpuWrZxBL7JYGi7i3xlxdg6bHfIhc
   09rR9YOFEFnHPWD3AI2dJ9nBaqQ0lbwMdtGbx2rv54Wf/8uJKnsrzcYYM
   IFLQLIfa2mCWvZJFs3IxvL8T6Lxq8OxL2s9WMb1UXEy8uFwEFRl7N9gcD
   14jyx6vwEE4CD4AEN2n3M3Et6C/T0ngJUmzzSrfwZEH9o8lnigixMaqwM
   TlwhvW/mR1/IREGu3s5Nsq8vshpjWMI6CoSLLCQNDBp0pT48uatjsrZjG
   tbIGtoCTXn51ZlMb9hnksm83jXDvk3ZO1ZRkbMs+5OaOLVHwqUQarJMPF
   Q==;
X-CSE-ConnectionGUID: fyntKkuVRSmJNAjsjqzVSA==
X-CSE-MsgGUID: bI6FFF0HT3qxqp4VhTIPJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61834529"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="61834529"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:55:33 -0800
X-CSE-ConnectionGUID: m/EYh3NORLyJusd56dJPiw==
X-CSE-MsgGUID: fHK8ywmQQECr4gmUN6vw9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="111515340"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 10:55:32 -0800
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
Subject: [PATCH net-next v2 9/9] ice: init flow director before RDMA
Date: Wed,  5 Feb 2025 10:55:09 -0800
Message-ID: <20250205185512.895887-10-anthony.l.nguyen@intel.com>
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

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c3a0fb97c5ee..d7037de29545 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5186,11 +5186,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5198,6 +5199,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5221,8 +5223,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.47.1


