Return-Path: <linux-rdma+bounces-14521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D313C627FF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1089B3A6BBE
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41C31076B;
	Mon, 17 Nov 2025 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HR+mnIJV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9D155326
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360550; cv=none; b=qr8TBLOpp49rwBfQ7+rfcAaRfl0l8X8QmU5tbVNVIc0XZRfAFkCbeMOKxVMZQZLnBmzAXTu/7OCbvuSL9FEjJ5PFBp8Dls7ZnhHlUiw5gGF8Cv3Al80x2zBPUEQAJPBotLoUAuEipl6jtgQ/wuF+Jf1XHmnKE/MfnpTrv07WmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360550; c=relaxed/simple;
	bh=NNW5l9AdJbAgnKrA5pvWHnQRLJwEZNDUiKb+nY5XS00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDOwFAWEBNaLFuCxPpKUeBuynngGIyaERKW3TjaTct/4DMVonzXNlLmWAUQZlR6JxqmWje/JpLzhm4OjUJX+j54HuIb8JNFHm4sd1zF8L6aygbM1HqztCOjAxBdIbxgKXqTkS2zFrNahZcPPffe7OCBdyLU5CmWG5DAzvzsIQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HR+mnIJV; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2958db8ae4fso35973575ad.2
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763360548; x=1763965348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwyQscGLEWcVzMK+Zh/2eEVJsAKnI+n81yn33G7AUt0=;
        b=UwnegdxaHMY//Xhf7viOjV/v+A1V7JP6OdnN6qG7M6WtGI3zeUFellhbsS6mVdhobH
         /L3+ZLMYbAuEn/AzZBVujwHCUdH8LDwHV4iLSvmR1o5iEXK8R6FEKf54dTRt1Jwr3F5u
         +MsJXBgTpv5Hlb3xbK/rYb7+tqXRhIeWYODHNjs12Cd6goJpUECi7X5kqkFmVj95MhsC
         TDC+RoATfhI21V4mEj58hOsfJUjdJrgruKTccc332DJSSrvtZlsEUcTtS7AHRBaXICSW
         9HpZDIWK5cMu4DCEwUpyd7qT3U2lW3oZb6+ddIW3UeOpWGajGAKHt3lExwePLGtM5mnV
         yb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXX5R+hwfuYUxQf2VepU9/HzW5Hw/vPQWys11jZ4D5NF4KRfBpqPrwp6mblFeHnQaV4AFgynCKFiur/@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4x94RBKg6vBPzzbl9v7lTjfFesAcDcdX6UZi8LaJ6yAoyAqu
	LxM1UROss8Uz29DIIN9ypGZE29AZSoIJw1/uf/uBpfQtjdAJwv23pFgVXETZmYI7GNCnLCI5cLw
	NN/+XTUk9oZrRqZ4lIB6CfeKCrEsxEDpJdlHFwlZnnNxtnE1EJ3qDgZ5uTQ4CEUNmNjKY9yzW6F
	r1wuQv7+cO00Sy5e2oBtvmT79xzbrOsTZ7FP1wzvzTNdindZJ2fJaVRqeTRYzdFobngIVo3YkKw
	brIRwsTP7Ki/mtzdGRrypDW1wnF
X-Gm-Gg: ASbGncub9Y9aZFCXzTjalTRgK2MyxaQ62G0Nd1kd58dORxQbAlYBkue2JIYBRuV2g3z
	vh4i3sPPR1E3fB3tTgnbxca6rbU7J9LLQzrWQ3bQehZAT49VGWEZGqckGnS31tySQHM7pE/lVeQ
	OFTglvfeEvuP3uXCTis94NhyYHUAqMQfQ4zQiWPb5e/O3mK3p/zOzeEr9e4dSlynxUD7K1s+QLM
	qq5nNIqVb0lYPVXkNdyold49EU408YnT452T4QzWBSn2HDJ8ee0PlY15bEaxKz9O5513Z1Srx/i
	eDDHpaxKl9xj//NII0hkaih7f1geQr92fZ3vTnMv5CJgXp+0Yv0PW1/zYwy0OILh5K5udPEisoi
	iqnxcTUmwCkKf+3P4YfBDC2qSUA5yt92ZSajlS29v2WeXAUblATQKVmGgvUHcNC88VZilcIjycC
	A7Ut5CK5UVNI2YejPkhVdQ8c2cd2Ay/LtmFVTjh9i1DPlXQc0lvyTsCo8/NI0=
