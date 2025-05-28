Return-Path: <linux-rdma+bounces-10855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19276AC6E9B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 18:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBD81C003D3
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F328DF20;
	Wed, 28 May 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Yj1XlCb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371A28B50C
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451570; cv=none; b=C2BUytoG9dKWXxM/FXvxkSaVvTDZ56qm1snLyAyaeH1WQfz6HVBbsES+uRdoFq2pzaloJCsjM60pfqCmMglxy/46ebGE2eNlODWfpgiIR3PrOhCLdqt1PGGOi1pFgZqmMJICK7q4xrBLDYYcablYJGRhb/92EYaN7i6UsOWKNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451570; c=relaxed/simple;
	bh=fhxfhD2VJr7N/NFA3EsShcZyUJOLpTJhxWDJrIillnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/q8jQ5VOMfDjB39nyvTgMzZcLNh3+PbfQ412YC1h4rMK/35HUYe6V4Nf4JkLWZiNDJiD0ZQAfIvI/5gCYmRq0Y6cwY9aazD25iDe0svZSVMKTPjsw8RpJ+K7blGhIZlfY/Rgdbwfcgsgu3U2/uKBFcRbQ+eKU/HeF2ccVz2duU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Yj1XlCb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2349068ebc7so5625ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748451568; x=1749056368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU+5V0D50sosAbJkKDzKL3jVUZ5FjJivIDtXJcMadFo=;
        b=3Yj1XlCbJRh4dz+XQ54jCMu6hEj/eJa3CO9xHnolvo3yhI/HuKIkkVxyKNwvSoiJ12
         vy9fOmfhtiiVAVwct8RZTfOZ7EY4VctfJrVmRswHrdR7n4cUi4ZqNY6q7OZBenrQa5kU
         Z13SE6uavKbInk0qRtWIocb8FKisp7qWsXJ3BM/qOfmK7AZhI43UaPJ0gRY0QXhzBubH
         nSe9QSbwcF1LZdo1dnlPTJlfltMPjHMHn9pLDHXPdbwQwwOJnDHVrmXN1xAqd7th6+3R
         O1IhO32L3wuh5e1HecH8MZJpP/PKWO+aR/2SrcCOnte5qr/0j5hgKSni2IRcjimyQR5s
         f1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748451568; x=1749056368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AU+5V0D50sosAbJkKDzKL3jVUZ5FjJivIDtXJcMadFo=;
        b=pwRc1emkSBrXyxk1zxnV1CYmhdKjOlwxgSzmxY6VBapm71aMqDsqfDSMeAYZrpWVbc
         avUI3RvSa5+zBg+nVtuXWpcJTsqfZ2xIsk92DibHMVhNS6CesIu6VPtocFKfjAbt/u0b
         CuL1F7NCyDBYi/Q65SmOg53JiftyPaqoRE2xk1NXcegYgQeud7O8afUpaFyZ/7DPYreZ
         smz2fHEdKHwhtGP1ncPDlgF6RbE9Bi/FXzLgts8iIbPb8Zcwpb0CxX0d28MbBhK7rKVk
         ROWf1hM9KmWCUeHhwJyDkz6BEasBL+/LCyGQvCmbzduzkz+xYssLUNTHHOquZL2hgP45
         32OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/IE93cVoCYS1+c4XVBbE41XNK4XWU8IVFV0/HZGbCbYBHyx0jKRjh0szX3dAtFb0wAc8hOHYUNzVv@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWCmhrpwFCtxUOi2xNyc77j97wKUHbnY82c6+z8Mt4oNw9ZQJ
	IQ9opHZFbNRpfKmSsh1SOcfqFSekBJNuPmjMa1XSs5kJ1ll7+YdkGJD8tNm73IdX5z7KXeIKxlF
	Q9urknA8Lys+VItmasNIxdiRXhut7y+WWl76P3CHC
X-Gm-Gg: ASbGncsEVGAf//0SQ9ZowXXsi+hIxBpK/w0PLTxcEPKpI1Lf/ZYmu1v1EOvRDSvh6Rt
	Sf2SkIsvul8WvBwZ1sU4y2ozktuTivGSx0RHR8k8ABFcUyVMu1eyKW/nw5OeLuaw794gmzgjTE7
	vSK9fu+hA5ceMHaC6YtomwY3toCArYf37nq+y86PpOEC1FSfi6g7YnZ/QmzoEBJrzq56oxKDii8
	D2jrApJS1fG
