Return-Path: <linux-rdma+bounces-14360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E3C4761B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2871B34657D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45AE312838;
	Mon, 10 Nov 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UAGKaz7X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC8199935
	for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786741; cv=none; b=AZpO5UKV9cNsLwCrXRd5Z57YQoLPmyz5c6wmDELxud4z0s/eA/76QBA8jJose4wvNo7wU0tPlXDKzZK3WieJ71LesWSjwiRtWkf7q6Z/Xv0NLikyft25fV7mphsoU34N3iOW3HffX3U06sVUyP9aMGY3g5YLOY+aEfiUTOu7HFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786741; c=relaxed/simple;
	bh=MLqPQYYnkoH+bIBSKzBib5oQElQVZs/nrGK9BLh1qTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqqL5uO8VxT7wBtC/EM8tLfXngZ3Twop8hEQ91h3wT5pVC43NxKDNAJMRUA24YnDFAsyeghDhPqkbz7FnjQlGys7fNiLVmEZ4WtavebtcJz5P9KqcMWLuYuCsL0eZZFi6FuY37g79pNu4LmMANj3ZPoNcyASs34Tk2q3dP1OOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UAGKaz7X; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-4336f8e97c3so21737005ab.3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 06:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786739; x=1763391539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEV+FV7x6BwxI9epafGpjnGUcl656f8ybqzCCUsn0qE=;
        b=re/N61TDKwCZNSTZxABQ03xPJGNCHj4wbn1KOKXmTmb/9PZAPamm3DhcFPJaOHyT/n
         PSuxBT5geHX2rGp2PhGAwBUiD3Fo6hVLDgW6YLc82SGoBk6uliXJxWsMievIZCTO7khE
         2hhwN5Idw1puKemM47UqNFMa/KJLOgPEiuxjShRLDSIWM92l/7LRJVA1UPqaJ+/zjdCn
         HLnWVz/5tyFfpOVV1EQtrIThaXpxwA+U2zx7qHS8jRxT81pHXQqmNlJSlGmYMtimZnf/
         hU5KQMSmfGxtqvjfzv0s0GQbPws/cHYHaVOZrPbmk6jvMXhf3xPjrXBi0nRRvOn/1h4p
         aPEw==
X-Forwarded-Encrypted: i=1; AJvYcCVjeu4NkDj7Xisf5NYa9L+oApPC0PKKt2mKqkO3El4TW6vvp3a6sDnRUPUYmMiSJEAHuZCvcZYT/u+x@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eHM3pRk2WcXPB9WQE8QxFmcwvpoN1O58qnldGuDKQEK9wm/I
	epu3rd1WJT7sHQo3EVJVwz5DvB+QciYnTEbmlM9lpGhK3xSYUp5o3UZTkwUp2Q4gteFSbtD7SGx
	urlBJZlcrn5xW1MMinwYybdhwy4oXq2DTjs7W5fpcSbEJzP70QjUrLm2L2IUmg3zrigE3+MOkvd
	JL973buDTXg/FfPErBXYU6GMmx2gc69ZDO8hOGTqiPttjgob72IZM6I+raNyPql3iaE8bVBd1Pf
	Fj1LlSgrKffIYD6Ih2JmFTmqEOc
X-Gm-Gg: ASbGnctzSbZt6tqkvcE1CVp24FN10QBwBddZoRHif/J03aybtihE538y3Nlw263fZJJ
	QYBOO3PpMeOtJHvc9HR0nRCJI4FFZAutnTzlZ5Redh/azA7iG8mZ2d7SPqGfgPGWzndf45wZow8
	R2Fv7DV6Hww7RAsSgCuY8fNp2xSwDrPcqQxL1XLclv/+P+JOtbT1jgpRbfwhrer+CnuB5yK2EKL
	jmyLAVpGnDQXohyIwZFOOINDXNh/kT3c62jGbV6kt5oLn3BAkQWxyymtAMUFq2lr9gfrgzfJLgw
	Q/C4Wh7CGDJu1rWLAq8goSBXVkNt9X1GsvHlaM1OasS9d0VHZKSc4Buy4oF6ktqZfuKqvOpCmA3
	lP7QdKLHPk4MMOyTs2wctS49kV9iHC9S27MXrt/Kw6fKhaRZhVhh4e+09ny+hDNdAdp2Uhi8PK0
	sU3UTFnVKFsdeIbQC/sMOkyPcersgGlh/eL+OtcG5OAcwDg+aK
