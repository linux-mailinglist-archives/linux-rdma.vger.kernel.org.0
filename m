Return-Path: <linux-rdma+bounces-5589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570529B3C24
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 21:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F901F209B7
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594DF1E103C;
	Mon, 28 Oct 2024 20:45:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D686190472
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148337; cv=none; b=GlFFGsArjoMA1MatONkvXCwrJrcXFr4yKDONyBUMdgrtXTXiVJbgNl1sosQ6hom7ETDhyHmqID9LtC0vjfNpmO6OuY29qW6qfJQP1d97QMNwE7iWN8/+DGlXspTWhTPX8Ihx9T8qg5VZWfrRToSvrqW0XLZMz6qQuewmNQ4RiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148337; c=relaxed/simple;
	bh=JlSTUzkhOJrT5VFcvOPsjv667t7ku0zyTga+DMVjXaM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a/5KKoGlqiFOttmdTUBqGLHxF2n0nLSC5swUC4nXV4UF4U9p4da1AAPr+h3zWMTkPpk86HrzDqdoBxG9C6ifuZhM6rm4f7kjmRGx5vKQG9OUlfDnLKaT8wqZw32hTyn+fisPygJL3Gle6aKEqhUVcu73L37mmK3jrSwxDiZ0tgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4e5c68f6bso39495885ab.1
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 13:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148333; x=1730753133;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gm9HIUjtIgm+D7gqVN7uBVlVAbtiOD76ZVg8RQFmbeg=;
        b=MvGVpOvCFfxZcPDd2dd9A6SKyOhlByvk4+PEN3RhcCbRVh9TkWTWmgfK0BHyrzaawF
         tWnlSfjlUVR66vBqAHMobeiUoc7zsIgHbFkhzKlKb7dNjLBO1KQvy7adjUljfelXaZml
         FjrnW4WxzMXGvTRilGhJiFOFDDmx+NnoINahFrucAlHf0xrkrZzuqq+MJoDzJ0Uww+Ea
         biTXWgb1vEb5qjlG4B8LfLjctEW0um7AIiRIxcGW/iV6icg6JXsANrV8Fsu6paoLqRVl
         jyFiCERaY1NOj6z8ABq7s1AJXC1npi8kw9FfQzigePPR9IriiqfKDJTgHkyf6jB1NnlS
         ib4w==
X-Forwarded-Encrypted: i=1; AJvYcCXsjqhEbwHPMVcYZpIihRaP7TicxETV51rRcB7zSyPZ468VYGTN7kxVxiAX30diXGtbvCI0ZustLttE@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLGfQQIWLYF5A85d9n6PDVNLF8StwKoRSy8onO2Tb7kYCBxrs
	KkoVcJNvif1XAwx2DYUW2cXFwfCnVE7BE42F4pu8QJA17rzewdQdV//nSuDoA1lhccpPWv1mWSH
	JKPmV/7+5FshyeozwC0RkoLfY79VU+ZFl7rbiSbXWNS7XR4MXGYSSqWA=
X-Google-Smtp-Source: AGHT+IGZzVyntIeyX/gZ5yaDPioEdLlL7du5r6uZZi31yylONzfTAyJa0yATwAh/BOFzUE7mZXZlsTnS5exUluxtxolLDOBU84EI
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a4ed33225bmr96405405ab.20.1730148333472; Mon, 28 Oct 2024
 13:45:33 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:45:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671ff7ed.050a0220.4735a.0251.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Oct 2024)
From: syzbot <syzbot+list1a9e20eb3cc9c246ba85@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 61 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 295     No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 186     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 33      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<4> 5       No    possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

