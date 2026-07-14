Return-Path: <linux-rdma+bounces-23231-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xNNwMsipVmqY/wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23231-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 23:27:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C44F758FC6
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 23:27:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=kb768rMH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23231-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23231-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54B8C30BA2BE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBED42BEAD;
	Tue, 14 Jul 2026 21:24:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E56427A1A
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 21:24:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064299; cv=pass; b=E8/wL2XYFnbgSQqUYHINMY8kjaJz17ERa6hsJ+jXk3uBVCrXAWdecAogG0FtylbtsYHBeR0ZhFhCzEIPdENudrw3S68/6qcgqKz9ImEYje7Hg+5uTEQHYoq8Gqna/E081FpZ6vIZ7ljZcfJ3ClM/amXSHNOJeE4HLoMtgnZ9rDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064299; c=relaxed/simple;
	bh=5lEL8ncm6HpX+/UGi6fEjiqgrC5SrckOfqT3dPhdPCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5xmfWnztnaWwhDbeXVL9cVeS5HlHBxdImRKGqnhtYf263mFDZOFCdN7ZN8C56mvNq1JeK9v/FOxzyYv9mrQCc+guB96rnEZnM+1dVxjpyytO6ui7tifQpgUg0SZtXfgTRFs0ZeecXlcJcFg/+HBiNszTkQpMtQeYDEdWR9Qtis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=kb768rMH; arc=pass smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3847e8b0f3aso3976682a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 14:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784064295; cv=none;
        d=google.com; s=arc-20260327;
        b=DOrGTlnks+PFIcgDJa0BQFfDwksSj2FP4IibZ+X+Dyjn8J8jcJ2g0argXHht0WdMEO
         szCqBjOAGZ4gxRtyeg4SkSNxuQYItifEVuyf3iCLESsfl5OhdsaRDXBB3vUZV8Di2ANM
         60nqvXDPw68qscJWuqFOizXt0NCqfqN5t6Dd+Fs3LI6Dj8wY1a2Eun9X4ES90y8j3SSS
         RF8Dyngv46vW6iTCP12aeflYJcQ1BvnOHkxaa0uuvleTbPpt++XhHREAHeyHxw8Wopj+
         aqQ0IDv5/43sTS1BmC6t4eLUysgkWyNUrOZD6kJtMEL2Ji4zo0yTZNPpdUlrC0O7w+ty
         DKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fKdbGRuewpi7ZMpE9C7ytuL9gIr5Wnu61fkfFllAAco=;
        fh=wI0BhoypGkCDwNR01klpZsW4WqX+XyidKyoQi0lQFa8=;
        b=NNmsu38zGSzrLJRfJFfmAdP2C8mEvOes91vre4CS42VpmFYNXAttkFknW7/fObNMNC
         1b8PZebzXDbg7diojDBCOck2bmDyGIlsXGf+WsZXbw/io5Wj7lg68mvHDESxsROq+HJA
         TK6Wm0hjy7sQcWZwyWyM+DcGsiTbwkumB7v84BEwCzj9yownbz8q2RjEMvUn3VEAfgaI
         /GHyZLZ8Mq+uYRd1TgcMZiD8LorsaUcI1+8hkUd/4QOkZsHlBQQDFx70WMW2+JOX1AiU
         UwiUFT8sigBGrXAxK0gpaPcB+yVLPKmthrhkmOuEP7m9Hn+oTZfTJgI7zW3Rfq68weTg
         rVGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784064295; x=1784669095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKdbGRuewpi7ZMpE9C7ytuL9gIr5Wnu61fkfFllAAco=;
        b=kb768rMHCzIUv3YNEOOpJvF5oYlMBPoXuR1ImlPI4kNsZDO8kZYAsakHK8s426roPt
         oUQAchpiX/CtEgZvWCGcA5NtixsdnHuuWc+nuWj64asQC1TxIV0eP32aa30LMvJuurah
         gY9TAQYhrvMVZEiiRc58RKUvyEF5Fz6RyZawX53maDMUt6xiLNYmZLH6b62pZZk9nJlK
         rwmxbn6rXxk8yGTvr9FEVxshOOZWnB/sGxrXGwTOavh67guQkm/GeYbzZp9BmRAfHsRm
         3beMgZD0SLy8kerKaOQEFV8YSt0jSJOBFb1qJljl2t05ppnD6cfXoIgySP06ZQRiPoJT
         32Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064295; x=1784669095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKdbGRuewpi7ZMpE9C7ytuL9gIr5Wnu61fkfFllAAco=;
        b=IhX0iEQCvVZknz+VJLCRC7ti2DBY9sfeHSYmnu83Q0uHIO12Gjyr3UjoISIM2aRiwt
         tJGkLMhQNRQmP/NilwPBk9rpVIgPl10K/V0TDQOOpAZ8xqoJC89L9jLEIJGGlavSEnJ+
         aI0NxBfR45Ba9WSCc038q10OribjCZSLoGDF0LRtkTpmNuI85sFBIL1wUCFMvd1+5KAI
         ecKu/YOCxfdG2oguTpM/6jf/hwRWsK/jkAx8mBwEm3wnkMVcCkqPHS5sVzlA9cSuhIp2
         yHRe6kmI975Ski+Inq+9ukqFyOgY/Mw2pib/j0fnSXUXQ8mkwIzQ4O0xWXJSiCghxP5E
         fPJw==
