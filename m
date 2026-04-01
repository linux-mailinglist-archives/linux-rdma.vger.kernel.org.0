Return-Path: <linux-rdma+bounces-18886-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHnTEjfkzGmjXQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18886-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:24:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A2377855
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 128B0303D642
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3443CCA1A;
	Wed,  1 Apr 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcbMzFc1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD153CBE6B
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034901; cv=pass; b=SRwranEpAxKveIYSNQ3PJ5DYlGvtYqu02rx4mc/lXs/BWyfTaLYEfsZ2d5G8mGdYUIGtq0Fg5PyMiw0TTh2r3eeg5ZS58nxn3BwgOL0bxmuEP0JKNnMwX6nVJmJzElmVYLmQjIxaLYG5262XRzMSOpYhpTjs4y/R2rlCM7CGYMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034901; c=relaxed/simple;
	bh=Px8VZ/mZa/wVBiSvlhUqswxvgLPunBza8vM2mBYbtJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND3vOCHk6MNKIxh0xZ/lG2DHhWD82OIq7uxy4RpSjIpUNmdgD4mMcm7PdOcLmuO2mP4OCN6mC5oOMEDlduCJHe2VrMcJ+1uAN56qgJbRzCVxdhQV/82GqzxD/wMYvENuSYrfqKSZ2t7HDoASoYux/2LRziXjuBtOvDDEMjQ1ANg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcbMzFc1; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd7c372929so718521285a.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 02:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034898; cv=none;
        d=google.com; s=arc-20240605;
        b=FI/X02A//YU93Bb2GF7+fWHhkl//B5aqH7skli2+Wigh0WDizORYkIpsJFMGRit6Gz
         m8+35d0WRnHBsb/BTEPoxiHY1lGMvMVO1SXiDQwwTm8K5rQV0fVDBPyLE59pKEH8QEQ5
         JVd01kZ8cyX8QHtEmclq6SpglLObyVS2k4ob37r2Eb5053UuRg/XdI9cWS/Jk0jSsvlm
         gmWNNNMPUlIWN1UJ4yuxuxezw2sjEBEmPamMxvfxY4IBWCMGm3LsqdZAv6A669DvuyLt
         WAZIFgcwIZUU6oUPLsIpKQFYwx520ciQMGL/K4do12jNLuqMcWzwPRl4ETCej5aOgQ1r
         xWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        fh=w76YB9mvkaaL3xDr1qXeWfaJYLMnSOPCD5CuJtsY+ms=;
        b=FOzlFSo/H5CDD70/5FNQUxJ2MDaVFZLaX4Yv2c3QZ290oNmu3gU0R5yfCCaTjL9LK3
         rbpzIyaAB56h1vQGnKbUNYQRh4gp+snrXime/eFP3xxhFy/C/oXiVYmj6rh3zaGDDORb
         M15K3QOSGKVrIt4JrnmzTHbg/jDhUZ5r7RPpfxhYu1XCfjV9Ib7pJKS2iRloEEKnJUQO
         LGHqCmFpgs0SLUTBQiRrj0cf3goSPCqVAxfF5tPlV14qRleGxLjzyCrpCTSztOST26f4
         qA9KctfVzB+DNBiV6+1Acm2nf0qloiwhac5k/+fOrBoLcDeBNMLNtSaUUELvlej5iJcO
         HMmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034898; x=1775639698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=PcbMzFc143UJPNLa1IszL9pPW8NVryFgbF485R7GCAGuU6p+ZrBk02ECuyE3QGpPPR
         s8PmzFSS1wArBXxvuc+UtXXMnAOwCJ+jq+1vNSV+UniMmd1Z5E8/yTmPY7jdYzGGTVr6
         NzWp9TOvjIix3ogAaxIjggzONpWn1bnYrGEVP35Jv2A4mKUlB7v6q/VKR1ubhl2Awk3s
         Kxcz59bI9slSkfdhXbqubS/KzGRsdYjcTJgVAK0tjaZi0oohw05fsUO/dcsMUFE+pl0E
         aVByIpngrWTZAFOiI7hgEJOSTa3dRZmFq7KhzfK0ZJxLzy54WLBvphLnzo2fZIpudTwx
         M7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034898; x=1775639698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=DuL+gSHAqYjEQrbChW/k6TpsZXtqTf+bDFB89mQ3H4C5jZQljm3kEZ67qilpYUYcRz
         rNXvz3RmpGSic7J3KKi8CTMaybPiG8EXWD76SfDGVsFc1QpteLknjkZz6yyuzDhMwb0A
         pQ0dqpwn6Ox78A6QzNmHjMNcXKayhbUkqq86Pw7ZjcYdt+1kTzCyInN+D3jsxEKJ337/
         kLNmPsrqbgTzA2/nJIH22YgzYD80tG8unrqod8MdTb49IKAB4zzOeDNcczrCKx0oNcqY
         C7Ux9MXcV7wG6BgWfIzNcf9AdIjegCyywVctkZ0svqx+0J8MXsFcW1cljMTcHsxHq005
         W0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKDBbT4eH79H2k2TPcho3HaEblWWhmxP88tD83lhpj3hYfKTLHdUmJf7C0GqRUYs4JP35RL4OBTZSG@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/UX9z+zSwZuPuhJw7ZPk5cVcnhMx4s2+YRmZGNwJjragThSw
	6vJiSeFYguVC1iQj18dH273Z+OAobTwkWKathVgtUaY3d6eR10zGO+z4QMIMyjGG9QjlCtFznP6
	6qn3tVnp3NAIRULMEnzECSHwhc5UfSh/yUATnl/jt
