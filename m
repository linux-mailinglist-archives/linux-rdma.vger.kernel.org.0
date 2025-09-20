Return-Path: <linux-rdma+bounces-13525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB681B8C136
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865467E793F
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71B2EB5B5;
	Sat, 20 Sep 2025 06:52:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76722248BD
	for <linux-rdma@vger.kernel.org>; Sat, 20 Sep 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758351126; cv=none; b=JXY+YZ1W0/7DPc9mSamsZPcCAe9x2jByt9VqYzSjWWukNShm11YVRi9tMZ1pSyw+b5M40KA5iaBb7xOAER96PKtvg1Dr6GSAJW5SRbPiAGiiWn9Lt/PZQwOqyFm7YnonOKyODzoQHQ0+km+o8s+guVYiEXvnMlBHcX6ieMQUMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758351126; c=relaxed/simple;
	bh=0A3UN6LJOPp/OZfQ1gyQ88jOqiCAaywlt9ynTRCXTOQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mY7x00YybzKAIrT8K8e2A42MKcUMA0tEPE+gFeRqIAncznlc+X8/ILjLF+HF4N/9zc/wLTY5zBRGUw/0RSd1jE5KSqBvVRtFowiWTJyqovFU+5Ci8pghP60MuoUXB67X8szX/4bd4suPaG4ZTh5nsAsC/2NobqnBoyaa3gPawZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-40f7be8ecf2so73472685ab.1
        for <linux-rdma@vger.kernel.org>; Fri, 19 Sep 2025 23:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758351124; x=1758955924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4LEO1FGizwQheZAp+/czE31tJW/ITYrqK47/XHpiws=;
        b=dlAdd1q3ynwbxmFcgVia916N0aIxIOpVO3lHhd/wIIc+Z45X5stWyNoJi0Z//L3QeX
         63F3ncwszAj2/iAmOj98UtRZjxsblhxDaL9w/YE+EtgyaIfMSX1XhKubfTp7Pl7ODTZM
         eX2axFgpA4DV1sv8ZrIMg+RDjXrH0/a5fIjSA+k2tiaBL4qWhVJJl9Rrtt/hISetQhXt
         OYksaW7GxV4ktjqHC2i0/PcbeT1wrOHTdj2qAk1OzbiLs0y22jwrpLHqJxey0znxpNq7
         P/edfB4Zl31sWQopLm9SDXqsHS5xcxc8kTOwOxxEkpe7JrUna94HscQKUgJY8o9mO7Kl
         cQFA==
X-Forwarded-Encrypted: i=1; AJvYcCVP3NlJl83nLtgCoK2TvCxYne3ta4yMsJWVYlx9E5swGvyHC+e4Laq82GojRBmko5Q8CBwZALERkwYp@vger.kernel.org
X-Gm-Message-State: AOJu0YzU55cwdFSz6uUkgiNBeyeLGO0FyFZvTPCz/FeEHXD6zYbtEGF4
	a8Qr/unG/lASLuu1xjt1+iDT55kWf+B0UhHR6rwvPXuM/BuHI9hTsvQ2Upsx54cF6H56SNYPERB
	Anao4a3MxelBtOD5S/SFXVtgdmt4rl6HfyfBSKnUTTzqDpZ5Gq8CWhvld7J8=
X-Google-Smtp-Source: AGHT+IFk2ivyv/T41tozdkfanIx6JpttUK1xxhTgZqBmUoSeelYWRE0sOcYZnKVWJMBEFYXr1BsIXV7c521L4jjIKa98VP6cUTpU
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:424:30f:8e7f with SMTP id
 e9e14a558f8ab-4248199c513mr88966625ab.17.1758351124090; Fri, 19 Sep 2025
 23:52:04 -0700 (PDT)
Date: Fri, 19 Sep 2025 23:52:04 -0700
In-Reply-To: <20250920064813.386544-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce4f14.a00a0220.37dadf.0026.GAE@google.com>
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

commit:         cd89d487 Merge tag '6.17-rc6-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10864d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102f5c7c580000

Note: testing is done by a robot and is best-effort only.

