Return-Path: <linux-rdma+bounces-10989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF17ACE298
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 18:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8535F189CC27
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC41EFFB8;
	Wed,  4 Jun 2025 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAJRmGYG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F981EDA0F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056154; cv=none; b=YyOA9cF8X3QhKOybaByzjxeGn71l2V4o6mJRtPS++c3SqnobVS/a65Bm8pAWY9apaFCFb3pkQH/EQAzol0y/Yl+Ft5+kuRvrbELDHgEBvFVQrzpiGxx22NBfNfNVXtaI1YxmXeAvqg4R9TnFOFvo6gAx+ntQj53yvo5ISecRr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056154; c=relaxed/simple;
	bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGHlG0N7hqJ3EyinwXq2dcF9LlK28hOYmhqaMduGWND6gHTXz8F4zUZ9PDT0q/mddEw8h0eab59a3dNSXv64UzdjY6Y73sX7qP22wZSeg7NgoD8cra7KL20iDMAXk9idUPAUF3BbS/bc6xzdy70/W5/EsL1Diq+qIy+fviZ5aG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAJRmGYG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
	b=eAJRmGYG3nOughcMclp3qjpNv8joCSd4WlFDqlXGEBWeJOPB+jPli4Lw/nt18XLKp20RJQ
	/VBCbH17A2jUOSbbuIZ/BrBkDiveECWONlo6JrQlBhzUVa66D6xwV2qqZsrpDDUtK1YZ89
	6MgwfXMDe+PjIbLsf+dk/xTxKH1mAEw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-iZAEKd0lPvKEWUpU1uz0xA-1; Wed, 04 Jun 2025 12:55:49 -0400
X-MC-Unique: iZAEKd0lPvKEWUpU1uz0xA-1
X-Mimecast-MFC-AGG-ID: iZAEKd0lPvKEWUpU1uz0xA_1749056148
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac79e4764e5so4393866b.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056148; x=1749660948;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
        b=jvPZVML75Iy5V6SAGX22BD2Z8aTWCNpmIBVj5rqygQnVUzgIlnP9iexjmsakKxqqqn
         mJT1dK/Ac9xaxKEx8wEWy8FdGQPE+dKqJXw4m84kFk7fhjlOhWleTKl0VfKjdrQXAZ9G
         M/7w/QnBBhSWdNtqH9yi3Y5RH34WVWPnx7KK061LGFwRzIWRoESmO0nfIpeGsk2tfkA9
         ruIjpj2fzgO/iCXEF0lVAm0tFOioqAsXH9N3hEHt5V7DmR8hL85IohC/7wfiws2iyAiI
         yMI0/1+l9rLCh6o0FFrEX+hHNeitr9pI7o3VkY/+DLIyphN+7wJBTK7nIJKE9o8Fh6Kl
         m5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUggBDCelZEJNE+Af1/JsJziWxpFsEnglXHHDLsPs6YQ5qFdsPdXIl9UygddNZKEmy8stKWuNcYG4S7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6i19kHhujlmBsWbxyAQkWWovtMSCeKdGByNV2WZDpZKVKzu+a
	kCRrXUbf+/kE96jSsjvEOFRjLXUma3GXpdhiM7Bwpvyt97sTceNwKo5nEQK+0gmVe/Zfyxbvc2y
	VePRtbnB0W7irXK8KgFAHLTmhhv6OFyaNIIt+0+JYsoGXJuZyAPWnf1dbEH051Vc=
X-Gm-Gg: ASbGncuQs7Xq8rCjKIvs5gql2YNDpbe/i6MAlwxFieRbMtR96lHn7qk0vgCYR4TSLMR
	G2yiUV88U/JLRyX5gVJ5RnuWp+vUa85EXRNqBsd9oK+a8ACnlGSvTgkKQwQPZYJErmbWv95xCea
	WAnntps7Jf5W/xVBG/J1as3lzBOpkLbObMjUEY9xqcF9veXFHbDKNcYOJCBZmkLHvw+EEYHf8B9
	7xn63Ag9VSAO0whBQq3sZoMU4cHJcvXbkZA2ClXR1pqMzo1r+tbNkRwXmSMXSz8oYXdi/9DkR4Y
	l3jbV5o7a6Z9JIw6CR3CO0+EiAavjvTK4VBS
X-Received: by 2002:a17:907:6e9e:b0:ad2:4fb7:6cd7 with SMTP id a640c23a62f3a-addf8c99908mr343449266b.2.1749056147768;
        Wed, 04 Jun 2025 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYPG/Bjmaa00gr70znOgvLxuMNOHBq9tzeMq8cTFVTOyJdUQkjk6QowoSWQ/jATpsw4qluaQ==
X-Received: by 2002:a17:907:6e9e:b0:ad2:4fb7:6cd7 with SMTP id a640c23a62f3a-addf8c99908mr343446666b.2.1749056147365;
        Wed, 04 Jun 2025 09:55:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd043a9sm1117788866b.89.2025.06.04.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA8FF1AA9162; Wed, 04 Jun 2025 18:55:45 +0200 (CEST)
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
Subject: Re: [RFC v4 12/18] netmem: use _Generic to cover const casting for
 page_to_netmem()
In-Reply-To: <20250604025246.61616-13-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-13-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:45 +0200
Message-ID: <87plfjv432.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> The current page_to_netmem() doesn't cover const casting resulting in
> trying to cast const struct page * to const netmem_ref fails.
>
> To cover the case, change page_to_netmem() to use macro and _Generic.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


