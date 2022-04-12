Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF394FDAFD
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352384AbiDLJ5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359442AbiDLHnD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AFC25F5;
        Tue, 12 Apr 2022 00:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8560D615B4;
        Tue, 12 Apr 2022 07:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D2BC385A5;
        Tue, 12 Apr 2022 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748253;
        bh=ItFdyeHxJZBIWoIuqEPa3lbUs8g+9s4r/h9r0eUdwgw=;
        h=From:To:Cc:Subject:Date:From;
        b=dEvDnVe0iGkhcHj0RjVp1jlrxbMwXAFEKnJ86vaupD1IcCEu2GCzCKgERAVkBX8st
         USIP3lhU68Sp9qWoohjwgksBCkiJskRGTT7osn5nLpDmnBpZD4QYMPXlk7vo3RpKBx
         /J1CuYALC7IesyeLMTncnR46xQXq48yoEHl1sDLE84gS/DyKQn4lhnGN4UcNe5O/u8
         WKsCaD4NXP2a/noBdREk7mQofVwET70l6kIjyoUIJN7KUDBH/+w3mnV1g20ARxdO/C
         H870RDXqjabCqMbYtJ2rwhgCQOqW1EstcfvfxNE65XxH1iTXvZetCWYY3EAEcwnP5z
         tzNyt/BTPPQyQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 00/12] Refactor UMR post send logic
Date:   Tue, 12 Apr 2022 10:23:55 +0300
Message-Id: <cover.1649747695.git.leonro@nvidia.com>
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

Hi,

UMR are special QPs that require slightly different logic than other
QPs. This series from Aharon refactors the logic around UMR QP to
separate file and functions to clean the post send flow.

Thanks

Aharon Landau (12):
  RDMA/mlx5: Move init and cleanup of UMR to umr.c
  RDMA/mlx5: Move umr checks to umr.h
  RDMA/mlx5: Move mkey ctrl segment logic to umr.c
  RDMA/mlx5: Simplify get_umr_update_access_mask()
  RDMA/mlx5: Expose wqe posting helpers outside of wr.c
  RDMA/mlx5: Introduce mlx5_umr_post_send_wait()
  RDMA/mlx5: Use mlx5_umr_post_send_wait() to revoke MRs
  RDMA/mlx5: Use mlx5_umr_post_send_wait() to rereg pd access
  RDMA/mlx5: Move creation and free of translation tables to umr.c
  RDMA/mlx5: Use mlx5_umr_post_send_wait() to update MR pas
  RDMA/mlx5: Use mlx5_umr_post_send_wait() to update xlt
  RDMA/mlx5: Clean UMR QP type flow from mlx5_ib_post_send()

 drivers/infiniband/hw/mlx5/Makefile  |   1 +
 drivers/infiniband/hw/mlx5/main.c    | 109 +----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  89 +---
 drivers/infiniband/hw/mlx5/mr.c      | 421 +---------------
 drivers/infiniband/hw/mlx5/odp.c     |  63 ++-
 drivers/infiniband/hw/mlx5/qp.c      |   1 +
 drivers/infiniband/hw/mlx5/umr.c     | 700 +++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h     |  97 ++++
 drivers/infiniband/hw/mlx5/wr.c      | 377 +++------------
 drivers/infiniband/hw/mlx5/wr.h      |  60 +++
 10 files changed, 976 insertions(+), 942 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/umr.c
 create mode 100644 drivers/infiniband/hw/mlx5/umr.h

-- 
2.35.1

