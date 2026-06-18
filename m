Return-Path: <linux-rdma+bounces-22346-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qTlALgCMM2olDQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22346-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 08:11:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2B69DCDE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 08:11:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=hEbHoDIc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22346-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22346-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA5303049733
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB33368B2;
	Thu, 18 Jun 2026 06:10:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4062C11C6
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 06:10:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763056; cv=fail; b=j3acVB14fxIsdRJWpce/Oj3VQRHeeCD2NNThGjYC+QAHYLn8Arw2FyRpO2Yh7RPaozl50SCD2kmdY4nieZY0BeZmuqgrmj+C7XECadj25f3rPDbfxsJcpr5Kf6nKGsJ6uwsOTHl8c45kWsNCNDrA4BDpCABe3yKjg5iwX6JVwQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763056; c=relaxed/simple;
	bh=aoNXmADJPkDhnZOjZgCi5nKSSN+hSwva5gE5EhTFdSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UegROsVua6IkFq4MMnDRkTQ3AWzxwGWBuHCdcqdECuBPJ42xA/gI95D33bpRXvHa/auKC9hvvaUIH4OiOloJHRTNbDIrh04ug97CLNbpiA03c8wC5B3mpz15+2aFdZa2d9xnISZVrz1vK46lpHGJLul/gRGoAN8Scfanvh588Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hEbHoDIc; arc=fail smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I39JcY1739432
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=g5sz6xIN2DOx/R49RD/V8A7DarhSxstt7fwwKkQBLVw=; b=hEbHoDIcNNBH
	sZQV9mk7PiiboxdNzb2rNmI7KBN6NuhX/NwRqSVyxP5vjpQuiVqvYgDlAsy9Zdkh
	Tgcyc7uRW8eAc3fozG8JcWlf9hfVD+uBtdLV8+caTR1qKSIE+88Ezoo/MJ3rmGyC
	jcejquyAHng7TfyGE3Z4rqdgnkiroTqWLpuu8qmFQoHaV8tG9ZP9WEMDZVWQKBJm
	bFqMqdhR2XWBGl2F6B6sIHCBRl+9WgPa7bchX/8lF9rfzbPAYunO2eH7BQStVytC
	3EGL5UOGoab/Pt1Tfkhveb6OOhzXos1WVdxlfCazGkh3Yrd5JWZz6c9LG9zbg7pd
	DI7ZUVO+Iw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4euegcsygr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6fed63fe5so894089a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763053; cv=none;
        d=google.com; s=arc-20240605;
        b=caV4uFxh9bfjfb9UgPXK1/E7mizcVWnbfG0qHPRKxYRHrSD5MRJ0unjc21efaRXqBw
         E/hntr+ePjktEhOFzNxaHELtYH78cWZ4E7f6F7KxzBMzdP7invWekXjNdh65u5vNmAgY
         kXAwdRBF2I453HMrDXzKWuzjm5qRTQYBJ/ZmI/tdU53imbHDiIgRVDZZ954fgFVW1SWF
         Aypzlz4XXs6JS7pV9eiMW7b2HniYaAfgMNMyl/YdCwkyI7S7chWM4QbsB97PPL0N5mwg
         yxN/klNr4F/rYnpxRwMrZjidAcH8RwIowsfSjQE2hI6/xpH1xY2Ya7wtPsrFdtOVLF6R
         Y24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
        fh=uu+9K6taPtkFcXS2lZ5pfblx5XejmMiTWMZNes6dDyI=;
        b=IuK5Gfx7U7KtaALmZBsUCiix1ls0Uzn+fsNZRB27/DyteRgDIo3WPQaFFAt9SjAG47
         SmOO0XI0R260lq8lriJ1ZVSdcfgA98uVLZfx+fcOpGNTcpIH61l2A2I/HRqvMQY2GPRI
         NGr08DKtyz4dtxuXLgnA1h3On8yiQPFXo7fX6rHtdA0gjrnM+iA9OktMl1k1cB+HSjbA
         blREjkaDgiLGf/+u07lH2MoqjeRhXGbYxF51cAkr908p7UHYK8Ndm4xzploDwYdIUQfW
         xomEc9LbdNsepxpJjtVBCYqdo06YmmhGdQ9WoiXvZ27//bLFT83cMEgA96/sYwYRPlxI
         K98Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781763053; x=1782367853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
        b=G8slEcf1dC67P/IQTQ3SE2mKY8Gk0CN4Ki1I/tTvG79HV20a/DKenmgDFouDT70pOj
         SaZ7V5mJW50c1WIYF6IA9XHY4aB00wFT9xKs74NNCBZFGrNOFBSnPRp4T35W3HdN1H7Y
         r8AQFAAZFoHZDTzWMuS0Jz8m/R+aTUbk39RITdhyC8uNglhU8e05mqYKgLFsgtbDuZG0
         DwhwLZ53+t+bqWm+3oPZRzZddbkQtGyo0gb0Q+T9l3aQL7cs6/62b7aN7GpG7Rzv/Bt6
         Kou8U8OU1Yjsk24GD/9YJAAJVbANzfNR9qD0H6010Gfk6pb8eUTf50PVnWMEMKT/ENNd
         AuMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SJna/TRCDPZ0xWKMM1weg50qChmC+BNXvWvndEUHO6NqB4ZBKguJAqox8eWRN4gQto6rfBAwzPAco@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5M5PrUos8gYkWwU1CtRgyWxi+xIouOf+1pLs8qHyfxc4wbZO
	JTN+myfskl4fpAlHiCTW+8j8AI+rT51f6/vAk63bIQXxLBdZiWk0Z9j/UG1ilP0svFKsmuwhGN9
	rb5MmZWeNGx1H2r+8Y8kNM4E+ndYctLVD0sOzz7b0yjMXfcf5ymtCqkyN+nIn1UunicW40nsaW+
	1jPqu5H9TjThl6khwn2BwThQeMVAwwZ+O8LOdE
