Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B3E7B5C48
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjJBUzx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 16:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBUzw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 16:55:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435BAC9
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 13:55:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3243BC43395;
        Mon,  2 Oct 2023 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696280149;
        bh=Y2Lt8qx7KyiKOUPa2We5gWo6fuqgHoG5oG5OZdYy0+M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BMcitU6QE707Nv7g6gJ1R/jLsUitQvIalA9QIwaiVjMwAnU8Ia41eo+QMD8akWEAl
         /rQliFgY6/UxLd/8l33gzkvrrq8rVoed5MdIoFQmtQJYMIuunpjR91i0cDP842C+QE
         jNgE77xRgP4hH6UetsxuZZ8Dqc1wLhUR/tDIgyCn1rVpJOQYudBa+nboicw1ROVuse
         8w11v4zCWxtI1xSVl20iV/FBtlRmdodUFTw+0iqrVaRy1xbIsPAPNbIBDo53OLAqM1
         dou8zuehhoay/uNea7dGF3y/Fz+oGusWpD0uEcsoWkYhkzhZIXzMS79PH8wTN2ucxX
         xgWSZPIE14E0A==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Mon, 02 Oct 2023 13:55:21 -0700
Subject: [PATCH 2/2] mlx5: Fix type of mode parameter in
 mlx5_dpll_device_mode_get()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-net-wifpts-dpll_mode_get-v1-2-a356a16413cf@kernel.org>
References: <20231002-net-wifpts-dpll_mode_get-v1-0-a356a16413cf@kernel.org>
In-Reply-To: <20231002-net-wifpts-dpll_mode_get-v1-0-a356a16413cf@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vadfed@fb.com
Cc:     arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
        netdev@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        saeedm@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Y2Lt8qx7KyiKOUPa2We5gWo6fuqgHoG5oG5OZdYy0+M=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKnSesEfzOqbj2kfeNXzsH5q96utkjcLLAMNrU23Pf0++
 fiG0E/fOkpZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEZDMZ/set3+G6yeio7AwL
 m1uCJx+pLzxe/KRJ+/dVSfbY/cxuxwoZ/tkfelJ1K+/oz/9zFlaqLF/VU3vpT25Pic2rvmcv4xr
 OcXIAAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When building with -Wincompatible-function-pointer-types-strict, a
warning designed to catch potential kCFI failures at build time rather
than run time due to incorrect function pointer types, there is a
warning due to a mismatch between the type of the mode parameter in
mlx5_dpll_device_mode_get() vs. what the function pointer prototype for
->mode_get() in 'struct dpll_device_ops' expects.

  drivers/net/ethernet/mellanox/mlx5/core/dpll.c:141:14: error: incompatible function pointer types initializing 'int (*)(const struct dpll_device *, void *, enum dpll_mode *, struct netlink_ext_ack *)' with an expression of type 'int (const struct dpll_device *, void *, u32 *, struct netlink_ext_ack *)' (aka 'int (const struct dpll_device *, void *, unsigned int *, struct netlink_ext_ack *)') [-Werror,-Wincompatible-function-pointer-types-strict]
    141 |         .mode_get = mlx5_dpll_device_mode_get,
        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

Change the type of the mode parameter in mlx5_dpll_device_mode_get() to
clear up the warning and avoid kCFI failures at run time.

Fixes: 496fd0a26bbf ("mlx5: Implement SyncE support using DPLL infrastructure")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
To: saeedm@nvidia.com
To: leon@kernel.org
Cc: linux-rdma@vger.kernel.org
---
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 74f0c7867120..2cd81bb32c66 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -121,8 +121,8 @@ static int mlx5_dpll_device_lock_status_get(const struct dpll_device *dpll,
 }
 
 static int mlx5_dpll_device_mode_get(const struct dpll_device *dpll,
-				     void *priv,
-				     u32 *mode, struct netlink_ext_ack *extack)
+				     void *priv, enum dpll_mode *mode,
+				     struct netlink_ext_ack *extack)
 {
 	*mode = DPLL_MODE_MANUAL;
 	return 0;

-- 
2.42.0

