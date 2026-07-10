Return-Path: <linux-rdma+bounces-23036-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GrDdIk9zUWpgFAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23036-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 00:33:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE0973F90E
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 00:33:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=FzuzfCo6;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23036-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23036-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DBD63014C63
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 22:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F223E6DD2;
	Fri, 10 Jul 2026 22:33:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760233932C2
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 22:33:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722825; cv=pass; b=mNP3Rqyz0qDbYtuTtqN1Pi9D1+/HQv1WaVag3ZqFbIh9s3dfjToDGBmRvl26MPhg1LVnfP5NME+/+2msu+/ifwc072UCtMfSok6W0/LrQbd+TzmcU1qDTkivfzF4m9is2NRD7YLNXeMaM3vVU6pbM+u4rYIPJP1Kj4CqORBxKOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722825; c=relaxed/simple;
	bh=P2CfZ/eVooz8ByYMc/X83GhAycu5z9o7K3QZsj854og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbByhGLjWKWbgpC6w072tEcwBZCIM004jWOjrS5MWfDZUo325Hw+6gzv0a/ClM/WUnmggqg80R5HfuvKsFom1nvDOS0bW8/fCH1U3fjXQX+Z6WA1EBu5szsJIMm9YBwtUjRfiJkfdhne/BYyDCTErQQ1TjtHsBXnBqvN2pe6F2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=FzuzfCo6; arc=pass smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8486672f03cso1302008b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 15:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783722823; cv=none;
        d=google.com; s=arc-20260327;
        b=MYBbEWYfDnIwuFheSTnyhyVw9HjJ5AUJ8WDV8bqKawjpwkOJmtyVcT53g1JZOYAZMT
         Hhla5w8sPG7IkhXqY3UchfUscsZRiXinj6CcRx/6RBMwYNFook63irTRm7GqDTBcYOaH
         cYkSV7DW6IOL65kGW0HQU1kLL6l+qWEfka0tGXEJDBhj7eU7fvLRBPKesf+OXiu9LVjr
         H3joeXX4VIXPpMlb+pGO6LhgmedvnGwC6Y7NO5Mdwj07GJE+hpfKUYnp/RpeF8kimTo3
         ypomSBjgoAMVf3tnvGGR1X6ibHFio5WC2RmkbkCvva0v1KOElaLzNCuWLrw+DkvkzTIT
         mSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyKVX/uPhGkx9zXyKF8UrRvoqCkGwrtRinUkfLWvnaE=;
        fh=r7RYZs6Q4jGTbvFJIdoxe+KsxWtzvs0+4NePZZDY4S0=;
        b=cVTJP3QUjbbxWLYxIRMyzM6xcIKWkErkFjQuz1bNFYqu98QRAUsThVGMdS3jvMHSo/
         vVRuVH5tO7JrCjbKkHwwsg71rXZQUqiMc/CBHwxJTNDddJ2Y+sRUx98/xRei5jAaFn/I
         nMfzq4UUcl6BbaFTg0dQP1O9sK/Sj6/mZ9pObhmZpgwRmRJ5KK2W2MgUzDRlBsAB+YQ+
         2T7wTemSfW1i2fO3vvB7SFHiR6zfebviI6lKLj2dfBIHmTF14jswLBfW8Zpg1RX/gc5q
         Ccju9PqjQcA8G4yj2azs/LealIVzEEDQyR865sPIugLaf9Au7bC0fXyjgFO2pghkzxUe
         OYGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783722823; x=1784327623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyKVX/uPhGkx9zXyKF8UrRvoqCkGwrtRinUkfLWvnaE=;
        b=FzuzfCo67EgWdapvV0PsTD+8qfTUblpwmqTE7rUgQr6rjHsdVeB3xfzqB171fJHtbZ
         ILHlxjbztGtF2GkH6E2vqrL4m1iIZ9or3XXirhXjewT2rabVrZlIN/oEbpDxV01W2C0f
         qOIlu5dWzFJiAIqifY75QufZX8E0O2seuXhpcPTEtxBIlMMeFHzEzdQC3aSdChUhZ0lg
         DM0QyMXQA8SpsWqD4drTkiCWP4PCj4sIQyoVtMGgDrBqNct5W09eaLDDxMszHcOgqxmp
         8UusduZ0PPLBqdApQg6Qx9tutu3E9jbN8raJGjiBQnRu7sIQb2cjRkkf8/mgkW4pl62k
         NU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722823; x=1784327623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyKVX/uPhGkx9zXyKF8UrRvoqCkGwrtRinUkfLWvnaE=;
        b=RxTja8XtdxI2rvHmwSc9YSkM0I+RDYP4XqPJRQ4XMnwtUqVhOW8v4i+OBYF2Lihs87
         BuLyd2PqMlWfTP1ItHk7LYlkl0CkSVI1tfz0Cz2xpcgp6tA94jap449lNgTxeaJCkuHG
         /F0R8fVTaifa7AmZb73XwkJP9CMD51LiHWA58vRYL7okiNKBQebMTkBVLMJNOWIPWX1v
         pV3wy+vaUmEB6/A1CkxbvYQTUykfdopRw7yTkDMyXOEr6HrJOM1rtiYpEq7dFoECmFee
         RCEMOnDmgjw+QYwXIEgUNkY7Kr3gWknhbMoSPwUuEOL6+0RF5QHZNpoFF3rp926XO76/
         sDfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzpKqhm2EpZ7bb95WMnuQKQ2MTx4P4Djekh/n3JgUSsC0OxNnCLweff1YwkEGGfxvIcl+GK+jpHcM+@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnDC5X50r2GZbWvqZJ9eORrh0keQs6cEatrfp2R/yB/dVY2Sj
	pnS4rYrf9d9R/EBs4675I6uMhiKf2ptwVMjhEEufvy8dte4x6kFGSVr4zcohlht33qJ/XsDjVXZ
	2dNhuiiQK1Pppt2PnsRZ26ork99OBq/FRuudrR+Hj
