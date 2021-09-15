Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7FC40CD47
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 21:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhIOThY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 15:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOThX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Sep 2021 15:37:23 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DFC061575
        for <linux-rdma@vger.kernel.org>; Wed, 15 Sep 2021 12:36:04 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 62so2617124qvb.11
        for <linux-rdma@vger.kernel.org>; Wed, 15 Sep 2021 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B61mktkGbwP68xIW0td59BfsAzYam3YtrOnmVe0s/1A=;
        b=Ig9CzW/vjNhJIsfW4jX8l7BewU8rEU/GiEtrw/p2YPnjActKU/GLnn1sOqz9pxYqpY
         UHZcfmg2EmcXcGbJ5ZSmey/gOiIHOqdPDsslVQbl/ElBSacIkwPgGeqX37g2k5cflIpA
         zQCi+scLoXx5XfFNOoL3nRK/eOi0eQLTfdmbWZbrN94ttEzH2pLXqPnkwTABUrhffQEK
         HOuroAaNJ+run9GrILkzP0WwYAjtmEVLeWb+F89TWllbGFCrJVZfU26NQAsZYtw1j9KV
         f0xbfpOKTREXvSP8rfjxbYHs3Vu9UvTGX9mta5Wty3YQJaXs0w/3DGzbWvjpQ0YrFq8b
         GsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B61mktkGbwP68xIW0td59BfsAzYam3YtrOnmVe0s/1A=;
        b=GPttTzS3YXcLzAb2aSO3asH27qfSIzwe4JEhFupKBwZcKvIj+xslWr9QIo5NaDo8NC
         Og/E6ap+Mo1Lwz9+ZEp4ConkTnuqKbuHX6MD2knZ/VSWmWGWtsTNOm/vqpGy0yp/SrNc
         +Vzf7II7p/Y9q0qWzWYdDnO0UOa+FAa7uxytKlk6yqWHVePuojpUxX2AWhnpSoTibo0h
         cYDuwOxUil4+zd0zJmzZH5dEtvdas65HIDC2mui2Dzbt7saClBzZWV4zANkNq6TnzSOe
         sl1cZZLlUCmoMcSTjSmV7OvE5rPCl5PHqz6RWfNUlchQ3vAnYIpST51ktvbDjAkelVIE
         1EhQ==
X-Gm-Message-State: AOAM530EL/Q2/84nrU8/Z3+fKmSNTOJVb2D0ujZnH2RgK1owOdWCxJkC
        ZEF+yCjCHax4QBhm1qHlzxyPKA==
X-Google-Smtp-Source: ABdhPJxM0PJDqbxTr6c3/m/wscBTasnEP9fiWGJKG0sZ90MispV4sp8cEU/235Sfk+ksqsxFFTFPpw==
X-Received: by 2002:a0c:90c4:: with SMTP id p62mr1676493qvp.50.1631734563237;
        Wed, 15 Sep 2021 12:36:03 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s7sm736031qkp.18.2021.09.15.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 12:36:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQahN-0016Gk-Bj; Wed, 15 Sep 2021 16:36:01 -0300
Date:   Wed, 15 Sep 2021 16:36:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20210915193601.GI3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ffdae005cc08037e@google.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 05:41:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fd67ed300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
> dashboard link: https://syzkaller.appspot.com/bug?extid=dc3dfba010d7671e05f5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com

#syz dup: KASAN: use-after-free Write in addr_resolve (2)

Frankly, I still can't figure out how this is happening

RDMA_USER_CM_CMD_RESOLVE_IP triggers a background work and
RDMA_USER_CM_CMD_DESTROY_ID triggers destruction of the memory the
work touches.

rdma_addr_cancel() is supposed to ensure that the work isn't and won't
run.

So to hit this we have to either not call rdma_addr_cancel() when it
is need, or rdma_addr_cancel() has to be broken and continue to allow
the work.

I could find nothing along either path, though rdma_addr_cancel()
relies on some complicated properties of the workqueues I'm not
entirely positive about.

Jason
