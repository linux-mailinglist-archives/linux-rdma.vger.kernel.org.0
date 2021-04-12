Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE335BC66
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhDLImo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbhDLImn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 04:42:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83595C061574
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 01:42:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u17so18930079ejk.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mgFyTQB2ZWkRKouessvc0RE6bi0BefXvlF25DpwAIA=;
        b=amYSfXiftN8yIT72dc3kUW24Oa+c+74DcNHf5MldljW+B7YU5fiOeujbX13MHTa1yj
         +GZGR4sMYwYTLxmR0PwuCiqbMSQ+uCYIBvBP1RHAzpwUb4mk/TlPI1y9Jjkc0vwmbuFH
         LJFQI+AnGDl5vkmWWwz/UcojahjdG10l/rwG1NITMVP9/E9ZjXMPnoIepCFwDNeFWpmG
         8mhQCVgGW9FLwOOr/ix0fpai0MP7L0dkjENaTE/9TUG9tmdei8dz5CPuZwRWdH6ZJgIH
         AkJF6LPZMJg6XkpWh4PeCoTl8QDyIzweT894hnRozSV4EhU9Tjr6oqlm+/nJcRjkPYSK
         Gbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mgFyTQB2ZWkRKouessvc0RE6bi0BefXvlF25DpwAIA=;
        b=XZBNRjyIEXgCmt56zTbDvNcsphgfEKWHaD/QT0IvPfbvDhrJ6xvWvImo2nJyb96dSo
         DsSUMN231HQjNfOAhoFWYt3zNhfNST/nQUM6fxt+v/pZqBcslaNmO2OpPxBLdk+uyOMK
         q1FXvHR5yDduSgal0IHA5x0uiAeuV5x491wgHi3KyTL3qcYS7hfOISdwumhPthJdwVWl
         Q26Q6KzlDi6wYHNxC/UjYnzNG8KAMHyycxlPP/Uhi6rbo3SNxjWHkfM87UTTbX9OY5If
         dZckr0n0tcuKUdvBYRQU3N417oaE3s9oNZmZn3WLgsxz/EUzRPcSI5wPgcNHnhrkTIjF
         kI5Q==
X-Gm-Message-State: AOAM530N96TTgMHGXD4TOLxSc3B2H8bN8Tveoyi7Rw+pAg4sFcJc1Xfs
        mDq/pQ5UStaqSJMBU8VkigSLIMU3igJpRRmjf8HNRw==
X-Google-Smtp-Source: ABdhPJxgnc4ralj0eNUpiBdiDv5sY1HF8HIYWfgq/hFvSlsHsWYNi1RLRkjTwBOAX/UNW3HdsuXmcEnqq8r63JoKuRg=
X-Received: by 2002:a17:906:4c91:: with SMTP id q17mr26768216eju.0.1618216944288;
 Mon, 12 Apr 2021 01:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com> <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
 <20210408120418.GQ7405@nvidia.com> <CAMGffE=pu7uhmsBaYBuZB2w+YOogrK+W5yEKRPZxTanx5+f0Gg@mail.gmail.com>
 <20210408135033.GT7405@nvidia.com> <CAJX1YtY2d6YHuDZ0Wbg+c33yoaoCa4_iO6_nT3Krb3uWZFfrag@mail.gmail.com>
 <20210408145124.GU7405@nvidia.com>
In-Reply-To: <20210408145124.GU7405@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Mon, 12 Apr 2021 10:41:48 +0200
Message-ID: <CAJX1Ytb1ztV+hgdqGhWErWooi4j+5JnZVQQ7L5qX6_D8WSemDg@mail.gmail.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 8, 2021 at 4:51 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Apr 08, 2021 at 04:44:02PM +0200, Gioh Kim wrote:
>
> > I think it might be a solution to change the
> > rtrs_clt_remove_path_from_sysfs as below.  It changes the order:
> > first remove the session from list and then destroy sess->stat
> > memory.
>
> Freeing memory used under a RCU lock before doing a RCU
> synchronization is an error, so at least this could make sense to me
>
> Jason

Hi Jason,

I just sent a patch "RDMA/rtrs-clt: destroy sysfs after removing
session from active list".
Thank you for the review.
