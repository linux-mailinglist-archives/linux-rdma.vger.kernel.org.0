Return-Path: <linux-rdma+bounces-14280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9A7C3AD6A
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 13:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B27C6343F01
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C41320CB3;
	Thu,  6 Nov 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VtKKFoog"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C62D9ED9;
	Thu,  6 Nov 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431402; cv=none; b=bFPlVFCtYt9/wAqQa9vrDG2gvt9z5OM5ubsNXB2Bx6CCnFWfWzh0g2lbHs7UBNCE/IM5oU0QGjprhFBLPmv9JcjG2Z3rYBspaIOvwalqqAfoNJ373x+VcC5YYj8WCvcRxuUGOi2md3cEgpYWFW0HXHgSbsX3M1o632IL6AWohkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431402; c=relaxed/simple;
	bh=d0lvBQBKFzvv/5IIxMUKuBk5kRz11DcP5bXpYzrCN+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dd1nIH293TTy1253miBJQSe2+PTj3SnAfW1/swWDZET03AES3YlN8cEdD3BWNIE86Z6qtiWXTOmBuxEMH05RBjcEEkyUb1tRAynoxjb/3b+IFjea7d+8zdhVQQFVmencJa03xfYgVvw+H2mRk1VKihX26ZpPaWxWiA1GhK3jG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VtKKFoog; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A683PlB008672;
	Thu, 6 Nov 2025 12:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+1oTEV
	MTQXpJ5Ki/iTFboiZZJng7H4yZjFT2iwT00s8=; b=VtKKFoogS83150vuVmsM2G
	SN0cN+7ZZNli1MlK1FWFVjTfC8bhFq3MphhUvL3pGM3uGEUgUwYG9qRB42wrWEEX
	md9iThcZAu59r1wjpnZ0wy5ZwW1rfhPCdaDOGRwG0/rqLbAoSucTn2sUeQdylXRs
	8seMDPso0FswYxCDPUh58I8/B6cHyCUDY1DSehimWB0Ne/81E8psi3byYPJ5VmeK
	ee744zoN9IQRB7DH8KGRGN7AedJ4DQgSI4ySufXoTGlDgN4F5mrUPbMhROr51yPs
	RDAjyldvnA4xClxjN8XbpIm8jo14Oi5PqakywJ7XQQ6iTqvOrzvGLEfHE+Tor7oA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q970cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:16:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A6CB9pO016372;
	Thu, 6 Nov 2025 12:16:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q970c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:16:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6B5EhL025588;
	Thu, 6 Nov 2025 12:16:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhswhk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:16:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6CGJ4i25756206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 12:16:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 427DA20043;
	Thu,  6 Nov 2025 12:16:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA51820040;
	Thu,  6 Nov 2025 12:16:18 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 12:16:18 +0000 (GMT)
Message-ID: <ec44c1ceab176c0a4c6447f966da8b7061958ffe.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] ib/mlx5: Request PCIe AtomicOps enabled for all
 3 sizes
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller"	 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jason
 Gunthorpe <jgg@ziepe.ca>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix
 Kuehling <Felix.Kuehling@amd.com>,
        Niklas Schnelle	
 <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
Date: Thu, 06 Nov 2025 13:16:18 +0100
In-Reply-To: <20251106101917.GB15456@unreal>
References: <20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com>
	 <20251105-mlxatomics-v1-2-10c71649e08d@linux.ibm.com>
	 <20251106101917.GB15456@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690c9198 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Wqnc6qscLTDqH0BWY3YA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 29QpuMSFYT_8eQVmRwQQ1-q_U7vXVlaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX/nw8E0gojWEo
 cDLMydgSGUHYHoV4feP32uTZ8CH+21y0jeiMp226rS7ElAbdWv9BisKMQIajo500ATC/xmlJj28
 8NczSmwZGru7t3D2JnyFgQ8ROdO2zTPOJFJyaOYV55aCvKWcujzaMD8G3+8/uZpqFYxGRI/HZXV
 y164QJOr1SWfqRY2mIOFrkOftygxj1XLYGdR5cB+cfFs5P6nOETV7AQNNqY+ign4Gw4EiTw/U3u
 BYwR+RhwJLdoGXqvaI+RYrlal+yYVPCepoyStTf+KBTw4jRP6Gerxkbo1jWcxOiW/pECySUjHN/
 T2NTIJMsb/sZCNDDreW/6GVe3KY88aTX1Z88MLrsKKAgO+DnU7tTFliDhBe0zVb9hNSNpI5R/LQ
 dSHJbN2JlyJW3pzuCS/nuevG6njghw==
X-Proofpoint-GUID: tN-EXOMwLVamCrHKgK8oMSNrxEBUos5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

On Thu, 2025-11-06 at 12:19 +0200, Leon Romanovsky wrote:
> On Wed, Nov 05, 2025 at 06:55:14PM +0100, Gerd Bayer wrote:
> > Pass fully populated capability bit-mask requesting support for all 3
> > sizes of AtomicOps at once when attempting to enable AtomicOps for PCI
> > function.
> >=20
> > When called individually, pci_enable_atomic_ops_to_root() may enable th=
e
> > device to send requests as soon as one size is supported. According to
> > PCIe Spec 7.0 Section 6.15.3.1 support of 32-bit and 64-bit AtomicOps
> > completer capabilities are tied together for root-ports. Only the
> > 128-bit/CAS completer capabilities is an optional feature, but still we
> > might end up end up enabling AtomicOps despite 128-bit/CAS is not
> > supported at the root-port.
> >=20
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> >  drivers/infiniband/hw/mlx5/data_direct.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/infiniband/hw/mlx5/data_direct.c b/drivers/infinib=
and/hw/mlx5/data_direct.c
> > index b81ac5709b56f6ac0d9f60572ce7144258fa2794..112185be53f1ccc6a797e12=
9f24432bdc86008ae 100644
> > --- a/drivers/infiniband/hw/mlx5/data_direct.c
> > +++ b/drivers/infiniband/hw/mlx5/data_direct.c
> > @@ -179,9 +179,9 @@ static int mlx5_data_direct_probe(struct pci_dev *p=
dev, const struct pci_device_
> >  	if (err)
> >  		goto err_disable;
> > =20
> > -	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32=
) &&
> > -	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64=
) &&
> > -	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP12=
8))
> > +	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32=
 |
> > +						PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> > +						PCI_EXP_DEVCAP2_ATOMIC_COMP128))
>=20
> I would expect some new define which combines all together, with some
> comment why it exists:
> #define PCI_ATOMIC_COMP_v7  PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCA=
P2_ATOMIC_COMP64 | PCI_EXP_DEVCAP2_ATOMIC_COMP128

I see your point. I don't understand the _v7, though.
Reading PCI Express spec 7.0 section 6.15.3.1 where for root ports
basically just 3 combinations are specified:

 - No support (all 3 sizes off)
 - Basic support (32-bit and 64-bit supported)
 - Full support (Base + 128-bit CAS supported)

I would propose to add the following combined defines to
include/uapi/linux/pci_regs.h - and then use them here:

#PCI_EXP_RP_ATOMIC_COMP_BASE(_SUPPORT) to be the "or" of _COMP32 and
_COMP64 and=20
#PCI_EXP_RP_ATOMIC_COMP_FULL(_SUPPORT) to include also 128-bit

But I guess that becomes a PCI question then. @Bjorn?

> Anyway the change looks right to me.
>=20
> Thanks,
> Acked-by: Leon Romanovsky <leon@kernel.org>

