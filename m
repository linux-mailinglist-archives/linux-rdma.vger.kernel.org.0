Return-Path: <linux-rdma+bounces-13541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2BB8E80A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 00:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0749D17A46D
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF283253359;
	Sun, 21 Sep 2025 22:02:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D518248C
	for <linux-rdma@vger.kernel.org>; Sun, 21 Sep 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492152; cv=none; b=c/ooM8wn5+J/PM/0tXVnaKSEi/iYtdVcK4UmdrhoRUpzOalQ7M9rD78HB4u1hdNu2FMUPu0lY/YbPk767EXgVa+5WDojaeKqerwh0nvo4zF5E+NAHqHV9P0Bdy50hmzwqbVCFE3WiKcOPMtnuRZnS1XdBY5H7poFevy9lfH7r4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492152; c=relaxed/simple;
	bh=+XlZojJtTDKRE98RhcmqipERzvJu7jEpUtHwvEI0L3s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TMobXuoT2Wh6CpPZBAZcM7k1Je6QASXfWXrTkKvqn6oZw7MWTdl4k8SoRrNSgjK0e5RKfMBAsSjR8w+EI4VeprCf78mJFxoRTChOBjUUkGZyan+9t6FpDxDlldMoI8MSW7oPILD3jN2ocC2gFjJBHreMA0fFaAG6DtHde630uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42570afa5d2so31275405ab.0
        for <linux-rdma@vger.kernel.org>; Sun, 21 Sep 2025 15:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758492150; x=1759096950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6DxhZC3m/OCA7QtH0RBYw7QU4Cim20zL6xqbEC0Kus=;
        b=ROODqYEZUqISOTWpbHCGNuDzwxGkONha7YFWk9X+ctesVaR1Zu8hVOXwISOy/AjCL0
         cSagNwXNoDQtXh6ndU9MYBAgfwEaTH9m/kpvwbLNXEZEsBaQa8LYavUhu8HTevs5Fy8C
         IjPjoc2/nuBlEe0sjSD3QabpjPecyLPKIBHf14ZAFq0NjLsoyZIl7/ZHpOvkBV8IX7Bs
         DFi3SHsciOVuxEjya9ZKK/fC8XdbQduwtbgGctE8dCQ61vrUwWBPsdA/UzJu8/ThXmwN
         jqluBCDUP/ZtiVvlgn3mTWgZ5kKVO2Dgi2OuFA/Y7maI+mOmYqmMLvqDJoYOeAQYGlhe
         v1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWmLupBRoykLU5lMWvjtgTsQg05qGgngCiPVmA6UjuOM0kzUB85iq96WBlrmmK8lea5VGOjUzhR9Vuf@vger.kernel.org
X-Gm-Message-State: AOJu0YybHbXjALyD2tq4/6yVWUUu14oZh7P7dn18/kNCd27/iQve4cY+
	ggGYkUXwmOqFOPbQ5dKUnVF8DLdZDcWz5VEEGbM+89tOGUC34OKZ7PnZX4JFBBjCbNb9tg4CfV7
	CBu0QIVjI86HAFNkADYw1MQzMTsbN8Vi8boA34tsgqCbXa5GAfe09Fbbs+HE=
X-Google-Smtp-Source: AGHT+IF3EFkQ/ZnlEHk9t7xQxkHgRkUuEIBNJ0dZM3cnhV00XoYZlti0EzXvqjwN6VGsSl1HuY2lS9okIQoxd4yRn4fzxcrTX7Pq
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378c:b0:424:805a:be8c with SMTP id
 e9e14a558f8ab-42481937382mr133139195ab.8.1758492150202; Sun, 21 Sep 2025
 15:02:30 -0700 (PDT)
Date: Sun, 21 Sep 2025 15:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d075f6.a00a0220.37dadf.0043.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Sep 2025)
From: syzbot <syzbot+list76811b2adc55ba6d5022@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 66 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 818     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 470     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 81      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 67      No    INFO: task hung in rdma_dev_exit_net (6)
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