X-Forwarded-Encrypted: i=1; AHgh+RrWQSHFkfLgaAEpef67H44cobDZagUrtPNTmCuBBpPqHc7E4Nre2nn2TesCdR5EJW7u31ah/ii1moP8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0ktXr0ymJ87apnXS9Ehvd4f9LRY94GElhkCQ+Fro2oxM2hWR
	9twl4d8kUZRli8H7689IuK31hHY2TNcLYZot/CUs61AcLP0Zo10WfmnC6l+jvCFbi0kdcWCjhOA
	hWXmfTmc8pUY7FgKG7dYVPa1VbCqtugTay4itKtCd
X-Gm-Gg: AfdE7cn8yXo4n9ORPyViEJQKEzh8CaH0Bcq+HK4M/1K7zdi0grL11gkts3+TkRKV4S5
	NYK3WH88R2A+jpoJbrfDo6tAvRYpo0OGAMxzT4lWhcMbEk2Rr05f2E6tGlJBzta3P0DWg4rJ557
	xTKy6W48bGkzqRqVvKMSYi0VklRmgu7G4jIgk5Xrxl2LznmPOB+d7hnAvAFREJmmfq9KiR2TmVv
	3vncOLPy6eJ2g6WFtlHrNGSsdfT8D9oHAES8UOkG7H2mGz7VQ9L5pgpvqynH5Gq9fdCsZ3CBYSA
	gC+7T+Z56u4K581DCa3sQfD3NZdHUJI=
X-Received: by 2002:a17:90b:4a11:b0:37f:9ce1:cdb0 with SMTP id
 98e67ed59e1d1-38e2a0a78c1mr306534a91.30.1784064295348; Tue, 14 Jul 2026
 14:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710223029.1307043-1-xmei5@asu.edu> <f69ec0975481ad04dc7403834bbb6b93d1092ecb.camel@kernel.org>
In-Reply-To: <f69ec0975481ad04dc7403834bbb6b93d1092ecb.camel@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 14:24:43 -0700
X-Gm-Features: AUfX_my-bnGdv6WApj0EccK6Wy1KqN5vNEqE9wuIXjURuJDWYgC0SW6HQ5GQbGg
Message-ID: <CAPpSM+QU=3CwxRavThhaeoFbiqECzDdPvV9C5StCfRK6aMn3zQ@mail.gmail.com>
Subject: Re: [PATCH net v2] rds: tcp: hold the RCU lock across ipv6_chk_addr()
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
	TAGGED_FROM(0.00)[bounces-23231-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C44F758FC6

On Fri, Jul 10, 2026 at 8:53=E2=80=AFPM Allison Henderson <achender@kernel.=
org> wrote:
>
> On Fri, 2026-07-10 at 15:30 -0700, Xiang Mei wrote:
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
> > Keep the RCU read-side lock held across the ipv6_chk_addr() call instea=
d
> > of dropping it right after the lookup, so the device cannot be freed
> > while it is in use.
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
>
>
>
> Thanks Xiang!  Just more thing to make sure your patches gets through. Ad=
d a change log here like this:
>
> Changes since v1:
>   Use rcu_read_locks instead of dev_hold/put
>   Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when=
 IPv6 is disabled
>
> Changes since v2:
>   Add change log
>
>
> Otherwise, it might get bounced if they happen to try your patch first.
> With that fixed:
> Reviewed-by: Allison Henderson <achender@kernel.org>
>
> Thanks!
> Allison
>
Thanks for the tips; I learned it!

v3 is ready:
https://lore.kernel.org/netdev/20260714212239.1511269-1-xmei5@asu.edu/T/#u

Xiang
> > Thanks Xiang!  Just more thing to make sure your patches gets through. =
Add a change log here like this:
> >
> > Changes since v1:
> >   Use rcu_read_locks instead of dev_hold/put
> >   Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference wh=
en IPv6 is disabled
> >
> > Changes since v2:
> >   Add change log
> >
> > Reviewed-by: Allison Henderson <achender@kernel.org>
> > Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation =
to struct in6_addr")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/rds/tcp.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> > index 955d92277d5a..30cfb0087f2c 100644
> > --- a/net/rds/tcp.c
> > +++ b/net/rds/tcp.c
> > @@ -355,23 +355,25 @@ int rds_tcp_laddr_check(struct net *net, const st=
ruct in6_addr *addr,
> >       /* If the scope_id is specified, check only those addresses
> >        * hosted on the specified interface.
> >        */
> > +     rcu_read_lock();
> >       if (scope_id !=3D 0) {
> > -             rcu_read_lock();
> >               dev =3D dev_get_by_index_rcu(net, scope_id);
> >               /* scope_id is not valid... */
> >               if (!dev) {
> >                       rcu_read_unlock();
> >                       return -EADDRNOTAVAIL;
> >               }
> > -             rcu_read_unlock();
> >       }
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       if (ipv6_mod_enabled()) {
> >               ret =3D ipv6_chk_addr(net, addr, dev, 0);
> > -             if (ret)
> > +             if (ret) {
> > +                     rcu_read_unlock();
> >                       return 0;
> > +             }
> >       }
> >  #endif
> > +     rcu_read_unlock();
> >       return -EADDRNOTAVAIL;
> >  }
> >
>

