Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDDD354E82
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhDFIZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhDFIZr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:25:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA768C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 01:25:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u5so20549963ejn.8
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPEC7Z0C1S3CtWI0bKM/SzVawZ4wVR7pzA9z9+9Y4iM=;
        b=TAPlMWUf9wyJ1Ary1eORH0Gp1bNpfZlB8U6NIfCM1dosXsTjrczuqhzvn5ekHLSCTv
         eb0r6QDRGZibtoVu/pGVkg8JeMGF0mWlEeE2IlL56/hEBjC4f2Nu8XQQvTtgvpfPOhb7
         kj6SY05e/LDbasYYbIwUfqbqPoCmrQPMTleY6TE+JaKSY0QnergmXj6AlwwdzOxm3EbP
         nhReUCb2yqFcYaNeIb6XAAQ+Ksp49y/FAqsWXrdBo54BJ67lPoMxXArOJOvrf4rJFq0F
         +p/et9C9/nQLft64XKI1E1pGbyOqFK+dqneN1Cthz4Nxf3cpyE+FpUL/E38HkaPiqCIo
         HuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPEC7Z0C1S3CtWI0bKM/SzVawZ4wVR7pzA9z9+9Y4iM=;
        b=f1yLC1mP3ZYEPs8RnNMLb9mPmfgNBRALS4oVYEULhSsV81z3VzOBM0W+gm/wOE9Ji5
         f8UrAbo5N1vM9NggvAgYzR8rCgM74MygLxvPgQXW6uHZ+I2KjQTLylftlsU5r465u/in
         V/vZWOjX7qtQMjA2lC28GjY83IKfO8HiZyBNWJWOl/g8gEgC1Yq/Lw2MOjIlankkhjD5
         K5ifdUivWJXJZwXgfDBtIfpenPme5B2iZinSPzh2z7G33Tb8iGN6ceOifAdDOZv+Tav7
         i0ZnVatab2A3A7n3lPxV7gLx6q3gXNwD2gTTCHTSAjAwXnEZ+XN9KyShtHsgSyLhivam
         ZdLQ==
X-Gm-Message-State: AOAM533Sc/LenzrNn5Fx/gWWwsVni6yPOovu5gOJ8RFc+svUXi+VTY5S
        W/bmDQTMHX9FjZJb9Qeo6JASUQEsYTUxluRrkrHEcw==
X-Google-Smtp-Source: ABdhPJwmE+Rv+h+sBNkMZQXshRB8p3H+2i1cWVJipfBKRd4UYNIZmk0m303Nqzs9u17F5vVs0OJV3jwu7pw3X0xtRqQ=
X-Received: by 2002:a17:906:190d:: with SMTP id a13mr10839476eje.330.1617697538688;
 Tue, 06 Apr 2021 01:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-16-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-16-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:25:03 +0200
Message-ID: <CAJX1YtZLHppqWbgOTneuhQm1jBsKpXqux-1+K5t_GoGZ-SDAJw@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 15/19] block/rnbd-srv: Remove unused arguments
 of rnbd_srv_rdma_ev
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so
> cleaned up
> rdma_ev function pointer in rtrs_srv_ops also is changed.
>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
