Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7823E249384
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHSDl7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHSDl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:41:59 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE44C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:59 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v21so17990502otj.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNwXvtjb550doMAvR/MXJrTG/3/GwfTOjvf/tXFzCbA=;
        b=AnQzcQdoQTS7L7aABcum3bNCOonVzWq990TwJ8PBnXlqcorcZWtmD93NySPq573AU2
         b7U8DZNVQv5yjFvlw55IlTkDpIUe+b0Qyvv/i/8yKmsZr5GOsWOW07sgpPRRNAnuv18x
         BnLtW8hyYa9y6IB1tqjotpEFtFBKlJQ1KJR+fX8PnI/e21c6EnSjQEqd9Cc+3r0JHvgn
         //PiWXteeLG/qIHKk86tLgrVvzT3g/JsigBn2We0Uvay2WbWp8X6nQwMRf7MBSOG1lgN
         P5ihHxZnVTi1A932mH9bjTvuoYVuNcRVF7vrWi8R9s7fPs5zbho5LHeW3XWf34cgmxpX
         6Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNwXvtjb550doMAvR/MXJrTG/3/GwfTOjvf/tXFzCbA=;
        b=oDGLicus/LiqRA7RQfZgoP6c1pmrPfO9pJC9ScTT7ZF+i1sXg7jFfpk23p8PAntXoP
         glnbHyTiDT97gvZ8d/Me7Zg3m6vr7ualxiTXLJcGQozUrSNKKkdC51C/0Of/j4nqma8V
         tEDc7GtIMvtZHrh47ZRc0ftds3xh/7rGNxNxBiCH8GSxHJjoxKeYkbXU/HU1i4ht0K8+
         Vl7rPMH2eRHQJYihtop/BZ4eR0VbtMIdIH/am64YsH+ekHQ0rlv7Pdx2aefdeaEvooU/
         pDgJo8ogR74jBm7IWKQehZM41LDQE4N7RVhdUtX3vmJUEQqAqyXDWRcg7mxeM+/dAS51
         nM1w==
X-Gm-Message-State: AOAM530kK/GPDIcq/gaUQCz0E6E1JkPD5gWrqLo4DmxdFjWvFGVTljAM
        Ieqz2ccWp3rISZ3bVF2QiXY=
X-Google-Smtp-Source: ABdhPJwvFAG2BspIxEyETRmfQC+20cLCrvZRjQPI4uwp8ArB4N4Q7MiIEpZ0Vnz6OOHkfVypRj9ldQ==
X-Received: by 2002:a05:6830:45b:: with SMTP id d27mr17805793otc.312.1597808518710;
        Tue, 18 Aug 2020 20:41:58 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id l17sm4331519otp.70.2020.08.18.20.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:41:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 05/16] rdma_rxe: Added bind_mw parameters to rxe_send_wr
Date:   Tue, 18 Aug 2020 22:39:56 -0500
Message-Id: <20200819034002.8835-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a first prototype version of the user/kernel ABI extension
to add memory windows functionality to the rxe driver. It evolves
later.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index d8f2e0e46dab..dc01e5f3e31a 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -93,6 +93,14 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32	mr_index;
+			__u32	mw_index;
+			__u32	rkey;
+			__u32	access;
+		} bind_mw;
 		/* reg is only used by the kernel and is not part of the uapi */
 		struct {
 			union {
-- 
2.25.1

