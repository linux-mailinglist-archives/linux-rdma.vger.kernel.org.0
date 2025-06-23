Return-Path: <linux-rdma+bounces-11557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D11AE4D48
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 21:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E04317CAF3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676382D4B67;
	Mon, 23 Jun 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iarOq283"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7602727FD
	for <linux-rdma@vger.kernel.org>; Mon, 23 Jun 2025 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705766; cv=none; b=Lyxyz0sE0x2DP08YEV+YcOluWDYM++Ot4rO/qb45NdstzxsZ0vVTd3VKhbZ2r0eO9M3UVxPuM2nJzAu1NivUYEOaBd68hB28CKlaPJaSBX3Bxxf3ZagYWqmIyU5LJTrxMjnV2xrUTurnBdDkfspjb1O9vxX9UX8LqxYdvwdIEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705766; c=relaxed/simple;
	bh=tH3eSBTG6tbTZzapgRbeJfffzzypj/6/QYNfupAEtkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQcSF6uvZi2ptzJ3Nr5KD4DNYFPW5+SVRx1S6NxNmWKrgwBZmjaa0kuqbgZY3AxKm9I4P/NXmsnMpo/7bYMAlHiEZuPAWZoWRU/8JwU55K9G0nfqHce9PjOotLtucRAD1PSKckNIVZu2C6yAWtpD/E/5V7j8q+cdDJFIknFOXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iarOq283; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e389599fso46425ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jun 2025 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750705763; x=1751310563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp/0chDgm2snxzxzq95eP+vthqt+mdAU4GERCYRoDSo=;
        b=iarOq283A+lGOwRY14zh7T4XNo+d4ywWBZL79etz5yP8MOUIm5q/u2k6u9wit31SVg
         UyzkcYRDvtOgmkdfGg60oGYhBmaHyQBPAMtlNUSwr7BVCnqxsmsPvf33S380tFv5qLiC
         YlFvahde1iBEHaMrTb7s6O/tX6gIcQXeZLCyZNK3VlbnW05UUUglXjtgo3c9YzJFabPM
         8Ht+vt58wZtH1fb6jne+Rcob6VaGqS6807gcly13IHhNtY/Ujl19BoX2w6tatkdHIRI3
         c9OBhyJafjKO/XuJPkM9VehSR3ThlyE8CG6/C4g/SLjjnyHc1beLnVpvUQqzl2Op+/NW
         hCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750705763; x=1751310563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp/0chDgm2snxzxzq95eP+vthqt+mdAU4GERCYRoDSo=;
        b=Y/LtrM16DG1N86KPUu+S0FeNc/Eu35m2fds8SQayqd2vKaK6tKs60AUbJJH4AIHvtB
         eCANs+Wok8YLK5zYg27VHmhnyXBS9u7C6MAvPDz0SsVdhSX+dJYRxB70He0zwWO5NXGy
         zmgXv14CvwTjbuK/l1KdCISTDFI9s+fEa6uzqz729a0xK6qP45R5tVgOxLZM3xJI3RUy
         XA8fZVx4JXZbHvzYPLEppLrIS9EV5PGoRqwX/D+dG9bBs8bUBUOr7Jber89CPFoY+/XP
         Y5MxpwIpqRMkWak/GPXjJGm9naTjg6ZMfa7nBQhaTbheUw/jd3Cd3p6nQj4RjsUMLX6r
         21Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUmURoPvJ+YkT0sUf4Yr3hMx/sotei3WG8yj4O2pej8dfbAg7bn0FtJKSRha7+kvvhyGu5bVAOBZxUM@vger.kernel.org
X-Gm-Message-State: AOJu0YxGaAWrMvcuxkGtzdmq7opIOA0PbINS8PqMZMr8TTeb3PB9nh3/
	Q+BRM85QUMBADdOXlFGa23CiElLy3TGy42UOI18F1UkbO0Am+zwwI7QB/obAhJJgEMsCLqCdKnp
	PZi6Lh8hOOYayhFFYoKUo7m8w4f96p/PZxWqJhwtV
X-Gm-Gg: ASbGnct5hpo4ANQ6LbzNCWVHPcptXCVMURk5RLNSuPjhvzLWgeJ10bnmZT1vt3xuYEk
	1KBTF3UWfJIjW7gYXiVbkAbPWdKjLmKdF2quRig7xHXHGHcE9Hk6ShLb3g56MUFEBqCATH7nP3v
	59xh0ljc4pYWtRjQJu0l7RQAO94bh55cYXMYaylfGbILqg9Ulxbu4NDoTGmru779oh5Kbfw7N6m
	w==
