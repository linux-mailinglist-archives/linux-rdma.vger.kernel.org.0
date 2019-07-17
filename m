Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093156BD1A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfGQNfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 09:35:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35274 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfGQNfm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 09:35:42 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so45780911ioo.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ip3PPd0vndEj34DMzxl7S9eVAI3Kqx6dxvHTivb13uM=;
        b=G94DRGnSBlJrQoBBLz3aZfwibG38R9JBN7e/+I8wSk/xBaJ32mWnDnKz9Ewr+lAQN0
         baqG5OHmW/mReGSvE3xCJ3EzYglPDW2FSMdvPajTyKBgudnyix5WL6OsTrKjrvS6uI7b
         8Mxf+N+NYY1qURa8utyKpgQxafQbgT0Rt1gNBYvmMyQUjtCu0Hx2u+WhQUai9TJ0yGSd
         QIcjjKylRX1z2J/WThucqcfH/4EwWHY0Xu/eD41Br3QMIjrOMIYNO+3yIpGdOuRXMs2Y
         FaeUvTBBArmry1lrZpyFtugWd3grcMt2Y9JAGCJ77jwIpKDBttu4xflhXRXFGde8cQeP
         gceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ip3PPd0vndEj34DMzxl7S9eVAI3Kqx6dxvHTivb13uM=;
        b=oa9CVS6UCYeQ+8EbFZtiuAvdOmCoYKP5qjgGHDyQRexn13UoHxMUTI93qen03I8klf
         0j+0iysyOoRYQiCi5aLWJyTcP9yk2NMXA8jjINmhuuJnLEbfExrkBBCy0khuWnRNhJPD
         axsZpCyMd8k76/rDtWuONH01/POkjgeF9oFJQi9qKQmzpCD61MhKfit8TeWLK8dokJ+v
         vVK7FP23VcA7Cqb0wex2BTKz3NTgHms6wbH02SxMHxv7t/prumas9FuLTTevBvUJCjJR
         tnSOTRI6SM4gz7vZ90q09VyPvmpdL/3KZ80ONcS1GqgS8sF8DqNzwPouOcE+Nmf46nX3
         m21g==
X-Gm-Message-State: APjAAAXUEzP9A48xCqQ4a5xc7GCUCuEBHRbYOggY/Ca/adKHcsnxvEdY
        EtdNRgJ7AZOhs1KWg2ryyj0JFxtLQViGDhOBQmA=
X-Google-Smtp-Source: APXvYqwxkYi7LiulJnYpg5EXi7U+VdMz+g4x7FDC1aLhyzeslPQBwBBbOYWMdjgT8bZJ0pRHk1FMDcI0fnx8uvYKH2s=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr40538589jar.2.1563370542008;
 Wed, 17 Jul 2019 06:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190716181200.4239-1-srabinov7@gmail.com> <20190717050931.GA18936@infradead.org>
 <CA+KVoo7oSdpX2j1hRT1gPFFrxkHLBfcxXh4HaxkjjNKD550sYg@mail.gmail.com> <20190717115507.GD12119@ziepe.ca>
In-Reply-To: <20190717115507.GD12119@ziepe.ca>
From:   Shamir Rabinovitch <srabinov7@gmail.com>
Date:   Wed, 17 Jul 2019 16:35:30 +0300
Message-ID: <CA+KVoo5wVzUovQvAXyZzsA8rK9=FuMEkNJDDwJteXe9-eLFu3A@mail.gmail.com>
Subject: Re: [PATCH 00/25] Shared PD and MR
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 2:55 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jul 17, 2019 at 02:09:50PM +0300, Shamir Rabinovitch wrote:
> > On Wed, Jul 17, 2019 at 8:09 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Jul 16, 2019 at 09:11:35PM +0300, Shamir Rabinovitch wrote:
> > > > Following patch-set introduce the shared object feature.
> > > >
> > > > A shared object feature allows one process to create HW objects (currently
> > > > PD and MR) so that a second process can import.
> > >
> > > That sounds like a major complication, so you'd better also explain
> > > the use case very well.
> >
> > The main use case was that there is a server that has giant shared
> > memory that is shared across many processes (lots of mtts).
> > Each process needs the same memory registration (lots of mrs that
> > register same memory).
> > In such scenario, the HCA runs out of mtts.
> > To solve this problem, an single memory registration is shared across
> > all the process in that server saving hca mtts.
>
> Well, why not just share the entire uverbs FD then? Once the PD is
> shared all security is lost anyhow..
>
> This is not the model that was explained to me last year
>
> Jason

We do share the whole uvrbs FD (context) with the second process and
let that process to instantiate the PD & MR from the shared FD.
The instantiation include creating new uobject in the second process
context that points to the same ib_x HW objects.
The second process does not own the shared context.
It just use it to get access to the shared ib_x objects and then it
mark those & shared FD as shared.

What was the expectation from "import_from_xxx" ?
