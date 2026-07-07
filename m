Return-Path: <linux-rdma+bounces-22839-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /qt8AHIoTWrYvwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22839-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 18:25:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E54CD71DD4C
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 18:25:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YgJdEqnl;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22839-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22839-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3998301EC11
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD357433BD6;
	Tue,  7 Jul 2026 16:15:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3C35FF6E
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 16:15:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440930; cv=none; b=cX69UQ+3aa0+PbMKXmLGFa7OzXe4GRRBqzGb5IiEXrDHkTqxAl8oUTaFJT4DaVkdVMMXVwr+3n2HGcs7rLKKdgkyXfX1Zt5VdgWUGMK0AeYHjGwGh+4q0zitWBhCOywrkGVWhgnRNeq8Qgbd3t9fa3gJFPak7AsgYolzig734nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440930; c=relaxed/simple;
	bh=75niY7Ljy7FT8jvSV7EktRwrOBqI3lwLXWuqSCh0cQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy8P+hWxUohl2/H220JrCmtJ3wq8qR1oQAH4MFajVa5cB2XJO2Amx6XXDj8LqWt6MUqPEvltkv0+LP4wtO+22w5PuSzfBe0k1QBDpVWe7XeX+D2KzzWw5JauG2MEtyB4sOGYaYyodnL6EjzKxMqoyxEieMHfCaO3MRAzkocg0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgJdEqnl; arc=none smtp.client-ip=74.125.225.130
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493b7612512so211245e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2026 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783440928; x=1784045728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75niY7Ljy7FT8jvSV7EktRwrOBqI3lwLXWuqSCh0cQo=;
        b=YgJdEqnlIgXKoytqAB/JelMn0j5QKGOJbMW4x5jKs9vY2rDBuOzJXqRLqqcjuJT5qa
         1LdqUT+bZVHHLJyn6JrF/NWuZ7TAfG+44wB6UxACyYOz3qxOt45h0vyLxTgr4EcO/FBy
         lkzsjIqsNpC4MXDpxlLrQIh40A2QnqVyj5JPoLGw3E5BYxGfGvfgyJCtPJn1u9vbj1je
         GFcenXpHJy9uAIBKoANU9b6P1a+OmxZ0+BzdukwYOYUs1xc1Dr4yZhNiFvDD+RT7mGkF
         0tf780j7F/EaVN+gICsO7FYkcFoOfNXkI9rNZNF01YsXiiRoPldcZsQ/tII82i3Wssww
         Dmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440928; x=1784045728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75niY7Ljy7FT8jvSV7EktRwrOBqI3lwLXWuqSCh0cQo=;
        b=ontoDqTrBmHI9TkWnjdhbN5/T4gtCOPiLOt/9mgUK6RMyTxNpaXdxGlylr8kLW4V2Y
         CXyFjY9iaT0QhPhgo8bRc0E7iUK2kzDoPlso0FDfUekYHLIXZMhf44RlBZeBxdSQHNvf
         ShTh8rFj5jisCMxDWDBp6yojLV7hDV6GjAczgdg4ebMxL8A6dFinu8RU7VPQGBs0m4h7
         patcLIwlQpzvuKdA5NGoX+/qxXuDq4VOpP36uPLSzNOINO6gaw3MkaKju2zSrODaMc4l
         cPLGAvKHyqryVndXSKgqBVSBfNTuKq73pMICYG7EUkOVgSiIsJyohWASAxZWZi2V1Vwv
         Gn/w==
X-Forwarded-Encrypted: i=1; AHgh+RrNFAiJvJPC9uhVHdSpWe31EE0APw49H0M8FqiW25wUWmQsHvuvtMddAiaP9MbtPrtMeLSU7Rblo8HG@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5GocjBAASaac7ws/l3tHgnXSCgUQ4d0RVv4ubiYS6CZTd0cD
	GThDyYc2tenBZN3A5A3V2EP/G0aqvgfzXjM2FKXHaQV1+b/cB/x3B8E1
X-Gm-Gg: AfdE7cnRL3vup4CmfLF3ZlKz9+UsaKdrCYBaf3Rp7b4g1bhKj0nPT0ziaEriaWjgRIt
	h6kfTpVyV1hKTl5EeKELmkKX1BVHutQKhSb3K6xVuht2iyzx0++W/FVmETZX04SxaJAUK5ujNF3
	1dTTBUJTod0pOmA3ylMYDZHw3JXVdwidTq/s+KqrIb/4QzYKtmJqyzCkFi7RAN/Pq3Hn12YJAAb
	VJkJUUQTVOtOBwArU400L1SNVm9BbJ0uW9mHiA4tKONih19k5EbiDmaDbAaBlCqort+OACAGZkb
	P6xe4tNG5w7DYkUhz9dqSexxdEGNrvmWOL12UVqYq4IO5FCNpKJt6dGy0NRsBb8nllyVLo0Ckg2
	OPkLA71HWuW/hsWa7ZBQXHZCFNNrUW12TFulZVhuxWidPkWUnKS9BCn8ig7gLZs4K1WvS12iuTX
	ECGJp8WXRYYBk=
X-Received: by 2002:a05:600c:8708:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493e1008e65mr38795035e9.4.1783440927256;
        Tue, 07 Jul 2026 09:15:27 -0700 (PDT)
Received: from fedora ([212.253.209.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0aa7da9sm70402585e9.1.2026.07.07.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:15:26 -0700 (PDT)
From: Serhat Kumral <serhatkumral1@gmail.com>
To: yanjun.zhu@linux.dev
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	dsahern@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] RDMA/rxe: rework per-net tunnel socket lifetime to fix refcount underflow
Date: Tue,  7 Jul 2026 18:54:21 +0300
Message-ID: <20260707155421.18021-1-serhatkumral1@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <91a47c3a-d6c5-4998-99e2-fb615253853b@linux.dev>
References: <91a47c3a-d6c5-4998-99e2-fb615253853b@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22839-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,8c9eede336e3a843750e];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E54CD71DD4C

Hi Yanjun,

> The current ordering introduces a subtle race that
> can leave an RXE link in an unrecoverable state.
>
> If the DELLINK path sets RXE_NET_SK_PUT first and
> then finds ndev == NULL, it returns without calling rxe_net_uninit().
>
> Finally, the per-netns UDP socket reference (nr_sk4/nr_sk6) is never
> decremented.

You are right, thanks for catching this. The once-only bit must not be
consumed by a path that can then fail to do the actual put.

In v3 the put no longer depends on ib_device_get_netdev() at all: the
struct net pointer is recorded in struct rxe_dev at creation time and
used for the put directly. That way the invocation that wins the
test_and_set_bit() can never fail to drop the references, even if the
queued unregister has already cleared the ib_device -> netdev
association. I chose this over reordering the bit test against the
netdev lookup because a reordered lookup still has a smaller window
where both racing paths see a NULL netdev.

I will send v3 shortly.

Thanks,
Serhat

