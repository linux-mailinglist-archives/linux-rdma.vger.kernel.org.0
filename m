Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665517B399C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 20:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjI2SFQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 14:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjI2SFE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 14:05:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA689CC8
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3d6d88231so109441235ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010673; x=1696615473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjv7XjWCeDrMXMYTb/YTTJo8q29FnAz83pH22uwoIO0=;
        b=g1MY3owXfmVFxC4qubpH9QOenRmlMJxfCvYyfu535aURz8GzIhvHdPQi6Xnp+Q6cZP
         Dd/hyifEZpAuLeFZ/ZckowK9PM3Rej+d/uOGZNunWhN3cv0KyPO+Za15HExnXJnmcUjr
         ha8BpBHJmCpV4lWAKEaVTlAymyXWoz6eDqMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010673; x=1696615473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjv7XjWCeDrMXMYTb/YTTJo8q29FnAz83pH22uwoIO0=;
        b=wKeQI6nD43iZ2vc0hmeIJZsy+ClYmOTeJlSlmrjwEKpOsdc+7puVFvChEzT7zwwyA/
         dnd6nO9ypYpmkFgC1RzlsDTkawkDP+Ac7Fay+ctrr5vu7ow6kuD5a1/xd2oZTMlCRcaz
         abyAtderSobGD0VcpoftaC66Qy0pvg8BNxrTUcDBR3pC/SyEhsr4uETVWoAmfGdf+eaJ
         QL3gBPXl7zY1tHo34LNt5kV+ZyZnKjUy1NlVTO1qCrixPY703jAI/rUpGAQ+jsU8AcT6
         jRdVR2BNsJIegd3yXlOx08kHN8Hum44JGYjwmWAp/kH9Lux9VX8KuugreP8YaWAk8xwo
         pkrQ==
X-Gm-Message-State: AOJu0Yx2G9C5reLAWjA1Vf+WRYJBkHbofJBvJj4jeCNQENmOJi5SEHb9
        28D+Li1kp5opX4wFubrkWHkKpw==
X-Google-Smtp-Source: AGHT+IEqbxt2iHBD3gT66BfcF4+zqgw5KnT5DPsKrmGXzyU2z5+ZNSV0Qlc7B//NeDlD+AqaM/ce+g==
X-Received: by 2002:a17:902:ea8d:b0:1bf:c59:c944 with SMTP id x13-20020a170902ea8d00b001bf0c59c944mr5046186plb.22.1696010673179;
        Fri, 29 Sep 2023 11:04:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001bf8779e051sm9028480plc.289.2023.09.29.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:04:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
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
Subject: [PATCH 3/7] RDMA/usnic: Annotate struct usnic_uiom_chunk with __counted_by
Date:   Fri, 29 Sep 2023 11:04:26 -0700
Message-Id: <20230929180431.3005464-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180305.work.590-kees@kernel.org>
References: <20230929180305.work.590-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=keescook@chromium.org;
 h=from:subject; bh=PVnuNq2a519xhVqwBmJpJ/aQUk1MR7UGuxLJSDkBI0M=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxGtOkrR3aIgB88Z3xMRuRsPr/pj6t6EgVcik
 IpjUEiLnaKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcRrQAKCRCJcvTf3G3A
 Jo5iEACbnoHJcJyHp7utyWJvDOGHq949IF3S9dIbHV2PkP642qwnvv3riAf4djGdAw0JTTF2VJA
 MU/bRdHd3fBmNGyf3uqPtz2avADi5Qrp02tF1gz8VOt4pgD6QJHfIkVFJBj04+VrIZuK2Xpusn5
 zoL6iEHRd/jUJFJlUNUlFEtm10nT5JkbkjpWKBD3g05vhRufE87afPIg60R61DQSA81h73t1O99
 N8qlbD2jKbuzlEb2IAko+pN/GNVvCV2qahIAEtBS60B3xkkwvKNCrmFJiAxvlqF0iYznuXBuAhb
 ojrSJRP1p5DwjajmTvpHROPJKipMvIs9Thufh+djwWCvfpWWwetI7bc+evEM/rUF2jiXl7oGOLO
 zMSAIhCHessLhv0mt6qrDF7OJxSwdxs4/1lRwzQt/aYCgyrWDAdKjUzS8JxgZAqdwdsBTPwD2+v
 gbbWHmXQQZOltmtew5a6N+hwlDI/zQCj9ZJCvAHH1HIp0cvAYznJNvjkZzsoP+HJKs/UgzFuONt
 Np1NLzVO+JKDE04zcP4DQftGbxQ5BSm4lRlfttV8DqLSbna6Nixk+T1lcO4SZdykPmMskePTb5G
 uzmYpw1ScL3aEag5bNei8eBBCxG2sdmOx/PPAsdh8knLy4FlBAed695G3bGcv1GWSKMtnzfP1IF OFHIWV/FkLGL9YQ==
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

As found with Coccinelle[1], add __counted_by for struct usnic_uiom_chunk.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Christian Benvenuti <benve@cisco.com>
Cc: Nelson Escobar <neescoba@cisco.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/usnic/usnic_uiom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 5a9acf941510..70d51d919d12 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -77,7 +77,7 @@ struct usnic_uiom_reg {
 struct usnic_uiom_chunk {
 	struct list_head		list;
 	int				nents;
-	struct scatterlist		page_list[];
+	struct scatterlist		page_list[] __counted_by(nents);
 };
 
 struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev);
-- 
2.34.1

