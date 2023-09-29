Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB27B399B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjI2SFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 14:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjI2SFE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 14:05:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653741B2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690bd59322dso11436177b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010673; x=1696615473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/QLRqHS2L1NZ+5Mittg0t9KUpHsT5gMIELAAOGClyI=;
        b=CnWJmFgDThESeBVrWvndRL7qevdh1LedSSoza2qpzq1NbzCsE5Z+V/JhhSt/4s6hhV
         a2ZsuSY7lMs1NtZF9tAuBQb/v+ysmbMW0PonovPnMYgGc8bMnpjHz6hKuJTriaMMlcRP
         BaiWCIy6iTKVZP6TB+a682fT2tPZUp4ZrqpHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010673; x=1696615473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/QLRqHS2L1NZ+5Mittg0t9KUpHsT5gMIELAAOGClyI=;
        b=TXaZTM7SwPR2UEHBG7IyBJmZIAuxkKa3jx96mY8eY+vnJvJ/Ae0+nPcKRzWfppjzib
         Iirs1x8PHB8f+c/XqlmqgLmR1XboXksmRXr8N8uYZack/LDKFpq4lJ1hjBXRCvlqjCi+
         VtSTjvRjyWSgc4kmpY1Ah98zGsEevMnknfkc2pT4ZJXKnjKwCmO/YbPmfNgsTGikzUwh
         kW8aHLQMn2D3y9+255nQg7TSLABbIbWOg/V+i2OUvm0GFtzusJeVMWruZ3LG2YvHFLCf
         Jo5al52APbiy77UnifydAxVOeVyBe/vBqaG5tAVFdZOp3cnGc0XxidCx/DWqDwuVBp1p
         wRJA==
X-Gm-Message-State: AOJu0Yw1HYyoRcyzSzsAzvIb4ZZV78jW24zzPRRoO29jmPtiO2wt8d8v
        vrMS6lyNYqwsF2LCY/EZzwdW2A==
X-Google-Smtp-Source: AGHT+IGac3Y+OxZ1Rfapit3zv2uDFcPVgfD1mFi/owGzR0eAKACpnMWPiW7mh4tp2DCOwfeg6BIUyQ==
X-Received: by 2002:a05:6a20:7d92:b0:15c:fa48:2c09 with SMTP id v18-20020a056a207d9200b0015cfa482c09mr6069263pzj.15.1696010672901;
        Fri, 29 Sep 2023 11:04:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gp15-20020a17090adf0f00b002790ded9c6dsm1743374pjb.31.2023.09.29.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:04:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
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
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 0/7] RDMA: Annotate structs with __counted_by
Date:   Fri, 29 Sep 2023 11:04:23 -0700
Message-Id: <20230929180305.work.590-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=keescook@chromium.org;
 h=from:subject:message-id; bh=/4LMpXENw48q7fWMpYL2O5Uv9CCph1q6zJBZxS3OiTQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxGtfNnwAB6/IhVqdJxC7ZgaTcIkDx4p62U8K
 94/n2sAm5mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcRrQAKCRCJcvTf3G3A
 JrPDD/9G/FXBBVcXylRtWq4GKt0j7nGB3Sb1K6AcSlCVxVFBRy+nxwfYQQZr4xtXxsWvyMHA3GO
 an6tniLg3oW6KAqeWlyoWTPCgAB03CJi+G+hDiHHCov15sOhpiT+456fNXINz4dWnuT1qjDocWu
 qVgb/JbcWJ1yknRDBwLxZj8BxmPFaaI0fAk3CBQ1uQGoIuXnpCcwPc3K4LnXUr291JEhvyG1GYm
 3AoB/bQL+pdZ+iiLJ8Yy/zYhFRiaJJjemNfx4dgeoeVtFYw/5lBL12b3cig48nQ5OYmhzuKV6DH
 J+ivtBBRlahSdgzv3pA7WYfvof4aT9lQPMFU8DAhQwTPxyBIQBQGJcmO6kpVvOYl/RV3fMyaG4O
 AHoNT3KByS2bpG0ExZn6Uudg9PdpU4oZDnBycx9eyVau5Fo5w3iNBmOaONQqpSV8sm21McFz7bc
 PlWSe1ghKr/6+gz6B7c6xuGI5XUCPAgmfeoZK0ImUfSKKq4dMNZQgXsbUKst/+9wQuU6Xes3YQo
 Th5dJxMb43142TKmxCpqx3Rjz4V3QoMFZuIzOmqjdgLuZ4/h/zPhD/7BIsty0C49KtvuHqctwCa
 6mxhmeKDdB6fYNPos0YZ/L7sWYNIQGJxNq4XbGnQijtT1dR331wWDNTg+3OFKZr5O6Et2PaYOjJ
 nEyQXsh KrnMXw1g==
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

Hi,

This annotates several structures with the coming __counted_by attribute
for bounds checking of flexible arrays at run-time. For more details, see
commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").

Thanks!

-Kees

Kees Cook (7):
  RDMA: Annotate struct rdma_hw_stats with __counted_by
  RDMA/core: Annotate struct ib_pkey_cache with __counted_by
  RDMA/usnic: Annotate struct usnic_uiom_chunk with __counted_by
  RDMA/siw: Annotate struct siw_pbl with __counted_by
  IB/srp: Annotate struct srp_fr_pool with __counted_by
  IB/mthca: Annotate struct mthca_icm_table with __counted_by
  IB/hfi1: Annotate struct tid_rb_node with __counted_by

 drivers/infiniband/core/cache.c             | 2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.h   | 2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.h | 2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.h    | 2 +-
 drivers/infiniband/sw/siw/siw.h             | 2 +-
 drivers/infiniband/ulp/srp/ib_srp.h         | 2 +-
 include/rdma/ib_verbs.h                     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1

