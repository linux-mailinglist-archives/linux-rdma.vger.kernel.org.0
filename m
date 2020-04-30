Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE91BF070
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD3GnO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3GnO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 02:43:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7617C035494
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 23:43:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so5434513wrt.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfLKPd6WdwwFQZMqYshsvE6IdIFdc2Vgh7Bb3+Jqfik=;
        b=QRvMrhdyxAmtsKtLU5lwSwPavpXqMbzey9WokLc7dB5ct6lPUIPGKhIdx9RJCLWfMS
         1VlIo5KWPZPsJ3KVU20Rtpt6pbCuDdkLEi8T8oqWhVbm0sAsX9R4OOmaQMnDreHCOvLQ
         qp0tY5FV5vxVeeJrjqmDhHTAh52d4CjFIkhmhm8n99NnGv8ZPEX7c7yEs2Q44kWqibS0
         2x1cN7BJ48LiI3Kemru2kDpYgCy7hBMu1eXtDUJxu8EeUP9baGi3I50GqH3VCC2uwDhG
         O3/ljnECBXzDIDIg9CTgCtlASko1AqC28we+6yAxeOsuAn2a/0439z+2ytS3ELUv8NZ9
         tIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfLKPd6WdwwFQZMqYshsvE6IdIFdc2Vgh7Bb3+Jqfik=;
        b=XQgse8w/dPUOqOyAxJNSbDGe9lGnRjqDt8yLKahR5FWGmE/0VEaLUxT2eU3VIFWXaH
         IrdztqUVWpn6uCJhdZg+T6dGb2yuqMfpoSJ2Aki4FpyLEBbzEuzNsh6+AUBAlZuWKO+H
         qDDE+AQknvcTUKyv6FAfil0sCsIY99PKxPzqwQPWToqgL3+UXNR3pz6vaApUqsQ8EomO
         /aaSJkBFF0T4cf454rrTScX6+zcfcB1b8sYJ6bskBGFKSKk/5wY5xJ8xamKHAPfv5Cdt
         SKJ2HTff3Modmv9OCgqjcolhTLrpYfDIpMUvNW8DC3FZnSUFsI4fj1zE4XALENPj9EeK
         TqIQ==
X-Gm-Message-State: AGi0PuZ+/hRmoMFUhWyYmNohuqyQsJeX7lm2lDbET03kmRaiik5+yOlW
        d1nLTR6ArsYz+XLhZwLARsXNlSbomRp/HBTLbh/9
X-Google-Smtp-Source: APiQypLGfEl3giFfsoU/P6XTGhs3BHM5vTrm5Gava6IXSWX5Q8m8RHTDn32FvpFYv6r0345z9rRdCS7ET9tjtWz4VKA=
X-Received: by 2002:a5d:6841:: with SMTP id o1mr2039673wrw.412.1588228992516;
 Wed, 29 Apr 2020 23:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-20-danil.kipnis@cloud.ionos.com> <20200429172018.GG26002@ziepe.ca>
In-Reply-To: <20200429172018.GG26002@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 30 Apr 2020 08:43:01 +0200
Message-ID: <CAHg0HuxO+6+on6g-YRmMK8z_n7g1E7gd4fndmUb_w+A8mqBeHg@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] block/rnbd: server: private header with server
 structs and functions
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 7:20 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Apr 27, 2020 at 04:10:14PM +0200, Danil Kipnis wrote:
> > +     struct idr              index_idr;
>
> No new users of idr, use xarray.
>
> Also no users of radix tree if there are any in here..

We don't use radiy tree. Will look into xarray to replace idr. Thank you.
