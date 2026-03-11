Return-Path: <linux-rdma+bounces-17966-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BPeLuxdsWl/uQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17966-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 13:19:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964E263883
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 13:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDAE3306CEDB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB453B636E;
	Wed, 11 Mar 2026 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RvFHcpA1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7571EEA3C;
	Wed, 11 Mar 2026 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231589; cv=none; b=pntryXsujQRl0D/w4Oba5pSv3qd+WYrfeXux6GohQao3JZ3KzchkqKhOa4tRlSqfG8eAfx9oyqDFPWCza+MUm1ww4FVNkrfN1AS+/D8VqaThCF1S4Qjux2SPeXk9/4RTn4NcpNaziBv4fsZ9XGnV+HGE4MEdjflJCIlDgVf69Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231589; c=relaxed/simple;
	bh=D6i4GXi0Ry4YqnwrhMtAC52r2UwmCXBrjKdgIpXw180=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2C5hyyT8Z84f41zhH1A8x0cyQQpJQNrat0apT8qYIRusVur4Z/x+arzyztzjmwDobBgG2DIixbZN0qt+M+Pdf9KqHbnt4REN+cBTp1ic2JRL+MHJyDOiHmknurb6fVITVPO/hSAfMMenTIYOASO4y5d4ElGxNk8dOaffmkoF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RvFHcpA1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B0QksL3693682;
	Wed, 11 Mar 2026 12:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fHHz4T
	03IlKNYe13VzqJfEZFehKeBHZHJTeV+cC6+Jo=; b=RvFHcpA1RmhMWF7+tOwKWg
	/CJQktSyMpjiV9c99xUJVFL1+GuGGEaNDWFTHgWJJiT2maUOpjpDQqW9uvvmdIGZ
	1teIyu8XIGVGofC3PReVqacEjRvfBWoUQXaVV8bK8s0ikFXB+fEUcoTTMuGDyaCj
	6bxYZlFwt2O2Ggf83nWdr4lyNd7ajzrqR1MAUhQ+GYQ4k1Iyvbsmkw7i22KFd2lr
	Rx0mEpHk45JaEkC82B8z52rOppqmf+F4EGpsHHaTX3YguidDdwjq0H7TiTqQcJYY
	F4dDc2V0jHusrZLPCSq+h+Y5B2QSUCywsYAJZXJLCto7va1t0NVKiibqLqZjEIHw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mq77t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 12:19:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B7PYoV021521;
	Wed, 11 Mar 2026 12:19:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbswfev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 12:19:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BCJbWw51053006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 12:19:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07B2620063;
	Wed, 11 Mar 2026 12:19:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C75D42004F;
	Wed, 11 Mar 2026 12:19:36 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 12:19:36 +0000 (GMT)
Message-ID: <fc35d3d36994c128ebf99014fa11be5f2f425b77.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] PCI: AtomicOps: Fix logic in enable function
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall
 <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Leon
 Romanovsky <leon@kernel.org>,
        Niklas Schnelle	 <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        stable@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 11 Mar 2026 13:19:36 +0100
In-Reply-To: <20260310215239.GA299126@bhelgaas>
References: <20260310215239.GA299126@bhelgaas>
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
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b15dde cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=wPh2HK_tBoa78iuf8CkA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwMiBTYWx0ZWRfXxtn37MRxJoW+
 DuQMHt4TJLgjm0OI9l+8ctW9LGemxFZpN7OkZ9m7qjQq+77Cr3JyuEHKe+aOJGZoqLCdhgRfEpw
 MF4XLH+41rFpXZYkfG1zf+1KrALJW82zPi6S5X0Vk1y/0Bx/mnJnYzrPYxBn2a98PGSBmSVqoFh
 Ywnrxhu64WXSvEcu2G7kW+gJkkBvqmnKcRJ1g3W4KcAfjgtI/DGquWY0dudzIClYDXVNX+Kyewz
 ei1LeysRLvqahTzwR3lGxGHATWv/sqpcLKpiZmTEfVxgssrusHh2H+Eb+S/P8Tai27ysfhJqDuP
 SgARmmDlSq5gQIyOI/4I8+2ZlcDABzkgE2yDm7urG0DYt8lwXS/3E9+RRWrHCqMr2PPzD6OHDl7
 x8HMli8REf4bYDb4EVhfjaWyOKscOmq+mHXHMq2mFrqlWSOYwrtR2QZ+Y5/E3jCiwO1V8zv8izn
 HMLF3z+uYdbrDKzBVVg==
