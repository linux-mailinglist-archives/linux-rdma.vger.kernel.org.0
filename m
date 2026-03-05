Return-Path: <linux-rdma+bounces-17556-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CYtIEq8qWnNDQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17556-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:24:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D75AC21620B
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2594C30659D4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3907D3E1226;
	Thu,  5 Mar 2026 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JfPh9ra7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86B3DBD6D
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731080; cv=none; b=n+YnfrHwBd3PEDa69289CHE8NpXOKD5xL77T/c5unuMyXHij4baTCcRUPq1H0jiJs8vuP+Z2JrGLQEMkbyhuQynB0rRHNGfKdHU4uvQ08Mkcfbi4aC60GaovlSqp8BWI0TMwrO0T50f4D4q9sGrGfTng9SoBTz2KJmp+zl/eB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731080; c=relaxed/simple;
	bh=3inKJ12YWmkFknPfDmB1PqO7w/MTNZuU8h9lIxmJeQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAgydmYoBnlHmmfDv/5lY4XzJXGUhvRvaTQRKKkodRZiaXBgV1CXrHjpn1zU18Wf4Zodqs7rzuOq17+UEPCWqBjG7rauuLC/CWEcBBmU+IWSmh2eMgLCINT2ToDvBFoC18aORFAgqP7RBYp8NF3tvt0iW5XThGnmWAP1FlaaUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JfPh9ra7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so1298063a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772731076; x=1773335876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RlUx0Q3mIemdGHzrjkfKl0zTwu1Q2a/1NFXe9PhCvmM=;
        b=JfPh9ra7I3A9zP6zrj8bpR531x6NZ1WQfqvuBN/mCo30+9ZSttW5xIb3KEqkTJ5A3h
         m0luSViHlWRXltC9aIfthw9fnddcmcB4i088yPU6NqrJA5PZSvF6j/UhstGMBmIc4IA1
         3Lkw3mA+BF9cnNWVKjbJxZd5KwHJzaP1ab7U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772731076; x=1773335876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlUx0Q3mIemdGHzrjkfKl0zTwu1Q2a/1NFXe9PhCvmM=;
        b=Jsw1dWchJUBN9Rnivg3f9bN+4woOwHWcx2Exe91MocQMNyiAXo8aHMtN7g7XkiLI0J
         eR+UaiZo28aSjUY1Yzs5WvyTUNTOcvAyJjKCWl5L96D6ESSfBbzR3BKns5YpGIdducjA
         y8t6EexC0ZpT3xm4P9bT8YpFySfMluBoeI/8cLiQ6S3IpWnxN9qBLuWHFFqLfSfsePeh
         MMS/GDF/1iWFEYaP7do27jwdNC3qfS6B7J19hpNCLBRMhs9d0vDLALRhFkaYKAIwDSM+
         cYoSaAWGDZAhssdQKp8C6bWSD90C7Tp6QGmTu2wM5hrIuXKorNp8UEa53o3n5PWLxCHD
         wgWw==
X-Forwarded-Encrypted: i=1; AJvYcCU02xt2UABAkDp7ROIdBhRCJGRYm3zPkZUbR8of/syZn3djMrejzQto+rR++fmuP+7XfKFd1qe6cwDm@vger.kernel.org
X-Gm-Message-State: AOJu0YwExdP9szHMXKXsi2GvJB2Xj4OtUuo+i2YkBS5+tTgxWjqLm5AT
	gjiA5qB7cR388sQmcf+rnkUCuVNh4U2D9IOFsXDd28BKFw0GjEFu9LgyREod0FmcEjHScM+lX9J
	ekJBBy9w=
