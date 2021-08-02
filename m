Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF43DDAE9
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHBOYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhHBOYc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 10:24:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9CFC00EB19
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 07:19:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h14so33975716lfv.7
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjS28k19BDaYm10Hg0Xzj3NNfyyFREVhBdM24dfS9A4=;
        b=h5BvfLFLIi0DXlDQBXrIIzS2CcW5nl5W/LHrx25OAxydKCN7h6szKc2juyzfoHcW2x
         cfy9bVQ+3dWU73z1BfydRQimpu981MMZ9FQbXkf8cQiHBlAIWRqdRmeJqlBo2FkcFqDg
         d7LLKVtAJV3J5cK+4iAjImDYK4xM9b0Ob/eK7QFM3zeAAlHlaK3wFbBdboi/4XDKxJVh
         zUBqwMfNerfuDag+dG9+Y82OVtwI8S6ab3lNNBlMlzxzUtz+Wjc3I5cXC3l9QFTpSOrW
         wUTSHPoJYA8ThRLLDlbYRh78lECvA4H0fqJyNM4bfORCFjakIZC8NoMpTmJnlycHbaRT
         ZESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjS28k19BDaYm10Hg0Xzj3NNfyyFREVhBdM24dfS9A4=;
        b=F4q1xYnxSCIV6StcbyfUp+cvkHpc8sHHiUw2d/CksUYP0a/KiDeSykZ7z4seucdqwR
         XENduCXOL5doHq6DF6oeHoZKow1uqE1YOtwQcxDLx2cRPYdOPZN68kkU/PqIOjmFyOgl
         XYsfC3NlLYSkP/dK85jdZRftBhJE8DyilM6kIPb3ao+GBy2M8gKP/yNcUdR6nTZiLLW3
         3ftm9SnkEUyvDW3mBhhvAMJDi+Fx1LNtao/Siie3r39RDEZ2r60fRyCM5vu0U4mXEEuI
         lQgSpnzvgiYpAvhoE4xgjbW5pqsHgrXP977mAmPSjeSODDShIKqxECvbG2FNgOnVCeI4
         M4kA==
X-Gm-Message-State: AOAM5302SHn4MxGtRzHIQTyzzdXErxJjdq9qj55p4hZHAOS4aQDHe5wO
        MABLS7dX0Vf6/8fj96MuKv558mA+JCVUSBb98JmBYg==
X-Google-Smtp-Source: ABdhPJw28t9I2rELg++/d0ZVrO9VGudxfMNqCWFQiYypie3jekxiIBZHawlZOJ6j3k1WJo15XkvVrGlxbsXrEorIagA=
X-Received: by 2002:a19:c192:: with SMTP id r140mr12106178lff.109.1627913938834;
 Mon, 02 Aug 2021 07:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-6-jinpu.wang@ionos.com>
 <YQeZkTIOHdqK6noK@unreal>
In-Reply-To: <YQeZkTIOHdqK6noK@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 16:18:48 +0200
Message-ID: <CAJpMwyj2hM8y9=QBRpD5AUb0hozE8=PU_807fZJhAsvZCngOBQ@mail.gmail.com>
Subject: Re: [PATCH for-next 05/10] RDMA/rtrs: Fix warning when use poll mode
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 9:07 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 30, 2021 at 03:18:27PM +0200, Jack Wang wrote:
> > when test with poll mode, it will fail and lead to warning below:
> > echo "sessname=bla path=gid:fe80::2:c903:4e:d0b3@gid:fe80::2:c903:8:ca17
> > device_path=/dev/nullb2 nr_poll_queues=-1" |
> > sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device
> >
> > rnbd_client L597: Mapping device /dev/nullb2 on session bla,
> > (access_mode: rw, nr_poll_queues: 8)
> > WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447 ib_cq_pool_get+0x26f/0x2a0 [ib_core]
> >
> > The problem is in case of poll queue, we need to still call
> > ib_alloc_cq/ib_free_cq, we can't use cq_poll api for poll queue.
>
> It will be great to see an explanation here.

Will add and resend. Thanks

>
> Thanks
