Return-Path: <linux-rdma+bounces-18659-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBz/F9pAxGlTxwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18659-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 21:08:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1872632B9D8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 21:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844E03047DF5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83936309F;
	Wed, 25 Mar 2026 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9Kn5rjL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C4F4F1;
	Wed, 25 Mar 2026 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469317; cv=none; b=Utloc6mUignDphi2XTgUiPBJhnRaSo6d6GMq8RX3wyRWoFnvtzGltqZIW6PFfMj+ArU9K+lwKdANLnCslBQ7tO2QN0wETW4hv0kqepWGjAi1COU6hoSSOt71P6CGl43qWvqMghWDk7sSB2QXfanZUGwVF10GO/paL3/KLIHEW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469317; c=relaxed/simple;
	bh=u0Cd5omrwW3YhsWw9m4ecHl9huofQib83nNWmHHNvaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g/ZEWvVUvtDougtFY+CmzeCM7/05Ly55P1SWq/v52HNPdueXyWrNL42CbJbIsPmZGUrwzLUg4LE03FoWbrrS3Ob3Ep/HIj7yuS86ZY4Dn3dd75w2LjkQV+LVFPr+AQvsw0EZjmi9H5lyFA/YHFTMPwhauj+xuFtUI26i92YtHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9Kn5rjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06011C4CEF7;
	Wed, 25 Mar 2026 20:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774469317;
	bh=u0Cd5omrwW3YhsWw9m4ecHl9huofQib83nNWmHHNvaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z9Kn5rjLrhwK1kdqyaXdq9wyvg4ZxB1tPZ9jrqFS7RwJK2jJUBL+K3GypmqN49WUc
	 7DF+RGwWI5JuMyhsC0VEXPeh93v1wJO7JvfeAJO0ldnRt6wJfPjLvSBUQai2E9Z94y
	 rYO+BbiXWGd1o+13OdefEL0nuHWpvX+F0iemDZ2+CKOk6mHrz7Le9Q+mA03UxWfvFO
	 VB5JM9Ml5U+22RVNF76VLqtK+gMk2Oz4adIOgGsd3tIKIV+b0RbOP1CEW5SPVZZMvh
	 FGpia0iUKWLj+azTSqC1objNUboZrH/JXpm/l94LrGqBGhna07ebvTkNnVrNiN6EjE
	 Vh7QS5w2CLHOg==
Date: Wed, 25 Mar 2026 15:08:35 -0500
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
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] PCI: AtomicOps: Do not enable without support in
 root complex
Message-ID: <20260325200835.GA1290451@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-fix_pciatops-v6-1-10bf19d76dd1@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18659-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1872632B9D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 04:16:17PM +0100, Gerd Bayer wrote:
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
> about the root-port that the PCIe device is attached to. Similarly,
> AtomicOps requests are enabled for root complex integrated endpoints
> (RCiEPs) unconditionally.
> 
> Change the logic of pci_enable_atomic_ops_to_root() to fully traverse the
> PCIe tree upwards, check that the bridge devices support delivering
> AtomicOps transactions, and finally check that there is a root port at
> the end that does support completing AtomicOps - or that the support for
> completing AtomicOps at the root complex is announced through some other
> arch specific way.
> 
> Introduce a new pcibios_connects_to_atomicops_capable_rc() function to
> implement the check - and default to always "true". This leaves the
> semantics for today's RCiEPs intact. Pass in the device in question and
> the requested capabilities for future expansions.
> For s390, override pcibios_connects_to_atomicops_capable_rc() to
> always return "false".
> 
> Do not change the enablement of AtomicOps requests if there is no
> positive confirmation that the root complex can complete PCIe AtomicOps.
> 
> Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c |  5 +++++
>  drivers/pci/pci.c   | 48 +++++++++++++++++++++++++++++++-----------------
>  include/linux/pci.h |  1 +
>  3 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2a430722cbe415dd56c92fed2e513e524f46481a..a0bef77082a153a258fbe4abb1070b22e020888e 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -265,6 +265,11 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
>  	return rc;
>  }
>  
> +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask)
> +{
> +	return false;
> +}
> +
>  resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f1044416281aba11bf071ea89488a..006aa589926cb290de43f152100ddaf9961407d1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3660,6 +3660,19 @@ void pci_acs_init(struct pci_dev *dev)
>  	pci_disable_broken_acs_cap(dev);
>  }
>  
> +static bool pci_is_atomicops_capable_rp(struct pci_dev *dev, u32 cap, u32 cap_mask)
> +{
> +	if (!dev || !(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT))
> +		return false;
> +
> +	return (cap & cap_mask) == cap_mask;
> +}
> +
> +bool __weak pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask)
> +{
> +	return true;
> +}
> +
>  /**
>   * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
>   * @dev: the PCI device
> @@ -3676,8 +3689,9 @@ void pci_acs_init(struct pci_dev *dev)
>  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  {
>  	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> -	u32 cap, ctl2;
> +	struct pci_dev *bridge = NULL;
> +	u32 cap = 0;
> +	u32 ctl2;
>  
>  	/*
>  	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
> @@ -3714,29 +3728,29 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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
> +	/*
> +	 * Finally, last bridge must be root port and support requested sizes
> +	 * or firmware asserts support
> +	 */
> +	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask) ||
> +	      pcibios_connects_to_atomicops_capable_rc(dev, cap_mask)))
> +		return -EINVAL;

Sashiko says:

  Since the generic weak implementation of
  pcibios_connects_to_atomicops_capable_rc() unconditionally returns
  true, the logical OR expression pci_is_atomicops_capable_rp(...) ||
  true will always evaluate to true. This makes the entire if
  condition evaluate to false.

  Because of this, it appears -EINVAL is never returned here, and any
  standard endpoint behind a Root Port will successfully be granted
  AtomicOps even if the Root Port lacks the capability in its
  PCI_EXP_DEVCAP2 register.

> +
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
>  	return 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..ef90604c39859ea8e61e5392d0bdaa1b0e43874b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -692,6 +692,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  				 void *release_data);
>  
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
> +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask);
>  
>  #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
>  
> 
> -- 
> 2.51.0
> 