X-Gm-Gg: ATEYQzz21bU8aIU4zQKnXJQV7hurL98r7/VFks/AdvGVQ9IYMNKVL13GCBhkLBDgQ+k
	fBu70lAqpDS1eoDyL2lL47/loCUp3wO4547wy0tjmPEXzo/kdvh3tgr6pRfQ/+AZdrJS4JVH8a2
	NJyTgE5uTnY+bELzR333/jzXBmHPpBGlVgPz+DB5eiz/H8T4RvL56WkS1H/OkMZngfIMSJz+VvF
	iHdOp6UERolj6yf51AW9Qbh9zsMF1vJnjS4RNMpiFnFMiAEWKngFFE0WEnzeooGw+HQnmr0khOv
	GKOyPrVfEotp6y2KnQiIQZTw0unUsAMj4xU/Hz38w1ivGjHNAf0+d5Ia+cZyWYocp/bNu3PIxB9
	a+3G0hMO9LGKnQd2egzG7tf5GWlsJvTsgCWMSkWGlcoxOpRjEfz0m4fAJvu2l80XM+yRvuIFgLn
	AhVbunLe+ENRMnEeg3qFyqv5FDHXJ0wDMh2pZnmExzSTxOQqe9swQW4lkXUIgbBEsCgLpYgkHA
X-Received: by 2002:a05:6402:5205:b0:65f:8207:7aad with SMTP id 4fb4d7f45d1cf-660eed592a9mr3698508a12.0.1772731076382;
        Thu, 05 Mar 2026 09:17:56 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-660a0b46573sm3642968a12.4.2026.03.05.09.17.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 09:17:56 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6610bd5f322so3238187a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:17:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbabbnbPF2zQCAvxTwIOcB70KyuyTq5lP6RNIcd3vp9W8DmjX3C8BdhYLkqCXQeflDU9Sgk4vgxJHX@vger.kernel.org
X-Received: by 2002:a17:907:da8:b0:b90:e20b:acb9 with SMTP id
 a640c23a62f3a-b93f0ed492amr449349666b.0.1772731075073; Thu, 05 Mar 2026
 09:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305103941.11f1b27d@gandalf.local.home> <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
 <a8907468-d7e9-4727-af28-66d905093230@kernel.org>
In-Reply-To: <a8907468-d7e9-4727-af28-66d905093230@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Mar 2026 09:17:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whW890h4m8r0iYwXEJK=MUJx9nLxuOduttRJNCLrMdz7A@mail.gmail.com>
X-Gm-Features: AaiRm50MziCc2ZpZgfQkRzw_b1J2hORS0ItOZxFqZ_sDR2-NwymgJYJk3iB9XEk
Message-ID: <CAHk-=whW890h4m8r0iYwXEJK=MUJx9nLxuOduttRJNCLrMdz7A@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for 7.0
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Huiwen He <hehuiwen@kylinos.cn>, Jerome Marchand <jmarchan@redhat.com>, 
	Qing Wang <wangqing7171@gmail.com>, Shengming Hu <hu.shengming@zte.com.cn>, 
	Linux-MM <linux-mm@kvack.org>, linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D75AC21620B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[goodmis.org,ziepe.ca,kernel.org,efficios.com,kylinos.cn,redhat.com,gmail.com,zte.com.cn,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17556-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 at 09:00, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> QEMU traditionally sets MADV_DONTFORK on guest RAM. One reason is to
> speed up fork(), because it doesn't need all the guest RAM in fork'ed
> child processes.

Yes, I think the MADV_DONTFORK thing makes sense on its own - more so
than MADV_DOFORK does.

Because it's a very valid thing for user space to do exactly for that
"speed up fork()" case.

It's similar to how we also export a MADV_WIPEONFORK - for a different
use-case, where we don't want the copying behavior (typically because
we want the child to re-create its own set of data: I thin the main
reason tends to be for things like reseeding random number generation
after fork etc).

So it's just MADV_DOFORK I don't particularly like, because it had
pre-existing kernel semantics (the VM_DONTCOPY bit predates the MADV_*
bits by many many years).

Not copying on fork is always safe. But copying something that the
kernel has said "don't copy" just sounds *wrong*.

> > But I get the feeling that maybe we should at least limit MADV_DOFORK
> > only to the case where the *source* of the DONTFORK was the user, not
> > some kernel mapping.
>
> ... that makes sense. Forbid toggling it on something that has
> VM_SPECIAL set, maybe.

Yeah, I think VM_SPECIAL would be a better match than just checking
VM_IO.  At least it would also catch things like that VM_DONTEXPAND,
and PFN mappings.

So just changing the existing VM_IO test to cover all the VM_SPECIAL
bits would be a simple improvement.

Maybe I should just do that and see if anybody even notices (and
revert and re-think if somebody does)

                 Linus

