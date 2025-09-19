Return-Path: <linux-rdma+bounces-13515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC2B89653
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 14:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4273AD114
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234AE30F942;
	Fri, 19 Sep 2025 12:15:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DC30E0DB
	for <linux-rdma@vger.kernel.org>; Fri, 19 Sep 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284107; cv=none; b=sA7s505F9Ma2hGeNEaWpOibS9u/dJCUcFIE+yE6FmuQvJSVWkv0OEGKN/Q+96OOKfVn9VatH5ypOFjNMzJGpNzGWxlP6LF60wuNv+mEJAlSrOYpKu43E1NkhQUvixIenItUanI2ntEtBfPEDhHm6sM3r1Si1m4Z+eudG424agS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284107; c=relaxed/simple;
	bh=F52Pe6ZzrWg2xOB535H6naWI5/xjhi+X85EvgHGfIVM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XK7cOo252OsWxyAqnWtjSaMwrx0fqgAtBbLgH3jQGic9CH9VAVCiuRVZzMC/14NlA/NKxrvmQJMLdCsH1CXOrtMGnKjjm3jzQSJ4RPDeTBKEkctj/GY7AWcf0Yg/g9TULpb50QpCRVv07f/fIqQBmdRj1vIYxIWF8tUkKkrPc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42486b1d287so7717375ab.0
        for <linux-rdma@vger.kernel.org>; Fri, 19 Sep 2025 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284105; x=1758888905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaASq3nSPIcvtUoCKBtRJSEolffSQ27wcU7lwN8Kr/k=;
        b=GWhLdmgnIoA+VYeYgOpOBlwUrdZrknh/IOgoXaf1cKEiF2+CCPd32GcTvwcRZnZW+e
         ackj8N1GSuiZWYtzwe1cFtxsPjU4P/hSr1eOrilOM8GWF2VQKF6jZ11ckLZtSCNVxh8W
         QrN2ve96lHUMYgZETIfWb0NEBu364IVRWM9zXmh1oXonim7bw3oVhScAS2m7AWgl2eUB
         E2ToJWpcvkf2tQXSnnb46KY4WUC33/pG8FLEZIOIFvseFswevPJd+zTH5SdzmrRv1VXF
         P7O/580o5XTExjyTAa0U1n0vDPohgnav84xOX9pfhdfI/qKGl/yUpcTLkcy9SwURJhTT
         onbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaYlqcHqyj7hSYFGm0hA0HiClN+xGmlDsxzu3Rh/pG7UPcX1iGrdUxs5IpyUTloLk3a3eH7BE+or6q@vger.kernel.org
X-Gm-Message-State: AOJu0YxqX7iD+x0jqww0GyKb7iKu0HrUm7KyEIDyImT497Un/GezNZfe
	S1d/wdm7bebLr/NTiRox1JMsVGNPDCs18wGRTjOGVEH8CjEuSD6kCrONNFfdNjGkZPLIyrw1bRx
	/YeipLF8TRAJwGS6OXs5EgXXddo2VVc6our4FtKrY4VMVA7EIIOxVs27gwmI=
X-Google-Smtp-Source: AGHT+IE1O8Xc6f8LrpO8boudUphXtvq/ClhpDSJmNM3SJDFi102WGVqC7B7iyKEup+Yu/ybdPLc+8ujPyZ6BW73fph6w1dGTVKQY
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378f:b0:414:3168:b9fe with SMTP id
 e9e14a558f8ab-42481991ea9mr59920315ab.29.1758284105478; Fri, 19 Sep 2025
 05:15:05 -0700 (PDT)
Date: Fri, 19 Sep 2025 05:15:05 -0700
In-Reply-To: <68caf6c7.050a0220.2ff435.0597.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd4949.050a0220.ba58e.045c.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	dust.li@linux.alibaba.com, edumazet@google.com, guwen@linux.alibaba.com, 
	horms@kernel.org, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 98d4435efcbf37801a3246fb53856c4b934a2613
Author: Jeongjun Park <aha310510@gmail.com>
Date:   Thu Aug 29 03:56:48 2024 +0000

    net/smc: prevent NULL pointer dereference in txopt_get

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131dc712580000
start commit:   5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=109dc712580000
console output: https://syzkaller.appspot.com/x/log.txt?x=171dc712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17aec534580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a9f62580000

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Fixes: 98d4435efcbf ("net/smc: prevent NULL pointer dereference in txopt_get")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

