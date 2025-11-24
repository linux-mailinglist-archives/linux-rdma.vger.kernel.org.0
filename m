Return-Path: <linux-rdma+bounces-14715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6680DC7F3D5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 08:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4983A61FE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA62252900;
	Mon, 24 Nov 2025 07:46:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AF1A9FB3
	for <linux-rdma@vger.kernel.org>; Mon, 24 Nov 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970387; cv=none; b=NscuYX9+vDSKo8Uiuot6QR1xCxlNxSEtsoHyGb1BtMVAy+ksjijWmM1pF6s4Q94ABAMaR3R0ACaj+Dk3SnVpryzaBbkT0Uy/RQjrks3FRg7x+2Y5ngowP2z7+r1OE87ZYxmSdbVSQft+ZvfedQpd+ENDEl912PhvNN36iDaw3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970387; c=relaxed/simple;
	bh=4xNB/nilpZtfVdOhcj6FdiLhPBHM3G5dcosoha1IVnQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FbQECj4nhAYcofJWu0r8GKrsHAae3MMnFwbZPjlfkXQsAxF9HsjNJcWwqJuc94B6DzXFqloc9KKQfCyM+2aUCif0BECesxHwcRYWT6e4PLLHfTw04eQPc0kMNjx1vyXmcmcqvBBh0hOrdJN0SbfeVjyWo7T2epKRLJ3vhFOIYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43328dcdac1so36859695ab.2
        for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 23:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970385; x=1764575185;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttxvOXl0bPzz6xot1ZSj7Ko2e2bMJkWTlI3KmEOuNIs=;
        b=r1FTKt0TfE2NxDmo3zLBqmRGhU7HPUkMwr7iK4TlH9At9YUjU8Xo2AUv7gwHdw+iTN
         0KFJ1alpQwLdhOLq/0NYxtzGWu5Z9BOfDGeACsmaSZ84IXhmj4qa1wT5TLnHKe4oUdNF
         5hKwNEkr4NttjZZ0fDcoV5ecHZqhwXLaOGFwvlzS0ARApCEx19/INFOn9BKZQeDqEU7D
         FPXCjeoY/tH9JcISueRQ359PY8AInlxPd25ttac6k3swfy7ka/l9B4R8aaO2Ej6iFOwp
         QekxHvjuiJyGeaoV2hSCtviQfteP8BBrugiYwbSmpd7zf28/uPJoTfAbObAvkqlMAdTf
         nrXg==
X-Forwarded-Encrypted: i=1; AJvYcCVB0gGOgtnVsiHxqeTMXassgTvbWxf/GbnGc+PZCNjlgrdcCwDeVGMzywisxrxs2VEYQK8J8FOrq1yW@vger.kernel.org
X-Gm-Message-State: AOJu0YzYU10Y+C7Oj6Q/uL9IIcPdGxaNlgWHyCyoEniPlk6ukkYzgdUP
	GlzFING7LS0gzH4F7nTZ8Umb40foeTSV5SRCo84gK0xHqI3gT9s16T5Eli7UJH4sbtwjU3ebhnw
	zOsgwDdYNMU4mrGKRgHuLg6g7Yw6jVkJmUQIWT8JcT4nS6tLD0b9yXhSXADo=
X-Google-Smtp-Source: AGHT+IGpxk/PJ0OfsW3IzlmskyROGbDpBEVQokJQbGTjZ0yZ3hU2rLg1CFTNK9UViGbk5yLMg+HfFlTMf5NJtI2NJ09uqWfi96kF
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:248c:b0:431:d951:ab9b with SMTP id
 e9e14a558f8ab-435b8b6c9c7mr90655845ab.0.1763970385120; Sun, 23 Nov 2025
 23:46:25 -0800 (PST)
Date: Sun, 23 Nov 2025 23:46:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69240d51.a70a0220.d98e3.007e.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Nov 2025)
From: syzbot <syzbot+list82a918bf0af167b1c8dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 66 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1145    No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 579     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 192     Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
<4> 114     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<5> 97      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<6> 8       Yes   KMSAN: uninit-value in ib_nl_handle_ip_res_resp
                  https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

