Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FAA72217
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 00:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbfGWWRB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 18:17:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46121 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731811AbfGWWRB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 18:17:01 -0400
Received: by mail-io1-f70.google.com with SMTP id s83so48749938iod.13
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 15:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Wc2GRQ8gP6XwuqazuIoFspLdgI5vGhNFmUdsnDHhoCY=;
        b=CGfb/5rkr0tEM4IsueGPJOSLOxogQ8kd8DqpHazxWoVCLQ0OPOsOecCVl8EK3CaV0n
         cz6zaUQfbMdUU5VCCPpMKR+vVtrHBm9S9ctdOeu+OMAxlk1CsST/THT4q1vRzUOMfu55
         iPhMCGf2WQr+W5NmLS+W8Dm+sL4FzLr8mi46z9SkgcWKguLnDrzSwETfShaS32KvTqdu
         778Av5PsmD3rO+O8084rT+6eFokO4ghafQhi0/6SgOROzmYWlPp1q/ahgcQPdSJ6y3uV
         KB40RM65tc8sucbsluBI6jWIBvWthfQrZM0gISyoVLD9h1MiNbrKKkFjZJkTejpPyEVv
         kTpg==
X-Gm-Message-State: APjAAAWFOum/YQPcA+hmkN5TtwcSn4ruOTUUWVPORnmOzoIzqJ3V3bU2
        uBnXK3qLZvk3dtFq1EzFiZ1k6yBNlo5/FcF3dpAGTZHv2+yU
X-Google-Smtp-Source: APXvYqynAoeiP6otUFVILsXnOFuFz0uSuLj1NQooZi4V+EzbzIGh6v4AwqOrxFa7CDpPfgeCk6q5DDGEZIUetLOW5G1d8Jhge8u1
MIME-Version: 1.0
X-Received: by 2002:a6b:6310:: with SMTP id p16mr73998019iog.118.1563920220602;
 Tue, 23 Jul 2019 15:17:00 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:17:00 -0700
In-Reply-To: <000000000000ad1dfe058e5b89ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034c84a058e608d45@google.com>
Subject: Re: memory leak in rds_send_probe
From:   syzbot <syzbot+5134cdf021c4ed5aaa5f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        davem@davemloft.net, dvyukov@google.com, jack@suse.com,
        kirill.shutemov@linux.intel.com, koct9i@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, neilb@suse.de, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, ross.zwisler@linux.intel.com,
        santosh.shilimkar@oracle.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, willy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot has bisected this bug to:

commit af49a63e101eb62376cc1d6bd25b97eb8c691d54
Author: Matthew Wilcox <willy@linux.intel.com>
Date:   Sat May 21 00:03:33 2016 +0000

     radix-tree: change naming conventions in radix_tree_shrink

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176528c8600000
start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14e528c8600000
console output: https://syzkaller.appspot.com/x/log.txt?x=10e528c8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
dashboard link: https://syzkaller.appspot.com/bug?extid=5134cdf021c4ed5aaa5f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145df0c8600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170001f4600000

Reported-by: syzbot+5134cdf021c4ed5aaa5f@syzkaller.appspotmail.com
Fixes: af49a63e101e ("radix-tree: change naming conventions in  
radix_tree_shrink")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
