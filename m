Return-Path: <linux-rdma+bounces-19657-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB5UKwzb8Gn3aQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19657-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:06:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B57674887A7
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0AB3304AA44
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411B392829;
	Tue, 28 Apr 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q16Rg7Ct"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFE35A384
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390638; cv=pass; b=I4kmhjQdgIjccLE+xJxdxdP9/RrVaCj2WSboP9G1Qfkjg/n+kBRhei742L47drSIsBTGXdgGD5RfQFmft+yckQF3RZ0YJOk7jqmSkAeXLpXYT3aXqn7FqP8r/Abfz+IPCjGZxciQ/JunmpoZnCsLffYn3r9z8oso0+OLZZOAZ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390638; c=relaxed/simple;
	bh=V1TtIX/iCckhSPjdszHxO6qFRnUBFAjULVepW2Qu+Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9MVkoPIG09TTR1M6p5hT+VTT/JuMYYiqnp2/md16P73dFXBQ38TizstiAr+hs5RVWcSvTU/iwN0yHdHHOrnrUXj4iN305e27MZPDxgHqY3yxyfrDUW2eLH3T2hpGvQeuTZ3bQWzhxmizNoFtzg5vA30TQKGnC6yRdA3hrZRKxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q16Rg7Ct; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6530287803cso11325945d50.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 08:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777390636; cv=none;
        d=google.com; s=arc-20240605;
        b=SKjW+xUVJNHMWvpUmmHCORcA0hmwYLGnFlhcN7CuGwHzpsRLcjAHOQnT6A9X3OZlie
         hmBRcOhKqy7MKKAe8vZWbvfBGuwVPRSbVpKpnVnBroKwzSjIRSmJxqj6dy++Sj1+G98n
         TcpBMJYb9ns0JZkbHCBj7z+TQSm0B8TdlrFBRczeHbIrMG/qslXsGOgzyMEp/A508Zo4
         QF8e1lCf7OjjEZitkWMemh05DNtThai3YSVQJf3PHwM/fjquy+dFfbxvN/4a2rgwBQi1
         X90kYCH5esBm+BR6N3h6e14nVAob99K51X5rbU80TuaoeQjFOJKZpT6s90pqxt1O16G4
         xN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EeCSZMQihSoLfCaEjkAJJ1qhiWibtCZTiVn2NWtYWbk=;
        fh=QrxgCpPCG5nLQYicqWJNW0Yl6Z+qrixsh9OxvV1s2P8=;
        b=VNC+j+3FguojzLmK9cq/LEsWhjnFoJmdZW/Hm4n1zdc3Rt7HNOFsLm/V+yTG1Q/TC+
         Bl3JwNJD1wDh21bgv8IZe6SdEHb1O5tYX8qNyJKctcKqnzpjNL2qGWQ8AooBj22PvQac
         F/a+j0NVEoeTHNgpDYObxFSDUAL73BjxoUNQKC9JFXhuKMz0LfML/zPr4Snes9jBMdHP
         9LXIRS5YqQuZsRgfPxlvc3SF0VFldd1j/SXnAGwXwCiW/zsIg4mNKA37lL1PXpDbyJYI
         CqLebwOa9a+HBHE5Nqj/MSuFvlVUnZVuzfkJJPimS8pV11r8oYqH1vMHD/efMUs/FONo
         TzuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390636; x=1777995436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeCSZMQihSoLfCaEjkAJJ1qhiWibtCZTiVn2NWtYWbk=;
        b=q16Rg7Ctzl9Mzh5wRI16CTT3hHwB2iqDB46D1rr0VJRFktR3GUPnqHfocL0J6dwp0n
         6M69Bp0WXmjvab+b8YJ88w/7ZzQacn+G4hhFKelT9NKZ0eX82VVHv98d5hH0vr+h7FyT
         ZekAU+2Pp0X2kGWx3KM/M77Z0UZCEuFBs42mPSMoqlPA1RUHuZMVqQN4mkm8XANAUge7
         ZnLecV/lbMF9+GBVaAbrT3kSKNHEqqyT1ZCe6EmM2k6NAxKBXXdmQ9FRcftpyIpt6DSR
         fZpb7ws8hkb6+vvRRPbfgu5+otuQVLgIKFRDcKnHRGBzA25iPWE2Q0UEWxN7jQEEzVJ2
         B/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390636; x=1777995436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeCSZMQihSoLfCaEjkAJJ1qhiWibtCZTiVn2NWtYWbk=;
        b=G59wjFqFE/puj18jEu162n803QA6kxv6J1yW4AlQnYBz3ZUJ0fK1GFN9tDbJl1dI8E
         FTYIT7iGWCoTWbNzOb+1esbQoB90FxK3hWnRYgwPFR9snu7A2Sm9RgH373Ry5aS2YDcL
         wTSvdc/f5XQwwu/UVqqrlOWHnAM1txL8W4q7jI9F/6Di8koeoxs+5l1q1b8ANpG9a3uW
         6CbdM6SMOrsNXMbKZ2i3KCwuyKAoMSSw2pJvaOvloWsZbu760RMC+UqRUBRugs9PfEdH
         T7TpHVfW/betkomd4m8ctOjaITm6xxIV6EQr27E9EK4MmahKjkZCMB+oQPAMz+cVAcm/
         7oaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8H+p1hGCFpTubb9dJsl1WSkrN1yrBXamansgKux6TpoC4sHl3H1WME31eOgqhJ828clCWqAU48Wm6U@vger.kernel.org
