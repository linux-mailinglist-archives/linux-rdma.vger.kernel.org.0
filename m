Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48792FBD9B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 18:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbhASR24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 12:28:56 -0500
Received: from smtp.infotech.no ([82.134.31.41]:59521 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389631AbhASRKv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 12:10:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id BF9CE2041AC;
        Tue, 19 Jan 2021 18:09:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zpIfBtn7j-PD; Tue, 19 Jan 2021 18:09:33 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id B534220418D;
        Tue, 19 Jan 2021 18:09:31 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bostroesser@gmail.com, ddiss@suse.de, bvanassche@acm.org
Subject: [PATCH 0/3] scatterlist: sgl-sgl ops: copy, equal
Date:   Tue, 19 Jan 2021 12:09:25 -0500
Message-Id: <20210119170928.79805-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Scatter-gather lists (sgl_s) are frequently used as data carriers in
the block layer. For example the SCSI and NVMe subsystems interchange
data with the block layer using sgl_s. The sgl API is declared in
<linux/scatterlist.h>

The author has extended these transient sgl use cases to a store (i.e.
a ramdisk) in the scsi_debug driver. Other new potential uses of sgl_s
could be for the target subsystem. When this extra step is taken, the
need to copy between sgl_s becomes apparent. The patchset adds
sgl_copy_sgl(), sgl_equal_sgl() and sgl_memset().

Changes since v6 [posted 20210118]:
  - restarted with new patchset name, was "scatterlist: add new
    capabilities"
  - drop correction patch "sgl_alloc_order: remove 4 GiB limit,
    sgl_free() warning"; could be sent separately as a fix
  - rename sgl_compare_sgl() to sg_equal_sgl() and the helper
    to sg_equal_sgl_idx()

Changes since v5 [posted 20201228]:
  - incorporate review requests from Jason Gunthorpe
  - replace integer overflow detection code in sgl_alloc_order()
    with a pre-condition statement
  - rebase on lk 5.11.0-rc4

Changes since v4 [posted 20201105]:
  - rebase on lk 5.10.0-rc2

Changes since v3 [posted 20201019]:
  - re-instate check on integer overflow of nent calculation in
    sgl_alloc_order(). Do it in such a way as to not limit the
    overall sgl size to 4  GiB
  - introduce sgl_compare_sgl_idx() helper function that, if
    requested and if a miscompare is detected, will yield the byte
    index of the first miscompare.
  - add Reviewed-by tags from Bodo Stroesser
  - rebase on lk 5.10.0-rc2 [was on lk 5.9.0]

Changes since v2 [posted 20201018]:
  - remove unneeded lines from sgl_memset() definition.
  - change sg_zero_buffer() to call sgl_memset() as the former
    is a subset.

Changes since v1 [posted 20201016]:
  - Bodo Stroesser pointed out a problem with the nesting of
    kmap_atomic() [called via sg_miter_next()] and kunmap_atomic()
    calls [called via sg_miter_stop()] and proposed a solution that
    simplifies the previous code.

  - the new implementation of the three functions has shorter periods
    when pre-emption is disabled (but has more them). This should
    make operations on large sgl_s more pre-emption "friendly" with
    a relatively small performance hit.

  - sgl_memset return type changed from void to size_t and is the
    number of bytes actually (over)written. That number is needed
    anyway internally so may as well return it as it may be useful to
    the caller.

This patchset is against lk 5.11.0-rc4

Douglas Gilbert (3):
  scatterlist: add sgl_copy_sgl() function
  scatterlist: add sgl_equal_sgl() function
  scatterlist: add sgl_memset()

 include/linux/scatterlist.h |  32 ++++-
 lib/scatterlist.c           | 233 ++++++++++++++++++++++++++++++++----
 2 files changed, 243 insertions(+), 22 deletions(-)

-- 
2.25.1

