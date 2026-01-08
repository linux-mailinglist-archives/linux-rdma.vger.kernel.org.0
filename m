Return-Path: <linux-rdma+bounces-15371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 475DBD05791
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 19:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E27F302BB93
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DAA3126DA;
	Thu,  8 Jan 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLGCbYxu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C52FB97D
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896620; cv=none; b=WwFma1Brg025ACnhr4UeBVPgovy43fjNryEXFRIFlmcRgBw3FVz1wF7A+d2Voms2m1vOQrNlRLgk5G29VkF3+9Rf/4tmMaEtcOMLC43G4F9vc5AsBkCP6rkFtoE/pRbQAb50sQ4nP2V2M4SanXdDCCgz8Xhbna8XjID7OJzjkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896620; c=relaxed/simple;
	bh=byjnH73p+Jzsz7pjUDHFcwFHOJJHuGtBOHNwd7Y2sgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1pZZLdnoTmX15Lh2mshGh/Kq5S4YmznnSpq/h0PbZaqLSIIqVjJ+i1EOISuY45TWyBUWxdn5KCTFfPAZsbod7AEAI6FrCV1VzUVPNlwHL4S8SQU1G5UQVP+Dl+n7fhsEPACaTwLS4DrowPVUvJSLDknzD+vqVFge9Kz0IjlDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLGCbYxu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767896616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EltKARJ+Nuab9bXI1zOrXiqWGrxnQkfq54M5thLshDQ=;
	b=eLGCbYxuEufh6i80JON6kMcWjUy92ZgBiFcGVfoiqD26roZZipMPTiZtb39DeQhUzqeAO/
	E8mGbTQ+Ebrd750ieJ/JwzCZW2s7J3JclvuO8j30xlMKwiI4UTdq9GnB2l15H/oiKPKmrT
	l8UW90WQoZWVbhtI3YQh9clwzOACCSE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-6V4tQ_yYO2CbwPIdoXc16w-1; Thu,
 08 Jan 2026 13:23:32 -0500
X-MC-Unique: 6V4tQ_yYO2CbwPIdoXc16w-1
X-Mimecast-MFC-AGG-ID: 6V4tQ_yYO2CbwPIdoXc16w_1767896609
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98D1B180045C;
	Thu,  8 Jan 2026 18:23:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F6131800285;
	Thu,  8 Jan 2026 18:23:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net-next 00/12] dpll: Core improvements and ice E825-C SyncE support
Date: Thu,  8 Jan 2026 19:23:06 +0100
Message-ID: <20260108182318.20935-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series introduces Synchronous Ethernet (SyncE) support for
the Intel E825-C Ethernet controller. Unlike previous generations where
DPLL connections were implicitly assumed, the E825-C architecture relies
on the platform firmware to describe the physical connections between
the network controller and external DPLLs (such as the ZL3073x).

To accommodate this, the series extends the DPLL subsystem to support
firmware node (fwnode) associations, asynchronous discovery via notifiers,
and dynamic pin management. Additionally, a significant refactor of
the DPLL reference counting logic is included to ensure robustness and
debuggability.

DPLL Core Extensions:
* Firmware Node Support: Pins can now be registered with an associated
  struct fwnode_handle. This allows consumer drivers to lookup pins based
  on device properties (dpll-pins).
* Asynchronous Notifiers: A raw notifier chain is added to the DPLL core.
  This allows the network driver (ice driver in this series) to subscribe
  to events and react when the platform DPLL driver registers the parent
  pins, resolving probe ordering dependencies.
* Dynamic Indexing: Drivers can now request DPLL_PIN_IDX_UNSPEC to have
  the core automatically allocate a unique pin index, simplifying driver
  implementation for virtual or non-indexed pins.

Reference Counting & Debugging:
* Refactor: The reference counting logic in the core is consolidated.
  Internal list management helpers now automatically handle hold/put
  operations, removing fragile open-coded logic in the registration paths.
* Duplicate Checks: The core now strictly rejects duplicate registration
  attempts for the same pin/device context.
* Reference Tracking: A new Kconfig option DPLL_REFCNT_TRACKER is added
  (using the kernel's REF_TRACKER infrastructure). This allows developers
  to instrument and debug reference leaks by recording stack traces for
  every get/put operation.

Driver Updates:
* zl3073x: Updated to register pins with their firmware nodes and support
  the 'mux' pin type.
* ice: Implements the E825-C specific hardware configuration for SyncE
  (CGU registers). It utilizes the new notifier and fwnode APIs to
  dynamically discover and attach to the platform DPLLs.

Patch Summary:
* Patch 1-3:
  DT pin consumer schema and helper functions for finding DPLL pins via fwnode.
* Patch 4:
  Updates zl3073x to register pins with fwnode.
* Patch 5-6:
  Adds notifiers and dynamic pin index allocation to DPLL core.
* Patch 7:
  Adds 'mux' pin type support to zl3073x.
* Patch 8-9:
  Refactors DPLL core refcounting and adds duplicate registration checks.
* Patch 10-11:
  Adds REF_TRACKER infrastructure and updates existing drivers to support it.
* Patch 12:
  Implements the E825-C SyncE logic in the ice driver using the new
  infrastructure.

Arkadiusz Kubalewski (1):
  ice: dpll: Support E825-C SyncE and dynamic pin discovery

Ivan Vecera (10):
  dt-bindings: dpll: add common dpll-pin-consumer schema
  dpll: Allow associating dpll pin with a firmware node
  dpll: Add helpers to find DPLL pin fwnode
  dpll: zl3073x: Associate pin with fwnode handle
  dpll: Support dynamic pin index allocation
  dpll: zl3073x: Add support for mux pin type
  dpll: Enhance and consolidate reference counting logic
  dpll: Prevent duplicate registrations
  dpll: Add reference count tracking support
  drivers: Add support for DPLL reference count tracking

Petr Oros (1):
  dpll: Add notifier chain for dpll events

 .../bindings/dpll/dpll-pin-consumer.yaml      |  30 +
 drivers/dpll/Kconfig                          |  15 +
 drivers/dpll/dpll_core.c                      | 320 +++++++-
 drivers/dpll/dpll_core.h                      |  11 +
 drivers/dpll/dpll_netlink.c                   |   6 +
 drivers/dpll/zl3073x/dpll.c                   |  15 +-
 drivers/dpll/zl3073x/dpll.h                   |   2 +
 drivers/dpll/zl3073x/prop.c                   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 728 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  29 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  29 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 217 ++++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  16 +-
 drivers/ptp/ptp_ocp.c                         |  18 +-
 include/linux/dpll.h                          |  74 +-
 19 files changed, 1385 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml

-- 
2.52.0


