Return-Path: <linux-rdma+bounces-14849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA92C98923
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 18:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C4784E1D5C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFED338593;
	Mon,  1 Dec 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iaXlWHOw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F73370E5
	for <linux-rdma@vger.kernel.org>; Mon,  1 Dec 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611035; cv=none; b=rUQ4j/GQMHUw5tMufZ5/ZymGpIsFrbTn1NafjnA5n83SxypEBrPf7ODd7c6JVjMx8Qvh2xIGH3Qpmd59MW9lHK7RTGR1s8cDoCCC1VxHnMTRl4+114Ur4i60Gs6Bb4fLIW+RgAftu9Uf4a7WYzIVjzsfBwE0Z68zWRz19+TGYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611035; c=relaxed/simple;
	bh=vjOMJrWFQpr1l88g7CIRlvPS5Pmc7X/YX9VtAzCpaCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gY1ta7YnjDUm5No9FMRawUQjka6R5Pn3/ZN3VByM1r0K5mwMyZluIGAp0vRfzR/vzsX1jFXxI0Obt8D37TesALKdCSsbAA4/4HaNImcst9Ct/RopmXyXFlGHQ1pquV3SSh7sDOw07ZzsE4wbOV2juoVmPwIH2B9v5bL27ULe0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iaXlWHOw; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1DxaDD3692447
	for <linux-rdma@vger.kernel.org>; Mon, 1 Dec 2025 09:43:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Nx2UlxPjAHEeAyLfVRPlU3Hm4xB6ZJ8PKySSxUXhnfs=; b=iaXlWHOwfkel
	ZJyZWL/esQTbnTK2151OSIX+o4Ji9ep+FASbSPTccT4Y5mvR9IEpPZkeyzE3Ea+l
	3ClIwG9JOppInwWJ8n2Bzmg3dLc0QfFtgalJY/MG0w+GgVMqkIgmrwZAzksKS9hk
	RtXb5q8UeFodFCw3FIQskN/2L5TBfLrnVTZHJdpCsOEoo+etXKoe7KV4TMKbJGhl
	TD5wN32YnjPfjuhSus+Q6hXqScQEMTzE3qij7fc0cjLeUMx+6IAA3G4fSX5kq7pI
	hbUhkuYiUwirqYXiWMelCltG4y5F8yeNRtdPaMHU8DtCJtoHTTqgaGdvhx4ptxdF
	odq9tbll5g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4asccyt4b2-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 01 Dec 2025 09:43:53 -0800 (PST)
Received: from twshared24723.01.snb1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 1 Dec 2025 17:43:49 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 7C26BCBE0463; Mon,  1 Dec 2025 09:43:39 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
Subject: Re: [RFC 1/2] Set steering-tag directly for PCIe P2P memory access
Date: Mon, 1 Dec 2025 09:43:20 -0800
Message-ID: <20251201174339.1852344-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124212753.GA2714985@bhelgaas>
References: <20251124212753.GA2714985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDE0NCBTYWx0ZWRfX7jrHVKgRhikZ
 2fNoaC7QipIC0Y2Zw/aUWePnRA78OkTg5BY7l1k7QrkKqLE/V/oHGElde5WDbnTCldj/CECOS2j
 /eQzDB71DaMtcIxUHtxVfrz759VICcBbuchGar3J7Alvjo72YYHpUGLerL3C+bJH5sbDRwksDn+
 +a8qPoD8Y73NoG+N2BFawJMjnT/3GMC/al7yDA7tMJwV6SOT4ZpYneoXkVx7KfSoIKPVuAOhxD3
 OAFxgjiUXsiQefh51XjiDsgWz7uFsZsW5+jNBV0quP2DwCLwb184kVXd5mcL1nOi8BLqNm+VF0c
 ArNNf3aLmcnfbaIvDViIVRCZS1nxzFYSGzWRxl/qooU57pZT3V9aVKDKD7XiTYEJIfA8ivVOu7m
 izQP0EIn6s3pu/ZDbmhC4f0rWZTqMA==
X-Proofpoint-ORIG-GUID: u36mgK8GD5FAgxhCxaDBfdsdb6NZutXD
X-Authority-Analysis: v=2.4 cv=TbKbdBQh c=1 sm=1 tr=0 ts=692dd3d9 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=S7gPgYD2AAAA:8 a=VabnemYjAAAA:8 a=8hobeDgTnmXHB3sxjRwA:9 a=QEXdDO2ut3YA:10
 a=1f8SinR9Uz0LDa1zYla5:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: u36mgK8GD5FAgxhCxaDBfdsdb6NZutXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01

> On Mon, 24 Nov 2025 15:27:53 -0600, Bjorn Helgaas wrote:
> > PCIe: Add a memory type for P2P memory access

> This should be in the Subject: line.

> It should also start with "PCI/TPH: ..." (not "PCIe") to match
> previous history.

Thanks, ack! I will update the subject line.

> > The current tph memory type definition applies for CPU use cases. For=
 device
> > memory accessed in the peer-to-peer (P2P) manner, we need another mem=
ory
> > type.

> s/tph/TPH/

> Make this say what the patch does (not just that we *need* another
> memory type, that we actually *add* one).

> The subject line should also say what the patch does.  I don't think
> this patch actually changes the *setting* of the steering tag (I could
> be wrong, I haven't looked carefully).

Sure, I=E2=80=99ll correct and revise the commit message to clearly state=
 what the
patch does.

> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/pci/tph.c       | 4 ++++
> >  include/linux/pci-tph.h | 4 +++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index cc64f93709a4..d983c9778c72 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -67,6 +67,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_ty=
pe, u8 req_type,
> > 			if (info->pm_st_valid)
> > 				return info->pm_st;
> > 			break;
> > +		default:
> > +			return 0;
> > 		}
> > 		break;
> > 	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
> > @@ -79,6 +81,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_ty=
pe, u8 req_type,
> > 			if (info->pm_xst_valid)
> > 				return info->pm_xst;
> > 			break;
> > +		default:
> > +			return 0;
> > 		}
> >  		break;
> >  	default:
> > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > index 9e4e331b1603..b989302b6755 100644
> > --- a/include/linux/pci-tph.h
> > +++ b/include/linux/pci-tph.h
> > @@ -14,10 +14,12 @@
> >   * depending on the memory type: Volatile Memory or Persistent Memor=
y. When a
> >   * caller query about a target's Steering Tag, it must provide the t=
arget's
> >   * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/doc=
ument/15470.
> > + * Add a new tph type for PCI peer-to-peer access use case.
> >   */
> >  enum tph_mem_type {
> >  	TPH_MEM_TYPE_VM,	/* volatile memory */
> > -	TPH_MEM_TYPE_PM		/* persistent memory */
> > +	TPH_MEM_TYPE_PM,	/* persistent memory */
> > +	TPH_MEM_TYPE_P2P	/* peer-to-peer accessable memory */
> >  };
> > =20
> >  #ifdef CONFIG_PCIE_TPH
> > --=20
> > 2.47.3
> >=20

