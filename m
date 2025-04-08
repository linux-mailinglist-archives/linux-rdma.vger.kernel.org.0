Return-Path: <linux-rdma+bounces-9277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F7A8173D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 22:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D377B1BB8
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C35253B41;
	Tue,  8 Apr 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzERQ4Ig"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7E2500DE;
	Tue,  8 Apr 2025 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145731; cv=none; b=FKE7YIn167eGT23B0RTlr8HAwCZltJM/uA1kxrq5tlW+JqRdISO65leoJmQlDf3GyZArw9omqIuPyzewfvrAJqH7fVIFpiUkpQuhwtti9IKbA8izlROiiPTwQ3q8vg704sRLZSIwr6hQXvNu64oRZaXuyiaeGRFKMn9Ncn8Lbxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145731; c=relaxed/simple;
	bh=V3Z9xLL+CF0zdWUM4uy01fpN3yOGZDvrIfmutE1VOKk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uJnpzKV0vmZLebKv/igSYJJ4SFfb+XbkP33+WcVyWW6gY/lAlKUb9XJlVPJ6Ke//wnfBUlb2Pd0Z35naCjl8MwJ1UD/HFgNz0fuygPupInr8Mgq3Cr3d6TFLTyCkunXbE7PQrmijHa7NLAK6LdDmoeB2ZMmNL1ayqn7cqoZO4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzERQ4Ig; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744145729; x=1775681729;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=V3Z9xLL+CF0zdWUM4uy01fpN3yOGZDvrIfmutE1VOKk=;
  b=RzERQ4IgpgVVcx8AZBbmTjEf7YOvrI6rO/d12uuiOjsY7Z5pPTySyC//
   f/fv+2QbD+n7A8FAXLeMCWHk0WiVoiVZzaf643sD4EhMEGTlixHXRbYw7
   3u+Pg4g1Kmbmadc0CYKRPJV9B5X9GUQ0vSkjQxociwzgf66MSzSnTimrM
   ncDyhDnu31gmh/j63XEYa1Nr/FgZ0Ef2P5gtpjVKmpFbpjSRc/lFBQc/U
   e/AM/Q9O9OusPL4SUtayXaYsxg+C4B/NPtD4vNkxlwqjAPFA/pvfqfxQ5
   hmpwpEZTCQM7EjaGV7+h3LMmPZTeUW8RRl6Ebd2dZLm4kXmi/v4BFSw2p
   w==;
X-CSE-ConnectionGUID: a88zHLxuQ0e2U9VyggQjnQ==
X-CSE-MsgGUID: Rex1vgtnTmWCDef5g/gzuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56970707"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="56970707"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 13:55:27 -0700
X-CSE-ConnectionGUID: geJKUbmXRVuxUFy6Zjqo0w==
X-CSE-MsgGUID: 0PDhL9E8QdCgJTN4AKArmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151563675"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 13:55:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 0/2] net: ptp: driver opt-in for supported PTP
 ioctl flags
Date: Tue, 08 Apr 2025 13:55:13 -0700
Message-Id: <20250408-jk-supported-perout-flags-v1-0-d2f8e3df64f3@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGN9WcC/x3MQQqDMBBG4avIrDsQo4Xaq5QuxPzaaUsSZqII4
 t0buvwW7x1kUIHRvTlIsYlJihXtpaHpNcYFLKGavPNX17sbvz9sa85JCwJnaFoLz99xMe473w5
 hAtzQUe2zYpb9/35QROGIvdDzPH/HYTm7dQAAAA==
X-Change-ID: 20250408-jk-supported-perout-flags-43219dcee093
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Andrei Botila <andrei.botila@oss.nxp.com>, 
 Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

Both the PTP_EXTTS_REQUEST(2) and PTP_PEROUT_REQUEST(2) ioctls take flags
from userspace to modify their behavior. Drivers are supposed to check
these flags, rejecting requests for flags they do not support.

Many drivers today do not check these flags, despite many attempts to
squash individual drivers as these mistakes are discovered. Additionally,
any new flags added can require updating every driver if their validation
checks are poorly implemented.

It is clear that driver authors will not reliably check for unsupported
flags. The root of the issue is that drivers must essentially opt out of
every flag, rather than opt in to the ones they support.

Instead, lets introduce .supported_perout_flags and .supported_extts_flags
to the ptp_clock_info structure. This is a pattern taken from several
ethtool ioctls which enabled validation to move out of the drivers and into
the shared ioctl handlers. This pattern has worked quite well and makes it
much more difficult for drivers to accidentally accept flags they do not
support.

With this approach, drivers which do not set the supported fields will have
the core automatically reject any request which has flags. Drivers must opt
in to each flag they support by adding it to the list, with the sole
exception being the PTP_ENABLE_FEATURE flag of the PTP_EXTTS_REQUEST ioctl
since it is entirely handled by the ptp_chardev.c file.

This change will ensure that all current and future drivers are safe for
extension when we need to extend these ioctls.

I opted to keep all the driver changes into one patch per ioctl type. The
changes are relatively small and straight forward. Splitting it per-driver
would make the series large, and also break flags between the introduction
of the supported field and setting it in each driver.

The non-Intel drivers are compile-tested only, and I would appreciate
confirmation and testing from their respective maintainers. (It is also
likely that I missed some of the driver authors especially for drivers
which didn't make any checks at all and do not set either of the supported
flags yet)

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (2):
      net: ptp: introduce .supported_extts_flags to ptp_clock_info
      net: ptp: introduce .supported_perout_flags to ptp_clock_info

 include/linux/ptp_clock_kernel.h                   | 18 +++++++++++++++
 drivers/net/dsa/mv88e6xxx/ptp.c                    | 12 +++++-----
 drivers/net/dsa/sja1105/sja1105_ptp.c              | 14 +++---------
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 16 +++++--------
 drivers/net/ethernet/intel/igb/igb_ptp.c           | 20 +++++------------
 drivers/net/ethernet/intel/igc/igc_ptp.c           | 15 ++++---------
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    | 26 ++++++----------------
 drivers/net/ethernet/microchip/lan743x_ptp.c       | 14 ++++--------
 .../net/ethernet/microchip/lan966x/lan966x_ptp.c   | 15 +++++--------
 drivers/net/ethernet/mscc/ocelot_ptp.c             |  5 -----
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |  2 ++
 drivers/net/ethernet/renesas/ravb_ptp.c            | 10 ---------
 drivers/net/phy/dp83640.c                          | 14 ++++--------
 drivers/net/phy/micrel.c                           | 17 +++++---------
 drivers/net/phy/microchip_rds_ptp.c                |  5 +----
 drivers/net/phy/nxp-c45-tja11xx.c                  | 14 +++++-------
 drivers/ptp/ptp_chardev.c                          | 16 ++++++++++++-
 drivers/ptp/ptp_clockmatrix.c                      | 18 +++++----------
 drivers/ptp/ptp_fc3.c                              |  1 +
 drivers/ptp/ptp_idt82p33.c                         | 16 ++++---------
 20 files changed, 100 insertions(+), 168 deletions(-)
---
base-commit: 0f681b0ecd190fb4516bb34cec227296b10533d1
change-id: 20250408-jk-supported-perout-flags-43219dcee093

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


