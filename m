Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60686265F27
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgIKMCe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIKMC0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 08:02:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B932C061756
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 05:02:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so9600036qkf.0
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D0ZOTZlli3YnxT/U7k9I9lkvcB/+y93d4fQplk7yHJk=;
        b=n0vjFDUzG4qczfNYYEQo0/PtVzhG6uwWdXe6pYAlq+bKliwiMGLEi6iZHnmN+MUf96
         vigHIL3FLLDBmZ208RA29lbJ853ZlKTcsSZwEjZwRKXuOo3+6wjXFz3y0FmOLmVRhoeE
         Oh1X21fEv4NbB+KAJR1egsZQ+e47DXNgoawyg+ok8Z3QC60bO3VMpeY+iag7pMD+MWIY
         SW52UKuvEUkCM3OcftS7ajs50GcI6NhFtwyGZnocEKuyJ3vdMYuu1Pu9MqgVhoApnikw
         NHC4nNhv//lnRtQ3N/pEnV9a0UkT4bLFNi9SQis9HU+SWBg5yPBUOd3+JQmQPQXkdNuj
         3rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0ZOTZlli3YnxT/U7k9I9lkvcB/+y93d4fQplk7yHJk=;
        b=D9Z87c7vUD8X5+7rxZIrSXVRx/fRMrF84HNVB9qaUKlIUAVwSrASolBlV4+NKbIQAH
         6L2jt+BYQgr4uwWPVQIzm20tuc3GcIG8C4ne2DATzEgmDeEQ6dVm0MSMvrdR1V3sracQ
         10MmAAg54gKPBLbKZFDW6n+oLd6xmDbQbcGnx9dUCmno2Nrh7aEKblT8s/Fm0KOHIAhW
         PfeyvIbzW0dZo3v7Kgvdc3J3d+flE99ciQLJBLPJNE0Ixgp5NxWr46Hnutv/bJbjbDNj
         ST0+BqKW+OqsJK7iVqzO8g0oOd9d7YgKIScw19nCWKfSoUUz6uvh5LciJxTGq5v/bLQR
         2TkQ==
X-Gm-Message-State: AOAM531x3kXCNdLVJudlHi5oMfehSecHuwMFqPhNpnwNRne0jNfZ8C8F
        FyfcpXyOVP+onklSL5knl2F+GQ==
X-Google-Smtp-Source: ABdhPJygUW9F4tubVaZ2xlkL1ks7ALZ2LGBS6K77k5kTwE5xiNcEmIj8mnjJVgK2kwSwFGx45VighA==
X-Received: by 2002:a37:4711:: with SMTP id u17mr1100114qka.54.1599825744148;
        Fri, 11 Sep 2020 05:02:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 202sm2417189qkg.56.2020.09.11.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 05:02:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGhl0-004mB3-60; Fri, 11 Sep 2020 09:02:22 -0300
Date:   Fri, 11 Sep 2020 09:02:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
Message-ID: <20200911120222.GT87483@ziepe.ca>
References: <0000000000008e7c8f05aef61d8d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008e7c8f05aef61d8d@google.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 07:09:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1002ea2d900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600e053900000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git 308571debccd7004acf02ea1b7163a96ad772292

Jason
