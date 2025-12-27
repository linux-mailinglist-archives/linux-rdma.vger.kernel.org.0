Return-Path: <linux-rdma+bounces-15231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65203CE015C
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 20:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438DA301C95A
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5DC23BF8F;
	Sat, 27 Dec 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VgQKTfng"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD97081E
	for <linux-rdma@vger.kernel.org>; Sat, 27 Dec 2025 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766863406; cv=none; b=kaFEUgBtg8eZlmRZNoJWJbFj/pwEouVkIsPu8BAKAYYPrMkiSbaWHutXBU+oXF31sc8H0z3B2e/BtfW1WwLqFOKemcu8TCkrdOe9bh1qEpcZYbWzi1ieEQfDz/qUPgIDBZLf6jre/IWdog/DVnXF6gKyJIBrhfJC1NCYnuBJuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766863406; c=relaxed/simple;
	bh=CIUTJPnEIzdHePK9nwXrWk8cZBaui4jZl8U3BBKZ3mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYsIyaph3jrD1AyMYvU+D6IU3u/NLGLdEujdQwxjY5WXLMEe0sPRVi0qg08077C2QbYouK1RI6ZRLpKYcmGjx1jRcR70Dm2hHAbs8SIiTSaRrUdxph0330uScO4Dag0VP8SEqz4cVPy+NS/9Tp8ujFQQxCkVs8sSHoTNIpdRPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VgQKTfng; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BRIEgw13046471
	for <linux-rdma@vger.kernel.org>; Sat, 27 Dec 2025 11:23:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=/9FmIM1H1ArdH+87Bbu2+pLJOGM2QnqhXssbZ8e99+A=; b=VgQKTfng2L9R
	rhYXyMQRWv8VsHX7/CT8xv9kTh1HVUggRC9V+2MQE3qxxBAlhB5Whhf33c6xfmjt
	t4AK6t+Ljt4S9A8kDvrCo5KRq/JGwnLAc4FITWcnsIcSEHupKq6IK8dqfp+ZYtXE
	A7YyewKvy4DiK4dXA61Qx/Bmq0NdKM6HKfkMYIGeYKb0Pqk4EbUfZEq4rrkOBj5E
	5Q1Jpy+NdKx7+bHeOrz2V0YvU63MeZPUAoYTL1mqeDENXVfdJvcAjQozzfD8JwaG
	ObxnI691JbQRRrjx6wum3rQG6JimJTqPgdfZzFbgEhswuv765pOZAJ8PPkoGLPxp
	78dJRDJIvQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4badudhgdq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Sat, 27 Dec 2025 11:23:23 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sat, 27 Dec 2025 19:23:21 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id BB69FE0509CC; Sat, 27 Dec 2025 11:23:03 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Date: Sat, 27 Dec 2025 11:22:54 -0800
Message-ID: <20251227192303.3866551-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204081117.1987227-1-zhipingz@meta.com>
References: <20251204081117.1987227-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: QN2tSl95qX9-Wd6sztAwqp1XCxKw2q1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI3MDE4NSBTYWx0ZWRfX5mDLaVnSxMy1
 DjuiESnwFKJxEVDIFKheArUAh1ZLfM/IaB1bn6GkgP4C6P5kPqwNzgDVMxy98WSufKenkqA+u0k
 PFMt3+zi6V5d+xAe0u7u+dyQIB6LRamYOVTv12f92h6zEr5akdTg7z/oWd3DdAGjlipccfVIbuF
 ZfyUSmNO6JdCHOLcbkXC6r78OIO86gdW7Mw0vXWhPoduGCeo0YqohM5SdO/I4737tvnzNh9PTBu
 PmG3GmZPCFaurlqiVQyEm6Tas9gTq8YMz3BX6k2pdlfCCfQzFhoZxoNLkWL+3UvGF2i7FiC/WrH
 coUjr69xduWBKQi7cHpEiRNTxZedLK82kctac/TphRM1zB16lHJl4jy8n9VygEoOlWVxMyDW2jO
 90K6JJduREw2fDDFoGT2FSmATtqmz9uDENIp7pYRfXxM2W91y83sDB2tFWxApJAkrFA1r5krj8n
 tUz3NDC7jSKrmUDOsAg==
X-Authority-Analysis: v=2.4 cv=LryfC3dc c=1 sm=1 tr=0 ts=6950322b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=vaBoqUaa7kBdn5e81RoA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: QN2tSl95qX9-Wd6sztAwqp1XCxKw2q1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-27_05,2025-12-26_01,2025-10-01_01

On Thur 2025-12-04  8:10 UTC Zhiping Zhang wrote:

