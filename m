Return-Path: <linux-rdma+bounces-17547-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FaHGRyzqWkZCwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17547-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 17:45:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C310F2158A9
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F213302514D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF45B3D6CA4;
	Thu,  5 Mar 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C/P3Pu3o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD423822A3
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729090; cv=none; b=tdxl3QhBB31QxW4jmEE9N/UAcQTBAChUL8l/YaEattM9nCrITnoh847IthFBaopOY4xA09C87vbrO3+dXyBeiI6snBbTMkW0/QZBJemPQ8TVI+hY5TrMqGPNO+llDGNtHLFMnmEy1TOHiiHlJyvplXFz2ZwuSjWrWey36P6Y6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729090; c=relaxed/simple;
	bh=DGtBdnbXZRg/j9yf/YqPta0iYnexB51IFud7cHPTG9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9GTuR4Sgmvsh9yJpvVawch1S707UvlFfWcNK7seqWzFHmM0rnQYfwr0wnHA+mJ27Vll1Q+INWGWhhI5pkKPDivTtqhNq8U/qDtbThbsvWRh0XeeFnPTU8VEiOWO71lmj+FlYEeysbcwSFi8lXZhPkrVgd2COd7oLH8YCyEu7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C/P3Pu3o; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so1059283a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772729084; x=1773333884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eNHfHsjGinUs8vAecQM39SD2K85CJrqw6vaptjuUYBM=;
        b=C/P3Pu3oKyMGyo5GRbnhV5eNnrbnPewMa6oHQVBlKSSVZNmQZoDQ0CvNkBma8e4Lod
         WRoZEklhBsc9vMRzc3RZ5vuCTxcqcWpDEB7/PAvVkNrHhhSJZFQOSeU/FuSwHaw9Dhxe
         VlBtg+DJaMlbNa0yIQn6moggDsVJRpjghGv+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729084; x=1773333884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNHfHsjGinUs8vAecQM39SD2K85CJrqw6vaptjuUYBM=;
        b=jLIKCKs9kMAfQfBSF5f1detRBTvVOFBKi4nRmScpz/o8yHwF6a9BKPjMiMMdylOYS5
         ouZbHaxEj8aBI2jILIhaiKZnWS5eKxVMv/9ys0SKDTu990YbZIXgdv9lVjKtNlF/i9hc
         Ex/QbVlMYj91Olh3OR3LQLGQSfIZsIqDnXC0UaRcMEa11bdIBM0GwWqQtJlsIaCr4zND
         CFbSE9COJRTcvbD3N/w+pCZVXN9hmsOUUkGfN+5ODl9E4uxwM+XSe7fXBaoEIJ7Gcb1a
         Aj9Pu1JPDdQgu2R7LLX2ysLtLVpbmt9+BL5grKLjAh5KLjzfV8iezToOC9d3EBcCan8j
         AzLw==
X-Forwarded-Encrypted: i=1; AJvYcCXn37d7upNXlSN9hYnd99f7GoD/D6f/WxpqDmPrORmDx8eL3bEIu3k+ZNZc1AGwb2dKM3wp3p+WIgQN@vger.kernel.org
X-Gm-Message-State: AOJu0YyFeAoWBpbzDEMN8JWU8bzpzDhLeiSrmi4vxHs/W9YlsTcajIwL
	IGseSL2xiDFnaZqskQvTg+3RltIPCv11/2HiU1jNVJt/cLxnEbYue68VQq1UlXkp33oWBmrJr1o
	D6cV/lF8=
