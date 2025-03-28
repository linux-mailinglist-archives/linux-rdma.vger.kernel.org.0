Return-Path: <linux-rdma+bounces-9016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7377A7491F
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7C17A9847
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BFD2192E1;
	Fri, 28 Mar 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NioVTezr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE881E1DFA
	for <linux-rdma@vger.kernel.org>; Fri, 28 Mar 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743160825; cv=none; b=UN5ZIS9ZUhLFqzAtp15X3xOb7S2Eo4o4vgVhO4O7xkaG/n2HODkJChLh/Qp6qbAk2hwwS+LpK6Eed4nTMK6lrGknQnLFM6r03QWZeIxQF9P7EW6WpEMBDzt0Ah32eVcoGOsRcv2GBR9MvRKflf8Ij6CGtdxoQXPY9L+wjqLzr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743160825; c=relaxed/simple;
	bh=AGQAVNzeZWIutjsf8vmQB6eAcv49DEkuAYtLpgz/A8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AmYX3yfCpuQXucaNFHXMo7znP09KgM1k6HsWC5SN1EBg5ciPJjJ0Ag/ANynAiCPcnxNlsHdQHsReMmVVKyGitK37uPQ/f/SKlDyARJwWvm+169yo4CJ14FIo5AgHjTwkIH0LgYaFeASjD+Qj3BI0zO7oUVUPLcKNehNRGJG1cEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NioVTezr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743160822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xADjDk9zc1bw1YBgWMpS4QPMZR6DTQ8CJRDpLqIGwyc=;
	b=NioVTezrX2nTWCgSlE2JjGpjk6O1Fo4Y/+dlZWqXQOHWqGABQD+WpYiz79aNPsBl211EXW
	fnp+V3JRI1S61hihg8Y3LdMiDVkoZyumfw/TxwG0r//JQDzWWLUghkDxLL6c1hZBnOIVHF
	aCg/Mg1b9b9E8v8bFiEhW6XEPeBw9LM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-jYto570PNTmEIFbsmgwjVg-1; Fri, 28 Mar 2025 07:20:21 -0400
X-MC-Unique: jYto570PNTmEIFbsmgwjVg-1
X-Mimecast-MFC-AGG-ID: jYto570PNTmEIFbsmgwjVg_1743160820
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5c03580aaso1735101a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 28 Mar 2025 04:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743160820; x=1743765620;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xADjDk9zc1bw1YBgWMpS4QPMZR6DTQ8CJRDpLqIGwyc=;
        b=lKWkUJd9um2qegcSEdzANyC25DlAjwFtl1LIiBJJJueNTbf+/yy7E1JOzrZy06kOHy
         b7exg3l3EZtc/ouSfBg7Yr+0Hzny0IjJMUo2mhyPRfklL11z7Y31wnvhuemI4wnPamgJ
         +yLig1Ti/JEiMO+qTKFX540/28JHLO9+Au89w0SOEYPIOSEjR0smArNbfI0PgBhrnp4v
         ZXYuCVXtCFl/YbO1AEeZ2jEjk7/2tIO57Nh7B3D+g8BzfRycuWh2uIJRgtBjRHaRClb7
         tMhpnMiqNU+BdSkqvZ4FBL96qq5VqeyjV4dQ4N83Wx42NTcLcaUgf1/+evghxnDqhjax
         UkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/d9KxKRDqSXhPDQD+JmzPluq0pgOb2Z7tm+lGFM1LmTMX9QN2jnxHTV08+8ObOGmURqHy20mcEBR7@vger.kernel.org
X-Gm-Message-State: AOJu0YyniLu+K/PfE5m9xcI6kl/Ef4PnfyezFD1Y1MVFw0eBTWyCxNYc
	hpjV8bURtrFgdTjdqSmiF/GSOmkrygQ0nfqKIKk1HcZZC6MHFgK2TJcB69PFrY3rH9necNj2oO5
	eo4HuhxkFwMBBhoSalKq2nksjS7KaHUDmY4EZHYAKUOGSQnoNOnUX7o6XMXI=
X-Gm-Gg: ASbGnctLvo7Zb0RYKfwlaWXXCHYROF9kbzCWsrF7N6iePDNCCY25TX1VGrdaPsUUvJj
	5McaW9O83wQCsqK6UGuZHHoqPLCuaPe/+3XIw+hEsL+ordNwKtVOP7ZtjQLkA0RbmU0sjHTDNWU
	JZIjqAhg0dMSVF6ceGjE6aa56H72S2m0fOjbdMdH49xLpYtgQ9bDRotEjd43fOsyz5N/+RkQuNu
	WjFFSC2M81Un3xCegrz0iA8G0rrvtQ4U+5CcqiIziLgwbYu4APYRAiTJTKpwcaQHMFdpxaBzwuE
	2ML3PoEn4iTa248CCpPzzittS2SnpS9cX2YpqVNc
X-Received: by 2002:a05:6402:1ed4:b0:5ed:837:e3db with SMTP id 4fb4d7f45d1cf-5ed8f2099b0mr5968651a12.32.1743160820360;
        Fri, 28 Mar 2025 04:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZK5Nv8BYjsY2nT5mHNKK8N9+Tgsi5w7rURbNEpTt3wAIOPFbmvEnvl96t0hGLvCjO+tk/7A==
X-Received: by 2002:a05:6402:1ed4:b0:5ed:837:e3db with SMTP id 4fb4d7f45d1cf-5ed8f2099b0mr5968629a12.32.1743160819905;
        Fri, 28 Mar 2025 04:20:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d3629sm1220781a12.23.2025.03.28.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 04:20:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4DF8C18FCDB5; Fri, 28 Mar 2025 12:20:17 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v4 0/3] Fix late DMA unmap crash for page pool
In-Reply-To: <20250327124803.41feffed@kernel.org>
References: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
 <20250327124803.41feffed@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 28 Mar 2025 12:20:17 +0100
Message-ID: <87bjtlpfke.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 27 Mar 2025 11:44:10 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This series fixes the late dma_unmap crash for page pool first reported
>> by Yonglong Liu in [0]. It is an alternative approach to the one
>> submitted by Yunsheng Lin, most recently in [1]. The first two commits
>> are small refactors of the page pool code, in preparation of the main
>> change in patch 3. See the commit message of patch 3 for the details.
>
> We see a crash and an UAF on:
>
> [   18.574787] RIP: 0010:page_pool_put_unrefed_netmem (net/core/page_pool=
.c:465 net/core/page_pool.c:808 net/core/page_pool.c:866)=20
> [   18.575880] napi_pp_put_page (net/core/skbuff.c:998)=20
> [   18.575912] skb_release_data (./include/linux/skbuff_ref.h:40 ./includ=
e/linux/skbuff_ref.h:56 net/core/skbuff.c:1079)=20
> [   18.575944] consume_skb (net/core/skbuff.c:1165 net/core/skbuff.c:1396=
 net/core/skbuff.c:1390)=20
>
> You should be able to repro with ping test over netdevsim

Alright, I'll take a look, thanks for the pointer.

-Toke