X-Gm-Gg: Acq92OEAGI/IRDGb86th2N/R1HKu0J0/nh6BOOZEyNnrY0eLQtXepvMpqH/47FJ2P6u
	MOuAyqYBMxg1vQ0oxPWnEu+D1pfGijt6/QJoLCQQmL3QXSyGR/moHga/2TZ0PJFyZNZCQHWgq9C
	SeuYzVEDPKIdUDs/WMqKZU5ghB0K2Jh3WRI4zjMTWME4fY1p8RViXj8EV+WJSMIJjqZaJEyRC9Y
	VncRpyaGyPiNOzaLnnPXlTlcjB5Dg==
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id 46e09a7af769-7e91ac6d2b6mr2060569a34.8.1781763052709;
        Wed, 17 Jun 2026 23:10:52 -0700 (PDT)
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e91ac6d2b6mr2060543a34.8.1781763051390; Wed, 17 Jun 2026
 23:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com> <20260615065912.2177918-3-zhipingz@meta.com>
 <20260617094113.GU327369@unreal>
In-Reply-To: <20260617094113.GU327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:10:40 -0700
X-Gm-Features: AVVi8CdOrBaOwYRxFRdDVRsJhHRei-ObhsXGhIoQfKNO7YbBBbYe7t0f7TbFl64
Message-ID: <CAH3zFs3wBwbmvEMp498LTdbrSt4Y5w7PNpqtcN_L_vHdqsvnxw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dma-buf: add optional get_pci_tph() callback
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX/JKTJY+VChvF
 V1h9oKAfkgrdJU77lGLdmuCMgIG1y6n8BggpQGrb6Y3t7suhwd01P3Jyq8rI07P3FddAwxbghLu
 Xs8NutE/cN/cUYi7JDxlorPCnzJC9kWZNwXoNHk7vuhKCi8ZfjRgKdtDjS39dIKB67DeFaEASO6
 4QumHphEWRNZTKprm4OmKg2FI0pBYJJEs3NiMUOGu6A/3Hf9uCvB6YswOSQyH7LIPvPqehNjSY2
 y6aF0hLA45VEV2VgBNHDy7h/I7EgRp02f+fn4wNJaClhQuS+0Cn6JpUFDKV+DT0L8RJVEhNdubU
 YEy89NsbYKI0sYZCePaEkwruEwmV3hqo4ChRPRSSWlCuobzXPEqnafTxyAq4t4ofTxuZfSoPjO7
 ZykQizTSSCb3YKk3TSr3sgOrqcCdP7c2M2/dla/o4vclCf9YDPr1yo/Stj0R1LbzXjq2y1zhcbx
 hb9Uh3vS6HvW5tYo2yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX56hKSRSrXg11
 qv26Y4MrxDgyb2idmjo0TfEMk0cBkAQZ1VytQTTh7Z0m3kvvB+EtGQq/TmvMD2uFkbtBMUIIuel
 DcSmim2lkZLn0pZ3euAR0DQp29XINeQ=
X-Authority-Analysis: v=2.4 cv=WYE8rUhX c=1 sm=1 tr=0 ts=6a338bed cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=IaYQQxp-055UKQrtbooA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: WWu80wCfUyiUdb_jZef-aqpcPozK1hHd
X-Proofpoint-GUID: WWu80wCfUyiUdb_jZef-aqpcPozK1hHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22346-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:dkim,meta.com:email,meta.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CA2B69DCDE

On Wed, Jun 17, 2026 at 2:41=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:58:59PM -0700, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_pci_tph callback and a
> > DMA-buf importer wrapper, dma_buf_get_pci_tph().
> >
> > TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
> > distinct PCIe TPH namespaces, so the importer requests the namespace it
> > can emit and the exporter returns the matching ST/PH tuple or
> > -EOPNOTSUPP.
> >
> > dma_buf_get_pci_tph() is the importer entry point. It requires
> > &dmabuf->resv to be held while the callback runs and returns
> > -EOPNOTSUPP when the exporter does not provide PCI TPH metadata.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 16 ++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> > +                     u16 *steering_tag, u8 *ph)
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_pci_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, p=
h);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..5e7b69a40f3d 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,20 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_pci_tph:
>
> There should be a blank line after the line above, along with a clear and
> concise description of what this callback does.
>
> Thanks
>
Sure, will change!

Thanks,
Zhiping

