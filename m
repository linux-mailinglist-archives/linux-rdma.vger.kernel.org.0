Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773253495A0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCYPds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhCYPdU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7AEC06175F
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j3so2853117edp.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLN+2seaXa40AIuGZbDpdFYWyUiwMRyiRtBWXAsvCDA=;
        b=HM3YO/Djao2e0hs2nsKDxnziAFLXBoBOLENwUwMYvmQUn7p9wx9AvgbnmhyKISOIio
         VGWNqOxt9xS70R3NniaCZIqZb2NF2hgkJXwNCfpbvuhLD+2yI03o5AP2Km0X3iKGqlnn
         Nsxt1ovPsz5UAtHbg0sFXeAlKfT/D91LJB2zbtNEatjIC0ojfSyB0OYXv7WNVmflgktr
         5i9Kuj9rv5hoOo74AvDGohZtquB4FVPX/c/vQbTqjU2GMxDPstUhgeBa9rnkKh4I30PV
         Wm+8RzJV959j3wsegSq2CljDVlkEaKLehvCHAmxMZFdr2nHYXxBY0v9+hmXpgn+cKtYk
         QrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLN+2seaXa40AIuGZbDpdFYWyUiwMRyiRtBWXAsvCDA=;
        b=afRzu70kda93xfgIE6bqdetwz0olFCECWTVzAvCYbVHzYM5hH69+cvFfO3CaAKZGcv
         Qw+0hilc+cKF/GSTIXIUoUU9T45v7RUdy18OhUE3grBpSny62yIHTlxQZAuHFG4Li8mJ
         jZoor3FDmnwUe5hGhBtHJrl24ZJ0R4ftY/YK7JPfUSD4JGpMTHcAloxw/FdhQ+zR2FMv
         MejbkiTjL7BE80xvcRhPHov1ghHSH/ZOt+NppvK+k3Gd9TPmIddq4b2GRMuMf4QDutBd
         DVL60IcWI7PUDlRKAEoh9cyoDWDcoq/ApYTqMYImqrJJ9CaH8cf2IpBuS2tyu3/KwjbZ
         +56g==
X-Gm-Message-State: AOAM5328iKNGu6qj712wGmi2n0OnqHoNQTPmbwehGJApW4M4vhqmuL1c
        C8RGInLvsAw67ScZhzmOgBQcMp3iNawxuQW2
X-Google-Smtp-Source: ABdhPJxxNM7I1d0yGgVOAVX7QfqiuzaMZLx567sZG36MubHOFh3M64YXKi7jIIyJIYLoFYK8+XO5ng==
X-Received: by 2002:aa7:c1d5:: with SMTP id d21mr9530853edp.167.1616686398079;
        Thu, 25 Mar 2021 08:33:18 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:17 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 06/22] RDMA/rtrs-clt: Break if one sess is connected in rtrs_clt_is_connected
Date:   Thu, 25 Mar 2021 16:32:52 +0100
Message-Id: <20210325153308.1214057-7-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need to continue the loop if one sess is connected.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 .../fault-injection/rtrs-fault-injection.rst         | 12 ++++++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c               |  5 ++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/fault-injection/rtrs-fault-injection.rst b/Documentation/fault-injection/rtrs-fault-injection.rst
index 775a223fef09..65ffe26ece67 100644
--- a/Documentation/fault-injection/rtrs-fault-injection.rst
+++ b/Documentation/fault-injection/rtrs-fault-injection.rst
@@ -17,10 +17,10 @@ Example 1: Inject an error into request processing of rtrs-client
 -----------------------------------------------------------------
 
 Generate an error on one session of rtrs-client::
-   
-  echo 100 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/probability 
-  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/times 
-  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/fail-request 
+
+  echo 100 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/probability
+  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/times
+  echo 1 > /sys/kernel/debug/ip\:192.168.123.144@ip\:192.168.123.190/fault_inject/fail-request
   dd if=/dev/rnbd0 of=./dd bs=1k count=10
 
 Expected Result::
@@ -72,12 +72,12 @@ Example 2: rtrs-server does not send ACK to the heart-beat of rtrs-client
   echo 100 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/probability 
   echo 5 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/times 
   echo 1 > /sys/kernel/debug/ip\:192.168.123.190@ip\:192.168.123.144/fault_inject/fail-hb-ack
-   
+
 Expected Result::
 
   If rtrs-server does not send ACK more than 5 times, rtrs-client tries reconnection.
 
 Check how many times rtrs-client did reconnection::
 
-  cat /sys/devices/virtual/rtrs-client/bla/paths/ip\:192.168.122.142@ip\:192.168.122.130/stats/reconnects 
+  cat /sys/devices/virtual/rtrs-client/bla/paths/ip\:192.168.122.142@ip\:192.168.122.130/stats/reconnects
   1 0
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 4f7690137e42..bfb5be5481e7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -51,7 +51,10 @@ static inline bool rtrs_clt_is_connected(const struct rtrs_clt *clt)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
-		connected |= READ_ONCE(sess->state) == RTRS_CLT_CONNECTED;
+		if (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED) {
+			connected = true;
+			break;
+		}
 	rcu_read_unlock();
 
 	return connected;
-- 
2.25.1

