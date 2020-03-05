Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619C417A87C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCEPEd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPEd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:33 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F7D20801;
        Thu,  5 Mar 2020 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420673;
        bh=lr8dnwfCk2Oy5AXqe/SQM5v/XztvAqWcFh3CRN0GGXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2heUR6ojYL8/anLIpvevmuFRLH/TJNUZokQt5MXonr4L6xhkwoUW7ojdLW0uJ9BR
         0Xuj6hjST/VKh0ig4/u7KOci0VgHWIu7og1Uj0P0NEHxxSL6JCJxioIcFfZS9Dg9jK
         WQwVyPwtONAXxBCnzkMrMtJToBKXwxYAiQrmZ0oI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 05/11] debian: Install all available librdmacm man pages
Date:   Thu,  5 Mar 2020 17:03:50 +0200
Message-Id: <20200305150356.208843-6-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150356.208843-1-leon@kernel.org>
References: <20200305150356.208843-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need to be explicit for every man page in librdmacm,
use simple '*' to install all rdma_*.3 man pages in one shot.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 debian/librdmacm-dev.install | 53 +-----------------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/debian/librdmacm-dev.install b/debian/librdmacm-dev.install
index e12c300a..68835cb0 100644
--- a/debian/librdmacm-dev.install
+++ b/debian/librdmacm-dev.install
@@ -6,57 +6,6 @@ usr/include/rdma/rsocket.h
 usr/lib/*/librdmacm*.so
 usr/lib/*/librdmacm.a
 usr/lib/*/pkgconfig/librdmacm.pc
-usr/share/man/man3/rdma_accept.3
-usr/share/man/man3/rdma_ack_cm_event.3
-usr/share/man/man3/rdma_bind_addr.3
-usr/share/man/man3/rdma_connect.3
-usr/share/man/man3/rdma_create_ep.3
-usr/share/man/man3/rdma_create_event_channel.3
-usr/share/man/man3/rdma_create_id.3
-usr/share/man/man3/rdma_create_qp.3
-usr/share/man/man3/rdma_create_srq.3
-usr/share/man/man3/rdma_dereg_mr.3
-usr/share/man/man3/rdma_destroy_ep.3
-usr/share/man/man3/rdma_destroy_event_channel.3
-usr/share/man/man3/rdma_destroy_id.3
-usr/share/man/man3/rdma_destroy_qp.3
-usr/share/man/man3/rdma_destroy_srq.3
-usr/share/man/man3/rdma_disconnect.3
-usr/share/man/man3/rdma_establish.3
-usr/share/man/man3/rdma_event_str.3
-usr/share/man/man3/rdma_free_devices.3
-usr/share/man/man3/rdma_get_cm_event.3
-usr/share/man/man3/rdma_get_devices.3
-usr/share/man/man3/rdma_get_dst_port.3
-usr/share/man/man3/rdma_get_local_addr.3
-usr/share/man/man3/rdma_get_peer_addr.3
-usr/share/man/man3/rdma_get_recv_comp.3
-usr/share/man/man3/rdma_get_request.3
-usr/share/man/man3/rdma_get_send_comp.3
-usr/share/man/man3/rdma_get_src_port.3
-usr/share/man/man3/rdma_getaddrinfo.3
-usr/share/man/man3/rdma_init_qp_attr.3
-usr/share/man/man3/rdma_join_multicast.3
-usr/share/man/man3/rdma_join_multicast_ex.3
-usr/share/man/man3/rdma_leave_multicast.3
-usr/share/man/man3/rdma_listen.3
-usr/share/man/man3/rdma_migrate_id.3
-usr/share/man/man3/rdma_notify.3
-usr/share/man/man3/rdma_post_read.3
-usr/share/man/man3/rdma_post_readv.3
-usr/share/man/man3/rdma_post_recv.3
-usr/share/man/man3/rdma_post_recvv.3
-usr/share/man/man3/rdma_post_send.3
-usr/share/man/man3/rdma_post_sendv.3
-usr/share/man/man3/rdma_post_ud_send.3
-usr/share/man/man3/rdma_post_write.3
-usr/share/man/man3/rdma_post_writev.3
-usr/share/man/man3/rdma_reg_msgs.3
-usr/share/man/man3/rdma_reg_read.3
-usr/share/man/man3/rdma_reg_write.3
-usr/share/man/man3/rdma_reject.3
-usr/share/man/man3/rdma_resolve_addr.3
-usr/share/man/man3/rdma_resolve_route.3
-usr/share/man/man3/rdma_set_option.3
+usr/share/man/man3/rdma_*.3
 usr/share/man/man7/rdma_cm.7
 usr/share/man/man7/rsocket.7
--
2.24.1

