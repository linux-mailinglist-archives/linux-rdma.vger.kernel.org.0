Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02E9198CF8
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgCaHcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 03:32:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45251 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCaHcL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 03:32:11 -0400
Received: by mail-io1-f68.google.com with SMTP id y14so3553888iol.12
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tiflqmbJNy/ISkOZp3HcyDqFy69LUMoxztgvrp3UZQw=;
        b=h1MBawhNq08tgkPygGCfyEm94JSKpZ3D0eJneCxxQOIZmVxsXW1RFBHwtsC7Ptjbb+
         bQtLiJoUMyp5SR2OwwnlcfqnUrTV8PGzNmOKh7w3FMn+gb/5kfuqNHYsKzc0WvcIO0ve
         o5zlRmEimdxq1RaZaoOP4vxiWYoMDhLQF6mHzTbNIjFY/zdWO7QxsHE00MCQ6HTfO6z6
         HHaFing6eAKtuqRqYOstvDA0PQFIxSs0AHRBiPwSbF8zatLTM+CFMFf1sM6CUDt1N/EA
         S1iFtGJ0InDRMGbh07/gcvv855/jKJgmkJJuDa1pjy/8HRkuP/hJpLYL5UJoeTM6mHDH
         HFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiflqmbJNy/ISkOZp3HcyDqFy69LUMoxztgvrp3UZQw=;
        b=mDBQg0SUmd+cGe69G4IO+Fx+wg3Nk6Ugmn6jQt6Su2u9rDp+kyEKmCtBozyOV4oFkC
         FLJEV0Ht2+RFIczGBbnCyzIlfeCp9BTxB9zwIhPF0jx4KddDSjTk1AsOQ8QVjhxzXXDG
         8MN3fe9U0/goR+UF9yko5kbY2wM98h9l0KfhgsPXKejoyBhukQBlmKXJiI0cgonKpzdd
         /jXeWLV0MCpkHbV2iuHy0kua5TcuWrA2kpMI0AaQWdZUWiJX0f3KJ2gz3waZipuMQYvh
         DFRsZdn2cxF6FvjhJiJby3hNcwD6bghMqRrVQDEqiqlIGi1vXqn4LPz/7UMTxClCNWYv
         HG0w==
X-Gm-Message-State: ANhLgQ1RDpU+IhB6Uf28SrbwZXbTFtzq82rCLQNCiHaffYIu15NcwOpa
        mjFqPtCPHqHKueA+FfA5jg3RQJBUthjmyo7WrHsGQQ==
X-Google-Smtp-Source: ADFU+vu/QcQ7rP5U+QEEb/x/eUTWclvPdZsvLzN7xRu9fw8Q8TU7CzMbtxNGTtpDdJWTNWgu32eC4xSwy9mb06hgeAY=
X-Received: by 2002:a02:3b0d:: with SMTP id c13mr14860699jaa.85.1585639930849;
 Tue, 31 Mar 2020 00:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-17-jinpu.wang@cloud.ionos.com> <93786c91-3008-9213-82f8-e5716596407c@acm.org>
In-Reply-To: <93786c91-3008-9213-82f8-e5716596407c@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 09:32:00 +0200
Message-ID: <CAMGffEm6XNJOxexDTGz2AZxaTV2f4icx+FkDivGqKzvLYtza9Q@mail.gmail.com>
Subject: Re: [PATCH v11 16/26] block/rnbd: private headers with rnbd protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 5:58 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +#define RTRS_PORT 1234
>
> Is this a default value? Please make this clear either by renaming this
> constant or by adding a comment

Yes, it's default port number, will add a comment!
Thanks Bart!
