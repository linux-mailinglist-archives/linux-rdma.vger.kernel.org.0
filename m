Return-Path: <linux-rdma+bounces-19589-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNBBJMly72kcBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19589-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 16:29:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C164745D5
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845DE3025D29
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA33D4128;
	Mon, 27 Apr 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EUDXK0UB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143793D34B9
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300153; cv=fail; b=ArsrHzajqgydjt/znBiYqY1nGUh5k0vky8zZzP0ubwg0W/UZvmEX3XMb70csfGkg3TB9ClFGW9T6WcM3PWmf81ri/Ay36gRw99BiEvWfI/hZ53ejn/m5ZsIT6ibA02LOWvj/IHNa2kDIS6CmIk4f9QP+eY7yLp3XWbmoKsquptQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300153; c=relaxed/simple;
	bh=cNz2WSzENxZIwe3ENOoH+tx49yVa0W2AI9rc1OJhwvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE7vqIEAEvrHJM6SZ8pRmeKuMUWmj9mQBy635Di2I8w9IpGIJtQMUXm9Xq41AWIs6c8dnS40haiZxr1wFiW8GdwTWbb7oPuhFyXt6M6fH5Qi1GXX1xdaj0Z4HvYqHsljQYlj8enOKheSksRHLNI58oy1eIJ3ckn8BEd/v/W23fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EUDXK0UB; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R3pkih942183
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 07:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2UYvqcb6I1B7arRH3pzlLzPrPOKAEH8Y0SQKyqL2jag=; b=EUDXK0UBjzGK
	QKaoX5rIbqufWNaKZdxeAqfPQCkyeDJd2/wFJgapOGZ67xUUMlghtDbf4D/d1LxH
	5K8gn8+RpXX2sydNaWxkc5Fg5ZbqRGAsqwVsCp1OE3OWi5+yquLz/58V0qPoBIMB
	HhedRrHQtQxwKZTwXJUSL7FPjA3ZBGAKGlymgWIYr0yRV3XBk5s5Z4C1y8nt7KML
	jPg8exqznSgbfD7YbW/T/LWbR/ipKX7cSSMzAc4VFZlAkI+faif4DC/D2wB4c7UM
	RbXB1a99Y6RAwk67EGD4OMCuU6JKBc5xh1gQ4EhZCgV4Nyiw1GPLWPY/voT8hSRh
	Zbz3O5ycQA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drubg8ms7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbc09d4e43so21013264a34.1
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300149; cv=none;
        d=google.com; s=arc-20240605;
        b=j9uZGfAvMCzaj/Vqv2DWFmCik9FOFltQ61V5uaDMbn3oEdo3Jyufub2RSebgaiB1lj
         gHV2yOax6NzS9InXrDC/j7txwdtxczXbbO2aVxvqU6SRTQuGvkz8pVIXfoNQjOnNUBEc
         uJWqnrTp/58c5tfUbP4dD3j6Z7+X5wz1zX45gKX/P8MT1bbn09bZf32zEGsJtOJDL+7m
         I+Otm6xBFLOhP05R10a+ucQqxEPPCYIdn6sYXI4Pc6jVoRKjI+HwIKHnFlnfgm21QkSh
         02WSmWqBObf3EaHafJ2qEoETp+MxR0wmPWHd9npcpwY3bcNiDEljhX3EofNjyyXwT5jz
         dpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
        fh=b8GBHVNHvNRm8VrDGLzakHOicjvW4ZCSBV/AkrHLjH8=;
        b=C3M/p1S67J/3C6EjcnCHgITwwCeqAPz9yj9Kd6OVXrEwPgVDFNXatTGD7QC4B8IXds
         2DSkATCEY+TskfAQ4qdXYOOLEG07PIIv4/HCPbSTP1tXuXVQIA2RdDxloeSSOvHV/pcv
         FYbnPkY3ly4njQ4vWXrYxDTiuzYvptuquiafzVCe5qtxFc1KSI+N62Gal12PjQwaB0kx
         hqYCtCbFe0ggP4I0BLCYR6Rwn+52LGQ7lod7eRPR3zyHFrDK78WHoRx4l2DkDa+SaGxY
         jlnqFgiVmp9hAfbXdpEtS4KTtSoszYfTklD1NPFOLJyEieZtzLhiULkpbDagQUIa0RAN
         w6bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300149; x=1777904949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
        b=pgszsrKuBZbg838bTzELIRYbg80bHhl4PSOe7CbA7Ar+MvrRcmiQL7TYugQAmGQuQ2
         BPTHgahsRGOcu0aKPI2//teapKZS98NSBLY8VT1KVNTNiUTSiBBemYLPFYbtGm2nggq3
         hW3TXfWmZNsx/RkRNvHeaPixodAoKT1Qr1c+LlPPgYPAEtDnhO7VcVxHAqE34W1vUFRJ
         lnVHA5291w2zU5Yi/OOOu8GDd57WVllW5lPyvYlAqX6VitKIEnwbyXcbtKRPsV58abAH
         z7Lv6aAu1y4szcw6KTFG2SlctsjoFXmX9lM91IqXaFPluovXk5ChEhWdPlyeo51V8k2w
         g0/Q==