X-Google-Smtp-Source: AGHT+IEP6CbJSMMIjAaNAJ9rOrnxvip7xFCbKZZbgsFvTLW3kA7gzinjehuUnzT5TsDabxmVW7mRkxDk9owGN0VC6EQ=
X-Received: by 2002:a17:903:41cc:b0:234:b2bf:e67e with SMTP id
 d9443c01a7336-23802c66acdmr344235ad.13.1750705762491; Mon, 23 Jun 2025
 12:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620041224.46646-1-byungchul@sk.com> <20250620041224.46646-2-byungchul@sk.com>
 <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com> <20250623102821.GC3199@system.software.com>
 <aFlGCam4_FnkGQYT@hyeyoo>
In-Reply-To: <aFlGCam4_FnkGQYT@hyeyoo>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 23 Jun 2025 12:09:09 -0700
X-Gm-Features: AX0GCFuS5sYOE7MPEWKATp8YxIxvbHC-ghHV1COC2m3qIITA4p4mPOlFQEJRPtU
Message-ID: <CAHS8izMbtp0dN3+PZsivFD4Zg1DqaL5BJ4cw4jGjs=wCXAns3A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Byungchul Park <byungchul@sk.com>, David Hildenbrand <david@redhat.com>, willy@infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com, 
	toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, 
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 5:18=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Jun 23, 2025 at 07:28:21PM +0900, Byungchul Park wrote:
> > On Mon, Jun 23, 2025 at 11:32:16AM +0200, David Hildenbrand wrote:
> > > On 20.06.25 06:12, Byungchul Park wrote:
> > > > To simplify struct page, the page pool members of struct page shoul=
d be
> > > > moved to other, allowing these members to be removed from struct pa=
ge.
> > > >
> > > > Introduce a network memory descriptor to store the members, struct
> > > > netmem_desc, and make it union'ed with the existing fields in struc=
t
> > > > net_iov, allowing to organize the fields of struct net_iov.
> > >
> > > It would be great adding some result from the previous discussions in
> > > here, such as that the layout of "struct net_iov" can be changed beca=
use
> > > it is not a "struct page" overlay, what the next steps based on this
> >
> > I think the network folks already know how to use and interpret their
> > data struct, struct net_iov for sure.. but I will add the comment if it
> > you think is needed.  Thanks for the comment.
>
> I agree with David - it's not immediately obvious at first glance.
> That was my feedback on the previous version as well :)
>
> I think it'd be great to add that explanation, since this is where MM and
> networking intersect.
>

I think a lot of people are now saying the same thing: (1) lets keep
net_iov and page/netmem_desc separate, and (2) lets add comments
explaining their relation so this intersection between MM and
networking is not confused in the long term .

For #1, concretely I would recommend removing the union inside struct
net_iov? And also revert all the changes to net_iov for that matter.
They are all to bring netmem_desc and net_iov closer together, but the
feedback is that we should keep them separate, and I kinda agree with
that. The fact that net_iov includes a netmem_desc in your patch makes
readers think they're very closely related.

For #2, add this comment (roughly) on top of struct net_iov? Untested
with kdoc and spell checker:

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 7a1dafa3f080..8fb2b294e5f2 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -30,6 +30,25 @@ enum net_iov_type {
        NET_IOV_MAX =3D ULONG_MAX
 };

+/* A memory descriptor representing abstract networking I/O vectors.
+ *
+ * net_iovs are allocated by networking code, and generally represent some
+ * abstract form of non-paged memory used by the networking stack. The siz=
e
+ * of the chunk is PAGE_SIZE.
+ *
+ * This memory can be any form of non-struct paged memory. Examples includ=
e
+ * imported dmabuf memory and imported io_uring memory. See
net_iov_type for all
+ * the supported types.
+ *
+ * @type: the type of the memory. Different types of net_iovs are supporte=
d.
+ * @pp_magic: pp field, similar to the one in struct page/struct netmem_de=
sc.
+ * @pp: the pp this net_iov belongs to, if any.
+ * @owner: the net_iov_area this net_iov belongs to, if any.
+ * @dma_addr: the dma addrs of the net_iov. Needed for the network card to
+ * send/receive this net_iov.
+ * @pp_ref_count:  the pp ref count of this net_iov, exactly the same usag=
e as
+ * struct page/struct netmem_desc.
+ */





--
Thanks,
Mina

