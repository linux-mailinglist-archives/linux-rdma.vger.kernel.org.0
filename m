Return-Path: <linux-rdma+bounces-5290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F63993C6D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 03:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E5FB21F3A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0451418654;
	Tue,  8 Oct 2024 01:44:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A414A82
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351844; cv=none; b=TITryhrSq2ghz9ISB4jQy0ZibYqhjnfh6fd6H0uDYFhRnY1nh5WINNTPxB0/jzToQwXclJrlYg23kic3mACxFRY2lnppqLtl2gSR4K2LCQ4bAgvoWvpyjotQwSnAKi8NMLgoXJE3+OuwH8NLRe//i+0BuE5KjDcFUxCZyiRq1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351844; c=relaxed/simple;
	bh=zEiGXPNNi+qV0aR54ss4qOfQqs8mEO+IEjrR6uv8Tx8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MI+RSrmge8EfJg9ioLG2MFQehFytf5yUh1jw7II0zw9Z7rfMpclLdLrWIiLLLmQsJkwsSWdOc43irkOSTNC49t7+Z7xAxMNBSOv/WwaEclScg5JzBzWLp6n6yY6q70okNL9fK/7g+KYBdzKfTAXtH4/H2mR0SMmXWjeFhi9aJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso57656825ab.2
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 18:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728351842; x=1728956642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1J06SoFiK32YSSK7pd1LagUMG6E/yMnS5Pg/4wxUAM=;
        b=S5bIcDC+dOWZOCR3CAHPBWocoFpGBki/W6wvxcEDRyLFsLmTE0bef9WCeGdFf6WauR
         GDI8+R1xVZhjyJbkFVnzjwK/CH4cNy1USTwVOF411Wgt6ruzCiW46AHwEWZTVab2/fap
         NVpmQuw88byHsjEqNEQzaW1Id2aKuMGFW+afEp5VqDDqli1owAwqRJQH0f363tTTT53S
         YTEoSDJL5urgNft2zYHz59ft7ZqfAfYi+uUkSCuBbRttUfkWfVpv3BAJXia/5i/sHCib
         a34o4iCGRRQjx/3W/WjRyuhpB1YiQVMKgSP7Rm6q29Z9DyVzBOPBxgnghPu3B8lLAuNd
         /JPg==
X-Forwarded-Encrypted: i=1; AJvYcCWZX/QAHopctX1RQRElzwn8yFHpGBmG5UFpjRfuCnuuuH/ixKgYC5Pvp1OqeG7nPY8STCKX7KGn8c3a@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtTA9/wTcwNND02mCMuTVRxRTVf2BtIUuzyiHV3Btbq0ALB/t
	eRF6xOAiv0aj1+n6QfOAFCoyAfGKbkHYt5bZ6b88qDAArOCl7LkZhVPAwO9QdXvA/xrnoZVk1sc
	1ilguCJ0xVZNT085oIrZGcX0avSTfqGC+F8RNCsVU+AM/tmlrXw0vcdI=
X-Google-Smtp-Source: AGHT+IEtrMwclXwLk1T+D4m61HcZKuVnKmJ+oYAzW76+X+uCSIGFo56jfuhfh3UacTn3YPpAjTVxw5WCYw2XQx4rootXFgdHencz
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1541:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a375bb2c30mr134150875ab.18.1728351842553; Mon, 07 Oct 2024
 18:44:02 -0700 (PDT)
Date: Mon, 07 Oct 2024 18:44:02 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67048e62.050a0220.49194.051e.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: ahmed.zaki@intel.com, andrew@lunn.ch, boqun.feng@gmail.com, 
	cmeiohas@nvidia.com, davem@davemloft.net, dkirjanov@suse.de, 
	ecree.xilinx@gmail.com, edumazet@google.com, hdanton@sina.com, jgg@ziepe.ca, 
	kalesh-anakkur.purayil@broadcom.com, kirjanov@gmail.com, kuba@kernel.org, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	michaelgur@nvidia.com, msanalla@nvidia.com, naveenm@marvell.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, penguin-kernel@i-love.sakura.ne.jp, 
	przemyslaw.kitszel@intel.com, rkannoth@marvell.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5f8ca04fdd3c66a322ea318b5f1cb684dd56e5b2
Author: Chiara Meiohas <cmeiohas@nvidia.com>
Date:   Mon Sep 9 17:30:22 2024 +0000

    RDMA/device: Remove optimization in ib_device_get_netdev()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16db2327980000
start commit:   c4a14f6d9d17 ipv4: ip_gre: Fix drops of small packets in i..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15db2327980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11db2327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eca3d0580000

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Fixes: 5f8ca04fdd3c ("RDMA/device: Remove optimization in ib_device_get_netdev()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

