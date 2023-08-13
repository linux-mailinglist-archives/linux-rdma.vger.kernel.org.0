Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C777A70C
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjHMOwE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMOwD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 10:52:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77F1702;
        Sun, 13 Aug 2023 07:52:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F290E1F8C3;
        Sun, 13 Aug 2023 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691938324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ECIEXm7J1bI39FHProgMerBnkUogZhcHV2A9rTxnnMI=;
        b=JY1aOg9158FlQwnYvCH7ZVhgTgGMqQRfcJsdKKddNx0TWIdRKxb6CYMaY+6kAxf+hEuT6i
        bDyipJ6iKu8Gdit7y+Ul9sak4/6gvd33j3CJkGL7hZ8Mk6rbaaQepisr5IzulNbaZRePb8
        nf4CL2NmJbpqyttAgsGvnAupCUGQdwE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA60C1322C;
        Sun, 13 Aug 2023 14:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QWm+LBPu2GSDFAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 13 Aug 2023 14:52:03 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH net-next v2 00/10] Convert mlx4 to use auxiliary bus
Date:   Sun, 13 Aug 2023 16:51:17 +0200
Message-Id: <20230813145127.10653-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series converts the mlx4 drivers to use auxiliary bus, similarly to
how mlx5 was converted [1]. The first 6 patches are preparatory changes,
the remaining 4 are the final conversion.

Initial motivation for this change was to address a problem related to
loading mlx4_en/mlx4_ib by mlx4_core using request_module_nowait(). When
doing such a load in initrd, the operation is asynchronous to any init
control and can get unexpectedly affected/interrupted by an eventual
root switch. Using an auxiliary bus leaves these module loads to udevd
which better integrates with systemd processing. [2]

General benefit is to get rid of custom interface logic and instead use
a common facility available for this task. An obvious risk is that some
new bug is introduced by the conversion.

Leon Romanovsky was kind enough to check for me that the series passes
their verification tests.

Changes since v1 [3]:
* Fix a missing definition of the err variable in mlx4_en_add().
* Remove not needed comments about the event type in mlx4_en_event()
  and mlx4_ib_event().

[1] https://lore.kernel.org/netdev/20201101201542.2027568-1-leon@kernel.org/
[2] https://lore.kernel.org/netdev/0a361ac2-c6bd-2b18-4841-b1b991f0635e@suse.com/
[3] https://lore.kernel.org/netdev/20230804150527.6117-1-petr.pavlu@suse.com/

Petr Pavlu (10):
  mlx4: Get rid of the mlx4_interface.get_dev callback
  mlx4: Rename member mlx4_en_dev.nb to netdev_nb
  mlx4: Replace the mlx4_interface.event callback with a notifier
  mlx4: Get rid of the mlx4_interface.activate callback
  mlx4: Move the bond work to the core driver
  mlx4: Avoid resetting MLX4_INTFF_BONDING per driver
  mlx4: Register mlx4 devices to an auxiliary virtual bus
  mlx4: Connect the ethernet part to the auxiliary bus
  mlx4: Connect the infiniband part to the auxiliary bus
  mlx4: Delete custom device management logic

 drivers/infiniband/hw/mlx4/main.c             | 207 ++++++----
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   2 +
 drivers/net/ethernet/mellanox/mlx4/Kconfig    |   1 +
 drivers/net/ethernet/mellanox/mlx4/en_main.c  | 141 ++++---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  64 +---
 drivers/net/ethernet/mellanox/mlx4/intf.c     | 361 ++++++++++++------
 drivers/net/ethernet/mellanox/mlx4/main.c     | 110 ++++--
 drivers/net/ethernet/mellanox/mlx4/mlx4.h     |  16 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 include/linux/mlx4/device.h                   |  20 +
 include/linux/mlx4/driver.h                   |  42 +-
 11 files changed, 572 insertions(+), 396 deletions(-)


base-commit: 2f4503f94c5d81d1589842bfb457be466c8c670b
-- 
2.35.3

