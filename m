Return-Path: <linux-rdma+bounces-14961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C1CB7094
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65765300983B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923B431A07F;
	Thu, 11 Dec 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbqGWXB0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE1258CD9
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482495; cv=none; b=MNJvXgv82jc+zoauGYscoeLsQ7aM2l0IgccALh9mnrthLfvRC4MmFG6Hw1GMySPOLNF4bhcNI0c3BLOIDyldRXFzGbHHmm5Zzx01T7lQUj52BDQHgzLGX1yQ6TzbiHoPHCypSKHH4Ki3odkEJSmz+T/B5F0TB9U1FiTIZgfIaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482495; c=relaxed/simple;
	bh=03Pl0EAIDgPI9vnDHXIs14bleahlQdzzdGQ93ZIGV8U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t39LGZ8QJS2go/1Vp1t2C+Hrb0AvxNZla7k8BH2xyLzXfgwZ9R9GkY9F4K14Ywv7J7xHKcwl5Wj20MvX0Z1/Gcpsk3mX+U99AjpH4MWZIC/vJ6M6dbnxD87qMOeTXz0S+IYAsClQ5bfutTxBfPr01acXbVhWW/j4In2pw7ckZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbqGWXB0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j1/uoB3Ms91T8przm8WNo02MG8iZMujEgt+YwxCU8nw=;
	b=WbqGWXB0FUeh9OlF8P7amPJRkDDRU0JBis2u3MICVeIGbVc4BGdAGGH0xkvR0MvzRH048D
	typIbtDK+/T9RddzJEDesvZ6g6U61erApbmofTdzcD4JGd3X9Z9Q28lJVW5SvNya4OMQgQ
	pKgh8er1e9LtwpmJp6QIT9qmxV4aGBU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-DIoxkukSNOCLiaK1yi1aGQ-1; Thu,
 11 Dec 2025 14:48:11 -0500
X-MC-Unique: DIoxkukSNOCLiaK1yi1aGQ-1
X-Mimecast-MFC-AGG-ID: DIoxkukSNOCLiaK1yi1aGQ_1765482488
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25519195609E;
	Thu, 11 Dec 2025 19:48:07 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26E361956056;
	Thu, 11 Dec 2025 19:47:57 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next 00/13] dpll: Core improvements and ice E825-C SyncE support
Date: Thu, 11 Dec 2025 20:47:43 +0100
Message-ID: <20251211194756.234043-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
* Patch 10-12:
  Adds REF_TRACKER infrastructure and updates drivers (zl3073x, ice) to
  support it.
* Patch 13:
  Implements the E825-C SyncE logic in the ice driver using the new
  infrastructure.

Arkadiusz Kubalewski (1):
  ice: dpll: Support E825-C SyncE and dynamic pin discovery

Ivan Vecera (11):
  dt-bindings: net: ethernet-controller: Add DPLL pin properties
  dpll: Allow registering pin with firmware node
  net: eth: Add helpers to find DPLL pin firmware node
  dpll: zl3073x: register pins with fwnode handle
  dpll: Support dynamic pin index allocation
  dpll: zl3073x: Add support for mux pin type
  dpll: Enhance and consolidate reference counting logic
  dpll: Prevent duplicate registrations
  dpll: Add reference count tracking support
  dpll: zl3073x: Enable reference count tracking
  ice: dpll: Enable reference count tracking

Petr Oros (1):
  dpll: Add notifier chain for dpll events

 .../bindings/net/ethernet-controller.yaml     |  13 +
 drivers/dpll/Kconfig                          |  15 +
 drivers/dpll/dpll_core.c                      | 290 ++++-
 drivers/dpll/dpll_core.h                      |  11 +
 drivers/dpll/dpll_netlink.c                   |   6 +
 drivers/dpll/zl3073x/dpll.c                   |  15 +-
 drivers/dpll/zl3073x/dpll.h                   |   1 +
 drivers/dpll/zl3073x/prop.c                   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 995 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  33 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  29 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 223 ++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  14 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  13 +-
 drivers/ptp/ptp_ocp.c                         |  16 +-
 include/linux/dpll.h                          |  58 +-
 include/linux/etherdevice.h                   |   4 +
 net/ethernet/eth.c                            |  20 +
 22 files changed, 1616 insertions(+), 161 deletions(-)

-- 
2.51.2


