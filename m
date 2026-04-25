Return-Path: <linux-rdma+bounces-19548-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ytCYM1cq7WlugQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19548-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 22:55:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 136F2467AC6
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77CAF300B10F
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71730C60D;
	Sat, 25 Apr 2026 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLb8EjkI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B9223DE7
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777150547; cv=pass; b=WzOg73fgSoyu8+8gKkrN2pI6KOOKDWIL6XGjhab1aAa65ww52SaF4e8uwT3mloeXu5G4GC67cHbaN2HnksH5bjOhH25UrzP8deiYE2SL4MltuN7i2+MHb1ScpfsQn+41fR2pL9q8vhFO85GUV37nVrUL49BHfIha8OBUIFNkUjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777150547; c=relaxed/simple;
	bh=zCdeAt7nHNpD8gmKmQvShlexi8G7S/UGDpzYzhKhmLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZLRB2kqXQcxqU/NZ/GNLexGX6sTTHmpl+I+vAX0DJpe/yUqfh3tAGU0+u9vyG1m20X7++qkUZEtJ73M9CCdASyf5XtjdxPv+uux7cBlXogK34vUld6Bjs9/9GQW7t4uabrnLqX7Qmocpv/MANJRqoq3koH2L9f9BcSNK7H9914=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLb8EjkI; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso1943195c88.0
        for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 13:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777150545; cv=none;
        d=google.com; s=arc-20240605;
        b=VH7nzjY6B6io+7Xzo6E74kDCId7+SUulv+vRZdpYzf5OJEBKYil5hOuGFxWZZ9XxXz
         KepAy4t+IGj9o+Sf5C4hWlr23kM2hTTioZNtxNks3odNvjf54JWKFZ4cDqZKkTVncAk0
         cyazDrXJEPC0UQhfd3fnQA4tdapgiuG1DVGp4ChdZz6BYYOt1V6VpkJ5LAB3xtUZBum1
         J+zCKJ+TaaTopoUxsS/y5dbA8uaUJO6bbmktXeoeCkgUqugxvvhn+AU9fOWEDCLHOSwO
         t2RwXiL7tlL4x0yI4s6B9aVl5i8e9zDSYjz591+CpzA2L5zBjbThCozU9WxKG3XKJBCU
         nQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5W+y77A2u9e9fTbEv0Xso8k8+rmTufsn3HnrtSSRQ/o=;
        fh=ZcDLKsYv793zblduPDxa/ZDUmZDhkYEYwG1uTyLcz0c=;
        b=RFAXtp1U62jGve0TnKjmM9IKMPTfdlqY3QxoiJewBRcs75NjDyREcL7Foe4KMYdoo4
         G4aJNPkoz1uYJPLDiAB6Y1XWyNu+cuJGTx/b4B4vgmBjjvJP6rWYp54qSrl9b3H2vDGO
         kdSmVKHzesd/mwrmHQyYVAH2wwo05juPyodnRzejheO8jwM8MshsY2reLT+oY9RfSpsH
         Gpepi2tAsIM7dUHUTdkjHFi0s1gvPAEo0KK9Us/b6iYEqY2hPZFW93hhNjtJsk9UK/5F
         NlmBk7eDeZJRy0O5hYUMvw4BJVpish37ZGOMQOokPQMvLWaKvc7J2e+RMwXjw0kFvreb
         rjHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777150545; x=1777755345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W+y77A2u9e9fTbEv0Xso8k8+rmTufsn3HnrtSSRQ/o=;
        b=fLb8EjkIpdoBlhllvavT9lcMfhcgJdBHMpz5Xp8kePG7a3A/nMBd4DMenuks+wJS3m
         r565VmUWl3/LDxj4LKdXS3XLiOWpYXcEfTJHOk+HtH61YZQ35LxuMdCZeRh79LaFAWPL
         eshbbTWILSNgW31wk/TOSmklufRh9dVtUXJpslBEJyxULJdlXC9Up4K1UMyPNR52BvI1
         PZpmMclb7BJU4k/Lu8RDcO8pHCCTPjOB6EV93ZUSeQ+0Ya3NZQ/4IXsjxkBqfuH0BpYn
         ucXdI7NIFDf6xPYWB6h2ZzlyUHmLKqF6tCqF1292ObrqESyGk5QS+fsyPQ+NI98Wcttj
         bYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777150545; x=1777755345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5W+y77A2u9e9fTbEv0Xso8k8+rmTufsn3HnrtSSRQ/o=;
        b=WHrpJNX8IypxqshHaJr2a5ye/ZGHn4r1M/9rBA5dvHBqQ5bDiqjdIz9rfdQ/iRJdgo
         kxGiIHMkTvj0o77KPqRao7sdONfhj4SyqJ6u5D0iasuVDbDXv8YdmBVHX6DnO/1HpdsJ
         c/FFufUPu/JiMoWap4ICgh8LdnXJ3ufMpUluu9/0jeJ0ESZPWj+hedO1g7iZS+Ao+PuM
         VS8xFIuOvRV9n8aEMK3btN7N9N4XRGLW/wCcJff0HgPDHjD8ZYYsl6c+jIH5JGjxu3wZ
         ITUtbnR3XA50wribECWq/MIkP3IqQk5wa/LFGsSPb6iIO1FlqRplBeImh/vYyupdNX+x
         kAUw==
