Return-Path: <linux-rdma+bounces-21482-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCVgM6IzGWqDsggAu9opvQ
	(envelope-from <linux-rdma+bounces-21482-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 08:35:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C95FDFD6
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 08:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A98513050F11
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 06:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FD43AA182;
	Fri, 29 May 2026 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tE2F1C3+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298603A3E88
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036493; cv=fail; b=GVFLpIWVF2MxdKTclDy7Fi/X5NR+oPEOEuYfuDGGaRweWSRSo1iOZv4pFWZeB+m4LwQslWHkfxK8eTaCo7Q2Z9TSCKI+DI6cSOqgr8QGUS0Bm0awz2Aph1M2+aJwSxeQsYG9wvR7seduIVxV3oyRvGVDQqT4Y9rIRi+w+krhlzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036493; c=relaxed/simple;
	bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBic7kaIy62AS8xr/2mLCmK/uGgUWk8MQ6T2rQsicOIPxSGL4eUKkEUKWjJrdDKEAbzBROmniwgnHmpTfpWO6SJQn0rgaDXeIIHGMBFiMy5tkC2CR7WaVHVDqR8xm3Dz+YIH/E0TzU11cBC1rfBU413wc5pJhvuaunGum/hs6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tE2F1C3+; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T0l29D2027065
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=; b=tE2F1C3+IWIc
	hD6uPAo9NgDmLx3SiAIqN6xdU/vi1BTlNSH50fpgV8+w2z56TbYNWRvwyATimLcQ
	6gBB7u+bSsBhHZxDEcSgqK3/4LhMs0I3XhEpCctNiBQjacxzZ64Ht3GAKINKXsRe
	2a4b6ZZDgp7DFIXB6NZzeM/x8uiRnSviRZdPNOFY+C+No5faqHXGRxg3ix2FcSdL
	ETSBtsgPPA9Za6p83WxjzQ6xcL+i2YajrLWFKyrDiNGr07q5cwUoyo4ikTdnEkY3
	yiwI4qfRPsWTAFXgnVqxw2XBZSbFpE5+g2k/neK+34pAldo7nom/u4tzd6ac5WIM
	FzG4O2F7ag==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1j3yt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e4de59797fso22424092a34.3
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 23:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036490; cv=none;
        d=google.com; s=arc-20240605;
        b=YqdPlTJKAwUBE3ReX5vhinA9mg4m2bJ10oPdxnGw3Z92ZYa5/0Gz+P2l4bsQB93aKg
         zZ1pvWZoxfjAJo+OFOjM3ysUyTNVp0SWWMp5BnGzd0b+QDAecpqERCfeD9tEMccyg9uy
         NrDrVeLRNzLaE+bWtN9uvG+gO9RU2qiGOEIqcjbNbVVu8F3XLSkYbkDu+2crNWg9N/zv
         ND3BUJnlbRiW8iHE158/3O2rm35hx02XRz05N6xnuPJXGRbwwYydPXa6uQH/dWXR5akn
         CwpzVVjbqRz7Ueb5knkI9LPBvK/JV07+VHnOxQuqfxsfd5Cjb6HCM0yDf4xgS2nv5G+g
         R+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        fh=4z7mmjAfHVY9vmJYwZSLAsqtuGZGuTGLXFHgIR1FHgw=;
        b=W33buKuzEZcIKyTjumFaI5Vr3BJyHddAYBqwKm8DMypSJmfXU1AI+YqbkgU3rVv85L
         JZegI7qgEcE8vhFz4H0WMcjd+ne+LRfQ5VScR8UeZOUTp1ie7Jd4dCVXe4Pz+kV822ae
         d1Xk4HhnoryyhAv0tZvf8h1/xHupbZDyboctAYZDJKYdxK/70eiVlfrMU4TmrBRxvo8w
         9Vj8ba3fY36e6wh/mBIPFbSmAFRPmULsQHwW1zlK0v6nIRCV4jZmslSziRDFm3RCwcYV
         lLqJ8DtPy0pZpkNVIElT5O2nhd/CSGVFuaYpQzX8kV5kaMgzvO3adqf70CsaX7GrMaFX
         irZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036490; x=1780641290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        b=glWZcFKNN08uLPOW9BB/gUZeq2b+FVV5naPCnIDop6NIS5wVxqzc94gy14oUmNJHWW
         n061LyjXa/X3/bPfpUfVXsd5fNXZtPQIM++t5jgKE68rOwB6yCCzFHHg6b6XMIIyEfXP
         1s0GjGcgi6nRA05hTsTJJYZIqZmLjK+I1q/j3L8KfvaP9puoUiWOGVmWB74BNUzfSMOp
         I1qMlDMtMF2xIVlBtYzfGRnEo/c1R8uZGeNe55TkmAL9SWSWpoUJZEB0Xtqbm38G/JCQ
         KqrPoUSdjZOVPWxxv0+Wgfn5HAVhfvdnVNMfnWM+vVCfu23s1P7dVCrY81TG/fxJcqfx
         Jl3A==
X-Forwarded-Encrypted: i=1; AFNElJ8AjdUU11aGhAR/Qteb+HTJXtcXEg10z1pdXzgZu+JBcsZ8/41TYkr/mvlI40zyUzfL2oErm3s+2HsN@vger.kernel.org
X-Gm-Message-State: AOJu0YxYAUV+aBkQUXu1v9qLg1hpRsNER6IqTBZRd0Hc4Y+VvoqfXVia
	6Jz5cOmJLnaD3JBwd6XIUN7gbQU1cXWQ71y6ryhqKBaK9cGyKR7rQmSpfUnXKehlOkkkAE94Ovx
	Kaz/0PtpS+NEFLLppyKG/dozVH8vdPX0nKQg9VnV/Q9Vcq/SKcESv015JZtuCDEI5mEaUts7sFU
	RH1/RRQad2wV4R3d7tAA+JMKYNqa3kuAcMS0WC6P8Bybdwquw=
X-Gm-Gg: Acq92OEPc3KwT3xoyYM9wED8l99SWLrzwBalE7aYHTjugURvZAdwRMHvvyB0lmORHOe
	WfkshJF7WGoP8yT2Im2WAyVCccWoV+iGdNOBNul2+iy4OPQIyhzd6b19VlFTyYOj7eD5SIcck4B
	568Z+XK16McaKlV64YxPLXQ2e8H/08sPe87MgHBt5L869ZpHXh0geFu9GqxiPAQ56RDsxdW8cwn
	miLLak8JnUxDN1IcYExwbSqyM7CmnABBr1m5aezgg/qrFgvrzw=
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7e694dc2b7cmr1101948a34.17.1780036490385;
        Thu, 28 May 2026 23:34:50 -0700 (PDT)
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7e694dc2b7cmr1101924a34.17.1780036489896; Thu, 28 May 2026
 23:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com> <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
In-Reply-To: <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:34:39 -0700
X-Gm-Features: AVHnY4LezOs9bV0UClJoUOHcNCdwbl4qfviQEKqNUnQx0j2Atcq5JV3HHpZqmfs
Message-ID: <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: H9tSPD6-mE0KU8mRSrv0VdDLwDpimF_s
X-Authority-Analysis: v=2.4 cv=Yu8/gYYX c=1 sm=1 tr=0 ts=6a19338b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=zd2uoN0lAAAA:8 a=f7uq7ceqOUF8L-MFIRoA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MSBTYWx0ZWRfX7FvD68RTRc5y
 0TmI5Vj5E1FEumRFWG4JXTHWv7LqbfkFKhS8GuB5T7mIWIlckF54g/H9c0lqH4VTfF1otWxkP4c
 EQ/e8pmJ7eVOveCbdmimLd/kPadip/EObvTnboz4WNJ6JobMG2RDTHHO5xAE0XKpGnR0p1N8cIL
 c9EPHA6G2JWzRJ5JnR3zXxofBhwbu7j6iupWGodQeMvkMuV4D8lZyiBvKQtheT75IlyA3k1gR/r
 b0zYRDg+Jn0pX1v+jpQms5lOrO0NMlAvk+iZwMHGtWHVGewJRKOHCqb64TE2oGm9TeoS+00Mjle
 RwfwMvtGUTaPuaQs15IqNNw6+smlQLdx0KKw6wzkWG5P7zkYE3qXrG4Csa0ly+8bXLjSVr2L3US
 pNMZbdc8d5X+AvYnhfzs/WgsKkKMXirQiGb9oGoEIThl72Hm0bH68iSZ1SmRf7eh049fGA0cyre
 9esZNELC1405LgnEcpQ==
X-Proofpoint-ORIG-GUID: H9tSPD6-mE0KU8mRSrv0VdDLwDpimF_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21482-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:dkim]
X-Rspamd-Queue-Id: 6B3C95FDFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/28/26 06:55, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >>>
> >> On 5/27/26 14:36, Jason Gunthorpe wrote:
> >>> On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >>>
> >>>> Yeah that's a good point, I should probably rephrase the question.
> >>>>
> >>>> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>>>
> >>>> But my question is how is that useful to a PCIe endpoint? What is th=
e effect of the ST here?
> >>>
> >>> TBH I've never heard Meta explain what their device is doing with
> >>> it. At least it seems to be super important to their device..
> >>
> >> Yeah I think at least a brief description of what is going on here wou=
ld be necessary for the review.
> >>
> >> Otherwise we have only the info that the exporter wants to give an opa=
que ST for the importer to use and no technical description what that is go=
od for, how to test it etc...
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Jason
> >>
> >
> > Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover le=
tter and the
> > patch's changelog as well.
> >
> > The short version: in this series the vfio-pci device is the completer
> > of the P2P
> > writes and mlx5 is the requester. As Jason noted, ST semantics on the c=
ompleter
> > are implementation-defined, so only the driver that owns the completer =
(here,
> > vfio-pci on behalf of its userspace owner) can hand out a meaningful ST=
; the
> > importer treats it as opaque and just places it on the TLP.
>
> Yeah but that is not really sufficient to justify a driver 2 driver inter=
face.
>
> Which PF driver is backing the vfio-pci and what effect does sending TLPs=
 with ST to it compared to TLPs without an ST?
>
> Regards,
> Christian.
>


There's no in-tree vendor PF driver =E2=80=94 the device is a Meta MTIA
accelerator managed entirely from userspace via VFIO passthrough.
That's why the ST has to flow through a uAPI: userspace owns the
device and its ST table, so it's the only entity that can publish a
meaningful value for a given dma-buf.

On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
an in-band instruction for the incoming P2P TLP =E2=80=94 selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework =E2=80=94 only the producer (userspace owner of the VFIO device) =
and
the consumer (endpoint block) need to interpret the value.

will include these words into v6's cover letter.

Thanks,
Zhiping

