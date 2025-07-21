Return-Path: <linux-rdma+bounces-12363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF945B0BE50
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B368016BFE5
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BD284B50;
	Mon, 21 Jul 2025 07:58:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C019AD89
	for <linux-rdma@vger.kernel.org>; Mon, 21 Jul 2025 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084716; cv=none; b=f1VDVYjMNUzzWyLsVYvRjkNq+1G+4WXeeWWakqkk17PbD8ZzR0QYGDvF62d+G0jtVwTWcNaWjTeY0O2uQIJSVHKIw2EmV0NEsqtTxdGcYG6k19pd2P+FR5j4tkB0UL0GNL4ooNX6BvAEJTh6yr8WP6hFNEQw5v/Kb27AKxF6x7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084716; c=relaxed/simple;
	bh=vWoc6vkEMUZ8tSt7qmyI5v7WgtN0mWOUlxC4Ce5T7ps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rUb5OaS7NONOliaN+7FXaBcjOQr8h98ar/sCvH8lv+e8BO1ltLkLUjPtY80wZp2QjCkcirYt6M54EKtwBx7TEIzRYGDzvibgC1FMbv3bAKj/8Fs/MSfczYfeyR+amQbaqLeB0OFPRWyrWeCESRenlcS3agha2nU04xRRvsfI724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso366641339f.1
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jul 2025 00:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753084714; x=1753689514;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qWsH7gI2IrsNAjvn+IJGgtDqsL30WdsMqCwe8OFr7E=;
        b=a7Z+RSgyIVWid3xM3NujhUPT93/n5lXu5WYFC/1Zok/uabfexdrLyC6GGtgDZFQeAF
         NaMsWJHpTrSZnYTwy78N6Vlv3LZb0rYM56cLmC5lyL5KbTTGoGd5FWzruME+2qyijXfD
         8061LAaXtkJlPjfdz4S/KWCNXrQrv5sPcBe+LE1jRctQkJPt7dGTMJ4cB5omzlIndkGj
         w7w7v+SPA0eujTmgynnQQ4SGI7xCUS5+PV7qebWXnIV0Za3vZ4RCec2Bp/LSbrQ9znHd
         D7h6+EXjSn9QikcEs74ssFrG2HxKLAvWn8jpRIZGJ2x3dAcYU+HgQaDwIlkMkSQDKAvz
         lMBw==
X-Forwarded-Encrypted: i=1; AJvYcCXg7EAga7xudbI6nBC9rpFE5ZXHpgBT/H7gQN/bltaufk6HHdHGCNGnmxtUwh5QSOsa/EnfYf1S15Wv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hS9lskdQhOberhhTaY7Flp3bpRP4voFY/4hJghYLxI5f5jnt
	epv3Tx2RW5nfbkOKd1O2Koo/owegNTzG8BjPlRbnZp117AVMe8TEjVVzZm1DMEk23c9uXcvgzwv
	fTgNKYnxkCVLORLF2W8qB2BtjsRylh+xfSf0r38lXCnjly//jOFdkF61FVI0=
X-Google-Smtp-Source: AGHT+IFs4koPgAH1a6/fQqINc1P2RFkey8F9mJltws+a0M1nOFV9A0+p6DC2S6cAkOEUom3pFAg1TXFnwLTvvuOgFLHrq6rh094z
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4144:b0:879:49e9:5156 with SMTP id
 ca18e2360f4ac-879c293fbf9mr2405562239f.9.1753084714382; Mon, 21 Jul 2025
 00:58:34 -0700 (PDT)
Date: Mon, 21 Jul 2025 00:58:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687df32a.a70a0220.693ce.00e6.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jul 2025)
From: syzbot <syzbot+liste30f0bbb947a4c7635ee@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 536     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 369     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 75      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 43      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
<5> 10      Yes   WARNING in rxe_skb_tx_dtor
                  https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

