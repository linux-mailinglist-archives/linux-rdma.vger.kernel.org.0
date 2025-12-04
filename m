Return-Path: <linux-rdma+bounces-14877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77062CA2C24
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 09:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C0B23007239
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD92FF142;
	Thu,  4 Dec 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fyRCOBpy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBC279DC0
	for <linux-rdma@vger.kernel.org>; Thu,  4 Dec 2025 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835890; cv=none; b=ojz8k0NCidAWF8rKmlMyKnuMV/GcHXArvPKDm8RvIqEkIsbKaabsflBEnpE4wIrd5Z3/VgFL9Y/i3vhTdMsUQ6kS1styQ8XN7lV/MrqftNsQSgEHLh57fGBxVGrRTGCP10DpMVWt1kEvQW8QLLPBaUqvv2lAUkEPVwEmte2HWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835890; c=relaxed/simple;
	bh=DGXIKSWSyIMgUWpRteBTNa/XMA2SaRhyxSPqWU/ROVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbdEhxC0yyNb9ZDKL5lZs1NZ2DB6g00I0WJYX4z2tjc8gZOPhDUwdNbMagU+rsXbTmbisPhfYNJRZ0JiALBj+lX/uWz63jI2P4ELV9Cp3l8anOzocPQplNxfBsvzq8fR9gI3/Xf6+9IIZ7xyGUHeKV2/nQAfn9tmOVEdXYaOQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fyRCOBpy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B47aXb82801804
	for <linux-rdma@vger.kernel.org>; Thu, 4 Dec 2025 00:11:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7MPRysJOVUlQ0qt4ZjKDZkV1oM9qOCbvfSMlkApW+X8=; b=fyRCOBpyWqyP
	pBDCaTOxrpCvnqqVqsTqLm+lxA45vIOZYKgRCWBS/Wf5OlRNCU9IEfgYQkyNMKeY
	itnmuci3XZV2jOLoDMcLfz9oWj3VRNgh/pGnMTffdyrhWYlDyCe6Cj7Cr93T5QKa
	EaXOVlFVrXszqd/W4M0BjJLk0mah5bwjDHDB9GO4lPHROwNBcIMCsQ+ONNmn+dJe
	s2uoO5Cm8AljACqgArqfZxPC2g69ERpwNDcpk2UC2WJ9C2wKUOQkGsxRivU4Ge7r
	LPVi9b2N0xgSA2NFqECiLQn9l2Un+Ud2GyOIPg6MpOfZszhqHE5GZ7yI88dpGIj/
	DB3uPNj4nQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4au62c85c5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 04 Dec 2025 00:11:27 -0800 (PST)
Received: from twshared13861.04.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 4 Dec 2025 08:11:26 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 9A8A4CD93C85; Thu,  4 Dec 2025 00:11:17 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Date: Thu, 4 Dec 2025 00:10:58 -0800
Message-ID: <20251204081117.1987227-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120131140.GT17968@ziepe.ca>
References: <20251120131140.GT17968@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA2NSBTYWx0ZWRfX997jD7nsilHp
 mAiWyaTvyyv6v4gj9HrsR1iLKE8tYGnONoeWvctV59UnGt6f6iVW3aorwAKSu37TJHkPzQJ+egD
 f3WCmV/PXKIYypRWw+P6YpPKD5NCyubF93Hn4eFUEwIP7+rCJO1M2XP5uU43+ph3eOD9TTF+BF8
 qGQ3XFpLr/k2dyl6hz8aul0kg4wcBU+ezFsu/T+3q3mTyxl6ti/IMegL6vY50BfkpXBU78UVMkr
 za/ogHVbOYOXAssCEC/y7+w4B1tNlkYa+EPBh5sNau/ksrcYOqqyil4mtNrDPQ/BrBwk2fnYjYu
 9/FMZWhOYhdTD22M6TdYtzJqKUGUHUmb4R9PdUsOb0Hkwz1gao7C7HYc9SXuGUxwhFS+1Moq28e
 BCbU8U/UIsljRapJdpQEpzc9qXbjEg==
X-Authority-Analysis: v=2.4 cv=LdUxKzfi c=1 sm=1 tr=0 ts=6931422f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=buVF335sMQSAnXPDUfMA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: La-UJtwmFUJuv8RnT8HPZohSNuYPCf52
X-Proofpoint-ORIG-GUID: La-UJtwmFUJuv8RnT8HPZohSNuYPCf52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01

