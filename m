Return-Path: <linux-rdma+bounces-18711-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOGrNj1jxWkJ+AQAu9opvQ
	(envelope-from <linux-rdma+bounces-18711-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 17:47:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8F338ABF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBC4F30903E5
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1140FD99;
	Thu, 26 Mar 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pisLqagj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91F4035CD;
	Thu, 26 Mar 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543204; cv=none; b=mJPOPdO8twPDzSqtwwy74+gCJnqE1Up6ToPA6vLThG99qYeQRjctwX+She/+zcil7neKm6ayEBqniWqNH9YhV1sY9TLJ7gyvcwJTemBJULYuAgFRitudfLW7e5j2cdcfvFHqElQPbB2Sd0KD4cZyRHbmjHbRjVRUB36FW1zV1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543204; c=relaxed/simple;
	bh=v9OxL3z6qKsfDWe7vgJygT5T/5mg3FeLB6gOdPjSyDk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AzwpW9huwKCjMnbMx3SFlL/M+7ZOzAVIYiZIp77Ap2h3AnY5WOw8Nd21+fB8oNIbiYvZDI3fyUfmtALHBhNFXAhdw/keQyHSTjceuEgewNng0cLINE/XjNKoZGEWYLal2r9dt95wh02nEQdVXfMFx5QpDoASVkvyDcz33meQqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pisLqagj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD1BC116C6;
	Thu, 26 Mar 2026 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774543203;
	bh=v9OxL3z6qKsfDWe7vgJygT5T/5mg3FeLB6gOdPjSyDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pisLqagj3vB7EHVWtrYeETBb1Gl8iQLkOtglrdUeLgotRTEpoTq6BAXEW845d4eTN
	 DbK7B6mnUv8MXwuZy+l8Ewm1Bp4/wszn0Itp3iNaoURdrX4Vzb+EMTyANgbZJpqO3+
	 Y641c7/ZpyRQV9qxCKNZmtH/wN1HWyA7PAFtaH/hUtCqlIJKajhEIgUGJlQoOvZKJ3
	 rP/VpkLPjhOnP6NMR2/N4iMdpN4DFyZxnqRQnK/c8/XChTyXH8pv6P0BGsONKLOFSU
	 QhDYiEU+YTg6LoechbtMk8kIA8WLWnwdnAeRqyKMIvrDYLDp35X3k32Bmf3LoSi0Bf
	 EE4YkDDj60FvA==
Date: Thu, 26 Mar 2026 11:40:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
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
	stable@vger.kernel.org, Gerd Bayer <gerd.bayer@de.ibm.com>
Subject: Re: [PATCH v6 1/2] PCI: AtomicOps: Do not enable without support in
 root complex
Message-ID: <20260326164002.GA1325368@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4183b471777efa949ce6f7b860c81282e91666ef.camel@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18711-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDE8F338ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:51:19AM +0100, Gerd Bayer wrote:
> On Wed, 2026-03-25 at 15:08 -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 25, 2026 at 04:16:17PM +0100, Gerd Bayer wrote:
> > > When inspecting the config space of a Connect-X physical function in an
> > > s390 system after it was initialized by the mlx5_core device driver, we
> > > found the function to be enabled to request AtomicOps despite the
> > > system's root-complex lacking support for completing them:
> > > 
> > > 1ed0:00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [ConnectX-6 Lx]
> > > 	Subsystem: Mellanox Technologies Device 0002
> > >   [...]
> > > 	DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> > > 		 AtomicOpsCtl: ReqEn+
> > > 		 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
> > > 		 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> > > 
> > > Turns out the device driver calls pci_enable_atomic_ops_to_root() which
> > > defaulted to enable AtomicOps requests even if it had no information
> > > about the root-port that the PCIe device is attached to. Similarly,
> > > AtomicOps requests are enabled for root complex integrated endpoints
> > > (RCiEPs) unconditionally.
> > > 
> > > Change the logic of pci_enable_atomic_ops_to_root() to fully traverse the
> > > PCIe tree upwards, check that the bridge devices support delivering
> > > AtomicOps transactions, and finally check that there is a root port at
> > > the end that does support completing AtomicOps - or that the support for
> > > completing AtomicOps at the root complex is announced through some other
> > > arch specific way.
> > > 
> > > Introduce a new pcibios_connects_to_atomicops_capable_rc() function to
> > > implement the check - and default to always "true". This leaves the
> > > semantics for today's RCiEPs intact. Pass in the device in question and
> > > the requested capabilities for future expansions.
> > > For s390, override pcibios_connects_to_atomicops_capable_rc() to
> > > always return "false".
> > > 
> > > Do not change the enablement of AtomicOps requests if there is no
> > > positive confirmation that the root complex can complete PCIe AtomicOps.
> > > 
> > > Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > ---
> > >  arch/s390/pci/pci.c |  5 +++++
> > >  drivers/pci/pci.c   | 48 +++++++++++++++++++++++++++++++-----------------
> > >  include/linux/pci.h |  1 +
> > >  3 files changed, 37 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > > index 2a430722cbe415dd56c92fed2e513e524f46481a..a0bef77082a153a258fbe4abb1070b22e020888e 100644
> > > --- a/arch/s390/pci/pci.c
> > > +++ b/arch/s390/pci/pci.c
> > > @@ -265,6 +265,11 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
> > >  	return rc;
> > >  }
> > >  
> > > +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > >  resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> > >  				       resource_size_t size,
> > >  				       resource_size_t align)
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8479c2e1f74f1044416281aba11bf071ea89488a..006aa589926cb290de43f152100ddaf9961407d1 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3660,6 +3660,19 @@ void pci_acs_init(struct pci_dev *dev)
> > >  	pci_disable_broken_acs_cap(dev);
> > >  }
> > >  
> > > +static bool pci_is_atomicops_capable_rp(struct pci_dev *dev, u32 cap, u32 cap_mask)
> > > +{
> > > +	if (!dev || !(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT))
> > > +		return false;
> > > +
> > > +	return (cap & cap_mask) == cap_mask;
> > > +}
> > > +
> > > +bool __weak pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask)
> > > +{
> > > +	return true;
> > > +}
> > > +
> > >  /**
> > >   * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
> > >   * @dev: the PCI device
> > > @@ -3676,8 +3689,9 @@ void pci_acs_init(struct pci_dev *dev)
> > >  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
> > >  {
> > >  	struct pci_bus *bus = dev->bus;
> > > -	struct pci_dev *bridge;
> > > -	u32 cap, ctl2;
> > > +	struct pci_dev *bridge = NULL;
> > > +	u32 cap = 0;
> > > +	u32 ctl2;
> > >  
> > >  	/*
> > >  	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
> > > @@ -3714,29 +3728,29 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
> > >  		switch (pci_pcie_type(bridge)) {
> > >  		/* Ensure switch ports support AtomicOp routing */
> > >  		case PCI_EXP_TYPE_UPSTREAM:
> > > -		case PCI_EXP_TYPE_DOWNSTREAM:
> > > -			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> > > -				return -EINVAL;
> > > -			break;
> > > -
> > > -		/* Ensure root port supports all the sizes we care about */
> > > -		case PCI_EXP_TYPE_ROOT_PORT:
> > > -			if ((cap & cap_mask) != cap_mask)
> > > -				return -EINVAL;
> > > -			break;
> > > -		}
> > > -
> > > -		/* Ensure upstream ports don't block AtomicOps on egress */
> > > -		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
> > > +			/* Upstream ports must not block AtomicOps on egress */
> > >  			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
> > >  						   &ctl2);
> > >  			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
> > >  				return -EINVAL;
> > > +			fallthrough;
> > > +		/* All switch ports need to route AtomicOps */
> > > +		case PCI_EXP_TYPE_DOWNSTREAM:
> > > +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> > > +				return -EINVAL;
> > > +			break;
> > >  		}
> > > -
> > >  		bus = bus->parent;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Finally, last bridge must be root port and support requested sizes
> > > +	 * or firmware asserts support
> > > +	 */
> > > +	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask) ||
> > > +	      pcibios_connects_to_atomicops_capable_rc(dev, cap_mask)))
> > > +		return -EINVAL;
> > 
> > Sashiko says:
> > 
> >   Since the generic weak implementation of
> >   pcibios_connects_to_atomicops_capable_rc() unconditionally returns
> >   true, the logical OR expression pci_is_atomicops_capable_rp(...) ||
> >   true will always evaluate to true. This makes the entire if
> >   condition evaluate to false.
> > 
> >   Because of this, it appears -EINVAL is never returned here, and any
> >   standard endpoint behind a Root Port will successfully be granted
> >   AtomicOps even if the Root Port lacks the capability in its
> >   PCI_EXP_DEVCAP2 register.
> 
> I've made the generic implementation of
> pcibios_connects_to_atomicops_capable_rc() default to return "true" to
> preserve the current code's handling of RCiEPs: Since they are not
> attached to a root port, their dev->bus->parent is NULL and the entire
> while-loop is bypassed - before this patch and after. (Sashiko was
> pointing at that being regressed with v4.)

