Return-Path: <linux-rdma+bounces-19617-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCZZGd4E8GlmNQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19617-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 02:52:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2947C3FC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 02:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17072302AE2E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 00:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A5282F2B;
	Tue, 28 Apr 2026 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOA7IsWY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A11263F44
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337562; cv=pass; b=NW0FeEe28MDATJ+tcC4hWSOHELzMWdRKv+N/Ky2TTjxTnHSMo9QH9ZK7PsDWT3o1ekAXKXDHc5kXEI/TeNZJr7tgpcJNZsgII41SamDaF5vfuT5BDMJiXKFntFBA71Efe7g24YKVfd1ggv8afSUk2Tb66yqAdob2NJJ256B/Eas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337562; c=relaxed/simple;
	bh=5JkfTqOC1eL7CG4shOxBzTcNRP+YcDINzm7NZMO6slA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVNQUDPBOPOISqN3+pCs2GIbDwccZU4Kok6isYUuxuhhCKJ0Q47Nk3cOH/e9uh090fxaTjw5R39Jt4iglI79d5okQtJRjIbyb6kIW9+ggdngaVB5rPktZeuAclxBnqHIdNJaMQAqJBBF/kpVAFMpVdJcFijcy1Gcs2tsvfWi7Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOA7IsWY; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c1a170a50so13671139c88.0
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 17:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777337558; cv=none;
        d=google.com; s=arc-20240605;
        b=ANfFpjXJmZ5BvGOc+iPa/5v/USQ45GgAQ8jBcJbX6AI5cszc0iQZRjLEqE/NHbGo5E
         BThp/2PBChpV7UplCkXgnvUsQ0UBSx35gcN3LbxVpyt1vkTGWRGr4W+iRT7/3atUIyiJ
         kOTlnjIJr3AH0c3ZhB5tiqxxQ7oWysxLG1KDbEwGzlzy9W0fY3ws9OulpZzLtySt7UGG
         iSqd89RqzIJhk0/Ij35aDTqLyMZCVXk2oCih1R1HmoIMhyP8n+nZ/ypV/HLODf01xR/5
         Gun+Ts/W+59yXJwZb2vkWM6f8FYnSWt2ADe776XV41StKrsj7UZtiVsk5F//fqQuKJlL
         ftNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1faFDeHdeNPVgHqyxnrjjHpukx7+JZjn6z+tE9Gsjw=;
        fh=DGYM3CMUIK8wrYCNLpdmwIG3fg9HI8KiCNFgkIuiq48=;
        b=L8Cw6uafDVwcAWChzccLGr3qd3yyVT8BbTj4Pd3HpGMFdOwpjvnAks7ZT4wqhKb8B7
         vPloqPjcLRDYGE6hcG2ulUbrEe16L/Mms+l7GQirPZXFMikl9imS7o+hJgTndvaECbxM
         STRW6sHSxDgqwPDxyFaVfYJtFVhq/5NWWfu9OTw8yDr471cuCRIMkUYuBixBO9qEgZX2
         gKeqMA2LyLfEE0vTbiBvqEoAHIuxwNskIJ8Ye/RAcb1LQC8mGluON9s7pNGB14aFbZ7s
         xMP+CJ5D79pXZwlOeknYEXwCeMKWb5oquV/+JuoSctpkal/kut0qq0A0IS6d8YnPk0a1
         ws2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777337558; x=1777942358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1faFDeHdeNPVgHqyxnrjjHpukx7+JZjn6z+tE9Gsjw=;
        b=EOA7IsWYHAUjwg1KZE4URxrlvtF81jSxhEyzIaKsYgADQKb5ynRsUka2Uco5gcgRIo
         VC2W4mR8UtQ3/wu5/bqu4lH9op54vd+5R54vJ02vLADB7kBUtb3obkOyj9ggS6Ll+5sz
         WvbDFgcnDSdn0WkvichPDoZY6AbucbjuRQgpQ6bI86ggPS8AYibkeJakjxjPyFsFFQyv
         z3nmZBaHPLnXFSLIN4eoAdHFUjFKjDnBgZECY+n6YsQUxJ/9hxJGNgpS2h+vJrpai99L
         lJ6Mx3clJAMAV9iCOvktBBtyb20o+rrkPIOQSTh2Mk/iqHFLuQZZu8geUxgCgwNxvNWB
         QaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777337558; x=1777942358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1faFDeHdeNPVgHqyxnrjjHpukx7+JZjn6z+tE9Gsjw=;
        b=tC03bmilkXl4mtaYuqMzgnJqIhau8Uir2MvVo2bZXRC6abtJfJicY2+cxP/HDX7Emg
         Mpb4SSMaO0MJqracqMYPGEyz68FN4H1CJgZCdO3z/9P406Oq5q3+/4smYQHys8CB9c0C
         iZHgXjxPfzNdVXIcXMF2pFk5X4+7ZjV77lhCzba55OmfvyxvzCE/3QPsbVsxP7xAzU0a
         nB1vLuayLmaMIygM5l0u8uwJ7KGsJqGR+O9IitzWtMwa83mqO+53qKtTI/vvIGNPOBYJ
         99sO+uwShppzWPgTE84Ym+Wr+IOksRgVNzCvUuz3grFsC4bMXosathTd29aUCLETWsBV
         c9TQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yRoNDqlOhFfQ2ePKNpipyMw+ZqMV8j+OyE4/TmDOMa0QIMaNotv0b0P9n0eiaKysDPhlKQuXNAeE4@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGQ9LMx9I5p+ShUQDXt+Wwfq5u7VBU/npI/2IMzk+QGZwqEa8
	7yT1fxnRCymxeAxl3yScNMsh4J11eLwWvNc7akI3IK50NqsZ5lONLow+0xv6jS03WKNuJGocN+G
	ElmdAcVfVN+y14ohoI2+FmkmkXuta/3nSLb7t6ClJKGOMxcWfE6LdhEAM
