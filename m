Return-Path: <linux-rdma+bounces-12855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8946B2F81E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021B4AC1EE3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320412F0699;
	Thu, 21 Aug 2025 12:33:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DB19E97B
	for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779616; cv=none; b=bpB7LxICuSjciB6u/cSJ3xAqhR7FwgcNBiw6AvzmDznPMOBQFLtW3vJRe7OIXnQBecVND4l3S2EoeQNjKE1lOlFmFGIFu5etfpjTmm1O0aoMyOk01rPOkZuLgRZjjxYkvOc7BrN+r0u3FFh6C8Pj9TtLhldFyBkxR5uKitKwUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779616; c=relaxed/simple;
	bh=x+Hm+jlpve5bhMsoCyS9BQA1Kt5xXfpBC/IqW4ac0us=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LtCsR7bGChoIp32NE1EH9n3oRMpKsTEA9FVRnPPW8Q93tUX/97nOEtVMIR9s2c+xSJU/FPhGlP3iTGc3XdIrIkK0Ez2P6X3FteET61nOkjQjA3iTL6Iq0RjEjbabMgLaIIvReygLRcOAAr1gWQhIA163lf2yluPYwkkTTd+pXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-435de5aa2adso1565750b6e.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 05:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779613; x=1756384413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzZRRGKVVE9scqFqMUJIdWTgztlx3eiucU/EMi2gV+U=;
        b=Q1p0+Nbv4FhMDz9byH3U+/9uX5hlp0LG7vJz+GGFRhrkS1ZBC9ZQrlU3gYfDM0ruk3
         vHbMk2AXS5BGSaQCKWubs+rbXeEsC6FAq03O1QxDly7oGPKyffFUZVUb1qAWHLn6UNpo
         dBUuYQ1kG4jEX1fL7gEhBYKA/KI+4jACjgf1FToHVGY15q5HImZ89Hiel8HJqlW0IMIL
         idenl5PIlLsUVegwDPjM5FVPsQT52TY0QGE7s5YPwNL/o5pyjoSu4veBeSApfxGk/4cJ
         7DAvDCx7ao5L1Sbp/PayWnOgvifbs8eiV66ud9WJBhSFMhJ1moFfSJLMt5kw8Dgva6Pw
         Tznw==
X-Forwarded-Encrypted: i=1; AJvYcCUT18jGNmIuZN4z7OoRxII9n2I/yWQSY0Cv9fdpSabG6SRYAb+yn5CxBdVPGjRPwdyQcxy5ubFTLYd4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr86+/qHRSOYjVVply0JnUxME/6j2SBUOG2FfwKMm+5ObWm0gB
	1coYI7w4nyzLmNmXCNTkeIkYPuEwGxKRcZbjdLG0iPNKjkzjjsO5hK6ZmC5l4qCbGoPDkTRHZZG
	3+Tfbgi5GScJrmx8b3OgHOskB5/oJL/F+ZTply+pwd7jPfDrPjuvSN9LscS8=
X-Google-Smtp-Source: AGHT+IGs+jx2/q3II9+0bk/3Agl8Uiev1mygp+Gevet8yBXKJRz3qHTlp2jWodu3KRQNAlEseKcvqVpZmf7x/lDC31V9kb8WO1Ju
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2394:b0:41e:9fd0:bd2c with SMTP id
 5614622812f47-4377d701a5amr822447b6e.18.1755779613539; Thu, 21 Aug 2025
 05:33:33 -0700 (PDT)
Date: Thu, 21 Aug 2025 05:33:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7121d.050a0220.3d78fd.0026.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Aug 2025)
From: syzbot <syzbot+listd166d65ef55e86d38882@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 567     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 403     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 79      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 55      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<5> 43      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

