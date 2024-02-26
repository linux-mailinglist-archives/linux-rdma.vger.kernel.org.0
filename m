Return-Path: <linux-rdma+bounces-1141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956DC86819A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 21:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406A928BA99
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69844130E53;
	Mon, 26 Feb 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibEtgfWr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE1130ADE
	for <linux-rdma@vger.kernel.org>; Mon, 26 Feb 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977623; cv=none; b=WSpVQM0EmmUq76lcaO5JUKMEPIobM9VoGCZ/xR29tRrhC+tr6m5wl0tLWklC/E6mJgIpU3wIX5tvdDpXQGLQA2XT1CDahAsXrRr6Gh22w/WXnrT3XVhGgXbNFsNnUIlgtLcAe/Lf6goSPDOmfCkdHQaHW7YHTljgdR/clBZIrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977623; c=relaxed/simple;
	bh=1NNrpPWwxt4Wlun6txn1U5W66+C0pMHiI0dvidFtKQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuuUIJpiGI+pyWjV8/CjCGCOMWkCGHwWWvV+KnG4dMu8q1zjYt0V6I73RZ+0ELVEW+ZQi8SH0FwUMbwGugLuC3HuQPEuL/KhPp5wNxpk9hztwh2v8DnZ/oe4+dWKduRKQAYDFFvP/Ow7KbQfVwahRPnfnfO6DWDkKz0Xf1K40I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibEtgfWr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56619428c41so887a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 26 Feb 2024 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708977619; x=1709582419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6wUd3d+jUzzFDGo3N2sfhDJBkkR2lZkFGs9HBtEVII=;
        b=ibEtgfWrXXoJke1V7pe5PM0g3KJre+Y5YjwJlKORFhXbFY2Ze8m3mvWQrZpaRO5/KI
         988x+pqazP5hGSTGIfo+AMVrxwgJ2WZpcmJ+TfEX8f1ABaLHrKcuprOo22IVCZ1QOTE2
         p2fMXl52KeBaK+jJbrYDBADGI3TqGaith/8CCUNY8289mjukQogBKWrlfw10Gk+9u7G5
         iVINbC/cl3f+YR6uTMOoJsmNLZA6/fK6gPVdip76GhdB/tYmsx8UhD/Dfux6FcylXU2B
         9xVYCMHB3Z1nVvTFtBN59F+yT8lVTn4XvknKUKXB/+WCb6cXbxLe6krHQH2wzUpdNud9
         CFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977619; x=1709582419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6wUd3d+jUzzFDGo3N2sfhDJBkkR2lZkFGs9HBtEVII=;
        b=NkXdcRVUJSdy0QNdYT+nBIP1z5xRA/bo8Q5HkuwzZsQzRgSYzKB+jVfBTt256XE5Z0
         /3sQLXJmdinc7UMt6Ag1tl3GFwIO1TqNlLzihgiuRmbhPqYWXnuTzhQMTE5wyktWIg6E
         pIZYGPtfAP+rQSjE7udsrOWUSt5k4N80w1GZu2dIiXTxD0IPcJiqrvzOlCtL1TWhrt04
         fvs3rVmdRe2Ij2A3ZIDePauz1f9F4hDFPhVokl7244fHvbTcKR3JYUM4aLYFhZc6hhNH
         C2+7R8ACzF8v8Gx3+nukAcYUWQDo268xvYYdIwn9Y6DKeXUGi40vBcGxHza2uAywCmzw
         EqQA==
X-Forwarded-Encrypted: i=1; AJvYcCVG3wnYcc+qBT7TZLvdEx/7nSW5odeWFzbiGMBYyYdErCXI51oxY0JF/wqoh2AqqciYiuyX40MVXeoP+6AMPlXyqyubLltB5SWAbA==
X-Gm-Message-State: AOJu0YzQJL0iugXjQwEiH8RAFR8kuvvGTBG4RTxau6YaIsDTi80YwTEq
	kkgUFCqoimdGrKy9RgjjvJsZC25vYcZ2Vv0e07kKJafU5QS5Zmu5JOOeB43ydj8V2y1JfUZNtBW
	ChtI+8lemx+fVw5dPrMclNTVjo3zHpCp3h4vs
X-Google-Smtp-Source: AGHT+IEzrfPuSMkIuKIQDVi8IqTx/p376kv+sevgDeUCh5mAyYNsgfI/xzcRWyf7ukxYHjVBr/lXn4PsRGsiQ0qNMOQ=
X-Received: by 2002:a50:d490:0:b0:565:733d:2b30 with SMTP id
 s16-20020a50d490000000b00565733d2b30mr42972edi.4.1708977618791; Mon, 26 Feb
 2024 12:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJb-TeMKZCAzhfXhhzQ2FkYYZd9DqyHCwRoOn5KV4+Z5A@mail.gmail.com>
 <20240226194838.70789-1-kuniyu@amazon.com>
In-Reply-To: <20240226194838.70789-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 21:00:07 +0100
Message-ID: <CANn89iKNj4nEZ8wzjBBsCv1q6xF34kRxX0F-yYosiU==woiBCw@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, kuba@kernel.org, 
	kuni1840@gmail.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, rds-devel@oss.oracle.com, sowmini.varadhan@oracle.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Mon, 26 Feb 2024 20:40:10 +0100