X-Gm-Gg: ATEYQzzWWVvEOWHl4AD7EonJAoXTQT8Yxc5kNuMHVCP1q9VaA62fCvyoJyLTGLZxPh7
	tMddjsyuM2b1WI1KDqvGrbVCc82DAHjsoTmA4Fxiy/fMwxM7Cv/FCrqzEOlnmG2n/y24pGHVZIw
	9BM4gCx9DAnW24QD02p82NKSXEF0LgII+FTweknPqWww1AI4+6nG9o3SiRztrbiMhnslMgywuj3
	X+gN1oRmshOjdAPOe7Taz+CkohmTcdmjytIHAfHW8BuDiYuUtmknCXSk/CC6j7CgHGqK5D01KJ9
	Gg8n+b87EegNuxbvOJLL/kHb2+TIYxKMGkyfkwvoW10ta+zjI0rR0/57oXggqiDIOdpf1hpytZM
	PDm9ufGZ1jBIjQDcvEnh0T79p5QzszzjM7Zw05OaE0w7ZNWMvMV4kajrO6xO7rCVrDsTsjkVfxd
	j+OnVgelOFlcqBO6DX00TOE1qxljbu2U9SluO3L/klWpqm/akOyFJWsU8sWHI+/ukgCwY/dH3R
X-Received: by 2002:a05:6402:50ce:b0:659:31af:b9af with SMTP id 4fb4d7f45d1cf-661415a4f29mr1774679a12.0.1772729084532;
        Thu, 05 Mar 2026 08:44:44 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-660e793b7d4sm2312678a12.7.2026.03.05.08.44.44
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 08:44:44 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9423d62cbbso1068066b.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 08:44:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1mj1HNACgSy5RnY50Bt2jo6YYtXaXAEyxaYqH/ac7pLc1EDresaG6vsnOhueD8tsZeNveIBRVAGMx@vger.kernel.org
X-Received: by 2002:a17:907:e10d:b0:b94:82e:55e7 with SMTP id
 a640c23a62f3a-b9409e75c5dmr122626266b.25.1772729083811; Thu, 05 Mar 2026
 08:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305103941.11f1b27d@gandalf.local.home>
In-Reply-To: <20260305103941.11f1b27d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Mar 2026 08:44:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
X-Gm-Features: AaiRm537Jv2IcupKWNVngREUNm8d0KvSSjwd0obOsEpercpOSBsTAHZ8PEtbhj4
Message-ID: <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for 7.0
To: Steven Rostedt <rostedt@goodmis.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Huiwen He <hehuiwen@kylinos.cn>, Jerome Marchand <jmarchan@redhat.com>, 
	Qing Wang <wangqing7171@gmail.com>, Shengming Hu <hu.shengming@zte.com.cn>, 
	Linux-MM <linux-mm@kvack.org>, linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C310F2158A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17547-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[kernel.org,efficios.com,kylinos.cn,redhat.com,gmail.com,zte.com.cn,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,goodmis.org:email]
X-Rspamd-Action: no action

[ Adding linux-mm and the rdma people ]

On Thu, 5 Mar 2026 at 07:39, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Fix accounting of the memory mapped ring buffer on fork
>
>   Memory mapping the ftrace ring buffer sets the vm_flags to DONTCOPY. But
>   this does not prevent the application from calling madvise(MADVISE_DOFORK).

I wonder how many other things have this assumption.

Now, many (most?) of the VM_DONTCOPY users set VM_IO too, because the
most common reason they don't want to be copied is that it's a special
mapping.

And then madvise() does nothing.

But I also get the feeling that the whole *reason* for MADV_DOFORK
existing in the first place simply doesn't exist any more.

It was added two decades ago when as a hack for the rdma people who
wanted to mix fork (with COW) and concurrent DMA, which just didn't
work reliably because the COW would break either way.

See commit f822566165dd ("[PATCH] madvise MADV_DONTFORK/MADV_DOFORK").

And that should just not be an issue any more thanks to how it's now
done with page pinning rather than with the old GUP interfaces.

So while I've pulled the tracing fix, I get the feeling that people
should at least think about just making MADV_{DO,DONT}FORK go away.

Now, Debian code search does show some users (libfabric, libibverbs),
and maybe they actually want the forking behavior for other reasons
too.

But I get the feeling that maybe we should at least limit MADV_DOFORK
only to the case where the *source* of the DONTFORK was the user, not
some kernel mapping.

                  Linus

