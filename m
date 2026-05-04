Return-Path: <linux-rdma+bounces-19966-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIsuH2Mh+Wmz5wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19966-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:44:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4B4C484F
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5D8F300AD89
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 22:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A18B387581;
	Mon,  4 May 2026 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgjxUrbz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116D333730
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934680; cv=pass; b=Y1ag4bN0EL5RaL/7L2jCyChAxtDZRFXybUc0aJGDAUI8osy3NLoyZNLRUrXpVuzOkcQ+3PMqdEaPD+3pReddbr/Q+4I/1Dun0IrscAIoXxlH8SpW717GWHqB12FOIPtOYmUjJktDbQQw0OoiHLQRN4zZ00lSlA+qzzPJ3qwI1qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934680; c=relaxed/simple;
	bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsnP1BktmGyPpQidla6g1kswuuFiEdcKNKv2U0npJkeL9VVEqLG0Q25IgvYbdScUPne8IMRWQ/LejNFEzeGhGazsIQxSEuFAzAGXeP0EKoSqlI0A9A5483xtRl1QgG3rao1FUdMUZrhyJ2qLemUOrmfnqcQ2NDI/DfdIsXk3Sm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgjxUrbz; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso2264a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 15:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934678; cv=none;
        d=google.com; s=arc-20240605;
        b=XNEwjDNXOXgk8PxqDTI8Nu9zwIRyWXclBaPDkGIDOj4SX86BuQe5KCRKcUReaMRXgn
         HM47qHCqI7BN9HCkg4FIYZbnpuuaP2VRtfjm/Bqq7oXvf/WEDVJQJ/BwyXBMs8b8V3pJ
         ukHk0I4I+z5uFlI/7EA9eLy9Wq77Jw5vdk9CTs+TznEVXMnaPfzTZs7SxOozFD+KQOKh
         hdb7gNwxufbjmDY6Hh0PL3w1tF2SoslDq+lpSi6wstvzqoFC5VYvirC5Gu3yDUD/Xl7/
         hqTpOEHm0HFqKNbqBrSQa+DAhdjSX7nY9E+LOB193BspdXRNkueMrnWwTfApfFIeoInJ
         x8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
        fh=ruR0fY3lPdTlSJCIb2xxSHVqCN9LF4HUzl1HlBAqQOc=;
        b=c3rqQ1n1/4q91zJg7586XH7p96xeMmszTCFKe+qu5X49mYkuBszi4kQrO1Q+CDgmbD
         Zw8NYEXifT5tNAo+hzJQrZO8mD9iwGs+dXrm5RDZaGGv+6Df2npVauoWXEwg/krwHd+j
         2GUvi1gCOE4rw5JYjGq4wRTnriqneUphZZFIHF+bzgKxBsy+w5yWGuUNxraDVUSR0jee
         L0w4Nd5WZWB5lP+Ied9GmOUQBzUKr1dMOHqLXtNmq68HZ1PJBtokJVNSHaxtELywzLOO
         Ve+Zr0tKNHYs2hdGNBqFRzcz1OCvg0sJIdsthyObXdy8UJGla2WJf4iBwSmRsEVB5At0
         zTAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934678; x=1778539478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
        b=JgjxUrbzRxZJnFoxwn+lkGfk9p6dyi2/BALGU2HDZARuAtdZT6q44GpYulSPolihSB
         6J8UQcN3es2bbnn7oeaWECe7mkGp4jPyQW9rEn8uC85TIZIhqSQzlEwNkYMiyCcH8Lfz
         Y23E2hwhegi/KLE7q/o1CkUUa5qogMoPCi18YCqXiU6hnct8pbCxdBqLMF5XxhUlDN2s
         UYQyFf/8X8zXlZq5rwteIJ6vkZzVVYjOVynO1M0rSM/G+066gwDGWcAqVGzFB6QpQrq7
         5NNBm8h3j05y30RJOVvmo4xvUd8mIi9lXiBFpJ3bCML/t7W/v9MYViO6CzjAuBMSxVuI
         e4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934678; x=1778539478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4g/aXIAan0ee1uFOoXPGBT468lGBaAVwYmjcBxQ4Oc=;
        b=mSY4WtB1CofNrCMLDDqjbAIxozQotIz9tpQ8xgLci4IwxvjeJLSHBLGDKffwfDacaQ
         /Ua2mTYT9x2E5FZp8+KoLfgLiNuvUhJI/FQglEkNsFvqGNuIfEEAGPH0zX/w+2k4g3nD
         yM/uUHrElURlLVOu1BEjzmfszBy61DQaKpaKafvVAolPtdzYv7QafCNfw3cC/sa1swq2
         H5DiuVgOSA4BSKqjF6mrDnk9jIor1PuuUjHsC55V7IgCX1EtWPliZo4skE+K1wBDp28v
         siZBFHg5YA/7g2YzVHrDAM12rkU80hxo/p8VxUU7MRal2g/TtdxpdkAtqE15zr7o+Xak
         QmtA==
