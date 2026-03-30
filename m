Return-Path: <linux-rdma+bounces-18781-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAg2F4g7ymnD6gUAu9opvQ
	(envelope-from <linux-rdma+bounces-18781-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 10:59:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9267357A21
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26C9B300617D
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6B3AEF23;
	Mon, 30 Mar 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GcKciWWr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3956158DCF;
	Mon, 30 Mar 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861186; cv=none; b=oKxdUtdozbYSEK6R45byQA9tUCrjhdXN6nftZtqI+aAYshAgnJeatW53wd5rWd2LGd7ur3vqxblWIl6zF6pTLUC4feN2TeJB7WMUreXkzItzGC1fV2JmeC1+CtRvkbQZitZqx6/D8mxESIrvw//u5O4z29CLVKbKyZ84HsHXO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861186; c=relaxed/simple;
	bh=giilVXXGkIuHlzuop8wJXfCCBPgtzG3AIY5OihAqbFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhIUJgdwKzHbPl0Mfa570tDuWntt2FzcFx3Ck2/zNavoZCYCUnfSROuTxjECw7R3zeUJA+GhlGJLlG78tlWx1s7i9Z0KMTFoEfeLt5vhXOYKAx6fHWoTpsNWXwY621yN2mRfKEZN5JXV3BgGbBme01qbUAizfvMnOVC8ZHuwiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GcKciWWr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TJtdcu4101669;
	Mon, 30 Mar 2026 08:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k792O7
	qTJqaxyo1o2gXXm95mAwWzi3w6ipuEO0MpZVI=; b=GcKciWWrKASWoFyyiBf1vG
	ZLVV4lCObeEwbt2t4qaTQ8qDUQ/cNs17gLvoz+LpxLpdwT4WyuxCHHgtGElvuXg/
	DUx/SV4txfjVsSmMvkyy961i+bIFUSeZEa4md2Tt53rHFO5h+sLqXbT8up1W4jat
	k0Koawmm8TJNXtiMQAG7FVuPxDU8szoPT8dD6JmVtGCrahynqkIkrIksLJgJcVyb
	FGC13pv448RUnCWHherSEMTR47lY34X+cHDGUEns2H5mSxs0r+zJXVyDrTFhlWdK
	NIHJHoHA2hMSj/G0i1zb1c/A8/k+kEtUxqlikhf+OFPMjdFMFVcVnDfVDEzDYz5g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q2x1hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 08:59:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U6R8jA008732;
	Mon, 30 Mar 2026 08:59:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11bwxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 08:59:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62U8xT5x29360496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 08:59:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42B012004D;
	Mon, 30 Mar 2026 08:59:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D012004B;
	Mon, 30 Mar 2026 08:59:28 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 08:59:28 +0000 (GMT)
Message-ID: <b858ebd652fa067e33efafc43d381a83c0ab3270.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/2] PCI: AtomicOps: Do not enable without support in
 root complex
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall
 <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle	
 <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexander Schmidt
 <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        stable@vger.kernel.org, Gerd Bayer <gerd.bayer@de.ibm.com>
Date: Mon, 30 Mar 2026 10:59:28 +0200
In-Reply-To: <20260326164002.GA1325368@bhelgaas>
References: <20260326164002.GA1325368@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8801-oVXRFUo1z80j49SlCDZHkOHnxqw
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ca3b76 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=DF3YyuCdIVBqkp6MlwEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gkqxAUfufMUhyx0qPWi-92SNYRfuzxim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2OCBTYWx0ZWRfX7s8l1gJSp1/d
 wKD2SeRvbLJA3NYu+8uicsGBpO03ZIqK/sP65UVFLBy6o9X0jmGnsBh+4JwcmrUbSKRTbmcfJLy
 iKS9kzAdb/qUmkITQlCVIbPaVF10PiOaTrOdMdFF7PhNCfpvnpO2WOTPSh+Jg6zaMS90VJf/U8c
 trVsrQ4op0VfZ3wItplJR50DaNxqX1Y/6H4OpMDLw+YTHf71qiXgrmoKOKoEKHmO5XL2JH1pa7r
 k4TDu64XsR49l7wz/SlaImrWUmQG7FMJ2AWo4OA9117W3oPIadzCsCWEryt4M6GRhNeqj1LEtDn
 RqweZRFUwNhRpQrnY6I8tBKYA9nZAjdvXGajh1CRmrPlHNxCsGzB+ZsFjkuEVQ85YxoM/sM2Cig
 8ngEs8YihFZ+Nt0UQv+HTpm7NPNLm5fSW05EGTIpmlTMs/ZgFJ9yYs8Hr/6Epmy7Nd52x7nqbpp
 zjGvnBhKKaa58zdHpjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300068
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-18781-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E9267357A21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-26 at 11:40 -0500, Bjorn Helgaas wrote:
> On Thu, Mar 26, 2026 at 10:51:19AM +0100, Gerd Bayer wrote:
> > On Wed, 2026-03-25 at 15:08 -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 25, 2026 at 04:16:17PM +0100, Gerd Bayer wrote:
> > > > When inspecting the config space of a Connect-X physical function i=
n an
> > > > s390 system after it was initialized by the mlx5_core device driver=
, we
> > > > found the function to be enabled to request AtomicOps despite the
> > > > system's root-complex lacking support for completing them:
> > > >=20
> > > > 1ed0:00:00.1 Ethernet controller: Mellanox Technologies MT2894 Fami=
ly [ConnectX-6 Lx]
> > > > 	Subsystem: Mellanox Technologies Device 0002
> > > >   [...]
> > > > 	DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> > > > 		 AtomicOpsCtl: ReqEn+
> > > > 		 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
> > > > 		 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> > > >=20
> > > > Turns out the device driver calls pci_enable_atomic_ops_to_root() w=
hich
> > > > defaulted to enable AtomicOps requests even if it had no informatio=
n
> > > > about the root-port that the PCIe device is attached to. Similarly,
> > > > AtomicOps requests are enabled for root complex integrated endpoint=
s
> > > > (RCiEPs) unconditionally.
> > > >=20
> > > > Change the logic of pci_enable_atomic_ops_to_root() to fully traver=
se the
> > > > PCIe tree upwards, check that the bridge devices support delivering
> > > > AtomicOps transactions, and finally check that there is a root port=
 at
