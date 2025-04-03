Return-Path: <linux-rdma+bounces-9132-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E32A79C91
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEB8172D4D
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3110123F299;
	Thu,  3 Apr 2025 07:06:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2B23F271
	for <linux-rdma@vger.kernel.org>; Thu,  3 Apr 2025 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663984; cv=none; b=I90Z5GpS9kY7oiTHS1h89806LN4wmpMiR+MOn0JxPk45wq7VtuoK9JtPM8RikSKzT0CNgtiA7r/sV87lFfrc9NlnS+SZL4k6GSjXO1oUyOATYP9vu+SyYRz68xwZeb3JXj2QHCBlc7ND45QL7a80Ag9p3mzncpCoMogAreE/WjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663984; c=relaxed/simple;
	bh=msW4OHTqeQD5/fI6ollGmj6Zfe1iTA9RBCs+z2/02qQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z5quoQ5Go02Zq+dXl9zA9cY4cxoWSu67yhJvU3uMw5hWhZt004318argS7/bV+tddj9ySsYOormCRHkaEH6qb7BekgXKl5aPAbqwXjdFjtwx/27i//+I1mHrHYdT0li4SGDfTsP0+ZKD1FO7wPSK6vf6KRGjR/jkeWiBST0SJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d43621bb7eso18036955ab.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Apr 2025 00:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743663981; x=1744268781;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dubI7A+8/AJKZ0segSg1WSFAtvONQ9Ynr61IT2Yuew=;
        b=NYS0chcBADjz8MQSoy+rk9bemh8IZj7NCLfbFfJVpuKA0fidtZkOpqO7JBJ59T3H/a
         KeggGKQ7x95/pPlFvQ/1oZ2nNFqAHYvvuPV57/f/fx0CQqo8TSX5WXmNsMteE2T1NaWg
         dwaKUnFZEyk04IMxNtj7WcC146iHWAnqssoCnrKROkJtgs2P8TyTIQ8tP8KabBq7W5FO
         IuKszdUzFIVhC2eLtvoN2n1xY+HDpWsQYcA8TATorAv0xy4kO+zzAxy8nYiwipvtoR9X
         JatuwzS/ytv5zw/MEwqZeeB8+YbInmwv5i8lOyHD2N/VHbwk18vy1bXWVSQLALEWZzDI
         YtjA==
X-Forwarded-Encrypted: i=1; AJvYcCVtsl148xH4/tB0s+IhKg4JvQaZ3YtcCyjD9WVCDA5xD7+xLv2AT8srBnpiQ9POYhMY+aaWrI8wBt3s@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1p8cO2QivpdXD7HAYmAM1hATVbJwIeIubGNrndnzFPtip8EJ
	XKy2nNyarrxVsG5Rkr/Idwtn6F5S8UZZAXQq1eIBLUyoEEw0gtk8CLwWK1GRmRR3iug2+5pCNau
	+Nw+yrgoMtpo2tCf2MGP6ZykGHZkt9wOH0Eb57ndhq84vekFxdnSDMyQ=
X-Google-Smtp-Source: AGHT+IGCkEE4ER7Pe49pqx25rRb5anZsM1vJ2b3g7aVmetiRzKNlw0V9jaes2+k3d+BZAiHc3czOgy6irU/HdVYtcaCxZpYCL2z0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:98c:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d6dcb9deb9mr18124105ab.8.1743663981582; Thu, 03 Apr 2025
 00:06:21 -0700 (PDT)
Date: Thu, 03 Apr 2025 00:06:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ee336d.050a0220.9040b.0150.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Apr 2025)
From: syzbot <syzbot+list35c2a04b7be876f280f0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 1 were fixed.
In total, 18 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 25924   Yes   possible deadlock in smc_switch_to_fallback (2)
                  https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<2> 356     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 259     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<4> 199     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<5> 91      Yes   possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
<6> 70      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<7> 13      Yes   KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
                  https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9
<8> 13      No    possible deadlock in smc_shutdown (2)
                  https://syzkaller.appspot.com/bug?extid=3667d719a932ebc28119

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

