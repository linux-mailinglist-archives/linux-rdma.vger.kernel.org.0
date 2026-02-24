Return-Path: <linux-rdma+bounces-17131-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H9lIUUNnmkfTQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17131-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 21:42:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB518C76B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 21:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AD603042020
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 20:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F5B33A9FF;
	Tue, 24 Feb 2026 20:42:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3638330654
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965758; cv=none; b=ovM0IpitFpnhftgfAvO6ziuYhUQKOVgwNkdtRdFc7IrqYXR/u/f6a8wgi1wRRO9CtllxMv6/X7+ljGIDfmmT/aUUjMtwcUD+2ZAJnQL4WxVnkfFnBYb6s/YFt1LcvmbcIPEMh8phtKmzzImUEljooyJwDudN9F2UhOuEsWCpGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965758; c=relaxed/simple;
	bh=RuUJirYKc4GHtLb88Bw6PLv7zH4BKU8mDD+V7n1DLwo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JQ5/ystXjUZPuScdWRoyOhZzSYLnPjrk/3/7BXz8SY6l6KxqkPmQdbVuX+bLYVvoPCObdZGmveuiQfsRUEN+zGSp4W8bzCAB0bo5QQAgfQfmF//TLvaZrBYeWn1dsjL6n+biE9QkJ+Y7LAknH7DSr8Tz1+DPJovmkRS3YCBuMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-663006e4c3cso73836043eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 12:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771965755; x=1772570555;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDBQSrDsUclAN7qfh+PMRyUjKAKuLpbm70VfyRSDwno=;
        b=H2ETsc+9E+BGK07xNW3jN2V7noPJ7ndRHlyLPezwuY6bBwxY36n2EHt5Nhrl5m+PtC
         bCiQRC6Cw/0WGJ8Xm70W6bmBJbtOGDHCbaggNUdIFzz9iZsVR/2W5jwriZkQbNiI12fM
         lhGSNwXZn2h2M1F1DLhyhoK9uP7hVzBwRkyU4aHmci1u3j6YSN0nLpJommNehfJHypsT
         aJJ8d7/FlDY6N8n96XqPe7wwtl93A1TwfKCdn7igtqYylU3LjtP9bx6Gga6BWysPPV1M
         f1avZX7/EpN8z7DDz5TjECd7wdrzEgCGbCO3OwdYHVDMn5BAb+svHaiquVvitRDKHG2V
         0dRg==
X-Forwarded-Encrypted: i=1; AJvYcCXmH4qKGkl+xq2gnZR/PyNAh8kAvyF77JqpkL+/rt/r8+BxWGdaPWp+lagtVkWFALjrhwPdudH7tW/z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aGQXB0KnSiMALPT66X5UHBnOtnY+zI2VjIE+J/6ahSDaxer0
	Ylmpj0w+REKrYZllFv9EjmxufAcg/cat5toI5ski2gcvlfYkFPxA5qyiCHIK/eprIBvtCz7DO1+
	p9pq9lA++8K+V0gF6T+bk4ycRoWFsFHjYWVKSHxjA1IK9mKkjEO0MZ+uuOKw=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1792:b0:679:8b1d:ba0f with SMTP id
 006d021491bc7-679c44ebb9emr7790782eaf.39.1771965755793; Tue, 24 Feb 2026
 12:42:35 -0800 (PST)
Date: Tue, 24 Feb 2026 12:42:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699e0d3b.a00a0220.32abbc.0212.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Feb 2026)
From: syzbot <syzbot+listdc9c15eb2c31aa8a8281@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-17131-lists,linux-rdma=lfdr.de,listdc9c15eb2c31aa8a8281];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email]
X-Rspamd-Queue-Id: A5EB518C76B
X-Rspamd-Action: no action

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 68 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 27481   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                  https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<2> 769     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 168     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<4> 154     No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 5       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
                  https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

