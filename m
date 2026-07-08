Return-Path: <linux-rdma+bounces-22909-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id as4pNVCXTmpiQAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22909-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 20:30:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7B729835
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 20:30:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=r5oU935R;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22909-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22909-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A8E303CD3A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9FF4A33F9;
	Wed,  8 Jul 2026 18:28:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7743800D
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 18:28:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535327; cv=none; b=qnqCNX1M63P8HRcP60f4M2TAc80l8nnKTJM+vBEeMsRsd9NTTPAbUlAGgeTYZAAEILCUa7ZVUOXsQbfMotVJ3BYBK312RJ6KH6txNOxFsL4d217bCTUmXw2toLR9joztMPqBooC4d0wZfloc6aLAHivtEVn052N+KLlbB4CNC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535327; c=relaxed/simple;
	bh=qznbZWEKvVbYbB3UWzzKOo3tdMbOv/BFQoeRrvOLZXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpuZtkx1EHICByPSObbHn3QRIROPLagzQ2V5lLfhJp5hrMEoQNUn30B3skfmeqcb1aqIx1RVUuca4RrQOlWqX6Hnb1TqFK8S9GsOEeeLFIX6NIgm8//xtsPLiX5aEMxGR4jd4kUZ0rDKTDw2/ag5lF1jjfGlXp34cVKuskrgkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5oU935R; arc=none smtp.client-ip=74.125.225.129
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-493b7dd83e8so2242955e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jul 2026 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783535324; x=1784140124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gq3cohTqbBoe5iaxO0km5tQIUkVdi62JW772GqwwYl0=;
        b=r5oU935RvmsEfixZVIKhPNdDrF63hqKBm9ll5p0TflXmwngGm1Ce91L5JqKlvQmygt
         jAFAZmmqw9i5sm/oSvNbGvwFVUElsk99zpAUxXf6BypiQaS9D9FFLk0lexOJr6Qdgh8e
         Xl7yTHbshhKIxb0nK5r+FTx/qtgctj+0ojAD4Ml1EiFSCaet5hbdhS9pDpJ8+4CEkaf8
         6IpHAT+khgYwrXbtnPjXsJ579KNmTV2DKV2V+RWPL9pDLoGhA5ElzoBNMq4VDK5d3eYX
         /G681XMDwiZtCJok3bRJkh7VRkt6CdYAbzMukRs7FaOhOUUdtVylVmevMyQLd/tbY5MS
         Ahag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535324; x=1784140124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gq3cohTqbBoe5iaxO0km5tQIUkVdi62JW772GqwwYl0=;
        b=SxF7u8CQb+bF7ydLepLJNlae8ZSqy+pwspUiiWl05vwoQv3R/nq8MbO3YXlAW32r85
         xbfIbBqUgobgBUAHa4gt+yRQNwNjNpzM0W4WH30Oqnf9RcK1KAERubv0i5J3b9MM12kN
         VYIC/OpNZeSjWR5hdP45HkoZcWEWI6hB5Py8z8Ba7zPL6fTpXGTXcVaioNeFOeUACJL8
         9VIcqzV+qQKDQARlUuJ2/20IYIrG8yJZu5+Ot7HBjaHf+hOxIlJC5w+IxHwkbNIwn7Mx
         /4XBakqF4vTF03K40ZYzpHfilPaB6H3u3ZSWjOyCUHWiQ8okgEMUmO5Y8BNEtBwiVeob
         burA==
X-Forwarded-Encrypted: i=1; AHgh+RrdobpOomylEPoyrH7IlpQgZHr9swzBcgJiixg7iFTsNNcjuNYOyD2JhkpkRYBQ4g9SQTaPEWhw6Yso@vger.kernel.org
X-Gm-Message-State: AOJu0YyRj2NBjRQeyETK4tR9f6OgsC8bsH1s90LIktmGJ5j5N3hp24Gr
	E3Vr3r0y7mcyj/5kWH8+04mwSUdMETspQavn1nvDHdpP/4FfXDin8YBP
X-Gm-Gg: AfdE7clf75u25aD3i7I9BX4DjP6hIpzd9BhsSw1Nec05iSzlFU45mppEBhCM/S+1lEF
	lyydu92b8VLZ/rcmOAllH8LyPIxpq1olJfch38bcs82bdZEIu0CASR0J7iKxz770hOYPn7o1TXi
	W36Rh3SEPKHeOUx/RTSNB1NcJLAly1S9qrqXB/e1hkApnJUbrwLvbKDvS8BCGvhbT9oSHsdvLsY
	G66jsmUw6r//BXwD0vwuefB+c90q696+wiD+rDhd+FqgDfsb+zqPN5a9pSb0jNkoWNMnU2xJRM9
	pEo4uisen8FfNUiP5bpjQEGnhrnEykorS7O2d6w0uejtqNs/auVoOEN4Gux7kjPpa16PjMsQDhA
	tHgmicArwoMRgDQW8SkSKkPigf5wwa4ZMucr+xiwuvN2rvCkFrvBDtj0dAo7gl7yytdKQjCs1q1
	aqShcLaG9WkFg=
X-Received: by 2002:a05:600c:4743:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-493e68c4a07mr37875705e9.20.1783535324110;
        Wed, 08 Jul 2026 11:28:44 -0700 (PDT)
Received: from fedora ([212.253.209.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a61135sm49702335e9.1.2026.07.08.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:28:43 -0700 (PDT)
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
Subject: Re: [PATCH v3] RDMA/rxe: rework per-net tunnel socket lifetime to fix refcount underflow
Date: Wed,  8 Jul 2026 21:10:07 +0300
Message-ID: <20260708181007.24280-1-serhatkumral1@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6ced0145-30ab-4af5-9005-9da024933fff@linux.dev>
References: <6ced0145-30ab-4af5-9005-9da024933fff@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22909-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31D7B729835

Hi Yanjun,

> However, after the network namespace teardown, the associated netdevice
> is still unregistered, which
> triggers the NETDEV_UNREGISTER notifier. In rxe_notify(), this event
> eventually calls rxe_net_del() to
> remove the RDMA link.

Isn't the ordering the other way around? The netdevices of a dying
netns are unregistered by default_device_exit_batch(), a pernet
device op, while rxe_net_ops is a pernet subsys, and subsys exits
run after all device exits. So NETDEV_UNREGISTER (and the notifier's
rxe_net_del()) should have already completed before rxe_ns_exit()
destroys the mutex. 

Am I missing a path where rxe_net_del() can run after rxe_ns_exit()?

Thanks,
Serhat

