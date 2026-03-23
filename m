Return-Path: <linux-rdma+bounces-18529-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KZwNKWLwWlxTwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18529-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 19:51:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917092FB9BC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 19:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5707D308A67D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC22F747A;
	Mon, 23 Mar 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwlRP2Hh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCF2F4A0C;
	Mon, 23 Mar 2026 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291434; cv=none; b=Ac2FgBKxph2fZLEnhUMMc69k4Hcf5RRWIFCSzxz9aWO6TDRitZLQYYW9KEKJFnx7ny45qDCLHoOfalADdRC1asgCM33C42dfwIT46TJXkrsIfSSM5nYaL7tlJvDPl7E8wd27Vm/13WUwA15gwcmnLi1pUnBT2EOF3lBvfXOOmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291434; c=relaxed/simple;
	bh=BnDiV8ytQlshCFNFNCsjkLObdceDwr67Or+iSq8MRC0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X/SlYIpfGmKnvRq8GWZ6FRMoGwytS3R79NHbIgK1N7ah8Qt7/XOm6TuSFW+llZhFeUx7Dp0r1by/URpRK009MPEMOZS7RoBbbDE/63ysXzo/+HfYARrm66C1LEA2x2uo0OGiRukQjGQ5YUAJrGvctDvZO+P5kW4GARPGWmcJNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwlRP2Hh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774291430; x=1805827430;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BnDiV8ytQlshCFNFNCsjkLObdceDwr67Or+iSq8MRC0=;
  b=gwlRP2HhF4QOLrnlNnRQDWV/WxYdny1S7obTIi+X1rUvRnjfb66GdS3/
   TipAqbyVNRJbwmbJ+DNcAgZjvljtEqRnrEyC6P/NIYmNGCM6DwAmAk1jc
   LZMCRytWgvtRHa76Br7swy5DkWwk5y/c9lEo2L/qx71j6ALph3TB82Sey
   rf8zDIbae4EjwHwEmpEQ35SqzRaMOEZsT/N5vs1HYS+tG66YT0yvc/g2u
   DATiZUKzo+qkM/hL2Ownkl2yQQCcl1HiiQqi2ptgkH5ZE7pyKbKaCT3Pa
   kR5DGZy4/N5B81oEAcoVNTADQdtDT4VDw2E5Qp1klS1mD77aB7lHrnCqy
   g==;
X-CSE-ConnectionGUID: Nzs8be/QT3qG8LzrCx+hKA==
X-CSE-MsgGUID: brDF7ksrQFmeDZcWWGa0xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75319676"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75319676"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 11:43:49 -0700
X-CSE-ConnectionGUID: pMtp41bXQdO7UvfgROCi6g==
X-CSE-MsgGUID: lsNIaCopSY2w13HeHCiJzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228593573"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.49])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 11:43:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 23 Mar 2026 20:43:34 +0200 (EET)
To: Gerd Bayer <gbayer@linux.ibm.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>, 
    Felix Kuehling <Felix.Kuehling@amd.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>, 
    Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v5 1/2] PCI: AtomicOps: Do not enable without support in
 root complex
In-Reply-To: <20260323-fix_pciatops-v5-1-fada7233aea8@linux.ibm.com>
Message-ID: <fc27b178-cf08-8f6a-5441-9fca908f4aa2@linux.intel.com>
References: <20260323-fix_pciatops-v5-0-fada7233aea8@linux.ibm.com> <20260323-fix_pciatops-v5-1-fada7233aea8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18529-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 917092FB9BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026, Gerd Bayer wrote:

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
> AtomicOps requests are enabled for root-complex integrated endpoints
> (RCiEPs) unconditionally.
> 
> Change the logic of pci_enable_atomic_ops_to_root() to fully traverse the
> PCIe tree upwards, check that the bridge devices support delivering
> AtomicOps transactions, and finally check that there is a root-port at
> the end that does support completing AtomicOps - or that the support for
> completing AtomicOps at the root complex is announced through some other
> arch-specific way.
> 
> This announcement is implemented through the new
> pcibios_connects_to_atomicops_capable_rc() function - with a default
> implementation to always return "true" to leave the semantics for RCiEPs
> intact. For s390, override pcibios_connects_to_atomicops_capable_rc() to
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
>  drivers/pci/pci.c   | 46 +++++++++++++++++++++++++++++-----------------
>  include/linux/pci.h |  1 +
>  3 files changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2a430722cbe415dd56c92fed2e513e524f46481a..a13235d3218e8ca451e25fe8d9094500fa21aa26 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -265,6 +265,11 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
>  	return rc;
>  }
>  
> +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *pdev, u32 cap_mask)
> +{
> +	return false;
> +}
> +
>  resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f1044416281aba11bf071ea89488a..c1143f8e6b2a0f029feb3c4390ac6f33837f6de1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3660,6 +3660,21 @@ void pci_acs_init(struct pci_dev *dev)
>  	pci_disable_broken_acs_cap(dev);
>  }
>  
> +

Extra newline.

> +static bool pci_is_atomicops_capable_rp(struct pci_dev *dev, u32 cap, u32 cap_mask)
> +{
> +	if ((!dev) ||

Unnecessary parenthesis.

> +	     !(pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT))

This fits to one line.

> +		return false;
> +
> +	return ((cap & cap_mask) == cap_mask);

Extra parenthesis.

> +}
> +
> +bool __weak pcibios_connects_to_atomicops_capable_rc(struct pci_dev *pdev, u32 cap_mask)
> +{
> +	return true;
> +}
> +
>  /**
>   * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
>   * @dev: the PCI device
> @@ -3676,7 +3691,7 @@ void pci_acs_init(struct pci_dev *dev)
>  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  {
>  	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> +	struct pci_dev *bridge = NULL;
>  	u32 cap, ctl2;
>  
>  	/*
> @@ -3714,29 +3729,26 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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
> +	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask) ||
> +	     pcibios_connects_to_atomicops_capable_rc(dev, cap_mask)))
> +		return -EINVAL;
> +
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
>  	return 0;
> @@ -3813,7 +3825,7 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
>  
>  err_out:
>  	pci_warn(pdev, "BAR %d: can't reserve %pR\n", bar,
> -		 &pdev->resource[bar]);
> +			&pdev->resource[bar]);

Unrelated change.

>  	return -EBUSY;
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..498f266c9838c55e9b03d03fef49a82358047f4f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -692,6 +692,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  				 void *release_data);
>  
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
> +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *pdev, u32 cap_mask);
>  
>  #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
>  
> 
> 

-- 
 i.


