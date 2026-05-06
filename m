Return-Path: <linux-rdma+bounces-20101-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGJXNNeE+2nXcAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20101-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 20:13:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B6B4DF2CC
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86B83300C327
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18684BCAAE;
	Wed,  6 May 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WohxvzDB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E147ECE2
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091212; cv=fail; b=McoohEd9/7knFkc53Tn2ivCfK3Q0s2+tv1T3WkmxrDmc8SSSdz4Q1Y+wB9vwWUKi9wxwzjc0jY2LY9tmaY1YLXjQgggWlli8oVXyKynB+Z5aoD8RxiTmNlyn5OOckJmTxZtFyXA63uz9ZRkCgntQKQaKRIDN4HAorHVNz9Lz7UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091212; c=relaxed/simple;
	bh=iwJF8kNlzSONi72wttB9cdvYDDohgwHHTCevGMN+7M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Liwn81ayAe5t7jJEjNC4np0hKlUb/Vdw8Ys37CWhWWygorhuIGga9uu4ZFDM0N4MuODQd//HV3Y7MDxAOmcXIwd72R6JGdMhy6cJhhZMRAiIcsq5+Gr7RgBytGzX8mPNPI8QQHT/7sRuQ9ukOrZsqEAGwcAqeC07casKV8zNdn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WohxvzDB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6468D6lG2489313
	for <linux-rdma@vger.kernel.org>; Wed, 6 May 2026 11:13:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bsbBvRMYnEJLwO6vFciq2lgaf49YRFfLC0382/bbMDg=; b=WohxvzDB7qU8
	o2wqk7WXisIZ2+qX8jjaoaehtsTVUyToiY5UVloN7qizzETPowd5S4Zb8nsC9EMl
	ULfRCe+eyS5F3L7XFUvewUEdAC5eCpjIHy/fSU0RKXCPBgxqLmVKOK5uz4d1xyua
	Eke9sevlGUcg5bDSN2idKRVF5h0mP8Krj1GJ0bk7ZFEuvrRJTHCQyy6EslL8rHDc
	eY2QYB8+Y7raLFdBngjmOlFSqJJ7pt4TUuOaX0mcx7wJ+l1lJ5lGdJpHSXCX+lte
	R3HEpqoAP35QuGsNrP9kQzHI0fvkMtoI/VDJafYjIWur8zAzA/LlV1Ml+TglKNA0
	ju/vhonoEw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwck1tg3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 11:13:29 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7de4be150b9so31280a34.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 11:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778091208; cv=none;
        d=google.com; s=arc-20240605;
        b=WN16lUWNT+FKG5vGmTjMyDdFnvuGsMnc0vp9Wmnge5E5Wzh9SV7rZnh7MQ5e2rK/w0
         emT60NRlLLOWzbs74qWpQk8nS+R84FemAvBWAVpSMYjC6i8f1j9VTRQuMEr+id796nWy
         kJuEF+e4ESQQqsj4Z1+yHMEeW6VvQ0lf/07r1gUCxMj9fppi1h5Ldm3wKk1/sR5cpvXP
         9VyowERofFXFkjs1hZJeZ8bXrau0vafdMT5H6Q5k0rd5QoMpej6SGVpcxPi1lQhPkwHs
         ZCkq7UQWnticS4dIWoKCKQZOOn3xytZtSJ1omDTXEdeGa9rS3kbh8/6WHz2tTGmgIPaM
         O8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
        fh=jzXdSpRHuZKgq2SImNF8pnlhZahHJDqxkTqW0N8PQOA=;
        b=IkECEP56LZ85MFCW/6Wzu4mtTrT3EIQtjvhoaUuFq6bZEJyCdrD1uh2ZCgX5YAPjpx
         XNKrI9gUW2szoAqnH5R5eHFiENZeWiK9lFrKVWJtLOjRSWxKg/d29bALsHo49omBHODj
         y2sdigG2hwuxOo+sWRy5QXLYEscW0bd9ZfzlAaAgwxIU/vcjw2vmAZPIP0jh7A6vDNhf
         gOn3mggLfg755xxSoiVkem6b/T5seZjRFusPv2mPVZPKP++efHzwxsvthdUYg6oVxgo9
         fyPplE9W+OjqI9H4H2bs3Fr9SmXI94gTQr6PT7U5A31DgWNPdGGanQ/wbxi3VLzxyWG1
         f1rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091208; x=1778696008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
        b=iwxxAiQaQa8TCmQc0k2oWgW2RJfy/8CTz/mbuHfvIsypQoF0wm2l1E9FpMSqzvBwax
         O7H5K0ynvFXIpsSI3t04UyD4+JxZr6RMgC5TMfYCuJYyOi9D3jfXhTAslcFP+XNAbxLM
         p2MHPw/7WlX1teSR3/YTblxt10TIvHb8PEhbS+Hk4YUnI+qo7qG4EPRDLfGFS03kKhfn
         QGZ5/vLXI7W866X2o9jBS4G373/D9g1AjGODGxxIDqc4TEWvmqJP1eaMt/diRKYg0svZ
         x9A91QEk9bfk72R1oFehXHVq7C9HeT7tX5ppXKetd42Ln3KbXBY7yP4n8/15sPJP8UcO
         9wXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iUoIuYcrgEz4Plm5qTjA1YLgBo/UxlvXV9BXgzQ8zmNHhPeww42N9kYh7BiCu7ElXuFVRv8uahaNQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgsj0KpCUqWynnRSgjeRIeOBjp/pH7yLvRTHFVLc4pEWIqtJ2M
	ck16gl2H0e2FRV/AOe3HkmeDCC1YKIVbjK9IB3q8E4SnDWRCQ3DocdwVJrl7zxd6azTcvFr79qR
	MQEdqeVh5yTPHBgddkt1Xk8VGh/317FGpsybrqUktEuGgUhzD1CxgPDRRU3BbIy7jmnHQvQxJNL
	tWz4smewDofPY4/RXTHj19UT+MtuEo0xoUinNR
