Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D01120DC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2019 02:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLDBFz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Dec 2019 20:05:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26087 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbfLDBFz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Dec 2019 20:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575421554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mb2uA8H8LkeFlI3MZDn+f+z590eg/6oojJfUikjRY5I=;
        b=iEN/Izj3DsrL34qziqj7Fgw+OA0WcimyH4s8NkYWnFHhMoJfhydTZst7Zk8sjD23eIizw+
        waMrwvRk1uoh5VyHC6EWGsbSy7T5lWLS5CyzbgJgHw6usNa6pmeH98/qLsxD9nkg7ychdw
        N58rP4SeaFp7yMzSfUcR1mVUVYFUcMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-oxdtObirPLa0FlLmaJrW7g-1; Tue, 03 Dec 2019 20:05:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD3218557C2;
        Wed,  4 Dec 2019 01:05:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EEEF100194E;
        Wed,  4 Dec 2019 01:05:34 +0000 (UTC)
Date:   Wed, 4 Dec 2019 09:05:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191204010529.GA3910@ming.t460p>
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
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: oxdtObirPLa0FlLmaJrW7g-1
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
> ...
> [snip]
>=20
> What do you think are appropriate next steps?

OK, my guess should be correct, and the issue is related with un-aligned
bvec->bv_offset.

So firstly, I'd suggest to investigate from RDMA driver side to see why
un-aligned buffer is passed to block layer.

According to previous discussion, 512 aligned buffer should be provided
to block layer.

So looks the driver needs to be fixed.

> Do you think you have an
> idea on why the specific "multi-page bvec helpers" commit could have
> exposed this particular latent issue? Please let me know what else I
> can try, or additional data I can provide for you.
=20
The patch might not cover the big offset case, could you collect bpftrace
via the following script when you reproduce the issue with >4096 offset?

kprobe:iblock_execute_rw
{
    @start[tid]=3D1;
}

kretprobe:iblock_execute_rw
{
    @start[tid]=3D0;
}

kprobe:bio_add_page
/@start[tid]/
{
  printf("%d %d\n", arg2, arg3);
}

kprobe:brd_do_bvec
{
  printf("%d %d %d %d\n", arg2, arg3, arg4, arg5);
}


Thanks,
Ming

