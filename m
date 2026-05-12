Return-Path: <linux-rdma+bounces-20498-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICKgLI5DA2pV2QEAu9opvQ
	(envelope-from <linux-rdma+bounces-20498-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:13:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAAA523647
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D28D3574FF1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFED3C98B5;
	Tue, 12 May 2026 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="f+lVZCsO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D93C9883
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596785; cv=pass; b=mduhHleNuxEH67q1ppPmJjfHeSmrRhQ6Cj08H3Fs9qBFpR6hLHolTbo//7aHS4Ts7oFnmAEs029gJdK186F65JX9gKmt/hzJCveTw7m4imPCIQD2E35V9TACxXesSApwlI/Ro7hqNY2bGtFjTRyJ7AYKF/5JL90zzpuRQVB9Fww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596785; c=relaxed/simple;
	bh=yGks7eQ6R62usyLqX0AzI6lBTaK1ylA2vXD9wKRE1P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8f94LotXI//AkOKY5kmbcXejO7/N4SeqvcbKMpvizcpdU0fZgDRZ5bQRVwCshJKS21kUgaq1euq1OSoOX7nR2abtA0U/h0f5Ef8XEDWwrXiV8P+/0fQxXIUW3C0E1VhHlJK4uWQ0RuB1wzf5/W+7tNAztlhsnY45N3RiWgIkaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=f+lVZCsO; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bce3350fe3eso26238666b.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596780; cv=none;
        d=google.com; s=arc-20240605;
        b=VjHEom2U4FlMyYwm/b5MgzhuVnmbpmkvrOMuuMPnOgqWmhul1rvJlhqU3zzFYp+6Ra
         i5pzKvniuPD1GI3/8f9YmckyqNqj2HzJjgbbERbMpJdr50+R7yIrTlgfVrXZlbzWbrIC
         aPESlj7s5gHe48Vy48ZSxCxF1l1l2KGCUeLQcF96xo9pnbVtCRiPf5BOzWS0gKhZnNQ7
         kkstyAH8+b7hWsHZx73ja1Cncu9uXXzwqCq5IM3YSF5pC+H0EUx8B09uGy73GGutODyY
         ev+LyMIabx8VuO+PJj6SHJY7Qqw2QW8eLgwurM+SSeENr5oh913Qg0sW9OZ00AsJf5GP
         05xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEYhejCZ3W3ZnGLxE9yTvbR2p0JifYcgZ+ylvPK8KYo=;
        fh=JJHAu7olhN6+kwoQljVcTU2lCIEvR0Tc64+vUcI6MkQ=;
        b=eePEXY4ftO6BaeO7asjEUqe20gwoHGkBtwuMBL8WQlWlhf6po0XEPgaYby86EB/uJo
         pfvO6ImogPAg1CcF7HLepW0yp61+iFZkix7mrr33juj6BbiwSg6kRBqCUeX4l3/j1aca
         fQXfnyYYcYjPgCGXkGjg9lNHdG2Pwb9hN9TnnokBEp00A6bZNJVwWs9CtEsoYfMqUkY3
         g/kVMuiAkrNUfNC7ojLmWG3AhBrFr+UHBCgxfApeDZthzvxZuxyMEumKJwOfmy/CM/so
         CP3Ddv1N80zSuEz9V0/YtzevKsrMZFkAaCjXHg3YhhGRaU+y21Om4vZoM4X96Gv/UkBh
         HS3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1778596780; x=1779201580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEYhejCZ3W3ZnGLxE9yTvbR2p0JifYcgZ+ylvPK8KYo=;
        b=f+lVZCsOiclNljy0oCh1BuFGwSPYi4z1QviFxhOlw1JHfBpixckyxnnbKdoC4Kx6xm
         3JE2tksNLLH9T2QrkNC+ibklnA5FWIhcYYOsndFVpctDU48fwUNbSQPvFab+Tx9h7xqb
         +Ghmj5AGSdTKF0PdhIoZ0VqEZFCbRwz+ewk5C3jBWi63ReH0xp31lEbw/hwW8L6c1s/l
         Cz5sIpQYF0nlTdDHLGvArbhIVgqm/g6ghEuzYMsDFIicsOt/XSpijsFoxEUOUMlFWfB0
         VwUSmBgUkKwNFmbU/CzZwtYW9sNHFpWdSooJODwR9MHzGFLEmDExAIVkje1SKWaAmk3D
         tvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596780; x=1779201580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEYhejCZ3W3ZnGLxE9yTvbR2p0JifYcgZ+ylvPK8KYo=;
        b=Vku1coLahJwyJLt2PN2QWzu4Ge1t+gG0N2FDFn9KHaeWFapHUZFWQXroe7RYZfWBpf
         sWQy/YakJDDNDzHMyXSfwO6Enlr+oe89q4b2SpYlt2gZldEx+CjZW/4/m6Q0ln3E3p4H
         e1A12wMZzWi6oET+2hv/7iCB71PSTXitimYuziGTDae5ejQH/fV65kgx+FYYr4rtR5t8
         f62iKvsQYY1TRVllHuhoWmNFLsxvrkTtKDQ03LyjGwgpWbIwKfchOVzxAIJyUns9x96Z
         Z8waDrsk7xgiARyQf68x4Hd5ifo0p0YumjElkBDKSHZzEqmbKSfWOMVT8p68OARjheZO
         ygYQ==
X-Gm-Message-State: AOJu0YzcfWIFxX4NKo645vw30Zf33ATDG1cRXPY4DH5d731ZiFba/p5V
	J82oHUQIb4R4KV51E2c94V7yjSjget2Ltt/Jfap4Coki3cMxUUAalugpHEZC3R/qMRgGzUX6aPm
	9Hr2iQ8VmeTtaGKwdc78wU4UGihgLdbRSBbN+PeBn04LwDHvUVp4sGHY=
X-Gm-Gg: Acq92OGSxBuFr0EXejTjbdaJ956N3KobSAU/cPZqqCWwahmbILRcMTr1g9d6SIdh2MF
	9zkqZwx92vnLiMtYUw/U5Dd2qhSN39EP/cNBDvFNzWTBNKMPR0JOfajGgST9WtLCvF3G/37E32Y
	9wUEN7cWKtobISRxebfvQRX4j+8+/9qV3HH7S5Ex577i9h1Y1CIB+8MB6kc4Pe5FU6sloJVIpYf
	7JNfoatbi3Pubr3dNSUE0Y7yW5tgp44kPlVymVhpP2z54Cd4fIwjcUNStiTN2WxwhSz2FJWhRRF
	wFWFXH7M4lH8WVK6q4TtVtST9tJgdCWVI0v+VZg=
X-Received: by 2002:a17:907:fdc1:b0:bc5:326:86e2 with SMTP id
 a640c23a62f3a-bc56be41963mr621927266b.4.1778596779635; Tue, 12 May 2026
 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511041812.378030-1-rosenp@gmail.com>
In-Reply-To: <20260511041812.378030-1-rosenp@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 12 May 2026 16:39:28 +0200
X-Gm-Features: AVHnY4IUVbpPAknXgCu8acC5phITzhKISWxSgnlIZGcEdWUhke0LSk-ZBO-PlUM
Message-ID: <CAMGffEn7R09e0TKmmF-WyNV3V3dqxRDknNU7d-9s+N34RpNQ3A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Use flexible array for client path stats
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rdma@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1FAAA523647
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20498-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinpu.wang@ionos.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ionos.com:email,ionos.com:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 6:18=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Store the client path statistics in the RTRS client path allocation
> instead of allocating them separately.
>
> This ties the stats lifetime directly to the path and removes a separate
> allocation failure path. Keep freeing the per-CPU stats data separately,
> but do not free the embedded stats object from error paths or the stats
> kobject release handler.
>
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  2 --
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 13 ++-----------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  2 +-
>  3 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infin=
iband/ulp/rtrs/rtrs-clt-sysfs.c
> index 287e0ea43287..f8b833bd81ad 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> @@ -37,8 +37,6 @@ static void rtrs_clt_path_stats_release(struct kobject =
*kobj)
>         stats =3D container_of(kobj, struct rtrs_clt_stats, kobj_stats);
>
>         free_percpu(stats->pcpu_stats);
> -
> -       kfree(stats);
>  }
>
>  static struct kobj_type ktype_stats =3D {
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index e351552733df..d34d7e5f34d6 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1536,7 +1536,7 @@ static struct rtrs_clt_path *alloc_path(struct rtrs=
_clt_sess *clt,
>         int cpu;
>         size_t total_con;
>
> -       clt_path =3D kzalloc_obj(*clt_path);
> +       clt_path =3D kzalloc_flex(*clt_path, stats, 1);
>         if (!clt_path)
>                 goto err;
>
> @@ -1552,10 +1552,6 @@ static struct rtrs_clt_path *alloc_path(struct rtr=
s_clt_sess *clt,
>         clt_path->s.con_num =3D total_con;
>         clt_path->s.irq_con_num =3D con_num + 1;
>
> -       clt_path->stats =3D kzalloc_obj(*clt_path->stats);
> -       if (!clt_path->stats)
> -               goto err_free_con;
> -
>         mutex_init(&clt_path->init_mutex);
>         uuid_gen(&clt_path->s.uuid);
>         memcpy(&clt_path->s.dst_addr, path->dst,
> @@ -1583,7 +1579,7 @@ static struct rtrs_clt_path *alloc_path(struct rtrs=
_clt_sess *clt,
>
>         clt_path->mp_skip_entry =3D alloc_percpu(typeof(*clt_path->mp_ski=
p_entry));
>         if (!clt_path->mp_skip_entry)
> -               goto err_free_stats;
> +               goto err_free_con;
>
>         for_each_possible_cpu(cpu)
>                 INIT_LIST_HEAD(per_cpu_ptr(clt_path->mp_skip_entry, cpu))=
;
> @@ -1596,8 +1592,6 @@ static struct rtrs_clt_path *alloc_path(struct rtrs=
_clt_sess *clt,
>
>  err_free_percpu:
>         free_percpu(clt_path->mp_skip_entry);
> -err_free_stats:
> -       kfree(clt_path->stats);
>  err_free_con:
>         kfree(clt_path->s.con);
>  err_free_path:
> @@ -2863,7 +2857,6 @@ struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt=
_ops *ops,
>                         list_del_rcu(&clt_path->s.entry);
>                         rtrs_clt_close_conns(clt_path, true);
>                         free_percpu(clt_path->stats->pcpu_stats);
> -                       kfree(clt_path->stats);
>                         free_path(clt_path);
>                         goto close_all_path;
>                 }
> @@ -2873,7 +2866,6 @@ struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt=
_ops *ops,
>                         list_del_rcu(&clt_path->s.entry);
>                         rtrs_clt_close_conns(clt_path, true);
>                         free_percpu(clt_path->stats->pcpu_stats);
> -                       kfree(clt_path->stats);
>                         free_path(clt_path);
>                         goto close_all_path;
>                 }
> @@ -3166,7 +3158,6 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt=
_sess *clt,
>         rtrs_clt_remove_path_from_arr(clt_path);
>         rtrs_clt_close_conns(clt_path, true);
>         free_percpu(clt_path->stats->pcpu_stats);
> -       kfree(clt_path->stats);
>         free_path(clt_path);
>
>         return err;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.h
> index 986239ed2d3b..1305601a6251 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> @@ -142,12 +142,12 @@ struct rtrs_clt_path {
>         u32                     flags;
>         struct kobject          kobj;
>         u8                      for_new_clt;
> -       struct rtrs_clt_stats   *stats;
>         /* cache hca_port and hca_name to display in sysfs */
>         u8                      hca_port;
>         char                    hca_name[IB_DEVICE_NAME_MAX];
>         struct list_head __percpu
>                                 *mp_skip_entry;
> +       struct rtrs_clt_stats   stats[];
>  };
>
>  struct rtrs_clt_sess {
> --
> 2.54.0
>

