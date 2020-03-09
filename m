Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA817E59E
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 18:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCIRVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 13:21:52 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40109 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgCIRVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Mar 2020 13:21:52 -0400
Received: by mail-qv1-f68.google.com with SMTP id u17so4738813qvv.7
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXjYgzydEIFf6l4K9Z+TCKu5LCpXzo28EhasuTaYcPc=;
        b=Cr+A+zgpZdvxbpOgYgNFNbOk7jcWMIim0WKuj8k5ZLfc9pq/eLdoUOtag1aVvG90DB
         fACdHaxZ9DUgQoPDU+xUerOF8obi3FgOOSHln+z3aZF9ZtzfRbJJ3QMt0iTKmAb5Tdb1
         VEk/G9iiHGDON4B7ESjtKiohfcYBvRb6b5UdTs/ZhjmJu4IV0CO8P5Fo53NAhUHUhfUS
         kyWd0zdIwLqG2IIb40smVrle8jemsBXnf0hf9LzWQoVb353+gD0zFbPcbo/bYlPLTSjT
         m4uva7wEuPZtbQc4HC6ABUyvS3DHiTFRx9fe0mJs7CRzGCq8Ppfq8oGxOl8uYjGAMvaJ
         0y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXjYgzydEIFf6l4K9Z+TCKu5LCpXzo28EhasuTaYcPc=;
        b=M8S3nMWsPaMP8O9b5AbbGP+43xQFo8vgUVmUWGYHdUxhviNdnX0OFhAEdp56GxCbX9
         873EBbXJ43invVRBkg27CuJA0S9rQc9WTQVgLRNHJ2q+hJPawnB0+ssTB9RYjjFULqWH
         gR97l+pro4wAfvSgh/r1WXhDuKrc/1DDk+uN0+aIU5WpYFHZ6qq+hFNm1tBInDK15sH9
         5GHAR/XHeMfXPvzM7BAwM7vfolW/daoBg+J8nentq9CxFCVip+GLtA85D96w1X0eNon7
         ixylGBJ84VxOYiHOMLTSe+Gagq/6zo9fAP3AhemzotjMOOWZDtHxuFreFRCzVJ/sDtWF
         WQ+w==
X-Gm-Message-State: ANhLgQ23R/m6/Bn05IcdWZCrMbtuAs5/cTFqrUZ8bAvnOxwvel9Qf77S
        XTA0BcLDz8zyaeUqGtUoGaH1iw==
X-Google-Smtp-Source: ADFU+vv1L/8G08f/Yc85KgGY+AnoOBeVnN2dPlRns5bBi0k507dbTfnEb3f5U4Ev6N1wE3oD9bTBbQ==
X-Received: by 2002:a0c:c209:: with SMTP id l9mr1222037qvh.190.1583774511330;
        Mon, 09 Mar 2020 10:21:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 17sm5825822qkm.105.2020.03.09.10.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 10:21:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBM6A-0003hk-Cd; Mon, 09 Mar 2020 14:21:50 -0300
Date:   Mon, 9 Mar 2020 14:21:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+0abbad99bee187cf63d4@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in rdma_destroy_id
Message-ID: <20200309172150.GU31668@ziepe.ca>
References: <00000000000059e701059fe3ec2f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000059e701059fe3ec2f@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 11:09:15AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=160452c3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> dashboard link: https://syzkaller.appspot.com/bug?extid=0abbad99bee187cf63d4
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0abbad99bee187cf63d4@syzkaller.appspotmail.com

#syz dup: KASAN: use-after-free Read in rdma_listen (2)
