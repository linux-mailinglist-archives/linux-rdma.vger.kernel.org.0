Return-Path: <linux-rdma+bounces-11236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E718FAD6905
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DC07A6F42
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD518215F72;
	Thu, 12 Jun 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWp03Oxf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E420E021
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713393; cv=none; b=GpKtpAOKgHLI/kWwKdcEvAR9fsRyewCP9f2/zGpdNupBFO898KjjFPqKARG1FX1CA527mtHm+u0g6VV5bJObawYSaCMNU4lyGAY/LlugLz1gpkSXtxaLZJ4HgIP9h6+TpgTLpk0DNfZ7QSyHJYqjeLvaPcOCgo12QyY5+oN5UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713393; c=relaxed/simple;
	bh=+D4CJpkdFyReV9euETz9WLcXlKqxJZxwzxQO+xgfM+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vEtIG/QD/idw9RU3T8TXj/9jHTYrqa2l9ftMJ5PuqxqyyQOeQjsPOowQwJ1wiScY+UNwN8QIJzkY/t2bNjkI91UxEMwJK+Z57KNBFJ841whlbA0bz/AEw/O+dQUEFgGqH+SX5eYuEiJXFwyDuqJc0ojrBaMRXykPAfNNy+nLkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWp03Oxf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749713390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+D4CJpkdFyReV9euETz9WLcXlKqxJZxwzxQO+xgfM+w=;
	b=CWp03Oxfr6CmVdQQL2XZ0t/SOkLyHtJeBuw6WVpjv9UA1UgDWRzIgr3BLUZjCczqmH+2oF
	+jMkqDuxtWrZNYc1xV2XcweEJ0pueecLrP5au6dnxYJeGC6WQlyMe6XI5TnfCSmDCgq+6e
	CdNBmwLIBPlPmiA0peavvGcaqxyd1IM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Asx4bJG3N5q7zORXpHaSUQ-1; Thu, 12 Jun 2025 03:25:37 -0400
X-MC-Unique: Asx4bJG3N5q7zORXpHaSUQ-1
X-Mimecast-MFC-AGG-ID: Asx4bJG3N5q7zORXpHaSUQ_1749713136
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-550d7bd9a7fso295645e87.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 00:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749713136; x=1750317936;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D4CJpkdFyReV9euETz9WLcXlKqxJZxwzxQO+xgfM+w=;
        b=cJHAc2DUOdRwcHB1TUX0FPSz7LQXjwgHIEvnUE7jLGrjuvEStilbY1rU+hLa1hC1sr
         g40O1uvkc5NsvporU5aI03InlnUbzPWD+UKXQEHLG/GtBsy4a4NPRThm3jKgfFtw0I/m
         G2HA2r2QMtyZdQaJUbf8zV8OsJ/H3WSYITKCGj72FB+SHrgFoa6klE5DVDugkXZn10KE
         WTQbKSiHQshZ27idlKfqG11L8Iamz4N18/9lai/bUkrRC+v7Aknm/YsiLJpQwbaZVrtz
         DQ+UNkhMIhXbUZiini/4D6ztsJYkesUzOFlA498YUN7eDDUyWM1kW9NOLzNU4j0NZ+ZY
         m0YA==
X-Forwarded-Encrypted: i=1; AJvYcCWwH1yJzblagOV+LSzfS6pTQtsjZxIM7YWrV2knz2t+F/wX4E0RDYH2Kx5nAY9DCpv4HEkHboTXDwOI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aSizm2ZH2cMt318wi0+ufShnt3PvgzfJRzGUHEwlSidwzD5g
	GLidnyXNL55rv4sFOFJAJCxSZkHifXCQvr/UyDUpJfwMQJSVZ3JQ6Z0BfVpzQRkbbiaCwklCwMP
	5awisXHk4J0eVOlTLGNf/BGLDvnD2sgkozTqXesRk9sNOSXWCGR5a4bb6jBAR1xU=
X-Gm-Gg: ASbGncsUR52AsxxH5pvn5LDzx4pE/Zv/I24JinFRP9zGLsx9BouX1OjoOEGmB7mK/fO
	sTzB8Ttsq6s/r5mob4tFACMX6PgWKoDD5xDpVmUupKn+eMczo+0pqGreDezXB/ObP9vWAMMszH8
	uXxSQo7SDUVRKkNDo5vjGJrGGImEr2NSlPzOdK+S6jXNVRkWvE8OArbDdNA0c2qaOdmMuFYI6RA
	37zRXpAtrQJ+dcbSfHrLFkWz9wSwKUlppBHzcR891kMId1OyPaU6BuZdc4dKo/lppEZlZR2FsWY
	XztCN+qWin6xV9vy6hpG406vxqbOVLImqZmqLCoVUGMN3Uo=
X-Received: by 2002:ac2:4bcb:0:b0:553:2bf7:77ac with SMTP id 2adb3069b0e04-553a6556fd4mr731266e87.41.1749713135750;
        Thu, 12 Jun 2025 00:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYXcIUPELqm844Oi0sfmBjt+dPKF9Oqlx+3OFLvEecnh1MblRL4rBN+Jxg88EOatPjNlEPHA==
X-Received: by 2002:ac2:4bcb:0:b0:553:2bf7:77ac with SMTP id 2adb3069b0e04-553a6556fd4mr731226e87.41.1749713135322;
        Thu, 12 Jun 2025 00:25:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f76fesm17684e87.226.2025.06.12.00.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:25:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B64361AF6C9D; Thu, 12 Jun 2025 09:25:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
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
 <yuma@redhat.com>, gregkh@linuxfoundation.org, sashal@kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <20250611131241.6ff7cf5d@kernel.org>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
 <aEmwYU/V/9/Ul04P@gmail.com> <20250611131241.6ff7cf5d@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 12 Jun 2025 09:25:30 +0200
Message-ID: <87jz5hbevp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 11 Jun 2025 09:35:45 -0700 Breno Leitao wrote:
>> On Wed, Apr 09, 2025 at 12:41:37PM +0200, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> > Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")=
=20=20
>>=20
>> Do you have plan to backport this fix to LTS kernels? I am getting some
>> of these crashes on older kernel, and I am curious if there are plans to
>> backport this to LTS kernels.
>
> I think it's worth disclosing that the crashes we see are in error
> recovery on unstable HW. My vote would be to keep this out of stable
> until it reaches at least one final release.

Hmm, okay, guess we should ask Sasha to drop these, then?

https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org

-Toke


