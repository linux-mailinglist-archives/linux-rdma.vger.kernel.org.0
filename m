Return-Path: <linux-rdma+bounces-11495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FCBAE1795
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 11:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAC1189D5AC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834ED283FD0;
	Fri, 20 Jun 2025 09:32:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C72283C82
	for <linux-rdma@vger.kernel.org>; Fri, 20 Jun 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411953; cv=none; b=gbdKGxhyimC5T0JT7RSUmiGwuezRNGmWDs73oy+mmfvb/avLD91JuF0OW4mnctQSTuSOF0fuAxmabZV1iZWAeBwhzu+pHVlsxBOUTVFOKsYaPZB2tOq8GEg3IjDHNaOl9VaizDOTcp7haiR+HlJzaD6a3F1CYIu/nmytMcTLLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411953; c=relaxed/simple;
	bh=+DS0SwWGVhQpF7xks0fNEy+VbOQ73ZppUW78S1YUBSQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R3QDOcGMzlsLAdXNlQ+nzZmQG1El95JvvW22n61F67vxpsBTFwQjbOhbPvcmaWv0cq5l2kocA0HcoC+TKepmPF5dqahSa29+9KUBkc2wK0er7lPM4BmCvyBO1zj5MTrs4HcgCpZSp6Y/mepTsm9kyfDdL+I+FX9ibHPgjLI7288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddc6d66787so24044225ab.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jun 2025 02:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750411951; x=1751016751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfVCfYID8ynNoAhHJetYJjFvlI7W95iRFPmmIzEobSE=;
        b=XM2VJ/RWVsW0vrnVhvhRh/taoMCM6FwwnFDDEGFbsuWIvMVzlJJ3p9YP7F0QtDcN9e
         SbkwRpJ8gtrkAdU5CFhsww4pHM7lDgBnl2FQev9ftN7BVaFPkgkLkdGfTismdwKkEvwy
         jiP0D+bPc27QvFJpFm0oQ2JHBoPhdk53gLl7wl2b7LknRauufu4ozQ4rwu77NsWDxGcJ
         e2UCcMfE7oDsqsZl5JHiYbSN4zH9vWcMB8simHiqU22n42cLcYXuDKGjw5TOU8qThDaP
         OC6Mgo4FMxHKhiDQxNdB+c6SvAd33E4md4e4B/z4qkALG3nygudLwvy4ODicxleGsENR
         81WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQv4tI3gbw6rpar6SCjsxhdiP4ro7NQ65ykBzZTWS3osMx23c7U/LCyou86HzvRKvzMaTc9uMSGZpP@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0pUZEEUQR3a7bU7qiyy7lfkDYNcKi06yfblY76iWjxlErsrm
	1efjtn5K/G4KJuTyeuhewqi8covOICq2xNdf8yWaJJi41lOt5QMEqB3X2J483OkjAOcYc4aovHk
	uqt+CyESqtj+I+QAw23knXe8EKDtMT/Al8EyKMT+EcJn3gBubvwYRg6hVoSY=
X-Google-Smtp-Source: AGHT+IGstLq5VANh65+Gc1YZ63Lb/J4GcN486TU1d/5UDaj2NwXT+37gbrQyZYU3p0tWbq526CIxLzOfT9Hq+MXgpbHqRUdj3xTI
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:3dd:b706:b7d3 with SMTP id
 e9e14a558f8ab-3de38c5c97fmr21209505ab.7.1750411950892; Fri, 20 Jun 2025
 02:32:30 -0700 (PDT)
Date: Fri, 20 Jun 2025 02:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68552aae.a00a0220.137b3.003f.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jun 2025)
From: syzbot <syzbot+list130c9052d10c27bfc9e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 462     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 338     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 72      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 50      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<5> 28      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
<6> 5       No    WARNING in rxe_skb_tx_dtor
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

