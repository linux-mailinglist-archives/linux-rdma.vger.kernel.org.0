Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326662669C5
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgIKUxJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 16:53:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40963 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIKUxG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 16:53:06 -0400
Received: by mail-io1-f71.google.com with SMTP id j4so7684225iob.8
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 13:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YVXF1g4+lOmnjRf2AcTsASLYPgunWmQEGdeWgbAB0oo=;
        b=UpcHehlqr4DpPEr+qRTNV1NUBJRADIcH756Ld6lKJkrPgPIVH28Qkvl1tzFzqt4K89
         539fHfdvTDMl4UocBwNFhbpmawzXybA7P9gNM6+wlwJ9OV5asTQRo4VX0h6FckevucEH
         WVI9+eYHeTsoruubzHs5DoULpvGOCrlDFVWJus80nsEAe/kjyPxC9/d13EGyov1UkRaA
         Z9RA3OjuAC2wI/sKolsAGVjk5sEx2BXrbz/iGe49f7nk5kjEWZYolYHV9xfRZHi1QI+c
         o0vVlXZUKjgeFS1ruP4t20qeOvGX+w5xuidngi6dEnTBOYwgoHz1bpSAygBlUvZiEdUZ
         kUzg==
X-Gm-Message-State: AOAM533R7KvorV4xEMRSoI7Qqp0ubpNpVPwNQivHyDtjVgKf4lc7qetv
        PE14MOpQy6BZ1bld1S7A9rcck0e6D7/JTkN/pab/Rq9atDuN
X-Google-Smtp-Source: ABdhPJxvuILFl1zVwslz3rOXPBUJrgVwPlDzIfXnq3TUXyLZVXcmchDm7ZTsSvK4buPOgx+5ucO7SLVwjQCZGdi+a624IWfjO167
MIME-Version: 1.0
X-Received: by 2002:a92:8709:: with SMTP id m9mr3488137ild.242.1599857585493;
 Fri, 11 Sep 2020 13:53:05 -0700 (PDT)
Date:   Fri, 11 Sep 2020 13:53:05 -0700
In-Reply-To: <20200911181939.GA1221970@ziepe.ca>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000131cf405af0fdfd0@google.com>
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
From:   syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com

Tested on:

commit:         7c003f9a RDMA/ucma: Rework ucma_migrate_id() to avoid race..
git tree:       https://github.com/jgunthorpe/linux ucma_migrate_fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
