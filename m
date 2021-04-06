Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23B354E7C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhDFIY2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhDFIY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:24:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1129C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 01:24:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so14269656ejy.7
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clBGZIZe4sgCSo3K+9SEqmJRY4RiGFqW9mKysDwJGBc=;
        b=hvyOHrzcUITGY0mGunygF9OIgxJDdgwYjc5Te5/josGQ++xEJZiWQMg0R4vVxlPho8
         IUi7vuOJMkKxZmsQKjQmK+gIUUfXzeZlnDhdk9uT/yYKAUYuPGwACOqEvTpQFP+pXyjQ
         xqXvZaXE19ATaYdwGAe8AS1ZFZhK3ThNtoCwNzvGB3xkG60V4CZSUvCBisp2QsqWl1wY
         wWeoawL4BrbeVXxKabaTjxdf6Bx7lXur/HOjFdDWDdXgpDZMSLesBqypr2bLlkICnNTG
         DKZ6R+MO5fuOfGF8KJjsAWO3uxQELYo0/UZ2J5xLSGMbkuJ4WNVmcwfAKjAkmwZzqJ6G
         DBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clBGZIZe4sgCSo3K+9SEqmJRY4RiGFqW9mKysDwJGBc=;
        b=hjV1brU1Qmqg+TzPm4u9dGSFAO/NeZvJ8hZ3/p+y2idYyyndsQ7IISievIOcuUHX0/
         eSE+0kcG5teVeJxAQaamZ0DoWEx0jvICg5PQXg+4oYtPOQwWsZo7mHpItkoo8Oso7MBu
         komxB6mKH3xWkvDUX8ldXmBTaCN1r4TklbjPeWpEpINPNdfQzUASjkdiQZRUNcZmkmun
         wKs+CimXHRS9bgW9LixBc8s2plKd4gw1r5wJ7t2Jq0cith7uvfKuql7OixrQisjLHVr0
         f1D2NJ9yc/GaJo6vtX5BF36mu+zZHUjFPhHQaH2lGDZBan5EYxg5NDc2q8+n1fomOacM
         pcnQ==
X-Gm-Message-State: AOAM531d5bp2gwLBO8uZCHGtLKYXRYeguOeTvKfAw8phZilzCTrdBRki
        ummD/VkHePngq98K+AAmhNd0d2qRgIkKF9i4BtLEGw==
X-Google-Smtp-Source: ABdhPJwJW+GpRsRr85JTaaKScPttTlGN41rA1wvE4LyxRJagmyi+IikNWNWlsORrIIz4BVyWuOQIs5liRCcnFW3DSY8=
X-Received: by 2002:a17:907:969e:: with SMTP id hd30mr11204049ejc.5.1617697459545;
 Tue, 06 Apr 2021 01:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-9-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-9-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:23:43 +0200
Message-ID: <CAJX1YtbZB8cXerBWtALNgs5QEezF2xzvgrThGqj0nTgkrJJ5iw@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 08/19] block/rnbd-clt: Replace {NO_WAIT,WAIT}
 with RTRS_PERMIT_{WAIT,NOWAIT}
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> They are defined with the same value and similar meaning, let's remove
> one of them, then we can remove {WAIT,NOWAIT}.
>
> Also change the type of 'wait' from 'int' to 'enum wait_type' to make
> it clear.
>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
