Return-Path: <linux-rdma+bounces-20649-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNrUAj5jBWqOVwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20649-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:53:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 654EB53E1DE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 583383025D19
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BBE383985;
	Thu, 14 May 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fsyf2ung"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B92C0274
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737972; cv=pass; b=LtK9Ft4Yw0ZEpJZNGwwcjUb/7Ml4xXsKxVRgV9uYHR8Dx87vbf3/shgMxc7IBC4Rcal3/Sn0Ir3zgF9ilt2yYXxttHmiqof0G4DnFpOnsWPL4mxqIUl2XVfqcSHWS7CShBelKgsvu35n1dY5RLbypui9BgJFaFQ0/k7ylw/O0CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737972; c=relaxed/simple;
	bh=jNKZ4zNOiJapN2UCQkJ7YsxiCTXnQMvJQjELnoY502w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjFfnEDxt7FJN2opYJ91JIe7cCeS0mOCtE9OwB3TxsFI5OJj9vgqCRmyJetOMlaWqQFsygq0iCABedXDtsI4CKzcNrjAYz5i7Deu9tAdc9OUjwwPJCDGh1+7I/2djgNHQNK9mx5wU0iDmNLFIx4DzOOoaYH8ch4f+dwm9hLoByQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fsyf2ung; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64DLjbJM953822
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=; b=fsyf2ungMeq6
	yshHRzeQ4U6BrRrLOw2m5LnpTLwWNRFjtrke7zVSXSFihlkGIGQqF9ZGo3jGgRXv
	2rFeRHThXTMGtORk281jxrE4gu3k+yTDpZgaO0RXgdCq1N5vftBndt64eqJWuKnS
	+qFgwbyeb4nBJPMKSoH2gapTvLOVcXTpgpJbzNuSuxsG6wL6MDQuJFxJqBTW1JNi
	IVV9KnN8WwJIC23O9zBqlSvbZlQqGkv8pX6J8DxJKQRvwoU15pvU+KJVRC+Shz/1
	pdRz08JIRHpjjYq3PaY5+SYfamSp6mY3XF0mgHmyOf5/MBFj0ETZ9P3+2Z1Vr68E
	ax4mD3GJvw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by m0089730.ppops.net (PPS) with ESMTPS id 4e3nw7nemx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dce1e67fccso9865481a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778737970; cv=none;
        d=google.com; s=arc-20240605;
        b=JZdeppYUSMybKoFiPH7TyXkcuBgER7GyWGjX6jF+VoYp7j/7WaFGWLu4QqNn7XOi3g
         UZyE2pXlq8dyrrrb5xL6si0jc4aJ7NBg29xp+8E5xqf+0/KC9Id8fX8JemM5UQE9ubPN
         jesxt32QrWu0sEspTwLQx7Vgw/MKvoVFf+DmSBI/hOiquUrrrglp5s5AYQU3WwBRn5yo
         tz5LQs+Iu+m0PxLMdXOUFNmlxVAh6yMaMXl4GmvR7uURfIXmH++1U5YvQROFKLbJm6Fb
         JIzll3PEOLA3tZka7qycsxP5aKDQfMW0ejtrwKOo8tUag4xSXGeV3Vgwsyap1OXjdyZ5
         Ji0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        fh=fn59FnxENVTyS91ddNs6FIXwOfz0IjzTYzAeulUS5jE=;
        b=O7sNqQHTaRx9dHsZLToBrz0C9ItF3uXHFxXAWREQNbIoREMTn9tpazsnJvFMY04DPA
         d5rheMXZ/moeen/eMVMhJ+0WKYIeyzfmIPWTVHObelTYRAYnErSHPUXx0d/9L6qN+YL8
         E33wCCfE/bdmC4fiRNpd9nF9kRgwW05MLFKnRLSB97hI2jG9qxqxIOkce2DrkZib9K22
         ubP8+EeBVugGxzEElyycjfZ+0Kw2rnREJHfntp+ngAaAWjcTfByaej0ZPiieu/O149JF
         eP8NeeOMJuWNrnh+wkqUCwt44BJyRL8hZy1w6I6K6W/LZcuH07jTxnaLFa5yqn9AOMrj
         8weg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778737970; x=1779342770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        b=MgqSbCfK7z07xnK1ACKZ6Erw760PQ+M4hOs8cIuulEWnll0eXKj58eMttmflj9AQno
         jwbbx1gSEgfpoRyDLcInJkUkWkyFCqIQx7D1U57qrv+/LNT++0yB1KdkUXhSrgljtBl1
         7VbJL4Vx1hBkeX4j42XoD+LB2M2/RLRe0DnWzGaMhaUUw7TiKlKGsnU4fGAX8YOCDsG+
         QIT48WYXalE7c+TMdDrnLTqSw7cOo0oUdgk5C1VHIINy1Plyl4ZnC46n8q+bYQ0rIV6W
         LIsoPDg9m2XiJIi+SoNlZRizXFUoY9HF7bo/oR87q8Z7UqT5J00pvqvu7WZaR1n17gYB
         S/rA==
