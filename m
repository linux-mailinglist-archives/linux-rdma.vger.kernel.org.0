Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2A3D6CC8
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhG0CvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:51:10 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12312 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhG0CvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:51:08 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GYhzd3CQJz7yKc;
        Tue, 27 Jul 2021 11:26:53 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:35 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:35 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 08/10] libhns: Add man pages to introduce DCA feature
Date:   Tue, 27 Jul 2021 11:27:58 +0800
Message-ID: <1627356480-41805-9-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Document hns DCA feature and related direct verbs.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 CMakeLists.txt                   | 1 +
 debian/ibverbs-providers.install | 2 +-
 debian/libibverbs-dev.install    | 2 ++
 redhat/rdma-core.spec            | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 743a109..da4b435 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -669,6 +669,7 @@ add_subdirectory(providers/cxgb4) # NO SPARSE
 add_subdirectory(providers/efa)
 add_subdirectory(providers/efa/man)
 add_subdirectory(providers/hns)
+add_subdirectory(providers/hns/man)
 add_subdirectory(providers/irdma)
 add_subdirectory(providers/mlx4)
 add_subdirectory(providers/mlx4/man)
diff --git a/debian/ibverbs-providers.install b/debian/ibverbs-providers.install
index c6ecbbc..c4c4c11 100644
--- a/debian/ibverbs-providers.install
+++ b/debian/ibverbs-providers.install
@@ -1,6 +1,6 @@
 etc/libibverbs.d/
 usr/lib/*/libefa.so.*
-usr/lib/*/libibverbs/lib*-rdmav*.so
 usr/lib/*/libhns.so.*
+usr/lib/*/libibverbs/lib*-rdmav*.so
 usr/lib/*/libmlx4.so.*
 usr/lib/*/libmlx5.so.*
diff --git a/debian/libibverbs-dev.install b/debian/libibverbs-dev.install
index 7d6e6a2..2c2feaf 100644
--- a/debian/libibverbs-dev.install
+++ b/debian/libibverbs-dev.install
@@ -29,11 +29,13 @@ usr/lib/*/pkgconfig/libibverbs.pc
 usr/lib/*/pkgconfig/libmlx4.pc
 usr/lib/*/pkgconfig/libmlx5.pc
 usr/share/man/man3/efadv_*.3
+usr/share/man/man3/hns*.3
 usr/share/man/man3/ibv_*
 usr/share/man/man3/mbps_to_ibv_rate.3
 usr/share/man/man3/mlx4dv_*.3
 usr/share/man/man3/mlx5dv_*.3
 usr/share/man/man3/mult_to_ibv_rate.3
 usr/share/man/man7/efadv.7
+usr/share/man/man7/hns*.7
 usr/share/man/man7/mlx4dv.7
 usr/share/man/man7/mlx5dv.7
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index 0d99e1c..9a24552 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -440,6 +440,7 @@ fi
 %{_libdir}/lib*.so
 %{_libdir}/pkgconfig/*.pc
 %{_mandir}/man3/efadv*
+%{_mandir}/man3/hns*
 %{_mandir}/man3/ibv_*
 %{_mandir}/man3/rdma*
 %{_mandir}/man3/umad*
@@ -448,6 +449,7 @@ fi
 %{_mandir}/man3/mlx5dv*
 %{_mandir}/man3/mlx4dv*
 %{_mandir}/man7/efadv*
+%{_mandir}/man7/hns*
 %{_mandir}/man7/mlx5dv*
 %{_mandir}/man7/mlx4dv*
 %{_mandir}/man3/ibnd_*
-- 
2.8.1

