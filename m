Return-Path: <linux-rdma+bounces-17917-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGoVI5eSsGkukgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17917-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:52:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E16BB258854
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3043140A1A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FFE3F1667;
	Tue, 10 Mar 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxjUxOUx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D736B05F;
	Tue, 10 Mar 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179364; cv=none; b=lv7tDyUcye5ibIcngfEUFDs1Vth+1oW0NvIWTKQs88yzQ+mtQMYzTA344NbG+tFJWHK/aMWAp1HB/ZE3H1kbcyupH/8seSm0dfXp8VX+CajZDZ/eGp5WZmex5fd1BLmbK5c8Mu5a8m8gYG0EEMpACTQCB9p+CEPskSUROxgob4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179364; c=relaxed/simple;
	bh=tK246CyPuH0GYnc+TNDlT4bGAapUUzHs7LgTfOYeSt8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MdN7dnJ4hkBnoLLdx6o8HPyVbycWonOEiyfh29Kg196xn3UB7majDiPVAGs+saG9AQsZTStslxUftOLJzId6j4hQxdxU9VirGt8ySyUpOP/8ZHRQvfC5wqZhZIpnVbkVG9YQu2TPEYFn/AHFhTqrKYeAaIorVSf8j4yrb2rbiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxjUxOUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AFFC19423;
	Tue, 10 Mar 2026 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773179364;
	bh=tK246CyPuH0GYnc+TNDlT4bGAapUUzHs7LgTfOYeSt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kxjUxOUxKrRqdiDSk20kQWKBnZYRy16tDIaHdw8eqUAl2lOrdsCXk1/P62HJIKF5B
	 0iFk4U2+mO0J58DylcVlZf7h2odysxJwQmmwgM35t75Ctvsg2fGlq/USQjx7lwAekr
	 w/VIwwiwBdHHhboWZJ5LaYBbGDyDoTaOcn2NxQrmsnx2ArUQ0+Dd8PDJg+5Rw1OHJT
	 L+g5I8ebcwEhE54OilH7o9RALvvWqwlcA4XB8sEAAl6Oac03CoNuK/de4baDdJ9wvN
	 lSa4kYM/g56dQS/ntGO7Ud87d2hNlLtBCql1IEcuhoVHSm6mh4popzvpg6U6EWiCzZ
	 uX0E6EvOF9Tyw==
Date: Tue, 10 Mar 2026 16:49:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: AtomicOps: Define valid root port
 capabilities
Message-ID: <20260310214923.GA823330@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-fix_pciatops-v3-1-99d12bcafb19@linux.ibm.com>
X-Rspamd-Queue-Id: E16BB258854
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17917-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 06:13:58PM +0100, Gerd Bayer wrote:
> Provide the two combinations of Atomic Op Completion size attributes
> that a root port may support per PCIe Spec 7.0 section 6.15.3.1. -
> besides the trivial "No support" - as two new defines.
> 
> Change documentation of pci_enable_atomic_ops_to_root() that these are
> the only ones that should be used. Also, spell out that all requested
> capabilities need to be supported at the root port for enable to
> succeed. Also emphasize that on success, this sets AtomicOpsCtl:ReqEn to
> 1, and leaves it untouched in case of failure.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/pci/pci.c             | 13 +++++++------
>  include/uapi/linux/pci_regs.h |  8 ++++++++
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f1044416281aba11bf071ea89488a..cc8abe6b1d07661488895876dbbcf8aaeadf4a17 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3663,15 +3663,16 @@ void pci_acs_init(struct pci_dev *dev)
>  /**
>   * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
>   * @dev: the PCI device
> - * @cap_mask: mask of desired AtomicOp sizes, including one or more of:
> - *	PCI_EXP_DEVCAP2_ATOMIC_COMP32
> - *	PCI_EXP_DEVCAP2_ATOMIC_COMP64
> - *	PCI_EXP_DEVCAP2_ATOMIC_COMP128
> + * @cap_mask: root port must support combinations of AtomicOp sizes
> + *	PCI_EXP_ROOT_PORT_ATOMIC_BASE
> + *	PCI_EXP_ROOT_PORT_ATOMIC_FULL
>   *
>   * Return 0 if all upstream bridges support AtomicOp routing, egress
>   * blocking is disabled on all upstream ports, and the root port supports
> - * the requested completion capabilities (32-bit, 64-bit and/or 128-bit
> - * AtomicOp completion), or negative otherwise.
> + * all the requested completion capabilities (BASE: 32-bit, 64-bit or
> + * FULL: 32/64- and 128-bit AtomicOp completion). In that case enable the
> + * device to send AtomicOp requests. Otherwise, return negative and leave
> + * the enablement in the PCI config space untouched.
>   */
>  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  {
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350d5442192162225b5e5202dbe2308..63ac62b882a94c6873a0db433ba808332ddbea04 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -669,6 +669,14 @@
>  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp completion */
>  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
>  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
> +/* PCIe spec 7.0 6.15.3.1: Root ports may support one of 2 sets of Atomic Ops */
> +#define  PCI_EXP_ROOT_PORT_ATOMIC_BASE		\
> +	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
> +	 PCI_EXP_DEVCAP2_ATOMIC_COMP64)
> +#define  PCI_EXP_ROOT_PORT_ATOMIC_FULL		\
> +	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
> +	 PCI_EXP_DEVCAP2_ATOMIC_COMP64 |	\
> +	 PCI_EXP_DEVCAP2_ATOMIC_COMP128)

I'm sort of ambivalent about this patch, partly because it adds
these #defines that aren't used anywhere.  Also, the "BASE" and "FULL"
names don't contain as much information as mentioning COMP32, COMP64,
and COMP128 does.

If we *do* want this, I think these combo definitions are beyond the
scope of uapi/linux/pci_regs.h, which generally is just
transliteration of register bits from the spec.  They could possibly
go in linux/pci.h where pci_enable_atomic_ops_to_root() is declared.

>  #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
>  #define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
> 
> -- 
> 2.51.0
> 

