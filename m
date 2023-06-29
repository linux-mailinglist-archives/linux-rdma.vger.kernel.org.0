Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356F742F8B
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 23:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjF2Vda (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjF2VdU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 17:33:20 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A730F7
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 14:33:19 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56597d949b1so755893eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1688074399; x=1690666399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdqbYuJF+hxkyaUumdwq6SAlmwcfqRVacmgjufRZP3s=;
        b=Ri4YdoMK4YHpExhY+UE6Vb015jMbjkJIg0g0obKr9vqjmhgnHd6VsAcxfdnv/AXONH
         ZD10eKzsS6kSgiksbq42vTeQuJoaXHzoJm76FZ6CFyxh2/lBzbOOQKt/AlRPTgfWSwwR
         o5xnu2nb/7rOhmGz+VJKL/o1nu2xI4DDSBTNCXsd8J0rUuDkWE34V9/eZEH8cMSnPevQ
         1Cr0oo1R6f5My4ILU/IOnq/AvSxzb/5Ljn8vJ+pXr1tpgMSixvTnoxtXAHOmCEu+CE3p
         jRefsamZQri2EIyemx5tknT2g4zCyIhpe/CSTwhxRmexcGn9kTfI+U0ysS4ZnZkjKBNN
         3rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074399; x=1690666399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdqbYuJF+hxkyaUumdwq6SAlmwcfqRVacmgjufRZP3s=;
        b=D/YhA5e98YpOEKFZ/cMuY9eFkBQ4oDaAOjic8iE1jYUmvhHd/z35CPNdQmbsjHXhcF
         Ux5QAFGZ52KbPdef3SaueEivKfnV3LuzG1sVNdQFhrzQzXeJCUxVFnTUlZ8Pz2iarffS
         kil9yF+i/NeVgO4EfY5PJyqtX/yjWYtQy0ujMNW4ir6YYc/Yc5CG8HXvryCQetqWWZQl
         NC2ssjTwnkHmoEJjfK8MLcGUJqqDwy3J8QluZtAulRBWiErSVkb+hac2ChwyfFhrqbxV
         QJ8fB2jmcK2e3rDgtRAuJTKMmtKLSWvEBEMeGU/kbY/+LerUdzJpkTLHD1nbO0wRNvTo
         butA==
X-Gm-Message-State: ABy/qLZzdUatIaAwzpRYxMXVGx6xhgcZYgD733kOWo65eDZ/6Dr8vIhd
        ZCVbVuVZQHOL+f7uUWMnfZuIypRMiK5Siufg8827Sw==
X-Google-Smtp-Source: APBJJlH8SNsWluW6RbphcqPAToJ+JJdDb4vhBzmVCqphRbUb7YiFFtWRm2T5v98UfyBEzgmtdWSpKg==
X-Received: by 2002:a05:6871:548:b0:1b0:5f67:283c with SMTP id t8-20020a056871054800b001b05f67283cmr1475012oal.15.1688074398749;
        Thu, 29 Jun 2023 14:33:18 -0700 (PDT)
Received: from dev-yzhong.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id t8-20020a17090a024800b0025bcdada95asm4830016pje.38.2023.06.29.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:33:18 -0700 (PDT)
From:   Yuanyuan Zhong <yzhong@purestorage.com>
To:     leon@kernel.org, jgg@ziepe.ca
Cc:     cachen@purestorage.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH 1/1] RDMA/mlx5: align MR mem allocation size to power-of-two
Date:   Thu, 29 Jun 2023 15:32:48 -0600
Message-Id: <20230629213248.3184245-2-yzhong@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629213248.3184245-1-yzhong@purestorage.com>
References: <20230629213248.3184245-1-yzhong@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The MR memory allocation requests extra bytes to guarantee that there
is enough space to find the memory aligned to MLX5_UMR_ALIGN.

For power-of-two sizes, the alignment can be guaranteed by kmalloc()
according to commit 59bb47985c1d ("mm, sl[aou]b: guarantee natural
alignment for kmalloc(power-of-two)").

So if target alignment is power-of-two and adding the extra bytes
crosses a power-of-two boundary, use the next power-of-two as the
allocation size.

Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2017ede100a6..92f35fafb2c0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1766,6 +1766,11 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 	int ret;
 
 	add_size = max_t(int, MLX5_UMR_ALIGN - ARCH_KMALLOC_MINALIGN, 0);
+	if (is_power_of_2(MLX5_UMR_ALIGN) && add_size) {
+		int end = max_t(int, MLX5_UMR_ALIGN, roundup_pow_of_two(size));
+
+		add_size = min_t(int, end - size, add_size);
+	}
 
 	mr->descs_alloc = kzalloc(size + add_size, GFP_KERNEL);
 	if (!mr->descs_alloc)
-- 
2.34.1

