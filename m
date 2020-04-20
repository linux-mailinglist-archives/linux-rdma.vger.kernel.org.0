Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7181B0210
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDTHAH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 03:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTHAH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 03:00:07 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB4C061A0F
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:00:06 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t10so8668397ilg.9
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqFHvk9xZJMhRW6+AHUh/bF20SKI/1RsLvajNQQNBGs=;
        b=KCNp8rGwRnCAuSN0lzCD/tn8MYyA7kQF91BbYLmpORDMnrcXuIuChTQYUQyeP8S7VH
         CPEBvqhVypW0z83GmQ4A/efMtysHw6cUuc3zCEe9xUJWQdrxrGQmVsytNtfsYlI1JUUJ
         No/aJnvgMDu1Nx8+mqdcYPwtdFZO3clb1N0QmCzaLIV8yVbw3EByidHrzn3svF8GhZqG
         DPSX2hCCg9hcr+w0fmLk1GQzCYXIzH87lhHMFIvkDu5o6shpWWD6+I7g2wlKdbQc7Tub
         ipYhm51xxqEWiWihA9/ls8m45aUs83avCkOk7E5lgrymYYOKtHDIwFdnuAR7GinnUoq5
         3tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqFHvk9xZJMhRW6+AHUh/bF20SKI/1RsLvajNQQNBGs=;
        b=qBixFLbNfdBXTVEhrMkp8p9cH0v0yz9OHS6P6/BGG55EqIgsFoH3efgkzeuVjtD8g4
         9UwimnePBLbfMn6b4XmkAz9pkCEJQD/AQpyLjb5sLzyjFQU5A4WDGXk8CL9gyVh1sn+S
         677/1pqXvsk5XiMJB1A5YlBEvtXSnBrf/YKEXBPk0w5QhnM2mzG35t9QY2DfUtboJLCL
         DVuVt0w+EeazHBTEnm0RWmcW0IUDkmAJALPg0HrggrJ+YPwjE0Pvw7+096/nqUdCy00I
         warlRyuClLdPWRK098/3gPJkz+cbblL3GVgDJ34Weqpu3gH5ZW2O+WRpo/+oGUGZwrLE
         5hnA==
X-Gm-Message-State: AGi0PuacaM7C+fL3zxUawMXE8QhP0NV+RvadLQCJJRpJDgSFTxfQyxFL
        3PseOuLv6JG95CUXCQvnRzLx3KqeVK2063HR2QQRhg==
X-Google-Smtp-Source: APiQypJhe8HdzU4OnxZXYK5jbfEnwUHB2gcgv8KOyhw/a7sV/4/6jwE73UXeEBFLBVpav1spqkcTALB5Xi4Ei+XBN9E=
X-Received: by 2002:a92:9a0a:: with SMTP id t10mr14601371ili.50.1587366006140;
 Mon, 20 Apr 2020 00:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-22-danil.kipnis@cloud.ionos.com> <d4603c67-ba0c-bb33-51cd-ef454bbb097c@acm.org>
In-Reply-To: <d4603c67-ba0c-bb33-51cd-ef454bbb097c@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 08:59:57 +0200
Message-ID: <CAMGffE=9iiA_-7shU_6P-hjnVbwogMqpBwUmbWj5pjMEw6HZPg@mail.gmail.com>
Subject: Re: [PATCH v12 21/25] block/rnbd: server: functionality for IO
 submission to block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 19, 2020 at 1:38 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This provides helper functions for IO submission to block dev.
>
> Should "submission" in the patch subject perhaps be changed into
> "submitting"?
>
> Anyway:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
"submitting" seems to be a better word, thanks Bart!
