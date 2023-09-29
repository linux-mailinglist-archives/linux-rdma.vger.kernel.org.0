Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9710D7B39A2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjI2SFU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjI2SFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 14:05:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385BCE5
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:37 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ae0135c4deso8287851b6e.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010676; x=1696615476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7loYy4I0V9WbaRkyDORfpVOvXKBDkMaDU3HmTq6aaCo=;
        b=EZhw26pMBtemT4/sbnEq4t0BUiSO5I0ZuBVJVi5aM9lw9Lp0W2ALRUOyFGjYBl5Vyu
         y7MMLy7tzTqQFIXSJov2bN+Tljn+5Sp9+RfB4PBIbdf0Ed9vAuC+cKFxO19l/T1/uYr6
         Ul0lfTGAq/j6aGv5LYk46VAqe3XgjMNSLT5Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010676; x=1696615476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7loYy4I0V9WbaRkyDORfpVOvXKBDkMaDU3HmTq6aaCo=;
        b=EGLG9xJxtpqyY9HO/gtX7+aKsj9t8ZK+MJXlsD1Z1qBlUnIafwMhRw8wO/jFKYAxlp
         eBBNCRAxoOXqqvqwAx0C6ut1suQC7yNHgdcBogXR9MSh4Ld75aN+V3MAVC7pCtooXurr
         gZvjhFo4eZUSXHs271bGeMMLe7vaT9v1ZNf5wbeYsUTP1rX3UglgPjnuQb0IfaIK6DPH
         zEbJ8OVzoaMyRnsrSC490qBLIbzsKatWmQxPsPHVLRUBWfuOY76DQG/AuM5brV3V0qiG
         xgurq2o8wRH/o747NwncTe1GfIMW79nHMziKJb4l8WwXnonFDjbqBu1lM52wqoPnMJrm
         OcbA==
X-Gm-Message-State: AOJu0YywT7y/4ffRgmfbqKfIhpoqOS9tIKayoV2QUuYJ97SrKvBO5voR
        lTYX0JQpux9P6mA6ksXNFaQX9A==
X-Google-Smtp-Source: AGHT+IFp3QSM5ekw8j1tI8tUgHc/WNycC/Pf0i2hoCRkySu8Sy7s2YFcq9MZ1lU4xH4xRaStQRdeLg==
X-Received: by 2002:a05:6808:18a6:b0:3af:79e3:68d7 with SMTP id bi38-20020a05680818a600b003af79e368d7mr1401295oib.59.1696010676667;
        Fri, 29 Sep 2023 11:04:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm13985771pga.68.2023.09.29.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:04:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        wangjianli <wangjianli@cdjrlc.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 7/7] IB/hfi1: Annotate struct tid_rb_node with __counted_by
Date:   Fri, 29 Sep 2023 11:04:30 -0700
Message-Id: <20230929180431.3005464-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180305.work.590-kees@kernel.org>
References: <20230929180305.work.590-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=keescook@chromium.org;
 h=from:subject; bh=5+hginCoO40gXVEhDd2TzT5efPqXVR+knLSWVnfU8ow=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxGuDgcPnSEEDSvhCdq3C2vJgb3qdw/LhpW2x
 tim/TyUa5iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcRrgAKCRCJcvTf3G3A
 Jg7CD/9IO6sfIhcdiDAPuO2CKDNVoq4p3SdHoXmM2XBp1YwBoHT7gEwQR4RT3mIzlG0I74nKm73
 H1EX/Yd0bkul503BOk+eormeqtpn+hLrIuRDPEbk8HlrZYFYWvVNa8D2yREVfyds3CgOwE6UyXc
 aSMx//AL8Z/qpDmeqBlbNL3O7OK6ht9K/mK42LORZkAY2hzmq0WV4kXhrC4PlektH2akmXS5DGj
 wlAO77pgLRGhcEKrZmaPjMsGzh7bZQ8houJ4w45ShKUjDBRQZM88fq4pbM8ImffIF2X0VUTXa8Y
 09T4SWVZEMw8sEudVJrENBXRQNVGyCNnhLA7UYvmfVX4tu7PhZOUpUpEQPy3OiRIFRedVNs1DnW
 NJ4fSKoAyJ70B8mH6FuSf70jLl4QpvpoFrsVzCYqLrYyMd6KLqEp8LdtoN/BR5NTtZVusEHHeuK
 6klHggoNRwySEq5Vx0C2HRXgbtytwRw+9wx+62nvwql58uSwlMWbkRW2pipsMK0VFMf4HrM+DZL
 plMPJQ5nI6HHBKsq9E9A4u4Q+EXFpmiMlhxgVfHlUWxmDUhKAevh2CY7xXj8qOBqh9CA+6KWM8o
 EfcCi4Zo4YfCzhn6C6lTC6EHSFNVRp42NhaUyL4yADcXaSwX2WpfvsaYkzZQGYOy7O8AMn4zzEM gPF6o2m6oJt8Efg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct tid_rb_node.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index b85de9070aee..055726f7c139 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -36,7 +36,7 @@ struct tid_rb_node {
 	dma_addr_t dma_addr;
 	bool freed;
 	unsigned int npages;
-	struct page *pages[];
+	struct page *pages[] __counted_by(npages);
 };
 
 static inline int num_user_pages(unsigned long addr,
-- 
2.34.1

