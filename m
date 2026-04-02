Return-Path: <linux-rdma+bounces-18942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB8EG5mBzmkqoAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 16:47:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF2438AC9D
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04483029E4E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF23ED5CF;
	Thu,  2 Apr 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nhc46qPm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DE3ED127;
	Thu,  2 Apr 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141113; cv=none; b=msTFljnezR8IMJM1avtgiy33+L2P/aRF/upzFmI0gymce+B7h7rOtiGL+NU17MbOn6UqjevlWVTvo1VOJKhrLwJNnPWbkdkEnnU3loBh91cYmbgAkoALuCV+e0cYMm72DzkXXi5g5iVIu7GjVJ2BdoPQyPyvz/8irG4gKQekvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141113; c=relaxed/simple;
	bh=Gq6/+QmI/e4+hpFHtzoceO2paPVB3rXBjICq6Vdav/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJxXtBWqXOYlnnCZ0IO9+I3wL9w0KEYA4qHuohtm1aGHyw2eWO09j/jddvLD8lxbn7gnGmoQug5wSUfja3gzQ4ScxML/5Upjpsmbs01OvYkxnG/WlIf0wyu+ZHLLinLkfCeVZstNwJnZgdJ9kCmxnFfZRzUQkFyo+WRTLlFGh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nhc46qPm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63229iCp197973;
	Thu, 2 Apr 2026 14:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d4rZSY
	bL+oDhoSCMlNTyVq8eTNE7GNFZW39e8eRRaWE=; b=nhc46qPmMJ198papkItcZd
	0UsNo7Hlka31crJUCVycEIjHISfyIMqzVyVWn+Fixs0STfPsyZqGuDUockRydvX6
	7G6rZ0JCeg93T6nMoG6owClMV0ag+pD88My8syscvXhZUKHgGsngA0vc6PmXwKK4
	9zNmbYQuaim/CsVsCjAvqf3yKDjny3+O5f73SDocy6FL3iZCoifCyji+zPCOdE04
	uw50qkwd80ap7tbbD08vKrFTSHgddBHeEhBRXsO2JvzMuLUNkCK/fXE9W/myvt1d
	v2np1GYv4BUzeSKH+7j82fM80UqXL/ozX26cPv00KxU8aTcgLFIVESOejqRRBV7w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgvfr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 14:45:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632D0oA1008689;
	Thu, 2 Apr 2026 14:45:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11t64e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 14:45:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632Ej0N626870080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 14:45:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A50612004B;
	Thu,  2 Apr 2026 14:45:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B69220043;
	Thu,  2 Apr 2026 14:44:59 +0000 (GMT)
Received: from [9.111.58.182] (unknown [9.111.58.182])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 14:44:59 +0000 (GMT)
Message-ID: <d873984cc49a75e534584465968fcec28134abf9.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/3] PCI: AtomicOps: Do not enable without support in
 root port
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall
 <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerald Schaefer	 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle	
 <svens@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexander Schmidt
	 <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        stable@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
Date: Thu, 02 Apr 2026 16:44:59 +0200
In-Reply-To: <20260401172757.GA226107@bhelgaas>
References: <20260401172757.GA226107@bhelgaas>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEyOSBTYWx0ZWRfX4DDaY7aarWO6
 ATaw91rurCK6qkWuOx5wxm3msrhDtzEjcwI5fFys+nmG8tQw/jdLbrUBCDMQBJzsYJbd4uupYBU
 50rwvfm76i5JdSijwPtcZZKqycSdPOza6ahLyDGyPQT+C+XZNuEtPthjrtB38tKzOirVIuuaGUd
 BixJszlDdCb7/O+pgxLM3CSva+XKyED6bbXTdxJBj7JMVbt3GiLcls6rXC3OrU7gd2VdwgdbWCq
 qqu4p8fCKCSJ+aKwUTLq3XS9f2yOjRbuUIKVLrezp/6GjkUZngm6P+VXnPFuaHEYnRlRZ+idSvw
 xo7bmtZnNfZDIjFoVC2PlOaJYA0rubynQ8lt9wHpXhRufKYscD/VX4p8D5+KNeGbr/h5eVZ9CCv
 Nm5Hyd2cQwzRLFOLnDiYX+GBtsidiyxfwtUufFykwRqJYDZpbnuUVWqS+on1ZAqpfYlalLHyYpL
 LTjWLsxjSsgNYW5fpvQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ce80f1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=_pRlaQ53w6PJSlYguW4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2ouAz1o2y_zW-wsAueOUQnwQ_OUNTVFW
