Return-Path: <linux-rdma+bounces-20585-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDN9LoSsBGrvMwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20585-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 18:53:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E75377B4
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2240032D6F09
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77384A1396;
	Wed, 13 May 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcv2C2Pb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC6495520
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689230; cv=pass; b=LJ+VVl2dpfr6lpMxA1VqKZdBvrNhlfdLoYCyBTSAQHM3cVBnB1kri6BsIvwfMpr62lxMkjRPIp0NjP1UECxJ3L9WgJlj8sF8yCteieoFkR9SA/HUBUfSf/WLiDYLQpUvbhNygod8oTBDsTAjqRJk6rL3ucsnxHhNjPxIavjVmu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689230; c=relaxed/simple;
	bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haI7N2SlpWH98zin43SW/V9Wem0Iy1iHZJqk/yBzvZqC9SL4z6KnTzh+w+ponmvPbfNPHmkpNuumSkDYc+pbeatGSTjHPLE66ksmVGD8K/AW0TWb/lEtSWC7lzsDpIihJrX1NU6eW5twWEkUwLMPbLjoMp5EszFNnxG/tcdBYo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcv2C2Pb; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so412a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 09:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689228; cv=none;
        d=google.com; s=arc-20240605;
        b=eZk5YVexjzkmxktyjV7EAtp3h/10o2CACwYGzswSacig8rkDcreQm+Ye6bx21r5CGT
         VM3fQ0rfceL9vjcz6mo5HH6RnZR8x9sbbSnGswMPU95rfis+vuGG7gwzXGPzTv4lHnvQ
         4nsu178T98M2CgcC6aJU8339R0YzMG6O/DPfVuAwdZJBCfoORx04NprI5NK07GETQa7T
         gRPaLd3Rf0aTu47I8H2dhW9q8RzDgMyEyP5uMmqXqasyoEYECgz3zrgkEl5VWfWvczhE
         4Mi55vHl8ViUzLuuc5mQIOO2geOQ+sUMFlxN0xucZO+wDesGECkkdhmXtuOHDbimktu4
         gwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
        fh=qx3tzZMsxmayaCdCMw65sCgPhJJOaaUNm+U7lzXw0es=;
        b=V3pVFaKDAR9E7MmK4a1UTCoPDb80eTcMuEM4zZkEKO2mbRGVxcM1vM2kCXQTxF/ekT
         RPgI6X3DAWwMJH2YWyZleCWfCY21O8TjWBB01YaNQAAzXzrPPJMjVawoeRzNAXbkNAUp
         /naEL6v/69gXzdxWTDwZY3688/8gG4BzwzMWzMjnMd+xdgidpEr0b8xQzLs3OpMF8wWh
         L+JShVFGXa5qtlvQAXschk/eacKUmEIrJqgPgYPAzZvgmoouFAXwLfjT8W79/fiWMUEA
         yzrnvlPh7wnc/wBaOoF8l6uNvZ88iEe7CZ/X7GriDLZsAdHQ3+QhfBXkGFnDlrorlhhv
         PHvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778689228; x=1779294028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
        b=bcv2C2Pb5BbAxkjDGC/Ls88uXgGODKKzM6B6ZJ+ZTPGGvpKaPY4erLix8MH4+WUDFM
         rc02AfmZo5Y4xBo6l3X116tYg3xWV1J/yycnEHuJEgrtJ4cziwL2NxUULPaujYjU1UVK
         ECQ1Af4dPWBH9uWNH5zphhUSVbeP9Z3eDQ/d6aaTYkJhoF3kwC3n5kEWjnWSLr8hQrBc
         6IOzYomk+KR6h5Uh6bwengHL0SuXn0IF5D1zGwkfFD7Va6EiOKtm4P0FI12051jFNAPI
         UXh0ArEI1bSzIptkLpkBLek3/GFqWZhnQmqMG+ZW2Jn/9CoA5nJzGh65rjdd/QuN4KXQ
         4DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689228; x=1779294028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
        b=r3MFOFAtYoQB+x4X93Fl5vZS4yXHYjXUr1pnCNsxRhnlo/6XIOZUrDMwcsUiu0FcOx
         Bmuftz4JxUHNPOftXx8keV7B5ovM/xwg0OFxbA6LAEiVBZtMLvxX6yVstHOqT/9UD7V7
         8+vX0z3wgXE+XmXkq6pNcXcmKh6YSfxCIVDwPjUp3L0lCbNBgkDz9l/8li+1PEoWlmjq
         BIeg/5D4v66GDzBV9/wddV0dyhsTTn7pM+cHBt5jqMeT3I6YtE0u73+bdYTxH4cO8l3G
         i6eAbcX5gsK3ct7Na6mJa24zXtFmkYJP1h2ApIKSGdbS+RWRkv+eQHvD8hU2n06ns6Zp
         YjEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+s5MsBRRMs5Irw4+qjNBE3DzpR8vLvzs3/Y80XMvLGOd811Nk+pQ/fiJWPx0qBFnZzB1UmuxWinHvi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/k+FsnbMcawMgMHf56cd7GxvINhdKu2KUkOoQlNggLh8SWRl
	EsYQCfwDZ1OSEUJCParufWxKHdS0qEFM7mFtGBj7q3g/phNcS0A7I5gDicZBtJukrxg4IkZAzqt
	vVUwl4BcPH97MFNpyuhz0Q/Mtapq35wYNTzHk34Hj
