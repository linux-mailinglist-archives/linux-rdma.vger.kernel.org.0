Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09E22815A2
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbgJBOsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbgJBOsh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 10:48:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24939C0613D0
        for <linux-rdma@vger.kernel.org>; Fri,  2 Oct 2020 07:48:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so2131549wrx.7
        for <linux-rdma@vger.kernel.org>; Fri, 02 Oct 2020 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JX2FxwIrrPXuM/u/Qno1EBAL0lJUlKuwL4H9trYkJ/w=;
        b=HMPEBDcnI+9aYkikeCqm4WkYHBElYJ5zwTB0TckPg4CxxKwJRurWPrPVxKM1CTnpmK
         0NB6r5SoYtO7ajWvCGnWfNS5/Vvgvd8Xtaa00+vTfKA9oZrKFInednpFmxFEjiL3o3OI
         p2bH3MPW/URATFK4WLEezkO3+3tpL4Zh2HKbyoiGZhUrBqBzJABQdgRqq14rzntFbT0K
         Mr+girQtXk5DtiF71ivjiLrFD8C9HpIDil/hrpoaoJlGJDtH/C9Nysv/nquKbs14oy8+
         6Rqf/cvzb0FEZHn4tA/3PIOB729qXe3ruyBIN6TfK/8ICwnjj2zAc4eQxP2jq0AMEza0
         m5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JX2FxwIrrPXuM/u/Qno1EBAL0lJUlKuwL4H9trYkJ/w=;
        b=cQug+l3FMunt50U70uW5167yaQiwffxDIgS4oiPefzB/dfIooBcZ8t09WmpAs9/o6w
         MNlro8KnoCM1+jezrVYC2+afizadWki+tioeAEBw8Hzia2jESm47U72AoVUIb0thwrSY
         1AD94dQmWZfzdhPJVEm2pKhPl0ACWy3z9nQNhMN/1JvAAQLPUU6Tn1B+fgi6kfAyU5Vb
         e+6or1xwY2M3cAuhfys2tfQM4yl3/xqz3qlPP1Ci1BazXB/1jxF3GcOUQfopbpa0G9U0
         NTQXYoLafjawaI7VTSMsjW9HnLt0bSSVpK3aaOaKiLpNR7AJ9R0X6NkZIsz0JD5xwG9H
         XGtQ==
X-Gm-Message-State: AOAM531XiRUGzMAfmc0LlSvNOPfLmBolGzIPWAvgloHNNLI1yCLIDZIN
        WIZ/Eq58iwv/1EKbAJzmrZ0H2TDXuJIzdg==
X-Google-Smtp-Source: ABdhPJw/lzcOxwf7ms6eaPAIIiOmvBHSL+VxtZJtGg7Q+xoEvpXH1a4/TvooVucTQOCG60hIfY9EXg==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr3503212wrw.294.1601650115788;
        Fri, 02 Oct 2020 07:48:35 -0700 (PDT)
Received: from jupiter.home.aloni.org ([77.126.105.230])
        by smtp.gmail.com with ESMTPSA id n4sm2001516wrp.61.2020.10.02.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:48:35 -0700 (PDT)
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] svcrdma: fix bounce buffers for non-zero page offsets
Date:   Fri,  2 Oct 2020 17:48:27 +0300
Message-Id: <20201002144827.984306-1-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This was discovered using O_DIRECT and small unaligned file offsets
at the client side.

Fixes: e248aa7be86 ("svcrdma: Remove max_sge check at connect time")
Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 7b94d971feb3..c991eb1fd4e3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -638,7 +638,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 		while (remaining) {
 			len = min_t(u32, PAGE_SIZE - pageoff, remaining);
 
-			memcpy(dst, page_address(*ppages), len);
+			memcpy(dst, page_address(*ppages) + pageoff, len);
 			remaining -= len;
 			dst += len;
 			pageoff = 0;
-- 
2.26.2

