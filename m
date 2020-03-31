Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E121991E7
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgCaJWE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 05:22:04 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38010 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbgCaJIN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 05:08:13 -0400
Received: by mail-il1-f196.google.com with SMTP id n13so11365188ilm.5
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaIPuaEHfGlz40ytsuyWF6/JgDLQ4j3rGwrQc8nNOeo=;
        b=VgI8wdrsaGL+NGbHkCzSH49Y7Kwn/7Zevnvommr9+aANVihZWB71+LWoaPFNqTywX4
         fzNNYwJwA8KL/YiHJ8e6pLEcDI83Zu+eRPks3DjLUSod1hLhMHeNYCghoCKGm/82p/q3
         TMdeni1Eje9vPwxNubuzs0iJ2EJwbwu4wydKoQPORrXbYXuUO9a7H1itq/G2DDxaYz/9
         34P59XZRP3vGO7sbSRBH9NjLTuNHDliG4HuU6BTGtXeU+rHifrsooS+1bsI1JkZI2R/h
         aEo6m5gu9vUIv1AZ0p2S5OKgZKGVRt7/Sr728HRocUIFGsDomDGbaB81opxaxl/WTEDB
         Vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaIPuaEHfGlz40ytsuyWF6/JgDLQ4j3rGwrQc8nNOeo=;
        b=NgEhZy61GYTjhJ+2Rx7VAOKH7NpGPmIdjpPvVBg6ojTZIpv56P8kz5/u4tZaZnwWv0
         f9YQ1C59kdSfuagWfVv+TuJDxOoj0Vgz8FZBNwR4OglDpXShJaPnEvDVBHluNlzVDSwH
         ClvvspXQ1bxb6jWkgAsIypVn2KfEUsMGCj/IeEAm2+U2iDdlDx0hXzeEVBmlrId5/VTT
         cqHkelziNiUvnc6soVxJ6nA9ZiUQyhxEXc6FrVHCmFsRvIwC4NZgpPJXy7vgcvWhnqO1
         cLxpAosq/KwiOSxOaH96fvvl1lDeErRJo5+2Iizc0YNLe9s5+asLAx0jhEsYzYgpF68B
         PmCA==
X-Gm-Message-State: ANhLgQ1GmSL03zaoO1aJanyH6h84Hf3AcwL6QQ5eo1mAwm82bln6hiRA
        Hfekw57a0MZQ7fEEJGpS1ZBiEblKKB20286FJ8ObpQ==
X-Google-Smtp-Source: ADFU+vuyPdhOQ1fVl1caMfDVAEeg351dCzywDnnsXe4ufhInV7i/V2M30hJ5kR5TWkss0d7Qy48aaDlizNyc0+Qt2yI=
X-Received: by 2002:a92:8159:: with SMTP id e86mr14386435ild.60.1585645691918;
 Tue, 31 Mar 2020 02:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-18-jinpu.wang@cloud.ionos.com> <0b163be9-2cd6-248a-f9e7-a68e690aceb2@acm.org>
In-Reply-To: <0b163be9-2cd6-248a-f9e7-a68e690aceb2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:08:01 +0200
Message-ID: <CAMGffEnmj52TfL=fDcvU_tgW=KpUqVWuCKeVwneU2W7Eo8sMGQ@mail.gmail.com>
Subject: Re: [PATCH v11 17/26] block/rnbd: client: private header with client
 structs and functions
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

On Sat, Mar 28, 2020 at 5:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +#define BMAX_SEGMENTS 29
> > +#define RECONNECT_DELAY 30
> > +#define MAX_RECONNECTS -1
>
> Please add a comment above each of these constants that explains the
> role of these constants. I can guess what the purpose of the last two
> constants is but not what the purpose of the first constant is.

Sure, will add comments for each of them.
Thanks!
