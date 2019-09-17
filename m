Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AC9B51B7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 17:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfIQPmH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 11:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbfIQPmH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Sep 2019 11:42:07 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CB52171F;
        Tue, 17 Sep 2019 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568734926;
        bh=Cs9d1NkB4qUoDkwuZrTgkp77GLRkyvP7Xqf3CmGIlKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niTsgqzBynMTMZ7IJhyt0HpXRowaAMQxofie64ypEQI5fNX5hLevcX664d2xTgcQa
         MH8w8RndhWSoUa7pBrkUMYdyiua6yGiphKlLZk4rKB1Uo1SsaxqpwxmhhT4VcxGKZD
         v26Q9NJYrgFU7dVJOVwfaowWmsRnzZxmUkKrKtw0=
Date:   Tue, 17 Sep 2019 18:41:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
Message-ID: <20190917154150.GE18203@unreal>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org>
 <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
 <20190916052729.GB18203@unreal>
 <25bd79e1-9523-8354-873a-0ff1db92659a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25bd79e1-9523-8354-873a-0ff1db92659a@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 06:45:17AM -0700, Bart Van Assche wrote:
> On 9/15/19 10:27 PM, Leon Romanovsky wrote:
> > On Sun, Sep 15, 2019 at 04:30:04PM +0200, Jinpu Wang wrote:
> > > On Sat, Sep 14, 2019 at 12:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > > > +/* TODO: should be configurable */
> > > > > +#define IBTRS_PORT 1234
> > > >
> > > > How about converting this macro into a kernel module parameter?
> > > Sounds good, will do.
> >
> > Don't rush to do it and defer it to be the last change before merging,
> > this is controversial request which not everyone will like here.
>
> Hi Leon,
>
> If you do not agree with changing this macro into a kernel module parameter
> please suggest an alternative.

I didn't review code so my answer can be not fully accurate, but opening
some port to use this IB* seems strange from my non-sysadmin POV.
What about using RDMA-CM, like NVMe?

Thanks

>
> Thanks,
>
> Bart.
