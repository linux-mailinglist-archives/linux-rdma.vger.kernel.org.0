Return-Path: <linux-rdma+bounces-18906-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDYrOKtVzWk5cAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18906-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:28:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCD37EA76
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3F95301DBBD
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72C47B422;
	Wed,  1 Apr 2026 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJLnNRUc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FC3803C8;
	Wed,  1 Apr 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064484; cv=none; b=ZawHs0eUbroskicKoTVWYJVDclifthAepI7f6poMZDMoNJYZgmQ1nvVrnvFxbYnih59nn8SbbNAUKxBjLAsKr/GFJqhgwkLDLDNTLROotXZfJKwU60lWgGR1KhO4qBx7YRO/lOsTdJJnv1GKQr8WMiljIVUjK11GQ4J8Q5jZ9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064484; c=relaxed/simple;
	bh=WVTA4OG5W7TsxKmU7pn8e5/Mped50Dcrq1sV28Cw8AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FgJoadqt+GVNTV2unzpjfzpuSIDiIKudFwIcomQq/dSROG2qNuCDnM1jGN7vtCeUMHvkBcJT7Hp+GSCIwKD0o2bBCCPK1EqYQV5gMOWkV4tcykSjIIlyLsQOyn5jrbQu05B3dTGtd3pLdbJhHpqEE4a0rS+5VMkgqgpT//bs754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJLnNRUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A5FC4CEF7;
	Wed,  1 Apr 2026 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775064484;
	bh=WVTA4OG5W7TsxKmU7pn8e5/Mped50Dcrq1sV28Cw8AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gJLnNRUc5SgBLvBF4Zbsg6p0t+2Voec1ATw2SVfEG93XkOMhxcn5dhlMnLVFvfMQD
	 ImcY4nxuq6IY09ybsJb+zmzZlpNBLUvrHY1nyHrk/eIuwqSTwSwTUc81uDuekmC9Ev
	 AFAN2U+Ih3Dgd2Ha/zvm+fBTg/BLjzria7/v0cjftNJbAax0sBsyr+vX55ONHczWAe
	 12ipMXlgoiHMQ/udIDzzVLukHXTsB/coMif7qeTzCK5mVqFfVz+urffCRatZ3bj/ut
	 mI1XfkyHrIrYf1DvczA/xwwNXN9A8JjUxVjqmgg2S90V/Z5wG1JoKscHoFhKQX/ZFd
	 hh/UPffKPM+Jg==
Date: Wed, 1 Apr 2026 12:27:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 2/3] PCI: AtomicOps: Do not enable without support in
 root port
Message-ID: <20260401172757.GA226107@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-fix_pciatops-v7-2-f601818417e8@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18906-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DCCD37EA76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:09:45PM +0200, Gerd Bayer wrote:
> When inspecting the config space of a Connect-X physical function in an
> s390 system after it was initialized by the mlx5_core device driver, we
> found the function to be enabled to request AtomicOps despite the
> system's root-complex lacking support for completing them:
> 
> 1ed0:00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [ConnectX-6 Lx]
> 	Subsystem: Mellanox Technologies Device 0002
>   [...]
> 	DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		 AtomicOpsCtl: ReqEn+
> 		 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
> 		 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> 
> Turns out the device driver calls pci_enable_atomic_ops_to_root() which
> defaulted to enable AtomicOps requests even if it had no information
> about the root port that the PCIe device is attached to.
> 
> Change the logic of pci_enable_atomic_ops_to_root() to fully traverse the
> PCIe tree upwards, check that the bridge devices support delivering
> AtomicOps transactions, and finally check that there is a root port at
> the end that does support completing AtomicOps.
> 
> Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

OK, I think this is set to go.  It sounds like there are no RCiEPs
that we need to worry about.

I think pci_enable_atomic_ops_to_root() will end up more readable if
we check for the Root Port first and explicitly as in the modified
version.  I *think* it's equivalent but can't easily test it.  What do
you think?

commit 2f3f32f2c180 ("PCI: Enable AtomicOps only if Root Port supports them")
Author: Gerd Bayer <gbayer@linux.ibm.com>
Date:   Mon Mar 30 15:09:45 2026 +0200

    PCI: Enable AtomicOps only if Root Port supports them
    
    When inspecting the config space of a Connect-X physical function in an
    s390 system after it was initialized by the mlx5_core device driver, we
    found the function to be enabled to request AtomicOps despite the Root Port
    lacking support for completing them:
    
      00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [ConnectX-6 Lx]
              Subsystem: Mellanox Technologies Device 0002
              DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                       AtomicOpsCtl: ReqEn+
    
    On s390 and many virtualized guests, the Endpoint is visible but the Root
    Port is not.  In this case, pci_enable_atomic_ops_to_root() previously
    enabled AtomicOps in the Endpoint even though it couldn't tell whether
    the Root Port supports them as a completer.
    
    Change pci_enable_atomic_ops_to_root() to fail if there's no Root Port or
    the Root Port doesn't support AtomicOps.
    
    Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
    Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
    Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 135e5b591df4..515f565a4a70 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3675,8 +3675,7 @@ void pci_acs_init(struct pci_dev *dev)
  */
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
-	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *root, *bridge;
 	u32 cap, ctl2;
 
 	/*
@@ -3705,35 +3704,35 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		return -EINVAL;
 	}
 
-	while (bus->parent) {
-		bridge = bus->self;
+	root = pcie_find_root_port(dev);
+	if (!root)
+		return -EINVAL;
 
-		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
+	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
+	if ((cap & cap_mask) != cap_mask)
+		return -EINVAL;
 
+	bridge = pci_upstream_bridge(dev);
+	while (bridge != root) {
 		switch (pci_pcie_type(bridge)) {
-		/* Ensure switch ports support AtomicOp routing */
 		case PCI_EXP_TYPE_UPSTREAM:
-		case PCI_EXP_TYPE_DOWNSTREAM:
-			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
-				return -EINVAL;
-			break;
-
-		/* Ensure root port supports all the sizes we care about */
-		case PCI_EXP_TYPE_ROOT_PORT:
-			if ((cap & cap_mask) != cap_mask)
-				return -EINVAL;
-			break;
-		}
-
-		/* Ensure upstream ports don't block AtomicOps on egress */
-		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
+			/* Upstream ports must not block AtomicOps on egress */
 			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
 						   &ctl2);
 			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
 				return -EINVAL;
+			fallthrough;
+
+		/* All switch ports need to route AtomicOps */
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2,
+						   &cap);
+			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
+				return -EINVAL;
+			break;
 		}
 
-		bus = bus->parent;
+		bridge = pci_upstream_bridge(bridge);
 	}
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,

