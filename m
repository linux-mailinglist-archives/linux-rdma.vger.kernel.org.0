Return-Path: <linux-rdma+bounces-9430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D7CA88DBD
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 23:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363A93B37EC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C0C1EB1B5;
	Mon, 14 Apr 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0uMc+bH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B32AF0A;
	Mon, 14 Apr 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666009; cv=none; b=UNwbvCfRpXjUSFkKdyu3Tth8yyHpYrYnSmkFogjw+Eglol61xqpA+xDfJIDz2klWiC8Pbmr4cdsE8VST3MSklrZUb8nXk1ouU7jRgL0Z5AjZnQeub3PpPRhgRSz9IPBiEqVTjconGRJp5YHgb41OQ5yCBwRyLyN/BVIFgZVOD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666009; c=relaxed/simple;
	bh=AcuwE8JaJ3lT4gvBhoaVTGVJ/yEd3t9suqvwbBI4EbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IE8batblwx60HAhHRdclSh+HYZw4hLY/his6/lrYJHX0DwAx+yxPWTnoMshgsmkv4cXo7o/vU5++qJFlwvtWt/gbN/hBEKpz/VNIyuY0uTIKsIO3m4xSXyAq2IibuhhyjyekHJCXSZSstNVMxmpr9tI26r7z/P2md7p1dpO9f3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0uMc+bH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744666007; x=1776202007;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=AcuwE8JaJ3lT4gvBhoaVTGVJ/yEd3t9suqvwbBI4EbA=;
  b=G0uMc+bHSTD1cYRoHSZzmG0RycGwavI0ckIZ36qwe1IZKrSmQbmSrbQP
   KGfX+OIMiRlKsF27XxhhI6BgXN8k5vO5wfOf//6h1zlzqYSk2ujocdEGP
   RQWGJyotpwwAIwwmMRfUz5ADpXwU2sA+UnhOKfTXtiI88dfIlLshVhh1c
   EVnfRvLg7LaqX4zecopPxlJ80GaPLHAxq2QXJgU8RLwUTwFUCtQBRwt+U
   po8n2fWg/M8dQ4XmygKQtMDyHymNlCAAZgJvS4JAjudX5hMRT6RI6D2f3
   6e0TBE/ODy6AeNCoFftQ88Zbcret/nA+wbFAFpMkitLVr7QnE+V5O72/v
   w==;
X-CSE-ConnectionGUID: g8VICSFARfynZrD7zXmk4w==
X-CSE-MsgGUID: LhzGXAywRyiWw324BJz+fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46163851"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46163851"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:26:45 -0700
X-CSE-ConnectionGUID: xcsM0XrkSEmbD1/whsfu2g==
X-CSE-MsgGUID: 0s24PglrTX2QBP6rlUfdQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130896307"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:26:46 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 0/2] net: ptp: driver opt-in for supported PTP
 ioctl flags
Date: Mon, 14 Apr 2025 14:26:29 -0700
Message-Id: <20250414-jk-supported-perout-flags-v2-0-f6b17d15475c@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIV9/WcC/42NQQ6CMBBFr0Jm7ZjSogFX3MOwIHQKo9g2bSEYw
 t1tOIHLl5f//g6RAlOER7FDoJUjO5tBXgoYpt6OhKwzgxTyJipR4+uNcfHehUQaPQW3JDRzP0a
 slCwbPRCJRkHe+0CGt7P9BEsJLW0JumwmjsmF73m6lqf/o7+WKFBLU5PS5l4Z1bJNNF8H94HuO
 I4ffFzFfcwAAAA=
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
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
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
Changes in v2:
- Expand PTP_EXTTS_EDGES in all .supported_extts_flags assignment
- Remove PTP_ENABLE_FEATURE from all .supported_extts_flags assignment
- Add a .supported_extts_flags assignment to ravb driver, even tho it
  doesn't currently support PTP_STRICT_FLAGS. The driver did previously
  check these, so I think its better to add them even if its equivalent.
- Added Vadim's Reviewed-by to patch 2/2
- Link to v1: https://lore.kernel.org/r/20250408-jk-supported-perout-flags-v1-0-d2f8e3df64f3@intel.com

---
Jacob Keller (2):
      net: ptp: introduce .supported_extts_flags to ptp_clock_info
      net: ptp: introduce .supported_perout_flags to ptp_clock_info

 include/linux/ptp_clock_kernel.h                   | 18 +++++++++++++++
 drivers/net/dsa/mv88e6xxx/ptp.c                    | 11 ++++-----
 drivers/net/dsa/sja1105/sja1105_ptp.c              | 14 +++---------
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 16 +++++--------
 drivers/net/ethernet/intel/igb/igb_ptp.c           | 20 +++++------------
 drivers/net/ethernet/intel/igc/igc_ptp.c           | 14 +++---------
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    | 26 ++++++----------------
 drivers/net/ethernet/microchip/lan743x_ptp.c       | 14 ++++--------
 .../net/ethernet/microchip/lan966x/lan966x_ptp.c   | 14 ++++--------
 drivers/net/ethernet/mscc/ocelot_ptp.c             |  5 -----
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |  2 ++
 drivers/net/ethernet/renesas/ravb_ptp.c            | 11 +--------
 drivers/net/phy/dp83640.c                          | 13 +++--------
 drivers/net/phy/micrel.c                           | 17 +++++---------
 drivers/net/phy/microchip_rds_ptp.c                |  5 +----
 drivers/net/phy/nxp-c45-tja11xx.c                  | 13 ++++-------
 drivers/ptp/ptp_chardev.c                          | 16 ++++++++++++-
 drivers/ptp/ptp_clockmatrix.c                      | 14 ++----------
 drivers/ptp/ptp_fc3.c                              |  1 +
 drivers/ptp/ptp_idt82p33.c                         | 15 +++----------
 20 files changed, 91 insertions(+), 168 deletions(-)
---
base-commit: b65999e7238e6f2a48dc77c8c2109c48318ff41b
change-id: 20250408-jk-supported-perout-flags-43219dcee093

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