X-Forwarded-Encrypted: i=1; AFNElJ+a3G4YPq4IFCnsYGgC6LHpSaut7zBr/+BVNFQhDsDITS/F3mV9/R6jPsrcR1jqWpXHYfD9+F6Lbr/C@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5E8kbw+8XgcafPOfos4UMVwXiyPW/8Wj7iWqBbIlTbqCFTxZ
	sClXCQ6WLyJ/2GZJ0iiXtPjl3eexyMkMCjopw1foGkL0s49OC/ToHUrjO6dsJdC8WqmuKzK2RaG
	qvGkNNGuryWdE4Ma+xRG76Aam4uPX1+tROom40gEv
X-Gm-Gg: AeBDietZt68q+f8p8QfqjYIlyzXBss1Xu+7Irtc9wjVm4xvrfsi4rkiOxJxmuoxyVJw
	3ycP5Xqfw/rYAbeiu9AAeY7c8mcKwDeUI+23uKCawcaMttHBhJ9fw0Mgiww3dM+83fg3Enwij4u
	/AxVmwWUO/3tlpkB3ov6m0vRP6FsAJVxKoSyz+vUDCTpoeS9s/Pr5AgxmaNMdEH6j+PwamPWrtu
	IlWoxT1QhKIxyJOAho3rck3iRK6xfWTInwvqqwU8WaEZZRt/dswF8RZPydCPBK3W9tPyleQEcbX
	i9cJvfjNhuSjdvs8hyTFVHWwJhrtbAxyJ6/vfr4L5KzyzCwTKWnWVzHJQJlDKD2YQ2tkeWvjOQ/
	iVcfYhWFMZxq52YomNg83Dif9fToB0Wk6qxaQ7AOkF2AtsbVhtaBszMsRvKNbGuLR6qgJw+k3
X-Received: by 2002:a05:7022:6728:b0:12b:ec67:3529 with SMTP id
 a92af1059eb24-12c73f781e0mr20543907c88.14.1777150544937; Sat, 25 Apr 2026
 13:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425060436.2316620-1-kuniyu@google.com> <20260425060436.2316620-2-kuniyu@google.com>
 <35659770-6046-45c3-8714-c6d5bb140978@kernel.org>
In-Reply-To: <35659770-6046-45c3-8714-c6d5bb140978@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 25 Apr 2026 13:55:33 -0700
X-Gm-Features: AQROBzAd5072zmHWl8nycRYHd0eZBr9hRnaN3PpKSrFDJP0lV1mFlFib1FXYjuk
Message-ID: <CAAVpQUCrUkng8fDQYRT0c37gvUw8HiD7Lkowv_pk9cYrG7YdQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
To: David Ahern <dsahern@kernel.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 136F2467AC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19548-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, Apr 25, 2026 at 8:47=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 4/25/26 12:04 AM, Kuniyuki Iwashima wrote:
> > syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
> >
> > The problem is ->newlink() and ->dellink() can be called
> > concurrently with no synchronisation, leading sk leak or
> > double free, etc.
>
> My expectation is that the synchronization is managed by:
>
> rdma_nl_rcv_msg()
>     down_read(&rdma_nl_types[index].sem);
>
> as the RTNL equivalent.

but down_read() is a shared lock and does not work as
per-netns exclusive locking.


>
> >
> > We defer UDP tunnel allocation to the first device creation,
> > but this would requrie per-netns locking.
>
> typo: s/requrie/require/

Will fix.

Thanks

