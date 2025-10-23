Return-Path: <linux-rdma+bounces-14001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF8BFF984
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 09:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 922BB35AA46
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE952DF6E3;
	Thu, 23 Oct 2025 07:26:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849F2BE620
	for <linux-rdma@vger.kernel.org>; Thu, 23 Oct 2025 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204388; cv=none; b=Syjq3L7XlK7lXiKh0t4CHTDBiMq2N08Y3Gb8j2ih9mt2DKW6iBEVbrrBqzZ/km/qjzS4Q6P2VYpqqgUxrau6UAMHLjVmm8B/62RLOK4XGAB0S9dn/khVXhKX/BhIdBqD5+XzAgghEeWM0ofxb5K+aybfMqUUD6QyvLgsOLSRgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204388; c=relaxed/simple;
	bh=072T1hELA4IEXLyNAvTpI1QKo4tu/F09LzG59OgBE/g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pEEuIVLr83nD/oz0RyvBCbM67+ysgGHsac5KTlAgCzMj20qV2HzGAZmoxtVsMPxVCifSjF6JefH9coohzmQdXVKNmZzy+xNU4bU80gVUswGkctCVvwqrbE4jK1WOCGP4wDvF3TxNPIomMKUucyecQtHXKi2dvm4gU2MrvzKid9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-930db3a16c9so35685839f.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Oct 2025 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204386; x=1761809186;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fvf9ZRE92JNWYABHY5d/bObPYmap/MAjRNgVlHVzgxs=;
        b=IW6Lch8Gihxxk/PvEHhEGhu6U4i3vTOoi8NnkTqtcu4BGQOoBj6G0oFerVCl1TCBup
         4QA/vmwJpqVPxBsekrgL0u+16eeLMEyrjZipbE8wVpZIGtKuCxXGy8LYZDyMZZB0JIgE
         tjSMIVKUVgOiYQOFdJ56f0eIyUIT6ba8jykhhfdDZoCGIwP0sDIGJXc2+ark1G4028jd
         BreIKA60+Skugn3pgOc7R+NVUo9ANnX/UoJCk86DXuW1YlBQLYz7hKnCOO9CGOxRqbcm
         iISX5bVEgWCHqI0H8rs72EbInnteo6IMTCxEu7wNQzlEoOFdV9mghL/uAT9SaIkml/Sl
         Idwg==
X-Forwarded-Encrypted: i=1; AJvYcCVZBVGSflEXbIbpeyPMgHJ7w4AfkP/X7J+Z4FG9R2NE5WNhd7hcoIYjP15uwb+IUReh3iqSqsGhYqN9@vger.kernel.org
X-Gm-Message-State: AOJu0YwH72rEupnhaGDmkVaqCw3yVcgfavVdumXPkNqxKpokyNJJSpo1
	1+N7iP005TxSAPTkrNpptdH4d+gsXIMKClMikt5S1shJMmrr5g8z0KCcipx1zOCsZBgAGODaXQa
	hKlgj5oMlAdLRynSnt+GpeEjf5QBsB99fOEjMk43k91/OALyaAXGqXzrni+E=
X-Google-Smtp-Source: AGHT+IG2kb+3VHnGMQVwuNQxhL6zzopTu/NOetDQ0IYJeK1D56foFuVk+8IoRsWkHr8VbEZDqSkkljH9Yltq1k42HqeQ8hqGDBHu
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1414:b0:940:d395:fb53 with SMTP id
 ca18e2360f4ac-940d395fcbemr2167628439f.12.1761204385851; Thu, 23 Oct 2025
 00:26:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9d8a1.050a0220.346f24.0070.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Oct 2025)
From: syzbot <syzbot+list0ee54e0d9d6647c72420@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 66 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 969     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 546     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 100     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<4> 94      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 89      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
<6> 5       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
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

