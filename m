Return-Path: <linux-rdma+bounces-10991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7AACE29F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E916AD07
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FF91F4CAE;
	Wed,  4 Jun 2025 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDmTVZPJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860661EFF93
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056231; cv=none; b=jRFqCOCE5dkOnjZtf8ylI9JuawMTGetTziIrVQkJS7h9wjGc0w+n+sAkZH1MVA9Xc/VGF/AtqaM97033qWpG16rh7b9XBLbY/GpwoFUcc3/rkHqVoNDrCO92UccVE9kPNfoC4Pxv6/teJ9D9W2PCh43A0Vtq/h6VtDW/BGuMfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056231; c=relaxed/simple;
	bh=Gw+d+3S7IYA06FhUQyd+hYu00sNtRnUnl76qT+h9VuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iz1OlhvhpTbpxIUa1yczuiqkXL/mDctHbgshYeG2siYFNIxbAXiGlr4YwFP8Wd2+9i4oppP0W31EuApbLAt+B37WjYW65vzSy/uFK2psF2LZqAAe0ZJgbyKOE4y5d1OSSmDlEmTb5z9eJu2GfACBma2+eBIM7B7Nzo/4+5ZEEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDmTVZPJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw+d+3S7IYA06FhUQyd+hYu00sNtRnUnl76qT+h9VuM=;
	b=iDmTVZPJhp6TEO6XBPU2TYP7RGohA2+vYPXI352xsK6gR6Y7iH8P15Yoq2alPbDHaWhoEu
	Ah78rRGtp0yPBMCnKv+46IboV2YABmli3n7GA/JS9Vga2a9FGamyUDg5H7xCwZ4FEUDQKw
	zhypJ4UQwkpCW8TDHkV8qINPsm5pVUU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-BZ4D8FeaNW6LKQAV9O0zWQ-1; Wed, 04 Jun 2025 12:57:07 -0400
X-MC-Unique: BZ4D8FeaNW6LKQAV9O0zWQ-1
X-Mimecast-MFC-AGG-ID: BZ4D8FeaNW6LKQAV9O0zWQ_1749056225
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad5697c4537so12338266b.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 09:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056225; x=1749661025;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw+d+3S7IYA06FhUQyd+hYu00sNtRnUnl76qT+h9VuM=;
        b=WoB9A4GPqwjH3Gd7t1fcWmp/v9DCtvyhQLa4EoR55ayXvl7O30B0Ku/zlpv6d/bZ7x
         OVpU4Jrcdv87URS6AC8QfKBXvZ8kK/A3sFsCUoN039sHKGvwXQNWQZa6XIG4xMttYC7X
         Mimx3NvNcJ7FBORN1XqLduD7KIlGJppLQcMuM0PqVbVyNXUfqbBW9F8/vIzvCrv/n6bY
         Xq2lEmAm3Q9mZwKMPf29sTItg86vv0ARJajqRYBscYCw9/xAGQr3M84OMfMp2f9nd4dk
         XfP48WwXRc3W8RfM8jnatyf7mLeoyTp5Anw85vguPxgvH+iCGfQwEVBkZB3VQSlPZoW9
         HkXw==
X-Forwarded-Encrypted: i=1; AJvYcCXje8ACD328pzm3/7naV9vmDJ1ndo8cUWbv7DD1Pz+k4+eOXMPWD27U4IOvGyn/Fm5MC2oKTZhfnk73@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxr2KChRC/gEokOb65ntdf1z5Q/o+yUgJVgUhIZJHqpQmoyZZC
	3S+6Kmu9jSP0vO9GihnlJdS+wSc/GBn+nrCmZuE+Fe4mfze49JNKAvHET7hZ82HPcw2MD7x4eJ0
	uwD2wu6l9fgjGrtt+I84gsV3Xa9DJAee57vB5FkvghdmxmkLkpdnSVAycH4dVeCQ=
X-Gm-Gg: ASbGnct+LieEjQtZc1yq7WdJ49f+wfRD7VWyGv50PtLsHBQ9pgAI5i86hAgUkhfqhFC
	a3TRFBmc0kTzYCokrogTAjvTzPLSo52092YP5ek0GOjUtbdouUmL6JQObDcMkFGJA1dosj2jvei
	YLyQ4KIsaeLLjUOnLZS4Kz/isr+gb/Nq91xSY2Wa65wTnE0cBDI4KZQDXvOxngk2z/07hOIivgk
	dCwexmSnFz0BaUDL3f52Lvf+9N0DKxkjiNsWp8NEXgont66sUbg/+n9IbquCx7amoVcbOX9wGOJ
	aegQuG7u
X-Received: by 2002:a17:907:1c26:b0:ad8:942b:1d53 with SMTP id a640c23a62f3a-ade078951c7mr24902066b.27.1749056225227;
        Wed, 04 Jun 2025 09:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqG4TOAjPvMml/YdZyEoQ+QahksC02aQ5Whxm4dNHjvxJYD+wb6qalU2zcWL3KxMHhCO06XA==
X-Received: by 2002:a17:907:1c26:b0:ad8:942b:1d53 with SMTP id a640c23a62f3a-ade078951c7mr24899166b.27.1749056224800;
        Wed, 04 Jun 2025 09:57:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6ab8esm1110204166b.185.2025.06.04.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:57:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 59CA91AA9166; Wed, 04 Jun 2025 18:57:03 +0200 (CEST)
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
Subject: Re: [RFC v4 14/18] page_pool: make page_pool_get_dma_addr() just
 wrap page_pool_get_dma_addr_netmem()
In-Reply-To: <20250604025246.61616-15-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-15-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:57:03 +0200
Message-ID: <87jz5rv40w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> The page pool members in struct page cannot be removed unless it's not
> allowed to access any of them via struct page.
>
> Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
> just wrap page_pool_get_dma_addr_netmem() safely.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