X-Proofpoint-ORIG-GUID: OQnZ_alvZpkD5Qiry3D6GrRhkQTyvfo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020129
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-18942-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: DBF2438AC9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-01 at 12:27 -0500, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2026 at 03:09:45PM +0200, Gerd Bayer wrote:
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
> > about the root port that the PCIe device is attached to.
> >=20
> > Change the logic of pci_enable_atomic_ops_to_root() to fully traverse t=
he
> > PCIe tree upwards, check that the bridge devices support delivering
> > AtomicOps transactions, and finally check that there is a root port at
> > the end that does support completing AtomicOps.
> >=20
> > Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> OK, I think this is set to go.  It sounds like there are no RCiEPs
> that we need to worry about.
>=20
> I think pci_enable_atomic_ops_to_root() will end up more readable if
> we check for the Root Port first and explicitly as in the modified
> version.  I *think* it's equivalent but can't easily test it.  What do
> you think?

At first sight it appears counter-intuitive to test the root-port's
capabilities before traversing the hierarchy - but with the explicit
read of the root port's DEVCAP2, we avoid the dependency to work on the
cap read within the while-loop.

My testing is somewhat limited, too - but I've verified that the
results with your patch (+ a small nit - see below) are the same as
with my version:

- ConnectX-5 Ex on s390: AtomicsOpsCtl: ReqEn-
- ConnectX-6 Dc on x86_64: AtomicsOpsCtl: ReqEn+

>=20
> commit 2f3f32f2c180 ("PCI: Enable AtomicOps only if Root Port supports th=
em")
> Author: Gerd Bayer <gbayer@linux.ibm.com>
> Date:   Mon Mar 30 15:09:45 2026 +0200
>=20
>     PCI: Enable AtomicOps only if Root Port supports them
>    =20
>     When inspecting the config space of a Connect-X physical function in =
an
>     s390 system after it was initialized by the mlx5_core device driver, =
we
>     found the function to be enabled to request AtomicOps despite the Roo=
t Port
>     lacking support for completing them:
>    =20
>       00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [C=
onnectX-6 Lx]
>               Subsystem: Mellanox Technologies Device 0002
>               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                        AtomicOpsCtl: ReqEn+
>    =20
>     On s390 and many virtualized guests, the Endpoint is visible but the =
Root
>     Port is not.  In this case, pci_enable_atomic_ops_to_root() previousl=
y
>     enabled AtomicOps in the Endpoint even though it couldn't tell whethe=
r
>     the Root Port supports them as a completer.
>    =20
>     Change pci_enable_atomic_ops_to_root() to fail if there's no Root Por=
t or
>     the Root Port doesn't support AtomicOps.
>    =20
>     Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
>     Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
>     Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: stable@vger.kernel.org
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 135e5b591df4..515f565a4a70 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3675,8 +3675,7 @@ void pci_acs_init(struct pci_dev *dev)
>   */
>  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  {
> -	struct pci_bus *bus =3D dev->bus;
> -	struct pci_dev *bridge;
> +	struct pci_dev *root, *bridge;
>  	u32 cap, ctl2;
> =20
>  	/*
> @@ -3705,35 +3704,35 @@ int pci_enable_atomic_ops_to_root(struct pci_dev =
*dev, u32 cap_mask)
>  		return -EINVAL;
>  	}
> =20
> -	while (bus->parent) {
> -		bridge =3D bus->self;
> +	root =3D pcie_find_root_port(dev);
> +	if (!root)
> +		return -EINVAL;
> =20
> -		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
> +	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);

You want to read DEVCAP2 on root here, bridge is still unitialized.

> +	if ((cap & cap_mask) !=3D cap_mask)
> +		return -EINVAL;
> =20
> +	bridge =3D pci_upstream_bridge(dev);
> +	while (bridge !=3D root) {
>  		switch (pci_pcie_type(bridge)) {
> -		/* Ensure switch ports support AtomicOp routing */
>  		case PCI_EXP_TYPE_UPSTREAM:
> -		case PCI_EXP_TYPE_DOWNSTREAM:
> -			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> -				return -EINVAL;
> -			break;
> -
> -		/* Ensure root port supports all the sizes we care about */
> -		case PCI_EXP_TYPE_ROOT_PORT:
> -			if ((cap & cap_mask) !=3D cap_mask)
> -				return -EINVAL;
> -			break;
> -		}
> -
> -		/* Ensure upstream ports don't block AtomicOps on egress */
> -		if (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_UPSTREAM) {
> +			/* Upstream ports must not block AtomicOps on egress */
>  			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
>  						   &ctl2);
>  			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
>  				return -EINVAL;
> +			fallthrough;
> +
> +		/* All switch ports need to route AtomicOps */
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2,
> +						   &cap);
> +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> +				return -EINVAL;
> +			break;
>  		}
> =20
> -		bus =3D bus->parent;
> +		bridge =3D pci_upstream_bridge(bridge);
>  	}
> =20
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,

Thanks,
Gerd

