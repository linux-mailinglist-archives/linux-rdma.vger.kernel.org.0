Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7EF177C2B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 17:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgCCQnT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 11:43:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42250 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgCCQnT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 11:43:19 -0500
Received: by mail-io1-f66.google.com with SMTP id q128so4266656iof.9
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 08:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10ej2Uh6kgWoftfggTlH7aAmB/MoY2a8fEdsUAY3Q4Q=;
        b=MfsgOPVAFeWYH55ITnz+BWPXJsN5J+QV/i4THP3hnwC0FDhgwlt0jZkThGIawk89Iw
         gYkOISdC/Ny+kfZx7dY7YrW/Ql8vYcl6Tt40dILag29bgnJC3YD6SkK8kev8L633V40W
         WRBGvCnA4BuKyDjtvejJjVr+Q18pXQA7Qq80hJVBjgrqN4ULTkmEuEZ/CVOYAmqqCEMJ
         H2OScDls0RUMeOLq4jor4iyhV5shoKhaoGXANdP30hO2Rko3Flpomy6DBVGVQ2z9d/GO
         CvD3V2+XMlw16joOMHj6JnxJ17c/k3VzOsY3MqeIXUu3a2gNm0/OXkusq5n4vaIe7Ylo
         PBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10ej2Uh6kgWoftfggTlH7aAmB/MoY2a8fEdsUAY3Q4Q=;
        b=RTQItKf0vIV+6zu2QZhn207/kk02EQMx8aB86ChpI6AmNCj7n3rre/MbAKqKHiqcI8
         +3PYW4L0hF32p7lRG2vjbH41+rJ+oy/RBuaIZl6SlKLxM2gWhr1HnNMKTld91CKelD6W
         8NYTaTu309qU0DeAaChuhiouoeBdtPMD5LfNmUYs7uurvE1yv0w45C8dwXoh6HWoWVws
         i2DAIDs+Z5ELCKozKAU5kPRJsaVA0K95P+v5NbBoYEjCiscRFTGEqFqnLZzqfZENxzEg
         /U+GqkjHWEgA5y8FpQndF0FuXfkA+tqJIQAp7DE2CPuOCHp+nkTAZoRTKcyC0adWoAVx
         CQSg==
X-Gm-Message-State: ANhLgQ1L8OsIS1Um0gIzcp3tU9d7MGGJURoNMz6AedL5le+fTEXcNZ9h
        zf8qepCS37dw66ugXWlI8lhS0U/9ZvoWJ7as9M1WeA==
X-Google-Smtp-Source: ADFU+vuc7eI5hgfY/RYI0iFnO6PjeenqayrwfrfDtH3uI9dJN6nWhA6GGuXjDYHC5UaS8zqgze+PjaXpDT9pmOnx1R8=
X-Received: by 2002:a02:3301:: with SMTP id c1mr4615401jae.136.1583253797558;
 Tue, 03 Mar 2020 08:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-22-jinpuwang@gmail.com>
 <92721a50-158f-3018-39d4-40fce7b0f4d8@acm.org> <CAHg0Huy_8hzxxA6R8_EzPNfYd3QN-meUckFStUrjiGeVaGj_Qg@mail.gmail.com>
 <CAMGffEmtJJE8eoMQ4X3MYEJez35M20DaWwTt_3-+hk7i=R-r=w@mail.gmail.com> <4de21393-a65a-f208-a37a-1889f8db5588@acm.org>
In-Reply-To: <4de21393-a65a-f208-a37a-1889f8db5588@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 17:43:06 +0100
Message-ID: <CAMGffEnOHxZLBJZyWGUaTY6eyg2BCz5Jidf6+4tU=ddV45WhzA@mail.gmail.com>
Subject: Re: [PATCH v9 21/25] block/rnbd: server: functionality for IO
 submission to file or block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 3, 2020 at 5:28 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/3/20 8:20 AM, Jinpu Wang wrote:
> > We tried the above approach and just noticed the bio_map_kern was no
> > longer exported since 5.4 kernel.
> > We checked target_core_iblock.c and nvme io-cmd-bdev.c, they are open
> > coding similar function.
> >
> > I guess re-export bio_map_kern will not be accepted?
> > Do you have suggestion how should we handle it?
>
> Duplicating code is bad.
>
> The code in drivers/nvme/target/io-cmd-bdev.c and target_core_iblock.c
> is different: it calls bio_add_page() instead of bio_add_pc_page().
>
> Please include a patch in this series that reexports bio_map_kern().
Got it, will do it.
>
> Thanks,
>
> Bart.
>
Thanks!
