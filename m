Return-Path: <linux-rdma+bounces-17963-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ACCOE5HsWlCtAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17963-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:43:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A55352626EA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31CBD3010490
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FBA3CFF5A;
	Wed, 11 Mar 2026 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XK1A2lnW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60473C3422;
	Wed, 11 Mar 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225802; cv=none; b=DtJ068ho4Y0u/AuE5nBMiNH1nC9iq+BEjF9WsRXTtENbtjRGrb61RrXtnJW+HOXoT49dV3HvzfJDyB1oxamWAbXQHuVAubqS8njLrTLF2YWr57cWR7uZsjZaI565zMhCZfamVebAxRbymxPcg4MMl0jV8kgAUUaCEweobbSY2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225802; c=relaxed/simple;
	bh=AtkPG8tzdGpN8/BbpE1mzpfAJY0eC9ktF9UeqdtIJ2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BXZNFd26cmPx4nAAlpBUQS/39vNiguREcgkBhjwvT8UCE9kdrcXDETf1pd39h9u9sDCO2ArrA9fMWqYhNtkB+aMJLOy77Fs9RAyl5RcL9DJ27q5DcUM+BpRcyzIJVlJW2Q7zxPHqAVHeseZ7Is1cj33OkLEeJnLxygHl70pfZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XK1A2lnW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B095wW1745814;
	Wed, 11 Mar 2026 10:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8572Uw
	gfWkDepvpVS37E5HDEdWVklCY1AWygPCkQAy4=; b=XK1A2lnWku1AlQsTvrkpou
	9T+pH0jrrHs8UNu0AObSNlPKaBx5LG2s0+uBLV1DIzmAFzFgGHzYpfsxq3j4974z
	3iC3CWzxymCKbKHpB0x2y5tW/L50/ME6B7DTZGsSlKeIwCogDvD422cAX0XV7pW4
	wNMemhfXsss2r9xfLlc16Y+cTIP2BH8TxCLBpgA5oUllJBIdfzI/tUYTq6/QzpSG
	Jvy8ce0zC7ilWPQJLleO00Kwfi04eiXW3LGYyKQdlGYlMgVZ6aBOzbVBUlnfIbyv
	aYUvSDtnzDN/4h6fAqmWEQNs0o51gyxyBtGirHPsXSilm8mXA0CtZnKmIWnwUcig
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyfd96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 10:43:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B8LZj1015720;
	Wed, 11 Mar 2026 10:43:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1224u31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 10:43:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BAh6jS54657526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 10:43:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28F692004D;
	Wed, 11 Mar 2026 10:43:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA68C20043;
	Wed, 11 Mar 2026 10:43:05 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 10:43:05 +0000 (GMT)
Message-ID: <e02ca89a1de3a21aecdebf9bbeb5fcf1e7464eb4.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] PCI: AtomicOps: Define valid root port
 capabilities
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
        Gerd Bayer
 <gbayer@linux.ibm.com>
Date: Wed, 11 Mar 2026 11:43:05 +0100
In-Reply-To: <20260310214923.GA823330@bhelgaas>
References: <20260310214923.GA823330@bhelgaas>
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
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b1473f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=47nuJLWWyNEhpKPdMncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4OCBTYWx0ZWRfX9DiEMEggvTUP
 ROazNa5TksWEOqDF4NTday75D0gcIwiGmgbtrkhf0/voPsu9FoRmpTcOJU4erHTe/szdwC3DxjP
 7QP54WWmR3uWeZ57/RX8cRzqNh8OG0P7DQM8WNVVKI1CWHvemCXgMosNmOlLZnntVH7jgs1PEbt
 tC1sAjIJcIuyQQDCRwLmtJTcJXDP57CAfuFh+C/yqT0bp5gdHW1ISgL4vsSCbNAyeSKNBcUDQyE
 CnB1W0EBpsEqB8BcRYpu5B4vMzRV7xMXtx8pOtyfrxwSfxx5uHZtmUljcd7v4ve6IuN2r3HAz57
 e6gP4M9TnePD2rlrXM1IS5iGzx42tMFkNtbwNvdgNuQjliMR4yN5+UD7R90Ij+OsoHt5JjBFtjJ
 L36dkTEN0Pnl/wIouWbfk+hXg9Vwth2sCosuuyFf4umLWmAdMtA31ZfUzJC6vZGaJempIZJKCPm
 SAEoBd/Yqxd4bHmLr/w==