X-Gm-Gg: Acq92OFKs/ThRpMt7DKE7RYQu5jWiU6lssEcjQuNsSEWzO1a+ZUZnA/3AorYLzUBryj
	Fy9gLEIpc0FE47lxFtfIizzwehkbmMcvPo8DuC3cmprltrFRv9+QzIklLOukdcSP6QefIR6/EdL
	5T5depFPv+nRSAE1POzJ6KTKyfRrDF9dsd2cwr9DYl3nSHmUcim9pwDddV25EgzeY+OrO6Hi40a
	Jj1wn06+FeLa8IM39/pCfPrf00JMu++gpHolFL30DLOZp2cgaSfM0ZjmatRO6yNDaFUyL4ja5mB
	l4X1HAyX3C+yRxbH6I88IkT/+BA7+y7ZjP3B7Z0gcOaFd30sU8vlW2PUEBaNzdi+LmfXtkP52aW
	Zmg==
X-Received: by 2002:a05:6402:a554:10b0:682:a2f:a15c with SMTP id
 4fb4d7f45d1cf-6827c43e148mr52503a12.11.1778689227392; Wed, 13 May 2026
 09:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
 <20260428184631.40f1f1b7@kernel.org> <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
 <20260429190150.417b0302@kernel.org> <CANkEMg=Xc9jN8McZmLerK_ffOwRFfX+yO=4Ha6+umVogbkBj3A@mail.gmail.com>
 <20260504181022.60ee2a1a@kernel.org> <c2258e70-4c2e-4999-8876-ad98f4259eda@nvidia.com>
In-Reply-To: <c2258e70-4c2e-4999-8876-ad98f4259eda@nvidia.com>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 13 May 2026 11:20:16 -0500
X-Gm-Features: AVHnY4LR-7un0veJqtGYLAWCLE6dTqG73RIFCxJa315MJ-hSMZ1fDaAXA4SUzUo
Message-ID: <CANkEMgmhh40uE8asRO3WJpAtDZWDcSjJNVCzh54TgwcMUonhdA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 151E75377B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20585-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 5, 2026 at 1:21=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote:
>
> Hi Marc,
>
> On 05/05/2026 4:10, Jakub Kicinski wrote:
> >
> > Sorry, I don't know mlx5 very well. Sounds like you have to talk
> > to nVidia or/and run some experiments. The current patch is a no-go.
> >
>
> The hardware offloads 4789 by default, hence the
> UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN, you cannot simply remove it.
>
> Have you tried disabling tx-udp_tnl-segmentation through ethtool?

Thanks for the responses.

Gal, by "the hardware offloads 4789 by default," does that mean the
hardware offloads 4789 even without an explicit command from the
driver? I ask because mlx5 does send a command to offload 4789, but
perhaps this command is redundant and only for bookkeeping purposes.

I haven't tried changing the offload related ethtool parameters, and I
will, but I suspect it won't help in this specific case since the
perceived regression involved non-tunneled traffic.

If the hardware indeed offloads 4789 autonomously, then the perceived
regression we saw might not have been real or related to enabling
vxlan.

