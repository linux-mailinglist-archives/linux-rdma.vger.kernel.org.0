Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05671E92F2
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2020 19:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgE3RxC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 May 2020 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE3RxB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 May 2020 13:53:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE9EC03E969
        for <linux-rdma@vger.kernel.org>; Sat, 30 May 2020 10:53:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so2779296ioo.4
        for <linux-rdma@vger.kernel.org>; Sat, 30 May 2020 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HS1GS0uW0iGDBC7nG4kU9MwPkGFshmW2ZF2bwWJbTj0=;
        b=m8EBLRYz6x2JufsEVyHs2+/sZebtROmecrXI6iX9b3rg6LNZu1DLFS3klM44D6Kly2
         /TBvN6OZMd1A887AKTGjr9Wp34i/snlywk15EChZfA7jV8X7T5qTze7dotW6RveOQuwV
         CwPPJ2Oz+8wIcIbDMekq3CkwJCzE1ZmJHfQGf92HGfbH3c2adhS27R0IYGp9qeQ/xknn
         6uCs45dGr9j6+T3zwFlZwson4sGok/eT0FJNQ9xdzPLr/1/J5LLVT52OfcYbhLgl6oQt
         2pAKSLXfCVcyUJJrHzFspIZT1u6qgXUWiGo206isiFlVYXFIVlffi0QYEhoWlL/t1FU8
         obuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HS1GS0uW0iGDBC7nG4kU9MwPkGFshmW2ZF2bwWJbTj0=;
        b=IBgKvqA1k7oh31a7ND4kKWpXfnqUbjCS1FypJIgNxi+OGnzwx0ehCVhqFt2ZqD4psh
         G/vlAEI6Ec79WBhMyEmP1ZE/FXVKA1ZRUZM8iHBdbUG71z5v/I5jE7chGMB8iNJzrIDb
         Gi+O2tLWyFe5zfiZZSoYUoA0+qmbXIwaYhBGkpwQXKfXGGgrqynthbEYdgiIfNvI0J5Q
         Q8I8poZtV4dZ/GuZsk0UBsFNCXBoWIokb9N/BoncPwsQf+YZxAAAMpBCATjw194Oru7b
         Yuut7OLvLAYLOUk5wqvULCb+d2oe1U+wKX0DUruQPEQsXEA00EKKkgmTZJGV8XjH5050
         Qixg==
X-Gm-Message-State: AOAM531r/kb0Yx3l9rlXdwBs+OH3KcheKMq9D1ozuBnYf3s8Ct+3zNpc
        FoYB7XbN22p73ddF0Ivll5TQKviv
X-Google-Smtp-Source: ABdhPJz1PRO51OYk7Kp7rLZBtxAKzjZIH3sFwB29PcK25NayVa0z25PVz4f9WhvGH6+k706EKR87wQ==
X-Received: by 2002:a02:245:: with SMTP id 66mr13460612jau.69.1590861180736;
        Sat, 30 May 2020 10:53:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g15sm1038970ilr.5.2020.05.30.10.52.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 10:53:00 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UHqwBO002218
        for <linux-rdma@vger.kernel.org>; Sat, 30 May 2020 17:52:59 GMT
Subject: [PATCH v2] RDMA/core: Move and rename trace_cm_id_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 13:52:58 -0400
Message-ID: <20200530174934.21362.56754.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The restrack ID for an rdma_cm_id is not assigned until it is
associated with a device.

Here's an example I captured while testing NFS/RDMA's support for
DEVICE_REMOVAL. The new tracepoint name is "cm_id_attach".

           <...>-4261  [001]   366.581299: cm_event_handler:     cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0 ADDR_ERROR (1/-19)
           <...>-4261  [001]   366.581304: cm_event_done:        cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0 ADDR_ERROR consumer returns 0
           <...>-1950  [000]   366.581309: cm_id_destroy:        cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0
           <...>-7     [001]   369.589400: cm_event_handler:     cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0 ADDR_ERROR (1/-19)
           <...>-7     [001]   369.589404: cm_event_done:        cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0 ADDR_ERROR consumer returns 0
           <...>-1950  [000]   369.589407: cm_id_destroy:        cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0
           <...>-4261  [001]   372.597650: cm_id_attach:         cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 device=mlx4_0
           <...>-4261  [001]   372.597652: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ADDR_RESOLVED (0/0)
           <...>-4261  [001]   372.597654: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ADDR_RESOLVED consumer returns 0
           <...>-4261  [001]   372.597738: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ROUTE_RESOLVED (2/0)
           <...>-4261  [001]   372.597740: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ROUTE_RESOLVED consumer returns 0
           <...>-4691  [007]   372.600101: cm_qp_create:         cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 pd.id=2 qp_type=RC send_wr=4091 recv_wr=256 qp_num=530 rc=0
           <...>-4691  [007]   372.600207: cm_send_req:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 qp_num=530
           <...>-185   [002]   372.601212: cm_send_mra:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0
           <...>-185   [002]   372.601362: cm_send_rtu:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0
           <...>-185   [002]   372.601372: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ESTABLISHED (9/0)
           <...>-185   [002]   372.601379: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ESTABLISHED consumer returns 0

Fixes: ed999f820a6c ("RDMA/cma: Add trace points in RDMA Connection Manager")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma.c       |    2 +-
 drivers/infiniband/core/cma_trace.h |   20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

Changes since v1:
* Select a better name than "cm_id_resolve"
* Capture more information about the new ID, including the name of
  the attached underlying device
* As Leon has requested in the past, include sample capture output
  in the patch description

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 26e6f7df247b..7b24874b090a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -479,6 +479,7 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 		rdma_restrack_kadd(&id_priv->res);
 	else
 		rdma_restrack_uadd(&id_priv->res);
+	trace_cm_id_attach(id_priv, cma_dev->device);
 }
 
 static void cma_attach_to_dev(struct rdma_id_private *id_priv,
@@ -883,7 +884,6 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
 
-	trace_cm_id_create(id_priv);
 	return &id_priv->id;
 }
 EXPORT_SYMBOL(__rdma_create_id);
diff --git a/drivers/infiniband/core/cma_trace.h b/drivers/infiniband/core/cma_trace.h
index 81e36bf13159..e6e20c36c538 100644
--- a/drivers/infiniband/core/cma_trace.h
+++ b/drivers/infiniband/core/cma_trace.h
@@ -103,23 +103,33 @@
 DEFINE_CMA_FSM_EVENT(sent_dreq);
 DEFINE_CMA_FSM_EVENT(id_destroy);
 
-TRACE_EVENT(cm_id_create,
+TRACE_EVENT(cm_id_attach,
 	TP_PROTO(
-		const struct rdma_id_private *id_priv
+		const struct rdma_id_private *id_priv,
+		const struct ib_device *device
 	),
 
-	TP_ARGS(id_priv),
+	TP_ARGS(id_priv, device),
 
 	TP_STRUCT__entry(
 		__field(u32, cm_id)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+		__string(devname, device->name)
 	),
 
 	TP_fast_assign(
 		__entry->cm_id = id_priv->res.id;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+		__assign_str(devname, device->name);
 	),
 
-	TP_printk("cm.id=%u",
-		__entry->cm_id
+	TP_printk("cm.id=%u src=%pISpc dst=%pISpc device=%s",
+		__entry->cm_id, __entry->srcaddr, __entry->dstaddr,
+		__get_str(devname)
 	)
 );
 

