Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7510C209
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2019 02:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfK1B6G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 20:58:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728404AbfK1B6F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Nov 2019 20:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574906285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUPnElubbjlD82TJXHwII0/MHT1qGprga5eaeNVe8gs=;
        b=eYeBj+OG58ZV95vSxM214yqhFiLV9TtYecabBByJxv5QW8JtdzZ5l9SlZNGM1j88dzwcVD
        jCEMqNQgP9B6vvuBVrvh12QzUyT+aWIhtNyZ5XkXyDvpEqAzUT9qezLrMUVKg5ODtDBTT3
        MsrnqhS2kt5X+QNj4s1FTDxVoME9Dng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-VuG1VY16PqKZA6xGxTG0wQ-1; Wed, 27 Nov 2019 20:58:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6983F800D41;
        Thu, 28 Nov 2019 01:58:00 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E80E10018FF;
        Thu, 28 Nov 2019 01:57:52 +0000 (UTC)
Date:   Thu, 28 Nov 2019 09:57:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191128015748.GA3277@ming.t460p>
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VuG1VY16PqKZA6xGxTG0wQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

On Wed, Nov 27, 2019 at 02:38:42PM -0500, Stephen Rust wrote:
> Hi,
>=20
> We recently began testing 5.4 in preparation for migration from 4.14. One
> of our tests found reproducible data corruption in 5.x kernels. The test
> consists of a few basic single-issue writes to an iSER attached ramdisk.
> The writes are subsequently verified with single-issue reads. We tracked
> the corruption down using git bisect. The issue appears to have started i=
n
> 5.1 with the following commit:
>=20
> 3d75ca0adef4280650c6690a0c4702a74a6f3c95 block: introduce multi-page bvec
> helpers
>=20
> We wanted to bring this to your attention. A reproducer and the git bisec=
t
> data follows below.
>=20
> Our setup consists of two systems: A ramdisk exported in a LIO target fro=
m
> host A, iSCSI attached with iSER / RDMA from host B. Specific writes to t=
he

Could you explain a bit what is iSCSI attached with iSER / RDMA? Is the
actual transport TCP over RDMA? What is related target driver involved?

> very end of the attached disk on B result in incorrect data being written
> to the remote disk. The writes appear to complete successfully on the
> client. We=E2=80=99ve also verified that the correct data is being sent o=
ver the
> network by tracing the RDMA flow. For reference, the tests were conducted
> on x86_64 Intel Skylake systems with Mellanox ConnectX5 NICs.

If I understand correctly, LIO ramdisk doesn't generate any IO to block
stack, see rd_execute_rw(), and the ramdisk should be one big/long
pre-allocated sgl, see rd_build_device_space().

Seems very strange, given no bvec/bio is involved in this code
path from iscsi_target_rx_thread to rd_execute_rw. So far I have no idea
how commit 3d75ca0adef428065 causes this issue, because that patch
only changes bvec/bio related code.

>=20
> The issue appears to lie on the target host side. The initiator kernel
> version does not appear to play a role. The target host exhibits the issu=
e
> when running kernel version 5.1+.
>=20
> To reproduce, given attached sda on client host B, write data at the end =
of
> the device:
>=20
>=20
> SIZE=3D$(blockdev --getsize64 /dev/sda)
>=20
> SEEK=3D$((( $SIZE - 512 )))
>=20
> # initialize device and seed data
>=20
> dd if=3D/dev/zero of=3D/dev/sda bs=3D512 count=3D1 seek=3D$SEEK oflag=3Ds=
eek_bytes
> oflag=3Ddirect
>=20
> dd if=3D/dev/urandom of=3D/tmp/random bs=3D512 count=3D1 oflag=3Ddirect
>=20
>=20
> # write the random data (note: not direct)
>=20
> dd if=3D/tmp/random of=3D/dev/sda bs=3D512 count=3D1 seek=3D$SEEK oflag=
=3Dseek_bytes
>=20
>=20
> # verify the data was written
>=20
> dd if=3D/dev/sda of=3D/tmp/verify bs=3D512 count=3D1 skip=3D$SEEK iflag=
=3Dskip_bytes
> iflag=3Ddirect
>=20
> hexdump -xv /tmp/random > /tmp/random.hex
>=20
> hexdump -xv /tmp/verify > /tmp/verify.hex
>=20
> diff -u /tmp/random.hex /tmp/verify.hex

I just setup one LIO for exporting ramdisk(2G) via iscsi, and run the
above test via iscsi HBA, still can't reproduce the issue.

> # first bad commit: [3d75ca0adef4280650c6690a0c4702a74a6f3c95] block:
> introduce multi-page bvec helpers
>=20
>=20
> Please advise. We have cycles and systems to help track down the issue. L=
et
> me know how best to assist.

Could you install bcc and start to collect the following trace on target si=
de
before you run the above test in host side?

/usr/share/bcc/tools/stackcount -K rd_execute_rw


Thanks,
Ming