X-Google-Smtp-Source: AGHT+IE+10iqDbg+nNZwKoERC31ti1waT3JGUefT6kLzfWcc7m2mF/j3Wj3h+FLmIIEmZ+rbcVel3pVflpD+
X-Received: by 2002:a17:903:388d:b0:298:8a9:766a with SMTP id d9443c01a7336-2986a76744amr115936015ad.53.1763360547607;
        Sun, 16 Nov 2025 22:22:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2985c2554e1sm13072965ad.28.2025.11.16.22.22.27
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2025 22:22:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4777b03b90fso18320655e9.1
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763360545; x=1763965345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwyQscGLEWcVzMK+Zh/2eEVJsAKnI+n81yn33G7AUt0=;
        b=HR+mnIJVEu9QOiFmTofbats34N5w/gAWe0aS5MXWPemrRBQDRPJxmIQuEzgCxjSpet
         4eWxjG9OAPqO5ksWPH+prcBzuUkQKAt1GSMoIv45I0nQEctkcPgEVH/opbphnwuaHtnP
         2CkL7lXO9IPzZ3w4dRsx082DphBqvh2A93RWk=
X-Forwarded-Encrypted: i=1; AJvYcCXd4Z8rHoLfZ7Zl2VNF4UQZ7J92ep6D5zglNbIRYxf/LNlOcgx7QxMrYycXtH2rIOIhhBg5AXV98CK3@vger.kernel.org
X-Received: by 2002:a05:600c:8b22:b0:477:7a1a:4b81 with SMTP id 5b1f17b1804b1-4778fe57115mr101296485e9.9.1763360545147;
        Sun, 16 Nov 2025 22:22:25 -0800 (PST)
X-Received: by 2002:a05:600c:8b22:b0:477:7a1a:4b81 with SMTP id
 5b1f17b1804b1-4778fe57115mr101296305e9.9.1763360544572; Sun, 16 Nov 2025
 22:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110145628.290296-1-sriharsha.basavapatna@broadcom.com>
 <20251110145628.290296-5-sriharsha.basavapatna@broadcom.com> <20251111110009.GN15456@unreal>
In-Reply-To: <20251111110009.GN15456@unreal>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 17 Nov 2025 11:52:11 +0530
X-Gm-Features: AWmQ_bnldubCiKT3Qs4qBeaJ9sVOCdo5GiHQuf8v5aXlOkNE4zw2mDkTOdSq2ks
Message-ID: <CAHHeUGVeYHBRL9xb1ynTdhiYR+4XCEUqh4X8m0x54QToZpm5Xg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v3 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eff3b60643c45eed"

