Return-Path: <linux-rdma+bounces-17918-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPAqCZSTsGkukgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17918-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:56:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A062588C6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD56A310C95C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6973F1675;
	Tue, 10 Mar 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9XDLVkP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE543EE1EA;
	Tue, 10 Mar 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179560; cv=none; b=ojgy+P5zbGeMsRW7dHaaG63VdWt49ih6xJTcZeLgC7R/U3q4cVF1eqSWXa9h5Q8dbJIgbUGgKvt1xIu4CPot6LKLXBW5IkEnWrKJZceUuLzf5GoGUsIk3qopPQcmqhikFNgO/AKDSBmjRqf2u3g8tuIiBqHXJSLmcHZCjF9ZMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179560; c=relaxed/simple;
	bh=9DspE8ZzxPIkgad3kbhVNSegbVmg7d6ttJzOySzgDE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B458eZM6DLYMIhVcYvJ3iTpJHSdkP2a1aW19MwptkymzZ55B/luE9wSCoo0YsKer2Rn7aub+2M+ukTSU8dfHwUFwQOn/X4o5wkp+YSiAgDhCep5RjcNY3r9bR/aRpqfWqd4eDzI7CDe24V0kBZ+PHoebQw0+tYUhoblZ2JH95nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9XDLVkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C5BC2BCAF;
	Tue, 10 Mar 2026 21:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773179560;
	bh=9DspE8ZzxPIkgad3kbhVNSegbVmg7d6ttJzOySzgDE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V9XDLVkPIUguhDuLOIiUIpyMSxaGPliXRd7O6lqvaXBBvEXDJAKzrSK6ZeN/F1Xfh
	 jUA8CdDYMJjHcHrse0iQOy7CsVP5oqh1gKttZym7Wk6Onv3Ncjth8aMn072v+4820p
	 JKejxWFMoZQqjf88JQ0li2hVFTd+DM1a3rq34A1UjO2tDsqlw9JTVfizZAx8/rtcvY
	 /abfz1lpZSCUDNmBxqi74Xk88jjcSfHCeT71YpX9s6YQW1oPiEFKLHojqNVzUfWTPP
	 PFrtaONJFG1J9ZAyPMHvLg3W/QCkoN4xHt+XbVT6HcRyS6HZSJUvfdC6TETrMiH74y
	 aFgnA4khDntVQ==
Date: Tue, 10 Mar 2026 16:52:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: AtomicOps: Fix logic in enable function
Message-ID: <20260310215239.GA299126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-fix_pciatops-v3-2-99d12bcafb19@linux.ibm.com>
X-Rspamd-Queue-Id: 78A062588C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17918-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 06:13:59PM +0100, Gerd Bayer wrote:
> Move the check for root port requirements past the loop within
> pci_enable_atomic_ops_to_root() that checks on potential switch
> (up- and downstream) ports.
> 
> Inside the loop traversing the PCI tree upwards, prepend the switch case
> to validate the routing capability on any port with a fallthrough-case
> that does the additional check for Atomic Ops not being blocked on
> upstream ports.

Thanks for looking at this.  I think this makes good sense, and I'd
like to:

  - Hoist the problem description up here.  IIUC we enable AtomicOps on
    s390 when we shouldn't, which presumably leads to some problem.  I
    think the same could happen anywhere we don't have a Root Port,
    e.g., jailhouse, loongarch, maybe some VMM guests?

  - Reduce or remove the text above, which is basically C code
    translated to English, and move it down after the problem
    description, so we can state the problem and symptom, followed by
    the solution.

I think the core is (as you say below) that if there's no Root Port,
we previously allowed endpoints to use AtomicOps even in cases where
we don't know if the recipient supports them.

That *sounds* bad, and if you actually saw some kind of corruption as
a result, that would make this very compelling.

> Do not enable Atomic Op Requests if nothing can be learned about how the
> device is attached - e.g. if it is on an "isolated" bus, as in s390.
> 
> Reported-by: Alexander Schmidt <alexs@linux.ibm.com>

If there's any public report of the problem, include the URL here.

> Cc: stable@vger.kernel.org
> Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cc8abe6b1d07661488895876dbbcf8aaeadf4a17..23db6ad5f310ed009a9b2ca4933c7498e0d22b85 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3677,7 +3677,7 @@ void pci_acs_init(struct pci_dev *dev)
>  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  {
>  	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> +	struct pci_dev *bridge = NULL;
>  	u32 cap, ctl2;
>  
>  	/*
> @@ -3715,29 +3715,27 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)

Since we're looking at this, I think we should update the spec
references in this function (in a separate patch).  

  * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
  * in Device Control 2 is reserved in VFs and the PF value applies
  * to all associated VFs.

It looks like the AtomicOp Requester Enable part of PCIe r5.0, sec
9.3.5.10, was incorporated into the Device Control 2 Register
description in PCIe r7.0, sec 7.5.3.16.

  * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
  * AtomicOp requesters.  For now, we only support endpoints as
  * requesters and root ports as completers.  No endpoints as
  * completers, and no peer-to-peer.

This looks like PCIe r7.0, sec 6.15.  Same section as r4.0, but we
should at least make both of these refer to the same spec revision.

>  		switch (pci_pcie_type(bridge)) {
>  		/* Ensure switch ports support AtomicOp routing */
>  		case PCI_EXP_TYPE_UPSTREAM:
> -		case PCI_EXP_TYPE_DOWNSTREAM:
> -			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> -				return -EINVAL;
> -			break;
> -
> -		/* Ensure root port supports all the sizes we care about */
> -		case PCI_EXP_TYPE_ROOT_PORT:
> -			if ((cap & cap_mask) != cap_mask)
> -				return -EINVAL;
> -			break;
> -		}
> -
> -		/* Ensure upstream ports don't block AtomicOps on egress */
> -		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
> +			/* Upstream ports must not block AtomicOps on egress */
>  			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
>  						   &ctl2);
>  			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
>  				return -EINVAL;
> +			fallthrough;
> +		/* All switch ports need to route AtomicOps */
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> +				return -EINVAL;
> +			break;
>  		}
> -
>  		bus = bus->parent;
>  	}
>  
> +	/* Finally, last bridge must be root port and support requested sizes */
> +	if ((!bridge) ||
> +	    (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT) ||
> +	    ((cap & cap_mask) != cap_mask))
> +		return -EINVAL;
> +
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
>  	return 0;
> 
> -- 
> 2.51.0
> 

