Return-Path: <linux-rdma+bounces-13505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9EB86F03
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425897E4ADA
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6E02F39CD;
	Thu, 18 Sep 2025 20:44:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380FB2F3601
	for <linux-rdma@vger.kernel.org>; Thu, 18 Sep 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228271; cv=none; b=bzIocVTCplB2+fe22JlDS3kcBmeYmJn3GsMG8gai1cvS+P5v2IVRH6kXPC9wgzzGVXFk1a/QnQzQmjufX0BXyaDiVPu101JDNzkRFjSnoGUF97nf32OpVE6dE0M2o+4BQ7/txOUmY6bZw/4Cw1Ic9wfXgnsYODpMbpKg4DL8Rz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228271; c=relaxed/simple;
	bh=NfiIJR6kIHevsUQujY5aQQ/4j2GVgOuNSAyAHQIKxjE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mS0AeQVDxl2foFiOTRxZZJt76w/yoEhWTV25sbRu7FgZybkI1/YciBzFF/nBCdsa1n/8jIGQB4z/itY9sf4oaG9avh1NR+R8h86vIJOgiUKhOwyV6Ytm3BWf1yyM/f8IcfTRNFlch1KnJpyQUkU8urwy2w1ivMB4h7lUVCJmgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-40f7be8ecf2so34419795ab.1
        for <linux-rdma@vger.kernel.org>; Thu, 18 Sep 2025 13:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228269; x=1758833069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jy95kM/qgX/gO/SpA4ej+P7GNTHFDJ+aCcX1GcgB2yk=;
        b=KKqZ+/UDRIGeJX1UYSNNNA7gaASsxhRkkDFJ2gdfBoj/PFr7t0pHYhcZEw5Ay1VtiK
         cLEsEUp/bkIWtL5irI93Lr1Ss3bCKusMU8seBjIwVelzefKnBQpN3VOJIqf89mdsbV5u
         a9iKWAy679lZX/LQstydf606zZxx2wwc1/YlrnmaFW2PVU3s6k58hSFsU/H5ialI5nTd
         3LJuzo6C7zA9Tb/2eoHM7tCsmcmnhPhsxgZ+dhGzRMjhnj0guyS79cMS20go8l5MPkYA
         PhNwabarWyFWgP0RqLvsUr6X8R3u98yj5iRFtxto3iFvxRW4v/VuccrZhNwNcKgTEDZ/
         gjKw==
X-Forwarded-Encrypted: i=1; AJvYcCWxpzIhbKpYxvQzbchFBpU9YGj2UAnbxeNCt3H8WgJLFJVaZ8xhAn99EPkfl8RZxLW/udsU5S0GUn1/@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPMewwizR1/6toM5ksgMYrNiSZMLnTRUq1IuacxOruuCCiDAG
	ic9PmXUn6Aj3f9s4406FOvTd7fpfoBL+yamN8cdixxmIAwUaX5Nax4Cmocxg7WZVhAQLiMKFqur
	WyavTkOLuYDN0sRTrek3RFVlImjZyQcBAJ5DrGcsj+UfFQh21dxWqnIGDIY8=
X-Google-Smtp-Source: AGHT+IFu1MADOFwiTOdU5yaJk1ZgNZavxLZ2jQpFx0eMPLtJmGm9swFNp0+N1yEJNO6C9z/DFUwMwah6rUU7Dl2Hk1mJlu3m/iVX
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:424:8160:46de with SMTP id
 e9e14a558f8ab-424819bcc22mr16145105ab.28.1758228269425; Thu, 18 Sep 2025
 13:44:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:44:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc6f2d.a00a0220.37dadf.000a.GAE@google.com>
Subject: [syzbot] Monthly smc report (Sep 2025)
From: syzbot <syzbot+list16381c3f7f9f0890654e@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 1 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 46 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 484     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 128     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 5       Yes   general protection fault in __smc_diag_dump (4)
                  https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

