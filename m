Return-Path: <linux-rdma+bounces-10985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC70ACE27E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 18:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE7D189BA9C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166461F1927;
	Wed,  4 Jun 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaS9W4H4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520461E1C36
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056080; cv=none; b=ehkPE/z3zGQn8QQ/Anhvy7DuP3Nvj1stZQsk4ADIW+chupVg3YxgS5E+3V18IhL0PVoiKjEwTUx0U1AeyXlhFivP02oD6sQn9YT1jVGOjOHuFanYIqolzXOeIEjl8SkbiyQ7oVt8eXH0gfkzhShGME3BnTeVzOZw4LQqKh8ZGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056080; c=relaxed/simple;
	bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBUwjlomjFsHKpHVWeNV3UZl862oU1hJji/p6S5puEhd77VO3ymAfKOv93W/McfTrhhGoum/E1JZiO9ZBot/6KO+i+88CXFqsomRN+fEYCcs3D7AkbZqFQqcbY5WTnPEXjLMDGfSAX3gzYHcROGKvZcWQ4glfatllKtgA6ge9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaS9W4H4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
	b=LaS9W4H4StlrQ7Ke3sraaLMkOrGH6lCPrRKzRC9eVRhP0oNYS2IOj0bX9XHqVGIl5nAxpx
	2wG1sYHcqbqQVo4z8OuMEZXWlCuBpyFRf+4IKrMmJcBw3nCnQHTwiGD7VKpMrLoOUWhKFj
	X2vX8RMje7igenj8DB2mZvsoK/bDzEQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-eFv7UA2TMeegxVUAXT6tJg-1; Wed, 04 Jun 2025 12:54:37 -0400
X-MC-Unique: eFv7UA2TMeegxVUAXT6tJg-1
X-Mimecast-MFC-AGG-ID: eFv7UA2TMeegxVUAXT6tJg_1749056075
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32a72e28932so5700631fa.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 09:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056075; x=1749660875;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
        b=Hwf5IaLjt0e7jtQcSq3KGFVyj947eWMhI1J6pqMmTo3cqEKV9ngi0a2IQphtlgUtnE
         6cLeqWreywx2/cEn95zjc551QWJRvSkQvdAuc8EiA53aOjxSPfuha9lHBdUKZ6HLQmDI
         v+szhl2NTnbP/OQDHL7JhKM468XxwnrgD5aQQFSxVbJbg8UYpKSfdauv84fXINyiqeww
         nH4P6dkzRah3VoM3zxtz4L9BpvBpscVKIrhKqGDPPZxxRKLscJJaRvOWwTxxbkNhe9kQ
         6TxqAAr+mR3QI6vLUD6nzVJUit7bPdlbhD1zsVusBdWDLS5MRtEtwE/rD29MSYw5cd7L
         qRDw==
X-Forwarded-Encrypted: i=1; AJvYcCUeXZrFsm66SWGWWGtv2CiNmAlJFoya/6wSLuSteCA88/W6EEcDIqh7a7khbxzTSnIvLCWNw1I/lzQz@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwDtoNTyH0dVjPE3acXmSijhH85DJKH7SrC4xJak2B0LMguqV
	P0ZCUcC95Nq7WeoeoOkXDJfV+o8ReSVknwKvsqYvWfEARHZcRNh48jc6OPaadK/87nT4dnVd30G
	s7+SXXSAGJ4YNBGqrlJ/SUcxWzUSA7cnLRRA7NxhlWHzukXNiunU6+h0O3gcHi90=
X-Gm-Gg: ASbGncuBbVOkwnVJT7z0Ri+RtafnESHXx3lNNroTvd1RqjSRAeZiLke6HxnE2pcqwrZ
	C3g9xytaMqKzLTSZzEfoWnQC4desyr0nlUDkNPu2w1XUzIg/J9hs+Xnd/dh8mLfhCVUZ8Qzwhh9
	XF0Gk0dtFOnEoV665a/xh6x93ANbw8TZYBgFWu34Zo9uiARKOXDJYTf72DWl8tX31a2jydRZpky
	dfDSjh8YDopbcZKBsOuUsNuuHhP5ec8Ppsziy2javfxuQvawXUKbaoFO5c63PbuQh1SUhnBf7pW
	nsMOQYnL+eBn3p3K0uM=
X-Received: by 2002:a17:906:99c2:b0:ad8:8f3b:de2d with SMTP id a640c23a62f3a-ade07606d85mr24141266b.9.1749056063557;
        Wed, 04 Jun 2025 09:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+FyEzbRQ7ljsnYaqZEY9RyRG/Pit4hUmUJvWYN4/otGwuEi027SbI5iZa7eBk4SkzaaVb2g==
X-Received: by 2002:a17:907:72c7:b0:ad8:93a3:29c2 with SMTP id a640c23a62f3a-ade077dafb1mr27934766b.14.1749056049265;
        Wed, 04 Jun 2025 09:54:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6abc2sm1124547566b.173.2025.06.04.09.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:54:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9A0E71AA9158; Wed, 04 Jun 2025 18:54:07 +0200 (CEST)
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
Subject: Re: [RFC v4 03/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_page_order()
In-Reply-To: <20250604025246.61616-4-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-4-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:54:07 +0200
Message-ID: <874iwvwiq8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


