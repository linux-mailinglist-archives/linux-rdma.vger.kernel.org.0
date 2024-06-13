Return-Path: <linux-rdma+bounces-3115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39947906727
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 10:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23562B257B3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D113FD62;
	Thu, 13 Jun 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="J5RR+smA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD337522F
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267908; cv=none; b=IVm6TRue7QSCEm1OH92Kxmr75S+aD5bQXurMrtCDPYGViTz5HBV8WTxablXEQqJ8NXQo2Ar8vARdUhICINiBDpV5mb7/pUqQ9fx70gtLoFEHls67vlOyoqhvZqGVUjinpwsPa5CZTXk4wbRSOAixCWL4ZI1wjslyw3rH4XtP+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267908; c=relaxed/simple;
	bh=2cd3WU4jJBUpRq9fPbSfAEyjd+eCow4Da/es5L1GR68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBKoPS6BMkQqmq5h5NmbolzuA9bMPcCQgReaW9RIddCFluBawEOAd0EtvS7Tkj85G7DdK5D2GqsBm/vlOuvmvBNDcM4LlEPuUaldHH40rTXX1OLFVJ74dCvzxujn/2IJk8WYvxmaW/v2cgFwLBPi2+Zf5k73fAPYGfr3MFu9qDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=J5RR+smA; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718267902; bh=2cd3WU4jJBUpRq9fPbSfAEyjd+eCow4Da/es5L1GR68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5RR+smAanNphMPcYXei/Ptc5MADbEqSdKRbpnIIjsONC7hcUanD+NSAkD7GXyTAW
	 +puPumxbFVbo8AStVQtIjFPzrYraHkYozJBy4nygVgdLM/1Cw/mDRwk+keFPIuufb9
	 GipAFmQqri+CXFAb/8TcN8WoHaQNQX/ocJRbGuxoGebB48i04SjRFG9xFLeMiCSHRI
	 hNGkEoKi6tVOFUeRFlwR2joG1FTfx3KRWfSovT5qgQ+77iKauQxir4Uk14+sf2POAH
	 pKcfgeOpcekxZOk5zBFIJt8Ji43NrTxw7JJsmpWFSvxk+m1ZYNcDk8xJ/Rwk1dMCE+
	 //zDti6dY/RMw==
Received: from oshpigelman-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by oshpigelman-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45D8c2vZ1440923;
	Thu, 13 Jun 2024 11:38:03 +0300
From: Omer Shpigelman <oshpigelman@habana.ai>
To: linux-rdma@vger.kernel.org
Cc: ogabbay@kernel.org, oshpigelman@habana.ai, zyehudai@habana.ai
Subject: [PATCH 2/4] hbl: HabanaLabs RDMA provider
Date: Thu, 13 Jun 2024 11:38:00 +0300
Message-Id: <20240613083802.1440904-3-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613083802.1440904-1-oshpigelman@habana.ai>
References: <20240613083802.1440904-1-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a provider for exposing HBL device for user applications via
standard verbs interface and Direct Verbs (DV).

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Co-developed-by: David Meriin <dmeriin@habana.ai>
Signed-off-by: David Meriin <dmeriin@habana.ai>
Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
---
 CMakeLists.txt                               |    2 +
 MAINTAINERS                                  |    5 +
 README.md                                    |    1 +
 buildlib/check-build                         |    1 +
 debian/control                               |    3 +-
 debian/copyright                             |    5 +
 debian/ibverbs-providers.install             |    1 +
 debian/ibverbs-providers.lintian-overrides   |    4 +-
 debian/ibverbs-providers.symbols             |   16 +
 debian/libibverbs-dev.install                |    7 +
 debian/rules                                 |    2 +-
 libibverbs/verbs.h                           |    8 +-
 providers/hbl/CMakeLists.txt                 |   14 +
 providers/hbl/hbl-abi.h                      |   25 +
 providers/hbl/hbl.c                          |  225 ++++
 providers/hbl/hbl.h                          |  155 +++
 providers/hbl/hbldv.h                        |  433 +++++++
 providers/hbl/libhbl.map                     |   19 +
 providers/hbl/man/CMakeLists.txt             |   14 +
 providers/hbl/man/hbldv.7.md                 |   38 +
 providers/hbl/man/hbldv_create_cq.3.md       |   68 ++
 providers/hbl/man/hbldv_create_encap.3.md    |  116 ++
 providers/hbl/man/hbldv_create_usr_fifo.3.md |  121 ++
 providers/hbl/man/hbldv_is_supported.3.md    |   43 +
 providers/hbl/man/hbldv_modify_qp.3.md       |  102 ++
 providers/hbl/man/hbldv_open_device.3.md     |   59 +
 providers/hbl/man/hbldv_query_cq.3.md        |   84 ++
 providers/hbl/man/hbldv_query_device.3.md    |   61 +
 providers/hbl/man/hbldv_query_port.3.md      |  125 ++
 providers/hbl/man/hbldv_query_qp.3.md        |   63 +
 providers/hbl/man/hbldv_set_port_ex.3.md     |  106 ++
 providers/hbl/verbs.c                        | 1085 ++++++++++++++++++
 providers/hbl/verbs.h                        |   27 +
 redhat/rdma-core.spec                        |    6 +
 suse/rdma-core.spec                          |   21 +
 util/util.h                                  |   13 +
 36 files changed, 3071 insertions(+), 7 deletions(-)
 create mode 100644 providers/hbl/CMakeLists.txt
 create mode 100644 providers/hbl/hbl-abi.h
 create mode 100644 providers/hbl/hbl.c
 create mode 100644 providers/hbl/hbl.h
 create mode 100644 providers/hbl/hbldv.h
 create mode 100644 providers/hbl/libhbl.map
 create mode 100644 providers/hbl/man/CMakeLists.txt
 create mode 100644 providers/hbl/man/hbldv.7.md
 create mode 100644 providers/hbl/man/hbldv_create_cq.3.md
 create mode 100644 providers/hbl/man/hbldv_create_encap.3.md
 create mode 100644 providers/hbl/man/hbldv_create_usr_fifo.3.md
 create mode 100644 providers/hbl/man/hbldv_is_supported.3.md
 create mode 100644 providers/hbl/man/hbldv_modify_qp.3.md
 create mode 100644 providers/hbl/man/hbldv_open_device.3.md
 create mode 100644 providers/hbl/man/hbldv_query_cq.3.md
 create mode 100644 providers/hbl/man/hbldv_query_device.3.md
 create mode 100644 providers/hbl/man/hbldv_query_port.3.md
 create mode 100644 providers/hbl/man/hbldv_query_qp.3.md
 create mode 100644 providers/hbl/man/hbldv_set_port_ex.3.md
 create mode 100644 providers/hbl/verbs.c
 create mode 100644 providers/hbl/verbs.h

diff --git a/CMakeLists.txt b/CMakeLists.txt
index e70cfc06b..6b06a82aa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -716,6 +716,8 @@ add_subdirectory(providers/cxgb4) # NO SPARSE
 add_subdirectory(providers/efa)
 add_subdirectory(providers/efa/man)
 add_subdirectory(providers/erdma)
+add_subdirectory(providers/hbl)
+add_subdirectory(providers/hbl/man)
 add_subdirectory(providers/hns)
 add_subdirectory(providers/hns/man)
 add_subdirectory(providers/irdma)
diff --git a/MAINTAINERS b/MAINTAINERS
index 4b241171e..f078e1698 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -66,6 +66,11 @@ M:	Cheng Xu <chengyou@linux.alibaba.com>
 S:	Supported
 F:	providers/erdma/
 
+HBL USERSPACE PROVIDER (for hbl.ko)
+M:	Omer Shpigelman <oshpigelman@habana.ai>
+S:	Supported
+F:	providers/hbl/
+
 HF1 USERSPACE PROVIDER (for hf1.ko)
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
 S:	Supported
diff --git a/README.md b/README.md
index 928bdc4da..6260cbf94 100644
--- a/README.md
+++ b/README.md
@@ -18,6 +18,7 @@ is included:
  - efa.ko
  - erdma.ko
  - iw_cxgb4.ko
+ - hbl.ko
  - hfi1.ko
  - hns-roce.ko
  - irdma.ko
diff --git a/buildlib/check-build b/buildlib/check-build
index 8f8e84e56..f9881ca6b 100755
--- a/buildlib/check-build
+++ b/buildlib/check-build
@@ -269,6 +269,7 @@ allowed_uapi_headers = {
 
 non_cxx_headers = {
     "infiniband/arch.h",
+    "infiniband/hbl_user_ioctl_verbs.h",
     "infiniband/ib.h",
     "infiniband/ib_user_ioctl_verbs.h",
     "infiniband/ibnetdisc_osd.h",
diff --git a/debian/control b/debian/control
index b0a8c2767..64a616b10 100644
--- a/debian/control
+++ b/debian/control
@@ -60,7 +60,7 @@ Package: ibverbs-providers
 Architecture: linux-any
 Multi-Arch: same
 Depends: ${misc:Depends}, ${shlibs:Depends}
-Provides: libefa1, libipathverbs1, libmana1, libmlx4-1, libmlx5-1, libmthca1
+Provides: libefa1, libhbl1, libipathverbs1, libmana1, libmlx4-1, libmlx5-1, libmthca1
 Replaces: libipathverbs1 (<< 15),
           libmlx4-1 (<< 15),
           libmlx5-1 (<< 15),
@@ -86,6 +86,7 @@ Description: User space provider drivers for libibverbs
   - cxgb4: Chelsio T4 iWARP HCAs
   - efa: Amazon Elastic Fabric Adapter
   - erdma: Alibaba Elastic RDMA (iWarp) Adapter
+  - hbl: HabanaLabs InfiniBand device
   - hfi1verbs: Intel Omni-Path HFI
   - hns: HiSilicon Hip06 SoC
   - ipathverbs: QLogic InfiniPath HCAs
diff --git a/debian/copyright b/debian/copyright
index f4e1b8b4a..f8e2d6be9 100644
--- a/debian/copyright
+++ b/debian/copyright
@@ -161,6 +161,11 @@ Files: providers/erdma/*
 Copyright: 2020-2021, Alibaba Group
 License: BSD-MIT or GPL-2
 
+Files: providers/hbl/*
+Copyright: 2022-2024 HabanaLabs, Ltd.
+           2023-2024 Intel Corporation.
+License: BSD-MIT or GPL-2
+
 Files: providers/hfi1verbs/*
 Copyright: 2005 PathScale, Inc.
            2006-2009 QLogic Corporation
diff --git a/debian/ibverbs-providers.install b/debian/ibverbs-providers.install
index fea15e0fc..b32e58903 100644
--- a/debian/ibverbs-providers.install
+++ b/debian/ibverbs-providers.install
@@ -1,5 +1,6 @@
 etc/libibverbs.d/
 usr/lib/*/libefa.so.*
+usr/lib/*/libhbl.so.*
 usr/lib/*/libibverbs/lib*-rdmav*.so
 usr/lib/*/libhns.so.*
 usr/lib/*/libmana.so.*
diff --git a/debian/ibverbs-providers.lintian-overrides b/debian/ibverbs-providers.lintian-overrides
index 763858dac..ef24ed811 100644
--- a/debian/ibverbs-providers.lintian-overrides
+++ b/debian/ibverbs-providers.lintian-overrides
@@ -1,2 +1,2 @@
-# libefa, libhns, libmana, libmlx4 and libmlx5 are ibverbs provider that provides more functions.
-ibverbs-providers: package-name-doesnt-match-sonames libefa1 libhns1 libmana1 libmlx4-1 libmlx5-1
+# libefa, libhbl, libhns, libmana, libmlx4 and libmlx5 are ibverbs provider that provides more functions.
+ibverbs-providers: package-name-doesnt-match-sonames libefa1 libhbl1 libhns1 libmana1 libmlx4-1 libmlx5-1
diff --git a/debian/ibverbs-providers.symbols b/debian/ibverbs-providers.symbols
index d2c09890d..509f8b3a8 100644
--- a/debian/ibverbs-providers.symbols
+++ b/debian/ibverbs-providers.symbols
@@ -185,3 +185,19 @@ libmana.so.1 ibverbs-providers #MINVER#
  MANA_1.0@MANA_1.0 41
  manadv_init_obj@MANA_1.0 41
  manadv_set_context_attr@MANA_1.0 41
+libhbl.so.1 ibverbs-providers #MINVER#
+* Build-Depends-Package: libibverbs-dev
+ HBL_1.0@HBL_1.0 53
+ hbldv_create_cq@HBL_1.0 53
+ hbldv_create_encap@HBL_1.0 53
+ hbldv_create_usr_fifo@HBL_1.0 53
+ hbldv_destroy_encap@HBL_1.0 53
+ hbldv_destroy_usr_fifo@HBL_1.0 53
+ hbldv_is_supported@HBL_1.0 53
+ hbldv_modify_qp@HBL_1.0 53
+ hbldv_open_device@HBL_1.0 53
+ hbldv_query_cq@HBL_1.0 53
+ hbldv_query_device@HBL_1.0 53
+ hbldv_query_port@HBL_1.0 53
+ hbldv_query_qp@HBL_1.0 53
+ hbldv_set_port_ex@HBL_1.0 53
diff --git a/debian/libibverbs-dev.install b/debian/libibverbs-dev.install
index c90b2b653..8c1942c02 100644
--- a/debian/libibverbs-dev.install
+++ b/debian/libibverbs-dev.install
@@ -1,5 +1,7 @@
 usr/include/infiniband/arch.h
 usr/include/infiniband/efadv.h
+usr/include/infiniband/hbldv.h
+usr/include/infiniband/hbl_user_ioctl_verbs.h
 usr/include/infiniband/hnsdv.h
 usr/include/infiniband/ib_user_ioctl_verbs.h
 usr/include/infiniband/manadv.h
@@ -16,6 +18,8 @@ usr/include/infiniband/verbs_api.h
 usr/lib/*/lib*-rdmav*.a
 usr/lib/*/libefa.a
 usr/lib/*/libefa.so
+usr/lib/*/libhbl.a
+usr/lib/*/libhbl.so
 usr/lib/*/libhns.a
 usr/lib/*/libhns.so
 usr/lib/*/libibverbs*.so
@@ -27,12 +31,14 @@ usr/lib/*/libmlx4.so
 usr/lib/*/libmlx5.a
 usr/lib/*/libmlx5.so
 usr/lib/*/pkgconfig/libefa.pc
+usr/lib/*/pkgconfig/libhbl.pc
 usr/lib/*/pkgconfig/libhns.pc
 usr/lib/*/pkgconfig/libibverbs.pc
 usr/lib/*/pkgconfig/libmana.pc
 usr/lib/*/pkgconfig/libmlx4.pc
 usr/lib/*/pkgconfig/libmlx5.pc
 usr/share/man/man3/efadv_*.3
+usr/share/man/man3/hbldv_*.3
 usr/share/man/man3/hnsdv_*.3
 usr/share/man/man3/ibv_*
 usr/share/man/man3/mbps_to_ibv_rate.3
@@ -41,6 +47,7 @@ usr/share/man/man3/mlx4dv_*.3
 usr/share/man/man3/mlx5dv_*.3
 usr/share/man/man3/mult_to_ibv_rate.3
 usr/share/man/man7/efadv.7
+usr/share/man/man7/hbldv.7
 usr/share/man/man7/hnsdv.7
 usr/share/man/man7/manadv.7
 usr/share/man/man7/mlx4dv.7
diff --git a/debian/rules b/debian/rules
index 34b392150..65d679517 100755
--- a/debian/rules
+++ b/debian/rules
@@ -62,7 +62,7 @@ ifeq (,$(filter-out $(NON_COHERENT_DMA_ARCHS),$(DEB_HOST_ARCH)))
 	for package in ibverbs-providers libibverbs-dev rdma-core; do \
 		test -e debian/$$package.install.backup || cp debian/$$package.install debian/$$package.install.backup; \
 	done
-	sed -i '/efa\|mana\|mlx[45]/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
+	sed -i '/efa\|hbl\|mana\|mlx[45]/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
 endif
 	DESTDIR=$(CURDIR)/debian/tmp ninja -C build-deb install
 
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index cec005519..9c3fa1e0a 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2244,7 +2244,7 @@ struct ibv_device **ibv_get_device_list(int *num_devices);
  */
 #ifdef RDMA_STATIC_PROVIDERS
 #define _RDMA_STATIC_PREFIX_(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11,     \
-			     _12, _13, _14, _15, _16, _17, _18, _19, ...)      \
+			     _12, _13, _14, _15, _16, _17, _18, _19, _20 ...)  \
 	&verbs_provider_##_1, &verbs_provider_##_2, &verbs_provider_##_3,      \
 		&verbs_provider_##_4, &verbs_provider_##_5,                    \
 		&verbs_provider_##_6, &verbs_provider_##_7,                    \
