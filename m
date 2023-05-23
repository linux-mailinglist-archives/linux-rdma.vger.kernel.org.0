Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F870D0E4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 04:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjEWCN3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 22:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjEWCN2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 22:13:28 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E6115
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 19:13:25 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76c550fbae9so270049539f.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 19:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808005; x=1687400005;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld4BfU0VLxl5x6yDFqKhqit5WImG/Bc0Y+8M10OgY8w=;
        b=STaUDzh8+sKlcFG2vq32ToG9HoUmuSM0gZAZIJqic1UFDLWKVt1PA5SrRajKmAmJDJ
         JnGVzGpvEnn731JTIu0gVoTpY/Z4y1Ly8n4GQpBamx5ZzoGDnReA1KIudCNad5vIi2WV
         2AI5QRt3ZRwDyBugV3fq7RazRdUAYXD+pFMJa99NRKO6KrzkDUCgCE1Flt1HA/WzqE24
         vKfhHrukvA5D8cETBKyaiZeUHt6hD7oxscs1thGq1/9aR5Yjr176/T34vfQV1usly+Ku
         3TZ56YYwV6HsqYT4tDuooTP0OKgpLjbsIdqp74ikrtFVKtkgOasypOt5vtAFf3wRXKOI
         KPig==
X-Gm-Message-State: AC+VfDxk33bHyx3ipOnlFH4DpJNYc479YurLvh1MtHD8aZGUoZPVMPS7
        OA8jJf6wKIYxdapQETxDLIfe/ey40biIQAf6yVXYOWgX5gjg
X-Google-Smtp-Source: ACHHUZ6i6qzx3KdoUGB7zeJblsyBnPyyqo41SA9bhWFsK3Nb5NGsyRpwbwbw1HfPzqgiRMrvMwUxicSR/e1VGxCVLUwruyVS/iNd
MIME-Version: 1.0
X-Received: by 2002:a02:85cb:0:b0:3c5:1971:1b7f with SMTP id
 d69-20020a0285cb000000b003c519711b7fmr6203433jai.6.1684808004894; Mon, 22 May
 2023 19:13:24 -0700 (PDT)
Date:   Mon, 22 May 2023 19:13:24 -0700
In-Reply-To: <0f3f5941-0a95-723e-11e1-6fad8e2133b0@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a589d005fc52ee2d@google.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/infiniband/sw/rxe/rxe_qp.c
patch: **** unexpected end of file in patch



Tested on:

commit:         56518a60 RDMA/hns: Modify the value of long message lo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
dashboard link: https://syzkaller.appspot.com/bug?extid=eba589d8f49c73d356da
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132bea5a280000

