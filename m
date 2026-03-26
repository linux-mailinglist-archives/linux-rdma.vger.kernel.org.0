Return-Path: <linux-rdma+bounces-18703-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJxpFoQExWmh5gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18703-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 11:03:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C6332D71
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCC8F3061D0B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575F3B8D55;
	Thu, 26 Mar 2026 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ve8fYCXH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919803B2FD5;
	Thu, 26 Mar 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518693; cv=none; b=LHIw++A3s5x78E/hM1fJavw8yxPz1hDEjlX2ADFWKkgynzIWSCMVbQM7dStqcJLU1brxz79Lp90f9xajfCKmh0m3hFurEEIph4jMbAAMGVgmXMBSP6MPUPkmWNM1DLb5tIZ0wKvyDt9+mzRDyIqCPbM1HWS0IZ6umrbKp4NAUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518693; c=relaxed/simple;
	bh=1F1e+PD6WQJUH7+46B7/HIOsr2UDXoO60eIIHWfuy9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krwZZv/Fl0ypadXYvGMp9GmEUArYqTr9x0MytQbS5jqLjQtyX6Xpyz2dSq4dzHkVRx++96NEdxQR4E8ldHIRhcrb1YuznCGFrQtrcVUzk8VdrDJuRTqEwx4fzipnRDsFeAwwtz/EefJ8bWlWJggi8ZNNWKTM95uhzw7cGNepRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ve8fYCXH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7cxGX2322759;
	Thu, 26 Mar 2026 09:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1kgxzl
	Ld5zBWO+ZzZO1oRCKJxbowZoD8EBRF0PyTh0Q=; b=Ve8fYCXHgY0pU4QFhgtTEO
	kvTn0vaOcu1Spqi3bMtkmL/2foTGoRdpxKhIyQt/5dt/CFx/MHirAD9ncdk6X+rt
	GAm6/jqCWe8qqjHVwgsAw2fFmENVllJjdMtAFtVdVgLXxQS5uV/2hzY9gg69HuLg
	cpdOuWvnfrFw5+X7rHggb6yJLI9/uVqNvZBnhF6LxGCDGYt4WAFUot/Lflr3w8Gb
	5bf9fQ+GgsLgSwS9HitCb4tlhkf+E3fpLOIpcFwxhBjlsnRW30ATFCNFH/MeoLo6
	k16HrVLa9gURaKkF0uMIQ/2tX7V22hnq85jusXLFvPkG0dFt1MI1XRXXyh9na8nw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv3kuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:51:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q5m0sN005972;
	Thu, 26 Mar 2026 09:51:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ytg5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:51:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q9pJlu20185348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 09:51:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9850E2004D;
	Thu, 26 Mar 2026 09:51:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 493D12004B;
	Thu, 26 Mar 2026 09:51:19 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 09:51:19 +0000 (GMT)
Message-ID: <4183b471777efa949ce6f7b860c81282e91666ef.camel@linux.ibm.com>
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
Date: Thu, 26 Mar 2026 10:51:19 +0100
In-Reply-To: <20260325200835.GA1290451@bhelgaas>
References: <20260325200835.GA1290451@bhelgaas>
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
X-Proofpoint-ORIG-GUID: OSqgECE0RlHxvqNr9gv6e4eF2D_OyIL8
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c5019c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=x6K-tPQhctwWebVqKp8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2OSBTYWx0ZWRfXwU8JLL36ZvE9
 u3BIiHMeyg4IJAMCMHH9FdAbLenEj91xljHWC3fmBBtHg72UmTKkmQSleVmY2loLQOSyKlnoixz
 4aVLM7QBLlp9vNplTa0xS9aywiIju+ZzHk0gYcvdvjzFD7mIn8Jaz6V6TtVWvSdoMTK0qRi0dOA
 aPpy+OZNO+g10mYiiPeL7KZstIjaIyiIq0A8zqcxAcwity2UiXqFZsNZQTlXRhmj4Q0TYKX6moh
 +AWwWCZpPzLe9i7KhupA119dJL0/qF4rNzFytiOjhHnctimgSe++RETHKGRaJH0HmUs6MPJyeNX
 5UEkTF7J2ZKdYhsslEHj+GqtmJCJ3HcsCd7wla6/x+NavBW3KV2XKn1eePEid4gCOJt/LZNDLQ0
 hYVTKuSlPpH/lsas0zuEaWIYti9RvldqMzNk4TbbHN5Z2LGhtpKfsC7ZU6JwBMd3j+enNFcR5wM
 4qrwBLn4WZmNH1ME0Zg==
