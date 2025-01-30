Return-Path: <linux-rdma+bounces-7339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC0A22D67
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 14:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728A2163B95
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEDC1E2606;
	Thu, 30 Jan 2025 13:12:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7D1ACEB3
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242750; cv=none; b=L106Pe7/BcNraOIz8XXKa/OI04c9V9JpNGQjzykgPmMcKKgKhX90rEIkZalM98hbTy+M1DWdfO53DGSX5ticGMDzrKpHl5LzeMU2Hk7F15Y/CYpm8t2gqKZqN7EB6u4GMpvQXY2rtaC0t/6e906PkSrhOZzQWLn8f65vm6iATzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242750; c=relaxed/simple;
	bh=UWhx295qmY3GWSKOMZW+APOnFJqWoObpRK5OQrnQBYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KeLvj8ZT8+BefOs6S4QwtBHN1CavquPiAg3b2aU0ekFADtLO1tDzHN4LDEwy/NF5ak5nFyTEh740Vjjcow6xpN6tgz4H0TEryNXj7He5ufjdwl+OlC60wYSzTqA8uO5xhIXZOyBTdPHbFoniMUUuA7nqghmgMhvkW0IGV3ZR81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cff02dc800so4937315ab.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 05:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738242748; x=1738847548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcXw+weI9Kk8+GGZ8VUeVAxRzMM7UfZFaRgdoYJYpjg=;
        b=U+Y6I/M3wK/A+JYxOAlM9Vn3o3nwOt7cjeKO+QRuSa/QgFARv9SYDAy1qOBnvtlMnt
         z5tUVpHI4C/uhuGy33xBfrc9amA+k/29jHxsKwqL3Sx3JRWFATeG/Vetoc2p8StTof8D
         yF9tG+VH4UDE4+jscSeQZmkVaOVGXOzQVQ80YICTEVS8t48cIGgWLQ5A+xWgziu5VlXk
         v8wQ6nfjElPMULQxIUWQ/Es4Om1vcL+IfYCw6o6UQTLoXTv5U4SjMGiS6kj+yXugCzWk
         JPC+n5jwIsoBi+/Oe6q10p/YDznYPB3JTiSzEJ4WMEPKLHj70ZtRn3jT1zGAPemiRQV0
         RXdw==
X-Forwarded-Encrypted: i=1; AJvYcCX6C6xlt/ffTIi8b4MZwhiVixR1yTol5pcNHjxpmrlxVQ0QXCICc6RvtWcNQN7rdS+3YYLMa9sKY3gN@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1QVxv4I3QEt2WB6AqlblZxYLKqwfYIHQJ+KGVz+fACyxoNa+
	trn2qfj3Umjtamg4AzqUp17Vq2LtlmmflsoR98EFmrOaTArd7DgDzNewEYjNW93uEcp6RPIqyac
	GNDIcEPmZZ7GnfcJzFKvuL9xjT2QxzSlgImXCKN6d1J+ppE/iU1KPE8s=
X-Google-Smtp-Source: AGHT+IGNGlTx07cXqgLqsCN1w/mv7AKqoofadPmiBbvugykq4wQQuUgPz9Is0j9cRsAtzgcYvLYd/T0AsKEqT//r1fcggDQhJ3Q9
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3cffe42f28cmr68960695ab.18.1738242748599; Thu, 30 Jan 2025
 05:12:28 -0800 (PST)
Date: Thu, 30 Jan 2025 05:12:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679b7abc.050a0220.48cbc.0006.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jan 2025)
From: syzbot <syzbot+list68ee45d79914eff2710d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 62 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 267     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 88      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 61      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 59      Yes   possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
<5> 39      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<6> 5       No    possible deadlock in siw_create_listen (2)
                  https://syzkaller.appspot.com/bug?extid=3eb27595de9aa3cf63c3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