X-Gm-Gg: AeBDietxJwCqwo55vzKk2ewJwXyyRkbjzlqSw6knzNWyA0yrUHCVzd7bPJRiZasr+x1
	c4flpaRQbPVMEK7UrZYCnkDgujAAjYiy3BGVVhiNNSPp+0E51X+M1+vKINuhcgv8ShZhWS/JqTr
	sDm7lF53u43RF1gIPgjz2jU8jsPo7904nHc+CwMJ2Y5kv+vM6cEgdurukQWZrW9gLbgpgY0xmyF
	4b6TWYfSJKTRjK9k5wjNqJmWRhj0/4F
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id 46e09a7af769-7e1df2863femr2542385a34.28.1778091208356;
        Wed, 06 May 2026 11:13:28 -0700 (PDT)
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id
 46e09a7af769-7e1df2863femr2542358a34.28.1778091207771; Wed, 06 May 2026
 11:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-3-zhipingz@meta.com>
 <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
In-Reply-To: <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 6 May 2026 11:13:16 -0700
X-Gm-Features: AVHnY4IkP9FyuA_XByk4LxkXqiqZTgspyYe5GlY8B_-IOTQbxE0OcjjDWm1D7Xc
Message-ID: <CAH3zFs0zAf0=kxxMfyxuBF0Mw+0FTFANHDG5C9d7-vQ9dFO0Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: qp1W3fva5nNJlZKQWLT9Gwn2EzrquYpk
X-Proofpoint-GUID: qp1W3fva5nNJlZKQWLT9Gwn2EzrquYpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OCBTYWx0ZWRfX410brv0EBYrS
 2NpIa1U+o/noP8pOYC03CnMTgD2nBXNX2lMAVq99tC1avWSLwErzrwl+zGePsS3MXalvFsdbc55
 sJ7pXtjU8oB/4d06JFLgTQ2PzA6GpRZCAW8AVNAbB0TWI6MWGl4ZPqjJX08rz+BPVVD51hxMkKz
 C4hQPMpQWVZ6vEJgwEUVblTKy7AeHKZjuHsrkcdcxRY81mprKOMS94p2fbJ2NdXl3qHKwhniPis
 8sDUkH4zZfnVYEY5yEhpDDB/ChbaHs+K+PmZmAvH34ZDtzHe4yvvJLyR1M1JOzEs9Rf7Y8Dd/Uh
 NSnUGI52OMc2IsO7FbIwNxjOpZcqNvdDTPHxNf8SlFd3FEjII3S6NRxSM2LUGuuGVrXe8Jt6XME
 K8wKKPbqacsYBrmR/B87oaSQCCIe3cQbXcX3c/OUV2nnpXKlKMjCYsD+TwWe1rBx1N4TPQZ5emD
 uR8YVle+w5qh4SnX6Wg==
X-Authority-Analysis: v=2.4 cv=Pu+jqQM3 c=1 sm=1 tr=0 ts=69fb84c9 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=kFoJLRxUVyBjw7Himy0A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 63B6B4DF2CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20101-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,meta.com:dkim,meta.com:email]

On Wed, May 6, 2026 at 12:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> > peer access and translate the raw steering tag into an mlx5 steering tag
> > index. Factor mlx5_st_alloc_index() so callers that already have a raw
> > steering tag can allocate the corresponding mlx5 index directly. Keep t=
he
> > DMAH path as the first priority and only fall back to dma-buf metadata =
when
> > no DMAH is supplied.
> >
> > Pass the device's supported ST width (8 or 16 bit, derived from
> > pdev->tph_req_type) to get_tph() so the exporter can reject tags that
> > exceed the consumer's capability. Initialize ret in mlx5_st_create() so=
 the
> > cached steering-tag path returns success cleanly under clang builds.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -46,6 +46,8 @@
> >  #include "data_direct.h"
> >  #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> >  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >  {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +901,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >  };
> >
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st=
_index,
> > +                           u8 *ph)
> > +{
> > +     struct pci_dev *pdev =3D dev->mdev->pdev;
> > +     struct dma_buf *dmabuf;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     st_width =3D (pdev->tph_req_type =3D=3D PCI_TPH_REQ_EXT_TPH) ? 16=
 : 8;
>
> The tph_req_type is defined under CONFIG_PCIE_TPH, how about add a wrap f=
unction
> to query it.
>
Good catch!
so the direct dereference here will break the build when TPH is
disabled. I'll add a small
wrapper in include/linux/pci-tph.h alongside the existing helpers, e.g.:

  #ifdef CONFIG_PCIE_TPH
  u8 pcie_tph_get_st_width(struct pci_dev *pdev);
  #else
  static inline u8 pcie_tph_get_st_width(struct pci_dev *pdev) { return 0; }
  #endif

  with the implementation
in drivers/pci/pcie/tph.c returning 16 for PCI_TPH_REQ_EXT_TPH and 8 otherw=
ise.
Then get_tph_mr_dmabuf() becomes:

  st_width =3D pcie_tph_get_st_width(pdev);
  if (!st_width)
      goto end_dbuf_put;

which also gives us a clean early-out when TPH isn't supported on the
device. Will fix in v3.

Thanks,
Zhiping

