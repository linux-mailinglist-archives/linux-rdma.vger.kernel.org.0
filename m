Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0B11217F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2019 03:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDCkA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Dec 2019 21:40:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbfLDCkA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Dec 2019 21:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575427199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUNcibfkDj9cICd3L3313R4P5SZt0kUgexQ7UYbZQvw=;
        b=eJ6yMl5YXoveElD3aSR0Pnld+fedmrUFcjnlNpqzKmOCQdF4229NhtsOAfpVMlT0+ooqIF
        4HDunz6/0jvA9DyabHyzwn0rm4hlBYZ2Ix0Odvyf2cj1Glvh3P8kKe8UUQ2+J6Lro4fGzf
        NijyYtGAZjjH1d+2vd4xN7AexSka5iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-eal7FyFpPpS8Ce4pW7mcwg-1; Tue, 03 Dec 2019 21:39:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3DFA10054E3;
        Wed,  4 Dec 2019 02:39:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBA6C5D6AE;
        Wed,  4 Dec 2019 02:39:44 +0000 (UTC)
Date:   Wed, 4 Dec 2019 10:39:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191204023939.GD3910@ming.t460p>
References: <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p>
 <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
 <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
 <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p>
 <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eal7FyFpPpS8Ce4pW7mcwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 03, 2019 at 02:56:08PM -0500, Stephen Rust wrote:
> Hi Ming,
>=20
> Thanks very much for the patch.
>=20
> > BTW, you may try the attached test patch. If the issue can be fixed by
> > this patch, that means it is really caused by un-aligned buffer, and
> > the iser driver needs to be fixed.
>=20
> I have tried the patch, and re-run the test. Results are mixed.
>=20
> To recap, our test writes the last bytes of an iser attached iscsi
> device. The target device is a LIO iblock, backed by a brd ramdisk.
> The client does a simple `dd`, doing a seek to "size - offset" of the
> device, and writing a buffer of "length" which is equivalent to the
> offset.
>=20
> For example, to test a write at a 512 offset, seek to device "size -
> 512", and write a length of data 512 bytes.
>=20
> WITHOUT the patch, writing data at the following offsets from the end
> of the device failed to write all the correct data (rather, the write
> succeeded, but reading the data back it was invalid):
>=20
> - failed: 512,1024, 2048, 4096, 8192
>=20
> Anything larger worked fine.
>=20
> WITH the patch applied, writing data up to an offset of 4096 all now
> worked and verified correctly. However, offsets between 4096 and 8192
> all still failed. I started at 512, and incremented by 512 all the way
> up to 16384. The following offsets all failed to verify the write:
>=20
> - failed: 4608, 5120, 5632, 6144, 6656, 7168, 7680, 8192
>=20
> Anything larger continues to work fine with the patch.
>=20
> As an example, for the failed 8192 case, the `bpftrace lio.bt` trace show=
s:
>=20
> 8192 76
> 4096 0
> 4096 0
> 8192 76
> 4096 0
> 4096 0

The following delta change against last patch should fix the issue
with >4096 bvec length:

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 9ea1894c820d..49e37a7dda63 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -308,7 +308,7 @@ static blk_qc_t brd_make_request(struct request_queue *=
q, struct bio *bio)
                if (err)
                        goto io_error;
                sector +=3D secs;
-               offset_in_sec =3D len - (secs << SECTOR_SHIFT);
+               offset_in_sec +=3D len - (secs << SECTOR_SHIFT);
        }

        bio_endio(bio);

However, the change on brd is a workaround just for confirming the
issue.


Thanks,=20
Ming

