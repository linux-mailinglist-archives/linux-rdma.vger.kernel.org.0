Return-Path: <linux-rdma+bounces-8242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B75A4B550
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 23:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F0E1890CD5
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286D1EEA4A;
	Sun,  2 Mar 2025 22:37:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8941E7C32
	for <linux-rdma@vger.kernel.org>; Sun,  2 Mar 2025 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740955044; cv=none; b=L4tE30lmCjtoJz//7RdjCmNbjR+xbCpvwMsy3u3YwLUbs/lFd/aGf34b0X+2XnkfCWhxgJRoekvZWIBlVKhGaVkC0d9VYbLIxyv9AKSP8iaW10Bqsv7QoaPckwBqFOlgKcJKlDLCzSIehe+5VxhxXeeTRW1fyxlgHKuJ/ag/8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740955044; c=relaxed/simple;
	bh=0DwsUAsSJO5UQn4bmGPqqVWlWH5R2lmMZ64UhyrEuAE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c9VHViG/cSQoMYUtH/LzMeNf0BnvECdRHX1WbAO90j69ONgXFxL8lJTCQHHrp/ZT5H412ggL01pA1+JrrewyE67y5sTKuoU6/Tlq+aDHUM1SOzvOJuSLtbT0rNreYU2qlChBtq7ZM7I75WYa+8b7U0Vx3lxqCOFac2nRu/1OWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-84cdb5795b0so326445639f.2
        for <linux-rdma@vger.kernel.org>; Sun, 02 Mar 2025 14:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740955041; x=1741559841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utamXc6I+xnosmBsdnrUmah40k48pr1hjvzaM3mHGis=;
        b=eTyw4QyNZBE9yzEUECdSuI4O5uR0wg5Hpqh1TA/KidZBwlkzT7r93SEZ+h9yu36Zpy
         6XNLhOQYFsqUXqfmF3oJlPrmmWujg3aZ4dPAnxt+mq/zyJ5jTjhgbRFHSraH/y2HMkYP
         104CE/AYU0bpy4VUGgrXjnFcKvJdHOG5xjzcU0CirPHUnJQQQ9ngY6ODg6Y4oqDJEP3+
         SbWWTDgSV/fCFMUxz/DvnGU5+9U6s5KYbR1ttdzyZzo+trKHZqOSI9SuO3t1o7Z+kfOD
         zKCzrq+BAUYIJ9S5qp0YwnmEsFGb7d+r4gKE8viJPBIcU3PM4EqfXLGn8x0snpkJV70f
         1CDg==
X-Forwarded-Encrypted: i=1; AJvYcCWJDqMXdJaA35V44uSTaYf8NJb5/z2Esg3Teg30M0X4tyC7PCv5xfnjBM4AndNyFOAEAE7VXUqggJcE@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBeRKFmxox/nGofa9/XQRFsQrIK7YYAgOoSE1d0XeLYIJ+Wk8
	jL6EmeiJuXh2joONxyowM/mi2vKZ6x61CGJypYqU2tx5vNclMXznjh1zRX8YeADHWAdpw+3sfx6
	D/sEO7UqQFkHknITjAWO5tryUa02a+eB6DbDcWLlPVfqc4R59+NmkYxc=
X-Google-Smtp-Source: AGHT+IGg5TxX+8ogMdxKRe/mR0oKCCW7kVQPBosty+8SM4ulIsEmTFJiDcgxtPaN1YTH2wFl/E8vYvuxOyzrsGbXTQRfUSpa5b0U
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:3d3:d067:7409 with SMTP id
 e9e14a558f8ab-3d3e6e940ddmr103456735ab.11.1740955041629; Sun, 02 Mar 2025
 14:37:21 -0800 (PST)
Date: Sun, 02 Mar 2025 14:37:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c4dda1.050a0220.1dee4d.009e.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Mar 2025)
From: syzbot <syzbot+listc59baa9b4f1dc791b29d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 62 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 309     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 155     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 78      Yes   possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
<4> 66      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 45      No    INFO: task hung in rdma_dev_exit_net (6)
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

