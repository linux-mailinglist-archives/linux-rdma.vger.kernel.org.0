Return-Path: <linux-rdma+bounces-18885-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MEnHD7izGmjXQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18885-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:15:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4874377631
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65C2F3072D1F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856DC3C945E;
	Wed,  1 Apr 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twFnRIT8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48B3C5DD6
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034706; cv=pass; b=E1bJhK9UnFId0Kj5IYCuZ6lOMevLlfbiNZpxn8etY9W+NT1jf9Ao3BXJE0kmh2upGd2hwwipvyd35OVOsFTvm+F+BLFtlvBLgI7vqVasTMZBwjJIaHaEsUYKz2ZmbJEDX7Fs0p0YRmovCOcUrfZ2XGFThxOWUk3/fVC34J7DUfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034706; c=relaxed/simple;
	bh=dmaTcuAy6jfJ+bmzS1Jm/uyBrkTWgyDnScrFaQ2/nas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkmGih7acj6veWXVgU1FpAVN2SxTACTj06JBZdFjuMjv6xqRkTNtn5IyvXpT3yapl23KQL2Nufxw7nVSk2t5O6PaGxsE+GcnJPLFbDom3s2M4683aWjduIs639pAgi9+121TB8Y98BW3meM4mhD0MyeK/vQyhTWzPqW5kkyYaTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twFnRIT8; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509134ab2d2so52358901cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 02:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034703; cv=none;
        d=google.com; s=arc-20240605;
        b=aPbTSjqDadiA/So7v/4nYh1oaXw1BLXAW6vRKj7d6ePjjOip0HU8Ip43rkjovvDbc8
         IpW/P/lt2BbBqM+wmoiMVm0ZtGauPIcgQFlOR27epAhpBU5M6Z+ds8mBK0QpU03HY/VS
         lnwfxnB60Jilbs27tORPcLgnMAegvtSJH/zDT5+W8PSKweLPi0RI6io1cnQPagh9kmd3
         O4xlhTgSkelYTK6Jq9qPokk4l3mXOrR/ZQawIhd7pNayeqbWM4R9TseqwLh7b+hBk1Y4
         CjKD1BkxvN6A9e8tFSI/DahpUuVJXPu1lFfqsPigcfphokpQKxaPUR3aqQ1HNHG4LYUF
         w9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        fh=R3kK73G9UUzE1BeYkxdv31oDNvbUSfZEoIT9+IZ2MDI=;
        b=UuFAwfvGhQjXrw5jLHuW0a3za+2ZgR75nV0lbSMwSe3t2P5ayjy3mHdmtFx7d0nV92
         Er9G6VTZJAKMIjdeW67a8EgzltA0Aw5GZW54a/Bq06GYgtT6r/690USHfeKZWcHM6RBQ
         9W3VXo8Ke6PN2KW9m6IybX2kVQn+bwatVNw6pRsV7z31lB2/eLorx7oXPSk0oh7omCQH
         OJaOnqEw4NzLXMFNCnf8nHf+yD4UmvqLnb6eg2NOAUqBlBmyAl9N0p+haE8q/gSkAHJ3
         dKXOtda/chXXoqkSk1OMoqNGRH3o8Lu9aFdSR2s/dBWctmbOZ+C7xVNQGHLc2UGB4KFm
         QCyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034703; x=1775639503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=twFnRIT8SirtW12uUCHs6hTeF/J2DOg5PKAmKI/mwRCncAk4AIvZwUq8xR7yTK0iJ+
         4ImgI8xWhYvzAYMKo33ksmbew7TAwPlXPwRplqecw+NYSPwHcYD8NcIFmA0v/FzgmIrA
         GlgznlRQinWJpsA4qp4IlnNYa4zu4LMzYJu3khv64uuDL3+ybWpc3gfaIp1N30uXymnh
         o/KWJm7bZFr+X8f9bK2b9IBUwDPo2JrcV4mBBOIg3fqCL5h118wWZzw/mlpOg5YazSse
         2pJzkr32Nm/rqUXZUcHdfdBBA5R+Rztx/u8eIHbmmnYHi26nHKuFO8CqGzwdfgZfHKXJ
         VrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034703; x=1775639503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=P4Jm/MytcSjZTV0vqB+K73JFJFnQhy8qGSe7hZilb1BaZ2u8uTfjb4j778fdXLcD4M
         jaySZybsprDE0NszGlYVLp/uijM51B/dR5U+FRYhVqyGoQqmbyURSc4kTklWzkQoiOgt
         h6csXnRL6RCNGcCFcCNHU0q5dTvNsZAVb1x6AGH1n+2WGUkPpe7vSmJPXfcHKBR3glQh
         r8DKJonbOGq6ObjygtfWUa1/4aZeNkuG6v/45BTg6wbEsPcgZ1Tvuy35pabhVUdYvhtT
         /1hN2HSjuhYivn9bM0RxcuBTDSekS9/dI+4dJAjY9Y+suV3tbqFppDqUlHtjwIKCuKVT
         JB7A==
X-Forwarded-Encrypted: i=1; AJvYcCW8MKDzWYlX9GgFN5X7EsnJJaNvA6+0dJPRdvffKPaHSAEJAPPiWhySsv0uCEm26v9yPAoXepAorFx5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bqBlREsgtf8apeyGWMUosKMAtX8F+eYPlY8QNGITwh1BgqD0
	ZJrHLSiQoGqMsYSXN0hD7qBLGPOxepbHHE8Xl3iknoXHdGb8VEarAUdgCSk1HIrTUmuE6IulMrY
	944B+/ZIfA9wDEroulq0o20KYze4oTB4hzPUFcOPA
X-Gm-Gg: ATEYQzy0z91+OyK/rxzXWwx8qRShyvuxHyVEEBHE1fPhNkc6xvAlAT4Vt76FH4OrVB/
	UbHNEKOtdAzxiMBIcLUTTFd2M9PmNm5TeAfOArxNfgM1xD2oq3r/4TPFjInpbBy1my4X7z2V9xj
	bZxWdCaegHi8ssqHPrWGqId1lryBRNyQsAkjSeP0mmPr0oZ83KiljfD3FYZ9S+kNlPYkkAwi17R
	/pd3hJD1vj85vOWg0Esyq86njlgmoplhEjUs8WMq+HS57on4vru4XXL4zyqMZNUVl3e6Pl0RuaS
	m2jcSwk/Bu1Cuopy
X-Received: by 2002:a05:622a:5909:b0:4ed:b2da:966f with SMTP id
 d75a77b69052e-50d3bd84b29mr44808651cf.31.1775034702251; Wed, 01 Apr 2026
 02:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:11:31 -0700
X-Gm-Features: AQROBzDMpjzScINQf3v40GgXHFr7zNRIwe6Qb5aBvyyAycV5Up8H_bwJXHOzd_8
Message-ID: <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>, 
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com, 
	bridge@lists.linux.dev, bpf@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18885-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4874377631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>         struct sock *sk =3D sock->sk;
>         int err =3D -EINVAL;
>
> +       pr_warn_once("process '%s' (pid %d) is listening on an AF_INET so=
cket. Consider using AF_INET6 with IPV6_V6ONLY=3D0 instead.\n",
> +                    current->comm, task_pid_nr(current));
> +

Some kernels are built without CONFIG_IPV6, so this warning would be
quite misleading.

