Return-Path: <linux-rdma+bounces-13303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C1B541B8
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 06:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C1462678
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10326B2CE;
	Fri, 12 Sep 2025 04:42:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F49260587
	for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757652124; cv=none; b=gB0mTW07NxkrdjQ8z2KIHWWN4dXYC+aKIED5j7aSYRbTo81+YU+ufiMbNbeVfBBWZ2iFPiF/bfV9JxYBhg+r3KdHQozBxkefHrTK3Tp9SSnzFXqhTR5iPEmmqXpN0r7SinsEqmrKZ9TlSe7fvXr1mIMV/XMRzOiT0YVB8xpLMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757652124; c=relaxed/simple;
	bh=Fptw9TkIyST6rg2tazLPSYWcZUmtHqtzpEpZ4Prdayk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S0Ix0QVZq4QomICBvoaYTfVGQFKMY7nRem0lvaEZz1bLGOWsef3Q9KZ7g02TjNDjHIOVmg1dNq0+liqunRE9utK8oxMpBSE6PJTn+/uHWXLgddne57JfuX+QAJdPBrUDCFa0NvaJsy4beI4tozlYr58RMgjZ00j/NWjSo6BYC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-402abd9bfadso19712545ab.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Sep 2025 21:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757652122; x=1758256922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEEv35Wlr+ozjAsH3vwrObCKIxWmWsxGPbGbWyIn5nk=;
        b=fgARA2cM1KfzKRH4FdXGLpvM5+tKs9AetRgiQbp5+P1wyIuUvTuUZojsyqchSBe7cB
         Ld4fNL6A6Pa5wmQBMEypk21HFWiH49Hjy3bmZv+UA9B9vbognBRWMJPyFDNcgSGk9eUb
         8l95ivMdiFv9G4cIKI1+ee8MX544M3PkhBFLImds0pz2X/AR+47Wx3pUjeyMCws9hRx4
         L6b8YSLgK5HaVEamhtH0gTMpXCMf/jLFYHq3Ce15PM6lYRgVXg7zrsbt1gyx805osVOu
         j3hHrW2+BtRHyzyNG8ZJnE7/enu8xricEBvsQfVaIEp4/a/OwFzYR3xO9C2UlNYwpvAY
         pZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB0ZGFNbmsLI2zOQI3g8qUQ6wUj0PEKY+azRx87j0qGDEro+23aGuzp7HX+zuxrS28A6qckVXc2o9z@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7lQ8nB8FNhHmE/v884b/qfIsz4uhtG7UGIlw8M2F/LpOqzu8
	UpB00fWsW8gE7+LXiEpbBDzT6J3SL6NxFDmtC91xjGnHsDINuBgU5+12R+qQYiQr7RUSPyOJFkS
	j8i4H1YeJQdMBfLZZHoWJ7ycu7rHsXzPK1J0L1pwvBcMXoVU2t9jbXfmxZQc=
X-Google-Smtp-Source: AGHT+IGNt9oe189cknDHKvOK7DO8mmhGmDb7pQl7w/dRubRVTvFDLkuRxL+XeO729rtQxdH7CDeVS5fZWUpvBKhsojsOeFHPIIZP
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:403:c8eb:877c with SMTP id
 e9e14a558f8ab-420a42687c3mr30972285ab.25.1757652122133; Thu, 11 Sep 2025
 21:42:02 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:42:02 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c3a49a.a70a0220.3543fc.0031.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: edwards@nvidia.com, hdanton@sina.com, jgg@ziepe.ca, leon@kernel.org, 
	leonro@nvidia.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a92fbeac7e94a420b55570c10fe1b90e64da4025
Author: Leon Romanovsky <leonro@nvidia.com>
Date:   Tue May 28 12:52:51 2024 +0000

    RDMA/cache: Release GID table even if leak is detected

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fc9642580000
start commit:   5f540c4aade9 Add linux-next specific files for 20250910
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10029642580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fc9642580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b52362580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Fixes: a92fbeac7e94 ("RDMA/cache: Release GID table even if leak is detected")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

