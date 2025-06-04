Return-Path: <linux-rdma+bounces-10993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6C0ACE2AA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE37189614A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01DE1F099A;
	Wed,  4 Jun 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYTc7xWM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AD18E1F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056385; cv=none; b=P3Y9hZumXIhK/6G99+1ASKyxLvw4tkT6i+E9r6wpCDDTWrtX1N+1hHVCcvelDwQimMPAhaI7ONY57TP0UOzFIoqZRTIQ2lU5yIRaMzoeU+pWnZlQFHCWRm/Dk7k/JUNo6DY1gRb2e9bKF5cJN2C1zvDotfn5Y7c8v7GL6287VbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056385; c=relaxed/simple;
	bh=TisxmFxL/O31Am4LeVuPkcK1xwB3+HHPha7PZiRcrV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptsm7p5xX4SE4smbey03V+WjkK4mWvOC2yt5z8ZHTuvM7Sc30JO1XGTFTGrCDNAqkG85x8E+S9oEBSqc6paHMRGLb5daGQUPUg/rg3ErMkESs6FT/6IfJDbW5CsFWqI5Q+hU7tcgcTi03j3Dmo90Qe9MMsj2VKmSC4qblsEmx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYTc7xWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcDq3LrKSOS2wxrwTduRvwlyf6+kgRTg7vc6C+v+3YI=;
	b=CYTc7xWMu/AbTU+BGb0SrhX0NiLK5uo15c0jsQPlvyBA6nyGa495VQaQB1d9sJZjQ3p1ak
	uTdMqWdhbmK7VD7buG8eUDKae1yIsABJVW/OW4i53NzlOccH2sTamNReq7BOIUyR4+kzu9
	KR1utFChIJJrucKwEop8X7BiePiSieM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-LCTtAo-XMkGobh7pkJRY0Q-1; Wed, 04 Jun 2025 12:59:41 -0400
X-MC-Unique: LCTtAo-XMkGobh7pkJRY0Q-1
X-Mimecast-MFC-AGG-ID: LCTtAo-XMkGobh7pkJRY0Q_1749056380
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-601ed3871a1so80714a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 09:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056380; x=1749661180;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcDq3LrKSOS2wxrwTduRvwlyf6+kgRTg7vc6C+v+3YI=;
        b=flaCv/szRTAM5KHdzk3ZZnDSLpAkmtBUpgXhnzqnc5t5POSYdI/wuAFbckMeIPJpNC
         EKKyjtuMBihf3BtSIgGM2/P5iFqFZj1GDLOleZHG5I452RPBmdAy5E2tKjr0lAXkHWQl
         Q4oV4h4uqz7iHb8Cny7dJj9PCpzBH8oF+Z6EOdK1f8f8fWoVP/Gh/c8gC/SthF61+Yzv
         iJ0WGYZcgeXsT68ZbguJ2t+hev0iInYN2YsUbJmW/oDpWwQxHwrYqoMBgeN/whCRiiDy
         buGHtCqP1hoyJyyXYhCGh7XuKLhI0AIhSOlUWIweXtdsO0Pe1MVGJQMIwR5nKN2WUZSv
         jxtg==
X-Forwarded-Encrypted: i=1; AJvYcCVwH7885sVUyEXuZl1hh2zR/bxp/ySUk3KabDMS4IgiFZ2gQyQtU31/92kt8n/jm8s6Z5VUfbtvHlds@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVwO4GH+tzgepwT30Q9PAFM6478s3jqpJfEhEVPlaLc23wffX
	xGTUTgin+hEUJh2CgSiGIAhxDuJQBt894gBzrLmFyMQsNTjARiD3KuzubBeKjZw/BXOODDXVl7D
	3T02oJvXPFKU8NImvvk2mupc7/RXBjQMOO8cUMQGT7iQhxrsK77DhaAvbvi0H/hE=
X-Gm-Gg: ASbGncsxrPJPKyJHdYIFA6OClJ7PsVeBfl2sARwRkfptBySNBTeF8Bm9iIO+2GmX4gQ
	yfp1uO18OWT+Adn2P4tX6uJ7a4LLRcjh4qLwumCCsFXxulOCJjjsTw1xbZGmRlbrhOb1CQLGkWI
	Cq/ERjtP7q7NXTKqcuvMdNxqtXvQcIUU0SZk4CgIfQtpicp6pSZ4RQ48ukgiMTel4YwgadomCPR
	jOqzbykMgmMT/69A6TnIQAQZTnE7KvP3LJh0jINq9otIy+msLyE2dq4/Wr0HLUy8jOUMk+14xmy
	bSzajRkb
X-Received: by 2002:a05:6402:358e:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-607226293a8mr293606a12.2.1749056379702;
        Wed, 04 Jun 2025 09:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZxMOZadu+KBXSHu7RkEeaN6qtSvGLWFm1vInB8dLTiO0dgyXATXc6Hz79i4hKaPIEOdbWXw==
X-Received: by 2002:a05:6402:358e:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-607226293a8mr293550a12.2.1749056379325;
        Wed, 04 Jun 2025 09:59:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606d7e17dd7sm1783024a12.48.2025.06.04.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:59:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C55081AA916A; Wed, 04 Jun 2025 18:59:37 +0200 (CEST)
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
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
In-Reply-To: <20250604025246.61616-19-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:59:37 +0200
Message-ID: <87ecvzv3wm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
>
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


