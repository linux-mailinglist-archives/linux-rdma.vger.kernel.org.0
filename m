Return-Path: <linux-rdma+bounces-4534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62295DAD9
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EEA1F229C7
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FAE3B182;
	Sat, 24 Aug 2024 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SU5xh5kU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC52AF1D;
	Sat, 24 Aug 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469644; cv=none; b=cVYSZhk/vLuHfoASBlfoBnB/SlrjJB1ijG3VFdy3s6cG8ZpoRjKMlgOyysQGDrEerhvdpHCIQtih9avIjmeOTyEcfimx7n/UEVjfqw92fOJbuX0h6WWWo+ffg6pF4zsXyMd5BmUwLHowv8rkGX6vvrfdSwbQeAhOsDxcyavtacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469644; c=relaxed/simple;
	bh=3hF75XyVl8jE5Hr5jzPTLntB0NZg8s35xEv5pzkD8XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OE8EISWrJfwieulDPuk5ZCLd+8ZKdkIEHNGM/TphR0/DJeh4c4yFrgzMbv0z8efDNcEk8D4uVyzotTyYEJ0CVHUulB9A4t03GTbZUiEC6vJatsos7AFHo3ac63DpTC/8+bSe97HyDjeimdYU6UUtOCMZfZ/cBtP8gzrhbiCBAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SU5xh5kU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469643; x=1756005643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hF75XyVl8jE5Hr5jzPTLntB0NZg8s35xEv5pzkD8XM=;
  b=SU5xh5kUWJR1BZkYQjz0dMs3E7gxJdX6WDrchQDmCDle9ivWI8rojT/M
   CE4Z7YM7GzHjGFDnGQDAYxwYwBMLS0rbH/BWDgnhzw2xD2bpLYo1uNWse
   2nYf75VhKx45HBVdcf8AD3LBxz9jcf5N7ZkIdmTpHQcv1AZ/gAe3a20/8
   6fA9V8/FOwHc5qalTdHeTHWri620UZIDHlrecHuvldeSLESCWZuHUoC7s
   +Q+BEyMS68z1LQvJ4a17adTSONsjSP+DTDByusnJDkwTIcDgOY07yi5nW
   8x3zxQTEUe9OmNWEHHBR7yVZt6oTKqwQ2efUZmcBMlQ0vC3jFz0Hw25yy
   A==;
X-CSE-ConnectionGUID: JquNem+vRFOdq+n8uhDc9Q==
X-CSE-MsgGUID: fE+L4moRQS+q25QR6t/V9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187776"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187776"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:40 -0700
X-CSE-ConnectionGUID: aBa6mbmVSDaogGdFvwUiRA==
X-CSE-MsgGUID: wzA4nWLAT82pMQ0eKyv4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492080"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:39 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 04/25] idpf: prevent deadlock with irdma get link settings
Date: Fri, 23 Aug 2024 22:19:03 -0500
Message-Id: <20240824031924.421-5-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

When the rdma core deinitializes (reset or remove), it is calling
get_link_ksettings. Add logic to get link settings to avoid even taking
the lock during a reset or remove, since we will not care what the link
settings are in that state anyways.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 3806ddd3ce4a..d287a5537167 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1296,20 +1296,25 @@ static void idpf_set_msglevel(struct net_device *netdev, u32 data)
 static int idpf_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
+	struct idpf_adapter *adapter = idpf_netdev_to_adapter(netdev);
 	struct idpf_vport *vport;
 
-	idpf_vport_ctrl_lock(netdev);
-	vport = idpf_netdev_to_vport(netdev);
-
 	ethtool_link_ksettings_zero_link_mode(cmd, supported);
 	cmd->base.autoneg = AUTONEG_DISABLE;
 	cmd->base.port = PORT_NONE;
+	cmd->base.duplex = DUPLEX_UNKNOWN;
+	cmd->base.speed = SPEED_UNKNOWN;
+
+	if (idpf_is_reset_in_prog(adapter) ||
+	    test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return 0;
+
+	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
+
 	if (vport->link_up) {
 		cmd->base.duplex = DUPLEX_FULL;
 		cmd->base.speed = vport->link_speed_mbps;
-	} else {
-		cmd->base.duplex = DUPLEX_UNKNOWN;
-		cmd->base.speed = SPEED_UNKNOWN;
 	}
 
 	idpf_vport_ctrl_unlock(netdev);
-- 
2.42.0