On Monday 2025-11-20 13:11 UTC, Jason Gunthorpe wrote:
>
> Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
>
> On Wed, Nov 19, 2025 at 11:24:40PM -0800, Zhiping Zhang wrote:
> > On Monday, November 17, 2025 at 8:00=E2=80=AFAM, Jason Gunthorpe wrot=
e:
> > > Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
> > >
> > > On Thu, Nov 13, 2025 at 01:37:12PM -0800, Zhiping Zhang wrote:
> > > > RDMA: Set steering-tag value directly in DMAH struct for DMABUF M=
R
> > > >
> > > > This patch enables construction of a dma handler (DMAH) with the =
P2P memory type
> > > > and a direct steering-tag value. It can be used to register a RDM=
A memory
> > > > region with DMABUF for the RDMA NIC to access the other device's =
memory via P2P.
> > > >
> > > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > > ---
> > > > .../infiniband/core/uverbs_std_types_dmah.c   | 28 ++++++++++++++=
+++++
> > > > drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
> > > > drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
> > > > .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
> > > > include/linux/mlx5/driver.h                   |  4 +--
> > > > include/rdma/ib_verbs.h                       |  2 ++
> > > > include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
> > > > 7 files changed, 46 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/dr=
ivers/infiniband/core/uverbs_std_types_dmah.c
> > > > index 453ce656c6f2..1ef400f96965 100644
> > > > --- a/drivers/infiniband/core/uverbs_std_types_dmah.c
> > > > +++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
> > > > @@ -61,6 +61,27 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_A=
LLOC)(
> > > >               dmah->valid_fields |=3D BIT(IB_DMAH_MEM_TYPE_EXISTS=
);
> > > >       }
> > > >
> > > > +     if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_DIRE=
CT_ST_VAL)) {
> > > > +             ret =3D uverbs_copy_from(&dmah->direct_st_val, attr=
s,
> > > > +                                    UVERBS_ATTR_ALLOC_DMAH_DIREC=
T_ST_VAL);
> > > > +             if (ret)
> > > > +                     goto err;
> > >
> > > This should not come from userspace, the dmabuf exporter should
> > > provide any TPH hints as part of the attachment process.
> > >=20
> > > We are trying not to allow userspace raw access to the TPH values, =
so
> > > this is not a desirable UAPI here.
> > >=20
> > Thanks for your feedback!
> >=20
> > I understand the concern about not exposing raw TPH values to
> > userspace.  To clarify, would it be acceptable to use an index-based
> > mapping table, where userspace provides an index and the kernel
> > translates it to the appropriate TPH value? Given that the PCIe spec
> > allows up to 16-bit TPH values, this could require a mapping table
> > of up to 128KB. Do you see this as a reasonable approach, or is
> > there a preferred alternative?
>
> ?
>
> The issue here is to secure the TPH. The kernel driver that owns the
> exporting device should control what TPH values an importing driver
> will use.
>
> I don't see how an indirection table helps anything, you need to add
> an API to DMABUF to retrieve the tph.

I see, thanks for the clarification. Yes we can add and use another new
API(s) for this purpose.

Sorry for the delay: I was waiting for the final version of Leon's
vfio-dmabuf patch series and plan to follow that for implementing the new
API(s) needed.
(https://lore.kernel.org/all/20251120-dmabuf-vfio-v9-6-d7f71607f371@nvidi=
a.com/).

>
> > Additionally, in cases where the dmabuf exporter device can handle al=
l possible 16-bit
> > TPH values  (i.e., it has its own internal mapping logic or table), s=
hould this still be
> > entirely abstracted away from userspace?
>
> I imagine the exporting device provides the raw on the wire TPH value
> it wants the importing device to use and the importing device is
> responsible to program it using whatever scheme it has.
>
> Jason

Can you suggest or elaborate a bit on the schmes you see feasible?

When the exporting device supports all or multiple TPH values, it is
desirable to have userspace processes select which TPH values to use
for the dmabuf at runtime. Actually that is the main use case of this
patch: the user can select the TPH values to associate desired P2P
operations on the dmabuf. The difficulty is how we can provide this
flexibility while still aligning with kernel and security best
practices.

Zhiping