@@ -2253,17 +2253,19 @@ struct ibv_device **ibv_get_device_list(int *num_devices);
 		&verbs_provider_##_12, &verbs_provider_##_13,                  \
 		&verbs_provider_##_14, &verbs_provider_##_15,                  \
 		&verbs_provider_##_16, &verbs_provider_##_17,                  \
-		&verbs_provider_##_18, &verbs_provider_##_19
+		&verbs_provider_##_18, &verbs_provider_##_19,                  \
+		&verbs_provider_##_20
 #define _RDMA_STATIC_PREFIX(arg)                                               \
 	_RDMA_STATIC_PREFIX_(arg, none, none, none, none, none, none, none,    \
 			     none, none, none, none, none, none, none, none,   \
-			     none, none, none)
+			     none, none, none, none)
 
 struct verbs_devices_ops;
 extern const struct verbs_device_ops verbs_provider_bnxt_re;
 extern const struct verbs_device_ops verbs_provider_cxgb4;
 extern const struct verbs_device_ops verbs_provider_efa;
 extern const struct verbs_device_ops verbs_provider_erdma;
+extern const struct verbs_device_ops verbs_provider_hbl;
 extern const struct verbs_device_ops verbs_provider_hfi1verbs;
 extern const struct verbs_device_ops verbs_provider_hns;
 extern const struct verbs_device_ops verbs_provider_ipathverbs;
