Return-Path: <linux-rdma+bounces-10616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DDAC1F20
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 11:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0382B1BC75F6
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848F221FB2;
	Fri, 23 May 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP9TFbWg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A071F4171
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990869; cv=none; b=fSDIlvngpUUFfRVOHd26t/7Hg7Jnwo+53HNG3h52fZwy8sCXiYfhjTYiUJHKcUttFJul/xAAq0Q1BXCCx5KGL1RBoH08o3ujZv6iIOmjIfNrmBInnpBF6R6w2Iuh5wBChdkBVJsNEO6hihH/zIroKQbSZTl1iLsOtB5iaPTi7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990869; c=relaxed/simple;
	bh=6AD71GZ1oJAgToKv63EU9Cvf388e1iJs65ueGm/PeYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hEUIO0TnEtXAL7GNg62/pSY7AbbT5E1TmIbOffD6wPDOXsrAYgOgqp29uiU2EB9FD6pguCgvz0w0h+IvMt0UeL2CVRXP1zXTqysDS/ZlxnkUT+tNHMUWJftq4g9k2eyQxyIUmVDzVoWFgrW9uEMHD58S5H6f+6rAbxB1T9nq+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hP9TFbWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747990867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9137AuC1JXl/uRnv3Q7irr3oyxG/GyI+XTAgsgelrk=;
	b=hP9TFbWgSuC4evXTGoYuZ5DdbKmI7+YCFf6g7Z3WUvh/xiF2MnbHhAAumEObhhXpRY6fMm
	jBvWl9I4QKXBbKeWh73GNWBulfZAC+JyzjCA5jRVu0ONJAd2OQBttAgv3kft3fPk/t70Zj
	ln8bwle63CR090vEmNTGzomN8CRpyR8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-kzlIquYlNeyEF91IUzF06w-1; Fri, 23 May 2025 05:01:05 -0400
X-MC-Unique: kzlIquYlNeyEF91IUzF06w-1
X-Mimecast-MFC-AGG-ID: kzlIquYlNeyEF91IUzF06w_1747990864
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32810342d69so50407031fa.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 02:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990864; x=1748595664;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9137AuC1JXl/uRnv3Q7irr3oyxG/GyI+XTAgsgelrk=;
        b=rbqWOlYue1dEDR2/xHxe0vV1sAPkEwfQ6ntbHTFZD7cUAFIaqmd9Vuh8mKw7ubwsRy
         ZZiDZ8z3fDsiirkeH5QQcNn0vnpa4urDDETWZOPEBHcp6urv3ROqHNiAQ88xEpswqMFS
         pBaJ/kzPCDmLcu7numVZA57vwDjdsu/NcygNlZs8kvOw+ZJQT0bemdZXgB45gUFCkPA0
         CN1aJlluYPzsh9y6BIK9IMvNXv+evHfp+9urC5O6egTF4uSvGPvaxWJTJST4cxgBhJtG
         nWmmLGZNa1VFrNo102AYF2bjLEN1QyRMcApOo2n38Fm1wMOzeHBAA3CX8OuuYYSZrpg3
         OPOg==
X-Forwarded-Encrypted: i=1; AJvYcCXffJburUzao4USFUoO8RxMzE16s/WfJvpCk2wtIf7X+9dAMkkdTDkeETzyo0GIHpS7UClFTIIW8J02@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdp0EmKjm56w+8+y3i8THmcbGWDugfhEiK/tNo2Ut1NpFEY9mB
	OOjSL1Z0gvLz5p9o01crwWfLB9ptNK9CriwYN6YjIap89Qtf9xJRJ3PCXQheCLforYtUlxYbHqz
	w2yRgBLcgRr5V/g9uHD8qZKIkQ3F/L8SxdB5QuDKgC1tLEV3+836En6P+oDULAdc=
X-Gm-Gg: ASbGnctIl57XVEKID3NUbLDdnKpSPh8pRVpPXqZYMtkGmh6rk0So4V4iW4D7u+LAw5Y
	gPBuJ55cC1I7RBx5M3YyoMHfvnvaTpoKAaSEOBqZxeKk8nzQvOeX5lKws+0soTP9yfnrIEjgb1E
	EICxbVRENtu98UbRAjIVe6V1TlcJI2FmeDlEDKzYAN9J8HBrjC7xc+VPSSIVj3GZB2wegyeVyf1
	TWta1WemgCpeGIA8pthZ1lSeiFJGwVhyiURCYg5xiYsbsPa2enJ0lk6fACf9FB24ArTTsiyVT8W
	hOzZq/Md
X-Received: by 2002:a05:6512:3d05:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-550e98ff25dmr10391799e87.44.1747990863808;
        Fri, 23 May 2025 02:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZQSs+uyNdVjrDhVHs2IglUPHTshvnWvanx+qtFny8cuAL31NdNk4CU+Vw4AmeBNf/utBp3w==
X-Received: by 2002:a05:6512:3d05:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-550e98ff25dmr10391773e87.44.1747990863352;
        Fri, 23 May 2025 02:01:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703f606sm3782184e87.238.2025.05.23.02.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 02:01:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 957971AA3B8F; Fri, 23 May 2025 11:01:01 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
In-Reply-To: <20250523032609.16334-2-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 23 May 2025 11:01:01 +0200
Message-ID: <87bjrjn1ki.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, reusing struct net_iov that already mirrored struct page.
>
> While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h |  2 +-
>  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 56d07edd01f9..873e820e1521 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,13 +120,13 @@ struct page {
>  			unsigned long private;
>  		};
>  		struct {	/* page_pool used by netstack */
> +			unsigned long _pp_mapping_pad;
>  			/**
>  			 * @pp_magic: magic value to avoid recycling non
>  			 * page_pool allocated pages.
>  			 */
>  			unsigned long pp_magic;
>  			struct page_pool *pp;
> -			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
>  			atomic_long_t pp_ref_count;
>  		};

The reason that field is called "_pp_mapping_pad" is that it's supposed
to overlay the page->mapping field, so that none of the page_pool uses
set a value here. Moving it breaks that assumption. Once struct
netmem_desc is completely decoupled from struct page this obviously
doesn't matter, but I think it does today? At least, trying to use that
field for the DMA index broke things, which is why we ended up with the
bit-stuffing in pp_magic...

-Toke


