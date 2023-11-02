Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4E07DF0A3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbjKBKzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346652AbjKBKzK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 06:55:10 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AEE13A
        for <linux-rdma@vger.kernel.org>; Thu,  2 Nov 2023 03:55:04 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e98a9dd333so947092fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Nov 2023 03:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698922503; x=1699527303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la7hzjP2zBKUn3oiit+lIJoZEhMcvAayTPixEdh76yQ=;
        b=xU3kIQ5A7n2eKujKMcRMrlTZZixL7vYX/yd6X87lHzthrielutZ84gOiWd4G5zDc2q
         erlbRBM8JHvp9tIqvDtAngUdfu6ZIxO11K9R8mnMsBROTobJcLPJ5U5L1NJMz4MvWjSg
         jBK9YJxigoCu6JrLweA5r7N/ZF4BOpzKslrL6z/8STuM3bK6aNLdr8BUVVvswvpbHoSB
         Pcc7tmpTFXNE3v3uQqyqrnbO4IqpTdWXFUvGYfhYwNWzNvZY+k4Jt5NLy238GDokpiVw
         ctm3esYiE6LKYBuvcdbFPkuxlEtElMWpf+EzN3l+ayzGjvPs7PWVTwHqiJG8QPxBMY4J
         gfIQ==
X-Gm-Message-State: AOJu0Yw9B3emllqy8mTye6Zzo0Ym5usoKi5DCiHSiNdKPeJlwYjVr+3a
        KeCG65YiFkAjqY88UJ/Czb/ArR3ti0CyP2PT9lzKN5IfbV1r
X-Google-Smtp-Source: AGHT+IElbKg+EeRIp1W9TwX1La69cw8Mn5P2aiLEy92t+6/mJ3coq2apA+VdMgsutl5EcPvBfgvYaOyr/g+K7qN1O8/97/Nr1hUF
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1d0:b0:1e9:90f0:613f with SMTP id
 n16-20020a05687001d000b001e990f0613fmr8462067oad.0.1698922503157; Thu, 02 Nov
 2023 03:55:03 -0700 (PDT)
Date:   Thu, 02 Nov 2023 03:55:03 -0700
In-Reply-To: <0000000000009ee19a0609135c34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d3e3d0609293891@google.com>
Subject: Re: [syzbot] [net?] [usb?] INFO: rcu detected stall in
 nsim_dev_trap_report_work (2)
From:   syzbot <syzbot+193dae06b6680599fbab@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eadavis@qq.com, edumazet@google.com,
        idosch@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com,
        saeedm@nvidia.com, syzkaller-bugs@googlegroups.com,
        tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot has bisected this issue to:

commit 644a66c60f02f302d82c3008ae2ffe67cf495383
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:36 2022 +0000

    net: devlink: convert reload command to take implicit devlink->lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c76cf3680000
start commit:   66f1e1ea3548 Add linux-next specific files for 20231027
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10276cf3680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c76cf3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2911330219149de4
dashboard link: https://syzkaller.appspot.com/bug?extid=193dae06b6680599fbab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b8e977680000

Reported-by: syzbot+193dae06b6680599fbab@syzkaller.appspotmail.com
Fixes: 644a66c60f02 ("net: devlink: convert reload command to take implicit devlink->lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