> > > > the end that does support completing AtomicOps - or that the suppor=
t for
> > > > completing AtomicOps at the root complex is announced through some =
other
> > > > arch specific way.
> > > >=20
> > > > Introduce a new pcibios_connects_to_atomicops_capable_rc() function=
 to
> > > > implement the check - and default to always "true". This leaves the
> > > > semantics for today's RCiEPs intact. Pass in the device in question=
 and
> > > > the requested capabilities for future expansions.
> > > > For s390, override pcibios_connects_to_atomicops_capable_rc() to
> > > > always return "false".
> > > >=20
> > > > Do not change the enablement of AtomicOps requests if there is no
> > > > positive confirmation that the root complex can complete PCIe Atomi=
cOps.
> > > >=20
> > > > Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> > > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > > ---
> > > >  arch/s390/pci/pci.c |  5 +++++
> > > >  drivers/pci/pci.c   | 48 +++++++++++++++++++++++++++++++----------=
-------
> > > >  include/linux/pci.h |  1 +
> > > >  3 files changed, 37 insertions(+), 17 deletions(-)
> > > >=20
> > > > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > > > index 2a430722cbe415dd56c92fed2e513e524f46481a..a0bef77082a153a258f=
be4abb1070b22e020888e 100644
> > > > --- a/arch/s390/pci/pci.c
> > > > +++ b/arch/s390/pci/pci.c
> > > > @@ -265,6 +265,11 @@ static int zpci_cfg_store(struct zpci_dev *zde=
v, int offset, u32 val, u8 len)
> > > >  	return rc;
> > > >  }
> > > > =20
> > > > +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev,=
 u32 cap_mask)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > >  resource_size_t pcibios_align_resource(void *data, const struct re=
source *res,
> > > >  				       resource_size_t size,
> > > >  				       resource_size_t align)
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 8479c2e1f74f1044416281aba11bf071ea89488a..006aa589926cb290de4=
3f152100ddaf9961407d1 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -3660,6 +3660,19 @@ void pci_acs_init(struct pci_dev *dev)
> > > >  	pci_disable_broken_acs_cap(dev);
> > > >  }
> > > > =20
> > > > +static bool pci_is_atomicops_capable_rp(struct pci_dev *dev, u32 c=
ap, u32 cap_mask)
> > > > +{
> > > > +	if (!dev || !(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT))
> > > > +		return false;
> > > > +
> > > > +	return (cap & cap_mask) =3D=3D cap_mask;
> > > > +}
> > > > +
> > > > +bool __weak pcibios_connects_to_atomicops_capable_rc(struct pci_de=
v *dev, u32 cap_mask)
> > > > +{
> > > > +	return true;
> > > > +}
> > > > +
> > > >  /**
> > > >   * pci_enable_atomic_ops_to_root - enable AtomicOp requests to roo=
t port
> > > >   * @dev: the PCI device
> > > > @@ -3676,8 +3689,9 @@ void pci_acs_init(struct pci_dev *dev)
> > > >  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mas=
k)
> > > >  {
> > > >  	struct pci_bus *bus =3D dev->bus;
> > > > -	struct pci_dev *bridge;
> > > > -	u32 cap, ctl2;
> > > > +	struct pci_dev *bridge =3D NULL;
> > > > +	u32 cap =3D 0;
> > > > +	u32 ctl2;
> > > > =20
> > > >  	/*
> > > >  	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
> > > > @@ -3714,29 +3728,29 @@ int pci_enable_atomic_ops_to_root(struct pc=
i_dev *dev, u32 cap_mask)
> > > >  		switch (pci_pcie_type(bridge)) {
> > > >  		/* Ensure switch ports support AtomicOp routing */
> > > >  		case PCI_EXP_TYPE_UPSTREAM:
> > > > -		case PCI_EXP_TYPE_DOWNSTREAM:
> > > > -			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> > > > -				return -EINVAL;
> > > > -			break;
> > > > -
> > > > -		/* Ensure root port supports all the sizes we care about */
> > > > -		case PCI_EXP_TYPE_ROOT_PORT:
> > > > -			if ((cap & cap_mask) !=3D cap_mask)
> > > > -				return -EINVAL;
> > > > -			break;
> > > > -		}
> > > > -
> > > > -		/* Ensure upstream ports don't block AtomicOps on egress */
> > > > -		if (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_UPSTREAM) {
> > > > +			/* Upstream ports must not block AtomicOps on egress */
> > > >  			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
> > > >  						   &ctl2);
> > > >  			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
> > > >  				return -EINVAL;
> > > > +			fallthrough;
> > > > +		/* All switch ports need to route AtomicOps */
> > > > +		case PCI_EXP_TYPE_DOWNSTREAM:
> > > > +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> > > > +				return -EINVAL;
> > > > +			break;
> > > >  		}
> > > > -
> > > >  		bus =3D bus->parent;
> > > >  	}
> > > > =20
> > > > +	/*
> > > > +	 * Finally, last bridge must be root port and support requested s=
izes
> > > > +	 * or firmware asserts support
> > > > +	 */
> > > > +	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask) ||
> > > > +	      pcibios_connects_to_atomicops_capable_rc(dev, cap_mask)))
> > > > +		return -EINVAL;
> > >=20
> > > Sashiko says:
> > >=20
> > >   Since the generic weak implementation of
> > >   pcibios_connects_to_atomicops_capable_rc() unconditionally returns
> > >   true, the logical OR expression pci_is_atomicops_capable_rp(...) ||
> > >   true will always evaluate to true. This makes the entire if
> > >   condition evaluate to false.
> > >=20
> > >   Because of this, it appears -EINVAL is never returned here, and any
> > >   standard endpoint behind a Root Port will successfully be granted
> > >   AtomicOps even if the Root Port lacks the capability in its
> > >   PCI_EXP_DEVCAP2 register.
> >=20
> > I've made the generic implementation of
> > pcibios_connects_to_atomicops_capable_rc() default to return "true" to
> > preserve the current code's handling of RCiEPs: Since they are not
> > attached to a root port, their dev->bus->parent is NULL and the entire
> > while-loop is bypassed - before this patch and after. (Sashiko was
> > pointing at that being regressed with v4.)
>=20
> The v4 patch definitely changed the behavior for RCiEPs: the current
> v7.0-rc1 code always enables AtomicOps for RCiEPs, and the v4 patch
> never enables AtomicOps for RCiEPs.  But I'm not sure this is a
> regression.  It definitely *could* break an RCiEP, but AFAIK we have
> no information about whether the RC supports AtomicOps, so enabling
> them and telling the driver that AtomicOps work might be a lie.
>=20
> IIUC, the motivation for this series was to avoid enabling AtomicOps
> on s390 where there is no visible Root Port, and you have platform
> knowledg that whatever is upstream from the endpoint in fact does not
> support them.
>=20
> I think we should avoid enabling AtomicOps unless we know for certain
> that the completer (Root Port or RC) supports them.  To me that sounds
> like:
>=20
>   1) Never enable AtomicOps for RCiEPs.
>=20
>   2) Only enable AtomicOps for endpoints below a Root Port that
>   supports AtomicOps.
>=20
> This could be two separate patches, where the second would fix the
> s390 issue reported by Alexander.

