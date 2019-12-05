Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B91113A35
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 04:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfLEDGB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Dec 2019 22:06:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54801 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbfLEDGB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Dec 2019 22:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575515159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7traVAkb9g+hYIUDmY3MF1gcTO+isie3n+oid7Vyh2g=;
        b=fKcjMCKAfYM16ynj6Qf7nJQy3JxppgayOZpIb7nXyo5GqpALEdp/qfoeRHDSqQIDcGHivD
        2qvT7qaW2ZKLQzmJMsqeK/dikd/FwTTW5A7AV3l9l/MPfGo+6UQajdEAh1VQH7CxQKZ/4F
        KsydaQbUT7YAB/2Uxyef957Ywh9Flkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-XIxIl1EdP36hstZshMCG5A-1; Wed, 04 Dec 2019 22:05:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E07A80459C;
        Thu,  5 Dec 2019 03:05:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 953E85D9C5;
        Thu,  5 Dec 2019 03:05:45 +0000 (UTC)
Date:   Thu, 5 Dec 2019 11:05:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191205030540.GA20684@ming.t460p>
References: <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
 <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p>
 <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p>
 <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p>
 <CAAFE1bcwcdVuzAG5+x1UNcTaa22bf0tOaT=QOWrTup98sFXxuQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1bcwcdVuzAG5+x1UNcTaa22bf0tOaT=QOWrTup98sFXxuQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: XIxIl1EdP36hstZshMCG5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 04, 2019 at 09:28:43PM -0500, Stephen Rust wrote:
> Hi Ming,
>=20
> Thanks for all your help and insight. I really appreciate it.
>=20
> > > Presumably non-brd devices, ie: real scsi devices work for these test
> > > cases because they accept un-aligned buffers?
> >
> > Right, not every driver supports such un-aligned buffer.
>=20
> Can you please clarify: does the block layer require that it is called
> with 512-byte aligned buffers? If that is the case, would it make
> sense for the block interface (bio_add_page() or other) to reject
> buffers that are not aligned?

The things is a bit complicated, see the following xfs commits:

f8f9ee479439 xfs: add kmem_alloc_io()
d916275aa4dd xfs: get allocation alignment from the buftarg

Which applies request queue's dma alignment limit which may be
smaller than 512. Before this report, xfs should be the only known
user of passing un-aligned buffer.

So we can't add the check in bio_add_page(), in which request queue
may not be available, also bio_add_page() is really hot path, and
people hates to add unnecessary code in this function.

IMO, it is better for all FS or users of bio_add_page() to pass
512 aligned buffer.

>=20
> It seems that passing these buffers on to underlying drivers that
> don't support un-aligned buffers can result in silent data corruption.
> Perhaps it would be better to fail the I/O up front. This would also
> help future proof the block interface when changes/new target drivers
> are added.

It is a brd device, strictly speaking, it doesn't matter to fail the
I/O or whatever, given either way should cause data loss.

>=20
> I'm also curious how these same unaligned buffers from iSER made it to
> brd and were written successfully in the pre "multi-page bvec" world.
> (Just trying to understand, if you have any thoughts, as this same
> test case worked fine in 4.14+ until 5.1)

I am pretty sure that brd never supports un-aligned buffer, and I have
no idea why 'multi-page bvec' helper can cause this issue. However, I
am happy to investigate further if you can run previous trace on pre
'multi-page bvec' kernel.

>=20
> > I am not familiar with RDMA, but from the trace we have done so far,
> > it is highly related with iser driver.
>=20
> Do you think it is fair to say that the iSER/block integration is
> causing corruption by using un-aligned buffers?

As you saw, XFS changed the un-aligned buffer into aligned one for
avoiding the issue, so I think it is pretty fair to say that.

Thanks,=20
Ming

