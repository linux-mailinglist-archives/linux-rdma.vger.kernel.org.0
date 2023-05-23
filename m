Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8794870D1CF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 04:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjEWCza (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 22:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEWCz3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 22:55:29 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11AAE0
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 19:55:28 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-335526b351eso5166495ab.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 19:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684810528; x=1687402528;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzBf17vg6dtaNKaRDsG+PPT0AxYkn2WCnZwmKI0a8Ww=;
        b=OoZzJlqsCZgIchkl712SfZ26wC2q7z/dNCU52uLBvTsQ+SvAGQNzFe2yKalncaZyRT
         vgvt501uKpcoWbxro4zyXju3V510sn+NTHF/t3moeCCq0FeyfxDJp9JIa1vhXRVq5PTF
         BiJYYGaz0LHoWCKDFEnAMulrapdYItd7vfBH5rADhQi58Q4Rm1mlzini1nOVAEkAf8ZS
         AlqaMFALsn0z+q29zhw5V5JK0APBX/SfdEPavAaVyazsQRaBRgGd4/Se8VzocYG+rVyD
         MvZkxW/+NyPYMbrIcxv06CVzgePF30fnt4n/XwWH0nTjA7CPhVCdXcUV1sGGdNmZijMS
         IgYA==
X-Gm-Message-State: AC+VfDw9wrcht953486feDpyrsHYt0ZR4LvjBE5td2fib13Wv4jFYv+a
        SWzQEj9jhaikdNh7TQyDFX1hgycMcIRuQypfiMhWuaMqUfkO
X-Google-Smtp-Source: ACHHUZ4HxvGKSx7a74k5XOIS6AmhgczH+9mrK4yfFo1fiil6sOeYFY/5MiHA8viaAEXwgj6gVzYrKXIY/Zydbs9WwAro4Q3CY+4a
MIME-Version: 1.0
X-Received: by 2002:a92:da0a:0:b0:333:760c:8650 with SMTP id
 z10-20020a92da0a000000b00333760c8650mr7006782ilm.6.1684810528147; Mon, 22 May
 2023 19:55:28 -0700 (PDT)
Date:   Mon, 22 May 2023 19:55:28 -0700
In-Reply-To: <13528f21-0f36-4fa2-d34f-eecee6720bc1@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b54ae05fc538543@google.com>
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
From:   syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>
To:     guoqing.jiang@linux.dev, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com

Tested on:

commit:         56518a60 RDMA/hns: Modify the value of long message lo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
console output: https://syzkaller.appspot.com/x/log.txt?x=1100bb5e280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=eba589d8f49c73d356da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10847e2e280000

Note: testing is done by a robot and is best-effort only.
