Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0896D182E44
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 11:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgCLKvM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 06:51:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40316 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgCLKvL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 06:51:11 -0400
Received: by mail-io1-f68.google.com with SMTP id d8so5156533ion.7
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2020 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjAuioxvdSttFV8/uVgl2ySO5YtKGSq0eHvNHm8enGU=;
        b=auCZLFTcTwKttSO25Xt2kAi/Cvul/awOhSQ64kpTxYERzNyUMeMmxzFNVIuMOq8Diw
         DE7Tb6AOPVaYJSVtPe/ryFyWNdDKau30M7KYoo+7sCENNOGvw0M+V36wj7pL8+cqM1iz
         omgL38+rPF+ZVb/izk+qCugy5WXmXRPSL0XcnOOsDYKTqHMwH6INEcqon+pz09fx0EIj
         1e7R0eTTL0KGz9xenRWbP99VvdOrJIZfzGrsENGE4dI72ty3rWcqP8VN83WKfqHqtcX5
         hOKgoLZarTbFrLBYR7pzDwCKu0gN7qKD1ltHNAd66Ui6RkI1nifDPJE5E592rM4rsMcf
         jDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjAuioxvdSttFV8/uVgl2ySO5YtKGSq0eHvNHm8enGU=;
        b=l6HDhC0UE9Pc4QjQUxgrkWnk73C1uDwK2FnbmBYXz/PNySnLYoj/5IA4SGPaEKOMSX
         v/XpMZu0gWOdLYZEho6m7/cm+Opb5CaBabF9u7DBTERs6TJC0GVXA/FID2Otra8Ze7T7
         jpqWZCs0Npk5SukTxZFwD4wrQPPekNoykdzOlOYoNFIDu/mh2et5fJUEy8l2YwYiHthf
         85N3SRcXeTVa+uz2bGDww6oqazbR8lqg2tBqX3UHd9I8Dz1LLDZ33W/abC+OEcs1eLBN
         VXxtVwyTopaMTObbLN/QbfTX51aH5k4ZPr4H7QYOAAtMb0gbDWnFyIcrzYdo5vTHLz9R
         kflg==
X-Gm-Message-State: ANhLgQ2yhoqAoielZikBorFjW2Jv2zEG9AW9aH9AcAPCqrl6TdIlJPNV
        KLFagZQ9kP4eM8AwYSJWVHW3nxeyPxnjlBWmAb0G
X-Google-Smtp-Source: ADFU+vt3PcoogJOf+pM0V1s9XOOS4yrCSX9h/tPds/8RkOInKK0/aS/aW2c1dcMZGlCffx8ZpkrIzHaJRU3pDhcw8Ic=
X-Received: by 2002:a6b:d008:: with SMTP id x8mr6733628ioa.87.1584010270623;
 Thu, 12 Mar 2020 03:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-14-jinpu.wang@cloud.ionos.com> <20200311190313.GI31668@ziepe.ca>
In-Reply-To: <20200311190313.GI31668@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 12 Mar 2020 11:50:59 +0100
Message-ID: <CAHg0HuxHq7_hEkYjpT7-o9w3_T5WVvot2cGLnDp1_mB62Xd40Q@mail.gmail.com>
Subject: Re: [PATCH v10 13/26] RDMA/rtrs: include client and server modules
 into kernel compilation
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 11, 2020 at 8:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Mar 11, 2020 at 05:12:27PM +0100, Jack Wang wrote:
> > Add rtrs Makefile, Kconfig and also corresponding lines into upper
> > layer infiniband/ulp files.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/Kconfig           |  1 +
> >  drivers/infiniband/ulp/Makefile      |  1 +
> >  drivers/infiniband/ulp/rtrs/Kconfig  | 27 +++++++++++++++++++++++++++
> >  drivers/infiniband/ulp/rtrs/Makefile | 15 +++++++++++++++
> >  4 files changed, 44 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
> >  create mode 100644 drivers/infiniband/ulp/rtrs/Makefile
>
> How is this using ib_devices without having a struct ib_client ?
Hi Jason,

After we resolved address using rdma_resolve_add() we access the
ib_device from rdma_cm_id. The ib_device has been registered on
rdma_cm module load in cma_init(). The handle device removal through
RDMA_CM_EVENT_DEVICE_REMOVAL.

Best,
Danil


>
> Jason
