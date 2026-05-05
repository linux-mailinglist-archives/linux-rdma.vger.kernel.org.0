Return-Path: <linux-rdma+bounces-19969-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBsOApk0+WkG6gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19969-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:06:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23A4C51B0
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4613039CA2
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C161EEE6;
	Tue,  5 May 2026 00:03:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916E240DFDA;
	Tue,  5 May 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939422; cv=none; b=K3EjMNdpNFgarGXbHOHftDX7CF2SbADKW1oGWeorFMp+EV8YTQN/cSQVg3HhNHYHOprLwIWS+wtpw3+sXyfqDgNAOaWzxcsuZp3nOzhAnl6+5st3mIsKk0Ke048zjSbKm/NlAqnaeuyPTri3z76CEEJem5xwVQt1W8GMs5unIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939422; c=relaxed/simple;
	bh=DHRz70Uo8B2FnHnKsVX8mUEtmQ7/qOybRXfNRinc8G4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oudW7yGcLrBnzHviPKATkGJxuS3+d4iJVQE9fYdCbugUL7ptzzAghRFGNuU5IyaAhN9DhII/NXWCC2UOUg0FWMLl6qMiSbx6FGQ7Aqrv25c0QPDPcyQu2o/Sov6j6YukUuLW2Mr7IEAqeGEI0S5cc8ZAhErck8gBfHvaEzlz3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 916C492009D; Tue,  5 May 2026 02:03:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8B34C92009B;
	Tue,  5 May 2026 01:03:39 +0100 (BST)
Date: Tue, 5 May 2026 01:03:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
    Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Export pci_parent_bus_reset() for drivers to
 use
In-Reply-To: <alpine.DEB.2.21.2605050042390.46195@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605050051390.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605050042390.46195@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 9C23A4C51B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19969-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.863];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,angie.orcam.me.uk:mid]

Export pci_parent_bus_reset() so that drivers do not duplicate it.  
Document the interface.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Changes from v1, 
<https://lore.kernel.org/r/alpine.DEB.2.21.2306200231020.14084@angie.orcam.me.uk/>:

- Reword function description so as to list the return values separately.
---
 drivers/pci/pci.c   |   17 ++++++++++++++++-
 include/linux/pci.h |    1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

linux-pci-parent-bus-reset-export.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -4833,7 +4833,21 @@ int pci_bridge_secondary_bus_reset(struc
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
-static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
+/**
+ * pci_parent_bus_reset - Reset a device via its upstream PCI bridge
+ * @dev: Device to reset.
+ * @probe: Only check if reset is possible if TRUE, actually reset if FALSE.
+ *
+ * Perform a device reset by requesting a secondary bus reset via the
+ * device's immediate upstream PCI bridge.  Return failure if the reset
+ * failed or it could not have been issued in the first place because
+ * the device is not on a secondary bus of any PCI bridge or it wouldn't
+ * be the only device reset.  If probing, then only verify whether it
+ * would be possible to issue a reset.
+ *
+ * Returns: 0 if successful or -ENOTTY otherwise.
+ */
+int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *pdev;
 
@@ -4850,6 +4864,7 @@ static int pci_parent_bus_reset(struct p
 
 	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
+EXPORT_SYMBOL_GPL(pci_parent_bus_reset);
 
 static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 {
Index: linux-macro/include/linux/pci.h
===================================================================
--- linux-macro.orig/include/linux/pci.h
+++ linux-macro/include/linux/pci.h
@@ -1595,6 +1595,7 @@ int devm_request_pci_bus_resources(struc
 
 /* Temporary until new and working PCI SBR API in place */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
+int pci_parent_bus_reset(struct pci_dev *dev, bool probe);
 
 #define __pci_bus_for_each_res0(bus, res, ...)				\
 	for (unsigned int __b = 0;					\