X-Google-Smtp-Source: AGHT+IGGdfwntkUB55QdeGSCABzSV2DWZuG5kouHcKO7oWU4t5dqnqFSFlZOLFj0Ag1aujPVUHll9/DzhS/x
X-Received: by 2002:a92:ca4c:0:b0:433:2d7e:3076 with SMTP id e9e14a558f8ab-43367e7accdmr117342305ab.18.1762786738881;
        Mon, 10 Nov 2025 06:58:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f4c683esm11736155ab.31.2025.11.10.06.58.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:58:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso1419298f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 06:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762786736; x=1763391536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zEV+FV7x6BwxI9epafGpjnGUcl656f8ybqzCCUsn0qE=;
        b=UAGKaz7XCaRrjSbZWE5kS6mzQ5jS3CXjMw6ps78fM+q/o33KBJfExX7weRtuMcIBDE
         JR9KoVhzZjccboa7zXjS9DHTHDaPuVQk5JXgySeWS985RdfIVb5vXv54SVjkcKsJzPUS
         e3JrEiL1BD5x6r1fjglvMKi1cGqCkuwFHcX/I=
X-Forwarded-Encrypted: i=1; AJvYcCVoMrn/fI66ijoOeU8p3eSuCOabW8ZcEqFCJpWyFrk82/thqbBvWmGL+K8PHRl/fHHOdv3U6DWjFlck@vger.kernel.org
X-Received: by 2002:a05:6000:178e:b0:429:d3c9:b8af with SMTP id ffacd0b85a97d-42b2c6941c9mr6849102f8f.25.1762786736251;
        Mon, 10 Nov 2025 06:58:56 -0800 (PST)
X-Received: by 2002:a05:6000:178e:b0:429:d3c9:b8af with SMTP id
 ffacd0b85a97d-42b2c6941c9mr6849082f8f.25.1762786735777; Mon, 10 Nov 2025
 06:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-5-sriharsha.basavapatna@broadcom.com> <20251109094905.GH15456@unreal>
In-Reply-To: <20251109094905.GH15456@unreal>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 10 Nov 2025 20:28:42 +0530
X-Gm-Features: AWmQ_bmWX6lwbUQYzS2OnrkbspDN3ppV6LSdGlLE9dZRvAzgeUOtecOtdKTgQcE
Message-ID: <CAHHeUGUtM8gca8zhnN4oDHOkQybVLAgPUvtfoYXAOvDNbBw6dw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000040fc9006433ec5a6"

