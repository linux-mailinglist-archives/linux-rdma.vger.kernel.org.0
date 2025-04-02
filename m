Return-Path: <linux-rdma+bounces-9126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC66A7975E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 23:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A56172271
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C801F3BBE;
	Wed,  2 Apr 2025 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b58lRC8g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EB2E3360
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628419; cv=none; b=vC3X4K6cu79HGmZxkUdA/Cpx56TCDxA0SLiNZbirMKN7QC2p1CgJ6sSU1UrFTJd6b+6UqQe97cGiyMmf6HnTsm1y2JWOz3I85tAqYSDxfb89d14M2wzyOXIkJOnaMY4E4LrCnRWneGqazVWLNFFZl+a45DqMKXeoW/tNwlbuYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628419; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVIJ7ZCbgwvw/YUDhWvQ06p0Yo7QUSaJbkcW9SH48UMLu4eo/MEN8KrC4lHtsJhzMG+lzZelDnLW+W0S7p1fLlCY3AkpGxmnitJ4xY/IoFq+I8u/hHT0wyXHy6QpKT0XpopnlQxPi2DTpV0bSNwhYg6OHnVCLlpNvD8HsmK+Gno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b58lRC8g; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so29835566b.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Apr 2025 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628415; x=1744233215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=b58lRC8gMwarScoNCP9b3cPtb+KvjfQIj/xQRZjy8uhdcbbMTP5MEzwchxpnI2nDH2
         ncRV/kLsg04DSGkc+jUZn44O3p1rFf8e1yZXk5X7czk/rkha5UiUC/Zo6KynsI1FU0q2
         vfZe73JnQ58RIvMynsXsmUWyQMC8/LmQ0HKDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628415; x=1744233215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=Z5a7OHX2Z3RI59t+Yp8vrYhY9+85KXKklgqHFmYrHHFqY0Og3Tw7pJ8srXvMv9Bqc9
         +0xGg9CfU59o0GwCfHAvUm3nvswXuHjfBuju0OCfnPwo8tfOtVieFl8jxcnrwCi6bGfS
         IZ2k+u/hWD7BZSrStc+2pCQm1DHLgwNDJ3ITqUq/8Mgraq1mamqU6a5A3/NwXRQCWN7f
         DI1WcTi8PAUAiE9X4BTcM1wm6Izh5bnhflAj4qCgxtfAQttvTr42R3ytewsbHCuhTEk/
         fJQYDGnDg68iJH3QE+ifcsnZE8XNWGSoZGhhwFm7Ux1X7cS5yCr0PBHsmrJ2Wuiq/79w
         Mi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNGmc8C3C5TJQQZWwFSXluK1Ap1bzMn3Az+ZD86JtSJjhJ/x8LzonHJNYzM9VjYKua3c2WQqj9+4as@vger.kernel.org
X-Gm-Message-State: AOJu0YxMLzgn0qGg2H50SPh+jjTIXlP1bq9qYP1nzcXNrPeA963iJo8m
	exL7pUOcGkDmjWTHYnWkdUBR5swF8y30a8wX8aCLfJlzps9zNyMw39sDTYs7ieWCtMp8eKl/vHj
	9PSlt8g==
X-Gm-Gg: ASbGnctkbLa/wNPBRwBQf29DZyRzYF0uisDVxX+aTcZp6udUiMo4N48uy44EHjSdyKq
	1BYnfnjFwGAtosaVAbc8zqa6iVXEtNSSd5zErKMm6z4HllgDER3hkRqEqSJWZrJ0GhF3EgXq6m0
	SgdvI1+zy4xbVOGFa2xNxuWPmboOqqJyK+h0IlOm8fpp6P/cHCk+FWj6B2Uc5MXYjQDKJ8iDbpY
	iSnWqPMHbovwUWQHlVWroa+QHBeHiJqtN6ChOa6qWWNKSf3UDSdSVlpYvPDPrnKkdtigvKwGjZE
	+vYvuogl93UCaQvAZMVf8Icn9lQPlYU8XdTt/TkJozafP4scJg1yiYRifFErpy37cyx6fWhVEjt
	44CnWzh1oqwV+BsvghmE=
X-Google-Smtp-Source: AGHT+IFyeNelaEQy4sglNYR6kC+IhsiQqn5HGaa2FxxkC/Mzd9soZyfhGKAoyLYP/3hQ/WDFEhdBSA==
X-Received: by 2002:a17:907:7f90:b0:abf:e7c1:b3bf with SMTP id a640c23a62f3a-ac7bc03c016mr21811066b.11.1743628415231;
        Wed, 02 Apr 2025 14:13:35 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f8c2sm980583366b.105.2025.04.02.14.13.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:13:34 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac298c8fa50so36265866b.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Apr 2025 14:13:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUctVqy3TTuMZmJs6/57F9jYwyiIxdo3U61bOgi19dsOFfKDLz5iN/Ja6ofe7rL2Mw5RUqtFD4gmel@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus

