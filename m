Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508A41635D9
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 23:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgBRWKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 17:10:06 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54863 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRWKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 17:10:06 -0500
Received: by mail-io1-f72.google.com with SMTP id r62so14876551ior.21
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 14:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vvU9tXwdt6DNRQ9ZIKmSa6Ax83OtrJ8O+Uu4WXTvhvs=;
        b=XECxLw9q6cxTEFLifkN4hduh0B9XzH80rZBTxkBMB71lTJXCpSt7os9dUjZxEsX1gI
         R2hvP3j3wTWwAbm3RapUnbGV6c4NKsIfuV5ql2nbf3sd6R8ODn4Xhi7CcXk9pmhZvEMh
         7ymPXrs5j28mtMJwY86fICSCwLurJRGiFQO3Zd+hut3QcRHSlTNPz7cuHCnK4rn3roPw
         wKZEazhuxF43UVD8ByxqOT0Mp60E9bKxEtevtjpcp4MP0Z3ilxe5dLSnbz5WnvdLa3du
         r5ONLFSfdEomwujIAW3JPQwyENkO5mLFodOvxk+AILsbA1lUgA6yeCI28xEwTlqsOaxi
         R3GA==
X-Gm-Message-State: APjAAAUq+pZ446WBfC4W35lQP3VSh2azDS1eswo/qzeFLkhrPRFcclv/
        0bXCcqj/gixlYQ1D4emxi7unvXM7ndHDkvaWTw8iWXFSGbEa
X-Google-Smtp-Source: APXvYqwHWH2x83oxfx9QGX//EePWPIvpxo5k9ZSb/O/b/VucK2q030MYWQGFem1gNzIW0vNvvVvdF73iJ44anGyJHvj9ul22L9xp
MIME-Version: 1.0
X-Received: by 2002:a92:58d7:: with SMTP id z84mr20350248ilf.179.1582063804140;
 Tue, 18 Feb 2020 14:10:04 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:10:04 -0800
In-Reply-To: <20200218210432.GA31966@ziepe.ca>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ed37d059ee0efb4@google.com>
Subject: Re: KASAN: use-after-free Read in rdma_listen (2)
From:   syzbot <syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com>
To:     ebiggers@kernel.org, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com

Tested on:

commit:         11a48a5a Linux 5.6-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e5684f9a45838bb
dashboard link: https://syzkaller.appspot.com/bug?extid=adb15cf8c2798e4e0db4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14709845e00000

Note: testing is done by a robot and is best-effort only.