X-Proofpoint-GUID: 3MVBN0iaUaw400J6jOWN-rJwO2eBGebF
X-Proofpoint-ORIG-GUID: Kza7yqwBuvAB4_w-854NxDATdPuN8O_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110102
X-Rspamd-Queue-Id: 6964E263883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17966-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Tue, 2026-03-10 at 16:52 -0500, Bjorn Helgaas wrote:
> On Fri, Mar 06, 2026 at 06:13:59PM +0100, Gerd Bayer wrote:
> > Move the check for root port requirements past the loop within
> > pci_enable_atomic_ops_to_root() that checks on potential switch
> > (up- and downstream) ports.
> >=20
> > Inside the loop traversing the PCI tree upwards, prepend the switch cas=
e
> > to validate the routing capability on any port with a fallthrough-case
> > that does the additional check for Atomic Ops not being blocked on
> > upstream ports.
>=20
> Thanks for looking at this.  I think this makes good sense, and I'd
> like to:
>=20
>   - Hoist the problem description up here.  IIUC we enable AtomicOps on
>     s390 when we shouldn't, which presumably leads to some problem.  I
>     think the same could happen anywhere we don't have a Root Port,
>     e.g., jailhouse, loongarch, maybe some VMM guests?

A few things need to align here in order to observe the bug:
- architecture/configuration w/o Root Port knowledge
- PCIe device with AtomicOps support
- device driver that requests the AtomicOps enablement at the device
Unfortunately, I don't have access to any other combination that may
fail this way. However, I do have access to an x86 system to verify
that this does not generate an (immediate) regression.


>   - Reduce or remove the text above, which is basically C code
>     translated to English, and move it down after the problem
>     description, so we can state the problem and symptom, followed by
>     the solution.

Makes sense: I'll focus on the actual issue in the commit message here
and spin off a new series with patch 1.

> I think the core is (as you say below) that if there's no Root Port,
> we previously allowed endpoints to use AtomicOps even in cases where
> we don't know if the recipient supports them.
>=20
> That *sounds* bad, and if you actually saw some kind of corruption as
> a result, that would make this very compelling.

So far, we have not seen any real functional fall-out on s390 due to
this bug. Our current use-cases of Mellanox/Nvidia's ConnectX adapters
do not seem to lead to the adapter's exploitation of PCIe AtomicOps.
However driver init succeeds to enable AtomicOps Requests as can be
observed with lspci.

> > Do not enable Atomic Op Requests if nothing can be learned about how th=
e
> > device is attached - e.g. if it is on an "isolated" bus, as in s390.
> >=20
> > Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
>=20
> If there's any public report of the problem, include the URL here.

I can offer excerpts of output from `lspci`, only.

> > Cc: stable@vger.kernel.org
> > Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> >  drivers/pci/pci.c | 30 ++++++++++++++----------------
> >  1 file changed, 14 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cc8abe6b1d07661488895876dbbcf8aaeadf4a17..23db6ad5f310ed009a9b2ca=
4933c7498e0d22b85 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3677,7 +3677,7 @@ void pci_acs_init(struct pci_dev *dev)
> >  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
> >  {
> >  	struct pci_bus *bus =3D dev->bus;
> > -	struct pci_dev *bridge;
> > +	struct pci_dev *bridge =3D NULL;
> >  	u32 cap, ctl2;
> > =20
> >  	/*
> > @@ -3715,29 +3715,27 @@ int pci_enable_atomic_ops_to_root(struct pci_de=
v *dev, u32 cap_mask)
>=20
> Since we're looking at this, I think we should update the spec
> references in this function (in a separate patch). =20
>=20
>   * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
>   * in Device Control 2 is reserved in VFs and the PF value applies
>   * to all associated VFs.
>=20
> It looks like the AtomicOp Requester Enable part of PCIe r5.0, sec
> 9.3.5.10, was incorporated into the Device Control 2 Register
> description in PCIe r7.0, sec 7.5.3.16.
>=20
>   * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
>   * AtomicOp requesters.  For now, we only support endpoints as
>   * requesters and root ports as completers.  No endpoints as
>   * completers, and no peer-to-peer.
>=20
> This looks like PCIe r7.0, sec 6.15.  Same section as r4.0, but we
> should at least make both of these refer to the same spec revision.
>=20

Fair request... Will clean up in a separate patch.

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
> > +	/* Finally, last bridge must be root port and support requested sizes=
 */
> > +	if ((!bridge) ||
> > +	    (pci_pcie_type(bridge) !=3D PCI_EXP_TYPE_ROOT_PORT) ||
> > +	    ((cap & cap_mask) !=3D cap_mask))
> > +		return -EINVAL;
> > +
> >  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> >  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
> >  	return 0;
> >=20
> > --=20
> > 2.51.0
> >=20

Thank you,
Gerd