> > On Mon, Feb 26, 2024 at 8:22=E2=80=AFPM Allison Henderson
> > <allison.henderson@oracle.com> wrote:
> > >
> > > On Mon, 2024-02-26 at 11:14 -0800, Kuniyuki Iwashima wrote:
> > > > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > Date: Fri, 23 Feb 2024 10:28:32 -0800
> > > > > From: Eric Dumazet <edumazet@google.com>
> > > > > Date: Fri, 23 Feb 2024 19:09:27 +0100
> > > > > > On Fri, Feb 23, 2024 at 6:26=E2=80=AFPM Kuniyuki Iwashima
> > > > > > <kuniyu@amazon.com> wrote:
> > > > > > >
> > > > > > > syzkaller reported a warning of netns tracker [0] followed by
> > > > > > > KASAN
> > > > > > > splat [1] and another ref tracker warning [1].
> > > > > > >
> > > > > > > syzkaller could not find a repro, but in the log, the only
> > > > > > > suspicious
> > > > > > > sequence was as follows:
> > > > > > >
> > > > > > >   18:26:22 executing program 1:
> > > > > > >   r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
> > > > > > >   ...
> > > > > > >   connect$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4001, 0x0,
> > > > > > > @loopback}, 0x1c) (async)
> > > > > > >
> > > > > > > The notable thing here is 0x4001 in connect(), which is
> > > > > > > RDS_TCP_PORT.
> > > > > > >
> > > > > > > So, the scenario would be:
> > > > > > >
> > > > > > >   1. unshare(CLONE_NEWNET) creates a per netns tcp listener i=
n
> > > > > > >       rds_tcp_listen_init().
> > > > > > >   2. syz-executor connect()s to it and creates a reqsk.
> > > > > > >   3. syz-executor exit()s immediately.
> > > > > > >   4. netns is dismantled.  [0]
> > > > > > >   5. reqsk timer is fired, and UAF happens while freeing
> > > > > > > reqsk.  [1]
> > > > > > >   6. listener is freed after RCU grace period.  [2]
> > > > > > >
> > > > > > > Basically, reqsk assumes that the listener guarantees netns
> > > > > > > safety
> > > > > > > until all reqsk timers are expired by holding the listener's
> > > > > > > refcount.
> > > > > > > However, this was not the case for kernel sockets.
> > > > > > >
> > > > > > > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk i=
n
> > > > > > > inet_twsk_purge()") fixed this issue only for per-netns ehash=
,
> > > > > > > but
> > > > > > > the issue still exists for the global ehash.
> > > > > > >
> > > > > > > We can apply the same fix, but this issue is specific to RDS.
> > > > > > >
> > > > > > > Instead of iterating potentially large ehash and purging reqs=
k
> > > > > > > during
> > > > > > > netns dismantle, let's hold netns refcount for the kernel TCP
> > > > > > > listener.
> > > > > > >
> > > > > > >
> > > > > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > > > > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP liste=
n
> > > > > > > endpoints, one per netns.")
> > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > > > ---
> > > > > > >  net/rds/tcp_listen.c | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > > > > > > index 05008ce5c421..4f7863932df7 100644
> > > > > > > --- a/net/rds/tcp_listen.c
> > > > > > > +++ b/net/rds/tcp_listen.c
> > > > > > > @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struc=
t
> > > > > > > net *net, bool isv6)
> > > > > > >                 goto out;
> > > > > > >         }
> > > > > > >
> > > > > > > +       __netns_tracker_free(net, &sock->sk->ns_tracker,
> > > > > > > false);
> > > > > > > +       sock->sk->sk_net_refcnt =3D 1;
> > > > > > > +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL)=
;
> > > > > > > +       sock_inuse_add(net, 1);
> > > > > > > +
> > > > > >
> > > > > > Why using sock_create_kern() then later 'convert' this kernel
> > > > > > socket
> > > > > > to a user one ?
> > > > > >
> > > > > > Would using __sock_create() avoid this ?
> > > > >
> > > > > I think yes, but LSM would see kern=3D0 in pre/post socket() hook=
s.
> > > > >
> > > > > Probably we can use __sock_create() in net-next and see if someon=
e
> > > > > complains.
> > > >
> > > > I noticed the patchwork status is Changes Requested.
> > > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/ne=
tdevbpf/list/?series=3D829213&state=3D*__;Kg!!ACWV5N9M2RV99hQ!KHKUQKUDnNCdi=
Ecb4ZK1VBiYSitarEb-CAWeSJvaeK04fgW4cuWePg3Ac2HmIAPUHuqeCwgt466fHEKAAdfa$
> > > >
> > > >
> > > > Should we use __sock_create() for RDS or add another parameter
> > > > to __sock_create(..., kern=3Dtrue/false, netref=3Dtrue/false) and
> > > > fix other similar uses (MPTCP, SMC, Netlink) altogether ?
> > > >
> > > > Thanks!
> > >
> > > Hi all,
> > >
> > > Thank you for looking at this.  I've been doing a little investigatio=
n
> > > in the area to better understand the issue and this fix.  While I
> > > understand what this patch is trying to do here, I'd like to do a
> > > little more digging as to why 740ea3c4a0b2 didnt work for rds, or wha=
t
> > > else rds may not be doing correctly that the other sockets are.  I'm
> > > not quite sure about setting the kern parameter to 0 for socket_creat=
e.
> > > While it seems like it would have a similar effect, this looks
> > > incorrect since this is not a user space socket.
> > >
> > > I'll do a little more diging myself too.  If you had another idea abo=
ut
> > > adding parameters to __sock_create, I'd be happy to take a look.  Tha=
nk
> > > you!
> >
> > I wonder if the following change would help ?
>
> Yes, it also fixes the issue. :)
> https://lore.kernel.org/netdev/20240226193857.69672-1-kuniyu@amazon.com/
>
> but it will trigger full ehash iteration for netns with no RDS usage
> (and even without TCP).
>
> So, I think __sock_create() or the netref conversion would be better.

Maybe, although you could add debugging/assertions to make sure no
TCP_NEW_SYN_RECV request are created on behalf of a kernel socket...

I am pretty sure other layers in the kernel use kernel socket TCP
listeners, SUNRPC for instance.

