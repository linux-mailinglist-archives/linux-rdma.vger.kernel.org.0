Return-Path: <linux-rdma+bounces-17891-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAJdFcZdsGloigIAu9opvQ
	(envelope-from <linux-rdma+bounces-17891-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:07:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B023256244
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C1E9304F49E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BFE3D8102;
	Tue, 10 Mar 2026 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niZfI7zs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619993D6481
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165678; cv=pass; b=HNFw1qSiHbGHc5JDKHZ7EB73Z/KuWs7bo0yEhPrJYzOvXg1zezZt66Q6/AU9/V3N2RGi78daH8Q05jIFbPpr18DlfcZTftkWUd1dcrVNnUIDL5+kDqntElHQjGQKXr12OmAiGaoNiLSotT60B+Nz6o/Y9JmhBKKmvYmORliPpeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165678; c=relaxed/simple;
	bh=rYXsZMUuHk9Vij+MAdMAYvIwyWdemTN31YCkA/kn6go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iupIcMrRTI1IRmn4i1+gZpOlgp1aXL+k0UqyEAyOTxQ5kfL3YYQbcSxGeatBlW9U40U52EgG3WjQcgmTZnSWTh5lLZmlOsdteVYNQGI1IS7Vp9PXX/FIYbcvned70kdU6D7s/HwfROuXXiLQwr7zgrLjSLZfcQgxAyJ3y1vs8j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niZfI7zs; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506bcb23a78so115100001cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 11:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773165675; cv=none;
        d=google.com; s=arc-20240605;
        b=M/AGEeYyCJvfzowIBPWxJt+20N33xaeCFYor1/zrzpF6NKKu4hTlsRfcWyHPqCkVbW
         yi3rCnT24we/8mwq8OGEQI4Fex2IB8bYerSSsX93jhK1+nAxv7+KUXjmKLf7BGskIQ2R
         SEDdQyrLQwp2yin4kE2u6Ndp1cAkRNtr2ELj6wdnT8Vp2YH/BjtmmbCDnjSw5n+DvtJd
         5o+wGdWlqS58Zt1RqhEd5UbX9v6KG3aA/rPmOqgopJgnIkZPj/PIkkL8TKmmZjZYFf5Z
         6jlYwA3Sk8d5hGys/IDiIs9islpSuLdiJ3zb0OWy6QlPkS0slcUhL9bdqjCxrjudZPGF
         lrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        fh=W/d7OfC47AmAOhkEaAA/KoxbiHhEWQFvm7D6OBzCpIs=;
        b=ZW8+Dig1UYbLu1jXV7Ms12onQSCLdqWwY802jg8tfK2j44I8c4Ap6SOoXgR8Oa5FP+
         JMERAO1huAWM6ue9s9n3uwxBMzLRvJemDd7FOteSOCBZiAajXjn50ZSQBVku2603xXLY
         +JAb/udUnMzWAk/8abLXoDqInEoVRhnBtQptCgL70+vdJBMDHcz9yI23rJs8XnoMNoLT
         rPO1zauDDFVGnwphBKjc3QCOfWGxdJjDEiTmdM88OiRM4roA3m7rLYKTaVnbAysHwkdm
         5/L1beNKxWz0pXQAfbSrO2jJNGvdF/ozcqZLg4MXc0IghezmbqzDAhymLXw81c4OMeEX
         t5jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773165675; x=1773770475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        b=niZfI7zsg/Gf11FO83u/owPttxkNiDN0g8lBMJvYfX9zGE1ZT4lyeOWuQpd+O7heVW
         +EUeYM+TpxMEM4gKhvdte0rlYGKc+bvKnFAF8/nu/6z73H/O5bJ5Kduqnxqib5KnyNNB
         6NvU5phtZl/Lw6dkLkDVNLJqbfSTOMGWIdg9g3pK4P37zodrz1z9T01qhgCYqfx2kqzA
         XW8Fk7RTVnQzx/a73XKWo6K4HqjN1eqKFw6tcr4Zfxp3nwc0aZdktSeCizjJqwt6r1li
         1lNaeHPvVkIH/zTEQM4YN3qKUuA2tcrIPCgBy7/9iPP7MLAwP3gv66vZnpFoQz8gSodO
         a5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165675; x=1773770475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        b=o9xXLkvyxdP4OaicYFXEkycX9GMyKT2abeZAUrgEzDSrrha/keqN3/Tzpq1uULP8C1
         ukGHmy8zVQYped/yvpk+KC210P5itkbItuhbjAmXIX0uhPsFxB+tlKl+ChHSX5jUhFUi
         829cZvwdkPOppWUkPGgoQRQ/tglWterUcVpkjqBZeaimJfUxtC2IuDwP/4OSziSYGDJJ
         7SAglBx9PBzuFD4/8zz6WssIFrEwgg97bXeII9fNf1yonyJmtQsUjEyJdb6yyNdBKw2K
         f94APOaJLbuIFo6F64LoNlstrOn/3z9JG/hzngz91B3SdfWef0nzkvZbpGGw+J8UZY6D
         3+QA==
X-Forwarded-Encrypted: i=1; AJvYcCX0b06rpeaDm89kl6bpWAnNgkoJAdeHdmC7pJ1PKF72kXaWtDwLFzmMxWOdC8MWdMextE4tRPkF0LuS@vger.kernel.org
X-Gm-Message-State: AOJu0YzegNRHKdKlG2a820uBs5xLHw93cCC9OTMjDuiuodFFC5+reb99
	iGE4b6tANi8vQbafHzu8JW+xYqE2Vmk8f6EnJ+Iu0CO63W6LsmOgqhZCaWGRMnpxQlsraq4OW+o
	DQ4BpF3J94jNn9DwpENzY9ZDAsZ7HnuDmPP+8DoqA
X-Gm-Gg: ATEYQzx7LNv2QZ1eEqjAXfQ9JaewlK0btiZfJclSW/Wsk0tlKU5CS/glg3KmHjZ3QoA
	QiWnT7bjgBxSkASGUDG2/YP6eNUKDFqpSoD8wt+59Q41MSiUK9AimNTiXjPEBZJK1H9gQiNfCTu
	N6yRwn/3vP23zzMxbopJlMVe26sXPolO+LRkTYAoR4z0E1FfHQQ8Aj6UkGKnzqa/9oD0DJlYDoa
	KOSypG92nRwRS9WBUf1TJKpm83jG5f6TUDtER1jpQkgk8R1hgO9eE925jTW2ow0oTJsPgVita1L
	2VYgKHY=
X-Received: by 2002:a05:622a:30c:b0:509:1987:7626 with SMTP id
 d75a77b69052e-50919878112mr105695521cf.68.1773165674535; Tue, 10 Mar 2026
 11:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310175426.110496-1-mehulrao@gmail.com>
In-Reply-To: <20260310175426.110496-1-mehulrao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 19:01:02 +0100
X-Gm-Features: AaiRm53UGgNPm-VVL4bP7cqGr__1xchAYQsFlh3zLlZ1JMWlgUtST28CgXly02c
Message-ID: <CANn89iJxDq06TeNKANFw8E_FKsEq6v_st=1iLR-=HnZ_X=ofXQ@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
To: Mehul Rao <mehulrao@gmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0B023256244
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17891-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 6:54=E2=80=AFPM Mehul Rao <mehulrao@gmail.com> wrot=
e:
>
> smc_clcsock_user_data() can return NULL when the listening SMC socket is
> being torn down concurrently. During close, smc_close_active() sets
> sk_user_data to NULL on the underlying CLC socket before shutting it
> down. If a TCP SYN completion arrives in this window,
> smc_tcp_syn_recv_sock() is called from softirq and dereferences the NULL
> pointer when accessing smc->queued_smc_hs.
>
> The sibling function smc_hs_congested() already handles this case by
> checking for NULL and returning early. Add the same NULL check to
> smc_tcp_syn_recv_sock().
>
>  BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock (arch/x86/include/as=
m/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux=
/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
>  Read of size 4 at addr 00000000000006b0 by task poc-F362/154
>
>  CPU: 2 UID: 0 PID: 154 Comm: poc-F362 Not tainted 7.0.0-rc3 #1 PREEMPT(l=
azy)
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl (lib/dump_stack.c:122)
>   kasan_report (mm/kasan/report.c:597)
>   ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux=
/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented=
.h:33 net/smc/af_smc.c:136)
>   ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux=
/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented=
.h:33 net/smc/af_smc.c:136)
>   kasan_check_range (mm/kasan/generic.c:186 (discriminator 1) mm/kasan/ge=
neric.c:200 (discriminator 1))
>   smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/a=
tomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h=
:33 net/smc/af_smc.c:136)
>   tcp_check_req (net/ipv4/tcp_minisocks.c:927)
>   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2245)
>   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>   ip_local_deliver_finish (include/linux/rcupdate.h:883 net/ipv4/ip_input=
.c:242)
>   ip_local_deliver (net/ipv4/ip_input.c:259)
>   ip_rcv (net/ipv4/ip_input.c:573)
>   __netif_receive_skb_one_core (net/core/dev.c:6164)
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>
> ---
>  net/smc/af_smc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d0119afcc6a1..bb8966eeb332 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -132,6 +132,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struc=
t sock *sk,
>         struct sock *child;
>
>         smc =3D smc_clcsock_user_data(sk);
> +       if (!smc)
> +               goto drop;
>
>         if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_=
hs) >
>                                 sk->sk_max_ack_backlog)

This is racy. Please look at  Jiayuan Chen patches.

