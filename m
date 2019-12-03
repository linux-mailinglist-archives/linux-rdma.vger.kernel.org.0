Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38D10FDF4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 13:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCMqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Dec 2019 07:46:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbfLCMqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Dec 2019 07:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575377193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bY3tu33uM0AN7ABx5DnYQhbsOL7dFeYwJWHS5k7Rwgc=;
        b=UTOT7yWbaHQ44XHKI1W33R275sCstLYRRsALy1GzLipI8g5stfbwBWZ7T8Ybokqk7Kl2Iz
        V2MUnGe32wFVtrU6KUzdUK/c68TeuCSROgA3w1lkUcW8sg0J4amQoEClf5d9+Vlxq1AcpN
        +9eOSWwm/oX5YKXYemPTEA0tzBbhEHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-ThT0QIs4MXqG05REW0bKFA-1; Tue, 03 Dec 2019 07:46:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53CB9800EB8;
        Tue,  3 Dec 2019 12:46:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-36.pek2.redhat.com [10.72.8.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39AFA19C68;
        Tue,  3 Dec 2019 12:46:08 +0000 (UTC)
Date:   Tue, 3 Dec 2019 20:45:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191203124558.GA22805@ming.t460p>
References: <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p>
 <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p>
 <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
 <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
 <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ThT0QIs4MXqG05REW0bKFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 02, 2019 at 10:50:32PM -0500, Stephen Rust wrote:
> Hi,
>=20
> Another datapoint.
>=20
> I enabled "isert_debug" tracing and re-ran the test. Here is a small
> snippet of the debug data. FWIW, the "length of 76" in the "lkey
> mismatch" is a pattern that repeats quite often during the exchange.

That is because ISER_HEADERS_LEN is 76.

From our trace, 76 is bvec->bv_offset, is it possible that IO buffer
just follows the ISER HEADER suppose that iser applies zero-copy?

BTW, you may try the attached test patch. If the issue can be fixed by
this patch, that means it is really caused by un-aligned buffer, and
the iser driver needs to be fixed.

From 0368ee8a756384116fa1d0415f51389d438a6e40 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 3 Dec 2019 20:00:53 +0800
Subject: [PATCH] brd: handle un-aligned bvec->bv_len

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/brd.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c548a5a6c1a0..9ea1894c820d 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -190,13 +190,15 @@ static int copy_to_brd_setup(struct brd_device *brd, =
sector_t sector, size_t n)
  * Copy n bytes from src to the brd starting at sector. Does not sleep.
  */
 static void copy_to_brd(struct brd_device *brd, const void *src,
-=09=09=09sector_t sector, size_t n)
+=09=09=09sector_t sector, unsigned off_in_sec, size_t n)
 {
 =09struct page *page;
 =09void *dst;
 =09unsigned int offset =3D (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 =09size_t copy;
=20
+=09offset +=3D off_in_sec;
+
 =09copy =3D min_t(size_t, n, PAGE_SIZE - offset);
 =09page =3D brd_lookup_page(brd, sector);
 =09BUG_ON(!page);
@@ -207,7 +209,7 @@ static void copy_to_brd(struct brd_device *brd, const v=
oid *src,
=20
 =09if (copy < n) {
 =09=09src +=3D copy;
-=09=09sector +=3D copy >> SECTOR_SHIFT;
+=09=09sector +=3D (copy + off_in_sec) >> SECTOR_SHIFT;
 =09=09copy =3D n - copy;
 =09=09page =3D brd_lookup_page(brd, sector);
 =09=09BUG_ON(!page);
@@ -222,13 +224,15 @@ static void copy_to_brd(struct brd_device *brd, const=
 void *src,
  * Copy n bytes to dst from the brd starting at sector. Does not sleep.
  */
 static void copy_from_brd(void *dst, struct brd_device *brd,
-=09=09=09sector_t sector, size_t n)
+=09=09=09sector_t sector, unsigned off_in_sec, size_t n)
 {
 =09struct page *page;
 =09void *src;
 =09unsigned int offset =3D (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 =09size_t copy;
=20
+=09offset +=3D off_in_sec;
+
 =09copy =3D min_t(size_t, n, PAGE_SIZE - offset);
 =09page =3D brd_lookup_page(brd, sector);
 =09if (page) {
@@ -240,7 +244,7 @@ static void copy_from_brd(void *dst, struct brd_device =
*brd,
=20
 =09if (copy < n) {
 =09=09dst +=3D copy;
-=09=09sector +=3D copy >> SECTOR_SHIFT;
+=09=09sector +=3D (copy + off_in_sec) >> SECTOR_SHIFT;
 =09=09copy =3D n - copy;
 =09=09page =3D brd_lookup_page(brd, sector);
 =09=09if (page) {
@@ -257,7 +261,7 @@ static void copy_from_brd(void *dst, struct brd_device =
*brd,
  */
 static int brd_do_bvec(struct brd_device *brd, struct page *page,
 =09=09=09unsigned int len, unsigned int off, unsigned int op,
-=09=09=09sector_t sector)
+=09=09=09sector_t sector, unsigned int off_in_sec)
 {
 =09void *mem;
 =09int err =3D 0;
@@ -270,11 +274,11 @@ static int brd_do_bvec(struct brd_device *brd, struct=
 page *page,
=20
 =09mem =3D kmap_atomic(page);
 =09if (!op_is_write(op)) {
-=09=09copy_from_brd(mem + off, brd, sector, len);
+=09=09copy_from_brd(mem + off, brd, sector, off_in_sec, len);
 =09=09flush_dcache_page(page);
 =09} else {
 =09=09flush_dcache_page(page);
-=09=09copy_to_brd(brd, mem + off, sector, len);
+=09=09copy_to_brd(brd, mem + off, sector, off_in_sec, len);
 =09}
 =09kunmap_atomic(mem);
=20
@@ -287,6 +291,7 @@ static blk_qc_t brd_make_request(struct request_queue *=
q, struct bio *bio)
 =09struct brd_device *brd =3D bio->bi_disk->private_data;
 =09struct bio_vec bvec;
 =09sector_t sector;
+=09unsigned offset_in_sec =3D 0;
 =09struct bvec_iter iter;
=20
 =09sector =3D bio->bi_iter.bi_sector;
@@ -296,12 +301,14 @@ static blk_qc_t brd_make_request(struct request_queue=
 *q, struct bio *bio)
 =09bio_for_each_segment(bvec, bio, iter) {
 =09=09unsigned int len =3D bvec.bv_len;
 =09=09int err;
+=09=09unsigned int secs =3D len >> SECTOR_SHIFT;
=20
 =09=09err =3D brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-=09=09=09=09  bio_op(bio), sector);
+=09=09=09=09  bio_op(bio), sector, offset_in_sec);
 =09=09if (err)
 =09=09=09goto io_error;
-=09=09sector +=3D len >> SECTOR_SHIFT;
+=09=09sector +=3D secs;
+=09=09offset_in_sec =3D len - (secs << SECTOR_SHIFT);
 =09}
=20
 =09bio_endio(bio);
@@ -319,7 +326,7 @@ static int brd_rw_page(struct block_device *bdev, secto=
r_t sector,
=20
 =09if (PageTransHuge(page))
 =09=09return -ENOTSUPP;
-=09err =3D brd_do_bvec(brd, page, PAGE_SIZE, 0, op, sector);
+=09err =3D brd_do_bvec(brd, page, PAGE_SIZE, 0, op, sector, 0);
 =09page_endio(page, op_is_write(op), err);
 =09return err;
 }
--=20
2.20.1


Thanks,
Ming

