Return-Path: <linux-rdma+bounces-22197-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id caIaKdzYLWpZlQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22197-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 00:25:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 052ED67FEC7
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 00:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=igpbZWWh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22197-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22197-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01CA1303ADE2
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 22:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC723A6F0A;
	Sat, 13 Jun 2026 22:25:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0395368D5A
	for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 22:25:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389518; cv=fail; b=tkD9woEo1MpLCAFZgv/0SRISB3D+9Dy3XY/oTAW1O2UZH9ul+cv7E3tDDdtHtaCnlVrAp7YOT9bv12wR4iNo9BZpmiNeB1hwUX93nteLLFsvLGoSCG1rrVOaa2FKj+7+XcQqPJWv3dyeIGFpDJubSZnToxIPVNjWfsTkdyIE/tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389518; c=relaxed/simple;
	bh=1bdEY5yxv5t9XP5TtCJFWuEDTtBiQLjm4/B3JBKM7qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWzWtmh3kfVncJIqoWEJmgGdqE2+M7jNCgOtmMBic55qALXkDv7+RN5HGxKWvL5f1+lI8ArKYODt3ATEm5RE8UfDXT402IozvLX9bb/aJ/vLC9FiGgGKOiwhZa1NnkINAiqAXU7ggIplheNmtrlYeVW5C6/D+adrtVbCnh9uaA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=igpbZWWh; arc=fail smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DKjRFE1592438
	for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GRdIE6LSM1bH8RC9lncAbOJ2JdACIXbSk43KFW5xUf4=; b=igpbZWWhgcAG
	UQRhHeAkQUcQT9YS1C1yizMLyYubisFvGTIHjvXAP5Yq4zFuMdy0J6izagbAVYGE
	Oh4Rla1pSyswX57EwIqs6wjhCDpr7SSai2oeugc/TSvmNQ5+HA4Puhr8hB2sZfKm
	K24vuXIvlgHEIVuujAPmgQN4D9olXWM87UFrSbGJUSfPnONyzsT6/QOd4nUKplB6
	+eaVfmM5zaV0rySMY0pM1OEcco2PwpNZ4z+evfY3ySdK+6zvdWUdR9NvkMhTpJgz
	2PddCQmkEQIS46pCY7lwRWXYNf7regn3XsKqdJFxiGmJlAP+qmzk4l0OhsbMgxA/
	LQsjKjm8TQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es2h0jdyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e71881b08cso2276134a34.1
        for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389514; cv=none;
        d=google.com; s=arc-20240605;
        b=ZLowA2MXvszNm0zFiY0C5DQg4dJA3ciiVVT9EfeWLWpyxIgsXOLnrkhvnovTE63wzR
         1dFmBfSNQ+ZMaUzDLvrDPZHfiKsB9RR6cocpUdL9lLiwrpXgh0n7AIzlp4YQGRJs+tTN
         pahBhJbtzpyUqdOz956EaLlAbnHd3bZnSg50cadqTNSYT8u0K42lPpbuWX3PDS4tdawW
         rWycy9KxmV/xXxTz5ekJro1qPY0rVO9FRxmkEWbhw0tO52DGkJV3ABlS0G/JFublqxVx
         lV9JbfPH48L/L0Q+woPBPCAzz+QPt/oinLiDxAy21KOebUp6MwQpMT+Uh7SfRQK9hDmT
         DDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        fh=Oo3mr+wNq9k1/RZaMAfRh07mGNBRQFnzb9h1g5DdmaU=;
        b=dzJB2SOFSk9441KUUfhczPoQwImqGuNtm62Vdq4yJYpJPKFt9MX2nQ7Y42Z2z9D9MQ
         A31RPP7tWf0KVa+/4MpS6pnyYY8wo+k2kyZrBrewrJliuEiWO921bHif+RZyhY3ysQdX
         USu8cQhW9MRl0L8xkphyneG1Sgkcv1F6LEz4uZt5z2DxWVEzmt34wQssv+Jhrg5IZij+
         +q04CtET9a7S/lqSLgtvtdD0dDI7hPMaNzSxZm9H9KfYubnL5oRKDGC/+zkRkJAPx/g2
         5j3AZBkCROXuNNmEJQ8fbEDVsYZ1SyJB51Rtvs3mkWHRwwP6pphTEpwe7BXwyZtsj0h+
         gWrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389514; x=1781994314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        b=RAAVLu2AZe8iAfTJvduVN7rY7d6NVGozLRUFV7RiMz0Thu9zlPWopT5fAwxHlbIwvd
         3s7vwk7k34Rc3QnHipngtTV0GE2zlGUBBbw5ve1qCcUCMAarXu+GRuZ/SEqa53+40sJ6
         ehRBngPEqWptUgRfxMpZDPRUp1I+ivGcRYXGwfJD1A4Jdhs6gtt69+bW/rsKyKDIdxE3
         5iPZUYT8gTwoT2zJZnooT1jyC1jtj9crRaq5WSNWGifm4X9pbUhTHCtoMvtsch5aNxeA
         wzM3FGTvPTB3JuNWW9lYDwFtGdnl0j/7Clhujd0Ys3OBmqiOQnJ1c4lwtuD/g3AXJISP
         VqtA==
