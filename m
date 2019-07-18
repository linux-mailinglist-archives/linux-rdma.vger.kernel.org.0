Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3484A6CDED
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRMQQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jul 2019 08:16:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42959 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMQQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jul 2019 08:16:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so26856127qtm.9
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jul 2019 05:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3J3MRmHmnv8k8+kmMeTh8muNGIQlmefFOA4kZv7Gu5A=;
        b=Uh2uLgw2En/h60LbWt6F/7IU/rMARug7ZvEfqRxTmKL6YyJ92Dsst9hJDwkwjBjVCA
         ov2f/o+/sRpW5iC6D4BCYxkpiU3WmowkionHlImkUqf38juRLejTv1LBoqW22bOhl8G9
         BQb3MHWq+Zogra7BfoV+7rpxJ0ddbleJQ/chdytY3QtfzgIaVkaEES6pE695TSMVGUrP
         rj5yKr69wuE3dqU8uSK+dpcUSjoYb2Re3ftvYRJcTPe6QO/JZ90wy0rRYoFyEl9+eKeF
         7Wd6Q/KTtNKJWyOMIlTziNQhd2oonzh2vjsli2ATxYPxQhIes7wHj4iPWgpAHuGH63s6
         2n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3J3MRmHmnv8k8+kmMeTh8muNGIQlmefFOA4kZv7Gu5A=;
        b=Puv3xLv5gM/5Gf2UK4AbjLpK7NL9j7Dz+3w6mi+ZQvY7tBPc6ba+cGqIon2mvkDdxs
         TU1P9YU/jP4IaPwQgb7iNaeqw0iP9DpFK31jh00QXCF0nSiOHHA8BDvf8GWk7mYV7h2W
         lb+EUl1BeGPdfr7QOYXzIpftRu5hPfjdbsj+OP2xn0gjz+aGaWT6jM72OU4xgx/bgC8A
         MNeuXZyVSaL9MIHTCgshzaawyGFlVJdn32+cnUvNN4UvMnQRm7LCz/n0rDMOxpjJsspo
         Cnn7EI9c/sJUIM20LlFQjMoEAVHwhLYRXd/+3jyPEqGQVqZvB/r/bXGB0Ku/LIIoVQr2
         iBWA==
X-Gm-Message-State: APjAAAVwAHEbwrmmqaLzI6UQMtnIo+ytKSMQQVVoX/GAalYloVjwVh4V
        Zgm0KXK0yBvxisWHWr8/ClmN6A==
X-Google-Smtp-Source: APXvYqwYo65EZoMV0waPGFUtY95zhNnk3DFsOTwAclRYrqwqxp8kFVkvrj5t5JWZgn07/5dl0EOUsA==
X-Received: by 2002:ac8:7555:: with SMTP id b21mr31113909qtr.292.1563452175348;
        Thu, 18 Jul 2019 05:16:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w9sm11928383qts.25.2019.07.18.05.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 05:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ho5KY-0000To-24; Thu, 18 Jul 2019 09:16:14 -0300
Date:   Thu, 18 Jul 2019 09:16:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
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
Subject: Re: [PATCH 00/25] Shared PD and MR
Message-ID: <20190718121614.GA1667@ziepe.ca>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190717050931.GA18936@infradead.org>
 <CA+KVoo7oSdpX2j1hRT1gPFFrxkHLBfcxXh4HaxkjjNKD550sYg@mail.gmail.com>
 <20190717115507.GD12119@ziepe.ca>
 <CA+KVoo5wVzUovQvAXyZzsA8rK9=FuMEkNJDDwJteXe9-eLFu3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KVoo5wVzUovQvAXyZzsA8rK9=FuMEkNJDDwJteXe9-eLFu3A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 04:35:30PM +0300, Shamir Rabinovitch wrote:
> On Wed, Jul 17, 2019 at 2:55 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jul 17, 2019 at 02:09:50PM +0300, Shamir Rabinovitch wrote:
> > > On Wed, Jul 17, 2019 at 8:09 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Tue, Jul 16, 2019 at 09:11:35PM +0300, Shamir Rabinovitch wrote:
> > > > > Following patch-set introduce the shared object feature.
> > > > >
> > > > > A shared object feature allows one process to create HW objects (currently
> > > > > PD and MR) so that a second process can import.
> > > >
> > > > That sounds like a major complication, so you'd better also explain
> > > > the use case very well.
> > >
> > > The main use case was that there is a server that has giant shared
> > > memory that is shared across many processes (lots of mtts).
> > > Each process needs the same memory registration (lots of mrs that
> > > register same memory).
> > > In such scenario, the HCA runs out of mtts.
> > > To solve this problem, an single memory registration is shared across
> > > all the process in that server saving hca mtts.
> >
> > Well, why not just share the entire uverbs FD then? Once the PD is
> > shared all security is lost anyhow..
> >
> > This is not the model that was explained to me last year
> >
> > Jason
> 
> We do share the whole uvrbs FD (context) with the second process and
> let that process to instantiate the PD & MR from the shared FD.
> The instantiation include creating new uobject in the second process
> context that points to the same ib_x HW objects.
> The second process does not own the shared context.
> It just use it to get access to the shared ib_x objects and then it
> mark those & shared FD as shared.
> 
> What was the expectation from "import_from_xxx" ?

None of this discussion makes any sense to me, or matches the use
model that I thought this was targetting

Jason
