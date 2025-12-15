Return-Path: <linux-rdma+bounces-15005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1187CBFC15
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 21:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34CEE3027CFD
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA93126A6;
	Mon, 15 Dec 2025 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB8phYrl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309429B8E8
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830661; cv=none; b=OZQvyNL0hZ84DStw3pg9BUqGDb/hTgnY1UTQmxWNnRltlmYtfUkrXgKJTp5ipFPkX8fxh/7Mxd/4Op2QtvZMEqpbz5wfEGB4Tg8cb23Ye63zgrDW1vvigEp85gsQ1e0sHvNa9U3nBws5abjvdrG9CL+QTHCmO91OuWNKlPbwUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830661; c=relaxed/simple;
	bh=SHZt1xLw1ZmPdp57TFJNx25aVwMtAQfw8AmycOD6hIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dob7lGx0Rh9ua9lguS1rA2tNEOZZYZTLNW3WHl+pHPOgR8OjGhL8UColT8cUkUwazEvkV5yKlxW6dsN+SOXknmDt+zWzRRq9X9D03LfgAAdiS6oH0Ir3jL63wsToHsEAEb/9jGcog+l3J2128XZTl8/lo4TWBsfBojyq+6i0gck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jB8phYrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765830659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFKP1wRB7MG8FdwSMPJtMRcQY82d/F+Hn/PXu/Kymsk=;
	b=jB8phYrltOg/QaW4dI4s5ln3bN9bMIj/s52q02oqs4mEdH1xVtnu+jvarFXsAom9NlAc27
	p8/Xq5opSRtc2mL2lGoTXYpp2vTbA02jmY7zr7Ly2euKdGEEqU3rV2atun2R87ylKIm3Jw
	T23UOrXuH+O3qjVrYya+SNJHrjRFG0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-fV4hTD3GOUeULQgWq9f_sw-1; Mon,
 15 Dec 2025 15:30:53 -0500
X-MC-Unique: fV4hTD3GOUeULQgWq9f_sw-1
X-Mimecast-MFC-AGG-ID: fV4hTD3GOUeULQgWq9f_sw_1765830649
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30D6218002ED;
	Mon, 15 Dec 2025 20:30:49 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.214])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C414630001A8;
	Mon, 15 Dec 2025 20:30:38 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next v2 00/13] dpll: Core improvements and ice E825-C SyncE support
Date: Mon, 15 Dec 2025 21:30:25 +0100
Message-ID: <20251215203037.1324945-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
  DT bindings and helper functions for finding DPLL pins via fwnode.
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
  dt-bindings: net: ethernet-controller: Add DPLL pin properties
  dpll: Allow associating dpll pin with a firmware node
  net: eth: Add helpers to find DPLL pin firmware node
  dpll: zl3073x: Associate pin with fwnode handle
  dpll: Support dynamic pin index allocation
  dpll: zl3073x: Add support for mux pin type
  dpll: Enhance and consolidate reference counting logic
  dpll: Prevent duplicate registrations
  dpll: Add reference count tracking support
  drivers: Add support for DPLL reference count tracking

Petr Oros (1):
  dpll: Add notifier chain for dpll events

 .../bindings/net/ethernet-controller.yaml     |  13 +
 drivers/dpll/Kconfig                          |  15 +
 drivers/dpll/dpll_core.c                      | 296 +++++-
 drivers/dpll/dpll_core.h                      |  11 +
 drivers/dpll/dpll_netlink.c                   |   6 +
 drivers/dpll/zl3073x/dpll.c                   |  14 +-
 drivers/dpll/zl3073x/dpll.h                   |   1 +
 drivers/dpll/zl3073x/prop.c                   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 977 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  33 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  29 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 223 ++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  14 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  16 +-
 drivers/ptp/ptp_ocp.c                         |  18 +-
 include/linux/dpll.h                          |  59 +-
 include/linux/etherdevice.h                   |   4 +
 net/ethernet/eth.c                            |  20 +
 22 files changed, 1614 insertions(+), 156 deletions(-)

-- 
2.51.2


