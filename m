Return-Path: <linux-rdma+bounces-18719-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAvVG1q7xWkeBAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18719-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 00:03:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDB33CE19
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 00:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15DD33050201
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 22:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD9346E7A;
	Thu, 26 Mar 2026 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S+c8kVnG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053B32F757
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565759; cv=fail; b=Jr/wtHTVtvbDYOJTp2yE4gKnT0Ph9BRBql1fKrLZJ9joK03dd5mraYPVfb8ZH5eCh27i5ni5Fo+oh2ElVLy2O8A1j9jgZ86jk+/Ynm4nAY9Jk/xGdiFN9Dnuf+dJc09eIEW0ZwUdjNkDuGeZPBeT54bjDK5kFAhaCqhFXkUJ6aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565759; c=relaxed/simple;
	bh=BdyUGS9qVrZC2M4zs7j3VJuPzuCzCdpvDKaUG3wf5J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5TKORBIHI/IdxBEWLh0Z0btgauVIt4vIQoRIoEzsj5CgWuu7uIpzqwRaskFgkKDQ9jwR0gtjnTk5vAGl5LyFBmXAPlYPUwtweZyNtbllcR2Lx/AzmX9ExxUhD74Rq6uqla8pu3IEPdGr83CBfq5wDFywHeXgFMkW+JukFHs3oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S+c8kVnG; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QKa5Ep3969906
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 15:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gWmaYzOqDIhtbUb8Zs5Nf1ednm4S50xRfwW0Jz6U+w0=; b=S+c8kVnGsspV
	a654lLZZ0b8EsEWQ7eZrMsM3U42hl5QQn43gPcbCwg1iIRVkzVp2dRFBMOENsKwv
	SFukOMCLHJB+BVExRhe9tAQ85TnRLm8BMieG/xu8T5GxAF4nxZYBRBXXNSu81mfz
	72IHHjWgJ7wrMUq4HLUK01uWKkwfjjbYiSew0OJdVYtTd9jpySKJMO9QYnD5wD1F
	hO4pop4o2ClGk5kOI5qvHHOrYSB5X7rKufRQLoSTlAVCrJgs3+MLzJEtviKWKK4E
	rl7jpexzUWHR2QNxm3b2slr+Jfm5udNi6cLbkjrHBtc/MhaQw/bPV2OzMvUx4TNz
	3tP95BR8hg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d53xer9mn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 15:55:56 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-46724fd619cso6194309b6e.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 15:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774565756; cv=none;
        d=google.com; s=arc-20240605;
        b=kUmqeVb2QLRogdoB2ocwy7RsrAnF++QEZj5v2Y1u2vt6h6K3HMB8FjhZEz6jxgL1js
         t6SRMnRJlXqjruaHhHKfuCVTKMdQcuKvrw+8FMcL30F7EgC0Bjs3rDGqyYQ7BM3dBJC6
         d7xYD/QCiCWtzz5P9KX7NNg9i3h49acYsHReC46t3gWT4mk1J0puQIcW/0MdmXeqbn4j
         tUpACBm9oPExxCVbOKVvAEoKruOZzTfaDlBrk6lQbeCudT6++qM+pVfI3ofJ+sj9WoWf
         fas20uXwaHQ35gbuGg7bNhLStdt3MDkiIpPqGp7DXsHqiUkRprRoU90K1qKGqzffFWwd
         6Jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
        fh=bC1vbZk4hi0F726KvbZLGzgGyDmfTzVZe4H2cmGFdok=;
        b=NbRT23fadMOH7KJRUVDkmmIDwhecKo8m8JwUWuyzi3/ERMNmQRfiYENs7W4XhUwkS/
         sgAL+jbesNIopfhhMOGX33fnc0X4bwOfhr+MNv6yNbU9+PVCpPesAmuMtAMpzd0jRmz4
         Gwq15+U2Jh1c7qi2Xs0ToTrarp35RK3P1Dm3k64Su4Y7mUD3nqe8FhN9QPdjxf658Vgv
         Y9IDtvko+LRo0L5gMJCm14lQDAfXB00E0G5zJ9mNbF7mygDMsHwVzXgSD6rmBVYJP9j2
         jJH0KgMM56RDNGQry1ZGqIJPCFqYQzDa675CyUu/sj7ss7PJSMtgCpdAgRl8nntWD0gC
         zJXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565756; x=1775170556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
        b=SbgaNa1J+kT4t8fuy0Q/CwPL7wrEu76RvvR4YTLYlH2puDd9jKOOHRplT+d0Wqq2zk
         KTqeAqwYDNZxz5zxh0XLi0nJ+pgSxLd7Ec7kR6ahrnhy8xjB2Qq3cjzyDY9t8FC1Qnxy
         Uk9XJdVebIF02jd+8CZ6LDkppYXyH9nPhdI6p+8KXeqC1mc9KzoXqyHD+TtHPAnGh1ja
         qCozICiO1QJtaY+8gSInXy9SYY2r4yHX3+f1ajX8NnVU/rmCzQj3F6H2WdZmXlfeEqNc
         sbe7u9oyxawf5cbGeUWj/DepqlEJtmOezC6KUMf89Yrv4ymh4jdol5wPCnBg96vwjP+k
         lEIw==
