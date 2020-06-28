Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84520C892
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgF1Ou2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jun 2020 10:50:28 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48899 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgF1Ou2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Jun 2020 10:50:28 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from alaa@mellanox.com)
        with SMTP; 28 Jun 2020 17:50:22 +0300
Received: from dev-h-vrt-013.mth.labs.mlnx (dev-h-vrt-013.mth.labs.mlnx [10.194.13.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05SEoMFu028945;
        Sun, 28 Jun 2020 17:50:22 +0300
From:   Alaa Hleihel <alaa@mellanox.com>
To:     jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>,
        Honggang Li <honli@redhat.com>
Subject: [PATCH rdma-core] redhat: Fix the condition for pyverbs enablement on Fedora 32 and up
Date:   Sun, 28 Jun 2020 17:50:03 +0300
Message-Id: <20200628145003.13705-1-alaa@mellanox.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The cited commit enabled pyverbs build by default for Fedora 32 and up.
However, it broke enalbing pyverbs build when passing '--with pyverbs' flag.

Fix the condition so that now the behavior for Fedora 32 and up will be:
 * Default: pyverbs enabled.
 * --with pyverbs: pyverbs enabled.
 * --without pyverbs: pyverbs disabled.

Fixes: 07b304b75186 ("redhat: Build pyverbs for Fedora greater than release 31")
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Tested-by: Edward Srouji <edwards@mellanox.com>
CC: Honggang Li <honli@redhat.com>
---
 redhat/rdma-core.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index 7ff33b3ca8b8..76549e5cb61f 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -28,7 +28,7 @@ BuildRequires: valgrind-devel
 BuildRequires: systemd
 BuildRequires: systemd-devel
 %if 0%{?fedora} >= 32
-%define with_pyverbs %{?_with_pyverbs: 0} %{?!_with_pyverbs: 1}
+%define with_pyverbs %{?_with_pyverbs: 1} %{?!_with_pyverbs: %{?!_without_pyverbs: 1} %{?_without_pyverbs: 0}}
 %else
 %define with_pyverbs %{?_with_pyverbs: 1} %{?!_with_pyverbs: 0}
 %endif
-- 
2.26.2