X-Gm-Gg: ATEYQzz9pZPQ7dFFeh9ZEOvrhElZv05qPTqn4Iw1QtgGWe3KeNHAcXA8dbPNnJOnE0A
	dgxuM1qG/nIxK92k1sPdQwqhxMVTlK4rkGmY0qeTXuRnfuK79LQ7UHb7jHHHXDPEjDkSw6/1aov
	eEpeaHg08LU6JxewQFhgtaPvBDiMK7euoV+N0wTgmCXyhRJPdWk9Fd1hNFFYBEP07UjySHb4ZmG
	AVdmWbKUUidhSaZ0KpS1mZQfA0uYiRxvicRcVJ2TmaL1/YVfjVnER0xgOOpc4aSYgzoN2j8uQIx
	7R0yPQ==
X-Received: by 2002:a05:622a:1c05:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50d3bcf5f5dmr36705111cf.50.1775034897967; Wed, 01 Apr 2026
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-4-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-4-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:14:45 -0700
X-Gm-Features: AQROBzAoGbAvZgGI1SP1QOjEPB9AfHu4JQqffzH3Pc3uWqwtvvbxFW3VGI6Tc4w
Message-ID: <CANn89i+iRUgqtd+eirfSUM3k+keNZKzLwsHxZtwE+vHdv7H5PQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
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
	TAGGED_FROM(0.00)[bounces-18886-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,amazon.co.uk:email]
X-Rspamd-Queue-Id: B35A2377855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Wrap the IPv4-specific registrations in inet_init() with
> CONFIG_LEGACY_IP guards. When LEGACY_IP is disabled, the kernel
> will not:
>  - Register the AF_INET socket family
>  - Register the ETH_P_IP packet handler (ip_rcv)
>  - Initialize ARP, ICMP, IGMP, or IPv4 routing
>  - Register IPv4 protocol handlers (TCP/UDP/ICMP over IPv4)
>  - Initialize IPv4 multicast routing, proc entries, or fragmentation
>
> The shared INET infrastructure (tcp_prot, udp_prot, tcp_init, etc.)
> remains initialized for use by IPv6.
>

...

>
>         /* Add UDP-Lite (RFC 3828) */
> -       udplite4_register();
> +       if (IS_ENABLED(CONFIG_LEGACY_IP))
> +               udplite4_register();

udplite has been removed in net-next.

I would think your patch series is net-next material ?

