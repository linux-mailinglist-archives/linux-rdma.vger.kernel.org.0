Return-Path: <linux-rdma+bounces-22807-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sM0lMoUETGpyewEAu9opvQ
	(envelope-from <linux-rdma+bounces-22807-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 21:39:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177171515C
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 21:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cQXQCXk2;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22807-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22807-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32127326CDD2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E84242A170;
	Mon,  6 Jul 2026 18:14:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09F42252A
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2026 18:14:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361668; cv=none; b=CoiLAkUjTA9+TD0KT+hVWzctoq34hzwWjeXMD36KRDHGteCq8VpvMviyTU+utgMpQtv+w1pUSikVkXoEGv6vtdAeEals2YWT84GPv+/RESFDiwasJEYdACvtmF2Nj9UffeRGVC/AONi3KNt9ZBuwuG9dSndLvGS0xQtUu1wNyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361668; c=relaxed/simple;
	bh=ZZ1exXk7oGlPYShd89mNu572yhSOwHdjoPg0JPA1PqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW5acHqQr10MsbwmLaXHDaeElWCnadT5KPFgBL2B6fijzh8MIS1yYvdXdhfNnU8ic+UPiuNQ8ywrzfDz81WMgqe2fzDvPecY8OKIYfTAawtRP1yassqJD6fDKHGzwyr86bssCA20x4VS7eRMp/qYH4CQyMDwXW7WZql+ZrvsbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQXQCXk2; arc=none smtp.client-ip=74.125.225.130
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493af9b574cso2490175e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2026 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361665; x=1783966465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZ1exXk7oGlPYShd89mNu572yhSOwHdjoPg0JPA1PqI=;
        b=cQXQCXk2lA/b21m0tQMfQw/BHnrN3/05cR2v3Cxno/7jFiX3fEU0renl0Lo502D7kA
         Zc6R4CX5ajnXGx+Qg1IzKbjJkTggJ2qQRQis+20jK9YCzVilWAH+ryDSm+k7dflROlvZ
         CdxnzVsXa8qZ7B4X82YKo40WwXkMlec5EiIqsmuFithFgVASvRqtJt0+SnD7c76kkiJy
         LLCHGsKZD5N52BECD5GFXN/d+UwQxXQFqrvvRKWx/PCcvU7IlZDLZL/BKULJ5zxqYqa0
         c7hyP3RDZBdM06AeQKhYMvEPCpG8SUeCBA9QLnmO2YW7EDu8B74jVh7xTpxVXqKNqAHT
         8fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361665; x=1783966465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZ1exXk7oGlPYShd89mNu572yhSOwHdjoPg0JPA1PqI=;
        b=hqt4H1IkEYxiHq91HWttRaZXF+YPAa9nH61vSv8lJXfrpUZvDcoPcx1mVM/zNnv9JV
         yM5DFrp0t+IPl5Tkpucqpy0UgqEr1t34cV7J4Myn/bSOdNHaFhm1FH/WO0OWJTYpPgFS
         YnkKeltHHe6Vf2gKB0vI06v5lh/CYAJxEyZ0eXnkqtjyhY3RR7mbDGFVhJcmqoNL1WQ/
         ISmaVVbzYYJlRwrp+4T0//txDRCHrVUWJ7r3TvIxnZ1PdHCZK1L7KQLFVqzza+vKDsgT
         pT/O6l8/qX9iSimshu+IfdOiZ/IRiey9xYWhpOl75kYXSuKYS9Pq/BLvS9Vwckl+TOLi
         42+w==
X-Forwarded-Encrypted: i=1; AHgh+RoFP8Q3WeDxwj/PbRt9Hg5bDXZcz4g6EcGU7p3ktifd2QteQDqKLu8JWaTvTXCNLs/06KoVWtEpJldT@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSlGREI7tnFe1AQHa/oRJ7r8jmwkrPdlR88kzmL9Jt6lTy8ij
	HeYJow/i6RKoqXZ1+jELjQP3LJNATM4YX4SJdoFVq5nlLLeKWtex/WlGw0YIq28RDnLgXWK3
X-Gm-Gg: AfdE7ckMDvVgawp8wrH3F6xjakfai93DS8JplsHsvj9zg+iYUI1WsRvEjN8fu/pvRSn
	bbkhkMHO2U5xlJPKg0TLfjsI8RA/r1yfA8hucgX0X+XgcsqJzVN6DHcL3/vvD5nMhPEGQODszMN
	3AtDfErN3lAM7CgKNMhdhrXuiqExmgiGa4EkxkMLP83DynZ0eDzNxWdVT42QESiukw7G/+Ob9Xo
	3uoYkQ7EJRoorGXkzAFGEr0BTxBNycGI7lmTyy4gXINj7DuPZbWEtQwJxVmJQ9nchcXgU/O+W/e
	gp8weOXXmGEMZstKa1qqtAmHB/UalEXnHCYfXIQJko1tIBFBiMbocD0JETLBz0Z3dLX6zf/i1vy
	Qp4H/e5spCh/m6AgU5S2oBE5Cic/W1GizKqPnmBlRbYwiPsXdwD8n89ETu04sMfKD8J/vqU0zER
	ZR+xpEHXxMemY=
X-Received: by 2002:a05:600c:b85:b0:493:c14a:a1ca with SMTP id 5b1f17b1804b1-493df06361dmr18240785e9.3.1783361664717;
        Mon, 06 Jul 2026 11:14:24 -0700 (PDT)
Received: from fedora ([212.253.209.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e01e658asm658925e9.1.2026.07.06.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:14:22 -0700 (PDT)
From: Serhat Kumral <serhatkumral1@gmail.com>
To: yanjun.zhu@linux.dev
Cc: dsahern@kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	serhatkumral1@gmail.com,
	syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/rxe: rework per-net tunnel socket lifetime to fix refcount underflow
Date: Mon,  6 Jul 2026 21:14:04 +0300
Message-ID: <20260706181404.6687-1-serhatkumral1@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1a4f521b-796e-46a4-8992-dc5955e463b4@linux.dev>
References: <1a4f521b-796e-46a4-8992-dc5955e463b4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22807-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,ziepe.ca,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:dsahern@kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:serhatkumral1@gmail.com,m:syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,m:zyjzyj2000@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,8c9eede336e3a843750e];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2177171515C

Hi Yanjun,

Thanks for the review.

> core problem is to serialize the dellink operation.
>
> This commit replaces sk->sk_refcnt with the per-network-namespace
> variables nr_sk4 and nr_sk6. However, this change does not actually
> resolve the underlying issue, because it does not serialize dellink. As
> a result, the race condition can still occur.

You are right that v1 does not serialize dellink itself: if
RDMA_NLDEV_CMD_DELLINK and the NETDEV_UNREGISTER notifier run
concurrently for the same device, rxe_net_del() can be entered twice,
and that device would then drop two references instead of one.

What the per-net mutex does guarantee is that the socket pointer is
cleared under the lock and udp_tunnel_sock_release() is called at most
once per socket, so the refcount underflow / use-after-free from the
syzbot report can no longer occur. The remaining effect of the
unserialized dellink is that the shared socket could be released early
while another device in the namespace still uses it.

> One possible solution is to use rtnl_lock(). However, this is not an
> ideal approach, since there is ongoing work in the kernel community to
> reduce and eventually eliminate unnecessary uses of rtnl_lock().
>
> Another option is to introduce a static mutex specifically for dellink
> serialization. While this would likely solve the race, it is not an
> elegant solution and adds another global lock solely to work around this
> issue.

For that remaining window, instead of rtnl_lock() or a global mutex,
v2 makes rxe_net_del() idempotent per device with a test_and_set_bit()
in struct rxe_dev, so only the first invocation drops the pernet
socket references. This keeps the serialization at device granularity
without adding any global locking. If you would rather serialize
dellink itself, I am happy to respin that way.

I will send v2 shortly.

Thanks,
Serhat