X-Forwarded-Encrypted: i=1; AFNElJ9t1vdgmytxnOHojK8KNIAn9KZhi0HRnr6ch7IFE/+jF6sCJWXszMmHWAIoUTus62M1QDUpZB4WlZfM@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVu0+JyGU+4uATcDyTFrKxpn76IK1Wzj3omc03JwGCKaf93XJ
	qEv5aphwSJAQvNuJQ9ymPh6bD10qsa1xqnSV1EV5DgitfxiTlVSuioCVLm7KnQaKbC5t9DgiVM1
	ptmLLzdd3gu0s16L3E5cuyG+CWZ5BGw5j1q1hynMn
X-Gm-Gg: AeBDieu485DvtnUhOlY+C6HK9Rg8luBGljWX4AzGJZFq6HjQ3LBmV10o5tEgk3RSMyN
	l2eALjXaZnNV6ZMM2kp+FsflP8hlhp9rzVNUPYXhHAGyE9qXU3Vkz/KuNDnltktdiYRLBnRJ9BE
	V/TwQee1+rlbMSRolAS3uzVkgvMrZAvyWWOiRPbSzP+md3g/JOksQKph6hSf+Z7BmuuStAZh+J3
	eDdJB+6LiVbKgp0PYlcEp3dW0zqXzLRwjJuTucNdm3abOIegys+6i7r2uCEwmebvAN8+1U+kEDN
	mJzVgQ99QbgZd2yhjUBo2++Bmj4rcmadAi5iorJy4nEHp+/7HtB4idZd5qNwAvskAjNoeJYticU
	i/LRuT3eC31L9Qurd+GJ2lZcTxw==
X-Received: by 2002:a05:6402:71a:b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-67cccf0f26bmr7665a12.3.1777934677562; Mon, 04 May 2026 15:44:37
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
 <20260428184631.40f1f1b7@kernel.org> <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
 <20260429190150.417b0302@kernel.org>
In-Reply-To: <20260429190150.417b0302@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Mon, 4 May 2026 15:44:26 -0700
X-Gm-Features: AVHnY4J3w0BS71H3Vp7F7zgIqkv3XQzUGxKzlNG30V6pti40qOkOAPp-uV87PII
Message-ID: <CANkEMg=Xc9jN8McZmLerK_ffOwRFfX+yO=4Ha6+umVogbkBj3A@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7CC4B4C484F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19966-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, Apr 29, 2026 at 7:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Are you aware of NETIF_F_RX_UDP_TUNNEL_PORT ?
> I haven't checked it does exactly what we need, but I recall there was
> a ethtool feature for this..

Thanks, I didn't know about that feature and mlx5 uses it. However,
mlx5 unconditionally sets the `UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN`
flag, which excludes port 4789 from the entire UDP tunnel core offload
management (see `__udp_tunnel_nic_add_port()`).

So using ethtool to disable `NETIF_F_RX_UDP_TUNNEL_PORT` will not
disable vxlan offload for port 4789.

I think a better approach would be to just remove this static
automatic offloading for port 4789, mlx5 is the only driver using
`UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN` anyway. However, there might
be a reason for this, such as some supported hardware offloading vxlan
on port 4789 by default even without commands from the driver.

If mlx5 continues to use the `UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN`
flag, then some change is required to fully disable vxlan offloading.

