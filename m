Return-Path: <linux-rdma+bounces-21495-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPuSFBWIGWqdxQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21495-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:35:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB43602510
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D18A300A3B9
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68F13DD85C;
	Fri, 29 May 2026 12:32:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEF3DA5B1
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057957; cv=none; b=qiUa5PG5HP2bhScsl3pu3Uckl9/A9oRe+ROs5OWpDFn8Cbqj7vYQ+p4sJqvMj2R1pZC6KoNjwYvtBjjYbyZi1kFg7x58aVKZpbNfcpzZTRceu77zmifTJ6UsGphraD69K74eymdRZxRrBxi/VJbw3APK1Qvck81fqGL5zX+y0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057957; c=relaxed/simple;
	bh=GHCa7ff+ON9VHq5LdjHIbOXQ7LkYL2OdwD6bNt1F5VI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=grbzjAHlk+CH2M1szNYc7Wujo6SwK8kkeqIh4x7gALdy6Db9PBonvukbrZM1jlyvVtBp3IjbX2WbVHMkrfm/CbrcRJ8sDqAzZoEOJfSeI4qjCF1/ZZfVdpN6S/da9GxwWRuFkuvo9FIPANfBXPyHi27ElI7FQlr7Nh/qN7RAyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-43b8cd3e60eso7303269fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 05:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780057955; x=1780662755;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TlbbfryYRqdJQwBYuNl0spmWyrKbR5IHLnr7CT2vR4=;
        b=QP/q+qUoPKqWtfb3UL/ucK39DPZpzaa+cpTeN9OyzFwB4nMx0w9pA7+jKe32CXkaWe
         9fyLD+jVCfmz9A0Mor3Y/HKtS1iZliKPV9gi0cZNp1a39VOlXmCMCOllaoHFvKnXA1ps
         DsF6K3dUsb0UC2vWumhKW3+GbW4uexWrYY9iFtlug9w26rk1CpwQHhm0Qbg//65h9suz
         V01r2dJEXC1He5ss1YbIAV03VwEOHUOS6xSFEKkZWvW/zFtO0qKyCkkMP37D0V4Uderp
         IUguBA9E+AlXgUp4VlaVVBKf7OtdP37UWFPNildabuLDf1nKKPue1LhIghSjhK9NbKyZ
         SWug==
X-Forwarded-Encrypted: i=1; AFNElJ8aES1HjPuivKOYRYNT8+/Zi1564i+6yf7d8QmYlGarj0AHsGzLbwyVZZnyG3hkQMeaH7IqdytQWM59@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkvUPAxsSkqe2jM8Ea08gFYLGpL5A6bx57CzWOZfm44FieCKU
	VvhnqCBy09MifVEIm8lPOnEsUbpgXQqzDuH0v8LjzLx0Qh2la82aBJ4/qqBc/8Uo18EU1pNkumb
	2EzU22nwwErO8zDHoM/FTlP5Y8tSVzA4HTh/+valbgk/jomezyI+PMg6o1Bs=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:83c2:10b0:695:3a00:855c with SMTP id
 006d021491bc7-69e03fd3f66mr971927eaf.39.1780057955376; Fri, 29 May 2026
 05:32:35 -0700 (PDT)
Date: Fri, 29 May 2026 05:32:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a198763.c16d89a8.217f2c.0003.GAE@google.com>
Subject: [syzbot] Monthly rdma report (May 2026)
From: syzbot <syzbot+listeb15336c3e253c62864d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21495-lists,linux-rdma=lfdr.de,listeb15336c3e253c62864d];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,goo.gl:url]
X-Rspamd-Queue-Id: 9EB43602510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 70 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 34466   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                  https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<2> 974     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 174     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<4> 6       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
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