X-Proofpoint-GUID: 2SmBxZTyrhpqTEvqkssE5Yex2WT49E_1
X-Proofpoint-ORIG-GUID: cIe_qzXne_T1INu4ks0EVsZsdHC_Atlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110088
X-Rspamd-Queue-Id: A55352626EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-17963-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Tue, 2026-03-10 at 16:49 -0500, Bjorn Helgaas wrote:
> On Fri, Mar 06, 2026 at 06:13:58PM +0100, Gerd Bayer wrote:
> > Provide the two combinations of Atomic Op Completion size attributes
> > that a root port may support per PCIe Spec 7.0 section 6.15.3.1. -
> > besides the trivial "No support" - as two new defines.
> >=20
> > Change documentation of pci_enable_atomic_ops_to_root() that these are
> > the only ones that should be used. Also, spell out that all requested
> > capabilities need to be supported at the root port for enable to
> > succeed. Also emphasize that on success, this sets AtomicOpsCtl:ReqEn t=
o
> > 1, and leaves it untouched in case of failure.
> >=20
> > Suggested-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> >  drivers/pci/pci.c             | 13 +++++++------
> >  include/uapi/linux/pci_regs.h |  8 ++++++++
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8479c2e1f74f1044416281aba11bf071ea89488a..cc8abe6b1d0766148889587=
6dbbcf8aaeadf4a17 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3663,15 +3663,16 @@ void pci_acs_init(struct pci_dev *dev)
> >  /**
> >   * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root po=
rt
> >   * @dev: the PCI device
> > - * @cap_mask: mask of desired AtomicOp sizes, including one or more of=
:
> > - *	PCI_EXP_DEVCAP2_ATOMIC_COMP32
> > - *	PCI_EXP_DEVCAP2_ATOMIC_COMP64
> > - *	PCI_EXP_DEVCAP2_ATOMIC_COMP128
> > + * @cap_mask: root port must support combinations of AtomicOp sizes
> > + *	PCI_EXP_ROOT_PORT_ATOMIC_BASE
> > + *	PCI_EXP_ROOT_PORT_ATOMIC_FULL
> >   *
> >   * Return 0 if all upstream bridges support AtomicOp routing, egress
> >   * blocking is disabled on all upstream ports, and the root port suppo=
rts
> > - * the requested completion capabilities (32-bit, 64-bit and/or 128-bi=
t
> > - * AtomicOp completion), or negative otherwise.
> > + * all the requested completion capabilities (BASE: 32-bit, 64-bit or
> > + * FULL: 32/64- and 128-bit AtomicOp completion). In that case enable =
the
> > + * device to send AtomicOp requests. Otherwise, return negative and le=
ave
> > + * the enablement in the PCI config space untouched.
> >   */
> >  int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
> >  {
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index 14f634ab9350d5442192162225b5e5202dbe2308..63ac62b882a94c6873a0db4=
33ba808332ddbea04 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -669,6 +669,14 @@
> >  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp comp=
letion */
> >  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp comp=
letion */
> >  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp co=
mpletion */
> > +/* PCIe spec 7.0 6.15.3.1: Root ports may support one of 2 sets of Ato=
mic Ops */
> > +#define  PCI_EXP_ROOT_PORT_ATOMIC_BASE		\
> > +	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
> > +	 PCI_EXP_DEVCAP2_ATOMIC_COMP64)
> > +#define  PCI_EXP_ROOT_PORT_ATOMIC_FULL		\
> > +	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
> > +	 PCI_EXP_DEVCAP2_ATOMIC_COMP64 |	\
> > +	 PCI_EXP_DEVCAP2_ATOMIC_COMP128)
>=20
> I'm sort of ambivalent about this patch, partly because it adds
> these #defines that aren't used anywhere.  Also, the "BASE" and "FULL"
> names don't contain as much information as mentioning COMP32, COMP64,
> and COMP128 does.

Hi Bjorn,

I see your point. This patch is better suited to lead into a separate
small series that continues on to actually propose corrections of
today's (mis-)use of pci_enable_atomic_ops_to_root() in the
corresponding device drivers.

> If we *do* want this, I think these combo definitions are beyond the
> scope of uapi/linux/pci_regs.h, which generally is just
> transliteration of register bits from the spec.  They could possibly
> go in linux/pci.h where pci_enable_atomic_ops_to_root() is declared.

I like this idea, I'll move the "valid combination" defines to
linux/pci.h

>=20
> >  #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reportin=
g */
> >  #define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer sup=
port */
> >  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanis=
m */
> >=20
> > --=20
> > 2.51.0
> >=20

Thanks, Gerd

