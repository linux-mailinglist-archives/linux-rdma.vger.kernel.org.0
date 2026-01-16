Return-Path: <linux-rdma+bounces-15629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F686D38497
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 19:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18C053020175
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02E33C50D;
	Fri, 16 Jan 2026 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXoMAIoC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B61F92E
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589189; cv=none; b=lfvOoCHhfOP0ocbwfoTlIvY8JkLRnNkKZWvNooPMZhxq+Vxhu7p8iAVaIaU1DZ1Z7rgMrHVxXwb5hx8D3fX8vCi1CrcPmMjQxBrzn1XgLh8fRbPLU7NwoeVzj0fpHDoU/1Tu/wfcwnUv7xZdvpauQTLnMNH5ZBEvhyFzuyKNn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589189; c=relaxed/simple;
	bh=DIqgn0H/WpJOkcEMvlIngavbCSSA8jftcwAzyQKIpc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ld+A/tsTwOM8CrqPvi/G3hAOyKG6UQzGjqBTQK5NXsUnGbm5x7A1mnCUiA/eGbTStUUbAFvDyvsjEQJf0j1e3Y892+/y8i7JxZDdG/FIkOWyE/uvnZOLXqf07Ffsr6ClaUtyYeY/GQm6dejcP7VXMwne3gHFHfstkfRW9DywnG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXoMAIoC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768589187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZJVObctK3llj4uA0acCK4Yyzz9vQu+ksQA0NFHgNQGU=;
	b=BXoMAIoCK2gAEpkc+Owlo61VnE+ET+pyAw1PmGdifJ/mhwbQyQfKz+yK50IoEBh+nhsTqE
	LOYt4BK7zwK9PfXdkGzgNXw+7a+i9nRPOhTx5p8RJs+AxBPc3TEsHb1eKXx59iI+Wt0ZI6
	/tQRhV5KpV1GK5Ruey9s8Pzr4r4i0s0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-4JBC-iLFNpum_AD3n3AJXA-1; Fri,
 16 Jan 2026 13:46:24 -0500
X-MC-Unique: 4JBC-iLFNpum_AD3n3AJXA-1
X-Mimecast-MFC-AGG-ID: 4JBC-iLFNpum_AD3n3AJXA_1768589180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55617180035D;
	Fri, 16 Jan 2026 18:46:20 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0730119560A7;
	Fri, 16 Jan 2026 18:46:11 +0000 (UTC)
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
	Saravana Kannan <saravanak@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	devicetree@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 00/12] dpll: Core improvements and ice E825-C SyncE support
Date: Fri, 16 Jan 2026 19:45:58 +0100
Message-ID: <20260116184610.147591-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

DT Bindings:
* Provider Support: The dpll-device schema is updated to support
  '#dpll-pin-cells', allowing providers to define pin specifiers
  (index/direction).
* Core Schema: The core schema definitions for pin consumers and
  providers have been submitted to dt-schema (PR #183).

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
Patch 1: DT bindings (Provider support).
Patch 2-3: DPLL Core (fwnode association and parsing helpers).
Patch 4: Driver zl3073x (Set fwnode).
Patch 5-6: DPLL Core (Notifiers and dynamic IDs).
Patch 7: Driver zl3073x (Mux type).
Patch 8-9: DPLL Core (Refcount refactor and duplicate checks).
Patch 10-11: Refcount tracking infrastructure and driver updates.
Patch 12: Driver ice (E825-C SyncE logic).

Changes in v2:
- Removed dpll-pin-consumer.yaml schema per request (submitted to dt-schema).
- Added '#dpll-pin-cells' property into dpll-device.yaml and
  microchip,zl30731.yaml.
- Added include/dt-bindings/dpll/dpll.h
- Added check for fwnode_property_match_string() return value.
- Reworked searching for the pin using dpll device phandle and pin specifier
  logic.
- Added dpll-pins into OF core supplier_bindings.
- Fixed integer overflow in dpll_pin_idx_free().
- Fixed error path in ice_dpll_init_pins_e825().
- Fixed misleading comment referring 'device tree'.

Arkadiusz Kubalewski (1):
  ice: dpll: Support E825-C SyncE and dynamic pin discovery

Ivan Vecera (10):
  dt-bindings: dpll: support acting as pin provider
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

 .../devicetree/bindings/dpll/dpll-device.yaml |  10 +
 .../bindings/dpll/microchip,zl30731.yaml      |   4 +
 drivers/dpll/Kconfig                          |  15 +
 drivers/dpll/dpll_core.c                      | 374 ++++++++-
 drivers/dpll/dpll_core.h                      |  11 +
 drivers/dpll/dpll_netlink.c                   |   6 +
 drivers/dpll/zl3073x/dpll.c                   |  15 +-
 drivers/dpll/zl3073x/dpll.h                   |   2 +
 drivers/dpll/zl3073x/prop.c                   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 732 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  29 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  29 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 217 ++++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  16 +-
 drivers/of/property.c                         |   2 +
 drivers/ptp/ptp_ocp.c                         |  18 +-
 include/dt-bindings/dpll/dpll.h               |  13 +
 include/linux/dpll.h                          |  74 +-
 22 files changed, 1442 insertions(+), 158 deletions(-)
 create mode 100644 include/dt-bindings/dpll/dpll.h

-- 
2.52.0


