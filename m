Return-Path: <linux-rdma+bounces-18904-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABGwOWhPzWkWbwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18904-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:01:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82F37E515
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F13D13282174
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4F3CCFD8;
	Wed,  1 Apr 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M2H1yK1s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232A369204
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061215; cv=none; b=k5EjfXkkmWHhX8bGjxN4CEbg02B9pl+OqVNgy4tuiMqilkrTVf6kUygcimrkr76+eIVDqKlMsdXrZ1G8PD7Nm6NnKeQzBqpR8hCQZV5PUG44V0Jt/SGgKpbw4GQcZa/wL/zCeUPIsxXTqR/G2s6CWFJ+vAxZDKE46gCjdPU2000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061215; c=relaxed/simple;
	bh=ybEdMnj+IV21R50M/Nq06VgnFb302XMUbdzsNI1SGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCXuyEK7LJxkRpj3tD/EltXAEijn1UrQMmT0W9pE1YL/U5qKprQquivqoxIivq9OtHbLWmdOWhcuHtVr/1zbpgsmA/gp2V8uPv6bwq3bTuFJE5Rslc7q4l56bcvF00CyG8w/Ppbm6r/0mhHnEzGD7QYDGnmQ6SxZEObZreF+U08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M2H1yK1s; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1280914166b.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775061211; x=1775666011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=M2H1yK1sY4mSPGUGlxaceoQPYZEMWFnEH/b7eSzMs5khiByFRw54aKKYJR3kA0FCCK
         LqXh0OFLAPuoln3qF9iiY/AL5REc0yoaRvpOnIpO1dn3rQQ/aY/gQrPAKXaD42MJP6eS
         2WHKE1DiF26zecnf03RKaD7On1mfmtfW5a5t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061211; x=1775666011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=qIUEtf1zjZShHeqNI3t4/yqTDiR+8PQmiB/+Gd70IUKHNLgCllasvOllFxtu/iOOd1
         wQNzau5Jol4mV4apoHHOWdU+XVj6I0rAEGEZ7iiuf+5LGzXKXCQfRHkKgP1l0FM6RBDX
         rkOYdLEVO+7CuIyRG2v1FyxPO6z9SebSCox1/YhiyxKwzG+KHIBc728NJo1PJ4heq1d3
         Cq0hPC6QagQFzNXQNnKtr4bgqiha2jDC3itiHVJTtLLi/4rUa8kTKDTDzMbqvMwiyFxl
         waFZmIIuU0lEzoxf+Sgn/kUcCmuyVPCapSzj9EIIFl1U0dFZsraoEv8ry0zs8yJInUpF
         bmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHCxrBmt6PXshFvppkysXMQU08/X8fLqv4GmlzBxHfK0L2VvFb3ScaXdMJMYjC+FJh2SKNq/87E7kn@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/MewVPiMgcs08G7vC+ie+4omWCY0K14ihpCy11njFsF1rA2a
	lxvriZysWmiLONLnF58/1lWRk8wcvgU0jhxijTAo7c+doq0h3i7GwR/8HTxsjY7cAdgq0KWuu0o
	BD/GUovSZpA==
X-Gm-Gg: ATEYQzyf3QpFnLGu7uK/tJglV/wG9EIdvB4wNQdkYQfzCleWCuTV/EHVsQVhjlH9573
	cyboFe8Ab2nYJBxYTOnCR2523us1ctABUQvP2SG4YG+v7TrhjGNbxHT5kNNM/RMOSPJcP4ZCAsL
	haJVN+jXmmETs9k3T5IPgXfYG1YMDuSJqti4R/ko6mtLkcx811XTW51QNyCFHqUgG/eMnzad5oy
	8RsO/KFe9fKHiD/0SWtEH2fHAtrNWXrid9b4nq3mShPUtkUJlfyu4+PinzEdwCcPq0f1ivvsQiE
	d1Ve1VIw4obQRXRI+32cV5wSoL0nFPclrX3EjPCg4QKJ/1f6AMvmTubeoOA3sieuMDUKLJ72RBH
	sfcLHhdsBv6fdARuLzey87L81PovddCusTuS0s9j5flbPANxAP51f4UGiah5+8ZxtaYvwhb8vxv
	aSMKaE/zbEFc8CteBh32FbqLJDPldep/cabprXy39Nx0PAKikQXuvKwyJ6oZ9PvDOZtYDTMyn+
X-Received: by 2002:a17:906:208f:b0:b87:965:9079 with SMTP id a640c23a62f3a-b9c1379e1e0mr229705466b.3.1775061211275;
        Wed, 01 Apr 2026 09:33:31 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c97209csm6280966b.12.2026.04.01.09.33.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:33:31 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1280912366b.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 09:33:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7I+zL6BZ156NlYDiL49FZe6GDAfVHxkFYKTNFgXQ2uuoHwxiakD9gjvHWffI1Wu6bzEM1dBtrb+Cj@vger.kernel.org
X-Received: by 2002:a05:6402:35d0:b0:663:4315:7271 with SMTP id
 4fb4d7f45d1cf-66db0cfbdaamr2927572a12.23.1775060766098; Wed, 01 Apr 2026
 09:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
 <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
 <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org> <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <20260401080657.70cd9bd1@phoenix.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Apr 2026 09:25:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
X-Gm-Features: AQROBzBuhMzLrgonz6WGspEvkWFhuj-ddiDGEYTFKbMu2F_LUT3de-t_k_EwsPU
Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, Kees Cook <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18904-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[infradead.org,google.com,nvidia.com,kernel.org,lunn.ch,davemloft.net,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EB82F37E515
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 at 08:07, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 01 Apr 2026 10:28:23 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > Maybe on this date next year, we could make it not possible to build
> > the kernel *without* IPv6... ?
>
> There are some government agencies that used to require that IPV6 was disabled
> for security reasons. Yes they had broken old firewalls

I think you missed the big clue here. "This date".

Sigh. It's going to be a long long day.

              Linus