X-Gm-Gg: AfdE7cktEzSMeb8hi0AVPWuJYIQtaDMFYxx3bTmKdmYz6+jzYTtTaq3cKoaQoRjh3k3
	o1UN4y3aOIvN7tJuhAvH1Z25wOlXtEe7USTxYzgBaU5o+aAK3Pf6u75KlcBIZhm0oheu0RHvnxv
	dgOC2Hl0xr+rvRvssdEuErNezNQKYGUiYX4K+6daeVMe0FVhVYcVIWRaY3eXyBHynkHjk6AThfE
	qDITT9iUZ3I/COMJOGvTaO2HmGt2c8clHxV7fC93h8AP+vZijV+MouTupxaYLWq/KrtClDUf49k
	LNbhW0lqC/0hrBOkw52PDYzqeu0erOjkncMxTSw=
X-Received: by 2002:a05:6a00:1486:b0:848:77b3:579a with SMTP id
 d2e1a72fcca58-848896098c0mr762210b3a.17.1783722822748; Fri, 10 Jul 2026
 15:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709074459.326345-1-xmei5@asu.edu> <e7c19015d10439cea2ff78e57a93a610c12e52b0.camel@kernel.org>
In-Reply-To: <e7c19015d10439cea2ff78e57a93a610c12e52b0.camel@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 10 Jul 2026 15:33:31 -0700
X-Gm-Features: AVVi8CdSFO9ZEsWQZZfn_huEKkXHjvc00YHbFCenmr4jUMQsH-cbKpDjfXyjcI0
Message-ID: <CAPpSM+QyU8YK1EywyAAjeW7ynYYVHVrDp9JHhUdFh7=-B3hcUw@mail.gmail.com>
Subject: Re: [PATCH net] rds: tcp: hold the net_device across ipv6_chk_addr()
 in rds_tcp_laddr_check()
To: Allison Henderson <achender@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:santosh.shilimkar@oracle.com,m:ka-cheong.poon@oracle.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23036-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,oss.oracle.com,oracle.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,asu.edu:from_mime,asu.edu:email,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBE0973F90E

