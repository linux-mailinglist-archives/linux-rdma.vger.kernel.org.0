Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCED47B399F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjI2SFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjI2SFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 14:05:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B31CF7
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68c576d35feso12742093b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010678; x=1696615478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6dSgw/viVX1hF9GiVxg31bNXS5ti9jq2oLyQe/SrHc=;
        b=RAgSKSo4zQtWvBRw+50KgyVoBcddzo6Bxc8UevyFsYod4tHXTeT445CN4cpaSQ+9sM
         jOM9XQdA5XkKkBphfL4rm7rHzTioY2SgCLph1lWbeQrTteSM5PHvldaQAcEbXfyrYhri
         GWh0z9UUYr0L30xAZqh1/AdgcZ6F2Bh/NGmfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010678; x=1696615478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6dSgw/viVX1hF9GiVxg31bNXS5ti9jq2oLyQe/SrHc=;
        b=pq9V6tjfFvBfAyothmtbhlJPTOVBazheP9n5YenfklZRV/XaaYWGkNmUcoBKfND+ui
         KTQDIrNuZL68GDRQ/6PKFPnb3/hcmnocYJqTADGTWiI9QUtJmvWJUmd40+/GjZosM313
         j6EYByfAG2yMX1gKJShZYdV7awdXWbeJPO8aumUFPAuEcE4yT9FEix6Y8p4W1Dz1TxmB
         cfAczJvaGDWA+zx0WmkbKDy29/n/N2qHVdNvbKEfxKLOCyPHKIFsYd1CcIj/2ST5Zh0O
         8eRyWzmRFiF2Ed4bb4VD0YUT9WHhas6PPLAXhi4F/HBdEsM+YbPp/o/fBT3lAlqs9+5+
         PZoA==
X-Gm-Message-State: AOJu0YwkiqFi8pO/droSsKvLd2vw/BK0Uf5dMiF1MwdicBJEs7h/t3mA
        YDQKkqGsJUgZqjzwhmJWcu/AeA==
X-Google-Smtp-Source: AGHT+IE20otJ4RSneK87xPc+d9C9PCpIJ8g8LIGpqUyyhEz7f1L4BvfQ+bBNZm9ZhHkhttGWrv8vlQ==
X-Received: by 2002:a05:6a20:549a:b0:14b:8023:33cb with SMTP id i26-20020a056a20549a00b0014b802333cbmr5761090pzk.11.1696010677683;
        Fri, 29 Sep 2023 11:04:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b00690fb385ea9sm15316956pfo.47.2023.09.29.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:04:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
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
Subject: [PATCH 6/7] IB/mthca: Annotate struct mthca_icm_table with __counted_by
Date:   Fri, 29 Sep 2023 11:04:29 -0700
Message-Id: <20230929180431.3005464-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180305.work.590-kees@kernel.org>
References: <20230929180305.work.590-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=keescook@chromium.org;
 h=from:subject; bh=KnzErPDnGsoACiNJdVcsN/BX+MW+GH0rlXVaL/E2pIg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxGudlYNxBZwxaAdfN5vXxcaqFfVqmj7dgAXy
 KxCK6A4NgOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcRrgAKCRCJcvTf3G3A
 Jq2fD/wOjmJ/GTNcAOHMWxIkPbGB6y5ReI6NRHk1MISbwnUZHxFPl3cbxT4uBJ/tSFMWvYBIaZd
 CHF5KasHHeSkYcZgmCwOmDN1uWLSey/4j8PDvrpfKYLZ6trEcfgkT79P1w8JSgXNi/O8mBA7P3b
 7skNWfNzTtAOq3D9GCfGkKoa7SOuU+Zs+g2so6pg3TInolHbr36AlerV403JYrGfIAQROPlltvf
 6HbSLVByZEh4E3MlUrYKQhxmGo350//eAiVrjrpgj8zp6ASrjFLr5MSG5EZ1K1SOUhb1z1M710M
 KCxJhPfcH804qdRPlcPegKvBN3JwbexhAiuJUv81lEL8aIud2X5tFi8lJZfHbAtREW3ZALi+1XC
 qsi6RyjGH/EaSX65t5UCRLFRRnLK1Fu1L0ad+ny7oCoS+zPSFELwsvSsgeO1Ay3V9M3VM/t6xi9
 nPKdHSmc8EFPNM4xPJRu584TvMccInO4cFOq4JyjHaWZ9NX3EalXvkRQA6TUx4zo+AD2xJeYXb2
 lQWAJnl0LZCQ42huxY9W+Jj0X6J9hT32sjj6XnQGW65WPWCcGRBrEUoubExTgbb5eFqErnOwKcA
 R/RCcDiXvP+N2bi7MXqQ+DBgsFWZ4P1MaCRmEolelIiFmKGq3vm8m7RdjYnD9qmODro0EDfFQCR iOTFHqonxskMATQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

As found with Coccinelle[1], add __counted_by for struct mthca_icm_table.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mthca/mthca_memfree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.h b/drivers/infiniband/hw/mthca/mthca_memfree.h
index f9a2e65e2ff5..61d5bbba293a 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.h
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.h
@@ -68,7 +68,7 @@ struct mthca_icm_table {
 	int               lowmem;
 	int               coherent;
 	struct mutex      mutex;
-	struct mthca_icm *icm[];
+	struct mthca_icm *icm[] __counted_by(num_icm);
 };
 
 struct mthca_icm_iter {
-- 
2.34.1