--00000000000040fc9006433ec5a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 3:19=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Nov 04, 2025 at 12:53:20PM +0530, Sriharsha Basavapatna wrote:
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
> >  drivers/infiniband/hw/bnxt_re/dv.c       | 1208 ++++++++++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c |   55 +-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   12 +
> >  include/uapi/rdma/bnxt_re-abi.h          |   93 ++
> >  5 files changed, 1364 insertions(+), 16 deletions(-)
>
> <...>
>
> > +             if (IS_ERR(umem_dmabuf)) {
> > +                     rc =3D PTR_ERR(umem_dmabuf);
> > +                     dev_err(rdev_to_dev(rdev),
> > +                             "%s: failed to get umem dmabuf : %d\n",
> > +                             __func__, rc);
>
> All these dev_XXX() lines should go. They can be used before IB device
> is created, after that you are invited to use ibdev_XXX() helpers.
Thanks, will change them to ibdev_XXX().
>
> > +                     goto free_umem;
>
> <...>
>
> > +static void
> > +bnxt_re_print_dv_qp_attr(struct bnxt_re_dev *rdev,
> > +                      struct bnxt_re_cq *send_cq,
> > +                      struct bnxt_re_cq *recv_cq,
> > +                      struct  bnxt_re_dv_create_qp_req *req)
> > +{
> > +     dev_dbg(rdev_to_dev(rdev), "DV_QP_ATTR:\n");
> > +     dev_dbg(rdev_to_dev(rdev),
> > +             "\t qp_type: 0x%x pdid: 0x%x qp_handle: 0x%llx\n",
> > +             req->qp_type, req->pd_id, req->qp_handle);
> > +
> > +     dev_dbg(rdev_to_dev(rdev), "\t SQ ATTR:\n");
> > +     dev_dbg(rdev_to_dev(rdev),
> > +             "\t\t max_send_wr: 0x%x max_send_sge: 0x%x\n",
> > +             req->max_send_wr, req->max_send_sge);
> > +     dev_dbg(rdev_to_dev(rdev),
> > +             "\t\t va: 0x%llx len: 0x%x slots: 0x%x wqe_sz: 0x%x\n",
> > +             req->sq_va, req->sq_len, req->sq_slots, req->sq_wqe_sz);
> > +     dev_dbg(rdev_to_dev(rdev), "\t\t psn_sz: 0x%x npsn: 0x%x\n",
> > +             req->sq_psn_sz, req->sq_npsn);
> > +     dev_dbg(rdev_to_dev(rdev),
> > +             "\t\t send_cq_id: 0x%x\n", send_cq->qplib_cq.id);
> > +
> > +     dev_dbg(rdev_to_dev(rdev), "\t RQ ATTR:\n");
> > +     dev_dbg(rdev_to_dev(rdev),
> > +             "\t\t max_recv_wr: 0x%x max_recv_sge: 0x%x\n",
> > +             req->max_recv_wr, req->max_recv_sge);
> > +     dev_dbg(rdev_to_dev(rdev),
> > +             "\t\t va: 0x%llx len: 0x%x slots: 0x%x wqe_sz: 0x%x\n",
> > +             req->rq_va, req->rq_len, req->rq_slots, req->rq_wqe_sz);
> > +     dev_dbg(rdev_to_dev(rdev),
> > +             "\t\t recv_cq_id: 0x%x\n", recv_cq->qplib_cq.id);
> > +}
>
> And I afraid that you went too far with debug prints in this patch.
> Please remove ALL of them and leave only minimal number of error prints.
I'll remove the above function, which was needed during the early dev
cycle. Also, will reduce both errors and debug prints, and will keep
only a small set of dbg msgs that we have found to be useful.
Thanks,
-Harsha
>
> Thanks

--00000000000040fc9006433ec5a6
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCfwUWhAj4w2oAxsMOy7u2MfH80ojyUexuf
id0pKXy35jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMTAx
NDU4NTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQB6wkm8cxcaFNYsMm0kjmXBrfZMsagAmxUxUZcEjS3GRu/DdHvw/c6SyMqMtV18K8li9UHN
iFP1wEIVLqXesE364krA70r11u8obXWFtn+9syuPasHt5NitxJd5D5LKFSCTgdKUgyn9ggopjMNc
/kL3PoW5Mp1uYKpndbfPEQhF/cA4L4uAEP+xPD3TE7jykOZFwzS9gdIiOhCuECSg5wvQ47HuSAs+
VuPw024wdlpi8FDMoOVQJ/5737cGf6vPzJrMblYpv8CMHgbpU1Frya86Cpu/Ni9d5AlccoeVu5vN
NbFGWCtypYc7jS7o6XeOCFtNT+hVrqN1rPNUoneZnRDW
--00000000000040fc9006433ec5a6--

