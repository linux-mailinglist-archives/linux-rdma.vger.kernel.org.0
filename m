Return-Path: <linux-rdma+bounces-21483-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FHFELM2GWrzswgAu9opvQ
	(envelope-from <linux-rdma+bounces-21483-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 08:48:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B05FE216
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A17B83032F4B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AC3AA4E0;
	Fri, 29 May 2026 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="myui/KH8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923C2E7386
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036915; cv=fail; b=F1L0fG3s7cj7WE3cy/KuzdMpxcfV081/mvDGQd6yUi2O2HKSeIOagm5ER+T8xCC0waF59PDGmAPgRZ3eubRWflf1YuPn41m8yhCjKzzliv7kvUgFS9El3VEPfBHMK25v1eMr0Z4j93LvDkyarOvz8nuJ0ldxwdgtsIugr4o0jWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036915; c=relaxed/simple;
	bh=RUFhAdhfxdt+409Lo5x+VBLswnLbP635ULre/4vDtdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKUXheVwYsSCz0vx9XIU1KLhqo7baCQu5T15hK9+rLS2xwzI63AyH8F2/iyClo7PLUIDh/iSdHlRl2KVPf4N/iIkwwu3XfAivA6yt2lONTO3qyGxmmQLmxTICGseRpZBeYYBZ2r7CNs6wP9a8ec/A8sY4A1p4N137oK6pFr6Wl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=myui/KH8; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T01mlD2015443
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wjl2lJMhu3x6YF6VZMdTDkNQcozAcKqTdHEY7+axmxo=; b=myui/KH8juDb
	9VFRxDDFEIimNoAd5XwHhraUO/L1qE4ZtZnO5K+/nzprny+oPTbRJWHwUl7Iab/B
	cMLPIr8HMpKYeWusLbb/K+iwCBNNEvNQ4TbH/N8JWoEGZzYAl66wAE0qc8sarvKy
	NYv2JsEurivQoqaAHfEmVHaXwieB82fQ7S1h7lyRTkK45xQ7kvSunBJhbh5mhqcS
	R4u4gH7+DhvThFUOuSUwR7HsCG5Cx58JsKiG3AGPcpDd3+2CHCL50PZkKvpuBsSW
	56zV2uZKI0BOQNtMOtj246H6KVeuu5CBuNc+Twlud+11KyL2joGJMeL7vJmJjcwU
	nf9M3D97/Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7xq2a0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-479d74f0d95so20061185b6e.0
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036911; cv=none;
        d=google.com; s=arc-20240605;
        b=JchLV8o2TCZuGiQ/Ur5RHTP60tmcWe9kQ8zU+8hMBgDxytF6WvvG9oRMf1SyWufRD/
         oCNkDwgJb60HKp8hR01biwzfuFs2wl/suD4HG4VB+xA4u4F/l6BZ9SPgMjfFNcSqyuI+
         wBE0lm9UQCU6HVy7Y/6thBtYCIYNuTMMG6nm6sy2pGEaWRtGAafAc1+x50sPlhmI5HA2
         AIS4vZEdaFWm46e5wSFM0LqKN/K7ZQK60bhiOEAPnxp0SKdyrID/HZr24rosxH8vn7Bg
         lrcFb3hF6Nyqvmyi5kwmu+fMdu15/CioYOvYL+Ao8srna2pEqMJn+KdrkzZ/TBjZoGh+
         eYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
        fh=VPZci2JKNlOdVoa3hJeJin87r5P27oKUjf2U1aUTdjo=;
        b=FhGXhrd0ip+ixPIRkiuBItywDLXnuN7/PGSZSGCcvBbByRZncvLKZGjmFC2i9su8y/
         fAqk2o7SIryeTnNEx4cimBZFFXEGsM7XMCQrTxlj3cp4p6empvCGTzaztXSZlRuPkSez
         E4xySr2/AazkBVAMUKBYgQrnjZnJynMypi1MTpwAmkQI++taaRdYPC7lR4jI5ZFfrc/y
         hRLSEll8E1XiFEEcChDXdQSXh28+bUtG4h7LCnI8KYmkLcf9WPDM4PZEm5mYMKbhJM2x
         ZOl9Zcve6o9VZGYgu4G1WrOYb5WdcwLqchZuBXjJo8qyWhOHOUImoAhAmy6ypwbQSI3q
         xv1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036911; x=1780641711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
        b=Izfq+fgO4K2DY1UZGNzf3C40dy2Lsuv530X4irdkuP5VFfYS0bNEQl+Wcv2d7W0FyM
         T61S4/udm0zwfFoB76HHTdlnPSY+xKMUDwETifR3JwwYn8sVsW29cWK5sLfCvBkF9G9r
         IrdR6RYo5VFwiDREm+xzD8K8WHyAtPfXC8K4iHI3NNYWpuCw0/IAMjrSY2AFlgqFjZvU
         ecY78Q76i9ERKk3yR6qEx/vpCz6OJ1R32wKh/gpatgV5+HNZvOhuMsVYdrZiiUcGascC
         EYyl56dWlj/NKKGBIDVXzUzkqlSEq1Vv4+bBXYzrxgqyMi5vqj5s6NA07juG0BRpua+4
         3zSA==
X-Forwarded-Encrypted: i=1; AFNElJ8iaRX/6dbpt85B7nGn96j5PwGHf2AmfmNgHwsjPka2hAhUGyyFCFZ3HI8BsB5voG3fWYnP+Q0mF8fx@vger.kernel.org
X-Gm-Message-State: AOJu0YweDFo8cugphwC04MlK9A30saJcSoh4Ex4IUxNwI01S1zJJKoZI
	qw58MTKF3GiybpvRFS+fAlIGebopBg5K1LnAThMJPv3o8cRlSQRl1zt/Bn3A8xYlLRbiIS6WBeg
	BVux72D1kL/OJJFk8RRNXrJb3mCIVu+pVCvrGq1YO63BWtT6OGy/FTeCI08IkYqXxyfjxaL1H85
	/ZdS85iSnafDa1/+u8TJ72hll2AoGFPlAvhdjc
X-Gm-Gg: Acq92OHylKpzq1bpr2hVihgDF/39lHJIrI3C2v1aHOf0CYaXcsMnVmfiM8uXjTglSBP
	3j8Up/ciLtuKvKHW7gbHYWCXTJAGjqK/LuMAAba+8UzpttIMQOZTIOK0afCt5muncMhIJkGCcah
	OtCIugyb5cbkIQhZotSEBxHNRMw5PIK1YuAetOHpPHvaYsbw/K/XSGqt0CA2OakPJksCzfUdRF6
	NkyYr7Au6XxoQxaX/53JW+aFMhlMpL5sL9FsZx/dAf7N5Quvf0=
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id 5614622812f47-485e6dc0223mr972297b6e.35.1780036910720;
        Thu, 28 May 2026 23:41:50 -0700 (PDT)
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id
 5614622812f47-485e6dc0223mr972266b6e.35.1780036910218; Thu, 28 May 2026
 23:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org> <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
 <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
In-Reply-To: <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:41:39 -0700
X-Gm-Features: AVHnY4JOme_X08lKUfayqc49fxg4J4ab3o3Y14UzTjVjHMNZxrhWL7QV4gYwqO4
Message-ID: <CAH3zFs3eddZUtb08oNpjEg5b2=DJtRCuEcjsxuPyRA-zB2idag@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _6jhfzoEi0g61zz0SIvEhbCJ1fCXMDkp
X-Authority-Analysis: v=2.4 cv=R7Ez39RX c=1 sm=1 tr=0 ts=6a19352f cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=i0EeH86SAAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=zzBG9ipUb6nLY-ocZWUA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: _6jhfzoEi0g61zz0SIvEhbCJ1fCXMDkp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MiBTYWx0ZWRfX9Vx0kQPqSyMG
 ya2Yu+9ix8eEAQWaMHT+64fkP7vbWZqkpkLQkOhQCx/I3pWhdoAMR3lshp1hQgwRamjFaTi4Asc
 BrmnXUyBLhVoeZV9tHHmzpdQbhphzutmYyuR/OVLIUEgxXBQbNS7fUzAD7Fd1UF9fztA7f6yadW
 Yds5/M0O3WZpxt60rbDu0lWB1dP2GVse1x7cd1vbf7xKOF5qipszVgn6mBHkVFhMBxXNE7GS7rg
 GVh6dthzto3AOzNI4bGXWAv3o+pHmxSJROT4clxWe/fj+zkw6LvVSoEFpRKYQoPWtDVKNuDEfJj
 CHylrAlpR4r5BU8LkpwSo51wvGfkNfiYjlHWoD8agYWPcZTE9BvBb1I0mTgya3zRJDcQJaOt+Wg
 /OrNWwUmfbTcHN+j4fef0DzzGsGi66S+IIIWOaSiCuHDST7+kioOdWq7mCoU6LyeBkcUlI90jMz
 vdko0PKDXPa3x+7aYgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21483-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,shazbot.org:email,meta.com:email,meta.com:dkim,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 996B05FE216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 1:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/28/2026 1:35 PM, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.o=
rg> wrote:
> >>
> >>>
> >> On Tue, 26 May 2026 07:43:53 -0700
> >> Zhiping Zhang <zhipingz@meta.com> wrote:
> >>
> >>> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> >>> requester mode without reaching into pci_dev internals.
> >>>
> >>> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides=
 a
> >>> !CONFIG_PCIE_TPH stub for callers.
> >>>
> >>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >>> ---
> >>>  drivers/pci/tph.c       | 12 ++++++++++++
> >>>  include/linux/pci-tph.h |  2 ++
> >>>  2 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> >>> index 91145e8d9d95..6c4492075ae9 100644
> >>> --- a/drivers/pci/tph.c
> >>> +++ b/drivers/pci/tph.c
> >>> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pd=
ev)
> >>>  }
> >>>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >>>
> >>> +/**
> >>> + * pcie_tph_enabled_req_type - Return the device's enabled TPH reque=
ster type
> >>> + * @pdev: PCI device to query
> >>> + *
> >>> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_=
EXT_TPH.
> >>> + */
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> >>> +{
> >>> +     return pdev->tph_req_type;
> >>> +}
> >>> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> >>> +
> >>>  /*
> >>>   * Return the size of ST table. If ST table is not in TPH Requester =
Extended
> >>>   * Capability space, return 0. Otherwise return the ST Table Size + =
1.
> >>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> >>> index be68cd17f2f8..fe572737b409 100644
> >>> --- a/include/linux/pci-tph.h
> >>> +++ b/include/linux/pci-tph.h
> >>> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >>>  #else
> >>>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >>>                                       unsigned int index, u16 tag)
> >>> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_de=
v *dev,
> >>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >>>  { return -EINVAL; }
> >>> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { r=
eturn 0; }
> >>
> >> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> It need add #include <linux/pci.h> at beginning too, else it will counter=
 compile error like this:
>
>    In file included from drivers/vdpa/mlx5/core/mr.c:8:
>    In file included from include/linux/mlx5/qp.h:36:
>    In file included from include/linux/mlx5/device.h:37:
>    In file included from include/rdma/ib_verbs.h:46:
> >> include/linux/pci-tph.h:48:10: error: use of undeclared identifier 'PC=
I_TPH_LOC_NONE'
>       48 | { return PCI_TPH_LOC_NONE; }
>          |          ^
>    1 error generated.
>

Great catch =E2=80=94 thanks for testing.  I will add
#include <linux/pci_regs.h> to pci-tph.h so the TPH macros
(PCI_TPH_REQ_*, PCI_TPH_LOC_*) are in scope wherever the header is
included.

Thanks,
Zhiping