X-Forwarded-Encrypted: i=1; AFNElJ83EEDhHhY6fiWYSyCHHSXBWVlfWjyTF9DToAN6LARawMLR6eS1Exaen6nIAL3rrxV8ca2daAKwQFJH@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvyP7ZhTnxvnF7Vh5zlWf9YfSYspRaMhk6w56gV1qGdy8LejD
	a0XuJIuOP+IScH/U9vRInKtguDKS1xnAUgIGsJsPouGovofRnp3t2K/0C5taYxQ2Diyx8PCzX+v
	MXXiO7BGOclZg4D9zyWFUuTtMeNyrVlr8qI1eFcBSMCgVPi3x+so8IL65WZa0FG5BleUiV1dXla
	j5eWudXfpu3ZCFcE6FUgno8SkDUrh+E23UUS23
X-Gm-Gg: AeBDieuMqV11s+dDV5x0kdsp4YP062LvqfhLw/ISwMLa8AuoHzNZgqjLNpmk59aSCCu
	UvJdQDIvnp950En1YCu52EJZBSVIOqB6TkhHG7H+LAIpRqg5Md8ybZLrWgc+Od1QQDG8PVbMtIf
	JPiVz1wNLwG/xNKTHbGm31YjQK4+0IjtQB1PVTyMo/cXfZN8oSOzpksxFPlEokvewsafNKe5nQt
	JrYzKEgH4gStca4kdozOKHOoY0TqQ==
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id 46e09a7af769-7dc95525104mr20499570a34.6.1777300149214;
        Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7dc95525104mr20499546a34.6.1777300148671; Mon, 27 Apr 2026
 07:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com> <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260427133746.GJ440345@unreal>
In-Reply-To: <20260427133746.GJ440345@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 27 Apr 2026 07:28:57 -0700
X-Gm-Features: AVHnY4JY-sO0J_s7LFL2WwzvQxcK7s_leO-HiTQgItvSXPr8LTKeRFwdBSndRaI
Message-ID: <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
        Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=69ef72b5 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=jaC9V5GCrIjCCUt1bV4A:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1NCBTYWx0ZWRfXwsaWTTpfIJwE
 1nZerpw8yp3YtkpmgUHnqnqqRbVeDS6fW2qhMnDmyU/cyIVTPL4NavmCMLUebjcA3/CuJ7aDrml
 o1syndBSlMMI6LDzgo+Tt3zVV90bzGpVisbxpcYCqJJhGHnYPigbArw7tnsN64R/cbiQ7jOnLn9
 M54a/lDRX5kpLjmMklkZjxj6OHuIkimg6r3Tw+xB3Ya7rjAOwus+3PhUYzSSoI5OBUxMsdMBrxf
 Ewff9HteG8p8uP6QsuGQlWn690Tnp6T01CuzPurp/5bF2hMtk1ONabtWJnO5+2bi3CI1yvzJhcL
 ihWfjqBui0fcN2wts7C8+Szwh6s3VfTGxeM4cX4u4+F9//4WlAokgUyuRh3vr/28V7IQPqYGoxk
 GqWvgMw2ljzFbolyUoWvVLDgrKfyb9C/Do8+4Mm/OaYfRENIZa77BWE4YXpQlxdUv3kZqchjaQb
 XTVPzcDS26rVMB7P4Ew==
X-Proofpoint-GUID: na1HP7g9juHF6rww5yPsv5ExiTY3iH4S
X-Proofpoint-ORIG-GUID: na1HP7g9juHF6rww5yPsv5ExiTY3iH4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: E3C164745D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19589-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,meta.com:email,mail.gmail.com:mid]

On Mon, Apr 27, 2026 at 6:37=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > On Mon, 20 Apr 2026 11:39:15 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > so peer devices can reuse the steering tag and processing hint
> > > associated with a VFIO-exported buffer.
> > >
> > > Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> > > using a flag plus one extra trailing entries[] object for the optional
> > > TPH metadata. Rename the uAPI field dma_ranges to entries. The
> > > nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> > > is set the kernel reads one extra entry beyond nr_ranges for the TPH
> > > metadata.
> > >
> > > Add an st_width parameter to get_tph() so the exporter can reject
> > > steering tags that exceed the consumer's supported width (8 vs 16 bit=
).
> > > When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-----=
--
> > >  include/linux/dma-buf.h            | 17 ++++++++
> > >  include/uapi/linux/vfio.h          | 28 ++++++++++++--
> > >  3 files changed, 89 insertions(+), 18 deletions(-)
>
> <...>
>
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index bb7b89330d35..a0bd24623c52 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
> > >   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_=
CLOEXEC,
> > >   * etc. offset/length specify a slice of the region to create the dm=
abuf from.
> > >   * nr_ranges is the total number of (P2P DMA) ranges that comprise t=
he dmabuf.
> > > + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra tr=
ailing
> > > + * object after the nr_ranges DMA ranges carrying the TPH steering t=
ag and
> > > + * processing hint.
> >
> > I really don't think we want to design an API where entries is
> > implicitly one-off from what's actually there.  This feeds back into
> > the below removal of the __counted by attribute, which is a red flag
> > that this is the wrong approach.
>
> I believe removing `__counted` is a mistake. In my proposal, the intent
> was to adjust the meaning of the storage object based on the flag bit.
> The size of the array should still be represented correctly.
>
> Thanks

Thanks Leon =E2=80=94 you're right that __counted_by should be preserved. In
your approach, when the flag is set, the last entry in the array
carries the TPH data, so the effective DMA range count is nr_ranges -
1.

That said, after discussing internally, we're leaning toward
introducing a new VFIO device feature with dedicated TPH fields (as
Alex suggested too), to avoid overloading vfio_region_dma_range with a
union that changes semantics based on position.

Would you have concerns with that direction? I'll post a v3 with the
new approach.

