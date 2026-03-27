Return-Path: <linux-rdma+bounces-18739-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGpHMtrsxmkIQQUAu9opvQ
	(envelope-from <linux-rdma+bounces-18739-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 21:47:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D234B435
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 21:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF1D3112792
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B637EFEC;
	Fri, 27 Mar 2026 20:36:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AC37D13B
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643797; cv=none; b=Rjvbd59MnewWDNLHJP8BUknBnJ4iepZiVhOlC+vXT7hIJBnIvifNfkQGWWOWucFhn0RKcQVeVhxcyKtUm5zgEw8dPwSo7ETJas9fWmUzKy8egvHn/S3qLOdg5UHd6Exqw+1XaddwsVq20NU40oyBHQLWfSy/F9v/0MpEEZZJxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643797; c=relaxed/simple;
	bh=1n91EQ1AB+7d5o3+n6aYpJM7s0wrE/Mo2IM8MAQeN6M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SfV/k+DZPQSRU2k4qLM+AhJpMTChBPWyK9iaBJlDfIW8vCWaiC49Mqr2PIv97Prlo5YaHWmhYNvRfVbP+x0Lf5qUdp5dIJhnMKkfjuTlygtD7uyCl92SIiHBcgIB/J21G5D0AhTG2vKFW977KD/d/hkPenr69NntERo6P0vgY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d8b26a58a0so8938347a34.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 13:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774643795; x=1775248595;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hM/ggpwMA/cUoglF/orY177fG4wRORZBAym8g879DIw=;
        b=Z97pJ1Q0QeGCdquqUznZTh2+Wip3RKHwIh/6y1a9cmB0U6n62+jygM/TPrejwoF8mR
         huRVe5uaSktYbqC9bK76rz1SoRCwLV7cP/fpLZ7ChZXKZWjx18sMwqIC17aArSYlui3N
         kXULGhp0//7dznFBdEFo1qtD8Ms0gBG08GEqke2WC/2E6bOpZUpxlscpg/gFoGLgXUZ3
         DRh6tiAIIOatrJpp+w0UFF6NPUI3dScANk9IJAxb61vnHLYOJjE/6TVz7VkSVeMpOkvG
         VnwMSubJ46ZJDN5zEJZ38jyWehIbqUTeSNihtsMZgcK3RDFxflewoEIS1iwV+N6jNW6B
         TH8A==
X-Forwarded-Encrypted: i=1; AJvYcCX+3F1j3rSc/Jc8cZjQUyQMbtN08zMvTJQloRgB/sxJuF0BldAwJTutkQFffuV4R4TJesIapytSNtBm@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvbNUC39k8n4ALyTmXqoCnMoJvFSu0lLS3XxBctO9wP0Tj0Q8
	aOOHq4w3lSknlPhxuYhfaPufLc6wgooavZtdedMjColuxwpfuKRZkSX8bsAT0+7QNd0He52uEqH
	Q9ZS+qiC9pSLCbqsKcvxcOqqGWdlEOKgZpd/3NX7Gtxbj0J57bJb/Qc5pmXc=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1dc6:b0:67e:157f:c2ca with SMTP id
 006d021491bc7-67e157fcbbbmr1738213eaf.1.1774643795061; Fri, 27 Mar 2026
 13:36:35 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:36:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c6ea53.a70a0220.128fd0.000a.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Mar 2026)
From: syzbot <syzbot+listb87f6c97de627f5a2239@syzkaller.appspotmail.com>
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
	TAGGED_FROM(0.00)[bounces-18739-lists,linux-rdma=lfdr.de,listb87f6c97de627f5a2239];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 293D234B435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 68 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 29887   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                  https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<2> 802     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 170     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<4> 160     No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 5       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
                  https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
<6> 3       No    WARNING in gid_table_release_one (4)
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