X-Forwarded-Encrypted: i=1; AFNElJ/ElGXkLJAu6jJaDx2ut0fQyKq7Z+7IoUZLjwpkIVN17YfS3hdE+yngHZ6oB/wsJJve62dh3/2Ow7Xa@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX0VAyx7+6vSQmFjhUUFCAWamNhhfdTdTafrvwmcbKsrrAe3U
	VWFMGQPN0V+BfNbkfcTZolIjpkKWTJQHdwupB+7HYdvwBCozqu0RSjugIsXc9GYGQLfNKufaDuh
	NBCw9E3N1Qib7O6GjMiBWpjARMS47E5ju3jf7pxPIJDRx6OybZJwSH/chh2F8Lfhw1lMu4jD1Sd
	fvTclt/TDAV2GrD/M5LVZRMwPiCuUrpazU7qOLy5xOHrgc
X-Gm-Gg: Acq92OF28bSUVHMajKy+YAILA2urbamxbqmKScBZrTyigXWr+0/8jMpsIMhojGyiYOA
	mAfU9NR+9QuwYAm5tuWsVd+lFaBqGuAI9v4erVQ7O1p/DkYXVeyphGgvoTJyHd2olPKMv4nS7/G
	L+UaezAtBmzxXc/gBHgJbkKugtFAanZBjuqQllVCZGEWGk+e0nO6nUvMRc6xIei13GR7U8L3ZvL
	gMFEFazFBtAPgyI2sL6pg==
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id 46e09a7af769-7e78e75e354mr3483170a34.14.1781389514257;
        Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e78e75e354mr3483152a34.14.1781389513778; Sat, 13 Jun 2026
 15:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-5-zhipingz@meta.com>
 <20260612111001.5b7206eb@shazbot.org>
In-Reply-To: <20260612111001.5b7206eb@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:25:02 -0700
X-Gm-Features: AVVi8CexW_WJJGnDTI4HN0FLeTaWayUrCy_spJuvDIJixjLtGyyKLpDTD_UhDYM
Message-ID: <CAH3zFs0Nr6PCEVj0+iyAt6bdOVdQCnmNOCVuJ-5v7xAtKFuXMg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a2dd8cb cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=e6IX7qM6bnzC-tgAjTwA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX1FaFjZ3Ztd4a
 gT7/tI6TXkgzaDLDd1SXsH+hHyj0nmjMz1zFJpOO3rlvpdF0hxh1cnyXMq0mRCaQLxC9LL2py8p
 UHxKX770rxTTr2iVatJ4EwIJPgAgW3s=
X-Proofpoint-GUID: xk_0iaAA6eHfMyBNEzniETurNjBqBFLM
X-Proofpoint-ORIG-GUID: xk_0iaAA6eHfMyBNEzniETurNjBqBFLM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX5MUpXtUCMExX
 OWMbx9rf0bbuPM6NMr3IFsA246R4SF8u3xBytYu+s7WajJXPkFrfwkIJNk6Q9VOlbfGI73EJYca
 fUq3LxUbRkQAr1HvMMwqQd6fY0l6w2hsV8lbHDURHD08QtjPe3zljCXzVHcy2rRCinQ6eexzg5z
 LgWYNaz+BNaY+xK2jxrIlol6TjFRfU6GcQFXGjFkiAOOpvUErDqv1oqMNGTJ81kI3OnK6CHpG1P
 itHQkD5WJlFA/91LxuHkGaQ6ooBRkeEDFASeTaJQBvgaBNB63m6akM2fGf3iWI0u8/w3zjOwExp
 OZJGGIo1g1EfDvStjlJgrn9Gi7Hevki0c1cwc9mdxTOTKUFzPxJ0zZjj82+5DLqBKGmaYLvl/cs
 mZ1oQjH5C/hTUYpqcZwAGJbbCmMceBXBLuNH1J0Y1av+A1J/koC4sIxRICyWmduv7ZoA81aa7+7
 OJTOG34j0cpAcTaYZ6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22197-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,meta.com:dkim,meta.com:email,meta.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 052ED67FEC7

On Fri, Jun 12, 2026 at 10:10=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:19 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> > for a VFIO-owned device.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_tph() returns
> > the value matching the importer's requested namespace or -EOPNOTSUPP.
> >
> > Publish and read the TPH descriptor under dmabuf->resv, matching the
> > locking used for other importer-visible dma-buf state. The SET ioctl
> > takes dma_resv_lock_interruptible(), while the callback runs under
> > DMA-buf's asserted resv lock.
> >
> > Reject requests the device cannot consume as a completer:
> > pcie_tph_completer_type() must report at least
> > PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> > PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Validate fields before the completer
> > check so userspace gets the narrowest errno.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 94 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 37 ++++++++++++
> >  4 files changed, 145 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 1a177ce7de54..0a0705c8dbea 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +20,12 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
> > +     u8 tph_ph:2;
> > +     u8 tph_st;
> > +     u16 tph_st_ext;
> > +     u8 revoked:1;
>
> If these bitfields are now all protected under dma_resv_lock they
> should be grouped together with a comment to that effect, no need for
> revoked to get kicked out to its own storage unit.  In [1] I'm
> proposing runtime modified flags each get their own storage unit, but
> for more isolated cases, so long as we keep track and enforce serialized
> updates, I'm ok with runtime bitfields.  Thanks,
>
> Alex
>
> [1]https://lore.kernel.org/all/20260611213539.4100590-1-alex.williamson@n=
vidia.com/

Sure, will group them under one comment.

Thanks,
Zhiping

