Return-Path: <linux-rdma+bounces-10990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86907ACE29D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30B0189C3B0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D41F417F;
	Wed,  4 Jun 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUSye5E7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FF1F3BB5
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056202; cv=none; b=VALR5xz9k7pamKJ9MFAg985G9pNH9PFS3U5PuqLfasxDl50egXharPMify6i+6LDNQNkw+mIcmH+gznD0Syd1uqCu8nTv2BvqqM08hX48S+4siYe6ux0vgLLlpqbqZVzXYNQi8ABxTcweOp5sV8NbZv9JRue5Zxb3SLcspehXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056202; c=relaxed/simple;
	bh=hHWkN+1W3r8pcWm5IykqgahYA5ORV1Tz/OpKi1g0bhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ujboKMvBLkbp6d29QuyJhnW02D7XzsKttj8sfDPUDJAT9KhwaxgEAtL1lBKjk+/bwrV32Pt+76mHz2J/5qMSL5PLCWHqp3oSTRqgRPphNvESWSOLXum3HypIva0zbVm5wTfWsgIELur5Bdfw+/4EZ9Bh36kHGRi7Ubi54Mzfuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUSye5E7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2I81AuUlYQ9366SJCkTTKCrVJZ04owtIVy2X3Og2iB4=;
	b=hUSye5E7t/7rVbnF/0qHwa9pqGTmZ6tkv3UWhdqO63+yT6FyR7j64z/d4M1f1Jp+UDC628
	y7SmdKpVmnPfjoE1ae8jI9AnMnvb/RiXKcIlku00vE3N3/+hzQg0TjPNE4EbMpHbNmottD
	sBEBRNZw1mWfkRxMfDdA642CVNFy5pk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-I4mfK23xORyNcFPZ2dy4Ew-1; Wed, 04 Jun 2025 12:56:38 -0400
X-MC-Unique: I4mfK23xORyNcFPZ2dy4Ew-1
X-Mimecast-MFC-AGG-ID: I4mfK23xORyNcFPZ2dy4Ew_1749056196
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad56c5412f2so8088566b.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 09:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056196; x=1749660996;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I81AuUlYQ9366SJCkTTKCrVJZ04owtIVy2X3Og2iB4=;
        b=Htsr5je76iB8ccQW5+J+sbvxLWUZDH/w4iq08gE55dY3iAY53V1IQO82EgDAvIp4ch
         hGWregC67hXcIB2Zx6KptHLRbQyG71+VBWfIcCvVUt9HuYPRyo4Ys8lw4qeVMvswPp5E
         NcRWHQmehRGrKSmRjPte19LwD9r/+crnbsVjScKRWJqvpSdlbDzWJ3ZJX5U+HjZDFhLg
         E7z/twznPjNTZ+TzHyR3oMnazE9SbshPTIujgQVTH+DK+GfZGkUcdTj7PRn0a02yjp2o
         v3dhSlKnwO0uwy6OJQvFc5nUC6Rtmb1VNIL7qPfOBGZXReZBIHPEFX0Q+BL1u//R0DfM
         ukiA==
X-Forwarded-Encrypted: i=1; AJvYcCXUT/axkxfvjx3zhJQQhggzKqTZZCuD/f29qOLp4HUzj+drY2znFYGkkTGPnFmfbJr/X/0jDyrhCWx8@vger.kernel.org
X-Gm-Message-State: AOJu0YydxfSBUl1Cr252cwWnbs84AV7g4Fnqllxbx4NwBR6mxEVD1+gs
	13a1DZtJ/b/NaTvW6Grt3clBsnRm28amq0Zfa0IWzSEagfXIJ84XAuOTbaZrrvsOtAKxVpZLyg+
	XTjWBKW0eCGaEO1BvhndPhQk/JwaSzJlvRKi02YOXPNbTbRYU9UDB8CTnTrhsTaM=
X-Gm-Gg: ASbGnctv49tFnHROzuCqMIQFK/xwpDk9C0ALG0TkSkt7UHyorhC4JzXg4VdgbBdvsAU
	5ifUW0leuJMNiTvvoXkuQ4OJS9B8n44YhmDoTgutsRPkktJCqTufBjMnlhGax6tfqF5YznBFlhu
	REWYwvCu7lO4k/yQFya7WSaq1q5BLeZmdg3Earh2XIstvSpLlzO2CSc9Mqr0KrdsvfIMxVERr2z
	z9I9DjgiN8aIC0E47OVKyl4v/KXO8S0+2R93seUF7z5KTYYOZ3tFreCxJG9h95uCt9UeJk9itgn
	RTjaRwxc
X-Received: by 2002:a17:907:9410:b0:ad5:eff:db32 with SMTP id a640c23a62f3a-addf8fbbcbamr374232966b.48.1749056195769;
        Wed, 04 Jun 2025 09:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyDZZleVWiVesfO9YTAhzLK2xLG6f1Ssys6/5lTY37/ymkAbmNiWcQtPEP0I7NoOuKWqtMkg==
X-Received: by 2002:a17:907:9410:b0:ad5:eff:db32 with SMTP id a640c23a62f3a-addf8fbbcbamr374230266b.48.1749056195333;
        Wed, 04 Jun 2025 09:56:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39f08sm1135981966b.144.2025.06.04.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:56:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 06E6B1AA9164; Wed, 04 Jun 2025 18:56:34 +0200 (CEST)
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
Subject: Re: [RFC v4 13/18] netmem: remove __netmem_get_pp()
In-Reply-To: <20250604025246.61616-14-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-14-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:56:33 +0200
Message-ID: <87msanv41q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> There are no users of __netmem_get_pp().  Remove it.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


