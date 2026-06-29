Return-Path: <linux-rdma+bounces-22555-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lhAKJYBnQmrK6QkAu9opvQ
	(envelope-from <linux-rdma+bounces-22555-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 14:39:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F2E6DA5E8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 14:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22555-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22555-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C50C23026AC6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923F0407CF9;
	Mon, 29 Jun 2026 12:32:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB5404BD7
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 12:32:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736351; cv=none; b=AxjNmgEwVHj4AW+zk0VaDsK6U3Y7ZYAnTzkhAfSC1ES8caKgiT18brahKgpb0OxE6l0HH2Jv+wK7Wu+bTvlnQLRHcgRFy6QRrVCHrTBsNxTsgKaWaABp2s93rKut+SnHGQfLhbB47Hc/zl8JWFq9AY93HkCwIZBwcXWzftRj2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736351; c=relaxed/simple;
	bh=05wTrplBYLbniL2JMyaynVDDMtIZjgV+6cp2u9MXEgo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LmgtgJwJxTF0M1lt0GCBYD99+T0z3bz5V054/lSMkrrBt59z7iuw7ap7yZzUD9VwmLuy2V7IeD099PbaGB6odeRHe6BdrPMtIPOE13Zivm2IqmfQnjFcQ8oHEczWFkYB89lcv8lGSmsafdhNWeR7B0pmHF11/RO5XfaKzZW00Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-48576b535b6so2131925b6e.2
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 05:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736349; x=1783341149;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97lF234ATC9Md9VCubWMVnaIOy5R3mo9/loPCx5NO44=;
        b=kCwLYr4Q/XhSI9dQynA4nLFHod7QoqR6FELKVH61cq0/KeyUclAyDqZPoUvLDjcwvy
         b9HY05jFtX8NYbcItr895pCoCws/I4csI275PaWqRAFrPYWjK5IPQxfB7JfI7Amfibkb
         m3zSXgzTRbdt+NZ00cGKRr3KnElFVUjgDsoneR8VocZBA+AwXHAeMYDnEIer7m+vKcI/
         fzOUk75AQe6mWag+cDAcJ6PM/pQ3USv8rOBUC/ufraYtjkEl3D9DyspuuHVpXdceH+we
         pxuW0GD4kPAkh82T3ytYT2d10ExzBWuq3nZiirhlau+o5IsS2ZT36Jkg7RSXj/VYeWiT
         5VWA==
X-Forwarded-Encrypted: i=1; AFNElJ/hDvij98yuEDD5ncruQW8BTmBUK4uO8dHPvFa/ukXI8PnkAs6bXed8DsA7hW1nm76qmnL3SNadF/PT@vger.kernel.org
X-Gm-Message-State: AOJu0YyfsZATKDmnDUM9fEl9rEC0QqM7Zjv4yfH79Sa43tgdrrcVcPoS
	fhxzu/E/iNW5tpOrKew3TEhQDkyJS8bK1jS8r0EB4ekZ/wSM6Tx0B6Km2LWNqVpWIb5sTxP0FfR
	bTvD0B4LNT1lEypBl31WjV+Bh4iyNBOBCjfoQtqa3Vwn+9owpQbJ6SeEdZOU=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3191:b0:495:dc69:70c0 with SMTP id
 5614622812f47-495dc69f32amr1080408b6e.31.1782736349213; Mon, 29 Jun 2026
 05:32:29 -0700 (PDT)
Date: Mon, 29 Jun 2026 05:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4265dd.854d4ab9.360e1d.0007.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jun 2026)
From: syzbot <syzbot+listc12adc4662b662b38430@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22555-lists,linux-rdma=lfdr.de,listc12adc4662b662b38430];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,goo.gl:url,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,syzkaller.appspotmail.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28F2E6DA5E8

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 70 have already been fixed.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 37675   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                  https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<2> 1072    Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 178     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

