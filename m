Return-Path: <linux-rdma+bounces-19646-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PD5BHl68GnMTwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19646-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 11:14:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F851481127
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 11:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 756E53024365
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DC3DA7CF;
	Tue, 28 Apr 2026 08:56:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BA2C027F
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366582; cv=none; b=UI8Cha/azfOuw0urznlYsKpXinNMTSe3wPZ+RDlooo7Qm10o4+GgZqmsmzbbqqiJvTzNnsf3Ey8clMQyo7RJf7NQ/d2WA3Fj6z87/MnZjE1agNi/+cQ57wF9p1mbXpXJRHX98uugkhN08PLrt/76Qb9dWWzlkYKRzQj8SL88hTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366582; c=relaxed/simple;
	bh=Ucck6HAjQsfCfgMyBBsJAXv9BVUJxscRLWsecU26KUg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B2qZdzwiyli9q6GaPLiZAilKnpoErIkbntqCKISFehqIi6aydOi9I2tyZzIY4NDIbR1fYZtgHGUYjCtjGDPKsIR2nI/ssUJ3c9TuVyfwjz45FrzLix9/QfwNZkz7tyRboa1IbXICPaU0PXlMF8rVLYyIUrHFlUKRTghDqnqQnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69629c3b86cso3433461eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 01:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366580; x=1777971380;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMUaoUPuERHgdloaq/UfkCfk/TyeP/YS476bKdIigTk=;
        b=XbhE/67nmSP/O0rOUEI075MXcS4k+FXYnAnaGEF9eoJKYAwN/t2dW7F0kdj4sclHGf
         Bg5EUJN3wemx10o2hBCtq56VwxlhuuCR4ia5/s31VCq3H99bSzefk08RJf5d8gw9iVW4
         d5442RjLadOuyiNkprVF4yMgu2nlD/J4nrxL+ahB57IRbw93TWmElrCYm/hxg3ROMYZ6
         cj+4o7EvWP3lqDjEbFuCUM2JyvouECDfx0psW7KFEXvw+luhGgX1YXXzS9TwRzKTekhg
         85VGMP970E4El6PYkjgLBPnNlHBgW+rllUWcGwQEa5aZ/elRcIQqoNLJRnvTUPQeDtS7
         o32A==
X-Forwarded-Encrypted: i=1; AFNElJ+4Mt7yJmzHc/6H1i2uKNacFOTaGJxao+gc634fJxbr3zFYf9YotHF+X+M5oT2KRTEAjbBZMJ0xDwfO@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXt7nyYp3CYOFGs4ursxr88VDa+2OndUM1RrAedp9MWAFkp4/
	nJl6u6FYkU3voqeScyAm1nuBGLYBLd4F0X0vqMNrou9LJ03RKmcwRuzF27MDjChCajjxA6koI7J
	DQUdY4SjB1cME/ATgNt0BFoFZDwBWVG6Ii7eAm/TOwFwJoRlRkgjgrJ6p1WI=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:611:b0:685:7d77:27 with SMTP id
 006d021491bc7-6965cb725fdmr931653eaf.33.1777366580660; Tue, 28 Apr 2026
 01:56:20 -0700 (PDT)
Date: Tue, 28 Apr 2026 01:56:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f07634.050a0220.35765.0000.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Apr 2026)
From: syzbot <syzbot+list924a1435730c90550f9c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0F851481127
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-19646-lists,linux-rdma=lfdr.de,list924a1435730c90550f9c];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url,googlegroups.com:email]

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 2 new issues were detected and 1 were fixed.
In total, 8 issues are still open and 69 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 31997   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                  https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<2> 876     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 173     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<4> 169     No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 6       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
                  https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
<6> 5       No    WARNING in gid_table_release_one (4)
                  https://syzkaller.appspot.com/bug?extid=0e8fa99d40c1f50c1527

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

