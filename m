Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D991E8C4A
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2020 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgE2Xnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgE2Xnn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 19:43:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3FDC03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 16:43:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r2so1186020ioo.4
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6kMekp70y7/97bNHMukucpQgzblpsad4nDbQTss90oQ=;
        b=rO85bCBgDH7BKraf+qbWOooAepjxtVTMntdWd2WU6JC+PkXXVTK2jcgkr68BO1IWtT
         JB7FxfVQfmZsCsKslZ207ombYTHoEXXl6gV+BNi6XPnvvoh1TzmcHeC947OJY4ypfvZC
         8FOcAXNzXWQmS3BHDcLCocUG/pfTd/wCP5gqGzngsRrPjfP++vmdBQZuNP3gmCD1hcy1
         H3UmaxclN160i1EEcLW4Zx2tjnHdNM3e6j2wit0R6maAPBXc3soOCW2Rxn56OHsokEtx
         M80sjaYY+Bv4/k18nh24wSrwHYUCb6NhOkQoqfThestHBUvpyLjkWWw8njVXsu3wxZFB
         WJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6kMekp70y7/97bNHMukucpQgzblpsad4nDbQTss90oQ=;
        b=UIH/gkDKfENkbuacVo3EInurmAszizkKdoiPzl282DuVyC3D911y5gtQ2LZNP6NlZ2
         TMC9my9ncBxEaoHt27l80t+p0m2S5ESyWLC0kXmax6/28kVIwDDKpwQqeIxnjVEnlDoY
         SkZUqMB0gtgbBXnc/6LpexGb2ZjmNvie3VABpnrVgQzRWR+18THcU/uTwPqSYy0Li4dw
         II5V4v6yf4vlUPPbbsmevWYDTUts5080t4mMoqIaXT7QiZv9SuhBZn+8XRK7mosBY2Ss
         qRo3ErYbp5xK3lBiFvFj/z5a7zi/1SkfCFOa2+mOsyM+nvPQHhmN44UOeH7ZopQUZxL3
         n8kg==
X-Gm-Message-State: AOAM533ovuzPOEU9SWcF+wvUyO9SJ2WivL+cRsRbgmbuH7CMNW7lPogj
        FW89QB04x2WgGKtT+O+U+KvZk3vT
X-Google-Smtp-Source: ABdhPJxIYTzmxKlLaGI4VeaKQCINUXzW1ojZiWQI/efALOKH3w/gDIFTYghAmll5bpWsQ1Q0KtYKKA==
X-Received: by 2002:a02:958e:: with SMTP id b14mr9861744jai.126.1590795822223;
        Fri, 29 May 2020 16:43:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z4sm4432879iot.24.2020.05.29.16.43.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 16:43:41 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04TNhee6031526
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 23:43:40 GMT
Subject: [PATCH v1] RDMA/core: Move and rename trace_cm_id_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Fri, 29 May 2020 19:43:40 -0400
Message-ID: <20200529234340.12021.70650.stgit@manet.1015granger.net>
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

Fixes: ed999f820a6c ("RDMA/cma: Add trace points in RDMA Connection Manager")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma.c       |    2 +-
 drivers/infiniband/core/cma_trace.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 26e6f7df247b..520edce9b770 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -479,6 +479,7 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 		rdma_restrack_kadd(&id_priv->res);
 	else
 		rdma_restrack_uadd(&id_priv->res);
+	trace_cm_id_resolve(id_priv);
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
index 81e36bf13159..7b815488b26b 100644
--- a/drivers/infiniband/core/cma_trace.h
+++ b/drivers/infiniband/core/cma_trace.h
@@ -103,7 +103,7 @@
 DEFINE_CMA_FSM_EVENT(sent_dreq);
 DEFINE_CMA_FSM_EVENT(id_destroy);
 
-TRACE_EVENT(cm_id_create,
+TRACE_EVENT(cm_id_resolve,
 	TP_PROTO(
 		const struct rdma_id_private *id_priv
 	),