On Thu, Jul 9, 2026 at 9:42=E2=80=AFPM Allison Henderson <achender@kernel.o=
rg> wrote:
>
> On Thu, 2026-07-09 at 00:44 -0700, Xiang Mei wrote:
> > rds_tcp_laddr_check() looks up a scoped IPv6 interface with
> > dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
> > passes the bare struct net_device * into ipv6_chk_addr().
> >
> > dev_get_by_index_rcu() only keeps the device alive within the same RCU
> > read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK ca=
n
> > free the net_device; ipv6_chk_addr() then dereferences the stale pointe=
r
> > in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), readi=
ng
> > freed memory.
> >
> > Take a reference with dev_hold() before dropping the RCU lock and relea=
se
> > it with dev_put() after ipv6_chk_addr(), so the device cannot be freed
> > while in use. dev_put(NULL) is a no-op, so the scope_id =3D=3D 0 path i=
s
> > unaffected.
> >
> >   BUG: KASAN: slab-use-after-free in __ipv6_chk_addr_and_flags (... net=
/ipv6/addrconf.c:1998)
> >   Read of size 8 at addr ffff8880106ec000 by task exploit/153
> >   Call Trace:
> >    ...
> >    kasan_report (mm/kasan/report.c:595)
> >    __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
> >    ipv6_chk_addr (net/ipv6/addrconf.c:2031 net/ipv6/addrconf.c:1972)
> >    rds_tcp_laddr_check (net/rds/tcp.c:370)
> >    rds_bind (net/rds/bind.c:248)
> >    __sys_bind (net/socket.c:1920)
> >    __x64_sys_bind (net/socket.c:1956)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:63)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> > Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation =
to struct in6_addr")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/rds/tcp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> > index a1de114d5e2e..204dcdc33c27 100644
> > --- a/net/rds/tcp.c
> > +++ b/net/rds/tcp.c
> > @@ -363,12 +363,16 @@ int rds_tcp_laddr_check(struct net *net, const st=
ruct in6_addr *addr,
> >                       rcu_read_unlock();
> >                       return -EADDRNOTAVAIL;
> >               }
> > +             dev_hold(dev);
> >               rcu_read_unlock();
> >       }
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       ret =3D ipv6_chk_addr(net, addr, dev, 0);
> > +     dev_put(dev);
> Hi Xiang,
>
> Thanks for working on this.  It looks like this patch generated
> some CI warnings for dev_hold/put that should be addressed:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260709074459.32634=
5-1-xmei5@asu.edu/
>
> Per the comments from include/linux/netdevice.h:4546, netdev_hold/put
> replaced dev_hold/put, which takes a netdevice_tracker pointer.  But I
> think the easier way to do this may be just to widen the rcu locks alread=
y
> in this function.  Just move rcu_read_lock(); above the scope_id check,
> and make sure it's released before any returns.  That should get away fro=
m
> having to use the hold/puts all together.
>
>         rcu_read_lock();
>         if (scope_id !=3D 0) {
>                 dev =3D dev_get_by_index_rcu(net, scope_id);
>                 if (!dev) {
>                         rcu_read_unlock();
>                         return -EADDRNOTAVAIL;
>                 }
>         }
> #if IS_ENABLED(CONFIG_IPV6)
>         ret =3D ipv6_chk_addr(net, addr, dev, 0);
>         if (ret) {
>                 rcu_read_unlock();
>                 return 0;
>         }
> #endif
>         rcu_read_unlock();
>         return -EADDRNOTAVAIL;
>
> Also, this patch conflicts with another submitted patch:
> [net,v2] rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260709162723.36752=
3-1-Ilia.Gavrilov@infotecs.ru/
>
> So, please rebase on Ilia's v2, and mention the dependency in your change
> log so the stable folks pick them up in the right order.  Both fixes carr=
y
> the same Fixes: tag so they should travel together.
>
> Thank you!
> Allison

Thanks so much! Your version is better!
I have sent v2, which rebase on Ilia's v2:
https://lore.kernel.org/netdev/20260710223029.1307043-1-xmei5@asu.edu/T/#u

Xiang


Xiang
>
> >       if (ret)
> >               return 0;
> > +#else
> > +     dev_put(dev);
> >  #endif
> >       return -EADDRNOTAVAIL;
> >  }
>