X-Forwarded-Encrypted: i=1; AJvYcCUexpLjvE3w3MMxY+U+Bw0i8kqxp/0OrufTZnkQub4lHVJQtPuDPktoZ3LIjaC80Fhey0oLNBGdp4ZR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wjWQ5nFpf6uJiEK5/217eMDcWEnzsKKgKSYTVfqCkDlLgHSb
	LRckzk9o531TCz2JI+KjrXbdPC2VYj0Y+f3DPvACH6iQemG3pZmIxkWWOh0rjsHuGsO1fYE1Qn1
	Chjq9WkYW6h5gTikhe8moywiEJzV5a6nBypuaSr9n45h+NSnon0NFPDVHD6VAkgis3Y69we4XN9
	yf+tAiPMtOAvlu9f1BTikGUbglDe6EqSjVoyko
X-Gm-Gg: ATEYQzxKix9hAOQ9669YI/yPMUMCAFwpfAuediCT84wGRXNcoMrihi/FfYmnzLiEo2c
	UOOoR3gVnZg+G6+77lUpKNS+0wJLxW7wq8whRKkmfq369uCfkXU8EO5U3hrLyJcHz/Di7upHm5e
	N7OyTCxaVi05ebZodBurA+/2/1YesNzGCuOGEFhqpE1y5A8ls/seF+xAeP6DtMLXd6+6v8cSYxg
	n17Ql+Ox73uKV1+23iFoA==
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id 5614622812f47-46a7aa42abemr1548508b6e.32.1774565756380;
        Thu, 26 Mar 2026 15:55:56 -0700 (PDT)
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id
 5614622812f47-46a7aa42abemr1548497b6e.32.1774565755966; Thu, 26 Mar 2026
 15:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324234615.3731237-1-zhipingz@meta.com> <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
In-Reply-To: <acW2BwQKaUbS3eL9@kbusch-mbp>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 26 Mar 2026 15:55:44 -0700
X-Gm-Features: AQROBzDisNUSNgd3TlIskyBeYU1qigTy8IXoqXl2UWp2Iq9LIcNA3h_mkSfPwow
Message-ID: <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NCBTYWx0ZWRfX8Hv27cSqC5EW
 9ntclIjtoVv8CZO2A6CnBzPpnlPsmeDtIPvjwABjGVwKh13dUBb3kq9669vfk5Q6mVhvcd5X+MC
 Gl5Eo9tmKeOdsb1mR4Nuw7bnt0cH8GwaamoCLXTMpvPCXq+PpzxWxQD47AaNq153+2suuUs5257
 xTacbE6zWb9knX2aOIaNns75XT5gl0jDa5L+mhG3/ElAu09cRdv/+npawlswd3OrsBJugxUDoOZ
 XONVOA3m0QXHVNna7tPP1NvQI8w1pOPqqFttjmrbIamoRpM1heB8bAbimU/RBPUY4hYIR4vCv5T
 M7oQzy7fKiite7lhL3KziHUTlv2GbbuC9uADa/uUBNL1BTthYiU7zv4eZeBJwDPCzo4d2dkZBfX
 M2BGrMv2LzCKVwHxxwtzpD3P7EnGq+AwLXvKkbCE3nr7ZPAcT0u+hdG58w9a+QH3ZCCDsP84khV
 DWGDx0PaU++uy91Uwsg==
X-Authority-Analysis: v=2.4 cv=IucTsb/g c=1 sm=1 tr=0 ts=69c5b97d cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=NFdbOB6VLuGm633tFYQA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: KGChIfqmu-jHjasauj-n4EhnqDQsHozd
X-Proofpoint-GUID: KGChIfqmu-jHjasauj-n4EhnqDQsHozd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18719-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCFDB33CE19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 3:41=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> >
> On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > >  struct vfio_device_feature_dma_buf {
> > >     __u32   region_index;
> > >     __u32   open_flags;
> > > -   __u32   flags;
> > > -   __u32   nr_ranges;
> > > +   __u32   flags;
> > > +#define VFIO_DMABUF_FL_TPH         (1U << 0) /* TPH info is present =
*/
> > > +#define VFIO_DMABUF_TPH_PH_SHIFT   1         /* bits 1-2: PH (2-bit)=
 */
> > > +#define VFIO_DMABUF_TPH_PH_MASK    0x6U
> > > +#define VFIO_DMABUF_TPH_ST_SHIFT   16        /* bits 16-31: steering=
 tag */
> > > +#define VFIO_DMABUF_TPH_ST_MASK            0xffff0000U
> >
> > This extension of flags is basically kills future extension of this
> > struct for anything that includes TPH.
> >
> > Add new
> > enum vfio_device_feature_dma_buf_flags {
> >     VFIO_DMABUF_FL_TPH  =3D 1 << 0
> > }

yes we can do that.

> >
> > > +   __u32   nr_ranges;
> >
> > add your "__u16 steering_tag" and "__u8 ph" fields here.
>
That is what I did in V1, Leon.

> You're suggesting that Ziping append the new fields to the end of this
> struct? I don't think we can modify the layout of a uapi.
>
> If we can't carve the space for this out of the existing unused flags
> field, I think we'd have to introduce a new vfio device feature that
> basically copies VFIO_DEVICE_FEATURE_DMA_BUF with the extra hints
> fields.
>
if not using the fields in the flag, then we probably have to
introduce a new vfio
device feature.

> > >     struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> > >  };

