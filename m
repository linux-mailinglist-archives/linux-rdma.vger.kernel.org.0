Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC551B0217
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 09:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgDTHCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTHCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 03:02:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9235C061A0F
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:02:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so2066241ilo.6
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeK1G+MEeshIQlAw2ukA6k5dmclkKmqKslpAbKo5XIY=;
        b=gDVywrrS8MK11AaOEaiZpPlE9hTMRnk8bhDUYeX21LT2dQjIQrltq74rWmkaMXkjca
         ssdYH/LmLgwPZp7f9qCUyxzF8aDiX9h4JPSRRTbWAYqaogj3iTDOQ8tTHvNEaDLDHdmX
         juAdFHBKpT1FgGBZm7RQiq/tfjGijW2pjyVyM+FHALn7gX1aMI/F1i2M33P8hgNXyEwu
         A/Y7igRWjr3uGe/hCDYR/sD58TchP9gf34DwZ6p6izliWTaSQSTWoqzxPL3qFknkKFs4
         9RiIYwITqbQfjLGdsQyKZm3ri1wIzWxmI3syu+m6gkXAPW5IStI06YSn4hOCR+SwqY7P
         oxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeK1G+MEeshIQlAw2ukA6k5dmclkKmqKslpAbKo5XIY=;
        b=geHZoWDO76LPMtz4jR1KO3oCuV6YoROpBGHD4D1ur1vRvb2SPXGSjLDclFwXFI+Kho
         3gpQOXdYkReEr3sljnifKq5Qzkg5I4RH0WUZJeg2ENZpa7DhBSQ9aeEukz/n38hwdpI4
         nbH8jkJVOUnORsb8hKl1jQhJhqZAqaKIadJcM/nWHla6+5GncyabOs7fZ4E74445TjHH
         HoeGIYLYcvuF/ltgXUQxtqNkH6wFI6/61f/d5Phbma2Bcfoy01gVchrM2ScDiA789071
         5IFz+lKcC6rCGLTjhglZZBeZtWzoz7XyQouvcD3o9Wi7Ln9ReymT/Pp4cCt5B458z3bi
         g0wA==
X-Gm-Message-State: AGi0PuZMJKPljKFwn5VyL5hoyupQOieauk+NugYvYwUpN45RrUEzCTCn
        yg8qTpAhIJeKgyKp5OpyvYyyhLE5p4zHke/HuOyFeQ==
X-Google-Smtp-Source: APiQypJK/oBDMpDFUCDDfHGhTJVdFzlBHky4uJxOcT9LqRZzFl3VVHMuGoObVkLbtdMkq8lVkx+wY99J6GyU9p2ejF0=
X-Received: by 2002:a92:485b:: with SMTP id v88mr14365464ila.271.1587366120347;
 Mon, 20 Apr 2020 00:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-18-danil.kipnis@cloud.ionos.com> <feb3bb89-5258-6c86-0a14-1b9a4d94188e@acm.org>
In-Reply-To: <feb3bb89-5258-6c86-0a14-1b9a4d94188e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 09:01:52 +0200
Message-ID: <CAMGffEkHXn0KR+5sGrrQjXfkXR3kGiCw5CrdB6kTJSxtNwhBjg@mail.gmail.com>
Subject: Re: [PATCH v12 17/25] block/rnbd: client: main functionality
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

On Sun, Apr 19, 2020 at 1:17 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This is main functionality of rnbd-client module, which provides
> > interface to map remote device as local block device /dev/rnbd<N>
> > and feeds RTRS with IO requests.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
Thanks Bart!
