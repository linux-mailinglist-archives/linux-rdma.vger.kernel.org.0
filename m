Return-Path: <linux-rdma+bounces-17618-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI4cOlcsq2n6aQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17618-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 20:34:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE7227152
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 20:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C60430804E6
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85536D4F9;
	Fri,  6 Mar 2026 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lAQtG2f1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033936D4FA
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825641; cv=none; b=XJRMi8O2DRFwJ5gSY1esZZa+fFyi0qxAItWbLr10FPJLXrlPj+Fti4zqSnllkPSPzOij1gnY8Bc7g3/YZhqs9tg7S4sllQJV6r1HJx1EHln2Zh7oEnPOKHYhMlE2OawTbRmXnR5ucfhgCwP0d4625QUxwgm9wIKMuUUmek0sk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825641; c=relaxed/simple;
	bh=2Ri7B64hX2crhvJ+3cRKRgEfLRGSSXKNETH8TmvfS+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1pgZ7PGFFAWRyDzgHblms0cUgJcbd1oxZfh7vbQD3AyJqlljIlnfw3I6JxJVB3u1x13YKSspIlaBFyBHsK4covSbKW7Qd3NTVeSJspsWE/Lf3EPGgqIuK7iSjvQ2TD5N8KIdczvzSDUmHXkJ2MELW57xep+gsGlCDvnQsxkfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lAQtG2f1; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626IwWUu1880896
	for <linux-rdma@vger.kernel.org>; Fri, 6 Mar 2026 11:33:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Fsto2bYwR+ti6PcdpnLAZ8WgpkSbDqRu1vLh7+qCvp0=; b=lAQtG2f1cYKB
	CMenZmgF1mN6BzQuvQNceqCAksQNcRbOIMYgHvJBnXCyNz/9BFVibDWgt9YqTeI4
	Rzvf15wDDn4BYjb+DwZR3LRZ3WSSgGAmsU92JQ93NEPDKcombFHYkrlPbkghDKLY
	s/MAxLfwuew2hMjapyMhU/j7my/sxMoVXIvnIw+AuGI6UqV+LPyjH1q49fNvhatr
	museB50kmxTJg8NoSg8y/xl5ZncT4grWff7iyznukaV+WzD9n7ohx00Xror+Ddva
	G6NakstPGPlhQhdqEGvPK0vUWPYPFAHWjzDT6l+XkLDHbZG6RblSS9kCNqfeYZnM
	9MkqIvK6uA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cqrh7fyuk-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 11:33:59 -0800 (PST)
Received: from twshared10186.03.snb1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 6 Mar 2026 19:33:55 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id AEFC812CCCB13; Fri,  6 Mar 2026 11:27:53 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Yochai Cohen
	<yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Zhiping Zhang
	<zhipingz@meta.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 1/2] Vfio: add callback to get tph info for dmabuf
Date: Fri, 6 Mar 2026 11:27:49 -0800
Message-ID: <20260306192753.3245649-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aaDrp7teQoutU79s@kbusch-mbp>
References: <aaDrp7teQoutU79s@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8kF4Kn6FqTx2eTQFpsWRMrkmxvygIsEt
X-Authority-Analysis: v=2.4 cv=LOlrgZW9 c=1 sm=1 tr=0 ts=69ab2c27 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=l2nmrgH_Uvo59uWC4d4A:9
X-Proofpoint-GUID: 8kF4Kn6FqTx2eTQFpsWRMrkmxvygIsEt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE4NSBTYWx0ZWRfXxUY8P8nD6GEZ
 /Vf5tdyEP6h9yVYytp998E7JEiC5dumUBWjZXulADN9xgycsya1NZLt0SzvSUM7asKzBoUkdj4+
 LOCQTv8/OwEfYuHDSbJi5n0if9r8g55qLaBsLzs+43Y40B61fCt2EUJpLuvkxj19OhPRlrdp2Yv
 kIi8F3KyB5wS4tiqR/0fobWcVeEY8Xy9kI+T37w9TTLW0xWlj7FOMvIYB9kmV1UAMDRRsaGq2/O
 5xB6o0H+QxoVlzGd8z2uRRZboHWwJ0oKxUQcBi4rYZ5oifPIEWbSEA6GyJf1e8gm2kmSFSEkKTk
 WXKBeHhn/h0yzWRq74iiSRGtI2Tg752F4jsNRbMtnL+hzA1JfWZRhhy87oZcDRdh+BtwvbogIJN
 JAYW+p142BXvnxaRA8EwUhZfSEaIWHznIqdIj2z4TSWeSKG/fzOTgBaIBXZPZtBVWVXwI3dmdnT
 huGYIKpJ0YWvuP0udIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Rspamd-Queue-Id: 6EFE7227152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17618-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:dkim,meta.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 17:56:07 -0700, Keith Busch wrote:

> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index ac2329f24141..bff2f5f7e38d 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1501,6 +1501,8 @@ struct vfio_region_dma_range {
> > struct vfio_device_feature_dma_buf {
> >		__u32	region_index;
> >		__u32	open_flags;
> > +		__u16   steering_tag;
> > +		__u8    ph;
> >		__u32   flags;
> >		__u32   nr_ranges;
> >		struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>
> I don't think you can add fields to a uapi struct like this since it
> breaks comptibility. Instead, I think you may be able to carve it out o=
f
> the "flags" field since it's currently reserved to be 0, so I guess it'=
s
> potentially available to define a new feature.

Sure, thanks for the suggestion, yes I can also use the 'flags' field
for this.

Zhiping