diff --git a/providers/hbl/CMakeLists.txt b/providers/hbl/CMakeLists.txt
new file mode 100644
index 000000000..18bb90485
--- /dev/null
+++ b/providers/hbl/CMakeLists.txt
@@ -0,0 +1,14 @@
+rdma_shared_provider(hbl libhbl.map
+	1 1.0.${PACKAGE_VERSION}
+	hbl.c
+	verbs.c
+)
+
+publish_headers(infiniband
+	../../kernel-headers/rdma/hbl_user_ioctl_verbs.h
+	hbldv.h
+)
+
+SET (CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-rpath,'$ORIGIN'")
+
+rdma_pkg_config("hbl" "libibverbs" "${CMAKE_THREAD_LIBS_INIT}")
diff --git a/providers/hbl/hbl-abi.h b/providers/hbl/hbl-abi.h
new file mode 100644
index 000000000..9fcc511d8
--- /dev/null
+++ b/providers/hbl/hbl-abi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#ifndef HBL_IB_ABI_H
+#define HBL_IB_ABI_H
+
+#include <infiniband/kern-abi.h>
+#include <kernel-abi/hbl-abi.h>
+#include <rdma/hbl-abi.h>
+
+#define HBL_IB_ABI_VERSION 1
+
+DECLARE_DRV_CMD(hbl_alloc_ucontext, IB_USER_VERBS_CMD_GET_CONTEXT, hbl_ibv_alloc_ucontext_req,
+		hbl_ibv_alloc_ucontext_resp);
+DECLARE_DRV_CMD(hbl_alloc_pd, IB_USER_VERBS_CMD_ALLOC_PD, empty, hbl_ibv_alloc_pd_resp);
+DECLARE_DRV_CMD(hbl_modify_qp, IB_USER_VERBS_EX_CMD_MODIFY_QP,
+		hbl_ibv_modify_qp_req, hbl_ibv_modify_qp_resp);
+DECLARE_DRV_CMD(hbl_create_cq, IB_USER_VERBS_CMD_CREATE_CQ, hbl_ibv_create_cq_req,
+		hbl_ibv_create_cq_resp);
+
+#endif /* HBL_IB_ABI_H */
diff --git a/providers/hbl/hbl.c b/providers/hbl/hbl.c
new file mode 100644
index 000000000..5c0dd4d8d
--- /dev/null
+++ b/providers/hbl/hbl.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#include "hbl.h"
+#include "hbldv.h"
+#include "verbs.h"
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+static struct hbl_context *hbl_ctx;
+
+static const struct verbs_match_ent hbl_table[] = {
+	VERBS_DRIVER_ID(RDMA_DRIVER_HBL),
+	VERBS_NAME_MATCH("hbl", NULL),
+	{}
+};
+
+static void hbl_free_context(struct ibv_context *ibctx);
+static int hbl_query_device_ex(struct ibv_context *context,
+			       const struct ibv_query_device_ex_input *input,
+			       struct ibv_device_attr_ex *attr, size_t attr_size);
+static int hbl_query_port(struct ibv_context *ibctx, uint8_t port,
+			  struct ibv_port_attr *port_attr);
+
+static const struct verbs_context_ops hbl_ctx_ops = {
+	.alloc_pd = hbl_alloc_pd,
+	.dealloc_pd = hbl_dealloc_pd,
+	.free_context = hbl_free_context,
+	.query_device_ex = hbl_query_device_ex,
+	.query_port = hbl_query_port,
+	.create_qp = hbl_create_qp,
+	.create_qp_ex = hbl_create_qp_ex,
+	.destroy_qp = hbl_destroy_qp,
+	.modify_qp = hbl_modify_qp,
+	.create_cq = hbl_create_cq,
+	.destroy_cq = hbl_destroy_cq,
+	.query_qp = hbl_query_qp,
+	.async_event = hbl_async_event,
+};
+
+static int hbl_query_port(struct ibv_context *ibctx, uint8_t port,
+			  struct ibv_port_attr *port_attr)
+{
+	struct ibv_query_port cmd;
+
+	return ibv_cmd_query_port(ibctx, port, port_attr, &cmd, sizeof(cmd));
+}
+
+static struct verbs_context *hbl_alloc_context(struct ibv_device *ibdev, int cmd_fd,
+					       void *private_data)
+{
+	struct hbldv_ucontext_attr *attr = private_data;
+	struct hbl_alloc_ucontext_resp resp = {};
+	struct hbl_alloc_ucontext cmd = {};
+	struct verbs_context *vctx;
+	struct hbl_context *ctx;
+	int rc, core_fd = 0;
+
+	/* Only one customized context is allowed, i.e. DV context with non default value.
+	 * For subsequent allocations of default contexts (DV context with default value or non DV
+	 * context), return the same context and increment ref count.
+	 */
+	if (hbl_ctx && hbl_ctx->is_default_ctx && !attr) {
+		__sync_fetch_and_add(&hbl_ctx->ref_cnt, 1);
+		return &hbl_ctx->ibv_ctx;
+	}
+
+	ctx = verbs_init_and_alloc_context(ibdev, cmd_fd, ctx, ibv_ctx, RDMA_DRIVER_HBL);
+	if (!ctx)
+		return NULL;
+
+	vctx = &ctx->ibv_ctx;
+
+	if (attr) {
+		cmd.ports_mask = attr->ports_mask;
+		cmd.core_fd = attr->core_fd;
+		cmd.use_dvs = true;
+
+		ctx->core_fd = INT_MAX;
+	} else {
+		int core_dev_idx;
+		char path[NAME_MAX] = {};
+
+		if (sscanf(ibdev->name, "hbl_%d", &core_dev_idx) != 1) {
+			verbs_err(vctx, "failed to get core device index from %s\n", ibdev->name);
+			goto uninit_ctx;
+		}
+
+		snprintf(path, NAME_MAX, "/dev/accel/accel%d", core_dev_idx);
+
+		core_fd = open(path, O_RDWR | O_CLOEXEC, 0);
+		if (core_fd < 0) {
+			rc = errno;
+			verbs_err(vctx, "failed to open core FD, err %d\n", rc);
+			goto uninit_ctx;
+		}
+
+		cmd.core_fd = core_fd;
+		cmd.ports_mask = 0;
+
+		ctx->core_fd = core_fd;
+		ctx->is_default_ctx = true;
+	}
+
+	rc = ibv_cmd_get_context(vctx, &cmd.ibv_cmd, sizeof(cmd), &resp.ibv_resp, sizeof(resp));
+	if (rc) {
+		verbs_err(vctx, "get_context failed, rc %d\n", rc);
+		goto close_core_fd;
+	}
+
+	ctx->ports_mask = resp.ports_mask;
+	ctx->cap_mask = resp.cap_mask;
+
+	verbs_set_ops(vctx, &hbl_ctx_ops);
+
+	verbs_debug(vctx, "Allocated an IB context, ports mask 0x%lx\n", ctx->ports_mask);
+
+	ctx->ref_cnt = 1;
+	hbl_ctx = ctx;
+
+	return vctx;
+
+close_core_fd:
+	if (!attr)
+		close(core_fd);
+uninit_ctx:
+	verbs_uninit_context(&ctx->ibv_ctx);
+	free(ctx);
+	return NULL;
+}
+
+static void hbl_free_context(struct ibv_context *ibctx)
+{
+	struct hbl_context *context = to_hbl_ctx(ibctx);
+
+	if (__sync_sub_and_fetch(&context->ref_cnt, 1))
+		return;
+
+	verbs_uninit_context(&context->ibv_ctx);
+
+	if (context->core_fd != INT_MAX)
+		close(context->core_fd);
+
+	verbs_debug(verbs_get_ctx(ibctx), "IB context was freed\n");
+
+	free(context);
+	hbl_ctx = NULL;
+}
+
+int hbl_query_device_ex(struct ibv_context *context, const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size)
+{
+	struct verbs_context *vctx = verbs_get_ctx(context);
+	int err;
+
+	err = ibv_cmd_query_device_any(context, input, attr, attr_size, NULL, NULL);
+	if (err) {
+		verbs_err(vctx, "ibv_cmd_query_device_any failed\n");
+		return err;
+	}
+
+	verbs_debug(vctx, "Queried device\n");
+
+	return 0;
+}
+
+static struct verbs_device *hbl_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
+{
+	struct hbl_dev *dev;
+
+	dev = calloc(1, sizeof(*dev));
+	if (!dev)
+		return NULL;
+
+	return &dev->vdev;
+}
+
+static void hbl_uninit_device(struct verbs_device *verbs_device)
+{
+	struct hbl_dev *dev = to_hbl_dev(&verbs_device->device);
+
+	free(dev);
+}
+
+static const struct verbs_device_ops hbl_dev_ops = {
+	.name = "hbl",
+	.match_min_abi_version = HBL_IB_ABI_VERSION,
+	.match_max_abi_version = HBL_IB_ABI_VERSION,
+	.match_table = hbl_table,
+	.alloc_device = hbl_device_alloc,
+	.uninit_device = hbl_uninit_device,
+	.alloc_context = hbl_alloc_context,
+};
+
+bool is_hbl_dev(struct ibv_device *device)
+{
+	struct verbs_device *verbs_device = verbs_get_device(device);
+
+	return verbs_device->ops == &hbl_dev_ops;
+}
+
+struct ibv_context *hbldv_open_device(struct ibv_device *device, struct hbldv_ucontext_attr *attr)
+{
+	if (!is_hbl_dev(device)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return verbs_open_device(device, attr);
+}
+
+bool hbldv_is_supported(struct ibv_device *device)
+{
+	return is_hbl_dev(device);
+}
+
+PROVIDER_DRIVER(hbl, hbl_dev_ops);
diff --git a/providers/hbl/hbl.h b/providers/hbl/hbl.h
new file mode 100644
index 000000000..d079ce3fc
--- /dev/null
+++ b/providers/hbl/hbl.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#ifndef __HBL_H__
+#define __HBL_H__
+
+#include <infiniband/driver.h>
+
+#include "hbl-abi.h"
+#include "hbldv.h"
+
+/**
+ * struct hbl_dev - HBL device.
+ * @vdev: Verbs device.
+ */
+struct hbl_dev {
+	struct verbs_device vdev;
+};
+
+/**
+ * struct hbl_context - HBL context.
+ * @ibv_ctx: Verbs context.
+ * @ports_mask: Mask of ports associated with this context.
+ * @cap_mask: Capabilities mask.
+ * @ref_cnt: number of refcounts of the context.
+ * @core_fd: File descriptor of the core device.
+ * @is_default_ctx: was the context created with default values.
+ */
+struct hbl_context {
+	struct verbs_context ibv_ctx;
+	uint64_t ports_mask;
+	uint64_t cap_mask;
+	uint32_t ref_cnt;
+	int core_fd;
+	uint8_t is_default_ctx;
+};
+
+/**
+ * struct hbl_pd - HBL PD.
+ * @ibvpd: IBV PD.
+ * @pdn: PD number.
+ */
+struct hbl_pd {
+	struct ibv_pd ibvpd;
+	uint32_t pdn;
+};
+
+/**
+ * struct hbl_qp - HBL QP.
+ * @vqp: Verbs QP.
+ * @swq_cpu_addr: Send WQ mmap address.
+ * @rwq_cpu_addr: Receive WQ mmap address.
+ * @swq_mem_handle: Send WQ mmap handle.
+ * @rwq_mem_handle: Receive WQ mmap handle.
+ * @swq_mem_size: Send WQ mmap size.
+ * @rwq_mem_size: Receive WQ mmap size.
+ * @max_send_wr: Max number of send WQEs.
+ * @max_recv_wr: Max number of receive WQEs.
+ * @qp_num: HBL QP ID.
+ */
+struct hbl_qp {
+	struct verbs_qp vqp;
+	void *swq_cpu_addr;
+	void *rwq_cpu_addr;
+	uint64_t swq_mem_handle;
+	uint64_t rwq_mem_handle;
+	uint32_t swq_mem_size;
+	uint32_t rwq_mem_size;
+	uint32_t max_send_wr;
+	uint32_t max_recv_wr;
+	uint32_t qp_num;
+};
+
+/**
+ * struct hbl_cq - HBL CQ
+ * @ibvcq: Verbs CQ.
+ * @mem_cpu_addr: CQ buffer address.
+ * @pi_cpu_addr: CQ PI memory address.
+ * @regs_cpu_addr: CQ UMR address.
+ * @cq_size: Size of the CQ.
+ * @cq_num: CQ id that is allocated.
+ * @regs_offset: CQ UMR reg offset.
+ * @is_native: to identify if CQ is created via ibv_create_cq().
+ * @cq_type: Type of CQ resource.
+ * @port_cq: pointer to array of CQ for all available ports.
+ */
+struct hbl_cq {
+	struct ibv_cq ibvcq;
+	void *mem_cpu_addr;
+	void *pi_cpu_addr;
+	void *regs_cpu_addr;
+	uint32_t cq_size;
+	uint32_t cq_num;
+	uint32_t regs_offset;
+	uint8_t is_native;
+	enum hbldv_cq_type cq_type;
+	struct hbl_cq *port_cq;
+};
+
+/**
+ * struct hbl_usr_fifo_obj - HBL user FIFO object.
+ * @dv_usr_fifo: DV user FIFO data.
+ * @context: IBV context.
+ * @handle: User fifo IDR handle.
+ */
+struct hbl_usr_fifo_obj {
+	struct hbldv_usr_fifo dv_usr_fifo;
+	struct ibv_context *context;
+	uint32_t handle;
+};
+
+/**
+ * struct hbl_encap - HBL encapsulation data.
+ * @dv_encap: HBL DV encapsulation data.
+ * @context: IBV context.
+ * @handle: Encap IDR handle.
+ */
+struct hbl_encap {
+	struct hbldv_encap dv_encap;
+	struct ibv_context *context;
+	uint32_t handle;
+};
+
+bool is_hbl_dev(struct ibv_device *device);
+
+static inline struct hbl_dev *to_hbl_dev(struct ibv_device *ibvdev)
+{
+	return container_of(ibvdev, struct hbl_dev, vdev.device);
+}
+
+static inline struct hbl_context *to_hbl_ctx(struct ibv_context *ibctx)
+{
+	return container_of(ibctx, struct hbl_context, ibv_ctx.context);
+}
+
+static inline struct hbl_pd *to_hbl_pd(struct ibv_pd *ibvpd)
+{
+	return container_of(ibvpd, struct hbl_pd, ibvpd);
+}
+
+static inline struct hbl_qp *to_hbl_qp(struct verbs_qp *vqp)
+{
+	return container_of(vqp, struct hbl_qp, vqp);
+}
+
+static inline struct hbl_cq *to_hbl_cq(struct ibv_cq *ibvcq)
+{
+	return container_of(ibvcq, struct hbl_cq, ibvcq);
+}
+
+#endif /* __HBL_H__ */
diff --git a/providers/hbl/hbldv.h b/providers/hbl/hbldv.h
new file mode 100644
index 000000000..285bffac3
--- /dev/null
+++ b/providers/hbl/hbldv.h
@@ -0,0 +1,433 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#ifndef __HBLDV_H__
+#define __HBLDV_H__
+
+#include <stdbool.h>
+#include <infiniband/verbs.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* Number of backpressure offsets */
+#define HBLDV_USER_BP_OFFS_MAX			16
+
+#define HBLDV_PORT_EX_ATTR_RESERVED0_NUM	2
+
+#define HBL_IB_MTU_8192				6
+
+/**
+ * struct hbldv_qp_caps - HBL QP capabilities flags.
+ * @HBLDV_QP_CAP_LOOPBACK: Enable QP loopback.
+ * @HBLDV_QP_CAP_CONG_CTRL: Enable congestion control.
+ * @HBLDV_QP_CAP_COMPRESSION: Enable compression.
+ * @HBLDV_QP_CAP_ENCAP: Enable packet encapsulation.
+ */
+enum hbldv_qp_caps {
+	HBLDV_QP_CAP_LOOPBACK = 0x1,
+	HBLDV_QP_CAP_CONG_CTRL = 0x2,
+	HBLDV_QP_CAP_COMPRESSION = 0x4,
+	HBLDV_QP_CAP_RESERVED0 = 0x8,
+	HBLDV_QP_CAP_ENCAP = 0x10,
+	HBLDV_QP_CAP_RESERVED1 = 0x20,
+};
+
+/**
+ * struct hbldv_port_ex_caps - HBL port extended capabilities flags.
+ * @HBLDV_PORT_CAP_ADVANCED: Enable port advanced features like RDV, QMan, WTD, etc.
+ * @HBLDV_PORT_CAP_ADAPTIVE_TIMEOUT: Enable adaptive timeout feature on this port.
+ */
+enum hbldv_port_ex_caps {
+	HBLDV_PORT_CAP_ADVANCED = 0x1,
+	HBLDV_PORT_CAP_ADAPTIVE_TIMEOUT = 0x2,
+};
+
+/**
+ * enum hbldv_mem_id - Memory allocation methods.
+ * @HBLDV_MEM_HOST: Memory allocated on the host.
+ * @HBLDV_MEM_DEVICE: Memory allocated on the device.
+ */
+enum hbldv_mem_id {
+	HBLDV_MEM_HOST = 1,
+	HBLDV_MEM_DEVICE
+};
+
+/**
+ * enum hbldv_wq_array_type - WQ-array type.
+ * @HBLDV_WQ_ARRAY_TYPE_GENERIC: WQ-array for generic QPs.
+ * @HBLDV_WQ_ARRAY_TYPE_MAX: Max number of values in this enum.
+ */
+enum hbldv_wq_array_type {
+	HBLDV_WQ_ARRAY_TYPE_GENERIC,
+	HBLDV_WQ_ARRAY_TYPE_RESERVED1,
+	HBLDV_WQ_ARRAY_TYPE_RESERVED2,
+	HBLDV_WQ_ARRAY_TYPE_RESERVED3,
+	HBLDV_WQ_ARRAY_TYPE_RESERVED4,
+	HBLDV_WQ_ARRAY_TYPE_MAX = 5,
+};
+
+/**
+ * enum hbldv_swq_granularity - send WQE granularity.
+ * @HBLDV_SWQE_GRAN_32B: 32 byte WQE for linear write.
+ * @HBLDV_SWQE_GRAN_64B: 64 byte WQE for multi-stride write.
+ */
+enum hbldv_swq_granularity {
+	HBLDV_SWQE_GRAN_32B,
+	HBLDV_SWQE_GRAN_64B
+};
+
+/**
+ * enum hbldv_usr_fifo_type - NIC users FIFO modes of operation.
+ * @HBLDV_USR_FIFO_TYPE_DB: Mode for direct user door-bell submit.
+ * @HBLDV_USR_FIFO_TYPE_CC: Mode for congestion control.
+ */
+enum hbldv_usr_fifo_type {
+	HBLDV_USR_FIFO_TYPE_DB = 0,
+	HBLDV_USR_FIFO_TYPE_CC,
+};
+
+/**
+ * enum hbldv_qp_wq_types - QP WQ types.
+ * @HBLDV_WQ_WRITE: WRITE or "native" SEND operations are allowed on this QP.
+ *                  NOTE: the latter is currently unsupported.
+ * @HBLDV_WQ_RECV_RDV: RECEIVE-RDV or WRITE operations are allowed on this QP.
+ *                     NOTE: posting all operations at the same time is unsupported.
+ * @HBLDV_WQ_READ_RDV: READ-RDV or WRITE operations are allowed on this QP.
+ *                     NOTE: posting all operations at the same time is unsupported.
+ * @HBLDV_WQ_SEND_RDV: SEND-RDV operation is allowed on this QP.
+ * @HBLDV_WQ_READ_RDV_ENDP: No operation is allowed on this endpoint QP.
+ */
+enum hbldv_qp_wq_types {
+	HBLDV_WQ_WRITE = 0x1,
+	HBLDV_WQ_RECV_RDV = 0x2,
+	HBLDV_WQ_READ_RDV = 0x4,
+	HBLDV_WQ_SEND_RDV = 0x8,
+	HBLDV_WQ_READ_RDV_ENDP = 0x10,
+};
+
+/**
+ * enum hbldv_cq_type - CQ types, used during allocation of CQs.
+ * @HBLDV_CQ_TYPE_QP: Standard CQ used for completion of a operation for a QP.
+ * @HBLDV_CQ_TYPE_CC: Congestion control CQ.
+ */
+enum hbldv_cq_type {
+	HBLDV_CQ_TYPE_QP = 0,
+	HBLDV_CQ_TYPE_CC,
+};
+
+/**
+ * enum hbldv_encap_type - Supported encapsulation types.
+ * @HBLDV_ENCAP_TYPE_NO_ENC: No Tunneling.
+ * @HBLDV_ENCAP_TYPE_ENC_OVER_IPV4: Tunnel RDMA packets through L3 layer.
+ * @HBLDV_ENCAP_TYPE_ENC_OVER_UDP: Tunnel RDMA packets through L4 layer.
+ */
+enum hbldv_encap_type {
+	HBLDV_ENCAP_TYPE_NO_ENC = 0,
+	HBLDV_ENCAP_TYPE_ENC_OVER_IPV4,
+	HBLDV_ENCAP_TYPE_ENC_OVER_UDP,
+};
+
+/**
+ * enum hbldv_device_attr_caps - Device specific attributes.
+ * @HBLDV_DEVICE_ATTR_CAP_CC: Congestion control.
+ */
+enum hbldv_device_attr_caps {
+	HBLDV_DEVICE_ATTR_CAP_CC = 1 << 0,
+};
+
+/**
+ * struct hbldv_ucontext_attr - HBL user context attributes.
+ * @ports_mask: Mask of the relevant ports for this context (should be 1-based).
+ * @core_fd: Core device file descriptor.
+ */
+struct hbldv_ucontext_attr {
+	uint64_t ports_mask;
+	int core_fd;
+};
+
+/**
+ * struct hbldv_wq_array_attr - WQ-array attributes.
+ * @max_num_of_wqs: Max number of WQs (QPs) to be used.
+ * @max_num_of_wqes_in_wq: Max number of WQ elements in each WQ.
+ * @mem_id: Memory allocation method.
+ * @swq_granularity: Send WQE size.
+ */
+struct hbldv_wq_array_attr {
+	uint32_t max_num_of_wqs;
+	uint32_t max_num_of_wqes_in_wq;
+	enum hbldv_mem_id mem_id;
+	enum hbldv_swq_granularity swq_granularity;
+};
+
+/**
+ * struct hbldv_port_ex_attr - HBL port extended attributes.
+ * @wq_arr_attr: Array of WQ-array attributes for each WQ-array type.
+ * @caps: Port capabilities bit-mask from hbldv_port_ex_caps.
+ * @qp_wq_bp_offs: Offsets in NIC memory to signal a back pressure.
+ * @port_num: Port ID (should be 1-based).
+ */
+struct hbldv_port_ex_attr {
+	struct hbldv_wq_array_attr wq_arr_attr[HBLDV_WQ_ARRAY_TYPE_MAX];
+	uint64_t caps;
+	uint32_t qp_wq_bp_offs[HBLDV_USER_BP_OFFS_MAX];
+	uint32_t reserved0[HBLDV_PORT_EX_ATTR_RESERVED0_NUM];
+	uint32_t port_num;
+	uint8_t reserved1;
+};
+
+/**
+ * struct hbldv_query_port_attr - HBL query port specific parameters.
+ * @max_num_of_qps: Number of QPs that are supported by the driver. User must allocate enough room
+ *		    for his work-queues according to this number.
+ * @num_allocated_qps: Number of QPs that were already allocated (in use).
+ * @max_allocated_qp_num: The highest index of the allocated QPs (i.e. this is where the driver may
+ *                        allocate its next QP).
+ * @max_cq_size: Maximum size of a CQ buffer.
+ * @advanced: true if advanced features are supported.
+ * @max_num_of_cqs: Maximum number of CQs.
+ * @max_num_of_usr_fifos: Maximum number of user FIFOs.
+ * @max_num_of_encaps: Maximum number of encapsulations.
+ * @nic_macro_idx: macro index of this specific port.
+ * @nic_phys_port_idx: physical port index (AKA lane) of this specific port.
+ */
+struct hbldv_query_port_attr {
+	uint32_t max_num_of_qps;
+	uint32_t num_allocated_qps;
+	uint32_t max_allocated_qp_num;
+	uint32_t max_cq_size;
+	uint32_t reserved0;
+	uint32_t reserved1;
+	uint32_t reserved2;
+	uint32_t reserved3;
+	uint32_t reserved4;
+	uint8_t advanced;
+	uint8_t max_num_of_cqs;
+	uint8_t max_num_of_usr_fifos;
+	uint8_t max_num_of_encaps;
+	uint8_t nic_macro_idx;
+	uint8_t nic_phys_port_idx;
+};
+
+/**
+ * struct hbldv_qp_attr - HBL QP attributes.
+ * @caps: QP capabilities bit-mask from hbldv_qp_caps.
+ * @local_key: Unique key for local memory access. Needed for RTR state.
+ * @remote_key: Unique key for remote memory access. Needed for RTS state.
+ * @congestion_wnd: Congestion-Window size. Needed for RTS state.
+ * @dest_wq_size: Number of WQEs on the destination. Needed for RDV RTS state.
+ * @wq_type: WQ type. e.g. write, rdv etc. Needed for INIT state.
+ * @wq_granularity: WQ granularity [0 for 32B or 1 for 64B]. Needed for INIT state.
+ * @priority: QoS priority. Needed for RTR and RTS state.
+ * @encap_num: Encapsulation ID. Needed for RTS and RTS state.
+ */
+struct hbldv_qp_attr {
+	uint64_t caps;
+	uint32_t local_key;
+	uint32_t remote_key;
+	uint32_t congestion_wnd;
+	uint32_t reserved0;
+	uint32_t dest_wq_size;
+	enum hbldv_qp_wq_types wq_type;
+	enum hbldv_swq_granularity wq_granularity;
+	uint8_t priority;
+	uint8_t reserved1;
+	uint8_t reserved2;
+	uint8_t encap_num;
+	uint8_t reserved3;
+};
+
+/**
+ * struct hbldv_query_qp_attr - Queried HBL QP data.
+ * @qp_num: HBL QP num.
+ * @swq_cpu_addr: Send WQ mmap address.
+ * @rwq_cpu_addr: Receive WQ mmap address.
+ */
+struct hbldv_query_qp_attr {
+	uint32_t qp_num;
+	void *swq_cpu_addr;
+	void *rwq_cpu_addr;
+};
+
+/**
+ * struct hbldv_usr_fifo_attr - HBL user FIFO attributes.
+ * @port_num: Port ID (should be 1-based).
+ * @usr_fifo_num_hint: Hint to allocate a specific usr_fifo HW resource.
+ * @usr_fifo_type: FIFO Operation type.
+ */
+struct hbldv_usr_fifo_attr {
+	uint32_t port_num;
+	uint32_t reserved0;
+	uint32_t reserved1;
+	uint32_t usr_fifo_num_hint;
+	enum hbldv_usr_fifo_type usr_fifo_type;
+	uint8_t reserved2;
+};
+
+/**
+ * struct hbldv_usr_fifo - HBL user FIFO.
+ * @ci_cpu_addr: CI mmap address.
+ * @regs_cpu_addr: UMR mmap address.
+ * @regs_offset: UMR offset.
+ * @usr_fifo_num: DB FIFO ID.
+ * @size: Allocated FIFO size.
+ * @bp_thresh: Backpressure threshold that was set by the driver.
+ */
+struct hbldv_usr_fifo {
+	void *ci_cpu_addr;
+	void *regs_cpu_addr;
+	uint32_t regs_offset;
+	uint32_t usr_fifo_num;
+	uint32_t size;
+	uint32_t bp_thresh;
+};
+
+/**
+ * struct hbldv_cq_attr - HBL CQ attributes.
+ * @port_num: Port number to which CQ is associated (should be 1-based).
+ * @cq_type: Type of CQ to be allocated.
+ */
+struct hbldv_cq_attr {
+	uint8_t port_num;
+	enum hbldv_cq_type cq_type;
+};
+
+/**
+ * struct hbldv_cq - HBL CQ.
+ * @ibvcq: Verbs CQ.
+ * @mem_cpu_addr: CQ buffer address.
+ * @pi_cpu_addr: CQ PI memory address.
+ * @regs_cpu_addr: CQ UMR address.
+ * @cq_size: Size of the CQ.
+ * @cq_num: CQ number that is allocated.
+ * @regs_offset: CQ UMR reg offset.
+ */
+struct hbldv_cq {
+	struct ibv_cq *ibvcq;
+	void *mem_cpu_addr;
+	void *pi_cpu_addr;
+	void *regs_cpu_addr;
+	uint32_t cq_size;
+	uint32_t cq_num;
+	uint32_t regs_offset;
+};
+
+/**
+ * struct hbldv_query_cq_attr - HBL CQ.
+ * @ibvcq: Verbs CQ.
+ * @mem_cpu_addr: CQ buffer address.
+ * @pi_cpu_addr: CQ PI memory address.
+ * @regs_cpu_addr: CQ UMR address.
+ * @cq_size: Size of the CQ.
+ * @cq_num: CQ number that is allocated.
+ * @regs_offset: CQ UMR reg offset.
+ * @cq_type: Type of CQ resource.
+ */
+struct hbldv_query_cq_attr {
+	struct ibv_cq *ibvcq;
+	void *mem_cpu_addr;
+	void *pi_cpu_addr;
+	void *regs_cpu_addr;
+	uint32_t cq_size;
+	uint32_t cq_num;
+	uint32_t regs_offset;
+	enum hbldv_cq_type cq_type;
+};
+
+/**
+ * struct hbldv_encap_attr - HBL encapsulation specific attributes.
+ * @tnl_hdr_ptr: Pointer to the tunnel encapsulation header. i.e. specific tunnel header data to be
+ *               used in the encapsulation by the HW.
+ * @tnl_hdr_size: Tunnel encapsulation header size.
+ * @ipv4_addr: Source IP address, set regardless of encapsulation type.
+ * @port_num: Port ID (should be 1-based).
+ * @udp_dst_port: The UDP destination-port. Valid for L4 tunnel.
+ * @ip_proto: IP protocol to use. Valid for L3 tunnel.
+ * @encap_type: Encapsulation type. May be either no-encapsulation or encapsulation over L3 or L4.
+ */
+struct hbldv_encap_attr {
+	uint64_t tnl_hdr_ptr;
+	uint32_t tnl_hdr_size;
+	uint32_t ipv4_addr;
+	uint32_t port_num;
+	union {
+		uint16_t udp_dst_port;
+		uint16_t ip_proto;
+	};
+	enum hbldv_encap_type encap_type;
+};
+
+/**
+ * struct hbldv_encap - HBL DV encapsulation data.
+ * @encap_num: HW encapsulation number.
+ */
+struct hbldv_encap {
+	uint32_t encap_num;
+};
+
+/**
+ * struct hbldv_cc_cq_attr - HBL congestion control CQ attributes.
+ * @port_num: Port ID (should be 1-based).
+ * @num_of_cqes: Number of CQ elements in CQ.
+ */
+struct hbldv_cc_cq_attr {
+	uint32_t port_num;
+	uint32_t num_of_cqes;
+};
+
+/**
+ * struct hbldv_cc_cq - HBL congestion control CQ.
+ * @mem_cpu_addr: CC CQ memory mmap address.
+ * @pi_cpu_addr: CC CQ PI mmap address.
+ * @cqe_size: CC CQ entry size.
+ * @num_of_cqes: Number of CQ elements in CQ.
+ */
+struct hbldv_cc_cq {
+	void *mem_cpu_addr;
+	void *pi_cpu_addr;
+	size_t cqe_size;
+	uint32_t num_of_cqes;
+};
+
+/**
+ * struct hbldv_device_attr - Devie specific attributes.
+ * @caps: Capabilities mask.
+ * @ports_mask: Mask of the relevant ports for this context (should be 1-based).
+ */
+struct hbldv_device_attr {
+	uint64_t caps;
+	uint64_t ports_mask;
+};
+
+bool hbldv_is_supported(struct ibv_device *device);
+struct ibv_context *hbldv_open_device(struct ibv_device *device,
+				      struct hbldv_ucontext_attr *attr);
+int hbldv_set_port_ex(struct ibv_context *context, struct hbldv_port_ex_attr *attr);
+/* port_num should be 1-based */
+int hbldv_query_port(struct ibv_context *context, uint32_t port_num,
+		     struct hbldv_query_port_attr *hbl_attr);
+int hbldv_modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask,
+		    struct hbldv_qp_attr *hbl_attr);
+struct hbldv_usr_fifo *hbldv_create_usr_fifo(struct ibv_context *context,
+					     struct hbldv_usr_fifo_attr *attr);
+int hbldv_destroy_usr_fifo(struct hbldv_usr_fifo *usr_fifo);
+struct ibv_cq *hbldv_create_cq(struct ibv_context *context, int cqe,
+			       struct ibv_comp_channel *channel, int comp_vector,
+			       struct hbldv_cq_attr *cq_attr);
+int hbldv_query_cq(struct ibv_cq *ibvcq, struct hbldv_query_cq_attr *hbl_cq);
+int hbldv_query_qp(struct ibv_qp *ibvqp, struct hbldv_query_qp_attr *qp_attr);
+struct hbldv_encap *hbldv_create_encap(struct ibv_context *context,
+				       struct hbldv_encap_attr *encap_attr);
+int hbldv_destroy_encap(struct hbldv_encap *hbl_encap);
+int hbldv_query_device(struct ibv_context *context, struct hbldv_device_attr *attr);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __HBLDV_H__ */
diff --git a/providers/hbl/libhbl.map b/providers/hbl/libhbl.map
new file mode 100644
index 000000000..8a4f2fa47
--- /dev/null
+++ b/providers/hbl/libhbl.map
@@ -0,0 +1,19 @@
+/* Export symbols should be added below according to
+   Documentation/versioning.md document. */
+HBL_1.0 {
+	global:
+		hbldv_create_cq;
+		hbldv_create_encap;
+		hbldv_create_usr_fifo;
+		hbldv_destroy_encap;
+		hbldv_destroy_usr_fifo;
+		hbldv_is_supported;
+		hbldv_modify_qp;
+		hbldv_open_device;
+		hbldv_query_cq;
+		hbldv_query_device;
+		hbldv_query_port;
+		hbldv_query_qp;
+		hbldv_set_port_ex;
+	local: *;
+};
diff --git a/providers/hbl/man/CMakeLists.txt b/providers/hbl/man/CMakeLists.txt
new file mode 100644
index 000000000..36cd8c6b5
--- /dev/null
+++ b/providers/hbl/man/CMakeLists.txt
@@ -0,0 +1,14 @@
+rdma_man_pages(
+  hbldv.7.md
+  hbldv_create_cq.3.md
+  hbldv_create_encap.3.md
+  hbldv_create_usr_fifo.3.md
+  hbldv_is_supported.3.md
+  hbldv_modify_qp.3.md
+  hbldv_open_device.3.md
+  hbldv_query_cq.3.md
+  hbldv_query_device.3.md
+  hbldv_query_port.3.md
+  hbldv_query_qp.3.md
+  hbldv_set_port_ex.3.md
+)
diff --git a/providers/hbl/man/hbldv.7.md b/providers/hbl/man/hbldv.7.md
new file mode 100644
index 000000000..60db58dd0
--- /dev/null
+++ b/providers/hbl/man/hbldv.7.md
@@ -0,0 +1,38 @@
+---
+layout: page
+title: HBLDV
+section: 7
+tagline: Verbs
+date: 2024-05-03
+header: "HabanaLabs DL accelerators Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv - Direct verbs for ROCE links in HabanaLabs DL accelerators
+
+This provides low level access to the DL accelerator's NICs to perform direct
+operations, without general branching performed by libibverbs.
+
+# DESCRIPTION
+
+The libibverbs API is an abstract one. It is agnostic to any underlying
+provider specific implementation. While this abstraction has the advantage
+of user applications portability, it has a performance penalty. For some
+applications optimizing performance is more important than portability.
+
+The habanalabs direct verbs API is intended for such applications.
+It exposes habanalabs specific hardware level features, allowing the application
+to bypass the libibverbs API.
+
+The direct include of hbldv.h together with linkage to hbl library will
+allow usage of this new interface.
+
+# SEE ALSO
+
+**verbs**(7)
+
+# AUTHORS
+
+Bharat Jauhari <bjauhari@habana.ai>
diff --git a/providers/hbl/man/hbldv_create_cq.3.md b/providers/hbl/man/hbldv_create_cq.3.md
new file mode 100644
index 000000000..cf970dad0
--- /dev/null
+++ b/providers/hbl/man/hbldv_create_cq.3.md
@@ -0,0 +1,68 @@
+---
+layout: page
+title: hbldv_create_cq
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_create_cq - Create a completion queue (CQ) resource
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+struct ibv_cq *hbldv_create_cq(struct ibv_context *context, int cqe,
+			       struct ibv_comp_channel *channel, int comp_vector,
+			       struct hbldv_cq_attr *cq_attr);
+```
+
+# DESCRIPTION
+
+Creates a completion queue (CQ) object with user requested configuration.
+
+# ARGUMENTS
+
+Please see **ibv_create_cq(3)** man page for **context**, **cqe**, **channel**
+and **comp_vector**.
+
+## *cq_attr*
+:	Input parameters to allocate a CQ resource.
+
+```c
+struct hbldv_cq_attr {
+	uint32_t port_num;
+	enum hbldv_cq_type cq_type;
+};
+```
+
+*port_num*
+:	Port ID(should be non zero).
+
+*cq_type*
+:	Type of CQ resource to be allocated:
+
+	HBLDV_CQ_TYPE_QP
+		Standard CQ used for completion of an operation for a QP.
+
+	HBLDV_CQ_TYPE_CC
+		CQ resource for congestional control.
+
+
+# RETURN VALUE
+
+Returns a pointer to the created CQ, or NULL if the request fails and errno will
+be set.
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_query_cq**(3), **ibv_create_cq**(3)
+
+# AUTHOR
+
+Zvika Yehudai <zyehudai@habana.ai>
diff --git a/providers/hbl/man/hbldv_create_encap.3.md b/providers/hbl/man/hbldv_create_encap.3.md
new file mode 100644
index 000000000..913302a4e
--- /dev/null
+++ b/providers/hbl/man/hbldv_create_encap.3.md
@@ -0,0 +1,116 @@
+---
+layout: page
+title: hbldv_create_encap
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_create_encap - Allocates an encapsulation resource
+
+hbldv_destroy_encap - Free an encapsulation resource
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+struct hbldv_encap *hbldv_create_encap(struct ibv_context *context,
+				       struct hbldv_encap_attr *encap_attr);
+
+int hbldv_destroy_encap(struct hbldv_encap *hbl_encap);
+```
+
+# DESCRIPTION
+
+Allows the user to encapsulate the RDMA packets with a user defined header.
+
+# ARGUMENTS
+
+*context*
+:	RDMA device context to work on.
+
+## *attr*
+:	input parameters to allocate encapsulation resource
+
+```c
+struct hbldv_encap_attr {
+	uint64_t tnl_hdr_ptr;
+	uint32_t tnl_hdr_size;
+	uint32_t ipv4_addr;
+	uint32_t port_num;
+	union {
+		uint16_t udp_dst_port;
+		uint16_t ip_proto;
+	};
+	enum hbldv_encap_type encap_type;
+};
+```
+
+*tnl_hdr_ptr*
+:	Pointer to the tunnel encapsulation header. i.e. specific tunnel header
+	data to be used in the encapsulation by the HW.
+
+*tnl_hdr_size*
+:	Tunnel encapsulation header size.
+
+*ipv4_addr*
+:	Source IP address, set regardless of encapsulation type.
+
+*port_num*
+:	Port number.
+
+*udp_dst_port*
+:	The UDP destination-port. Valid for L4 tunnel.
+
+*ip_proto*
+:	IP protocol to use. Valid for L3 tunnel.
+
+*encap_type*
+:	Encapsulation type:
+
+	HBLDV_ENCAP_TYPE_NO_ENC
+		No Tunneling.
+
+	HBLDV_ENCAP_TYPE_ENC_OVER_IPV4
+		Tunnel RDMA packets through L3 layer.
+
+	HBLDV_ENCAP_TYPE_ENC_OVER_UDP
+		Tunnel RDMA packets through L4 layer.
+
+## *hbl_encap*
+	Encapsulation resource in action.
+
+```c
+struct hbldv_encap {
+	uint32_t encap_num;
+};
+```
+
+*encap_num*
+:	HW encapsulation number.
+
+# NOTES
+
+On success the API returns an encapsulation ID, which needs to be used for a
+particular QP using the **hbldv_modify_qp()**.
+
+# RETURN VALUE
+
+**hbldv_create_encap()** returns a pointer to a new *struct hbldv_encap* on
+success or NULL on failure.
+
+**hbldv_destroy_encap()** returns 0 on success or errno on failure.
+
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_modify_qp**(3)
+
+# AUTHOR
+
+Abhilash K V <kvabhilash@habana.ai>
diff --git a/providers/hbl/man/hbldv_create_usr_fifo.3.md b/providers/hbl/man/hbldv_create_usr_fifo.3.md
new file mode 100644
index 000000000..ff5ac319d
--- /dev/null
+++ b/providers/hbl/man/hbldv_create_usr_fifo.3.md
@@ -0,0 +1,121 @@
+---
+layout: page
+title: hbldv_create_usr_fifo
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_create_usr_fifo - Allocate h/w resource to send commands to NICs
+
+hbldv_destroy_usr_fifo - Free previously allocated h/w resource
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+struct hbldv_usr_fifo *hbldv_create_usr_fifo(struct ibv_context *context,
+					     struct hbldv_usr_fifo_attr *attr);
+
+int hbldv_destroy_usr_fifo(struct hbldv_usr_fifo *usr_fifo);
+```
+
+# DESCRIPTION
+
+Create/destroy a hardware resource to allow user to send direct commands to NIC.
+The resource is allocated per port.
+
+# ARGUMENTS
+
+*context*
+:	RDMA device context to work on.
+
+## *attr*
+:	Input attributes while requesting for a hardware resource.
+
+```c
+struct hbldv_usr_fifo_attr {
+	uint32_t port_num;
+	uint32_t reserved0;
+	uint32_t reserved1;
+	uint32_t usr_fifo_num_hint;
+	enum hbldv_usr_fifo_type usr_fifo_type;
+	uint8_t reserved2;
+};
+```
+
+*port_num*
+:	Port number.
+
+*usr_fifo_num_hint*
+:	Hint to allocate a specific usr_fifo HW resource.
+
+*usr_fifo_type*
+:	FIFO Operation mode:
+
+	HBLDV_USR_FIFO_TYPE_DB
+		Mode for direct user door-bell submit.
+
+	HBLDV_USR_FIFO_TYPE_CC
+		Mode for congestion control.
+
+## *usr_fifo*
+:	Hardware resource in action.
+
+```c
+struct hbldv_usr_fifo {
+	void *ci_cpu_addr;
+	void *regs_cpu_addr;
+	uint32_t regs_offset;
+	uint32_t usr_fifo_num;
+	uint32_t size;
+	uint32_t bp_thresh;
+};
+```
+
+*ci_cpu_addr*
+:	Consumer index's user virtual address.
+
+*regs_cpu_addr*
+:	User virtual address to the hardware resource.
+
+*regs_offset*
+:	The offset within the resource from where user can access the resource.
+
+*usr_fifo_num*
+:	FIFO resource ID.
+
+*size*
+:	Allocated fifo size.
+
+*bp_thresh*
+:	Back pressure threshold that was set by the driver.
+
+# NOTES
+
+On success user gets direct access to the resource using the information in
+*hbldv_usr_fifo* structure. If *usr_fifo_num_hint* is non-zero, driver will try
+to allocate the same resource. if not available, the API will return an error.
+
+User should use *ci_cpu_addr* to synchronize its command execution.
+
+# RETURN VALUE
+
+**hbldv_create_usr_fifo()** returns a pointer to a new *struct hbldv_usr_fifo*
+on success or NULL on failure.
+
+**hbldv_destroy_usr_fifo()** returns 0 on success or the value of errno on
+failure.
+
+# SEE ALSO
+
+**hbldv**(7)
+
+# AUTHOR
+
+Omer Shpigelman <oshpigelman@habana.ai>
diff --git a/providers/hbl/man/hbldv_is_supported.3.md b/providers/hbl/man/hbldv_is_supported.3.md
new file mode 100644
index 000000000..dcc4000b6
--- /dev/null
+++ b/providers/hbl/man/hbldv_is_supported.3.md
@@ -0,0 +1,43 @@
+---
+layout: page
+title: hbldv_is_supported
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_is_supported - Check if an RDMA device is implemented by the hbl provider
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+bool hbldv_is_supported(struct ibv_device *device);
+```
+
+# DESCRIPTION
+
+hbldv functions can be used only if this function returns true for the given
+RDMA device.
+
+# ARGUMENTS
+
+*device*
+:	RDMA device to check.
+
+# RETURN VALUE
+
+Returns true if device is implemented by hbl provider, false otherwise.
+
+# SEE ALSO
+
+**hbldv**(7)
+
+# AUTHOR
+
+Omer Shpigelman <oshpigelman@habana.ai>
diff --git a/providers/hbl/man/hbldv_modify_qp.3.md b/providers/hbl/man/hbldv_modify_qp.3.md
new file mode 100644
index 000000000..f11be2e2c
--- /dev/null
+++ b/providers/hbl/man/hbldv_modify_qp.3.md
@@ -0,0 +1,102 @@
+---
+layout: page
+title: hbldv_modify_qp
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_modify_qp - Manage state transitions for QP
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+int hbldv_modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
+		    int attr_mask, struct hbldv_qp_attr *hbl_attr);
+```
+# DESCRIPTION
+
+Modify QP state with proprietary configuration data as defined in
+*struct hbldv_qp_attr*.
+
+# ARGUMENTS
+
+*ibqp*
+:	Pointer to QP object.
+
+*attr*
+:	Pointer to QP attributes
+
+*attr_mask*
+:	Attribute mask as defined in enum *ibv_qp_attr_mask* for QP updates.
+
+## *hbl_attr*
+:	hbl specific QP attributes.
+
+```c
+struct hbldv_qp_attr {
+	uint64_t caps;
+	uint32_t local_key;
+	uint32_t remote_key;
+	uint32_t congestion_wnd;
+	uint32_t reserved0;
+	uint32_t dest_wq_size;
+	enum hbldv_qp_wq_types wq_type;
+	enum hbldv_swq_granularity wq_granularity;
+	uint8_t priority;
+	uint8_t reserved1;
+	uint8_t reserved2;
+	uint8_t encap_num;
+	uint8_t reserved3;
+};
+```
+
+*caps*
+:	QP capabilities bit-mask from *enum hbldv_qp_caps*.
+
+*local_key*
+:	Unique key for local memory access. Needed for RTR state.
+
+*remote_key*
+:	Unique key for remote memory access. Needed for RTS state.
+
+*congestion_wnd*
+:	Congestion-Window size. Needed for RTS state.
+
+*dest_wq_size*
+:	Number of WQEs on the destination. Needed for RDV RTS state.
+
+*wq_type*
+:	WQ type. e.g. write, rdv etc. Needed for INIT state.
+
+*wq_granularity*
+:	WQ granularity [0 for 32B or 1 for 64B]. Needed for INIT state.
+
+*priority*
+:	QoS priority. Needed for RTR and RTS state.
+
+*encap_num*
+:	Encapsulation ID. Needed for RTS and RTS state.
+
+# NOTES
+
+To use the full capability of the hardware , user needs to use the hbldv API for
+QP state transition.
+
+# RETURN VALUE
+
+Returns 0 on success, or the value of errno on failure.
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_query_qp**(3)
+
+# AUTHOR
+
+Bharat Jauhari <bjauhari@habana.ai>
diff --git a/providers/hbl/man/hbldv_open_device.3.md b/providers/hbl/man/hbldv_open_device.3.md
new file mode 100644
index 000000000..8f515ecee
--- /dev/null
+++ b/providers/hbl/man/hbldv_open_device.3.md
@@ -0,0 +1,59 @@
+---
+layout: page
+title: hbldv_open_device
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_open_device - Open an RDMA device context for the hbl provider
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+struct ibv_context *hbldv_open_device(struct ibv_device *device,
+				      struct hbldv_ucontext_attr *attr);
+```
+
+# DESCRIPTION
+
+Open an RDMA device context with specific hbl provider attributes.
+
+# ARGUMENTS
+
+*device*
+:	RDMA device to open.
+
+## *attr* argument
+
+```c
+struct hbldv_ucontext_attr {
+	uint64_t ports_mask;
+	int core_fd;
+};
+```
+
+*ports_mask*
+:	Mask of the relevant ports for this context. As all port numbers are
+	non zero, mask should also be 1 based i.e. 0th bit is reserved.
+
+*core_fd*
+:	Core device file descriptor.
+
+# RETURN VALUE
+
+Returns a pointer to the allocated device context, or NULL if the request fails.
+
+# SEE ALSO
+
+**hbldv**(7), **ibv_open_device**(3)
+
+# AUTHOR
+
+Omer Shpigelman <oshpigelman@habana.ai>
diff --git a/providers/hbl/man/hbldv_query_cq.3.md b/providers/hbl/man/hbldv_query_cq.3.md
new file mode 100644
index 000000000..fec0292ca
--- /dev/null
+++ b/providers/hbl/man/hbldv_query_cq.3.md
@@ -0,0 +1,84 @@
+---
+layout: page
+title: hbldv_query_cq
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_query_cq - Query proprietary CQ attributes
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+int hbldv_query_cq(struct ibv_context *context, hbldv_query_cq_attr *cq_attr);
+```
+
+# DESCRIPTION
+
+**hbldv_query_cq** queries a CQ object for hbl provider specific CQ attributes.
+
+# ARGUMENTS
+
+*context*
+:	RDMA device context to work on.
+
+## *cq_attr*
+:	Stores the provider specific CQ attributes.
+
+```c
+struct hbldv_query_cq_attr {
+	struct ibv_cq *ibvcq;
+	void *mem_cpu_addr;
+	void *pi_cpu_addr;
+	void *regs_cpu_addr;
+	uint32_t cq_size;
+	uint32_t cq_num;
+	uint32_t regs_offset;
+	enum hbldv_cq_type cq_type;
+};
+```
+*mem_cpu_addr*
+:	CC CQ memory mmap address.
+
+*pi_cpu_addr*
+:	CC CQ PI mmap address.
+
+*regs_cpu_addr*
+:	CQ objects mmap hardware address.
+
+*cq_size*
+:	CQ entry size.
+
+*cq_num*
+:	Number of CQ elements allocated.
+
+*regs_offset*
+:	CQ objects mmap hardware address reg offset.
+
+*cq_type*
+:	Type of CQ resource:
+
+	HBLDV_CQ_TYPE_QP
+		Standard CQ used for completion of a operation for a QP.
+
+	HBLDV_CQ_TYPE_CC
+		Congestion control CQ.
+
+# RETURN VALUE
+
+Returns a 0 on success, or the value of errno on failure.
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_create_cq**(3)
+
+# AUTHOR
+
+Bharat Jauhari <bjauhari@habana.ai>
diff --git a/providers/hbl/man/hbldv_query_device.3.md b/providers/hbl/man/hbldv_query_device.3.md
new file mode 100644
index 000000000..7c8a5ac15
--- /dev/null
+++ b/providers/hbl/man/hbldv_query_device.3.md
@@ -0,0 +1,61 @@
+---
+layout: page
+title: hbldv_query_device
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_query_device - Query an RDMA device
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+int hbldv_query_device(struct ibv_context *context, struct hbldv_device_attr *attr);
+```
+
+# DESCRIPTION
+
+Query an RDMA device of hbl provider.
+
+# ARGUMENTS
+
+*context*
+:	RDMA device context to work on.
+
+## *attr*
+:	Stores the provider specific device attributes.
+
+```c
+struct hbldv_device_attr {
+	uint64_t caps;
+	uint64_t ports_mask;
+};
+```
+
+*caps*
+:	Bitmask of device capabilities:
+
+	HBLDV_DEVICE_ATTR_CAP_CC:
+		Congestion control is supported.
+
+*ports_mask*
+:	Mask of the relevant ports for this context (should be 1-based).
+
+# RETURN VALUE
+
+Returns 0 on success, or the value of errno on failure.
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_query_port**(3)
+
+# AUTHOR
+
+Omer Shpigelman <oshpigelman@habana.ai>
diff --git a/providers/hbl/man/hbldv_query_port.3.md b/providers/hbl/man/hbldv_query_port.3.md
new file mode 100644
index 000000000..c06ca6e7a
--- /dev/null
+++ b/providers/hbl/man/hbldv_query_port.3.md
@@ -0,0 +1,125 @@
+---
+layout: page
+title: hbldv_query_port
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_query_port - Query non standard attributes of IB device port
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+int hbldv_query_port(struct ibv_context *context, uint32_t port_num,
+		     struct hbldv_query_port_attr *hbl_attr);
+```
+
+# DESCRIPTION
+
+Query port info which can be used for some device commands over the HBL device
+interface and when directly accessing the hardware resources.
+
+The API lets a user query different attributes related to the requested port.
+
+# ARGUMENTS
+
+*context*
+:	RDMA device context to work on.
+
+*port_num*
+:	Port number to query.
+
+## *hbl_attr*
+:	Stores the returned attributes from the kernel.
+
+```c
+struct hbldv_query_port_attr {
+	uint32_t max_num_of_qps;
+	uint32_t num_allocated_qps;
+	uint32_t max_allocated_qp_num;
+	uint32_t max_cq_size;
+	uint32_t reserved0;
+	uint32_t reserved1;
+	uint32_t reserved2;
+	uint32_t reserved3;
+	uint32_t reserved4;
+	uint8_t advanced;
+	uint8_t max_num_of_cqs;
+	uint8_t max_num_of_usr_fifos;
+	uint8_t max_num_of_encaps;
+	uint8_t nic_macro_idx;
+	uint8_t nic_phys_port_idx;
+};
+```
+
+*max_num_of_qps*
+:	Maximum number of QPs that are supported by the driver. User must
+	allocate enough room for its work-queues according to this number.
+
+*num_allocated_qps*
+:	Number of QPs that were already allocated (in use).
+
+*max_allocated_qp_num*
+:	The highest index of the allocated QPs (i.e. this is where the driver
+	may allocate its next QP).
+
+*max_cq_size*
+:	Maximum size of a CQ buffer.
+*advanced*
+:	True if advanced features are supported.
+
+*max_num_of_cqs*
+:	Maximum number of CQs.
+
+*max_num_of_usr_fifos*
+:	Maximum number of user FIFOs.
+
+*max_num_of_encaps*
+:	Maximum number of encapsulations.
+
+*nic_macro_idx*
+:	Nacro index of this specific port.
+
+*nic_phys_port_idx*
+:	Physical port index (AKA lane) of this specific port.
+
+# NOTES
+
+A user should provide the port number to query. On successful query, the
+attributes as defined in the *struct hbldv_query_port_attr* will be returned
+for the requested port.
+
+External ports connected to a switch are referred to as scale-out. Ports
+connected within itself internally are referred to as scale-up ports.
+
+# RETURN VALUE
+
+Returns 0 on success, or the value of errno on failure.
+
+# EXAMPLE
+
+```c
+struct hbldv_query_port_attr port_attr = {};
+
+for (port = 1; port < max_n_ports; port++) {
+	rc = hbldv_query_port(context, port, &port_attr);
+
+	printf("Port:%u Current allocated QPs:%u\n", port, port_attr.num_allocated_qps);
+	printf("Port:%u Lane:%u\n", port, port_attr.nic_phys_port_idx);
+}
+```
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_query_device**(3)
+
+# AUTHOR
+
+Abhilash K V <kvabhilash@habana.ai>
diff --git a/providers/hbl/man/hbldv_query_qp.3.md b/providers/hbl/man/hbldv_query_qp.3.md
new file mode 100644
index 000000000..b75f63745
--- /dev/null
+++ b/providers/hbl/man/hbldv_query_qp.3.md
@@ -0,0 +1,63 @@
+---
+layout: page
+title: hbldv_query_qp
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_query_qp - Query proprietary QP attributes
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+int hbldv_query_qp(struct ibv_qp *ibvqp, struct hbldv_query_qp_attr *qp_attr);
+
+```
+
+# DESCRIPTION
+
+This API is needed to get access to the hardware specific QP attributes.
+
+# ARGUMENTS
+
+*ibqp*
+:	Pointer to QP object.
+
+## *qp_attr*
+:	Stores the returned QP attributes from the kernel.
+
+```c
+struct hbldv_query_qp_attr {
+	uint32_t qp_num;
+	void *swq_cpu_addr;
+	void *rwq_cpu_addr;
+};
+```
+
+*qp_num*
+:	Hardware QP num.
+
+*swq_cpu_addr*
+:	Send WQ mmap address.
+
+*rwq_cpu_addr*
+:	Receive WQ mmap address.
+
+# RETURN VALUE
+
+Returns 0 on success, or the value of errno on failure.
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_modify_qp**(3)
+
+# AUTHOR
+
+Bharat Jauhari <bjauhari@habana.ai>
diff --git a/providers/hbl/man/hbldv_set_port_ex.3.md b/providers/hbl/man/hbldv_set_port_ex.3.md
new file mode 100644
index 000000000..8c538df4a
--- /dev/null
+++ b/providers/hbl/man/hbldv_set_port_ex.3.md
@@ -0,0 +1,106 @@
+---
+layout: page
+title: hbldv_set_port_ex
+section: 3
+tagline: Verbs
+date: 2024-05-03
+header: "hbl Direct Verbs Manual"
+footer: hbl
+---
+
+# NAME
+
+hbldv_set_port_ex - Set properties for a particular port
+
+# SYNOPSIS
+
+```c
+#include <infiniband/hbldv.h>
+
+int hbldv_set_port_ex(struct ibv_context *context,struct hbldv_port_ex_attr *attr);
+```
+
+# DESCRIPTION
+
+The API configures several hardware related configurations per port as defined
+in *struct hbldv_port_ex_attr*.
+
+# ARGUMENTS
+
+*context*
+:	RDMA device context to work on.
+
+## *attr*
+:	Structure to define port related extended properties.
+
+```c
+struct hbldv_port_ex_attr {
+	struct hbldv_wq_array_attr wq_arr_attr[HBLDV_WQ_ARRAY_TYPE_MAX];
+	uint64_t caps;
+	uint32_t qp_wq_bp_offs[HBLDV_USER_BP_OFFS_MAX];
+	uint32_t reserved0[HBLDV_PORT_EX_ATTR_RESERVED0_NUM];
+	uint32_t port_num;
+	uint8_t reserved1;
+};
+```
+## *wq_arr_attr*
+:	Array of WQ-array attributes for each WQ-array type.
+
+```c
+struct hbldv_wq_array_attr {
+	uint32_t max_num_of_wqs;
+	uint32_t max_num_of_wqes_in_wq;
+	enum hbldv_mem_id mem_id;
+	enum hbldv_swq_granularity swq_granularity;
+};
+```
+
+*max_num_of_wqs*
+:	Max number of WQs (QPs) to be used.
+
+*max_num_of_wqes_in_wq*
+	Max number of WQ elements in each WQ.
+
+*mem_id*
+	Memory allocation method:
+
+	HBLDV_MEM_HOST
+		 Memory allocated on the host.
+
+	HBLDV_MEM_DEVICE
+		Memory allocated on the device.
+
+*swq_granularity*
+	Send WQE size.
+
+*caps*
+:	Port capabilities bit-mask:
+
+	HBLDV_PORT_CAP_ADVANCED
+		Enable port advanced features like RDV, QMan, WTD, etc.
+
+	HBLDV_PORT_CAP_ADAPTIVE_TIMEOUT
+		Enable adaptive timeout feature on this port.
+
+*qp_wq_bp_offs*
+:	Offsets in NIC memory to signal a back pressure.
+
+*port_num*
+:	Port number.
+
+# NOTES
+
+The user will need to call it for each port to be used after the device open but
+before any network operations.
+
+# RETURN VALUE
+
+Returns 0 on success, or the value of errno on failure.
+
+# SEE ALSO
+
+**hbldv**(7), **hbldv_query_port**(3)
+
+# AUTHOR
+
+Sagiv Ozeri <sozeri@habana.ai>
diff --git a/providers/hbl/verbs.c b/providers/hbl/verbs.c
new file mode 100644
index 000000000..25d5b0a60
--- /dev/null
+++ b/providers/hbl/verbs.c
@@ -0,0 +1,1085 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#include "hbl.h"
+#include "infiniband/verbs.h"
+#include "infiniband/cmd_ioctl.h"
+#include "verbs.h"
+#include "hbldv.h"
+
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <util/util.h>
+#include <rdma/ib_user_ioctl_cmds.h>
+#include <rdma/hbl_user_ioctl_cmds.h>
+#include <rdma/hbl_user_ioctl_verbs.h>
+
+#define DEFAULT_NUM_WQE		16
+
+static inline void *hbl_mmap(int fd, size_t length, off_t offset)
+{
+	return mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset);
+}
+
+static inline int hbl_munmap(void *addr, size_t length)
+{
+	return munmap(addr, length);
+}
+
+struct ibv_pd *hbl_alloc_pd(struct ibv_context *ibvctx)
+{
+	struct hbl_alloc_pd_resp resp = {};
+	struct ibv_alloc_pd cmd = {};
+	struct hbl_pd *pd;
+	int rc;
+
+	pd = calloc(1, sizeof(*pd));
+	if (!pd)
+		return NULL;
+
+	rc = ibv_cmd_alloc_pd(ibvctx, &pd->ibvpd, &cmd, sizeof(cmd), &resp.ibv_resp,
+			      sizeof(resp));
+	if (rc) {
+		verbs_err(verbs_get_ctx(ibvctx), "Failed to allocate PD\n");
+		goto out;
+	}
+
+	pd->pdn = resp.pdn;
+
+	return &pd->ibvpd;
+
+out:
+	free(pd);
+	errno = rc;
+
+	return NULL;
+}
+
+int hbl_dealloc_pd(struct ibv_pd *ibvpd)
+{
+	struct verbs_context *vctx = verbs_get_ctx(ibvpd->context);
+	struct hbl_pd *pd = to_hbl_pd(ibvpd);
+	int rc;
+
+	rc = ibv_cmd_dealloc_pd(ibvpd);
+	if (rc) {
+		verbs_err(vctx, "Failed to deallocate PD\n");
+		return rc;
+	}
+
+	verbs_debug(vctx, "deallocted PD %d\n", pd->pdn);
+
+	free(pd);
+
+	return 0;
+}
+
+struct ibv_qp *hbl_create_qp(struct ibv_pd *pd, struct ibv_qp_init_attr *attr)
+{
+	struct ib_uverbs_create_qp_resp resp = {};
+	struct ibv_create_qp cmd = {};
+	struct hbl_qp *hblqp;
+	int ret;
+
+	hblqp = calloc(1, sizeof(*hblqp));
+	if (!hblqp)
+		goto err;
+
+	ret = ibv_cmd_create_qp(pd, &hblqp->vqp.qp, attr, &cmd, sizeof(cmd), &resp, sizeof(resp));
+	if (ret)
+		goto err_free;
+
+	hblqp->max_send_wr = attr->cap.max_send_wr;
+	hblqp->max_recv_wr = attr->cap.max_recv_wr;
+
+	return &hblqp->vqp.qp;
+
+err_free:
+	free(hblqp);
+err:
+	return NULL;
+}
+
+struct ibv_qp *hbl_create_qp_ex(struct ibv_context *context, struct ibv_qp_init_attr_ex *attr_ex)
+{
+	struct ib_uverbs_ex_create_qp_resp resp = {};
+	struct ibv_create_qp_ex cmd = {};
+	struct hbl_qp *hblqp;
+	int ret;
+
+	hblqp = calloc(1, sizeof(*hblqp));
+	if (!hblqp)
+		goto err;
+
+	/* Force clear unsupported mask. Pytests set comp_mask with random data.
+	 * Hence, we can't fail the API.
+	 */
+	attr_ex->comp_mask &= IBV_QP_INIT_ATTR_PD;
+
+	ret = ibv_cmd_create_qp_ex2(context, &hblqp->vqp, attr_ex, &cmd, sizeof(cmd), &resp,
+				    sizeof(resp));
+	if (ret)
+		goto err_free;
+
+	hblqp->max_send_wr = attr_ex->cap.max_send_wr;
+
+	return &hblqp->vqp.qp;
+
+err_free:
+	free(hblqp);
+err:
+	return NULL;
+}
+
+int hbl_destroy_qp(struct ibv_qp *iqp)
+{
+	struct verbs_qp *vqp = container_of(iqp, struct verbs_qp, qp);
+	struct hbl_qp *hblqp = to_hbl_qp(vqp);
+	int ret;
+
+	if (hblqp->swq_cpu_addr) {
+		hbl_munmap(hblqp->swq_cpu_addr, hblqp->swq_mem_size);
+		hblqp->swq_cpu_addr = 0;
+	}
+	if (hblqp->rwq_cpu_addr) {
+		hbl_munmap(hblqp->rwq_cpu_addr, hblqp->rwq_mem_size);
+		hblqp->rwq_cpu_addr = 0;
+	}
+
+	ret = ibv_cmd_destroy_qp(iqp);
+	if (ret)
+		return ret;
+
+	free(hblqp);
+
+	return 0;
+}
+
+static enum hbl_ibv_qp_wq_types
+get_qp_wq_type(enum hbldv_qp_wq_types from)
+{
+	enum hbl_ibv_qp_wq_types to = 0;
+
+	if (from & HBLDV_WQ_WRITE)
+		to |= HBL_WQ_WRITE;
+
+	if (from & HBLDV_WQ_RECV_RDV)
+		to |= HBL_WQ_RECV_RDV;
+
+	if (from & HBLDV_WQ_READ_RDV)
+		to |= HBL_WQ_READ_RDV;
+
+	if (from & HBLDV_WQ_SEND_RDV)
+		to |= HBL_WQ_SEND_RDV;
+
+	if (from & HBLDV_WQ_READ_RDV_ENDP)
+		to |= HBL_WQ_READ_RDV_ENDP;
+
+	return to;
+}
+
+static int copy_qp_attr(struct hbl_modify_qp *hbl_cmd, struct hbldv_qp_attr *hbl_attr)
+{
+	hbl_cmd->wq_type = get_qp_wq_type(hbl_attr->wq_type);
+	hbl_cmd->wq_granularity = hbl_attr->wq_granularity;
+	hbl_cmd->local_key = hbl_attr->local_key;
+	hbl_cmd->remote_key = hbl_attr->remote_key;
+	hbl_cmd->congestion_wnd = hbl_attr->congestion_wnd;
+	hbl_cmd->priority = hbl_attr->priority;
+	hbl_cmd->loopback = (hbl_attr->caps & HBLDV_QP_CAP_LOOPBACK) ? 1 : 0;
+	hbl_cmd->dest_wq_size = hbl_attr->dest_wq_size;
+	hbl_cmd->congestion_en = (hbl_attr->caps & HBLDV_QP_CAP_CONG_CTRL) ? 1 : 0;
+	hbl_cmd->compression_en = (hbl_attr->caps & HBLDV_QP_CAP_COMPRESSION) ? 1 : 0;
+	hbl_cmd->encap_en = (hbl_attr->caps & HBLDV_QP_CAP_ENCAP) ? 1 : 0;
+	hbl_cmd->encap_num = hbl_attr->encap_num;
+
+	return 0;
+}
+
+static int get_default_qp_attr(struct verbs_context *vctx, struct hbl_modify_qp *hbl_cmd,
+			       enum ibv_qp_state qp_state)
+{
+	switch (qp_state) {
+	case IBV_QPS_RESET:
+		/* No Ops */
+		break;
+	case IBV_QPS_INIT:
+		hbl_cmd->wq_type = HBL_WQ_WRITE;
+		hbl_cmd->wq_granularity = HBLDV_SWQE_GRAN_32B;
+		break;
+	case IBV_QPS_RTR:
+		/* No Ops */
+		break;
+	case IBV_QPS_RTS:
+		hbl_cmd->priority = 1;
+		break;
+	default:
+		verbs_err(vctx, "Invalid QP state %d\n", qp_state);
+		errno = EINVAL;
+		return errno;
+	}
+
+	return 0;
+}
+
+static int modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask,
+		     struct hbldv_qp_attr *hbl_attr)
+{
+	struct verbs_qp *vqp = container_of(ibqp, struct verbs_qp, qp);
+	struct verbs_context *vctx = verbs_get_ctx(ibqp->context);
+	struct hbl_modify_qp_resp hbl_resp = {};
+	struct hbl_qp *hblqp = to_hbl_qp(vqp);
+	struct hbl_modify_qp hbl_cmd = {};
+	int rc, fd;
+
+	if (hbl_attr)
+		rc = copy_qp_attr(&hbl_cmd, hbl_attr);
+	else
+		rc = get_default_qp_attr(vctx, &hbl_cmd, attr->qp_state);
+	if (rc)
+		return rc;
+
+	rc = ibv_cmd_modify_qp_ex(ibqp, attr, attr_mask, &hbl_cmd.ibv_cmd, sizeof(hbl_cmd),
+				  &hbl_resp.ibv_resp, sizeof(hbl_resp));
+	if (rc)
+		return rc;
+
+	if ((attr_mask & IBV_QP_STATE) && attr->qp_state == IBV_QPS_RESET) {
+		hblqp->qp_num = 0;
+		hblqp->swq_mem_handle = 0;
+		hblqp->rwq_mem_handle = 0;
+	}
+
+	if ((attr_mask & IBV_QP_STATE) && attr->qp_state == IBV_QPS_INIT)
+		hblqp->qp_num = hbl_resp.qp_num;
+
+	if ((attr_mask & IBV_QP_STATE) && attr->qp_state == IBV_QPS_RTS) {
+		hblqp->swq_mem_handle = hbl_resp.swq_mem_handle;
+		hblqp->rwq_mem_handle = hbl_resp.rwq_mem_handle;
+		hblqp->swq_mem_size = hbl_resp.swq_mem_size;
+		hblqp->rwq_mem_size = hbl_resp.rwq_mem_size;
+
+		fd = vqp->qp.context->cmd_fd;
+
+		if (hblqp->swq_mem_handle) {
+			hblqp->swq_cpu_addr = hbl_mmap(fd, hblqp->swq_mem_size,
+						       hblqp->swq_mem_handle);
+			if (hblqp->swq_cpu_addr == MAP_FAILED) {
+				verbs_err(vctx, "Failed to mmap send WQ handle 0x%lx\n",
+					  hblqp->swq_mem_handle);
+				return errno;
+			}
+		}
+
+		if (hblqp->rwq_mem_handle) {
+			hblqp->rwq_cpu_addr = hbl_mmap(fd, hblqp->rwq_mem_size,
+						       hblqp->rwq_mem_handle);
+			if (hblqp->rwq_cpu_addr == MAP_FAILED) {
+				verbs_err(vctx, "Failed to mmap receive WQ handle 0x%lx\n",
+					  hblqp->rwq_mem_handle);
+
+				/* Cache errno to report relevant error. munmap in error flow may
+				 * update errno in failure scenario.
+				 */
+				rc = errno;
+				goto err_munmap_swq;
+			}
+		}
+	}
+
+	return 0;
+
+err_munmap_swq:
+	if (hblqp->swq_mem_handle) {
+		hbl_munmap(hblqp->swq_cpu_addr, hblqp->swq_mem_size);
+		hblqp->swq_cpu_addr = 0;
+	}
+
+	return rc;
+}
+
+int hbl_modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask)
+{
+	return modify_qp(ibqp, attr, attr_mask, NULL);
+}
+
+int hbldv_modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask,
+		    struct hbldv_qp_attr *hbl_attr)
+{
+	int rc;
+
+	if (!is_hbl_dev(ibqp->context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	rc = modify_qp(ibqp, attr, attr_mask, hbl_attr);
+	if (rc)
+		return rc;
+
+	if (attr_mask & IBV_QP_STATE)
+		ibqp->state = attr->qp_state;
+
+	return 0;
+}
+
+int hbldv_set_port_ex(struct ibv_context *context, struct hbldv_port_ex_attr *attr)
+{
+	DECLARE_COMMAND_BUFFER(cmd, HBL_IB_OBJECT_SET_PORT_EX, HBL_IB_METHOD_SET_PORT_EX, 1);
+	struct verbs_context *vctx = verbs_get_ctx(context);
+	struct hbl_uapi_set_port_ex_in in = {};
+	int rc, i;
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	if (!attr) {
+		errno = EINVAL;
+		return errno;
+	}
+
+	in.port_num = attr->port_num;
+
+	for (i = 0; i < HBLDV_WQ_ARRAY_TYPE_MAX; i++) {
+		in.wq_arr_attr[i].max_num_of_wqs = attr->wq_arr_attr[i].max_num_of_wqs;
+		in.wq_arr_attr[i].max_num_of_wqes_in_wq =
+							attr->wq_arr_attr[i].max_num_of_wqes_in_wq;
+		in.wq_arr_attr[i].mem_id = attr->wq_arr_attr[i].mem_id;
+		in.wq_arr_attr[i].swq_granularity = attr->wq_arr_attr[i].swq_granularity;
+	}
+
+	in.qp_wq_bp_offs_cnt = HBLDV_USER_BP_OFFS_MAX;
+	in.qp_wq_bp_offs = (uintptr_t)attr->qp_wq_bp_offs;
+	in.advanced = (attr->caps & HBLDV_PORT_CAP_ADVANCED) ? 1 : 0;
+	in.adaptive_timeout_en = (attr->caps & HBLDV_PORT_CAP_ADAPTIVE_TIMEOUT) ? 1 : 0;
+
+	fill_attr_in_ptr(cmd, HBL_IB_ATTR_SET_PORT_EX_IN, &in);
+
+	rc = execute_ioctl(context, cmd);
+	if (rc)
+		verbs_err(vctx, "set_port_ex execute_ioctl err %d\n", rc);
+
+	return rc;
+}
+
+int hbldv_query_port(struct ibv_context *context, uint32_t port_num,
+		     struct hbldv_query_port_attr *hbl_attr)
+{
+	DECLARE_COMMAND_BUFFER(cmd, HBL_IB_OBJECT_QUERY_PORT, HBL_IB_METHOD_QUERY_PORT, 2);
+	struct verbs_context *vctx = verbs_get_ctx(context);
+	struct hbl_uapi_query_port_out out = {};
+	struct hbl_uapi_query_port_in in = {};
+	int rc;
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	if (!hbl_attr) {
+		errno = EINVAL;
+		return errno;
+	}
+
+	in.port_num = port_num;
+
+	fill_attr_in_ptr(cmd, HBL_IB_ATTR_QUERY_PORT_IN, &in);
+	fill_attr_out_ptr(cmd, HBL_IB_ATTR_QUERY_PORT_OUT, &out);
+
+	rc = execute_ioctl(context, cmd);
+	if (rc) {
+		verbs_err(vctx, "query_port execute_ioctl err %d\n", rc);
+		return rc;
+	}
+
+	hbl_attr->max_num_of_qps = out.max_num_of_qps;
+	hbl_attr->num_allocated_qps = out.num_allocated_qps;
+	hbl_attr->max_allocated_qp_num = out.max_allocated_qp_num;
+	hbl_attr->max_cq_size = out.max_cq_size;
+	hbl_attr->advanced = out.advanced;
+	hbl_attr->max_num_of_cqs = out.max_num_of_cqs;
+	hbl_attr->max_num_of_usr_fifos = out.max_num_of_usr_fifos;
+	hbl_attr->max_num_of_encaps = out.max_num_of_encaps;
+	hbl_attr->nic_macro_idx = out.nic_macro_idx;
+	hbl_attr->nic_phys_port_idx = out.nic_phys_port_idx;
+
+	return 0;
+}
+
+static int __hbldv_destroy_usr_fifo(struct hbl_usr_fifo_obj *obj)
+{
+	DECLARE_COMMAND_BUFFER(cmd,
+			       HBL_IB_OBJECT_USR_FIFO,
+			       HBL_IB_METHOD_USR_FIFO_OBJ_DESTROY,
+			       1);
+	struct ibv_context *context = obj->context;
+	int rc;
+
+	fill_attr_in_obj(cmd, HBL_IB_ATTR_USR_FIFO_DESTROY_HANDLE, obj->handle);
+
+	rc = execute_ioctl(context, cmd);
+	if (rc)
+		verbs_err(verbs_get_ctx(context), "destroy_usr_fifo execute_ioctl err %d\n", rc);
+
+	return rc;
+}
+
+struct hbldv_usr_fifo *hbldv_create_usr_fifo(struct ibv_context *context,
+					     struct hbldv_usr_fifo_attr *attr)
+{
+	DECLARE_COMMAND_BUFFER(cmd,
+			       HBL_IB_OBJECT_USR_FIFO,
+			       HBL_IB_METHOD_USR_FIFO_OBJ_CREATE,
+			       3);
+	struct verbs_context *vctx = verbs_get_ctx(context);
+	struct hbl_uapi_usr_fifo_create_out out = {};
+	struct hbl_uapi_usr_fifo_create_in in = {};
+	struct hbldv_usr_fifo *usr_fifo;
+	uint64_t ci_handle, regs_handle;
+	struct ib_uverbs_attr *handle;
+	struct hbl_usr_fifo_obj *obj;
+	struct hbl_context *hctx;
+	unsigned long page_size;
+	int fd, rc;
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	hctx = to_hbl_ctx(context);
+
+	obj = calloc(1, sizeof(*obj));
+	if (!obj) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	obj->context = context;
+	usr_fifo = &obj->dv_usr_fifo;
+
+	in.port_num = attr->port_num;
+	in.mode = attr->usr_fifo_type;
+	in.usr_fifo_num_hint = attr->usr_fifo_num_hint;
+
+	fill_attr_in_ptr(cmd, HBL_IB_ATTR_USR_FIFO_CREATE_IN, &in);
+	fill_attr_out_ptr(cmd, HBL_IB_ATTR_USR_FIFO_CREATE_OUT, &out);
+	handle = fill_attr_out_obj(cmd, HBL_IB_ATTR_USR_FIFO_CREATE_HANDLE);
+
+	rc = execute_ioctl(context, cmd);
+	if (rc) {
+		verbs_err(vctx, "create_usr_fifo execute_ioctl err %d\n", rc);
+		goto free_usr_fifo;
+	}
+
+	usr_fifo->usr_fifo_num = out.usr_fifo_num;
+	usr_fifo->regs_offset = out.regs_offset;
+	usr_fifo->bp_thresh = out.bp_thresh;
+	usr_fifo->size = out.size;
+
+	usr_fifo->ci_cpu_addr = MAP_FAILED;
+	usr_fifo->regs_cpu_addr = MAP_FAILED;
+
+	obj->handle = read_attr_obj(HBL_IB_ATTR_USR_FIFO_CREATE_HANDLE, handle);
+
+	page_size = sysconf(_SC_PAGESIZE);
+	fd = context->cmd_fd;
+
+	ci_handle = out.ci_handle;
+	regs_handle = out.regs_handle;
+
+	usr_fifo->ci_cpu_addr = hbl_mmap(fd, page_size, ci_handle);
+	if (usr_fifo->ci_cpu_addr == MAP_FAILED) {
+		verbs_err(vctx, "Failed to mmap user fifo CI handle 0x%lx, errno %d\n", ci_handle,
+			  errno);
+		goto destroy_usr_fifo;
+	}
+
+	if (hctx->cap_mask & HBL_UCONTEXT_CAP_MMAP_UMR) {
+		usr_fifo->regs_cpu_addr = hbl_mmap(fd, page_size, regs_handle);
+		if (usr_fifo->regs_cpu_addr == MAP_FAILED) {
+			verbs_err(vctx, "Failed to mmap user fifo UMR handle 0x%lx, errno %d\n",
+				  regs_handle, errno);
+			goto munmap_ci;
+		}
+	}
+
+	return usr_fifo;
+
+munmap_ci:
+	hbl_munmap(usr_fifo->ci_cpu_addr, page_size);
+destroy_usr_fifo:
+	__hbldv_destroy_usr_fifo(obj);
+free_usr_fifo:
+	free(obj);
+	return NULL;
+}
+
+int hbldv_destroy_usr_fifo(struct hbldv_usr_fifo *usr_fifo)
+{
+	struct hbl_usr_fifo_obj *obj = container_of(usr_fifo, struct hbl_usr_fifo_obj,
+						    dv_usr_fifo);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	struct ibv_context *context = obj->context;
+	int rc;
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	if (usr_fifo->regs_cpu_addr != MAP_FAILED)
+		hbl_munmap(usr_fifo->regs_cpu_addr, page_size);
+
+	if (usr_fifo->ci_cpu_addr != MAP_FAILED)
+		hbl_munmap(usr_fifo->ci_cpu_addr, page_size);
+
+	rc = __hbldv_destroy_usr_fifo(obj);
+
+	free(obj);
+
+	return rc;
+}
+
+static int get_max_ports_from_port_mask(uint64_t ports_mask)
+{
+	int max_num_ports = 0;
+	int msb_index = 0;
+
+	if (ports_mask == 0)
+		return -1;
+
+	while (ports_mask > 1) {
+		ports_mask >>= 1;
+		msb_index++;
+	}
+
+	max_num_ports = msb_index + 1;
+
+	return max_num_ports;
+}
+
+static int hbl_update_port_cq(struct hbl_cq *hblcq, struct ibv_context *ibvctx,
+			      struct hbl_create_cq_resp *cq_resp, int max_ports)
+{
+	struct hbl_ibv_port_create_cq_resp *hbl_port_cq_resp;
+	struct verbs_context *vctx = verbs_get_ctx(ibvctx);
+	uint64_t mem_handle, pi_handle, regs_handle;
+	struct hbl_context *hbl_ctx;
+	struct hbl_cq *hbl_port_cq;
+	uint64_t regs_buf_mask = 0;
+	uint64_t mem_buf_mask = 0;
+	uint64_t pi_buf_mask = 0;
+	unsigned long page_size;
+	uint64_t ports_mask = 0;
+	int fd, rc = 0;
+	uint8_t i;
+
+	hbl_ctx = to_hbl_ctx(ibvctx);
+	ports_mask = hbl_ctx->ports_mask;
+	page_size = sysconf(_SC_PAGESIZE);
+
+	for (i = 1; i < max_ports; i++) {
+		if (!(ports_mask & (1 << i)))
+			continue;
+
+		fd = hbl_ctx->ibv_ctx.context.cmd_fd;
+
+		hbl_port_cq_resp = &cq_resp->port_cq_resp[i];
+		mem_handle = hbl_port_cq_resp->mem_handle;
+		pi_handle = hbl_port_cq_resp->pi_handle;
+		regs_handle = hbl_port_cq_resp->regs_handle;
+
+		hbl_port_cq = &hblcq->port_cq[i];
+		hbl_port_cq->cq_num = hbl_port_cq_resp->cq_num;
+		hbl_port_cq->regs_offset = hbl_port_cq_resp->regs_offset;
+		hbl_port_cq->cq_size = hbl_port_cq_resp->cq_size;
+		hbl_port_cq->cq_type = hblcq->cq_type;
+
+		/* mmap the CQ buffer */
+		hbl_port_cq->mem_cpu_addr = hbl_mmap(fd, hbl_port_cq->cq_size, mem_handle);
+		if (hbl_port_cq->mem_cpu_addr == MAP_FAILED) {
+			verbs_err(vctx, "Failed to mmap CQ mem handle 0x%lx\n", mem_handle);
+			rc = -EBUSY;
+			goto err_munmap_cpu_addr;
+		}
+
+		mem_buf_mask |= (1 << i);
+
+		/* mmap the Pi buffer */
+		hbl_port_cq->pi_cpu_addr = hbl_mmap(fd, page_size, pi_handle);
+		if (hbl_port_cq->pi_cpu_addr == MAP_FAILED) {
+			verbs_err(vctx, "Failed to mmap CQ PI handle 0x%lx\n", pi_handle);
+			rc = -EBUSY;
+			goto err_munmap_pi;
+		}
+
+		pi_buf_mask |= (1 << i);
+
+		/* mmap the UMR register */
+		if ((hbl_ctx->cap_mask & HBL_UCONTEXT_CAP_MMAP_UMR) && regs_handle) {
+			hbl_port_cq->regs_cpu_addr = hbl_mmap(fd, page_size, regs_handle);
+			if (hbl_port_cq->regs_cpu_addr == MAP_FAILED) {
+				verbs_err(vctx, "Failed to mmap CQ UMR reg handle 0x%lx\n",
+					  regs_handle);
+				rc = -EBUSY;
+				goto err_munmap_cpu_reg;
+			}
+
+			regs_buf_mask |= (1 << i);
+		}
+	}
+
+	return 0;
+
+err_munmap_cpu_reg:
+	for (i = 0; i < max_ports; i++) {
+		if (regs_buf_mask & (1 << i))
+			hbl_munmap(hblcq->port_cq[i].regs_cpu_addr, page_size);
+	}
+err_munmap_pi:
+	for (i = 0; i < max_ports; i++) {
+		if (pi_buf_mask & (1 << i))
+			hbl_munmap(hblcq->port_cq[i].pi_cpu_addr, page_size);
+	}
+err_munmap_cpu_addr:
+	for (i = 0; i < max_ports; i++) {
+		if (mem_buf_mask & (1 << i))
+			hbl_munmap(hblcq->port_cq[i].mem_cpu_addr, hblcq->port_cq[i].cq_size);
+	}
+
+	return rc;
+}
+
+static struct hbl_cq *create_per_port_cq(struct ibv_context *ibvctx, int cqe,
+					 struct ibv_comp_channel *channel, int comp_vector,
+					 struct hbldv_cq_attr *cq_attr)
+{
+	struct verbs_context *vctx = verbs_get_ctx(ibvctx);
+	struct hbl_create_cq_resp *cq_resp = NULL;
+	struct hbl_create_cq cq_cmd = {};
+	struct hbl_context *hbl_ctx;
+	struct hbl_cq *hblcq;
+	uint64_t ports_mask;
+	size_t cq_resp_size;
+	int max_ports, rc;
+
+	hbl_ctx = to_hbl_ctx(ibvctx);
+	ports_mask = hbl_ctx->ports_mask;
+
+	max_ports = get_max_ports_from_port_mask(ports_mask);
+	if (max_ports < 0) {
+		verbs_err(vctx, "port mask is empty: %llx\n", ports_mask);
+		goto err;
+	}
+
+	if (!cq_attr)
+		goto err;
+
+	cq_cmd.cq_type = cq_attr->cq_type;
+	cq_cmd.flags |= CQ_FLAG_NATIVE;
+
+	hblcq = calloc(1, sizeof(*hblcq));
+	if (!hblcq)
+		goto err;
+
+	/* Round up the cqes to the next highest power of 2 */
+	cqe = next_pow2(cqe);
+
+	cq_resp_size = (sizeof(struct hbl_ibv_port_create_cq_resp) * max_ports) +
+		       sizeof(struct hbl_create_cq_resp);
+	cq_resp = (struct hbl_create_cq_resp *)malloc(cq_resp_size);
+
+	hblcq->port_cq = (struct hbl_cq *)calloc(max_ports, sizeof(struct hbl_cq));
+	if (!hblcq->port_cq)
+		goto err_port_cq;
+
+	if (ibv_cmd_create_cq(ibvctx, cqe, channel, comp_vector, &hblcq->ibvcq, &cq_cmd.ibv_cmd,
+			      sizeof(cq_cmd), &cq_resp->ibv_resp, cq_resp_size)) {
+		verbs_err(vctx, "ibv_cmd_create_cq failed\n");
+		goto free_cq;
+	}
+
+	hblcq->cq_type = cq_attr->cq_type;
+	hblcq->is_native = true;
+
+	rc = hbl_update_port_cq(hblcq, ibvctx, cq_resp, max_ports);
+	if (rc) {
+		verbs_err(vctx, "Failed to update port CQ\n");
+		goto destroy_cq;
+	}
+
+	return hblcq;
+
+destroy_cq:
+	ibv_cmd_destroy_cq(&hblcq->ibvcq);
+free_cq:
+	free(hblcq->port_cq);
+err_port_cq:
+	free(hblcq);
+err:
+	return NULL;
+}
+
+static struct hbl_cq *create_cq(struct ibv_context *ibvctx, int cqe,
+				struct ibv_comp_channel *channel, int comp_vector,
+				struct hbldv_cq_attr *cq_attr)
+{
+	struct verbs_context *vctx = verbs_get_ctx(ibvctx);
+	uint64_t mem_handle, pi_handle, regs_handle;
+	struct hbl_create_cq_resp cq_resp = {};
+	struct hbl_create_cq cq_cmd = {};
+	struct hbl_context *hbl_ctx;
+	unsigned long page_size;
+	struct hbl_cq *hblcq;
+	int fd;
+
+	hbl_ctx = to_hbl_ctx(ibvctx);
+	page_size = sysconf(_SC_PAGESIZE);
+	fd = hbl_ctx->ibv_ctx.context.cmd_fd;
+
+	if (!cq_attr)
+		goto err;
+
+	cq_cmd.port_num = cq_attr->port_num;
+	cq_cmd.cq_type = cq_attr->cq_type;
+
+	hblcq = calloc(1, sizeof(*hblcq));
+	if (!hblcq)
+		goto err;
+
+	/* Round up the cqes to the next highest power of 2 */
+	cqe = next_pow2(cqe);
+
+	if (ibv_cmd_create_cq(ibvctx, cqe, channel, comp_vector, &hblcq->ibvcq, &cq_cmd.ibv_cmd,
+			      sizeof(cq_cmd), &cq_resp.ibv_resp, sizeof(cq_resp))) {
+		verbs_err(vctx, "ibv_cmd_create_cq failed, port: %d\n", cq_attr->port_num);
+		goto free_cq;
+	}
+
+	hblcq->cq_num = cq_resp.cq_num;
+	mem_handle = cq_resp.mem_handle;
+	pi_handle = cq_resp.pi_handle;
+	regs_handle = cq_resp.regs_handle;
+	hblcq->regs_offset = cq_resp.regs_offset;
+	hblcq->cq_size = cq_resp.cq_size;
+	hblcq->cq_type = cq_attr->cq_type;
+
+	/* mmap the CQ buffer */
+	hblcq->mem_cpu_addr = hbl_mmap(fd, hblcq->cq_size, mem_handle);
+	if (hblcq->mem_cpu_addr == MAP_FAILED) {
+		verbs_err(vctx, "Failed to mmap CQ mem handle 0x%lx\n", mem_handle);
+		goto destroy_cq;
+	}
+
+	/* mmap the Pi buffer */
+	hblcq->pi_cpu_addr = hbl_mmap(fd, page_size, pi_handle);
+	if (hblcq->pi_cpu_addr == MAP_FAILED) {
+		verbs_err(vctx, "Failed to mmap CQ PI handle 0x%lx\n", pi_handle);
+		goto err_munmap_cq;
+	}
+
+	/* mmap the UMR register */
+	if ((hbl_ctx->cap_mask & HBL_UCONTEXT_CAP_MMAP_UMR) && regs_handle) {
+		hblcq->regs_cpu_addr = hbl_mmap(fd, page_size, regs_handle);
+		if (hblcq->regs_cpu_addr == MAP_FAILED) {
+			verbs_err(vctx, "Failed to mmap CQ UMR reg handle 0x%lx\n", regs_handle);
+			goto err_munmap_pi;
+		}
+	}
+
+	return hblcq;
+
+err_munmap_cq:
+	hbl_munmap(hblcq->mem_cpu_addr, hblcq->cq_size);
+err_munmap_pi:
+	hbl_munmap(hblcq->pi_cpu_addr, page_size);
+destroy_cq:
+	ibv_cmd_destroy_cq(&hblcq->ibvcq);
+free_cq:
+	free(hblcq);
+err:
+	return NULL;
+}
+
+struct ibv_cq *hbl_create_cq(struct ibv_context *context, int cqe,
+			     struct ibv_comp_channel *channel, int comp_vector)
+{
+	struct verbs_context *vctx = verbs_get_ctx(context);
+	struct hbldv_cq_attr cq_attr = {};
+	struct hbl_cq *hblcq;
+
+	cq_attr.cq_type = HBLDV_CQ_TYPE_QP;
+
+	/* The actual create CQ implementation would be via direct verbs. But we need this callback
+	 * to satisfy the python tests. So, we just create CQ for the first available port and exit.
+	 */
+	hblcq = create_per_port_cq(context, cqe, channel, comp_vector, &cq_attr);
+	if (!hblcq) {
+		verbs_err(vctx, "CQ create failed\n");
+		return NULL;
+	}
+
+	return &hblcq->ibvcq;
+}
+
+static struct hbl_cq *hbl_unmap_per_port_cq(struct ibv_cq *ibvcq, struct hbl_cq *hblcq)
+{
+	struct verbs_context *vctx = verbs_get_ctx(ibvcq->context);
+	struct hbl_context *hbl_ctx;
+	unsigned long page_size;
+	uint64_t ports_mask = 0;
+	int max_ports;
+	uint8_t i;
+
+	hbl_ctx = to_hbl_ctx(ibvcq->context);
+	ports_mask = hbl_ctx->ports_mask;
+	page_size = sysconf(_SC_PAGESIZE);
+
+	max_ports = get_max_ports_from_port_mask(ports_mask);
+	if (max_ports < 0)
+		verbs_err(vctx, "port mask is empty: %lx\n", ports_mask);
+
+	for (i = 1; i < max_ports; i++) {
+		if (!(ports_mask & (1 << i)))
+			continue;
+
+		if ((hbl_ctx->cap_mask & HBL_UCONTEXT_CAP_MMAP_UMR) &&
+		    hblcq->port_cq[i].regs_cpu_addr)
+			hbl_munmap(hblcq->port_cq[i].regs_cpu_addr, page_size);
+
+		hbl_munmap(hblcq->port_cq[i].pi_cpu_addr, page_size);
+		hbl_munmap(hblcq->port_cq[i].mem_cpu_addr, hblcq->port_cq[i].cq_size);
+	}
+
+	return hblcq;
+}
+
+int hbl_destroy_cq(struct ibv_cq *ibvcq)
+{
+	struct hbl_context *hbl_ctx = to_hbl_ctx(ibvcq->context);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	struct hbl_cq *hblcq = to_hbl_cq(ibvcq);
+	int rc;
+
+	if ((hbl_ctx->cap_mask & HBL_UCONTEXT_CAP_MMAP_UMR) && hblcq->regs_cpu_addr)
+		hbl_munmap(hblcq->regs_cpu_addr, page_size);
+
+	if (hblcq->is_native) {
+		hblcq = hbl_unmap_per_port_cq(ibvcq, hblcq);
+	} else {
+		hbl_munmap(hblcq->pi_cpu_addr, page_size);
+		hbl_munmap(hblcq->mem_cpu_addr, hblcq->cq_size);
+	}
+
+	rc = ibv_cmd_destroy_cq(ibvcq);
+	if (rc)
+		return rc;
+
+	free(hblcq);
+
+	return 0;
+}
+
+struct ibv_cq *hbldv_create_cq(struct ibv_context *context, int cqe,
+			       struct ibv_comp_channel *channel, int comp_vector,
+			       struct hbldv_cq_attr *cq_attr)
+{
+	struct verbs_context *vctx = verbs_get_ctx(context);
+	struct hbl_cq *hblcq;
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	hblcq = create_cq(context, cqe, channel, comp_vector, cq_attr);
+	if (!hblcq) {
+		verbs_err(vctx, "CQ create failed, port: %d\n", cq_attr->port_num);
+		return NULL;
+	}
+
+	return &hblcq->ibvcq;
+}
+
+int hbldv_query_cq(struct ibv_cq *ibvcq, struct hbldv_query_cq_attr *cq_attr)
+{
+	struct ibv_context *context = ibvcq->context;
+	struct hbl_cq *hblcq = to_hbl_cq(ibvcq);
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	cq_attr->ibvcq = &hblcq->ibvcq;
+	cq_attr->mem_cpu_addr = hblcq->mem_cpu_addr;
+	cq_attr->pi_cpu_addr = hblcq->pi_cpu_addr;
+	cq_attr->regs_cpu_addr = hblcq->regs_cpu_addr;
+	cq_attr->cq_size = hblcq->cq_size;
+	cq_attr->cq_num = hblcq->cq_num;
+	cq_attr->regs_offset = hblcq->regs_offset;
+	cq_attr->cq_type = hblcq->cq_type;
+
+	return 0;
+}
+
+int hbl_query_qp(struct ibv_qp *ibvqp, struct ibv_qp_attr *attr, int attr_mask,
+		 struct ibv_qp_init_attr *init_attr)
+{
+	struct ibv_query_qp cmd;
+
+	return ibv_cmd_query_qp(ibvqp, attr, attr_mask, init_attr, &cmd, sizeof(cmd));
+}
+
+int hbldv_query_qp(struct ibv_qp *ibvqp, struct hbldv_query_qp_attr *qp_attr)
+{
+	struct verbs_qp *vqp = container_of(ibvqp, struct verbs_qp, qp);
+	struct hbl_qp *hblqp;
+
+	if (!is_hbl_dev(ibvqp->context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	hblqp = to_hbl_qp(vqp);
+
+	qp_attr->qp_num = hblqp->qp_num;
+	qp_attr->swq_cpu_addr = hblqp->swq_cpu_addr;
+	qp_attr->rwq_cpu_addr = hblqp->rwq_cpu_addr;
+
+	return 0;
+}
+
+void hbl_async_event(struct ibv_context *ctx, struct ibv_async_event *event)
+{
+	struct ibv_qp *ibv_qp = event->element.qp;
+
+	switch (event->event_type) {
+	case IBV_EVENT_QP_FATAL:
+	case IBV_EVENT_QP_REQ_ERR:
+		ibv_qp->state = IBV_QPS_ERR;
+		break;
+	default:
+		break;
+	}
+}
+
+struct hbldv_encap *hbldv_create_encap(struct ibv_context *context,
+				       struct hbldv_encap_attr *encap_attr)
+{
+	DECLARE_COMMAND_BUFFER(cmd,
+			       HBL_IB_OBJECT_ENCAP,
+			       HBL_IB_METHOD_ENCAP_CREATE,
+			       3);
+	struct verbs_context *vctx = verbs_get_ctx(context);
+	struct hbl_uapi_encap_create_out out = {};
+	struct hbl_uapi_encap_create_in in = {};
+	struct ib_uverbs_attr *handle;
+	struct hbl_encap *encap_data;
+	int rc;
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	if (!encap_attr) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	encap_data = calloc(1, sizeof(*encap_data));
+	if (!encap_data) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	in.port_num = encap_attr->port_num;
+	in.tnl_hdr_ptr = encap_attr->tnl_hdr_ptr;
+	in.tnl_hdr_size = encap_attr->tnl_hdr_size;
+	in.ipv4_addr = encap_attr->ipv4_addr;
+	in.udp_dst_port = encap_attr->udp_dst_port;
+	in.ip_proto = encap_attr->ip_proto;
+	in.encap_type = encap_attr->encap_type;
+
+	fill_attr_in_ptr(cmd, HBL_IB_ATTR_ENCAP_CREATE_IN, &in);
+	fill_attr_out_ptr(cmd, HBL_IB_ATTR_ENCAP_CREATE_OUT, &out);
+	handle = fill_attr_out_obj(cmd, HBL_IB_ATTR_ENCAP_CREATE_HANDLE);
+
+	rc = execute_ioctl(context, cmd);
+	if (rc) {
+		verbs_err(vctx, "create_encap execute_ioctl err %d\n", rc);
+		goto err_free_encap_data;
+	}
+
+	encap_data->dv_encap.encap_num = out.encap_num;
+	encap_data->handle = read_attr_obj(HBL_IB_ATTR_ENCAP_CREATE_HANDLE, handle);
+	encap_data->context = context;
+
+	return &encap_data->dv_encap;
+
+err_free_encap_data:
+	free(encap_data);
+
+	return NULL;
+}
+
+int hbldv_destroy_encap(struct hbldv_encap *hbl_encap)
+{
+	struct hbl_encap *encap_data = container_of(hbl_encap, struct hbl_encap, dv_encap);
+	DECLARE_COMMAND_BUFFER(cmd,
+			       HBL_IB_OBJECT_ENCAP,
+			       HBL_IB_METHOD_ENCAP_DESTROY,
+			       1);
+	struct ibv_context *context = encap_data->context;
+	struct verbs_context *vctx;
+	int rc;
+
+	vctx = verbs_get_ctx(context);
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	fill_attr_in_obj(cmd, HBL_IB_ATTR_ENCAP_DESTROY_HANDLE, encap_data->handle);
+
+	rc = execute_ioctl(context, cmd);
+	if (rc)
+		verbs_err(vctx, "destroy_encap execute_ioctl err %d\n", rc);
+
+	free(encap_data);
+
+	return rc;
+}
+
+int hbldv_query_device(struct ibv_context *context, struct hbldv_device_attr *attr)
+{
+	struct hbl_context *hctx = to_hbl_ctx(context);
+
+	if (!is_hbl_dev(context->device)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	attr->caps = 0;
+
+	if (hctx->cap_mask & HBL_UCONTEXT_CAP_CC)
+		attr->caps |= HBLDV_DEVICE_ATTR_CAP_CC;
+
+	attr->ports_mask = hctx->ports_mask;
+
+	return 0;
+}
diff --git a/providers/hbl/verbs.h b/providers/hbl/verbs.h
new file mode 100644
index 000000000..b28de5b1b
--- /dev/null
+++ b/providers/hbl/verbs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright 2022-2024 HabanaLabs, Ltd.
+ * Copyright (C) 2023-2024, Intel Corporation.
+ * All Rights Reserved.
+ */
+
+#include <infiniband/verbs.h>
+
+#ifndef __HBL_VERBS_H__
+#define __HBL_VERBS_H__
+
+struct ibv_pd *hbl_alloc_pd(struct ibv_context *uctx);
+int hbl_dealloc_pd(struct ibv_pd *ibvpd);
+
+struct ibv_qp *hbl_create_qp(struct ibv_pd *pd, struct ibv_qp_init_attr *attr);
+struct ibv_qp *hbl_create_qp_ex(struct ibv_context *context, struct ibv_qp_init_attr_ex *attr_ex);
+struct ibv_cq *hbl_create_cq(struct ibv_context *context, int cqe,
+			     struct ibv_comp_channel *channel, int comp_vector);
+int hbl_destroy_qp(struct ibv_qp *iqp);
+int hbl_modify_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr, int attr_mask);
+int hbl_destroy_cq(struct ibv_cq *ibvcq);
+int hbl_query_qp(struct ibv_qp *ibvqp, struct ibv_qp_attr *attr, int attr_mask,
+		 struct ibv_qp_init_attr *init_attr);
+void hbl_async_event(struct ibv_context *ctx, struct ibv_async_event *event);
+
+#endif /* __HBL_VERBS_H__ */
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index 1dda527fb..75a1a5bb2 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -156,6 +156,8 @@ Provides: libefa = %{version}-%{release}
 Obsoletes: libefa < %{version}-%{release}
 Provides: liberdma = %{version}-%{release}
 Obsoletes: liberdma < %{version}-%{release}
+Provides: libhbl = %{version}-%{release}
+Obsoletes: libhbl < %{version}-%{release}
 Provides: libhfi1 = %{version}-%{release}
 Obsoletes: libhfi1 < %{version}-%{release}
 Provides: libhns = %{version}-%{release}
@@ -189,6 +191,7 @@ Device-specific plug-in ibverbs userspace drivers are included:
 - libcxgb4: Chelsio T4 iWARP HCA
 - libefa: Amazon Elastic Fabric Adapter
 - liberdma: Alibaba Elastic RDMA (iWarp) Adapter
+- libhbl: HabanaLabs InfiniBand device
 - libhfi1: Intel Omni-Path HFI
 - libhns: HiSilicon Hip08+ SoC
 - libipathverbs: QLogic InfiniPath HCA
@@ -450,6 +453,7 @@ fi
 %{_libdir}/lib*.so
 %{_libdir}/pkgconfig/*.pc
 %{_mandir}/man3/efadv*
+%{_mandir}/man3/hbldv*
 %{_mandir}/man3/hnsdv*
 %{_mandir}/man3/ibv_*
 %{_mandir}/man3/rdma*
@@ -460,6 +464,7 @@ fi
 %{_mandir}/man3/mlx5dv*
 %{_mandir}/man3/mlx4dv*
 %{_mandir}/man7/efadv*
+%{_mandir}/man7/hbldv*
 %{_mandir}/man7/hnsdv*
 %{_mandir}/man7/manadv*
 %{_mandir}/man7/mlx5dv*
@@ -579,6 +584,7 @@ fi
 %dir %{_sysconfdir}/libibverbs.d
 %dir %{_libdir}/libibverbs
 %{_libdir}/libefa.so.*
+%{_libdir}/libhbl.so.*
 %{_libdir}/libhns.so.*
 %{_libdir}/libibverbs*.so.*
 %{_libdir}/libibverbs/*.so
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index d632a9c47..f37cb672e 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -35,6 +35,7 @@ License:        BSD-2-Clause OR GPL-2.0-only
 Group:          Productivity/Networking/Other
 
 %define efa_so_major    1
+%define hbl_so_major    1
 %define hns_so_major    1
 %define verbs_so_major  1
 %define rdmacm_so_major 1
@@ -46,6 +47,7 @@ Group:          Productivity/Networking/Other
 %define mad_major       5
 
 %define  efa_lname    libefa%{efa_so_major}
+%define  hbl_lname    libhbl%{hbl_so_major}
 %define  hns_lname    libhns%{hns_so_major}
 %define  verbs_lname  libibverbs%{verbs_so_major}
 %define  rdmacm_lname librdmacm%{rdmacm_so_major}
@@ -161,6 +163,7 @@ Requires:       %{umad_lname} = %{version}-%{release}
 Requires:       %{verbs_lname} = %{version}-%{release}
 %if 0%{?dma_coherent}
 Requires:       %{efa_lname} = %{version}-%{release}
+Requires:       %{hbl_lname} = %{version}-%{release}
 Requires:       %{hns_lname} = %{version}-%{release}
 Requires:       %{mana_lname} = %{version}-%{release}
 Requires:       %{mlx4_lname} = %{version}-%{release}
@@ -202,6 +205,7 @@ Group:          System/Libraries
 Requires:       %{name}%{?_isa} = %{version}-%{release}
 Obsoletes:      libcxgb4-rdmav2 < %{version}-%{release}
 Obsoletes:      libefa-rdmav2 < %{version}-%{release}
+Obsoletes:      libhbl-rdmav2 < %{version}-%{release}
 Obsoletes:      libhfi1verbs-rdmav2 < %{version}-%{release}
 Obsoletes:      libhns-rdmav2 < %{version}-%{release}
 Obsoletes:      libipathverbs-rdmav2 < %{version}-%{release}
@@ -213,6 +217,7 @@ Obsoletes:      libocrdma-rdmav2 < %{version}-%{release}
 Obsoletes:      librxe-rdmav2 < %{version}-%{release}
 %if 0%{?dma_coherent}
 Requires:       %{efa_lname} = %{version}-%{release}
+Requires:       %{hbl_lname} = %{version}-%{release}
 Requires:       %{hns_lname} = %{version}-%{release}
 Requires:       %{mana_lname} = %{version}-%{release}
 Requires:       %{mlx4_lname} = %{version}-%{release}
@@ -232,6 +237,7 @@ Device-specific plug-in ibverbs userspace drivers are included:
 
 - libcxgb4: Chelsio T4 iWARP HCA
 - libefa: Amazon Elastic Fabric Adapter
+- libhbl: HabanaLabs InfiniBand device
 - libhfi1: Intel Omni-Path HFI
 - libhns: HiSilicon Hip08+ SoC
 - libipathverbs: QLogic InfiniPath HCA
@@ -261,6 +267,13 @@ Group:          System/Libraries
 %description -n %efa_lname
 This package contains the efa runtime library.
 
+%package -n %hbl_lname
+Summary:        HBL runtime library
+Group:          System/Libraries
+
+%description -n %hbl_lname
+This package contains the hbl runtime library.
+
 %package -n %hns_lname
 Summary:        HNS runtime library
 Group:          System/Libraries
@@ -520,6 +533,9 @@ rm -rf %{buildroot}/%{_sbindir}/srp_daemon.sh
 %post -n %efa_lname -p /sbin/ldconfig
 %postun -n %efa_lname -p /sbin/ldconfig
 
+%post -n %hbl_lname -p /sbin/ldconfig
+%postun -n %hbl_lname -p /sbin/ldconfig
+
 %post -n %hns_lname -p /sbin/ldconfig
 %postun -n %hns_lname -p /sbin/ldconfig
 
@@ -683,11 +699,13 @@ done
 %{_mandir}/man7/rdma_cm.*
 %if 0%{?dma_coherent}
 %{_mandir}/man3/efadv*
+%{_mandir}/man3/hbldv*
 %{_mandir}/man3/hnsdv*
 %{_mandir}/man3/manadv*
 %{_mandir}/man3/mlx5dv*
 %{_mandir}/man3/mlx4dv*
 %{_mandir}/man7/efadv*
+%{_mandir}/man7/hbldv*
 %{_mandir}/man7/hnsdv*
 %{_mandir}/man7/manadv*
 %{_mandir}/man7/mlx5dv*
@@ -717,6 +735,9 @@ done
 %files -n %efa_lname
 %{_libdir}/libefa*.so.*
 
+%files -n %hbl_lname
+%{_libdir}/libhbl*.so.*
+
 %files -n %hns_lname
 %defattr(-,root,root)
 %{_libdir}/libhns*.so.*
diff --git a/util/util.h b/util/util.h
index 92b674067..3859e5927 100644
--- a/util/util.h
+++ b/util/util.h
@@ -93,6 +93,19 @@ struct xorshift32_state {
 
 uint32_t xorshift32(struct xorshift32_state *state);
 
+static inline uint32_t next_pow2(uint32_t v)
+{
+	v--;
+	v |= v >> 1;
+	v |= v >> 2;
+	v |= v >> 4;
+	v |= v >> 8;
+	v |= v >> 16;
+	v++;
+
+	return v;
+}
+
 int set_fd_nonblock(int fd, bool nonblock);
 
 int open_cdev(const char *devname_hint, dev_t cdev);
-- 
2.34.1


