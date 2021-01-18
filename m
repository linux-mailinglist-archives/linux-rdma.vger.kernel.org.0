Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5312FAD81
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbhARWrN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389004AbhARWlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D8C0617A2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:46 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c5so17912944wrp.6
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwzNP5kyHoQeZRxeZSVY+m4WgCNHmZim89Aex+bzV3M=;
        b=DE6emldwpqG09140iU8DJVIgEVttWIINr5Lyz4ugvS4DsV0dLBfNxYlSnC0vczze2C
         9Ld7waXjDpfvS+Ez0w90iivhrKe0y8nE9y4gDBEjvdrmswkfS6jnIB54//9B2j0rc826
         j4nTGlxxPOdqnaxA8TofEn7/nsnwnN+/A3S/nE4ZBscU5SwDeKpTj8PtK3JHOtJsFwja
         KGNOMeHXDalpBDCos7sMEQ4mN9RV57pN4MAPuc5LA9h4dAcjOxy979wHnVUrDxVb31po
         b+rV+pTXCFvW6YkCBNzIk5gH+RnHBBoxZEBiPRvS/VOeH1SiPjtu013xXZa26F3uo75n
         lrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwzNP5kyHoQeZRxeZSVY+m4WgCNHmZim89Aex+bzV3M=;
        b=FP94fzUaci3kazdt/C4p3i8bds2WxlyOVS10jAUqdxUOdI34k+S9hPvXTHjLn2SoRh
         jPktwXCBQJ1r1DiBDrVBVoyQEecb4Bo6s6lM4bRRSQhNvkrZNgzY59JXLPnVVwhWqmyI
         gceVbq0zQxNxvD4qZsEX9NOOdJzct+dyaPzueKN12uZKRrgWDKV8Iytovf3JwhTkrgSu
         5sWO28wxfyD4QrC7HbauuVB/a5G18InkgaPU33wqDUxvZWBnQwdpoj98GpCCjpSopX39
         yjBsDhANsv9M7dqAp1v6ewScHl+FMYlXMYxjVWdZzZmgAPxyXMCcnaGrYT5Oj5oecHTZ
         Xtkw==
X-Gm-Message-State: AOAM532tpBN9SqPLUwAduvlRA8WFBij/gjfW4ZhVMQBwKKGssCNzDYVn
        asO8V1ojQyFnGOb6ebD46cmeiQ==
X-Google-Smtp-Source: ABdhPJywvIwmt0EOck4Pbkb+KtkE7KXOTIlpGFAE9ml3JcVB5KSkZ2lIFh8jLT1cKdtTrG5XBxeluQ==
X-Received: by 2002:adf:9d42:: with SMTP id o2mr1408439wre.135.1611009585324;
        Mon, 18 Jan 2021 14:39:45 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 11/20] RDMA/core/multicast: Provide description for 'ib_init_ah_from_mcmember()'s 'rec' param
Date:   Mon, 18 Jan 2021 22:39:20 +0000
Message-Id: <20210118223929.512175-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/multicast.c:739: warning: Function parameter or member 'rec' not described in 'ib_init_ah_from_mcmember'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index 740f03ecc05d7..57519ca6cd2c7 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -721,6 +721,7 @@ EXPORT_SYMBOL(ib_sa_get_mcmember_rec);
  * member record and gid of the device.
  * @device:	RDMA device
  * @port_num:	Port of the rdma device to consider
+ * @rec:	Multicast member record to use
  * @ndev:	Optional netdevice, applicable only for RoCE
  * @gid_type:	GID type to consider
  * @ah_attr:	AH attribute to fillup on successful completion
-- 
2.25.1

