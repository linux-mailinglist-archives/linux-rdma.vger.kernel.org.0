Return-Path: <linux-rdma+bounces-6506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300689F0B80
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 12:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B243164393
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099871DF97B;
	Fri, 13 Dec 2024 11:43:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE51DF24A
	for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090185; cv=none; b=rL4g0/xWKwyMsty5j0e3jRl4WHmbC2i6+PjXD+2wFX8Q9a5qVZg6/koCisa0mVTNa3NJatCLdM0y5iCEP+fx63lanOQctx1r2EWz4wblkTvoobePQ+C5y6pHlK+5yFyqSOf4rvHwzzHCDhQdcHmI4VzEwjVCKx7ycWxqP75i7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090185; c=relaxed/simple;
	bh=estDcRIo9Ps/V70akpJUOEghJnsuWqhCaWrCUbyCJD8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BH2TtFEiqLPK4AbXw59CjJBK47E1Qd0oaiPAkTTbBhLxJfw8vnCmvSukkTsv7j05GFxOGAZCFEBjwxH6OyCPQJzT6iqXAJ3lao4qCb7kv7jsDrLghKD+RTOkG8j5LGuSxHTfRlYSbRxNprDyI+NgLhaK/808febIjnmcQ+MhAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso26875875ab.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2024 03:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090182; x=1734694982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6njtYwuuhlt+oJFig9mpzBM61IwvHlJyPr4iUNckOYs=;
        b=mSSTyqnz5JnuwuRKq/EID8IK/k+B6cVXRIwC/RrlrwawJDPjBeblqkdPg5M0hX8NAr
         f/rVsMWZKAktS8O78WCx9doanfRD0lF3s0lEL5LG/rtWCZK9cd2w9pcwiXcsr+KnLlbv
         qV8Wf4iZo6jPaqtc1KGeY4uMZlaTipTVnqIldJzfsdkizA796YDUkNzNUShngswHc4CM
         GMkxYov/wda0uryTy/CWJ91mAYWpEx6f9Iq94DJW+NwhvkPdS+c0V+nK/tpeFWU1mJVH
         tHSyvomqw6iNQkkr4bkxY+fIFW1trkK3FLlPEFnYvv2DwV86CsauALNklkqCjcsI22/D
         VSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKWonp4HBTaCOxsXFuoBb1qisGECGrUFkUUcDKCfFon+VPTpxcT0n9gZteEAWVgAjIVo8WMsCx/PmB@vger.kernel.org
X-Gm-Message-State: AOJu0YxOE6gcD878kY92IL1u56pV6EP961GsBHpqSwFdrOQKpIcrUEtI
	QW8TUsSrkbOrK+/F8gZ4F6beDcIEmd1TVc/eUlCK7i6ffo/RUtGCJ5BFfyV59H652zwJKlXqlD2
	lBs617rwHD2E0B6bMVkG1FPHmrUVMidgZN5+orRlA0nbyY/qvcR/ol/M=
X-Google-Smtp-Source: AGHT+IHDAFY/TJurokeAD58Ic6k8Gv/vDg0siFvYAkQ1NFVck19SuU1w02dmhAQMhWSSadJDht8QTW+J8baOcxgzM5T4zE7FxWYz
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c47:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3b02d78812bmr23955515ab.9.1734090182295; Fri, 13 Dec 2024
 03:43:02 -0800 (PST)
Date: Fri, 13 Dec 2024 03:43:02 -0800
In-Reply-To: <675b61aa.050a0220.599f4.00bb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c1dc6.050a0220.17d782.000c.GAE@google.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
From: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, asml.silence@gmail.com, axboe@kernel.dk, 
	clm@fb.com, davem@davemloft.net, dennis.dalessandro@cornelisnetworks.com, 
	dsterba@suse.com, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, io-uring@vger.kernel.org, jasowang@redhat.com, 
	jdamato@fastly.com, jgg@ziepe.ca, jmaloy@redhat.com, josef@toxicpanda.com, 
	kuba@kernel.org, kvm@vger.kernel.org, leon@kernel.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, miklos@szeredi.hu, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, pbonzini@redhat.com, 
	perex@perex.cz, stable@vger.kernel.org, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net, 
	tiwai@suse.com, viro@zeniv.linux.org.uk, 
	virtualization@lists.linux-foundation.org, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de4f5fed3f231a8ff4790bf52975f847b95b85ea
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Mar 29 14:52:15 2023 +0000

    iov_iter: add iter_iovec() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17424730580000
start commit:   96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c24730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c24730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=4f66250f6663c0c1d67e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166944f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1287ecdf980000

Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

