Return-Path: <linux-rdma+bounces-9102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B163A785CF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 02:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BEA1892D01
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 00:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9168417E0;
	Wed,  2 Apr 2025 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S1RPZBqD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F54400
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743554794; cv=none; b=UIv0tN1FNEJlgxdfp+bvsobue8Q8KTvs9/1G/7ctE17sanl0fr1rNW/lV7XeaE2yXvn8JbaCi23oWt5b/93fhjjJWXyMin+SxBYGjO867LUsklaLoaZcqvHFjS1p85sHyHeri3l1i6by8VQQXXGbdZ9OHfFlHOK+0Z9gi2kRz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743554794; c=relaxed/simple;
	bh=gKvtz1iMes15Dk29gHgnGLSQ0AzIDyIu+TI574Yzf08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtJEmeOfvBX52s5sxlDCNfFdZKv1STNtgVjoE22SGEPJt1xEisI+vdSLYm6rif8gWHTQSUzQTH8y1IgypNEUfyOYR2fUr/WrySIiJO5pqmGP3iZ5t2+PoHw742LAPkfx3Nj+/BD9Z4iIdCvsgVf5OK3n+sPblOwBN3AG1y7piQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S1RPZBqD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso626270a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 17:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743554790; x=1744159590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vu/Ham6OvzEjp0kQLpwOmOKgb686vhg9IiykSVIyewU=;
        b=S1RPZBqDoCLb6qg2WmsgOdxWCKjcY5Jq9riqYT8ZAezx8Q1GoLWRlpxUGzyCFycSwv
         1zvUHoIrDlM5CoCz3WVY/96SRrtcf/jru1MrZOkY4lyZIqdpBdOyLrkKVqw5fHOd2uL8
         08U/4hr2pf06CzVa0c6oINR2G9U1Gvqb3oXzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743554790; x=1744159590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu/Ham6OvzEjp0kQLpwOmOKgb686vhg9IiykSVIyewU=;
        b=q9rN0UMp5mQMMdWhWELjUbZY5rPSsNCjEYMhF660t5XbT7rv/rzV9uKxGUbHmmThX5
         OxPz+5pwMFp8lpMBJZX0+olnLxpk2pl/Mo5TNesiV5Pv8bSt9oOiJrR9MhcPsnth5y4E
         2XpP3ELworOh4sZ0eyk1fxQzZ5n1VtM3hH+h33QxBI92rF7gtD0ET6ZHdNS+CkhMh6WM
         4W0dPus8+kmeiv/Dos61R/HRFYowkVnkxJUeG1De54nHqYHsiCFAhom1Yz8SnmaLeWBj
         IiRDtas4qDY4l5ejNnCGe9RgrwlyXTRQgpUaF7jc8s7ZQR9urheI6RYVwsEt82sFOtpk
         RJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCXp5MtNWd/ToiM9BjhcZGGGc0pJocku8bV1InhCJxzS/a+ntYkXtHAKb2t9xxqj2PBUyD7mzDVk1C3o@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCESwJwGWhFEA9dvwzvO2/fOzXtMuKCsk9K3gqwdtOphEoH7z
	Jqd2hLntvHfpgHUUjOgEb/8A0cNA26J9bSv7S+wRD0/bxKT+FF7CU89f7bsLOhH4Cx3d0ccOEpg
	W6DY=
X-Gm-Gg: ASbGnctL1zXdHVR6YrCB2a4P7D5pxqRyCNht5dLvOQruD42omVDwaJe+hvY3+kWGVzg
	6K4uggsquJGCj9UMEhT9ugPxttBfogaMKDmh3VSg++eWMYnGkjCWbJVCoUJIjXgatVUq4EY/COu
	u9ynUGE2SA0LYKMuQDnJfmuXbfYzAcf5h/E/tMMCRWGAmfdGv/ua2QMQ/BUf6CsvPFaR1uDNjUt
	85JAAKceK8WMFWP4TG6hNl2RaX5DDV0uW9B/Cy+IsG8YHLVmofsC8rGnRsCUrrfc74JO+rvBHzy
	SvSim2A4spGNWh6fppogdLMSL/XQfkjRa9YZJa5m5ftc8M5NGyh/uY/plf6XC5YX7Qrk7BESO6E
	ASOEHA3VeP8ivS5DKsX8=
