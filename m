Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04524BF60E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfIZPi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:38:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33657 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIZPi0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:38:26 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so7815151ior.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rh5tIrifhCGwEblEk0uaUyXDhhvPj9j5rW2V2gwVGcU=;
        b=Vx2Q2UPgYEUF8Xmkx/9xhohOpE68qdaWbVcHX5UDNohEKa9qV/UagHZar2QRyYaxv5
         cQ2Tan6V7e1oZVkIvtuwao3YX/9M4KR+NvjbunDEycr3rq8sECiLESEL9yw3y7ysvdBx
         Utf66xm2wwRHmcKiEoozzcemO9ROevzJeoab7iZRKluzv+8RfoDTPdAmsno6KL7mW0II
         ObVi9yeBbc3dXcQxfCoS3b7DrmNgg4FXi0is9Jh/TFKNIC/AkZ7mtU6nDj0h1d8FpyFW
         F+hRaAPPCCO+NQCj1sYl6ENT+cYyDuYBN6hNiUasFnzSjF3w3S8nYr/WJpqkdvrpbRe7
         gQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rh5tIrifhCGwEblEk0uaUyXDhhvPj9j5rW2V2gwVGcU=;
        b=Qa9Ih653kDhELBbNBKX223hDolB3pHwy1XcMGVvWs+RxxkvKEeDalyVLAb7kEQabLp
         rfk+YlL37VaW6wpqGbX0UvzzYTu5T9xtK07A5oQcYnYx5LHgw6soeKORAAI7OjLtWRxC
         C5Iin8tlLno2xkp5a88EZYi3mpAlTzdOenPZqomgud/WnfZ6BSi3eGGifLEehmyYHzmZ
         ob6appxDWGzEBQI1rn40T553swjUjxvGIGD40l7sMahr3XzW6KyVcr4x1O10ZDng91Xo
         sWfFB5f9LLjdLkDjHzPIMTGR0EY0vo9Q8j65sO97+y+UzFfIVjfHHmSNHk3MWgd9N46e
         q0PA==
X-Gm-Message-State: APjAAAVrAT6KtNt4IUlh67js1eQldaqF7cP0E3/+NowSS0xtS8NyVCK3
        JhZ+XqXZcxY7fz2JssBfc+CcHSdpES775cRtkJY2cnj9Mw==
X-Google-Smtp-Source: APXvYqxVAcTskR1MOwPRDd2AEz8PUi5T5ga+pwMPnis+3DCwSXqmMNV4Ui9T+PF8wy6NWAyUda+SOJWPK/eX/su4NvA=
X-Received: by 2002:a6b:c348:: with SMTP id t69mr3871001iof.66.1569512304072;
 Thu, 26 Sep 2019 08:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-22-jinpuwang@gmail.com>
 <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org> <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
 <ab90033d-6045-fcdf-f238-80d8b4852559@acm.org> <CAHg0HuwJJ3LmUwOOw2Uba0Zq_c9hwUyFBrao2nzpv4y97U1Mvg@mail.gmail.com>
 <40f69402-5f38-c78b-8922-3a77babb4c6c@acm.org>
In-Reply-To: <40f69402-5f38-c78b-8922-3a77babb4c6c@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 17:38:13 +0200
Message-ID: <CAHg0HuxOP7Vhkd3pHi8XZBo2uCBGmMOMgSpBQuPTVY9MLB5EBA@mail.gmail.com>
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

> > Bart, would it in your opinion be OK to drop the file_io support in
> > IBNBD entirely? We implemented this feature in the beginning of the
> > project to see whether it could be beneficial in some use cases, but
> > never actually found any.
>
> I think that's reasonable since the loop driver can be used to convert a
> file into a block device.
Jack, shall we drop it?
