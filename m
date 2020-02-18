Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20F01620BB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 07:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgBRGQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 01:16:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39429 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgBRGQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 01:16:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so18452509oty.6
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 22:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbfPddXeE0QPMjXyN0a3kXmjNViDiRwh9bgnEAmH2K8=;
        b=d0+A2ztxlNEsFBCrZ//aWYKpmZj1McPOeRXp7hrPI2UtGXM93siOHfR8Rx8b+8I6z+
         /vMfeMLLvVM8b/vI9xhWJPCqz7Vztwinqs6mq2+x5CWsllg6Ax3nx9/Jq2FTBVAM5lbC
         EHXEyQlUJZzQbGd7fGQQt7kNqg1gD0ZbvPVHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbfPddXeE0QPMjXyN0a3kXmjNViDiRwh9bgnEAmH2K8=;
        b=Xe8fWa+Q6nKsOE2BvnS/915vByLpUYWxYpKHFBzAsSc3yp4dm/3VN+wBRqMGUi0jg6
         TMxd3nfS1S2wKF1MyAl+si+SZIdZWG1PClNSjZ1OYMsWCAlg9aWof5USKMGk1XTYgOBN
         FcC31LvN9rnf7NX2YLekHne3mrgKQvBuo/lokJ5lGBY9Te00HotOIA22FNVEQ+MklXwo
         j50wHEPFZsXLprtnP9WkjwhWu5p7yU8p8jN8Wh/HmQggtx6R8BpN8GJcubh0RtIldxNx
         ZLULJh5uLMSmngg6jGU8Kt4wDA6EHAfigksN0X2yns89i9NBlN51kFynNOm1Vsd1a3qb
         iyOg==
X-Gm-Message-State: APjAAAUauYGAIcAt8VEGSf2UFsrSKCV/JAfugCZ5ll5jSi0xjS4mi1ee
        rzBmpoA8GEbuvFPgJMNePLmDePVpXZdwQF2HDTR2cQ==
X-Google-Smtp-Source: APXvYqymEcy813pHpNEXy0+i8V4xvrQhhrlvbkcO0857nIFcANJFZYGu01jsfsWI5gnUxR9XSRBuTJuK3MjJ5pY1ZHo=
X-Received: by 2002:a9d:4d99:: with SMTP id u25mr1199517otk.216.1582006596511;
 Mon, 17 Feb 2020 22:16:36 -0800 (PST)
MIME-Version: 1.0
References: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
 <1576477201-2842-2-git-send-email-selvin.xavier@broadcom.com>
 <20191218140835.GG17227@ziepe.ca> <903a4154-8237-0178-dc5f-34c58fa06aaa@mellanox.com>
 <CA+sbYW2nvT09ty8FsbG=GC_3MWJLJU8Mh_Lq+96ffvdxnfFr_Q@mail.gmail.com> <20191219141810.GA24224@ziepe.ca>
In-Reply-To: <20191219141810.GA24224@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 18 Feb 2020 11:46:25 +0530
Message-ID: <CA+sbYW2qnO908KvduGNE9uWu0jvXd83cQp3pLc+Mk7PoRb-Tkw@mail.gmail.com>
Subject: Re: [PATCH for-next v2 1/2] IB/core: Add option to retrieve driver
 gid context from ib_gid_attr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Parav Pandit <parav@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 7:48 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Dec 19, 2019 at 10:36:45AM +0530, Selvin Xavier wrote:
> > > Instead I guess a new symbol as rdma_get_gid_attr_context() can be added
> > > too.
> > I am okay with both adding context to gid_attr struct or adding a symbol.
> > Let me know your preference.
> > Or shall i handle this inside bnxt_re itself. Not sure whether any
> > other drivers intend to use this.
>
> Having a function to return the same void * that is passed to the
> driver ops functions seems reasonable and small to me.
Posting a patch with a symbol that returns void *

Thanks

>
> But you could also spruce this up a bit and have it work more like a
> true 'priv' and get rid of that void *..
>
> The container_of thing is really odd
>
> Jason