X-Google-Smtp-Source: AGHT+IGH9FRqbmLXCu8WFJb6dVN46h/TnBW/MP1T5WeV0m8oyOEBp/rxcLIB9unWYsuTueREphw7MK8d9rPrgIGIBnE=
X-Received: by 2002:a17:903:1b63:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-234c55ab5aamr3548825ad.28.1748451567487; Wed, 28 May 2025
 09:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-17-byungchul@sk.com>
 <20250528060715.GE9346@system.software.com> <87v7plmbo9.fsf@toke.dk>
In-Reply-To: <87v7plmbo9.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 May 2025 09:59:14 -0700
X-Gm-Features: AX0GCFuxRFdaXnvFJo88yADv-joqzgj8xrel-S60sB-_CFIsIQuQGzHBPdDTD9k
Message-ID: <CAHS8izOJVRu=qvsqZyXERKxA-fcqGuNVfiVsXsszQYAjD4d00g@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] mt76: use netmem descriptor and APIs for page pool
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 12:34=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>
> Byungchul Park <byungchul@sk.com> writes:
>
> > On Wed, May 28, 2025 at 11:29:11AM +0900, Byungchul Park wrote:
> >> To simplify struct page, the effort to separate its own descriptor fro=
m
> >> struct page is required and the work for page pool is on going.
> >>
> >> Use netmem descriptor and APIs for page pool in mt76 code.
> >>
> >> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++---
> >>  drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
> >>  .../net/wireless/mediatek/mt76/sdio_txrx.c    | 24 +++++++++---------=
-
> >>  drivers/net/wireless/mediatek/mt76/usb.c      | 10 ++++----
> >>  4 files changed, 26 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wi=
reless/mediatek/mt76/dma.c
> >> index 35b4ec91979e..cceff435ec4a 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> >> @@ -820,10 +820,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct m=
t76_queue *q, void *data,
> >>      int nr_frags =3D shinfo->nr_frags;
> >>
> >>      if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
> >> -            struct page *page =3D virt_to_head_page(data);
> >> -            int offset =3D data - page_address(page) + q->buf_offset;
> >> +            netmem_ref netmem =3D netmem_compound_head(virt_to_netmem=
(data));
> >> +            int offset =3D data - netmem_address(netmem) + q->buf_off=
set;
> >>
> >> -            skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_=
size);
> >> +            skb_add_rx_frag_netmem(skb, nr_frags, netmem, offset, len=
, q->buf_size);
> >>      } else {
> >>              mt76_put_page_pool_buf(data, allow_direct);
> >>      }
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/w=
ireless/mediatek/mt76/mt76.h
> >> index 5f8d81cda6cd..f075c1816554 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> >> @@ -1795,21 +1795,21 @@ int mt76_rx_token_consume(struct mt76_dev *dev=
, void *ptr,
> >>  int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)=
;
> >>  static inline void mt76_put_page_pool_buf(void *buf, bool allow_direc=
t)
> >>  {
> >> -    struct page *page =3D virt_to_head_page(buf);
> >> +    netmem_ref netmem =3D netmem_compound_head(virt_to_netmem(buf));
> >>
> >> -    page_pool_put_full_page(page->pp, page, allow_direct);
> >
> > To Mina,
> >
> > They touch ->pp field.  That's why I thought they use page pool.  Am I
> > missing something?
>
> It does, since commit: 2f5c3c77fc9b ("wifi: mt76: switch to page_pool all=
ocator")
>

I am very sorry, I was clearly hallucinating when I first looked at
this. In my defence it was kinda late at night in my time zone :-D

Since this driver supports page_pool, I think it's reasonable to
convert it to netmem. It may not be intreseted in supporting devmem or
io_uring zcrx but there may be more netmem features in the future and
future proofing it sounds good to me.

Reviewed-by: Mina Almasry <almasrymina@google.com>

(although I would like to see a virt_to_head_netmem helper FWIW).

--=20
Thanks,
Mina

