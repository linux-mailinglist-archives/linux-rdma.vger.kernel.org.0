Return-Path: <linux-rdma+bounces-14202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3CC2BFEC
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 14:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D80F189A18F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0630F80A;
	Mon,  3 Nov 2025 13:10:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6A30CDA6
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175437; cv=none; b=StODYP253YHXHCRCEAgzFgL7YEFGTH31ufszsBe8HJgcy1gttybM+BfCixdrAHbw8M7gacVdVjpKXe8TiOf9NvwYQh1Bwi81mfB8cw+MBwiKS8VGoBopjhGizL7Uqnmv2TwO5aeUv+I9ZhN9GbEwrXFTJ3INtHyNz9vsEpQwlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175437; c=relaxed/simple;
	bh=0kweIpBjLwsaUfCaQ3Lz+4RHhynx7QnaLSBzfQ3AiyY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HCn9EycbOgm+CmoDDoe4xVYPZOjErkdF0scxh3H8OQnppCXYvo/JOR3C+ppZy/szxfVB86ve7Nks6RanIxAkevwdP4DvBxpwh87UjqkyfY2spzJS/ohR3JgbCodquN9Ugf/H7Syi/U9RqTxt+XVznQ/OssNO73Gcp0xQUi6VhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43321627eabso80563885ab.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 05:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175435; x=1762780235;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLJ66hhXNV/HWG4YPamY6JleAjJAHrH8FugRFTyDWnU=;
        b=T6JPv4Ks/vwGaJxMywQJ8hGmAzWCSvvZ9TPcKaH2ihLWpAxNBpczZQu0+kl4FsJztL
         OYBb5uCpADBWTYhaaicFwiuSohn3xg2sAuPE0Dek/XBPRmfXiy0L5KNG83gVwk691Ze0
         3asglMcwmOkF762XqNBpBVzcidUVZnyEYLjrmGmoQVpUGJSDZJVqCIQ2Wh48bXpPBLeu
         XXadmqDIeHOA5qf8SLKkKDqI1wO/8vXUPddtJp6IqZ8F4F4oMyONJ2ShXrZ5MwtBvVsq
         0qWQIp2J8jMenw6PxsOcuTabjIG/VRPfG40jYbDm/HqfyuBItrokOuWuUSlyMPX6DqL6
         KYAw==
X-Forwarded-Encrypted: i=1; AJvYcCVLo6gZgJMXV9NXRLmybqucHSRzVyL3Ggml0Y6GB0Xl/QIDhMO4wW6xB/pIX+/Hwg9+oU2aUEAJBfO2@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBYmpq92yu1ycTKZn1q3HLt4YGull29T5xS6AZIVfvLizacV/
	FTAOpgy99JsyZse/XJ/5o0+42Jt14yv+hJ9uGMF12SbWuOqH/X36zWF8IdwGSePNRFyLRFw9koi
	UUYQUzpQK+IH2eUftXWpa25DXjKK6jUYuPCqreD/q57/5e+/kjx9pfJAGaGo=
X-Google-Smtp-Source: AGHT+IGnJXgJ7H+vLRXpvZRmXLRGl0W558D8Tz1IMtZDd5OAmew3vHktzusxKJXjGf2AlKR+2Ffxyj3Ze76tWWaNL2NhFXcpRuWU
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:270a:b0:433:2aad:9873 with SMTP id
 e9e14a558f8ab-4332aad9b89mr55929615ab.29.1762175435219; Mon, 03 Nov 2025
 05:10:35 -0800 (PST)
Date: Mon, 03 Nov 2025 05:10:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908a9cb.050a0220.29fc44.0047.GAE@google.com>
Subject: [syzbot] Monthly smc report (Nov 2025)
From: syzbot <syzbot+list2de134faa4e1daa63f2d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 49 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 573     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 146     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 19      Yes   KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
                  https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

