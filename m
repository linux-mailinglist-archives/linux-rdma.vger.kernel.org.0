Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EA4FF42A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiDMJxv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiDMJxu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 05:53:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DDB4EA27
        for <linux-rdma@vger.kernel.org>; Wed, 13 Apr 2022 02:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D08CCE2202
        for <linux-rdma@vger.kernel.org>; Wed, 13 Apr 2022 09:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E29C385A4;
        Wed, 13 Apr 2022 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649843485;
        bh=hg1hQVDDlyr8aW83zSVmwhG1X4TIEA8cORs4fU6WQVA=;
        h=From:To:Cc:Subject:Date:From;
        b=igJatG5P7qw+QxLR2fy/wFSWgPuNjov7+qan+b01w3QO30T2bbbcKIANP4LvuvZ+Z
         xNbZDZzoeNPNJd3KlmmpJwnW52T7MWkqZsMgG4W4neblPaJwDgKFAMM5WQsUQc2BtM
         1VmMKwMrGqaWSkJ0DsqLByYqBUu73/HzMQiefDe0T1GkdAnjn/XkQf6eBL5Eo6/F2r
         HbK0O6CybK6QOfZr6FWn6AVXlFZYBNIPZLUEiYZzRGvaTK0Sfl+V+cFyLZMRWFcRJu
         N3QTMhQzkrycwAlh0+eVk2yjVml9Xk1OQlH8jfus4heT1NYMkKkt6FCkToIs7Riq7L
         6ihnOB1xn3DCQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Raed Salem <raeds@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix flow steering egress flow
Date:   Wed, 13 Apr 2022 12:33:39 +0300
Message-Id: <11b31c1f85bc8c8add385529aa3f307c3b383a11.1649842371.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The commit mentioned in Fixes line removed the function that was
called to check validity of esp_aes_gcm attribute. Sadly, that
is_valid_esp_aes_gcm() returned success even for specs without
esp_aes_gcm at all.

So the right fix will be to remove whole if () and such fix
the following error observed in smatch too.

   drivers/infiniband/hw/mlx5/fs.c:1126 _create_flow_rule()
   warn: duplicate check 'is_egress' (previous on line 1098)

Fixes: de8bdb476908 ("RDMA/mlx5: Drop crypto flow steering API")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 9c2886bc72cb..39ffb363ba0c 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1095,11 +1095,6 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 
 	spec->match_criteria_enable = get_match_criteria_enable(spec->match_criteria);
 
-	if (is_egress) {
-		err = -EINVAL;
-		goto free;
-	}
-
 	if (flow_act.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		struct mlx5_ib_mcounters *mcounters;
 
-- 
2.35.1