X-Forwarded-Encrypted: i=1; AFNElJ9YWIQSZDmn8oM1530HDEfPbpTi4SDhspvTa0osOMiwgE3UAs0jr20bm3uggsuCXckK2JK0l5VWhrHW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95x5rAzoAL8LPPJow9c23PkWBHo1qn4Eh11KhAoKMFdjk+9FK
	cwSAPjprqPYsZuiZxVEV/fyj46BSB1GhKfr5ilPebcc5/ss1Zzb9IdXQcPQZfHgYRBDOWC4pFGt
	EPCfh+fL3hIXpB+e2ZId3kfSlyjMQFY9MibDIpi7uGh3oQR7P7rAO4vCgbGRW+3/u5Ld5v2SkES
	Cs1EPbrdtkB+wQzB0UxoWsSCDFVoGcIucXdg5go05ziIBU8es=
X-Gm-Gg: Acq92OEBZ6ckkWp1yBycXpyzWBlGEIjcQaVl6nSFKGKJKeoHgORwM/oO7ONKOebmPCA
	hU/XgfD72hfby3YDk8okQqJo+JvoDGKiBGcr1KjcFd/TV6P1QLEiJBi/qxfuIL51XaZVUZrRHrA
	23YZQqu+Du1Y3DK5oYJqalnozu6dLQzp+xldvmexy9cGT6wNOfgpQtL0of+rXRYJoAuvcuuf7ix
	nxHE7xGyOCp6u6tZ5IyDrXRRkmrT0r4UW3sDW3bb5mZItqt1sk=
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id 46e09a7af769-7e3da47a167mr4289730a34.18.1778737969718;
        Wed, 13 May 2026 22:52:49 -0700 (PDT)
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e3da47a167mr4289722a34.18.1778737969331; Wed, 13 May 2026
 22:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com> <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
 <20260513063141.GC15586@unreal>
In-Reply-To: <20260513063141.GC15586@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 13 May 2026 22:52:38 -0700
X-Gm-Features: AVHnY4L9mpkzt-pRZEvg5JzN0p2zqJY8w2-rDz2pv9D7N-e0Agw9sPJQbQsXATM
Message-ID: <CAH3zFs2XyXxzVwru2gYZn-9ioyvy44HMmfppf7shTn8Qop-4iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Leon Romanovsky <leon@kernel.org>
Cc: fengchengwen <fengchengwen@huawei.com>, Alex Williamson <alex@shazbot.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Iqwutr/g c=1 sm=1 tr=0 ts=6a056332 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=hJXI5Qx6rLfdTxNNxg4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: -GvKq0qbeHODsJJVyobySoAaSy9VP_d6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1NiBTYWx0ZWRfX+Ee6nud5dSeF
 Bs5y3BJBOc+jvQdveZLI5jBRic1DOpQyu0r75uzm8PX6AOOPypqiHSyeW0xTwOTMUdgwWaOps5U
 PdwmITNTMinfF9mGO6KDbCnXQA8dikXkUCmwkT+lKfVvutmjuDAcA3uJBwCLw9zdqZXIKw4JW6Q
 TR6soxkj4/eUj5LDTqSafQAv8DKYekSuCYOojuoHGE2jS4fAvyK1LfEP3Dm9JtW3KLX2eXWlAU5
 iYsVHwgdvcvlA6oP7Ka1lTNR/yk4FO+FU5F+ddBXfkYBUufbJpV5WYnsxvoiSKgnhkLfR6BFHTt
 xUxVTc0w7mqevOlrBq8Ktd3h8m1nUPqBR9Im0hXKypW3LJun57cnrrNP23g3FwD1LsVb0ghE+Ks
 bi6/6fWrkIMDyGhUesazr5Ay51rgtY5uO1UQ/C0GBZkwRhOEYqRPt7Hp5H5wCfag1KaAIt57A0V
 5kZG+0MdkJ1rDB9wXZQ==
X-Proofpoint-GUID: -GvKq0qbeHODsJJVyobySoAaSy9VP_d6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 654EB53E1DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20649-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
...
> >   #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
> >   #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
> > */
> >   struct vfio_device_feature_dma_buf_tph {
> >       __s32 dmabuf_fd;
> >       __u32 flags;
> >       __u16 steering_tag;       /* 8-bit ST */
> >       __u16 steering_tag_ext;   /* 16-bit Extended ST */
>
> I wonder whether `steering_tag` and `steering_tag_ext` can coexist
> and hold different values at the same time.
>
> BTW, please send your patches with diffstat.
>
> Thanks

Yes, firmware can report both `steering_tag` (8-bit ST) and
`steering_tag_ext` (16-bit Extended ST), they may differ. An importer
can consume only the one matching its width. I=E2=80=99ll clarify that in t=
he
next revision.

I=E2=80=99ll also make sure the next posting is sent with diffstat.

Thanks,
Zhiping

