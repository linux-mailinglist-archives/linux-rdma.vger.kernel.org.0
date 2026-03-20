Return-Path: <linux-rdma+bounces-18449-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEVALv1LvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18449-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:30:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FCC2DB005
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED8B33011D6A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461E3A963C;
	Fri, 20 Mar 2026 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kqqsFI6A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBC1A6817;
	Fri, 20 Mar 2026 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013193; cv=none; b=Bfp6c3Czb4RqjBx2LT98HvMdDLe7Y5+fq74IfuyPbQvRe7hriSGDX7En9neSsQAdPr5CyZQr3E4WM2hZ0KS9Nsu7FJhMkR0yV/waRNsDtQIHZPmu2Njve2TL+PSbkLBa+n5MVUxTh+dIaQJNF9I6pKHOgGDfH1TakbExkqe4ELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013193; c=relaxed/simple;
	bh=8Qf4O59cRCiTNM8d1DSocI7ifO6Oqsvd7RQ1vRUfjPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6Y3n+UnAxISXDT2eivNj3P0HIVtW2ZXowCOrcc8xeQTuy2/HNBt4XwVt8ifEjAQ0vUUrgZ8m9jRFY1J+8LPN+bIrJmKsKXeFST+JJ8h61Le45n/o5mEOmllW/Tkrvs0ob4KOV+pVKhbt27dtNTEuAt8vAuDyH0m6H6HEIAyjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kqqsFI6A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JJwgp93617724;
	Fri, 20 Mar 2026 13:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4CZhX4
	ltwX6/2CwWGNZOXJCSOImkdXq3DA2jYreZCnA=; b=kqqsFI6A4QThf77memBY3a
	9udbqlS3k66eXfg2YSWJobl7VTplSBaZElJ4joGRquupkxa+NitWC4ZpgBlZzl++
	DGfGsRLIx6xgTxDThh9i8ie8p8RltDDARLaUwBelPzQ42SLlF3lH9k8UD1Ru39+w
	r0xsEJwYCOZ3DMiAR819HKU/+z6E36wNG5TRIImN/socHuO69Ven4k/h2sijKYr7
	2BRQvB/USzYMe1uDy1GQLMa3yP0CXVIehPCUo6GCu6Jrl2jjkRqUBMGock5w4tbb
	dY5857Di3qoAFMS44Zu0V4epwZ7KdvKD/kGJCm5T8W+MCCtJGgiyvKC9b/OX0y0Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybskre0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:26:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KCokTi015644;
	Fri, 20 Mar 2026 13:26:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nq9qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:26:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KDQMeS52887984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 13:26:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 180A42004B;
	Fri, 20 Mar 2026 13:26:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCE1E20043;
	Fri, 20 Mar 2026 13:26:21 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 13:26:21 +0000 (GMT)
Message-ID: <3764a54560d7caba6092e2a396b8dfcda1467802.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] PCI: AtomicOps: Do not enable if root-port
 capabilities are unknown
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall
 <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        stable@vger.kernel.org
Date: Fri, 20 Mar 2026 14:26:21 +0100
In-Reply-To: <20260313-fix_pciatops-v4-1-93bc70a63935@linux.ibm.com>
References: <20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com>
	 <20260313-fix_pciatops-v4-1-93bc70a63935@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bd4b03 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=bk9QdSnUxZs7UvxrWr4A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: nAiDaXskiwg1ItIqtGXSFjsP9M9i-w8i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwNCBTYWx0ZWRfXyV8MTvF0ujem
 54N0H8apDlj3D4IgT2Vj3R+MeCM2L4FnuuyJDfjEKPn3CwvssstcUeOgxpXWj62d3XwbaWwbHjw
 pniSkM+rtsDiX2h4c+yo0f9G0hWPoZU3qw598bz1Mn3XeaIUehQJINLDZMWvW7dt1bWfB2t2wER
 /upDtdPkRA9YwoxQC5RHEjtoGifHYJWg9dPt5Dfgobo4WEF9uhTmIrKsoCanmZY4vioN0Iyj2NS
 z4RxMGZZdDixyPWQqQBklYwiLytPls19QFCVioUbuZFT8sK40p9HEXcvhT8V6ZqNCtkeAV/V/KZ
 kbLhQTWc8MU1Ee1ntsLbkufT46IzuThsHOEjt66bx5CfDoadqMWNA1zlIOkD1fbt341Q9nn4zyX
 IZOvcPKl2TVyxSb9ebfL1oLi51dBaHtYGVN2CavGpJJNem7AKcRdIlG4IBKLPBpEavsisMp1YF8
 XXg+y973O4U28iSmlug==
X-Proofpoint-GUID: v--fBaIoxvjTiYJKS9agvBeiMOyBDzf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200104
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-18449-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B7FCC2DB005
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-13 at 17:49 +0100, Gerd Bayer wrote:
> When inspecting the config space of a Connect-X physical function in an
> s390 system after it was initialized by the mlx5_core device driver, we
> found the function to be enabled to request AtomicOps despite the
> system's root-complex lacking support for completing them:
>=20
> 1ed0:00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [Co=
nnectX-6 Lx]
> 	Subsystem: Mellanox Technologies Device 0002
>   [...]
> 	DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 		 AtomicOpsCtl: ReqEn+
> 		 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
> 		 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>=20
> Turns out the device driver calls pci_enable_atomic_ops_to_root() which
> defaulted to enable AtomicOps requests even if it had no information
> about the root-port that the PCIe device is attached to.
>=20
> Change to logic of pci_enable_atomic_ops_to_root() to fully traverse the
> PCIe tree upwards, check that the bridge devices support delivering
> AtomicOps transactions, and finally check that there is a root-port at
> the end that does support completing AtomicOps.
>=20
> Do not enable AtomicOps requests if nothing can be learned about how the
> device is attached - e.g. if it is on an "isolated" bus, as in s390.
>=20
> Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f1044416281aba11bf071ea89488a..94e90988df86b3278b1b6abbc=
326abf9b4a4a962 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3676,7 +3676,7 @@ void pci_acs_init(struct pci_dev *dev)
>  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  {
>  	struct pci_bus *bus =3D dev->bus;
> -	struct pci_dev *bridge;
> +	struct pci_dev *bridge =3D NULL;
>  	u32 cap, ctl2;
> =20
>  	/*
> @@ -3714,29 +3714,27 @@ int pci_enable_atomic_ops_to_root(struct pci_dev =
*dev, u32 cap_mask)
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
> +		/* All switch ports need to route AtomicOps */
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> +				return -EINVAL;
> +			break;
>  		}
> -
>  		bus =3D bus->parent;
>  	}
> =20
> +	/* Finally, last bridge must be root port and support requested sizes *=
/
> +	if ((!bridge) ||
> +	    (pci_pcie_type(bridge) !=3D PCI_EXP_TYPE_ROOT_PORT) ||
> +	    ((cap & cap_mask) !=3D cap_mask))
> +		return -EINVAL;
> +

Sashiko (the new review tool) annotated that this patch may regress how
RCiEP's are treated:
https://sashiko.dev/#/patchset/20260313-fix_pciatops-v4-0-93bc70a63935%40li=
nux.ibm.com

And it has a point: While AtomicOps Requests were allowed for RCiEP's
per default - now they're forbidden per default. Turns out that the
situation for RCiEP's on all archs is the same as for "isolated
functions" on s390: With pure PCI config ops you cannot tell, whether
the root-complex supports them or not.

I'm thinking about inverting the logic here - and adding an else clause
with an arch-specific hook to serve as discriminator.
Thoughts anybody?

>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
>  	return 0;

Thanks,
Gerd