The v4 patch definitely changed the behavior for RCiEPs: the current
v7.0-rc1 code always enables AtomicOps for RCiEPs, and the v4 patch
never enables AtomicOps for RCiEPs.  But I'm not sure this is a
regression.  It definitely *could* break an RCiEP, but AFAIK we have
no information about whether the RC supports AtomicOps, so enabling
them and telling the driver that AtomicOps work might be a lie.

IIUC, the motivation for this series was to avoid enabling AtomicOps
on s390 where there is no visible Root Port, and you have platform
knowledg that whatever is upstream from the endpoint in fact does not
support them.

I think we should avoid enabling AtomicOps unless we know for certain
that the completer (Root Port or RC) supports them.  To me that sounds
like:

  1) Never enable AtomicOps for RCiEPs.

  2) Only enable AtomicOps for endpoints below a Root Port that
  supports AtomicOps.

This could be two separate patches, where the second would fix the
s390 issue reported by Alexander.

If we come across RCiEPs that need AtomicOps and we somehow know that
the RC supports them, we can add a quirk or something to take
advantage of it.

We are still hand-waving about peer-to-peer transactions; we don't
even try to account for that because we don't know what peer might be
the completer.

> The whole point of pcibios_connects_to_atomicops_capable_rc() is to
> allow different architectures to implement a discriminator outside of
> PCIe's structure - potentially depending on CPU model or more.
> 
> The only point I wonder about: Should
> pcibios_connects_to_atomicops_capable_rc() default to return "false"
> and deliberately change the behavior for today's RCiEP's (if there are
> any...)?
> 
> > 
> > > +
> > >  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> > >  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
> > >  	return 0;
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..ef90604c39859ea8e61e5392d0bdaa1b0e43874b 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -692,6 +692,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> > >  				 void *release_data);
> > >  
> > >  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
> > > +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask);
> > >  
> > >  #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
> > >  
> > > 
> > > -- 
> > > 2.51.0
> > > 
> 
> Thanks,
> Gerd

