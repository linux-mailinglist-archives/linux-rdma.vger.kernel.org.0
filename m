Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E76217C892
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2020 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFWzD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Mar 2020 17:55:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56353 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFWzD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Mar 2020 17:55:03 -0500
Received: by mail-il1-f197.google.com with SMTP id b17so2659580iln.23
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2020 14:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=m8ypvxz+cK1JIvyLt/BMDjKohGZTA1dUlqmR0UXYtMg=;
        b=KpRRmcYnSHVjVZj8UECWGBx6IF+icnP/sjImdAhfJvt6AbaxfQdKMO3BQrtmrAg9oD
         jlb6XLDHMbhIbuJ0HTQNZjTmlgwSl00T+yRtORixgJRP+/Wpnh+6B8i5O7hg/KBlbPOp
         Ns22Mq16rd7rKiPBn4MUERDQOEEPSGAIgOju6AubJNnzt3KiXQszAdvs7Jqc7O/YAWfk
         7vaK2cR5gqDXYkr6UvZ2Orl8M4Tot+uGazG5BkFKVfBZgbAE+V4QyW8NhclmhKoJ0Ig0
         tsX8h1NMrXEcpyssSUTwOIFebKZ+TG/upvPEvBwqA2cbtRzGxRCQcE6bREey0jkykFUH
         HumA==
X-Gm-Message-State: ANhLgQ26+Sgrx6VGwIG2tsxrTqJ9gS4FW8cNeakYpxOonwzRZB4OWIxs
        V1vIdfypqlZeTMvHVgW8Rz3CFM0Y26R12qkcmg6WqPbVK2AV
X-Google-Smtp-Source: ADFU+vvl/Pw/zrYZi3hTs86i/nHL37mFWPQxthR6YKLbvs4Bfi5y+N2n+47G78N/xSSVGDM+PUK1aVBGtLcC1MK5QKPC+D5KtvQh
MIME-Version: 1.0
X-Received: by 2002:a6b:17c4:: with SMTP id 187mr4941793iox.143.1583535302639;
 Fri, 06 Mar 2020 14:55:02 -0800 (PST)
Date:   Fri, 06 Mar 2020 14:55:02 -0800
In-Reply-To: <20200304135649.GE31668@ziepe.ca>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003406b805a0378b77@google.com>
Subject: Re: BUG: corrupted list in cma_listen_on_dev
From:   syzbot <syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com

Tested on:

commit:         5e29d144 RDMA/mlx5: Prevent UMR usage with RO only when we..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d613b606deeaad7
dashboard link: https://syzkaller.appspot.com/bug?extid=2b10b240fbbed30f10fb
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
