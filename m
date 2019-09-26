Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F7BF5D9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfIZPZg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:25:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42924 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZPZg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:25:36 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so7539850iod.9
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANKXMrQIqZzezj3n0/pxcngnrbP+XTA0XWu5Ideq1CA=;
        b=NmTQHK6YRs8/MQPa6f+dJU4e/4AM9usVsEpdXzVxcUF0kFuwsbz/in38JEq4TNfv2T
         pqPauHSYoBu9apVku06aq3G8sV7z9VAmS25GmYuF9VpB80TMqPihos3Ivx15SJmfrm03
         a005UXHADjzJWW3K481syopMNeTASzd8zGsBUCOar/h2Quvuaj17M3iJvafccRfFQ4dU
         2T0cjfj3QXwIC4SvlYLsJh2hzYnajJ+bd0oWOx/WNiiPxD3JZk5hwLMq1YEkuoIfJ4Lc
         bPv9uLTMHxJZMEkMp4iBB5AQQPH+wxk3kOMtngwhG7trHtpMNVkGkpzV1hpYlR7pJcDx
         sMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANKXMrQIqZzezj3n0/pxcngnrbP+XTA0XWu5Ideq1CA=;
        b=KlbTFIBzla5EYNqJs7zjghV1/iK0y9geWiGH6q4Z/rVQKGT/rgO3uk8tw67hr7pL1y
         Wejf0X2LiNakgcBruLEUuA4o6yGVyciJLY56cR7/ZrkPZRCw3qfOXxQyHd5TdXm/g1G0
         2E5T3cT55DVQcn9+yCMZtcdk5g0HK4oQ8CseXJV9Yu40OiVD8hIsnF1cc5VKY+BDrR7x
         Tpef8BmcFWdtZjs3B4JfuplLr6cf1DvHJ6fzwisTHpwGUN3Sn6GHBtd+Lg9InwBBATrS
         ZjrvB+7Rz2kXTe09SDg5ZmIvrc1OtYQj1D+pCG6B+zfWNt3/dhEtCn4GfBWKsxj+esIv
         FoNQ==
X-Gm-Message-State: APjAAAV5SrdYpTBGEFefBZdHcPQGaHuFriCYDt4rOGubXB37XCfowmO7
        TPGaV9nuJ8MCvIqlu05lO9ZSlg1Yh/e120ZZRa2Z
X-Google-Smtp-Source: APXvYqwpPfJFfBVn7JxVPk2o7p/q+up1RvzhOE1o7ZPdjtuYusLKQyPQf76ZeoCf+/tQ5JGTWzhAP01vfPAUPuumt8U=
X-Received: by 2002:a6b:1882:: with SMTP id 124mr3763428ioy.116.1569511534376;
 Thu, 26 Sep 2019 08:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-22-jinpuwang@gmail.com>
 <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org> <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
 <ab90033d-6045-fcdf-f238-80d8b4852559@acm.org>
In-Reply-To: <ab90033d-6045-fcdf-f238-80d8b4852559@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 17:25:23 +0200
Message-ID: <CAHg0HuwJJ3LmUwOOw2Uba0Zq_c9hwUyFBrao2nzpv4y97U1Mvg@mail.gmail.com>
Subject: Re: [PATCH v4 21/25] ibnbd: server: functionality for IO submission
 to file or block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 26, 2019 at 5:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >>> +struct ibnbd_dev *ibnbd_dev_open(const char *path, fmode_t flags,
> >>> +                              enum ibnbd_io_mode mode, struct bio_set *bs,
> >>> +                              ibnbd_dev_io_fn io_cb)
> >>> +{
> >>> +     struct ibnbd_dev *dev;
> >>> +     int ret;
> >>> +
> >>> +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> >>> +     if (!dev)
> >>> +             return ERR_PTR(-ENOMEM);
> >>> +
> >>> +     if (mode == IBNBD_BLOCKIO) {
> >>> +             dev->blk_open_flags = flags;
> >>> +             ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
> >>> +             if (ret)
> >>> +                     goto err;
> >>> +     } else if (mode == IBNBD_FILEIO) {
> >>> +             dev->blk_open_flags = FMODE_READ;
> >>> +             ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
> >>> +             if (ret)
> >>> +                     goto err;
> >>> +
> >>> +             ret = ibnbd_dev_vfs_open(dev, path, flags);
> >>> +             if (ret)
> >>> +                     goto blk_put;
> >>
> >> This looks really weird. Why to call ibnbd_dev_blk_open() first for file
> >> I/O mode? Why to set dev->blk_open_flags to FMODE_READ in file I/O mode?

Bart, would it in your opinion be OK to drop the file_io support in
IBNBD entirely? We implemented this feature in the beginning of the
project to see whether it could be beneficial in some use cases, but
never actually found any.
