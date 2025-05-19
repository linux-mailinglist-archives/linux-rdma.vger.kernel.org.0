Return-Path: <linux-rdma+bounces-10413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01360ABBF53
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275D87AA659
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1627A104;
	Mon, 19 May 2025 13:37:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11401F5841
	for <linux-rdma@vger.kernel.org>; Mon, 19 May 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661865; cv=none; b=L/PnTAOjMa9pWyBh0/yBzth3KGVU5zSUtgoiJ2CgO2OcEAQNIpg37AR/96gMCddWP+2AN3JN5BE6CEoQCDJRn/umeur7pEkWGlAD+SLqbt69r/GAS6X2sKZGc53ZF6+U48noTJ7n+NHR8Y94BWzx+Y2Zu5lb6eW5/9alnfmiSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661865; c=relaxed/simple;
	bh=4ezMdT4TCdJi9BA4h1T0RMJWKu8DgGKgRqI8FBr88aI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TX8HFRuiHS/+jLLZxiQiGXfRJJaWiCP/Z31tPK8gwM6oUIDyriZtRRyf1IbPHURwKL8vXCClsftMJ9b9QihcRDbYiXMxI5e+EA10vFt3Ij5khamqiK86kiR+H2Z1rb8SSm5rFgCul47zN6YnavQRS/DXj4IkwMDqI/Dqr9NVRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2321207ff20so25235555ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 19 May 2025 06:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747661863; x=1748266663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmHmVLS5to/1J2qUe6GSOAdXZhUuNyL4y5/tJYS0NHg=;
        b=bWJhKQAOCRuHM/dQu6j8TfXiJCxI4G46/RrPek6gSPdZgxVg7nzZ5vLhw58Z7EdBNY
         /fDLdQY2t0jpxaVar5FTPv4dCjWicMBC0luGXL0hJPDVdz3G/wPumVafpNPPLsdFmAeR
         mshjK3obCez6Cpd09BopU5z+J9b6LtrnTxGmGjGrA43NwvAMds4r3TTcjU/11SYqEZWU
         caVplbMrg6C4AwaP74cKhO7Yb1GK6M/VQiu8prH5JgM7gwSkz/wc+SqfLT8nVRQdWOvY
         dI8FTuFNQQt1DQ2NMLmqWaFDgMSSj7VJHTjKgISdhdIQ9okf/vP4M3v/YL7rKBvCHMBv
         1jhA==
X-Forwarded-Encrypted: i=1; AJvYcCWx1tMjq3Z+VN6vrRbNPbGZZ7BFGKuOW4p8VxNc3uqbmP14iqKU8MUq054zq6Ow6ECk93AhVeF7Mpng@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf756w7Rla0cMSKoJ01hw6cyrdmivuq+nFkRHJgpeMmBPr58gX
	zVRmnqOKBAAtbjEnj+6FU78SlbUc/iNfHyAbb+D9UfC0aS02KHSrJLiPH+xzz+FrJ9GHRH6FcRS
	W3MJgDrMQlLNflGJuPYOasBPm7XSGkNAoafj2B/XubUXHaRy2ZqkVL0Likek=
X-Google-Smtp-Source: AGHT+IE6y7en3BV9Ror6OfNRB12PQDAh/yNXSR/J6voL1fvH/8PiqEKEpIoTMvtE13gDtcDTx3KRIEg3ZF9avl9PWv70S7YjQXCl
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a8a:b0:85b:5494:5519 with SMTP id
 ca18e2360f4ac-86a231b453bmr1566008739f.5.1747661852704; Mon, 19 May 2025
 06:37:32 -0700 (PDT)
Date: Mon, 19 May 2025 06:37:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682b341c.a00a0220.7a43a.0072.GAE@google.com>
Subject: [syzbot] Monthly rdma report (May 2025)
From: syzbot <syzbot+list07ae2e9bb5b19774106a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 2 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 442     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 274     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 48      No    INFO: task hung in rdma_dev_exit_net (6)
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

