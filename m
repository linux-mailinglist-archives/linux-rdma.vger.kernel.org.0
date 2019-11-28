Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E010C5BB
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2019 10:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfK1JMb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Nov 2019 04:12:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57445 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbfK1JMa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Nov 2019 04:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574932349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93nTBfXZSHlR8+dS6GNm1bAKHx8uhAYoz9B1bYNCDvo=;
        b=C6qAKSkuwRCnct1FekBqh2V4g1MfLksmOJFS7EmBjXWY1pB/BkEF0gBe9OYOYxGsiWHDuW
        V1xRMz0cCJWhV78YC77VaRCdcB8L8mjSfpCw0NJVPdF2BKndKyD2afwB0crxq5WP66ln4w
        sLlSBmj5TsZWWxLYAbH0EweLz6G7piY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-rBL7dYfcNgmQmzjigss6Gg-1; Thu, 28 Nov 2019 04:12:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E65B593A0;
        Thu, 28 Nov 2019 09:12:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 499746084E;
        Thu, 28 Nov 2019 09:12:15 +0000 (UTC)
Date:   Thu, 28 Nov 2019 17:12:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191128091210.GC15549@ming.t460p>
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p>
 <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p>
 <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: rBL7dYfcNgmQmzjigss6Gg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 27, 2019 at 11:14:46PM -0500, Stephen Rust wrote:
> Hi,
>=20
> Thanks for your reply.
>=20
> I agree it does seem surprising that the git bisect pointed to this
> particular commit when tracking down this issue.
>=20
> The ramdisk we export in LIO is a standard "brd" module ramdisk (ie:
> /dev/ram*). We configure it as a "block" backstore in LIO, not using the
> built-in LIO ramdisk.

Then it isn't strange any more, since iblock code uses bio interface.

>=20
> LIO configuration is as follows:
>=20
>   o- backstores .........................................................=
.
> [...]
>   | o- block .............................................. [Storage
> Objects: 1]
>   | | o- Blockbridge-952f0334-2535-5fae-9581-6c6524165067
>  [/dev/ram-bb.952f0334-2535-5fae-9581-6c6524165067.cm2 (16.0MiB) write-th=
ru
> activated]
>   | |   o- alua ............................................... [ALUA
> Groups: 1]
>   | |     o- default_tg_pt_gp ................... [ALUA state:
> Active/optimized]
>   | o- fileio ............................................. [Storage
> Objects: 0]
>   | o- pscsi .............................................. [Storage
> Objects: 0]
>   | o- ramdisk ............................................ [Storage
> Objects: 0]
>   o- iscsi ........................................................
> [Targets: 1]
>   | o-
> iqn.2009-12.com.blockbridge:rda:1:952f0334-2535-5fae-9581-6c6524165067:rd=
a
>  [TPGs: 1]
>   |   o- tpg1 ...................................... [no-gen-acls, auth
> per-acl]
>   |     o- acls ......................................................
> [ACLs: 1]
>   |     | o- iqn.1994-05.com.redhat:115ecc56a5c .. [mutual auth, Mapped
> LUNs: 1]
>   |     |   o- mapped_lun0  [lun0
> block/Blockbridge-952f0334-2535-5fae-9581-6c6524165067 (rw)]
>   |     o- luns ......................................................
> [LUNs: 1]
>   |     | o- lun0  [block/Blockbridge-952f0334-2535-5fae-9581-6c652416506=
7
> (/dev/ram-bb.952f0334-2535-5fae-9581-6c6524165067.cm2) (default_tg_pt_gp)=
]
>   |     o- portals ................................................
> [Portals: 1]
>   |       o- 0.0.0.0:3260 ...............................................
> [iser]
>=20
>=20
> iSER is the iSCSI extension for RDMA, and it is important to note that we
> have _only_ reproduced this when the writes occur over RDMA, with the
> target portal in LIO having enabled "iser". The iscsi client (using
> iscsiadm) connects to the target directly over iSER. We use the Mellanox
> ConnectX-5 Ethernet NICs (mlx5* module) for this purpose, which utilizes
> RoCE (RDMA over Converged Ethernet) instead of TCP.

I may get one machine with Mellanox NIC, is it easy to setup & reproduce
just in the local machine(both host and target are setup on same machine)?

>=20
> The identical ramdisk configuration using TCP/IP target in LIO has _not_
> reproduced this issue for us.

Yeah, I just tried iblock over brd, and can't reproduce it.

>=20
> I installed bcc and used the stackcount tool to trace rd_execute_rw, but =
I
> suspect because we are not using the built-in LIO ramdisk this did not
> catch anything. Are there other function traces we can provide for you?

Please try to trace bio_add_page() a bit via 'bpftrace ./ilo.bt'.

[root@ktest-01 func]# cat ilo.bt
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



Thanks,=20
Ming

