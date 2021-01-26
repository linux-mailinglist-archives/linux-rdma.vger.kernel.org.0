Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D153F303E14
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 14:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbhAZMyl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403919AbhAZMt3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9BC061A31
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c127so2619921wmf.5
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMPWL4xcF1JuemrxQOYLmhlUXhHVXt9aCwFIvLWAmvg=;
        b=NPJrLaJ+ieP70+yUH0QEuQwSl/cJVDPNtryk+LPPOU4ry0VjoWJADw8ppN74mpelqa
         v7DZOil5sBeBMS9JjBEIZySg0hBo4Qkm6npFjH57DCrM2MdPuXoVOMWKVsEOq07C3L1o
         bFftf5O4HyIWE8HbRhxXrz64hiVWg2MfcYJljZJ8iAyDlKuqFiAJjB+eVnd4EFsXrJaw
         TDs1+Nqqno78NLwdMDvF8e8D9CZgBVmJP2urdcU8Khx8BIz6Kr+Ch+xifOvLCzKrbfu0
         u/M4eJPU1Yxiaq/L/Kd+eZFu+rCuTdpmsqXUzKgH12cGzzjU/hJMxVzheaJjLPOLVJLi
         fCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMPWL4xcF1JuemrxQOYLmhlUXhHVXt9aCwFIvLWAmvg=;
        b=hdp6c/03xMgVl4hMcV4BXJfGy8iIVuDRdc08ZpFGyG5hhCkyHQGKTtKwNmisNUFHyK
         mv0Rj77Fp7YUNG4yaJfuA4apuRgYCqKtuCGKTCI66xGLZQpJ3aZw+TnUNfFZy4RWqvjc
         rvgWjCJkoJUo6mKjcjRS5r/KdSNIL6TXBt7pxRdknV8zPFi5L0v6VRxnnKNssCr9ooIS
         MeY6mlLe0o9P49mZ+p9s6U+XITqjTJ0Mq/k318B6y/6ViLHkYtVoNGTYEFS5gUl0nW46
         agPD/+sEmnXO8QHU/YFTiv+RY29TohMU6Gmt/0S/LcKW4TprUa9ABxnCm9if34QDGWib
         ZOSA==
X-Gm-Message-State: AOAM530rfA7cYboEZ+ILgXWG2a0avPYtNJVNlmQHwcaJ0mA2ZQ5av77o
        f22OWyQgW19mtvxmPoTvxgnWXg==
X-Google-Smtp-Source: ABdhPJwHKbeLsVd+Hxqfezp4jl3v4stixH8G3pUHkseIsG2FSuSpZibIrfyILM1amXTlIQK/o8JB/g==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr4526261wmq.79.1611665256744;
        Tue, 26 Jan 2021 04:47:36 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 01/20] RDMA/hw/hfi1/intr: Fix some kernel-doc formatting issues
Date:   Tue, 26 Jan 2021 12:47:13 +0000
Message-Id: <20210126124732.3320971-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/intr.c:99: warning: Function parameter or member 'msg' not described in 'format_hwmsg'
 drivers/infiniband/hw/hfi1/intr.c:99: warning: Function parameter or member 'msgl' not described in 'format_hwmsg'
 drivers/infiniband/hw/hfi1/intr.c:99: warning: Function parameter or member 'hwmsg' not described in 'format_hwmsg'
 drivers/infiniband/hw/hfi1/intr.c:115: warning: Function parameter or member 'hwerrs' not described in 'hfi1_format_hwerrors'
 drivers/infiniband/hw/hfi1/intr.c:115: warning: Function parameter or member 'hwerrmsgs' not described in 'hfi1_format_hwerrors'
 drivers/infiniband/hw/hfi1/intr.c:115: warning: Function parameter or member 'nhwerrmsgs' not described in 'hfi1_format_hwerrors'
 drivers/infiniband/hw/hfi1/intr.c:115: warning: Function parameter or member 'msg' not described in 'hfi1_format_hwerrors'
 drivers/infiniband/hw/hfi1/intr.c:115: warning: Function parameter or member 'msgl' not described in 'hfi1_format_hwerrors'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/intr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/intr.c b/drivers/infiniband/hw/hfi1/intr.c
index 387305b768e94..5ba5c11459e79 100644
--- a/drivers/infiniband/hw/hfi1/intr.c
+++ b/drivers/infiniband/hw/hfi1/intr.c
@@ -91,9 +91,9 @@ static void add_full_mgmt_pkey(struct hfi1_pportdata *ppd)
 
 /**
  * format_hwmsg - format a single hwerror message
- * @msg message buffer
- * @msgl length of message buffer
- * @hwmsg message to add to message buffer
+ * @msg: message buffer
+ * @msgl: length of message buffer
+ * @hwmsg: message to add to message buffer
  */
 static void format_hwmsg(char *msg, size_t msgl, const char *hwmsg)
 {
@@ -104,11 +104,11 @@ static void format_hwmsg(char *msg, size_t msgl, const char *hwmsg)
 
 /**
  * hfi1_format_hwerrors - format hardware error messages for display
- * @hwerrs hardware errors bit vector
- * @hwerrmsgs hardware error descriptions
- * @nhwerrmsgs number of hwerrmsgs
- * @msg message buffer
- * @msgl message buffer length
+ * @hwerrs: hardware errors bit vector
+ * @hwerrmsgs: hardware error descriptions
+ * @nhwerrmsgs: number of hwerrmsgs
+ * @msg: message buffer
+ * @msgl: message buffer length
  */
 void hfi1_format_hwerrors(u64 hwerrs, const struct hfi1_hwerror_msgs *hwerrmsgs,
 			  size_t nhwerrmsgs, char *msg, size_t msgl)
-- 
2.25.1

