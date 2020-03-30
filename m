Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 530E71981EC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgC3RIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 13:08:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34661 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgC3RIV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 13:08:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so4130413otr.1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2020 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzOIcpQMGry/S7KX/3i7FgRktSaDHF+E1Qb4eqLRCuI=;
        b=Ad+nBNSpjurCoWqj//saej4OFOKjZlYLa0jKuodco+te+2JVG/IANMC0ikGvaZGOg9
         ehwwvhE5XhgZpWyO0m9adpKNM4PYIQaxkbNUEHZf9Sy3sOzUQ88RnOSIl5hXYIu3symh
         2Yzv1I0vyFWGAEfDUG0zNQuf98O4BdjfDYJTUE7jFws0nGCYTn19Is7qyYIL5hrqRWgt
         rDx0G/o8YABjNrEhlFc6aY35c65jRO4QjO7+cJG871TLgXoTAxgN9C6wlTwv1MsBDXlg
         15QEJSRz69OeHuBm6MfshBiN30xhgVlJOeAU0T4Ra+XlpoI1qPuQCkRPGdDJyx4JBLRA
         whtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzOIcpQMGry/S7KX/3i7FgRktSaDHF+E1Qb4eqLRCuI=;
        b=JIeqH9MYLWJa/uTlWUVIrz6zgykAUPDBU9sO7fpAIo9Pi0PynxKjyErYvmJQJlg8lO
         3rJnaCoQ1vLNaJnTiDCCYRJTB2/CJsNOhTHI0LSPV/TLIvJW69kUJIrDjTRqHp6q9LOz
         R6InTxkJGyG7YMsjLIqTthA6U7JAc6YnGbI1WxuGprtrh6vUCbZEmQ06gDLjQuiu4dQs
         U119N+Dkmqq7mkcVUqVyw8WVViIrXumqaraxQNpqNB0yDvvg45LG//USH4UFJaZ4dWHe
         5bfjOKz0sDxdA9O1RbakugzFQ+z/8fEd09CSJu/xTgOlj3O30bT52C8gavl5mKaKxeh/
         fFnw==
X-Gm-Message-State: ANhLgQ3x0EBRIR0Utw2ZHF5BtBNwyOXiOYh/yyjWYY7KQ1zJkFynhul1
        k2DwCUVwKBs7Cmavx+/wGZOWU0t1Vv7pIsIN8rFGqQ==
X-Google-Smtp-Source: ADFU+vsZduY51eDd7FS9ubS+PNYEHKDob0M//Wghi65nlZ5LqUBQIcY9bjjm+Kk1UD2LVIpEBTaw7W/SLGM8xpAsD6U=
X-Received: by 2002:a9d:6ad8:: with SMTP id m24mr126508otq.66.1585588099575;
 Mon, 30 Mar 2020 10:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p> <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p> <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p> <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
 <CAAFE1beqFBQS_zVYEXFTD2qu8PAF9hBSW4j1k9ZD6MhU_gWg5Q@mail.gmail.com> <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me>
In-Reply-To: <d2f633f1-57ef-4618-c3a6-c5ff0afead5b@grimberg.me>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Mon, 30 Mar 2020 13:08:37 -0400
Message-ID: <CAAFE1bdAbKfqbf05pKBcMUj+58fijDMT-8WBSuwiKk2Bmm4v2w@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sagi,

> Sorry for the late reply, lost track of this.

No problem!

> Can you try attached patch and see if it solves your issue?
> WARNING: very lightly tested...

I have run our tests against this patch and it is working well for our
"basic" testing as well. The test case that previously failed, now
passes with this patch. So that's encouraging! Thanks for the quick
response and quick patch.

One question we had is regarding the hard coded header length: What
happens if the initiator sends an extended CDB, like a WRITE32? Are
there any concerns with an additional header segment (AHS)?

Thanks again,
Steve