X-Google-Smtp-Source: AGHT+IG1UGFz6pgQwAwickpjhEfNijJp1SXPgnRGnykKLY14ZSupzQGiXDRNjXCKZxqYHuD57ZVeTw==
X-Received: by 2002:a17:906:fe08:b0:ac3:ed82:77c2 with SMTP id a640c23a62f3a-ac7a50cebf6mr15830266b.5.1743554789707;
        Tue, 01 Apr 2025 17:46:29 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b205sm854698566b.60.2025.04.01.17.46.28
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 17:46:29 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac297cbe017so66699266b.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 17:46:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFx5eggmIE5VLMR2kzjd96K8OJxzeGCLG+s1/N6flziMgiknjl7ov51d1I0EBLR3OUfr8b8/TFl8/0@vger.kernel.org
X-Received: by 2002:a17:906:5a58:b0:ac6:b80b:2331 with SMTP id
 a640c23a62f3a-ac7a5a6a7femr5394166b.4.1743554436373; Tue, 01 Apr 2025
 17:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743449872.git.metze@samba.org>
In-Reply-To: <cover.1743449872.git.metze@samba.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 1 Apr 2025 17:40:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com>
X-Gm-Features: AQ5f1JqzSUFwvrLn7ljSUlWXdbqdVpjtPJUQgf_7X3eWbMud67Mtv15-jjUkgBs
Message-ID: <CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: Stefan Metzmacher <metze@samba.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
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

"

On Mon, 31 Mar 2025 at 13:11, Stefan Metzmacher <metze@samba.org> wrote:
>
> But as Linus don't like 'sockptr_t' I used a different approach.

So the sockptr_t thing has already happened. I hate it, and I think
it's ugly as hell, but it is what it is.

I think it's a complete hack and having that "kernel or user" pointer
flag is disgusting.

Making things worse, the naming is disgusting too, talking about some
random "socket pointer", when it has absolutely nothing to do with
socket, and isn't even a pointer. It's something else.

It's literally called "socket" not because it has anything to do with
sockets, but because it's a socket-specific hack that isn't acceptable
anywhere else in the kernel.

So that "socket" part of the name is literally shorthand for "only
sockets are disgusting enough to use this, and nobody else should ever
touch this crap".

At least so far that part has mostly worked, even if there's some
"sockptr_t" use in the crypto code. I didn't look closer, because I
didn't want to lose my lunch.

I don't understand why the networking code uses that thing.

If you have a "fat pointer", you should damn well make it have the
size of the area too, and do things *right*.

Instead of doing what sockptr_t does, which is a complete hack to just
pass a kernel/user flag, and then passes the length *separately*
because the socket code couldn't be arsed to do the right thing.

So I do still think "sockptr_t" should die.

As Stanislav says, if you actually want that "user or kernel" thing,
just use an "iov_iter".

No, an "iov_iter" isn't exactly a pretty thing either, but at least
it's the standard way to say "this pointer can have multiple different
kinds of sources".

And it keeps the size of the thing it points to around, so it's at
least a fat pointer with proper ranges, even if it isn't exactly "type
safe" (yes, it's type safe in the sense that it stays as a "iov_iter",
but it's still basically a "random pointer").

> @Linus, would that optlen_t approach fit better for you?

The optlen_t thing is slightly better mainly because it's more
type-safe. At least it's not a "random misnamed
user-or-kernel-pointer" thing where the name is about how nothing else
is so broken as to use it.

So it's better because it's more limited, and it's better in that at
least it has a type-safe pointer rather than a "void *" with no size
or type associated with it.

That said, I don't think it's exactly great.

It's just another case of "networking can't just do it right, and uses
a random hack with special flag values".

So I do think that it would be better to actually get rid of
"sockptr_t optval, unsigned int optlen" ENTIRELY, and replace that
with iov_iter and just make networking bite the bullet and do the
RightThing(tm).

In fact, to make it *really* typesafe, it might be a good idea to wrap
the iov_iter in another struct, something like

   typedef struct sockopt {
        struct iov_iter iter;
   } sockopt_t;

and make the networking functions make the typing very clear, and end
up with an interface something like

   int do_tcp_setsockopt(struct sock *sk,
                     int level, int optname,
                     sockopt_t *val);

where that "sockopt_t *val" replaces not just the "sockptr_t optval",
but also the "unsigned int optlen" thing.

And no, I didn't look at how much churn that would be. Probably a lot.
Maybe more than people are willing to do - even if I think some of it
could be automated with coccinelle or whatever.

                Linus

