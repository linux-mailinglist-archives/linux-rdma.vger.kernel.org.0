Return-Path: <linux-rdma+bounces-18856-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO6sFv8PzGnGNgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18856-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 20:18:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82DD36FDAF
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9533D309ED29
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388444B69C;
	Tue, 31 Mar 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3geoRpn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31A3BE653;
	Tue, 31 Mar 2026 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980593; cv=none; b=UHn98QjUO3seRiFXXUU9UpCD/IB5eqqO65zP1hZeKbtxpuZSiYHz6HeSo+nscX5MPnOzUmS/vo9lzCqZiVJ7akhjm2mqzwQUnflvlvhI68hgZ/EV9s0wvuC3JKdId7wsva2u+Iy/7Nwi9lcIiiW9MKZeQjuendlsuZLmFxFU4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980593; c=relaxed/simple;
	bh=nzQnfGUQ/Qrnk6+M3VmailVBuvjc3cVLymUFDIPNA4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n1LZmQQku6oNkOMnLS5rI1ihthe5KOr1a3TfZRi+1q/teH9C17muuosl5IG8PZawhyz/nucy9I+z7BXjdyzgSkTkGz1xbE7ya4Vu6S+eFkLoeIiv9BVdYqcD9tlPKR/bz3Nv1NfPB8BPbRUprDEy9GWX5HXLHatmmQlBo4Lf+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3geoRpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357C3C19423;
	Tue, 31 Mar 2026 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980593;
	bh=nzQnfGUQ/Qrnk6+M3VmailVBuvjc3cVLymUFDIPNA4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u3geoRpnG270ZeZJ1srTHgfO8a0IGZRX5t/zGwoajko1Nwdmgme7mTpirjy8m/nPo
	 kqJyhquoqNkQxT//G0PiEhABavJHjpO08Gl+554FJBFH2K0mqt3QHkMDdxVLiUC6BK
	 DTuZGxaj50I3m5v9AJv5yZzafEnvrKOzkmqeseMcuSY5kjL05Lk5WTsLcx3S3pPNEZ
	 xG6tAc5/PMiUEA7wqmM1UxODp/KTCiCRYC9vPmiBhVvwGK5UBU7Too/E1eh1ffr/SG
	 GMkdAzb7zVF+IXJrrHxSzjtfM0sRfHqKqjcfpmUzfWJAClGdCEaXwfOz570f3nRrNK
	 m1RW7D43O+ePw==
Date: Tue, 31 Mar 2026 13:09:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kuehling, Felix" <felix.kuehling@amd.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
Message-ID: <20260331180952.GA148118@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab40ebb-6ce6-490f-a22b-6b2ee873c085@amd.com>
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
	TAGGED_FROM(0.00)[bounces-18856-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: C82DD36FDAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 08:01:57PM -0400, Kuehling, Felix wrote:
> On 2026-03-30 17:42, Bjorn Helgaas wrote:
> > [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
> > 
> > On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
> > > Since root complex integrated end points (RCiEPs) attach to a bus that
> > > has no bridge device describing the root port, the capability to
> > > complete AtomicOps requests cannot be determined with PCIe methods.
> > > 
> > > Change default of pci_enable_atomic_ops_to_root() to not enable
> > > AtomicOps requests on RCiEPs.
> > I know I suggested this because there's nothing explicit that tells us
> > whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
> > that GPUs, infiniband HCAs, and NICs that use atomic ops may be
> > implemented as RCiEPs and would be broken by this.
> 
> FWIW, on AMD APUs our driver doesn't call pci_enable_atomic_ops_to_root. It
> just assumes that the GPU can do atomic accesses because it doesn't actually
> go through PCIe: https://elixir.bootlin.com/linux/v6.19.10/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4785

What does this mean for the other branch that *does* use
pci_enable_atomic_ops_to_root()?  Can any of those devices be RCiEPs?

> > These drivers use pci_enable_atomic_ops_to_root():
> > 
> >    amdgpu
> >    bnxt_re (infiniband)
> >    mlx5 (infinband)
> >    qedr (infiniband)
> >    mlx5 (ethernet)
> > 
> > Maybe we should assume that because RCiEPs are directly integrated
> > into the RC, the RCiEP would only allow AtomicOp Requester Enable to
> > be set if the RC supports atomic ops?
> > 
> > I don't like making assumptions like that, but it'd be worse to break
> > these devices.
> > 
> > [1] https://lore.kernel.org/all/20260326164002.GA1325368@bhelgaas
> > 
> > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > ---
> > >   drivers/pci/pci.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8479c2e1f74f1044416281aba11bf071ea89488a..135e5b591df405e87e7f520a618d7e2ccba55ce1 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3692,15 +3692,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
> > >   	/*
> > >   	 * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
> > > -	 * AtomicOp requesters.  For now, we only support endpoints as
> > > -	 * requesters and root ports as completers.  No endpoints as
> > > +	 * AtomicOp requesters.  For now, we only support (legacy) endpoints
> > > +	 * as requesters and root ports as completers.  No endpoints as
> > >   	 * completers, and no peer-to-peer.
> > >   	 */
> > >   	switch (pci_pcie_type(dev)) {
> > >   	case PCI_EXP_TYPE_ENDPOINT:
> > >   	case PCI_EXP_TYPE_LEG_END:
> > > -	case PCI_EXP_TYPE_RC_END:
> > >   		break;
> > >   	default:
> > >   		return -EINVAL;
> > > 
> > > -- 
> > > 2.51.0
> > > 

