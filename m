Return-Path: <linux-rdma+bounces-16479-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L6NFUs1gmmVQgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16479-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:50:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33ADD183
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26751300F688
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B034D3B2;
	Tue,  3 Feb 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2S4V2Zs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB67320A00
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140423; cv=none; b=EdCqQM01QtNVt+6f8PrYo+5S8gX1frIdtUePb/XLNRR9vryoJNoc0uAJmCZDudytWYhGDSG/Zb5u0eRI+RIjd/8JBa8K6825vp5vbmTWTIyr4rw9mu2jOgyXNAD7JEIGb/9kEKh22fyqKrlnGI8ev2rjhvjFzvd/oX1kexGxiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140423; c=relaxed/simple;
	bh=HHvnBhkgNwwhh1fth8zIsWotnAY49QBqAvrx/DGxWYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/womI76CTQheUjGFsWFzZvFqw6igTOoZkFMjDj7JrqmDXiPg1o4j9KkJRUsXU7/vKY2A7IoOJFopUa/nJhBa6lvLyswmXU4I7e67P3+KDSvsz8kiY0+l3jMPQNzE9FQ20/lMWXIB5XcGUb6Cm22B4o6YucM/qqcAXIuozAbHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2S4V2Zs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770140421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LCv8SFYnaztbSil42TURSGs/yi8nv/V4GVb/geKh0eI=;
	b=N2S4V2ZsaKOi6FAqWvppHfbicjgmuf7kcGtjw0NjOEh1NBGvz+btnbZn969srAHgfYII1G
	wy3nsxeOV5uVeyqcpND/3AJnIO4tVzyudPwI7KfOaar40Ko226H86/7W1TN36at8zCQqrB
	STkcY7PSL9lehF/5buKmhW08ZCXpfbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-jmHyeyRQN1a2P8Vk7fR_4A-1; Tue,
 03 Feb 2026 12:40:14 -0500
X-MC-Unique: jmHyeyRQN1a2P8Vk7fR_4A-1
X-Mimecast-MFC-AGG-ID: jmHyeyRQN1a2P8Vk7fR_4A_1770140411
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BEE91956059;
	Tue,  3 Feb 2026 17:40:10 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4066030001A7;
	Tue,  3 Feb 2026 17:40:04 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 0/9] dpll: Core improvements and ice E825-C SyncE support
Date: Tue,  3 Feb 2026 18:39:53 +0100
Message-ID: <20260203174002.705176-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16479-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B33ADD183
X-Rspamd-Action: no action

This series introduces Synchronous Ethernet (SyncE) support for the Intel
E825-C Ethernet controller. Unlike previous generations where DPLL
connections were implicitly assumed, the E825-C architecture relies
on the platform firmware (ACPI) to describe the physical connections
between the Ethernet controller and external DPLLs (such as the ZL3073x).

To accommodate this, the series extends the DPLL subsystem to support
firmware node (fwnode) associations, asynchronous discovery via notifiers,
and dynamic pin management. Additionally, a significant refactor of
the DPLL reference counting logic is included to ensure robustness and
debuggability.

DPLL Core Extensions:
* Firmware Node Association: Pins can now be associated with a struct
  fwnode_handle after allocation via dpll_pin_fwnode_set(). This allows
  drivers to link pin objects with their corresponding DT/ACPI nodes.
* Asynchronous Notifiers: A raw notifier chain is added to the DPLL core.
  This allows the Ethernet driver to subscribe to events and react when
  the platform DPLL driver registers the parent pins, resolving probe
  ordering dependencies.
* Dynamic Indexing: Drivers can now request DPLL_PIN_IDX_UNSPEC to have
  the core automatically allocate a unique pin index.

Reference Counting & Debugging:
* Refactor: The reference counting logic in the core is consolidated.
  Internal list management helpers now automatically handle hold/put
  operations, removing fragile open-coded logic in the registration paths.
* Reference Tracking: A new Kconfig option DPLL_REFCNT_TRACKER is added.
  This allows developers to instrument and debug reference leaks by
  recording stack traces for every get/put operation.

Driver Updates:
* zl3073x: Updated to associate pins with fwnode handles using the new
  setter and support the 'mux' pin type.
* ice: Implements the E825-C specific hardware configuration for SyncE
  (CGU registers). It utilizes the new notifier and fwnode APIs to
  dynamically discover and attach to the platform DPLLs.

Patch Summary:
Patch 1: DPLL Core (fwnode association).
Patch 2: Driver zl3073x (Set fwnode).
Patch 3-4: DPLL Core (Notifiers and dynamic IDs).
Patch 5: Driver zl3073x (Mux type).
Patch 6: DPLL Core (Refcount refactor).
Patch 7-8: Refcount tracking infrastructure and driver updates.
Patch 9: Driver ice (E825-C SyncE logic).

Changes in v5:
* Fixed typo in patch 7
* Fixed issues found by AI in patch 9
... in v4:
* Fixed documentation and function stub issues found by AI

Arkadiusz Kubalewski (1):
  ice: dpll: Support E825-C SyncE and dynamic pin discovery

Ivan Vecera (7):
  dpll: Allow associating dpll pin with a firmware node
  dpll: zl3073x: Associate pin with fwnode handle
  dpll: Support dynamic pin index allocation
  dpll: zl3073x: Add support for mux pin type
  dpll: Enhance and consolidate reference counting logic
  dpll: Add reference count tracking support
  drivers: Add support for DPLL reference count tracking

Petr Oros (1):
  dpll: Add notifier chain for dpll events

 drivers/dpll/Kconfig                          |  15 +
 drivers/dpll/dpll_core.c                      | 288 ++++++-
 drivers/dpll/dpll_core.h                      |  11 +
 drivers/dpll/dpll_netlink.c                   |   6 +
 drivers/dpll/zl3073x/dpll.c                   |  15 +-
 drivers/dpll/zl3073x/dpll.h                   |   2 +
 drivers/dpll/zl3073x/prop.c                   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 755 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  30 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  32 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 217 +++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  16 +-
 drivers/ptp/ptp_ocp.c                         |  18 +-
 include/linux/dpll.h                          |  59 +-
 18 files changed, 1347 insertions(+), 150 deletions(-)

-- 
2.52.0