That sounds like a plan. Working on a v7 - keeping the reference
updates as a third patch of the series.

> If we come across RCiEPs that need AtomicOps and we somehow know that
> the RC supports them, we can add a quirk or something to take
> advantage of it.

Leave that as an execise for later.

> We are still hand-waving about peer-to-peer transactions; we don't
> even try to account for that because we don't know what peer might be
> the completer.

Anyway, I'm wondering what the adoption of AtomicOps looks like. Not
much turned up in my searches.

> > The whole point of pcibios_connects_to_atomicops_capable_rc() is to
> > allow different architectures to implement a discriminator outside of
> > PCIe's structure - potentially depending on CPU model or more.
> >=20
> > The only point I wonder about: Should
> > pcibios_connects_to_atomicops_capable_rc() default to return "false"
> > and deliberately change the behavior for today's RCiEP's (if there are
> > any...)?
> >=20
> > >=20
> > > > +
> > > >  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> > > >  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
> > > >  	return 0;
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..ef90604c39859ea8e61=
e5392d0bdaa1b0e43874b 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -692,6 +692,7 @@ void pci_set_host_bridge_release(struct pci_hos=
t_bridge *bridge,
> > > >  				 void *release_data);
> > > > =20
> > > >  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
> > > > +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev,=
 u32 cap_mask);
> > > > =20
> > > >  #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags=
 tell us the PCI region flags */
> > > > =20
> > > >=20
> > > > --=20
> > > > 2.51.0
> > > >=20
> >=20
> > Thanks,
> > Gerd

Thanks,
Gerd

