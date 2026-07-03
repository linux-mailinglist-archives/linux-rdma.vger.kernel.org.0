Return-Path: <linux-rdma+bounces-22738-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3o9PBT1eR2qSXAAAu9opvQ
	(envelope-from <linux-rdma+bounces-22738-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 09:01:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E96FF527
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 09:01:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=C0z5ENmq;
	dmarc=pass (policy=reject) header.from=meta.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22738-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22738-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B661C307C80E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 06:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E89385D63;
	Fri,  3 Jul 2026 06:57:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7653876C4
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2026 06:57:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061847; cv=pass; b=WZISJIsybSj4nlVwDyWbTU5j+ejIcSgjO8fnHYxjAdayuFsLAxGu2rd0n19qf+IG+YS8iExX2OSx8vzNDJjGm1Z2cLD4qi53/95LcJVF+Qnn6/nRHV8eP4qCZ7EXgb3QI66XYFLWPpL/USQ/68ou4knaVJk2S9Pn3Do0elFVzGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061847; c=relaxed/simple;
	bh=dSdsH9dksi+uHV/fTw6nPqI8igLABzvcuyiyNSlvbvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvkoqIKa0cGhFU2HZFPlssauwdXSyEvYVpH4aFglg5ySnxusZfk5WbjSslAW73kF//tlvzXoMo8HuQ3cGszBLaES/chD04mlHN/U4Mev8Sk/Qwg5oRwfPuNybhgDMayUIXA7bzEFVhjMkv7BbIG3adq4LPlCV0Ag8KzchXfUscE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C0z5ENmq; arc=pass smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6635sLiE1004176
	for <linux-rdma@vger.kernel.org>; Thu, 2 Jul 2026 23:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=1ooYXEhr8R5Avu36PkA1
	fDBaUkP8RkT4tBNox1TcVoA=; b=C0z5ENmqDzbJ1NLEJsUJo9CQ3N/uTO7VUwp4
	kfTj0sxCwlKtZcFAbfH5EzA4i/QyE7hzmnXKp60uoJGQ6MOgjGVYxymZs1LzEGgR
	KK/MabO62rFu7yFaRhdUXbWVs6RszHi4Llfrvj+O2Ur3DURJFa0bbiYbtGGtmf1S
	48+CP9y9ZSyGN4WLNaqbVQgnwIsdkrlxGhdYdoaiAHm7xF2MwkQzJeva9fd6d3Yw
	oQ3EMU2riwO6WaSrWDjGw+BApAFcAp1tWa/vlThjMXh9zmTVaUOIm+H2kTLvSMGL
	86M/qI56en4xsmMLOVp5WIYEay69OIWSI0Mz0mScKxmp2zYwIw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by m0089730.ppops.net (PPS) with ESMTPS id 4f65usrn2f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 23:57:24 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9e54e9cf5so349423a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 23:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783061843; cv=none;
        d=google.com; s=arc-20260327;
        b=bVzQH4HuZlBzy8XCKP7MNAAbCGbWGYrcyXU1HdHzWAkuuLd26Lc7O47bvD5EetzIIW
         6Rr8Qy55Dqpi5A4YRW1GlqfZl1idkZ8XjwOZrwQRC3aU1iyOSMRVCbJsKm3h9W2PYjE5
         Zu427bPD4E6vdmtrMk5d0OCTHRYLnRKu3TkJuuv3dGlexJCS27xQE4szd8LObV9pfrjX
         d6gC5eHDRgUtpfIM1FI+FCBMEoRPz3dZ/viKJGoF7FeohIoTsJTvuIRrunbv4dIRlPdk
         vjIAyn/iXaZx4zl9jmMyW1pRn0G/dOe9Vd+zjBf6sAlq2mYtSnCn3Al5k0d/snv1mRO2
         L4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
        fh=isIJn1s1tluB7VvgQYFOxJdXPYuwf9hly5YqwWwNUfM=;
        b=pj03IeGVX+Lfhlj/w0pr9+bJhaz+T+36N6Bj87viRX3r0qfdYD/B/A7caZSomyQ4+1
         IZFpBJMCxglBcY45J0DxvrTxjmtYCcdJRk2y4GdD/AR3TNdxBbKIpaGr4/7ajtuOWw0z
         LcxOaH77ct1Umpp4MqBHP6bme5yt2EdxoL/vbq56IC6bkuimHz5OWDLr1G7Q5UoSAovN
         1f/kbImT1+usbBdfKRiW2QZHYUjAUDpBxzw7FWAilyQX0672KuGNuLqbWpdJ7XrWcll5
         BDQS28cnJu2xXvEfNjdq121198ZXQnbZUsAsptP6OV7iubLBNTON42AF2jGrprakiepB
         d3lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061843; x=1783666643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
        b=fGXsx/Baajyz1wTw9SmBNES+RkeTxd57BX+VqaZEDWAuj6qs5Is2oNyVYsp2oFV5Jx
         XKBylkGRHARabGY7926QphE1n001sq4oOURgrvgI7XQ00Eg6VyEYWGpFvqwSBcD9O5nC
         j1JHVbNdLCiYb12E8DeuIITE1k/yYd7rrlXVOoRq2ta6BnGbO3Kk0LR1HZY6Xpfs9eR2
         M9V5FeT0w4CXguWQdN0MMDLjUCk6Hx39bNJgb5PtCIv+DxG3Yl+LF1vqW24iVzokzXuu
         GwRAobDbYDjMproOevxgk9wINA/7dxFeMCJ3imOpfWIh3BA3sEIXg1h/0+4TUbCtEb5N
         vEPg==
X-Forwarded-Encrypted: i=1; AFNElJ88lpnKlxnIt5HXsX7sSZfvb96DjbZmtaGAHDeLw2T04wrUlPtO7/ZnBpsM62vYh6cPJarWALEPnvix@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb23Nx8nJ4UrqAa4Vl8dvGkplKHXIQyH5oBZY6Fk7bByTJZhI/
	uy7xvHU1cfKz5lu1LKFlqp7jJ2cB+tKcWJ1Gq3IN6WF0VXSyckwbaPERJz0630rJb4CshoeD41Z
	cLG6Yquhil+PhpCa5HOyBihmzc1mJnHUsnZe7ud6aLQH/4cQ0GONhyfAyu17HRb+MtRrDFf76uH
	jf4UpCmBTOml0MH520EVITPOGgfXhJVJbRNXfm
X-Gm-Gg: AfdE7cl5hnqO67aPK/FQcZZCBDx/4pgapmO100FbCiSuqzkLGwJw8XYKgl1hMxY47nA
	b97obTjCEjpqzNY73jn16iLF/cRr3wMh0X5Xwnmu+YBPIF4Z6d3N9xP25aXNRJOAj7T11Hnqz4y
	kf/L89wSiIQFdgHVpbXJ3IEUKycyO8r7mGAppgBWhMBHyzhOHfN0DnoBquwhn+Dr3+XviDXdoep
	v7D1b9UXXqe99BcVCnbBEJqRCuFDg==
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7eb4cc26248mr5970982a34.17.1783061843328;
        Thu, 02 Jul 2026 23:57:23 -0700 (PDT)
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7eb4cc26248mr5970963a34.17.1783061842839; Thu, 02 Jul 2026
 23:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com> <20260702181025.2694961-4-zhipingz@meta.com>
 <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
In-Reply-To: <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 2 Jul 2026 23:57:10 -0700
X-Gm-Features: AVVi8Ccw8yAXcsgDvWHGsVO2xij76p-6UW92x4FC6KeN1aOXDWOhO-jLzIpoK30
Message-ID: <CAH3zFs31yd9uyo3waOT=SxCGaKGBfxdAv2XDQ+9dQyuo-cCV3g@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX6DoyuGQMsAZF
 +PBGBLBC5Dp/QWg/I9ymuRk6kRVC8t9c8IlcMA8jPDDxi3SPs0mgncPC2c82JTzFNx9A51nz8vz
 i8c9QjpU75Zi8y22Dv4IU56tlMoYCkTXcI36HZ8X6egqCwvQHYQoyrosF+dqY/kKat/ptWmZj33
 aSmpkkZx3Ic0e1esIc0SMlOTH/vt3IEZHzq/ZNWj6n/4EdlkIjvw5BGf4K2y1J97bjdzvrv4vhl
 A64CAaoTu/ifzzJpN65DB8N8jcDqtt6XjuAAlAFS63MPgbAPJ97gzhvPXIAJbRKcbgnUYt6+P1f
 a0zZZ1RNg1vEBv0obLZASeIjb5yPmDfsL+MFm6Sc+qnuZac8WB784l2ytiTU37n1XfGkUsmBlum
 ac1TOaIBY05qxDsUmu6jQsykEjLHw5K4YSQGRZuBt8r2ppHUmSzGFyTU8tlpLJZamXg0VFE7uTS
 rnhUAhhPpHQ3KE8D3lA==
X-Proofpoint-ORIG-GUID: OTbdAfB3OxLL2DJXOfG9vEplUmK_myyD
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a475d54 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=wlcL9-RM8ybxaKpgEcQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX5mbl4rYUonHW
 YdzZIyXbvZzK9/r33sukm7VME7JgSKSgtbqutO1VlHCBVkvB+K6ZMb3yHXGZG22CiktH2py2fzG
 /zCdjxJzxD2TXOqF8/uTfqqjXApRC58=
X-Proofpoint-GUID: OTbdAfB3OxLL2DJXOfG9vEplUmK_myyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fengchengwen@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22738-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B4E96FF527

...
> > The attach path reads @revoked without holding memory_lock. Annotate it
> > with READ_ONCE() to document this intentional lockless access: the read
> > is a benign early-out, and a racing revocation is re-checked under
> > dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
>
> I believe this modification (@revoked) might be related to resetting the
> bit field segment and subsequently identifying a concurrency issue. It is
> recommended to submit this as an independent commit.
>

Thanks, I think the @revoked part is still closely related here. The lockless
attach-path read existed before this patch; this only annotates it
with READ_ONCE().
The bitfield-to-bool change is needed because READ_ONCE() cannot be used on a
bitfield. The real check remains the dmabuf->resv recheck in
vfio_pci_dma_buf_map(),
so I'd prefer to keep it in this patch.

...
> > +
> > +     /*
> > +      * Updates protected by dmabuf->resv, @revoked additionally
> > +      * protected by memory_lock.
> > +      */
> > +     u16 tph_st_ext;
> > +     u8 tph_st;
>
> how about: u16 tph_xst;
>            u16 tph_st;
>

I'd prefer to keep tph_st/tph_st_ext if that works for you. They map directly to
ST and Extended ST, and non-Extended ST is 8-bit, so u8 tph_st reflects the
actual width.

> > +     bool revoked;
>
> why not move revoked before or after tph fields if it don't take one bit field?
>

I kept @revoked there because the comment documents the locking for these
dma-buf state fields: TPH under dmabuf->resv, and @revoked under dmabuf->resv
plus memory_lock.

> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
>
> how about: u8 tph_xst_valid
>

I'd prefer tph_st_ext_valid since it matches VFIO_DMA_BUF_TPH_ST_EXT and the
"Extended ST" wording used in the documentation.

> > +     u8 tph_ph:2;
> >  };
>
> ...
>
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u16   steering_tag_ext;
> > +     __u8    steering_tag;
>
> how about:
>         __u16 xst;
>         __u8 st;
> and it corresponding to VFIO_DMA_BUF_TPH_ST/ST_EXT
>
> Thanks
>

If that's OK, I'd prefer steering_tag/steering_tag_ext in the uAPI. They
match the PCIe "Steering Tag" term and seem clearer for userspace than
st/xst.

Thanks a lot!
Zhiping

