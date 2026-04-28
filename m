Return-Path: <linux-rdma+bounces-19625-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM/9CydE8GmDQwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19625-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:22:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F1547D86E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EB453026169
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1E2EAD0D;
	Tue, 28 Apr 2026 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+B6ppfm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB371419A4
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353763; cv=pass; b=LW8oQ3Q3pQVaZITEVNYs+dbWX3kfmVNWX8ZT0d2Zhv4WDdvLRhtvVshqYMN3vfVubPLLQv+bpgWFP3CW5TkTQas+teNG896XhuUDsnbZZLgo9gIneiuGsEPZrX1dJBcfgIqOopu+PQxKPZlhF2roqSpU3F+uwCd8OFBoQBQnQa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353763; c=relaxed/simple;
	bh=o1kIm/GEN0Voi4jeHMqAl2BTicBCaMV9d+q2RCSvKBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNrKrmO8bNP5USzsB2liaaCBTB2PDX7gCqR0AOjhzMCa6K/xW5yIzt1DUx7LDO9U7qofDUBoqMyx6Ona4Ghk0H1F+cMfbI0K1fo/jymsq9v1Xvr2obdKps+ivSJ25JBcD/7ls6Y0Ry6CClhN+B8P8L4Y2cvfSWRZZ10yXcaeZFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+B6ppfm; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c45281a06so14980199c88.1
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 22:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777353761; cv=none;
        d=google.com; s=arc-20240605;
        b=HDPqVsJc9OrFFifoACgHG70p7IBWozOAwzjaMHKCEK61sV/+atPHa5D2SLTpTvpoy1
         7kq+dlSecidKutvabmDNJxgz0VG3dA9SkAgj+/vcb+SH79B+d1P8dtg8ufPpj2QkNsj9
         d2+5Dm25lgPFSvZYWJPO/Fj0K00k8R3hq+2DWYeP7V7D9ltRZfF0nxRb7rrggxT3fNfL
         Gx68lBfAz+GPYHtwP+siN1U7wuRxN7bljJ3pExfKBc24kl9S6CgqgtsrIzluKfq+aHue
         y+5kXeTLhqSnc9Xu27jc1bMa2j9qGw5NbpAdHZbtWulmMz2HOE7ohdabj3KgoATMjTUj
         LrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kzEpF/BcWsfDkVXwBhC63bKTyTECILIZ6DTj3ro/JM8=;
        fh=nAQBsBxBUhBHR9CFwebkROazIBk1yzJMGr/MBr2939I=;
        b=BbDtbXlupS66sJ6JyvrmnX/B4YfVn+H7d8l5FEQGbIzc8cAZN591BsomCT4qNujHBN
         wyYE2E2mNUNAzfwvdS65axAPYtZDTg1wChkUZMKtAj3X/hODIxMsa+xGPjlc3+SEx22r
         PtaM0hJWlD11pyhjPNTbpmR3LunjUoGiTyDq63fqET4NysHucIkBJ+nIF76dRRJ3KK+O
         L+i0092KPx6YkzXoJ43CG6eKBjqFEtZK9DYd1uWh3PUJ8MOzou6NIOTcRK450FWQ5S7y
         pm6QHFUAxtUSB+rSVgeGQyclV9fegu6qxC/ALDrpasmGeykCAH/XASarxVuvcIJlVp59
         ukaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777353761; x=1777958561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzEpF/BcWsfDkVXwBhC63bKTyTECILIZ6DTj3ro/JM8=;
        b=G+B6ppfmMRs0SVLPFTnvaPU+pTfSRhYj9x+QgwVH+LOQWszGWfzFE/z+/mf5gIMDBb
         vobH35APs5kfSWjy7pePkokMFFRfCXf3SYDNT7+sQnfWsI9QnVPFiZT9pNttjHXGDLnK
         J6XxmjPoHXT0Bey0cStpUz14IJVE93rsALfWkbpbadp++4qN0tA2cn9el3w3mHJVdvwW
         QiLi5qMCTIq45LPrahTDaotRSLMJYcCweIDWSll0dHriOxmbSOIjsF9Y1zJ0BQL3SjWI
         lJGf6deF5nPXQQw5GImpy71vlx2WH8kIbddzm7rH4aVqJvFLA0uNlKKDP1mAdfdp/dfP
         XIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777353761; x=1777958561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzEpF/BcWsfDkVXwBhC63bKTyTECILIZ6DTj3ro/JM8=;
        b=G+8fOf+kPQXk3sh1SDb/0VubfqRbm8z9vjQrX4c46s602ICizp6FUUk8y0tWCsP2/Y
         u0bWhIDj1VUOF4taX7irDwqPPDhP74cjL54l2jJ79qDFFZMW2Xx6ZahkWdF0s/tLzrsa
         NehAEniz85V2XkDv1Or71VFAgTdmYr/SsRU0q2v05BA7y0U5pa/xqsiGsXpGUCSlBiee
         f0zhTmQK9BLi3BwppFGBnQ0rHa2P06napItAOZdPqQ8ITgYit8YOBxVhens4qAPJiEJU
         p8pYe8bW392hZA0oS2Q6fQgioN3PmFUxMP/ln3Tc1bRwr23TJxZ8FHMMxf1GThshf8fh
         f2Vw==