> On Monday 2025-11-20 13:11 UTC, Jason Gunthorpe wrote:
> >
> > Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
> >
> > On Wed, Nov 19, 2025 at 11:24:40PM -0800, Zhiping Zhang wrote:
> > > On Monday, November 17, 2025 at 8:00=E2=80=AFAM, Jason Gunthorpe wr=
ote:
> > > > Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory acces=
s
> > > >
> > > > On Thu, Nov 13, 2025 at 01:37:12PM -0800, Zhiping Zhang wrote:
> > > > > RDMA: Set steering-tag value directly in DMAH struct for DMABUF=
 MR
> > > > >
> > > > > This patch enables construction of a dma handler (DMAH) with th=
e P2P memory type
> > > > > and a direct steering-tag value. It can be used to register a R=
DMA memory
> > > > > region with DMABUF for the RDMA NIC to access the other device'=
s memory via P2P.
> > > > >
> > > > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > > > ---
> > > > > .../infiniband/core/uverbs_std_types_dmah.c   | 28 ++++++++++++=
+++++++
> > > > > drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
> > > > > drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
> > > > > .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
> > > > > include/linux/mlx5/driver.h                   |  4 +--
> > > > > include/rdma/ib_verbs.h                       |  2 ++
> > > > > include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
> > > > > 7 files changed, 46 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/=
drivers/infiniband/core/uverbs_std_types_dmah.c
> > > > > index 453ce656c6f2..1ef400f96965 100644
> > > > > --- a/drivers/infiniband/core/uverbs_std_types_dmah.c
> > > > > +++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
> > > > > @@ -61,6 +61,27 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH=
_ALLOC)(
> > > > >              dmah->valid_fields |=3D BIT(IB_DMAH_MEM_TYPE_EXIST=
S);
> > > > >      }
> > > > >
> > > > > +     if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_DI=
RECT_ST_VAL)) {
> > > > > +             ret =3D uverbs_copy_from(&dmah->direct_st_val, at=
trs,
> > > > > +                                    UVERBS_ATTR_ALLOC_DMAH_DIR=
ECT_ST_VAL);
> > > > > +             if (ret)
> > > > > +                     goto err;
> > > >
> > > > This should not come from userspace, the dmabuf exporter should
> > > > provide any TPH hints as part of the attachment process.
> > > >
> > > > We are trying not to allow userspace raw access to the TPH values=
, so
> > > > this is not a desirable UAPI here.
> > > >
> > > > Thanks for your feedback!
> > >
> > > I understand the concern about not exposing raw TPH values to
> > > userspace.  To clarify, would it be acceptable to use an index-base=
d
> > > mapping table, where userspace provides an index and the kernel
> > > translates it to the appropriate TPH value? Given that the PCIe spe=
c
> > > allows up to 16-bit TPH values, this could require a mapping table
> > > of up to 128KB. Do you see this as a reasonable approach, or is
> > > there a preferred alternative?
> >
> > ?
> >
> > The issue here is to secure the TPH. The kernel driver that owns the
> > exporting device should control what TPH values an importing driver
> > will use.
> >
> > I don't see how an indirection table helps anything, you need to add
> > an API to DMABUF to retrieve the tph.

> I see, thanks for the clarification. Yes we can add and use another new
> API(s) for this purpose.

> Sorry for the delay: I was waiting for the final version of Leon's
> vfio-dmabuf patch series and plan to follow that for implementing the n=
ew
> API(s) needed.
> (https://lore.kernel.org/all/20251120-dmabuf-vfio-v9-6-d7f71607f371@nvi=
dia.com/).
>
> >
> > > Additionally, in cases where the dmabuf exporter device can handle =
all possible 16-bit
> > > TPH values  (i.e., it has its own internal mapping logic or table),=
 should this still be
> > > entirely abstracted away from userspace?
> >
> > I imagine the exporting device provides the raw on the wire TPH value
> > it wants the importing device to use and the importing device is
> > responsible to program it using whatever scheme it has.
> >
> > Jason
>
> Can you suggest or elaborate a bit on the schmes you see feasible?
>
> When the exporting device supports all or multiple TPH values, it is
> desirable to have userspace processes select which TPH values to use
> for the dmabuf at runtime. Actually that is the main use case of this
> patch: the user can select the TPH values to associate desired P2P
> operations on the dmabuf. The difficulty is how we can provide this
> flexibility while still aligning with kernel and security best
> practices.
>
> Zhiping

Happy holidays! I went through the vfio-dmabuf patch series and Jason's
comments once more. I think I have a proposal that addresses the concerns=
.

For p2p or dmabuf use cases, we pass in an ID or fd similar to CPU_ID whe=
n
allocating a dmah, and make a callback to the dmabuf exporter to get the
TPH value associated with the fd. That involves adding a new dmabuf opera=
tion
for the callback to get the TPH/tag value associated.

I can start with vfio-dmabuf and add the new dmabuf op/ABI there based on
Leon's patch. Pls let me know if you have any concerns or suggestions.

Zhiping

