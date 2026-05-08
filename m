Return-Path: <linux-rdma+bounces-20251-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ik0GyP+/Wl2lgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20251-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:15:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F14F882E
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980F63083A31
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8A3FCB1A;
	Fri,  8 May 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwhlcuSE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B513FB060
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252599; cv=none; b=ozpa5oGfrj6LkJF25iDcEvjWU5Mh/GKwlT/oaPjgr8H85bf0Gfhllexyx2UcoXZYVpsLh79tDeiX6I+TZxGLf+FveFivGWanV40WTh8ZpeFPiWY4AvDY8HT7oPStda/3TYactDo0MOGXpwZf8DXRpwa+ZbAgx/1mFHPT5WVVZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252599; c=relaxed/simple;
	bh=Yc8G/OYaz0np5e+ifQwa6O1CU5HmHo+b4K8v6Tjxvs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ1G7nWZwsZ89vYRJbqObD3jQm/mQcFz19hM0dpg9aM9D8vayqehnrPvTuymE1J7dNn+4QsRyzEQVQqmajd300O4C1zQLA/MQpAdcOUkbq24mjiv4aGG3UPk3AYMivmDNuiNVopY2TvytnGT6nfpt4JH7Lz2zqvg0ubdBdf0sYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwhlcuSE; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c80148ae949so930983a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252593; x=1778857393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCvkvD50FsVxDN97c8Hp0jXUGucP6UrrTJOe2Js6aRE=;
        b=iwhlcuSE1RFQW2tMj7c6OHS86RYq0Cr8bopzDoWjdgEhNUOx91pEsF8qHLVtRoYcpX
         toDk8UOGhdVxf9rWykP63/iEbJY0DCENeha6M0qNKzWdhB8uHse6vuj7omiMm1xbPzhf
         diAn5UqdUa5AiqVush6Ex/+pFWzc3Hp6J2mvNO/KZa6jj930gJ0w4gSYuJVWFs5RAIMR
         dGvAt4A1Cm06wdzEsAlmWhtrKhn0lK7euxhaaBB4EgQfcdMAMqN63yyYmfKs4L7s5rA/
         lUkUdTkx52qH0L1z6gQ19mJJ/hFM/sdw/C8NEQFHJgXBy6qKO4bjXgylqqitjrKLaQVe
         xrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252593; x=1778857393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCvkvD50FsVxDN97c8Hp0jXUGucP6UrrTJOe2Js6aRE=;
        b=EpObG7JL9i3HwPDhGbGRAv8Zor6T1049R83P7hbDtB7Bm9D+G4NPQQ6hdUWR9xp83y
         e1er642L9VeHiyhi7DGe0TiOHrgAdyFZdcN58k00ca9pYRcM3ikyNnbIbtkPrcEeUgOC
         59iZ8+8IopyazxBrhIMcKNVvP/y18gT9wkbzOTO7Cn0T/hBK4jFJDpIvUudvNM2Nyfgj
         +mpGOKCB9CQFg60ogP4Weq0+dNSz9csE0T3PK8e+96z4RoG++ZwQ7TYtawvT3a7LxXw/
         fh551+acVA9R53eSsnaBIVQztY/LmSIlCp7R38v8uJYY/ytkutGG+iKvcaBhbjMLtfm8
         F0PA==
X-Forwarded-Encrypted: i=1; AFNElJ/qVCREq0CDy7epja2VtPVIMlWSLrZ98l/qeyRjFjaw2/LdPobmwPKdzHLdhCOcbJwTVrUgwtgWhmkJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaomyxrCP1ojYl8w1P1iAN4LTSOpHxYu+BAXKoz49tHFkgWZb
	PLOgfrJrzmJQomV7j0gpwdem5r5ojDDNOxa4RlMQj/yMNjaNwydr1Mv/
X-Gm-Gg: AeBDietjvUvElbaoPEHHZIQ9gf40fH2IT64D2MDQ84pvRqbmAbOF/tGlku0fvgVk0TU
	N6wYt/SScB0GjgogNOUq8Zf6Sw++ai4PknA0yRsNyO8XlWuATsQwoIWOXkm/NaHNvcVCWemVvJo
	LL1GzULeBsmUg61I6NGmDVs9q1y2iIfcyA/4jI2xRJjvJnfmAim6dcYW4B6SsB5XFe2fHYy7HiN
	03R/PSOYo/aEeWhNvvnIgEvVowbN0UAvLWbzqyjmzKj9/EnakW4J9qZHjhxDVlAvu+rvm0M/XrQ
	gcdV3eAyB60Bkco/0jEhoVL+PPO2no/lRt/8pxJMJQFZG+SZPeKY88nPsMpduoDLkOjGRLfhmR4
	TEQitFx29e5TmJ5Q9AUwf6rRbh4t+4Nm2U/lbp1DmepcBKod7wDQuTRdH0tDMv6FYC4BHIuydgs
	JuVNy1/wt97QdC3r7P
X-Received: by 2002:a05:6a20:244d:b0:3a3:a69c:216e with SMTP id adf61e73a8af0-3aa5ac23e75mr14422053637.38.1778252592814;
        Fri, 08 May 2026 08:03:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396594645csm13180339b3a.14.2026.05.08.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:03:11 -0700 (PDT)
Date: Fri, 8 May 2026 08:03:11 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Message-ID: <af37Eoq2TLjhI7kx@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-6-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-6-52821445867c@meta.com>
X-Rspamd-Queue-Id: CB9F14F882E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20251-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,devvm7509.cco0.facebook.com:mid,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Adding netkit-based devmem tests is a straight-forward copy of devmem
> test commands plus some args for the nk cases, so this patch breaks out
> these command builders into helpers used by both.
> 
> Though we tried to avoid libraries to avoid increasing the barrier of
> entry/complexity (see selftests/drivers/net/README.md, section "Avoid
> libraries and frameworks"), factoring out these functions seemed like
> the lesser of two evils in this case of using the same commands, just
> with slightly different args per environment.
> 
> I experimented with just having all of the tests in the same file to
> avoid having helpers in a library file, but because ksft_run() is
> limited to a single call per file, and the new tests will require
> different environments (NetDrvContEnv/NetDrvEpEnv), it would have been
> necessary to have each test set up its own environment instead of
> sharing one for the entire ksft_run() run. This came at the cost of
> ballooning the test time (from under 5s to 30s on my test system), so to
> strike a balance these tests were placed in separate files so they could
> keep a shared environment across a single ksft_run() run shared across
> all tests using the same env type (introduced in subsequent patches).
> 
> The helpers work transparently with both plain and netkit environments
> by inspecting cfg for netkit-specific attributes (netns, nk_queue,
> etc...).
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---

[..]

> Changes in v4:

This is a v3, but you already have changes for v4 :-p

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

