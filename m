Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA47E98E6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 10:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjKMJ2M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 04:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjKMJ2L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 04:28:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543A10D2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 01:28:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA3FC433C8;
        Mon, 13 Nov 2023 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699867688;
        bh=tQWDkraWW17tXIJ9OIZXAPsWCiMvHAkHa2bctM7Mt8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=gRHRO5fQ0zHSbB6bNzgkbVww0KYw/kXlrB9I2uZCXxmYF4H8HAIjFBy+ecQ8IZ1Pj
         9JQXOvkLGohpcOIO72G7X22PiiazyVxCeogmC2JQbHOK+j6iB8JckT8kbpZ6sMOBzY
         LlQUObOM0pgFhkFWBmEdN5nPx+APzypXbLCu6IZy4Rae56OzsC7RhnD5HTbaliGuIN
         Hwfq9r5l7OFstttVevdukvdhdjY/of9RVl66URKjDAX0LPY6VKMBEB4aZAXqTlyLIh
         ekTxdMohMAJ7Ox1XjtAELUVgLuJCHPYbVnp9RvP1Njoz6gp2mNi/FVfsqvuvh1ediR
         Sj6opNUS1+bwQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/usnic: Silence uninitialized symbol smatch warnings
Date:   Mon, 13 Nov 2023 11:28:02 +0200
Message-ID: <c559cb7113158c02d75401ac162652072ef1b5f0.1699867650.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The patch 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16, 2005
(linux-next), leads to the following Smatch static checker warning:

        drivers/infiniband/hw/mthca/mthca_cmd.c:644 mthca_SYS_EN()
        error: uninitialized symbol 'out'.

drivers/infiniband/hw/mthca/mthca_cmd.c
    636 int mthca_SYS_EN(struct mthca_dev *dev)
    637 {
    638         u64 out;
    639         int ret;
    640
    641         ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);

We pass out here and it gets used without being initialized.

        err = mthca_cmd_post(dev, in_param,
                             out_param ? *out_param : 0,
                                         ^^^^^^^^^^
                             in_modifier, op_modifier,
                             op, context->token, 1);

It's the same in mthca_cmd_wait() and mthca_cmd_poll().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/533bc3df-8078-4397-b93d-d1f6cec9b636@moroto.mountain
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mthca/mthca_cmd.c  | 4 ++--
 drivers/infiniband/hw/mthca/mthca_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index f330ce895d88..8fe0cef7e2be 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -635,7 +635,7 @@ void mthca_free_mailbox(struct mthca_dev *dev, struct mthca_mailbox *mailbox)
 
 int mthca_SYS_EN(struct mthca_dev *dev)
 {
-	u64 out;
+	u64 out = 0;
 	int ret;
 
 	ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);
@@ -1955,7 +1955,7 @@ int mthca_WRITE_MGM(struct mthca_dev *dev, int index,
 int mthca_MGID_HASH(struct mthca_dev *dev, struct mthca_mailbox *mailbox,
 		    u16 *hash)
 {
-	u64 imm;
+	u64 imm = 0;
 	int err;
 
 	err = mthca_cmd_imm(dev, mailbox->dma, &imm, 0, 0, CMD_MGID_HASH,
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index b54bc8865dae..1ab268b77096 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -382,7 +382,7 @@ static int mthca_init_icm(struct mthca_dev *mdev,
 			  struct mthca_init_hca_param *init_hca,
 			  u64 icm_size)
 {
-	u64 aux_pages;
+	u64 aux_pages = 0;
 	int err;
 
 	err = mthca_SET_ICM_SIZE(mdev, icm_size, &aux_pages);
-- 
2.41.0