X-Gm-Message-State: AOJu0YzAH17zg9WL9xi5ys427eG5Sv6V67afYVVti3qZvwB/vBh7rA9G
	K7dqMCr3JiFQ3HVIi+ybqJQAItPZplEHjMs5M09hOZEmqO6eMMEjYQZOo4TB81rpUFHZBHXp5WQ
	p7D0n0vR9iN2S7xt6thV8V0AnpBVeSY8=
X-Gm-Gg: AeBDievwIEB3x2BbHXj062Uz8JkIaS2YTCaYm88oLaKXLrtwDDcO0YkNM0z8eO86xs/
	Enj9AmZ7sefEuo7Gm60I7arb4k9uYEzoi4Ce/qq5b+LOPIP0inz57f3oZbJN0RVEOyduK0rbbZl
	wscNkTUXXe3qRaADre7Vjqaxd+mEKxNNvJfZrBw/nxHjCWEXQpjS+wS6WcOK+buNEIUZB6tZMxu
	VBstzFt/PbAzdSjV5KNB8JMyuOjT2pnyxcxuhGkxiu8AmnvxQo4vKHgISTUltdSZaJhzVVl5Ig8
	/RWYe2mKZ8SCEd+kvO1A
X-Received: by 2002:a05:690e:118a:b0:658:fc74:ed79 with SMTP id
 956f58d0204a3-65beed37b17mr3356969d50.11.1777390635964; Tue, 28 Apr 2026
 08:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413115949.2799399-1-lgs201920130244@gmail.com> <20260428143540.GA2647286@nvidia.com>
In-Reply-To: <20260428143540.GA2647286@nvidia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 28 Apr 2026 23:37:07 +0800
X-Gm-Features: AVHnY4KkUygxtZiOGzNnWJihtQ4bsHzFnByEuecYa_JlGLi4QJ_LnELCP7CDURk
Message-ID: <CANUHTR_=n8PSha-p5M=rF0pScTDo4GmVh2Ba+h44uL+3XCiq+w@mail.gmail.com>
Subject: Re: [PATCH v2] IB/mlx4: Fix refcount leak in add_port() error path
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Roland Dreier <roland@purestorage.com>, Jack Morgenstein <jackm@dev.mellanox.co.il>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B57674887A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19657-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Jason,

Thanks for reviewing.

On Tue, 28 Apr 2026 at 22:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>
> Sashiko says this will crash because this was skipped:
>
>         p->pkey_group.attrs =
>                 alloc_group_attrs(show_port_pkey,
>                                   is_eth ? NULL : store_port_pkey,
>                                   dev->dev->caps.pkey_table_len[port_num]);
>
> Along with other problems.
>
> Jason

You are right! I missed that mlx4_port_release()
currently assumes pkey_group.attrs and gid_group.attrs are already
allocated. On the kobject_init_and_add() failure path they are still
NULL, so kobject_put(&p->kobj) can crash in the release callback.

I will respin v3 by making mlx4_port_release() tolerate NULL attribute
arrays and by dropping the parent reference taken before
kobject_init_and_add() before putting the embedded kobject.