X-Proofpoint-GUID: 1hiv0VvXh2pfW19u80XK0ds2_UlMWuiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260069
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-18703-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 541C6332D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-25 at 15:08 -0500, Bjorn Helgaas wrote:
> On Wed, Mar 25, 2026 at 04:16:17PM +0100, Gerd Bayer wrote:
> > When inspecting the config space of a Connect-X physical function in an
> > s390 system after it was initialized by the mlx5_core device driver, we
> > found the function to be enabled to request AtomicOps despite the
> > system's root-complex lacking support for completing them:
> >=20
> > 1ed0:00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [=
ConnectX-6 Lx]
> > 	Subsystem: Mellanox Technologies Device 0002
> >   [...]
> > 	DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> > 		 AtomicOpsCtl: ReqEn+
> > 		 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
> > 		 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> >=20
> > Turns out the device driver calls pci_enable_atomic_ops_to_root() which
> > defaulted to enable AtomicOps requests even if it had no information
> > about the root-port that the PCIe device is attached to. Similarly,
> > AtomicOps requests are enabled for root complex integrated endpoints
> > (RCiEPs) unconditionally.
> >=20
> > Change the logic of pci_enable_atomic_ops_to_root() to fully traverse t=
he
> > PCIe tree upwards, check that the bridge devices support delivering
> > AtomicOps transactions, and finally check that there is a root port at
> > the end that does support completing AtomicOps - or that the support fo=
r
> > completing AtomicOps at the root complex is announced through some othe=
r
> > arch specific way.
> >=20
> > Introduce a new pcibios_connects_to_atomicops_capable_rc() function to
> > implement the check - and default to always "true". This leaves the
> > semantics for today's RCiEPs intact. Pass in the device in question and
> > the requested capabilities for future expansions.
> > For s390, override pcibios_connects_to_atomicops_capable_rc() to
> > always return "false".
> >=20
> > Do not change the enablement of AtomicOps requests if there is no
> > positive confirmation that the root complex can complete PCIe AtomicOps=
.
> >=20
> > Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> >  arch/s390/pci/pci.c |  5 +++++
> >  drivers/pci/pci.c   | 48 +++++++++++++++++++++++++++++++--------------=
---
> >  include/linux/pci.h |  1 +
> >  3 files changed, 37 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index 2a430722cbe415dd56c92fed2e513e524f46481a..a0bef77082a153a258fbe4a=
bb1070b22e020888e 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -265,6 +265,11 @@ static int zpci_cfg_store(struct zpci_dev *zdev, i=
nt offset, u32 val, u8 len)
> >  	return rc;
> >  }
> > =20
> > +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32=
 cap_mask)
