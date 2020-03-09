Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4217EA31
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 21:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgCIUiE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 16:38:04 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40756 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIUiD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Mar 2020 16:38:03 -0400
Received: by mail-il1-f198.google.com with SMTP id g79so4850038ild.7
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2020 13:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FyBfheArJnhlEred6MZhSVZvPVZpg2r/L/LEQFp4FgM=;
        b=CB/an+r4EetFsPA3Y0DzuTPxYhp39ZNbJ+RsUHjerkVW+/eDSy02E75giQzx3gCjVc
         JufLIK8Fw4wKuJCVBSF8QpQasd3O8c5yvLNaXE1Po6IIwSgq8vpHd9C6aqxTQbFeO/Yb
         gekpiY/Qti7t9+FFu/u7P/bP4z6tcVVg0xNckKpVtaaT1bzwJQz8hX7byL3Ztzcl+WfT
         MROp1mRIhOAGz/GmE57oT9h7D46hdS+CEhUEOEDsCtY062oNBAp6MuWMZwWzbG6ugyVC
         if+oJA1DFcRcQ+BhNLW8ujyYl8ojGyh6rPZyrvTk8vAOCnOuxc6aV8YM/Zgw7VipGuwf
         Hhcw==
X-Gm-Message-State: ANhLgQ35CLQP207+6N55dKsQiOzeJV9ZYmuVopAnzr5NnCAInc+JarrR
        eme/pjp4ShWDaBwShvKQLJY7O53IULh9yFuJWyEmLVoS0Tdj
X-Google-Smtp-Source: ADFU+vs6NRdZDmtS8uYDb8qazIYJpHJg9C6btgA5lHwHjUTKq4FowMq2XkeXEszZfiKOKa90OJ7qMNdL0bP/r7FAK0o6DC1++3rp
MIME-Version: 1.0
X-Received: by 2002:a02:5ec2:: with SMTP id h185mr6650590jab.2.1583786283133;
 Mon, 09 Mar 2020 13:38:03 -0700 (PDT)
Date:   Mon, 09 Mar 2020 13:38:03 -0700
In-Reply-To: <20200309191648.GA30852@ziepe.ca>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce6f6205a071fa5e@google.com>
Subject: Re: WARNING: kobject bug in ib_register_device
From:   syzbot <syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com>
To:     jgg@mellanox.com, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com

Tested on:

commit:         0aeb3622 RDMA/hns: fix spelling mistake "attatch" -> "atta..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b58f96e9824c82cb
dashboard link: https://syzkaller.appspot.com/bug?extid=da615ac67d4dbea32cbc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ca10a9e00000

Note: testing is done by a robot and is best-effort only.
