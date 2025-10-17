Return-Path: <linux-rdma+bounces-13918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96EBE6EA7
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 09:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A0419C205C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9822230F546;
	Fri, 17 Oct 2025 07:22:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546224728F
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685727; cv=none; b=oES3FbqSe3J5axVgky0XvMtroTEHWXfirMCobTXMI8inJHZtpN6IvD77IyWCJL0098vKgP30pm6P/u/UUfmbC1n3VlpfVQp1qoHxoXqXJMLjDvC5V1wSoE9GXZFZkG3pP5dO++GfCkX13q3DBnsK35yZQS9RUZ2wVyagXzq3hqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685727; c=relaxed/simple;
	bh=q8lETvLaobuL3XgXbBKnxQsn+bRCtfzBwaEJQjNgDqU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=of2EO0S5ZvfeX39r6IN/byUQABpfVDuZy0bJVBQkClVifbK8CWg1MX5QqKV0eivMKdmMkPlN8omnVV91eJRvPuTBvsu76Kguo0wlnZBiaGzlLBY/X8/Sq3p+cf3/pyeaVk3oD27/7hNRZFmC5Fkds0hOn49O7LkLz3zFdnlT9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f8824b65fso52034755ab.2
        for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 00:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685724; x=1761290524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdCmJA8jhBXmo4IBQnz6DZIBUwH7MMuVcTakMsfhXEo=;
        b=LA9jSUbr/0p1qqJZfwpHvlkEyHu556Tar70FMTefKtn7B5X9cMTGGpaF2pXTyQINU6
         HvdyGKWTjozPr3UW0hgTEx4BLEqQlVJKo2DVvuX1ujf2ml5jNm+OTJsJrByKnuRDdflN
         4bZWwbXIICut1/KSL+KKL5bvfWPT0+nAC/Bn4iEqh6v/OOSEqOCd48sAesKldWaA9JP7
         GFD7W53+epfrYGSk/HWdwJtQTknyWpnjkk1K62rLdMsOlaQktjoESh8R7+HC/nDal70E
         HkUD0GcozMVFRcucuSXQWtFcLzvUY7xGYygUT+TUUJ9fyREEVofBLMI6cDX8DXmhso1N
         5YSA==
X-Forwarded-Encrypted: i=1; AJvYcCXoK14/oOkzxdXQO4G53mG9HN1DV/MnRbhxZV5Lz59uYwvnKWKuBOcn6IRnK88FVJ9teVl9zjyEUqOr@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlKJMPpCQgv08OTKJ6SEZisHwLr5K7VIUnxT1R0oLv0W2Chza
	9H2yYfYM3xWT1pPt/BffS5d0Wuust/ObTxyayX5MbD+Fox6prgroT+Ral/QXQNwT6+5DpDWoKLL
	NVonvOdl4sF4t689JplLXerP0s3sTXV780/Dz8zA+vRyxDNd/K5+FrJNuQ6w=
X-Google-Smtp-Source: AGHT+IFgiMVnSrEVd2xDfgd8O4XbUaNXWA/Td+9ca2dZKYpiwJtifThtzyAm7PJLavQJCLBlKSR8+m0MYwlDaOv1TnpxDV8mLMiZ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4506:20b0:430:c8ad:81d3 with SMTP id
 e9e14a558f8ab-430c8ad8410mr14490805ab.30.1760685724070; Fri, 17 Oct 2025
 00:22:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:22:04 -0700
In-Reply-To: <20251017065045.1706877-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f1ee9c.050a0220.91a22.041a.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wangliang74@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com

Tested on:

commit:         98ac9cc4 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10084de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f81efe6184ed80d7
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115ba734580000

Note: testing is done by a robot and is best-effort only.

