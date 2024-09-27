Return-Path: <linux-rdma+bounces-5134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F629988643
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C053A1C22D8B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F19189903;
	Fri, 27 Sep 2024 13:28:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430D6AAD
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443710; cv=none; b=kj7txkEFN9aBDKH8dZbiA9dBQc4v52ROjrQTnVQxKBtUGfPIA+0TJaZRSnao1acVL68kULfhdEbVWFGY5x9Qrm0OEa+NXHp5CEB0W6F4vX+QyBd5tAan4FHtbZkQWhBJezC6aWvHUotO0igIdWsM2bCWOGcukTRaqhg7AwYlFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443710; c=relaxed/simple;
	bh=0E3niAAD+G6Dw2wZipJtWeSFOTc8oYKzVvOCAU88kD0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=csYZWOPSih1nOAskpRZzKQRJv15qYrUMvfvHryXpenXIpv5vH/SECoT49Q+oiqKjWRCxD5I3hnAveYqyB1eLUp1TKBBR24TIbuW4j7PKdK7eQlRl33venU2mBPG81nw3B6NmKjhUf45j8pT0fuNAEI38mHVMp7rBm/gY7BRDrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342e7e49cso20162875ab.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 06:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727443708; x=1728048508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=et3EJGS/ZhbG/lI88ALbK4RuafRSN9jb2K6pRh2BmS8=;
        b=Z7/yrq5XcqsiFl9e3rbHrMnyA6hsI8iLOoYy3O+fQOHeXdsOaB5o3dXXl8ETIU1WWQ
         3DLrnSGU6OAzGBQzN2LlnvpltLY/lqNyDmnrTrwLnDezjA0bYtqXf9mXdjtTZ6KNfZ3q
         6XKSkCArzxi38qoU6Q2dNZdV2CLBcLXEvOlR0B3Oee6SCSuPYrxuB8runCH57MhyjOgo
         i5up3EeZlJWQ3pWsQqOcqhFPUPea8aqJBU0Q4kOfLKv/Opia4nukR7uGslnlRY84K79E
         22GRUtf1pirQlPYMzeniOzDxIjBagNh2nUgMCkmsGz8g6GurSt1Q/rFZYF/Jhfj4N68X
         5W8w==
X-Forwarded-Encrypted: i=1; AJvYcCVGUCssNma8UDlvJymlRJMYHrNal9rftSOLbtWC17dd+DDOTgw5V6NMwii8Pe9k0kNXGyFcOsAouj+m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+KIDf1QVl43XMgoop8/IulCPnr7tNYzebBtmZdbuXIH2Q0vK
	ZiVr27/tymRGj9AS61r35GcY2Ztdpq0bbeReA4sP0he+JvPw+fpaM9ut1OyCE5+SdfNd0ZU7JFR
	NzOLPvUxiK/Tt7+NQ87oyrUt8B7xWrBHp7cr1R+p369Kvp20ClDsvkrE=
X-Google-Smtp-Source: AGHT+IGbAy1zQGCXJ8P9FxZGs/Bk5j8b4JyoiAHF4y/M7LM/1pm90J9RVbpSJypvRrLgcIFQE61mi6q1oqHqwWy35OxkvgbNl7YX
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3451c3a08mr32873305ab.24.1727443708274; Fri, 27 Sep 2024
 06:28:28 -0700 (PDT)
Date: Fri, 27 Sep 2024 06:28:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6b2fc.050a0220.38ace9.0013.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Sep 2024)
From: syzbot <syzbot+listae4a64541abfe3a7a043@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 61 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 135     No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 111     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 26      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