X-Forwarded-Encrypted: i=1; AFNElJ93F/QOGHxYGqIKVPJz2eNwQI991Oe2zkFru2f3xGphy+bWTcYiKtpZKurGQ5jc1yU4KGUxDx82ag+/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59BxA4YFH9oM1Z6ACyCWoYCaSv+mIAgBss6VcMh336YY5rM3z
	k8ocG27vtvJLyqX2E1ZTzAjrBaKdLK7VkvavjIpSBPfsHpHCCs8IiQch1QBkvOWwoDo7B+8bWQU
	6qkbAUm0xKTA4n55pw8iGHnLUTzZivw2TZNF7JrEw
X-Gm-Gg: AeBDiev8whbNMASGM/PKmMsQmPN7Kd9eb8xNf9amoLwzzFjjpu685BTRpm8WdmCWd48
	8AkBxfm/KbemxFP2xr5noxTbyFWEmeIBdhKXXLWck5quEFoRDEcwSld7s/symwsmod2bUMEH+bC
	WWiBKefhWCcuue0W6/7vobRvZlFRjCi5lRUJ2hbKTpFK96acFb/SRMFbmyPHn/gXsWy+/9pxhpf
	HChiqYqDAVmw83Db1wHZD9eNPVu6ex6Kpwcx1Rlq2Gi4sLs3EoBf7nU2WaJWlEKtxTMBu7tkPie
	pyAbM67Dk1A1s0hPuZ4LrwUBgeW1vRByphqeldzhJ51UR4Uuw54BoA1DVR3cC/RBUqIX9i3lqV+
	Uym+uGDK6zjFwQesC+USL7jXL4NZNzdkeLjdR267daV1g101Ipmi0ZeuLdnQpTpvKbQnrkG0RgA
	==
X-Received: by 2002:a05:7022:6ba2:b0:12b:f8d6:d4bc with SMTP id
 a92af1059eb24-12ddd9b3e46mr747334c88.34.1777353760822; Mon, 27 Apr 2026
 22:22:40 -0700 (PDT)
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
 <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev> <CAAVpQUDVb4VDibeXz-DmAHF7gOAvDenSTGA6DpEwwS5HaQjM5w@mail.gmail.com>
 <0c1258e2-7060-4084-9a07-dd7af8262dec@kernel.org> <0ef2f2e0-e437-4ec9-8ebe-21c702041acb@linux.dev>
 <bbaf583c-2170-41d8-9226-2d4e742f71d1@linux.dev>
In-Reply-To: <bbaf583c-2170-41d8-9226-2d4e742f71d1@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Apr 2026 22:22:29 -0700
X-Gm-Features: AVHnY4Lguf3NitDulOJQOGrEZRLII3MDDDVtP5TiMApSgBF7RMgVfb1BQYsPgAg
Message-ID: <CAAVpQUDVFb5=DNahoRkhv1iM1TYU4_keJEETeLswUx_QFT6G4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-rdma@vger.kernel.org, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 74F1547D86E
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19625-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 10:12=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
>
>
> =E5=9C=A8 2026/4/27 19:15, Zhu Yanjun =E5=86=99=E9=81=93:
> >
> > =E5=9C=A8 2026/4/27 17:58, David Ahern =E5=86=99=E9=81=93:
> >> On 4/27/26 6:52 PM, Kuniyuki Iwashima wrote:
> >>> To be clear, you meant implementing David' idea, right ?
> >>> I'm asking because dellink won't need locking then.
> >> dellink is not needed with my suggestion. It was added to manage
> >> basically a refcount on the socket to close on last rxe delete in the
> >
> > This is my original implementation.
> >
> > @Kuniyuki Iwashima, can you reproduce this problem in your local host o=
r
> > other test environments?

The syzbot does not have a repro, but I think it can be
reproduced by calling newlink and dellink with multiple
threads.

newlink would trigger kmemleak splat while dellink trigger
KASAN splat.


> >
> > If yes, can you make tests after applying the commit in the link:
> > https://patchwork.kernel.org/project/linux-rdma/
> > patch/20260424043522.22901-1-yanjun.zhu@linux.dev/
> >
> > Thanks a lot.
>
> Hi, David && Kuniyuki
>
> I read the call trace again.
>
> If net namespace has already released socket in A thread, then rdma link
> del command is called in B thread to release socket.
>
> So A thread has released socket firstly, then B thread also release socke=
t.
>
> The similar call trace would appear.
>
> The followiing is the explanation to the commit
> https://patchwork.kernel.org/project/linux-rdma/patch/20260424043522.2290=
1-1-yanjun.zhu@linux.dev/
>
> The double-free occurs as follows:
>
> CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
> ---------------------                ---------------------------
> rxe_ns_exit()                        rxe_link_delete() (rdma link del )

If rxe_link_delete() is in progress, it means the user thread is
alive, holding the netns refcount, and rxe_ns_exit() cannot be
called.

So, dellink() never races with rxe_ns_exit(), and it races only
with the concurrent dellink().

And when that occurs, the number of threads is not limited to
two, theoretically triple-free, quad-free, ... are possible.


>     -> sk =3D ns_sk->rxe_sk4               -> sk =3D ns_sk->rxe_sk4
>     -> udp_tunnel_sock_release(sk)
>        [Success: First Free]             -> udp_tunnel_sock_release(sk)
>                                             [Crash: Double Free]
>
> After removing the socket release logic from rxe_ns_exit(), we ensure
> that only the device destruction path (rxe_link_delete) is responsible
> for freeing the tunnel sockets, effectively eliminating the double-free
> problem.
>
> I am not sure if this is the root cause or not.
>
> Please comment.
>
> Thanks a lot.
> Zhu Yanjun
>
> >
> > Zhu Yanjun
> >
> >> namespace.
> >
>
> --
> Best Regards,
> Yanjun.Zhu
>

