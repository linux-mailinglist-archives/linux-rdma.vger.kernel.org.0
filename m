Return-Path: <linux-rdma+bounces-10373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E8AB99F0
	for <lists+linux-rdma@lfdr.de>; Fri, 16 May 2025 12:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C91BA0A5F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 May 2025 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052F233140;
	Fri, 16 May 2025 10:17:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8E21ABDA
	for <linux-rdma@vger.kernel.org>; Fri, 16 May 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390652; cv=none; b=VFXJP6QMabmzTrloBsxz1H5omqxOCyIUH1d2GgCjdy3dE2He5d01KmJ8ywZArSBmnvZ+G+aqVr2OGizfJGW1TXrr8fidZNNuEvJVdGZIpB7hb7UgdDuRl+aU4Ltn1qYPAvf7kneXfu6VOlv8GLCKtmhQ+Q8R2r5unvw115NrfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390652; c=relaxed/simple;
	bh=Xol6wi0uV1fmTpSn2Y8V20Qyl8nzYWBqxDUmPlg3yJM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lUWAorMlH4WqV0q2EFCuvupUdfpuOn3bgZTPuWCkvReDfE+L+IIOtwNnRd9ekJY3cbWxcgva8SChXLTtygpHDdBw/IfumesZG160FX0UisVGWI8bnUuV394SrWK5RFaXCYk+rgkqme3oGR5zAUkrwNoOWk8RL88/wvWZ2aj0kkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3da707dea42so37922055ab.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 May 2025 03:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747390649; x=1747995449;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6M2DPVjlQQj1l7tZgOW7xpWl0T5tZezkpbkFHSK1Y5E=;
        b=YS3BWIDYoLbnaxefb7JSs/O3bVQMBr7raMk2l+UR3heXEh2qF+XwtTGt0X4Zw4r21+
         Tvt1D00EyznGQzFGi751eWY2NylAxFHx41Q7ni3tUMzhHoKQF6RcHjKUpHrTOnMVtZ4a
         uuqNhoOp1rk4YZe/yIghinl3GB38R8rDgwezH3wi557TbcD5MKOt/DfCyzpC+2yreaYR
         H5AK8CFpzl7jAbqHWcOvWIwGupKDvZ90ErOWUSNLxDC6V9ZOEqwsn1QbY95NrfDhnSpZ
         85V7PUhsFghrlLWDwJwXAqAElfTgyZZ1DopqLDL+rENHbsK/UIh5yQsffWkVsYHegogK
         3Xpw==
X-Forwarded-Encrypted: i=1; AJvYcCUABzRk+YUkPj+0cYN6TRgju5i8yisktaODB1Qf7gm5Kkdl8S2Ob4gKGKU6KkRp2lamjWMzsDWN3DD7@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNEN7z7mTW5tcxUULGs92lrJYbPUZX9vkEY/LRYFnSpnITlrd
	iiQ79qlLGOwOu12clcYVTv//QoVwp00JA/PbtQWCkl85rD1RYLhCmg3YtlnJg8ei1KzTUbs69rU
	dcuUoRA1gCvXd1nEc/meKsuzoW3i4XZG6Dm343UYbOX7/kNJCV2qNvhmQab8=
X-Google-Smtp-Source: AGHT+IGfopz6HPz9olGYC+CF+abURQHYa4/P/72pxan4xxCeMOnsBg7LfD2zgeozwxYJl9XRuPS2SrDFjXshZ3Oivd2P5DV71rBk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:3d8:1bd0:9a79 with SMTP id
 e9e14a558f8ab-3db84334fa6mr37329945ab.21.1747390649487; Fri, 16 May 2025
 03:17:29 -0700 (PDT)
Date: Fri, 16 May 2025 03:17:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682710b9.a70a0220.38f255.0001.GAE@google.com>
Subject: [syzbot] Monthly smc report (May 2025)
From: syzbot <syzbot+listf6f56d6a8ea41d6b17f7@syzkaller.appspotmail.com>
To: jaka@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 299     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 82      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 71      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

