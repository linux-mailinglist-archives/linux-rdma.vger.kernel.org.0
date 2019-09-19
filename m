Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE2B734D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 08:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfISGlA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 02:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfISGlA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Sep 2019 02:41:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F71487630;
        Thu, 19 Sep 2019 06:41:00 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C45760872;
        Thu, 19 Sep 2019 06:40:58 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [rdma-core patch] srp_daemon: fix a double free segment fault for ibsrpdm
Date:   Thu, 19 Sep 2019 14:40:45 +0800
Message-Id: <20190919064045.23193-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 19 Sep 2019 06:41:00 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

Command: ./ibsrpdm -d /dev/infiniband/umadX

Invalid free() / delete / delete[] / realloc()
   at 0x4C320DC: free (vg_replace_malloc.c:540)
   by 0x403BBB: free_config (srp_daemon.c:1811)
   by 0x4031BE: ibsrpdm (srp_daemon.c:2113)
   by 0x4031BE: main (srp_daemon.c:2153)
 Address 0x5ee5fd0 is 0 bytes inside a block of size 16 free'd
   at 0x4C320DC: free (vg_replace_malloc.c:540)
   by 0x404851: translate_umad_to_ibdev_and_port (srp_daemon.c:729)
   by 0x404851: set_conf_dev_and_port (srp_daemon.c:1586)
   by 0x403171: ibsrpdm (srp_daemon.c:2092)
   by 0x403171: main (srp_daemon.c:2153)
 Block was alloc'd at
   at 0x4C30EDB: malloc (vg_replace_malloc.c:309)
   by 0x40478D: translate_umad_to_ibdev_and_port (srp_daemon.c:698)
   by 0x40478D: set_conf_dev_and_port (srp_daemon.c:1586)
   by 0x403171: ibsrpdm (srp_daemon.c:2092)
   by 0x403171: main (srp_daemon.c:2153)

Signed-off-by: Honggang Li <honli@redhat.com>
---
 srp_daemon/srp_daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index 337b21c7..f0bcf923 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -727,6 +727,7 @@ end:
 	if (ret) {
 		free(*ibport);
 		free(*ibdev);
+		*ibdev = NULL;
 	}
 	free(class_dev_path);
 
-- 
2.21.0