> > +{
> > +	return false;
> > +}
> > +
> >  resource_size_t pcibios_align_resource(void *data, const struct resour=
ce *res,
> >  				       resource_size_t size,
> >  				       resource_size_t align)
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8479c2e1f74f1044416281aba11bf071ea89488a..006aa589926cb290de43f15=
2100ddaf9961407d1 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3660,6 +3660,19 @@ void pci_acs_init(struct pci_dev *dev)
> >  	pci_disable_broken_acs_cap(dev);
> >  }
> > =20
> > +static bool pci_is_atomicops_capable_rp(struct pci_dev *dev, u32 cap, =
u32 cap_mask)
> > +{
> > +	if (!dev || !(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT))
> > +		return false;
> > +
> > +	return (cap & cap_mask) =3D=3D cap_mask;
> > +}
> > +
> > +bool __weak pcibios_connects_to_atomicops_capable_rc(struct pci_dev *d=
ev, u32 cap_mask)
> > +{
> > +	return true;
> > +}
> > +
> >  /**
> >   * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root po=
rt
> >   * @dev: the PCI device
> > @@ -3676,8 +3689,9 @@ void pci_acs_init(struct pci_dev *dev)
> >  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
> >  {
> >  	struct pci_bus *bus =3D dev->bus;
> > -	struct pci_dev *bridge;
> > -	u32 cap, ctl2;
> > +	struct pci_dev *bridge =3D NULL;
> > +	u32 cap =3D 0;
> > +	u32 ctl2;
> > =20
> >  	/*
> >  	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
> > @@ -3714,29 +3728,29 @@ int pci_enable_atomic_ops_to_root(struct pci_de=
v *dev, u32 cap_mask)
> >  		switch (pci_pcie_type(bridge)) {
> >  		/* Ensure switch ports support AtomicOp routing */
> >  		case PCI_EXP_TYPE_UPSTREAM:
> > -		case PCI_EXP_TYPE_DOWNSTREAM:
> > -			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> > -				return -EINVAL;
> > -			break;
> > -
> > -		/* Ensure root port supports all the sizes we care about */
> > -		case PCI_EXP_TYPE_ROOT_PORT:
> > -			if ((cap & cap_mask) !=3D cap_mask)
> > -				return -EINVAL;
> > -			break;
> > -		}
> > -
> > -		/* Ensure upstream ports don't block AtomicOps on egress */
> > -		if (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_UPSTREAM) {
> > +			/* Upstream ports must not block AtomicOps on egress */
> >  			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
> >  						   &ctl2);
> >  			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
> >  				return -EINVAL;
> > +			fallthrough;
> > +		/* All switch ports need to route AtomicOps */
> > +		case PCI_EXP_TYPE_DOWNSTREAM:
> > +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> > +				return -EINVAL;
> > +			break;
> >  		}
> > -
> >  		bus =3D bus->parent;
> >  	}
> > =20
> > +	/*
> > +	 * Finally, last bridge must be root port and support requested sizes
> > +	 * or firmware asserts support
> > +	 */
> > +	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask) ||
> > +	      pcibios_connects_to_atomicops_capable_rc(dev, cap_mask)))
> > +		return -EINVAL;
>=20
> Sashiko says:
>=20
>   Since the generic weak implementation of
>   pcibios_connects_to_atomicops_capable_rc() unconditionally returns
>   true, the logical OR expression pci_is_atomicops_capable_rp(...) ||
>   true will always evaluate to true. This makes the entire if
>   condition evaluate to false.
>=20
>   Because of this, it appears -EINVAL is never returned here, and any
>   standard endpoint behind a Root Port will successfully be granted
>   AtomicOps even if the Root Port lacks the capability in its
>   PCI_EXP_DEVCAP2 register.

I've made the generic implementation of
pcibios_connects_to_atomicops_capable_rc() default to return "true" to
preserve the current code's handling of RCiEPs: Since they are not
attached to a root port, their dev->bus->parent is NULL and the entire
while-loop is bypassed - before this patch and after. (Sashiko was
pointing at that being regressed with v4.)

The whole point of pcibios_connects_to_atomicops_capable_rc() is to
allow different architectures to implement a discriminator outside of
PCIe's structure - potentially depending on CPU model or more.

The only point I wonder about: Should
pcibios_connects_to_atomicops_capable_rc() default to return "false"
and deliberately change the behavior for today's RCiEP's (if there are
any...)?

>=20
> > +
> >  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> >  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
> >  	return 0;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..ef90604c39859ea8e61e539=
2d0bdaa1b0e43874b 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -692,6 +692,7 @@ void pci_set_host_bridge_release(struct pci_host_br=
idge *bridge,
> >  				 void *release_data);
> > =20
> >  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
> > +bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32=
 cap_mask);
> > =20
> >  #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tel=
l us the PCI region flags */
> > =20
> >=20
> > --=20
> > 2.51.0
> >=20

Thanks,
Gerd