X-Gm-Gg: AeBDieu6Ic5hOG1J7bc/jKexMhxz3pxXAID6tXlNPGgcuRtrGtum0sL5XEKwdlE7zdb
	el4pE+GtBy2E4Gl5XeLIElhCQchot/XlgrX1S7mLHlJgWik/7+Q6Q/NIhqHdZ67iDP/r0ZqDZkq
	+W/hsi/omETIqOd0t3I4G7Z33LnZpjqYjeIUCrsmE1TLj2jiUf6XzZom07Sia9DJRiOfUo3cNW3
	DATvotEmNPXzcUaGsBcY4m+QBR0sa+wFbYbKAKkBPeNPY6wt3CE7C24bMMmKllxC0cDa8vyuYW2
	bgcTDTShvQZp5t9gjoyPTwljmz6pMgEZK6zum5kLF3G5A7FyHdSqp2tK3N+dnEeVcQ97QyIsBMS
	hxeE+fsLR2pv0SoZhGZiijePbge1KEpHU9iIngs5h1q3vOzBvaz0=
X-Received: by 2002:a05:7022:2385:b0:12c:8b9:71d9 with SMTP id
 a92af1059eb24-12ddd9b5758mr471711c88.27.1777337557728; Mon, 27 Apr 2026
 17:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425060436.2316620-1-kuniyu@google.com> <20260425060436.2316620-2-kuniyu@google.com>
 <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev> <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
 <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev> <CAAVpQUAh2KT=YpfDO5nkqrzH0kbAXEBVe6jtOtLc93wjs3N7Fg@mail.gmail.com>
 <e2e1406f-8d9d-4a96-949d-e75096446d1a@linux.dev> <9681c9e2-79a9-4d72-b1ad-229ba6d7aab7@kernel.org>
 <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev>
In-Reply-To: <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Apr 2026 17:52:26 -0700
X-Gm-Features: AVHnY4L1a3uwSiV0pmrDsNd68lhv3BqXs6Ej5PQplq73ANZHBWH6C1MLElQqZe0
Message-ID: <CAAVpQUDVb4VDibeXz-DmAHF7gOAvDenSTGA6DpEwwS5HaQjM5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-rdma@vger.kernel.org, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B5E2947C3FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19617-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 1:20=E2=80=AFPM yanjun.zhu <yanjun.zhu@linux.dev> w=
rote:
>
> On 4/27/26 7:38 AM, David Ahern wrote:
> > On 4/26/26 9:53 PM, Zhu Yanjun wrote:
> >>> That said, I don't have a strong preference, so up to you
> >>> maintainers.  Simple lockless solution vs per-newlink/dellink
> >>> locking.
> >> To be honest, I do not have a strong preference here, though
> >>
> >> I lean slightly toward the per-newlink/dellink locking approach.
> >>
> >> Both the simple lockless solution and the locking approach seem
> >>
> >> reasonable, depending on whether we prioritize simplicity or
> >>
> >> explicit synchronization and lifecycle clarity.
> >>
> >> It would be helpful to get feedback from David Ahern, Leon,
> >>
> >> and Jason to converge on a final direction.
> >
> >
> > Going in circles. I have said from the beginning of network namespace
> > support for rxe do not open the port until first rxe device create and
> > once opened leave it open. Simple design that limits socket churn to
> > users wanting to leverage rxe in a network namespace. Zhu Yanjun, if yo=
u
> > are going to be a maintainer of a feature you need to have a consistent
> > stance on the architecture and code design.
>
> Thanks for the clarification =E2=80=94 I see your point about keeping the=
 design
> simple and avoiding unnecessary socket churn.
>
> I agree that deferring the port open until the first RXE device is
> created, and keeping it open afterwards, provides a cleaner and more
> predictable model. It also better scopes the overhead to users who
> actually rely on RXE within a network namespace.
>
> My earlier responses were not consistent, and that=E2=80=99s on me. I was
> exploring different approaches, but I understand that as a maintainer I
> need to converge on a clear and stable architectural direction.
>
> Unless there are strong objections, I will align the implementation with
> this model and make sure the behavior is consistent across the code
> paths. I=E2=80=99ll also revisit the current patches to ensure they follo=
w this
> design principle.
>
> Please let me know if there are additional constraints or edge cases I
> should consider.
>
> @Kuniyuki Iwashima, Please follow the per-newlink/dellink locking
> approach. Thanks a lot.

To be clear, you meant implementing David' idea, right ?
I'm asking because dellink won't need locking then.