--000000000000eff3b60643c45eed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:30=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Nov 10, 2025 at 08:26:28PM +0530, Sriharsha Basavapatna wrote:
> > The following Direct Verb (DV) methods have been implemented in
> > this patch.
> >
> > CQ Direct Verbs:
> > ----------------
> > - BNXT_RE_METHOD_DV_CREATE_CQ:
> >   Create a CQ of requested size (cqe). The application must have
> >   already registered this memory with the driver using DV_UMEM_REG.
> >   The CQ umem-handle and umem-offset are passed to the driver. The
> >   driver now maps/pins the CQ user memory and registers it with the
> >   hardware. The driver returns a CQ-handle to the application.
> >
> > - BNXT_RE_METHOD_DV_DESTROY_CQ:
> >   Destroy the DV_CQ specified by the CQ-handle; unmap the user memory.
> >
> > QP Direct Verbs:
> > ----------------
> > - BNXT_RE_METHOD_DV_CREATE_QP:
> >   Create a QP using specified params (struct bnxt_re_dv_create_qp_req).
> >   The application must have already registered SQ/RQ memory with the
> >   driver using DV_UMEM_REG. The SQ/RQ umem-handle and umem-offset are
> >   passed to the driver. The driver now maps/pins the SQ/RQ user memory
> >   and registers it with the hardware. The driver returns a QP-handle to
> >   the application.
> >
> > - BNXT_RE_METHOD_DV_DESTROY_QP:
> >   Destroy the DV_QP specified by the QP-handle; unmap SQ/RQ user memory=
.
> >
> > - BNXT_RE_METHOD_DV_MODIFY_QP:
> >   Modify QP attributes for the DV_QP specified by the QP-handle;
> >   wrapper functions have been implemented to resolve dmac/smac using
> >   rdma_resolve_ip().
> >
> > - BNXT_RE_METHOD_DV_QUERY_QP:
> >   Return QP attributes for the DV_QP specified by the QP-handle.
> >
> > Note:
> > -----
> > Some applications might want to allocate memory for all resources of a
> > given type (CQ/QP) in one big chunk and then register that entire memor=
y
> > once using DV_UMEM_REG. At the time of creating each individual
> > resource, the application would pass a specific offset/length in the
> > umem registered memory.
> >
> > - The DV_UMEM_REG handler (previous patch) only creates a dv_umem objec=
t
> >   and saves user memory parameters, but doesn't really map/pin this
> >   memory.
> > - The mapping would be done at the time of creating individual objects.
> > - This actual mapping of specific umem offsets is implemented by the
> >   function bnxt_re_dv_umem_get(). This function validates the
> >   umem-offset and size parameters passed during CQ/QP creation. If the
> >   request is valid, it maps the specified offset/length within the umem
> >   registered memory.
> > - The CQ and QP creation DV handlers call bnxt_re_dv_umem_get() to map
> >   offsets/sizes specific to each individual object. This means each
> >   object gets its own mapped dv_umem object that is distinct from the
> >   main dv_umem object created during DV_UMEM_REG.
> > - The object specific dv_umem is unmapped when the object is destroyed.
> >
> > Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.co=
m>
> > Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Co-developed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   12 +-
> >  drivers/infiniband/hw/bnxt_re/dv.c       | 1071 ++++++++++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c |   55 +-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   12 +
> >  include/uapi/rdma/bnxt_re-abi.h          |   93 ++
> >  5 files changed, 1227 insertions(+), 16 deletions(-)
>
> <...>
>
> > +enum {
> > +     BNXT_RE_DV_RES_TYPE_QP =3D 0,
>
> There is no need to set BNXT_RE_DV_RES_TYPE_QP to 0, all enums start
> from 0 in C.
>
ack.
> > +     BNXT_RE_DV_RES_TYPE_CQ,
> > +     BNXT_RE_DV_RES_TYPE_MAX
> > +};
> > +
> >  struct bnxt_re_dev {
> >       struct ib_device                ibdev;
> >       struct list_head                list;
> > @@ -231,6 +237,8 @@ struct bnxt_re_dev {
> >       union ib_gid ugid;
> >       u32 ugid_index;
> >       u8 sniffer_flow_created : 1;
> > +     atomic_t                dv_cq_count;
> > +     atomic_t                dv_qp_count;
> >  };
> >
> >  #define to_bnxt_re_dev(ptr, member)  \
> > @@ -274,6 +282,9 @@ static inline int bnxt_re_read_context_allowed(stru=
ct bnxt_re_dev *rdev)
> >       return 0;
> >  }
> >
> > +struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev);
> > +void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq=
);
> > +
> >  #define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5     1088
> >  #define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5              128
> >  #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5     128
> > @@ -286,5 +297,4 @@ static inline int bnxt_re_read_context_allowed(stru=
ct bnxt_re_dev *rdev)
> >
> >  #define BNXT_RE_HWRM_CMD_TIMEOUT(rdev)               \
> >               ((rdev)->chip_ctx->hwrm_cmd_max_timeout * 1000)
> > -
> >  #endif
> > diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw=
/bnxt_re/dv.c
> > index 1485aa0a6818..100e18d07f51 100644
> > --- a/drivers/infiniband/hw/bnxt_re/dv.c
> > +++ b/drivers/infiniband/hw/bnxt_re/dv.c
> > @@ -14,6 +14,7 @@
> >  #include <rdma/uverbs_named_ioctl.h>
> >  #include <rdma/ib_umem.h>
> >  #include <rdma/bnxt_re-abi.h>
> > +#include <rdma/ib_cache.h>
> >
> >  #include "roce_hsi.h"
> >  #include "qplib_res.h"
> > @@ -379,6 +380,76 @@ static int bnxt_re_dv_validate_umem_attr(struct bn=
xt_re_dev *rdev,
> >       return 0;
> >  }
> >
> > +static bool bnxt_re_dv_is_valid_umem(struct bnxt_re_dv_umem *umem,
> > +                                  u64 offset, u32 size)
> > +{
> > +     return ((offset =3D=3D ALIGN(offset, PAGE_SIZE)) &&
> > +             (offset + size <=3D umem->size));
> > +}
> > +
> > +static struct bnxt_re_dv_umem *bnxt_re_dv_umem_get(struct bnxt_re_dev =
*rdev,
> > +                                                struct ib_ucontext *ib=
_uctx,
> > +                                                struct bnxt_re_dv_umem=
 *obj,
> > +                                                u64 umem_offset, u64 s=
ize,
> > +                                                struct bnxt_qplib_sg_i=
nfo *sg)
> > +{
> > +     struct bnxt_re_dv_umem *dv_umem;
> > +     struct ib_umem *umem;
> > +     int umem_pgs, rc;
> > +
> > +     if (!bnxt_re_dv_is_valid_umem(obj, umem_offset, size))
> > +             return ERR_PTR(-EINVAL);
>
> I wonder why do you need this check. Will it be better to rely on
> ib_umem_*_get() interfaces for these checks and slightly change code
> to perform dv_umem =3D kzalloc(...) after that?
yes, this can be done, ack.
>
> > +
> > +     dv_umem =3D kzalloc(sizeof(*dv_umem), GFP_KERNEL);
> > +     if (!dv_umem)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     dv_umem->addr =3D obj->addr + umem_offset;
> > +     dv_umem->size =3D size;
> > +     dv_umem->rdev =3D obj->rdev;
> > +     dv_umem->dmabuf_fd =3D obj->dmabuf_fd;
> > +     dv_umem->access =3D obj->access;
> > +
> > +     if (obj->dmabuf_fd) {
> > +             struct ib_umem_dmabuf *umem_dmabuf;
> > +
> > +             umem_dmabuf =3D ib_umem_dmabuf_get_pinned(&rdev->ibdev, d=
v_umem->addr,
> > +                                                     dv_umem->size, dv=
_umem->dmabuf_fd,
> > +                                                     dv_umem->access);
> > +             if (IS_ERR(umem_dmabuf)) {
> > +                     rc =3D PTR_ERR(umem_dmabuf);
> > +                     goto free_umem;
> > +             }
> > +             umem =3D &umem_dmabuf->umem;
> > +     } else {
> > +             umem =3D ib_umem_get(&rdev->ibdev, (unsigned long)dv_umem=
->addr,
> > +                                dv_umem->size, dv_umem->access);
> > +             if (IS_ERR(umem)) {
> > +                     rc =3D PTR_ERR(umem);
> > +                     goto free_umem;
> > +             }
> > +     }
> > +
> > +     dv_umem->umem =3D umem;
> > +
> > +     umem_pgs =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
> > +     if (!umem_pgs) {
> > +             rc =3D -EINVAL;
> > +             goto rel_umem;
> > +     }
> > +     sg->npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
>
> You already calculated it, exactly 4 lines above.
ack.
>
> > +     sg->pgshft =3D PAGE_SHIFT;
> > +     sg->pgsize =3D PAGE_SIZE;
> > +     sg->umem =3D umem;
> > +     return dv_umem;
>
> <...>
>
> > +     if (atomic_read(&rdev->stats.res.cq_count) >=3D dev_attr->max_cq)=
 {
> > +             ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded(=
CQs)");
>
> User can trigger this error and fill dmesg. If you want to keep it, move
> to be debug print.
ack.
>
> > +             return NULL;
> > +     }
> > +
> > +     /* Validate CQ fields */
> > +     if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
> > +             ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded(=
CQ_WQs)");
>
> Same
ack.
>
> > +             return NULL;
> > +     }
>
> <...>
>
> > +     atomic_inc(&rdev->stats.res.cq_count);
> > +     max_active_cqs =3D atomic_read(&rdev->stats.res.cq_count);
>
> atomic_inc_return(&rdev->stats.res.cq_count);
ack.
>
> > +     if (max_active_cqs > rdev->stats.res.cq_watermark)
> > +             rdev->stats.res.cq_watermark =3D max_active_cqs;
> > +     spin_lock_init(&cq->cq_lock);
>
> <...>
>
> > +static int bnxt_re_dv_uverbs_copy_to(struct bnxt_re_dev *rdev,
> > +                                  struct uverbs_attr_bundle *attrs,
> > +                                  int attr, void *from, size_t size)
> > +{
> > +     return uverbs_copy_to_struct_or_zero(attrs, attr, from, size);
> > +}
> > +
>
> Please don't wrap basic functions.
ack.
>
> > +static void bnxt_re_dv_finalize_uobj(struct ib_uobject *uobj, void *pr=
iv_obj,
> > +                                  struct uverbs_attr_bundle *attrs, in=
t attr)
> > +{
> > +     uobj->object =3D priv_obj;
> > +     uverbs_finalize_uobj_create(attrs, attr);
> > +}
>
> Same
ack.
>
> > +
>
> <...>
>
> > +     dv_umem =3D bnxt_re_dv_umem_get(rdev, context, sq_umem,
> > +                                   init_attr->sq_umem_offset,
> > +                                   init_attr->sq_len, sginfo);
> > +     if (IS_ERR(dv_umem)) {
> > +             rc =3D PTR_ERR(dv_umem);
> > +             ibdev_dbg(&rdev->ibdev, "%s: bnxt_re_dv_umem_get() failed=
, rc: %d\n",
> > +                       __func__, rc);
>
> Please remove __func__ prints.
ack.
>
> > +             return rc;
> > +     }
> > +     qp->sq_umem =3D dv_umem;
> > +     qp->sumem =3D dv_umem->umem;
>
> <...>
>
> > +static void
> > +bnxt_re_dv_qp_init_msn(struct bnxt_re_qp *qp,
> > +                    struct bnxt_re_dv_create_qp_req *req)
> > +{
> > +     struct bnxt_qplib_qp *qplib_qp =3D &qp->qplib_qp;
> > +
> > +     qplib_qp->is_host_msn_tbl =3D true;
> > +     qplib_qp->msn =3D 0;
> > +     qplib_qp->psn_sz =3D req->sq_psn_sz;
> > +     qplib_qp->msn_tbl_sz =3D req->sq_psn_sz * req->sq_npsn;
>
> Did you check that it can't overflow?
ack, will check the args.
>
> > +}
>
> <...>
>
> > +static int bnxt_re_dv_free_qp(struct ib_uobject *uobj,
> > +                           enum rdma_remove_reason why,
> > +                           struct uverbs_attr_bundle *attrs)
> > +{
> > +     struct bnxt_re_qp *qp =3D uobj->object;
> > +     struct bnxt_re_dev *rdev =3D qp->rdev;
> > +     struct bnxt_qplib_qp *qplib_qp =3D &qp->qplib_qp;
> > +     struct bnxt_qplib_nq *scq_nq =3D NULL;
> > +     struct bnxt_qplib_nq *rcq_nq =3D NULL;
> > +     int rc;
> > +
> > +     mutex_lock(&rdev->qp_lock);
> > +     list_del(&qp->list);
> > +     atomic_dec_return(&rdev->stats.res.qp_count);
>
> atomic_dec()
ack.
>
> > +     if (qp->qplib_qp.type =3D=3D CMDQ_CREATE_QP_TYPE_RC)
> > +             atomic_dec(&rdev->stats.res.rc_qp_count);
> > +     mutex_unlock(&rdev->qp_lock);
>
> <...>
>
> > +static void bnxt_re_copyout_ah_attr(struct ib_uverbs_ah_attr *dattr,
> > +                                 struct rdma_ah_attr *sattr)
> > +{
> > +     dattr->sl               =3D sattr->sl;
>
> Please don't do vertical alignment.
ack.
>
> > +     memcpy(dattr->grh.dgid, &sattr->grh.dgid, 16);
> > +     dattr->grh.flow_label =3D sattr->grh.flow_label;
> > +     dattr->grh.hop_limit =3D sattr->grh.hop_limit;
> > +     dattr->grh.sgid_index =3D sattr->grh.sgid_index;
> > +     dattr->grh.traffic_class =3D sattr->grh.traffic_class;
> > +}
> > +
> > +static void bnxt_re_dv_copy_qp_attr_out(struct bnxt_re_dev *rdev,
> > +                                     struct ib_uverbs_qp_attr *out,
> > +                                     struct ib_qp_attr *qp_attr,
> > +                                     struct ib_qp_init_attr *qp_init_a=
ttr)
> > +{
> > +     out->qp_state =3D qp_attr->qp_state;
> > +     out->cur_qp_state =3D qp_attr->cur_qp_state;
> > +     out->path_mtu =3D qp_attr->path_mtu;
> > +     out->path_mig_state =3D qp_attr->path_mig_state;
> > +     out->qkey =3D qp_attr->qkey;
> > +     out->rq_psn =3D qp_attr->rq_psn;
> > +     out->sq_psn =3D qp_attr->sq_psn;
> > +     out->dest_qp_num =3D qp_attr->dest_qp_num;
> > +     out->qp_access_flags =3D qp_attr->qp_access_flags;
> > +     out->max_send_wr =3D qp_attr->cap.max_send_wr;
> > +     out->max_recv_wr =3D qp_attr->cap.max_recv_wr;
> > +     out->max_send_sge =3D qp_attr->cap.max_send_sge;
> > +     out->max_recv_sge =3D qp_attr->cap.max_recv_sge;
> > +     out->max_inline_data =3D qp_attr->cap.max_inline_data;
> > +     out->pkey_index =3D qp_attr->pkey_index;
> > +     out->alt_pkey_index =3D qp_attr->alt_pkey_index;
> > +     out->en_sqd_async_notify =3D qp_attr->en_sqd_async_notify;
> > +     out->sq_draining =3D qp_attr->sq_draining;
> > +     out->max_rd_atomic =3D qp_attr->max_rd_atomic;
> > +     out->max_dest_rd_atomic =3D qp_attr->max_dest_rd_atomic;
> > +     out->min_rnr_timer =3D qp_attr->min_rnr_timer;
> > +     out->port_num =3D qp_attr->port_num;
> > +     out->timeout =3D qp_attr->timeout;
> > +     out->retry_cnt =3D qp_attr->retry_cnt;
> > +     out->rnr_retry =3D qp_attr->rnr_retry;
> > +     out->alt_port_num =3D qp_attr->alt_port_num;
> > +     out->alt_timeout =3D qp_attr->alt_timeout;
> > +
> > +     bnxt_re_copyout_ah_attr(&out->ah_attr, &qp_attr->ah_attr);
> > +     bnxt_re_copyout_ah_attr(&out->alt_ah_attr, &qp_attr->alt_ah_attr)=
;
> > +}
>
> Why do you need to open-code existing ib_uverbs_query_qp()? I afraid
> that this in-driver prone to errors.
I will change it to use the kernel function: ib_copy_qp_attr_to_user()
in uverbs_marshall.c, and I will remove the above driver function -
bnxt_re_dv_copy_qp_attr_out().
>
> > +
>
> <...>
>
> > +     uobj =3D uverbs_attr_get_uobject(attrs, BNXT_RE_DV_QUERY_QP_HANDL=
E);
>
> You should check that uobj is not an error.
ack.
>
> > +     qp =3D uobj->object;
>
> <...>
>
> > +static int bnxt_re_dv_copy_qp_attr(struct bnxt_re_dev *rdev,
> > +                                struct ib_qp_attr *dst,
> > +                                struct ib_uverbs_qp_attr *src)
> > +{
> > +     int rc;
> > +
> > +     if (src->qp_attr_mask & IB_QP_ALT_PATH)
> > +             return -EINVAL;
> > +
> > +     dst->qp_state           =3D src->qp_state;
> > +     dst->cur_qp_state       =3D src->cur_qp_state;
> > +     dst->path_mtu           =3D src->path_mtu;
> > +     dst->path_mig_state     =3D src->path_mig_state;
> > +     dst->qkey               =3D src->qkey;
> > +     dst->rq_psn             =3D src->rq_psn;
> > +     dst->sq_psn             =3D src->sq_psn;
> > +     dst->dest_qp_num        =3D src->dest_qp_num;
> > +     dst->qp_access_flags    =3D src->qp_access_flags;
> > +
> > +     dst->cap.max_send_wr        =3D src->max_send_wr;
> > +     dst->cap.max_recv_wr        =3D src->max_recv_wr;
> > +     dst->cap.max_send_sge       =3D src->max_send_sge;
> > +     dst->cap.max_recv_sge       =3D src->max_recv_sge;
> > +     dst->cap.max_inline_data    =3D src->max_inline_data;
> > +
> > +     if (src->qp_attr_mask & IB_QP_AV) {
> > +             rc =3D bnxt_re_copyin_ah_attr(&rdev->ibdev, &dst->ah_attr=
,
> > +                                         &src->ah_attr);
> > +             if (rc)
> > +                     return rc;
> > +     }
> > +
> > +     dst->pkey_index         =3D src->pkey_index;
> > +     dst->alt_pkey_index     =3D src->alt_pkey_index;
> > +     dst->en_sqd_async_notify =3D src->en_sqd_async_notify;
> > +     dst->sq_draining        =3D src->sq_draining;
> > +     dst->max_rd_atomic      =3D src->max_rd_atomic;
> > +     dst->max_dest_rd_atomic =3D src->max_dest_rd_atomic;
> > +     dst->min_rnr_timer      =3D src->min_rnr_timer;
> > +     dst->port_num           =3D src->port_num;
> > +     dst->timeout            =3D src->timeout;
> > +     dst->retry_cnt          =3D src->retry_cnt;
> > +     dst->rnr_retry          =3D src->rnr_retry;
> > +     dst->alt_port_num       =3D src->alt_port_num;
> > +     dst->alt_timeout        =3D src->alt_timeout;
> > +
> > +     return 0;
> > +}
>
> Again open-code variant of existing IB/core function.
I couldn't find any existing function to copy-in qp attr from
userspace to kernel. I will implement a new function
ib_copy_qp_attr_from_user() in uverbs_marshall.c and export it so that
drivers can use it. I'll also export the existing kernel function
ib_resolve_eth_dmac() for such DV use cases.
>
> > +
> > +static int bnxt_re_dv_modify_qp(struct ib_uobject *uobj,
> > +                             struct uverbs_attr_bundle *attrs)
> > +{
>
> I'm starting to believe that this DV QP interface is not right thing to
> do. I would expect DV to be for extra parameters on top of existing
> basic QP infrastructure.
We are not positioning our Direct Verbs to be an extension of existing
standard IB verbs. This is required for a class of applications that
need direct access to hw resources.
Thanks,
-Harsha
>
> Thanks

--000000000000eff3b60643c45eed
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAZLqC9HioZBkDRJAOHZmx1MNEP7dVJRZbE
xEnC+2jnmTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMTcw
NjIyMjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAQpSyQMPX3RKcLXdWfFyeyI2609L1+Pm/adQgj7rSFnYjOfXdyyHeO3mrOx5s97uaLPZG8
aCg96LLlIKLR1bdiU0u6RhIbjzppWSJbcSFU4s93YLOoMQ0DLr1gAhb9ThHE7jDTZav4OfKDVAd9
/Xbx+HOB/UIBhbUc4HDnUJsEVpPYF2Ob6ZvwpX7BrhWP/FJTJayaxa5bvjamUNg1k6AHkKJxgfip
FA36CKvrfj37+64tgENqcayAlGntBj0nQJA0RjhoKUl9JqMiuimBPVSOkxn6Nem5FiM36jopj8cd
vGZA/Y0tDfMyFt4K3rdGMwT51ANJ26lJRf3w7jbQd5hD
--000000000000eff3b60643c45eed--

