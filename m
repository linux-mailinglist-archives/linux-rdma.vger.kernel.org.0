Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DBC86DC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfJBLB7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 07:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfJBLB7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 07:01:59 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBE420700;
        Wed,  2 Oct 2019 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570014117;
        bh=MRkJ9FBwwnsUsT4+sXWpliu6nS8IXo7anjS6WpYh6ns=;
        h=From:To:Cc:Subject:Date:From;
        b=15cM//gdmMjLW1eOn2tC2uKDFw2GtCOGg3Q2dJx1MvGcaNlsvOEQFsXX/qZWaCS6l
         AyC3HDkpAbpcqxqTqv2El85nyBKg6Qpx33Y+tNnrQOZhI9QQMn045ChiYmykgX68go
         W3YumpBSm9gMW2cS7BRha1B5JGH2KGVklIdbk7RA=
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leonro@mellanox.com>
Subject: [ANNOUNCE] rdma-core v26.0 has been tagged/released
Date:   Wed,  2 Oct 2019 14:01:53 +0300
Message-Id: <20191002110153.15759-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v26.0
Tagger: Leon Romanovsky <leonro@mellanox.com>
Date:   Wed Oct 2 13:59:35 2019 +0300

rdma-core-26.0:

Updates from version 25.0
   * mlx4: Update errno where necessary
   * pyverbs: Fix PD assignment in QPInitAttrEx
   * verbs: Fix UD pingpong default message size to match default MTU
   * mlx5: Add support for ibv_open_qp
   * ibdiag: Remove wrongly added ibtypes.py file
   * redhat: BuildRequires python3
   * srp_daemon: fix a double free segment fault for ibsrpdm
   * cbuild: Run gpg with a home directy in the tmpdir
   * mlx5: Don't assume that input is rounded to power two
   * mlx5: Fix incorrect size of QPN variable as part of direct rules
   * mlx5: Set miss address on copied STE during rehash
   * mlx5: Fix incorrect postsend of new rehashed/formatted table
   * Fix static library regex check
   * suse: provide libibmad-devel
   * suse: make all infiniband-diags config file noreplace
   * suse: add perl dependency for infiniband-diags
   * suse: fix dependency to rst2man
   * suse: Fix name for libefa RPM
   * mlx5: Fix shift of bit in conversion between mlx5_ilog2 and ilog32
   * ccam: Properly enable ilog32() calculations
   * Revert "Revert "mlx5: Use ilog32 instead of mlx5_ilog2""
   * Revert "mlx5: Use ilog32 instead of mlx5_ilog2"
   * libqedr: Add support for send with invalidate
   * ibdiags: Support arbitrary number of IB devices in ibstat
   * libibumad: Redesign resolve_ca_name to support arbitrary number of IB devices
   * libibumad: Support arbitrary number of IB devices
   * efa: Support send using extended QP API
   * efa: Add create extended QP direct verb
   * mlx5: Allow creating a RDMA_RX flow table
   * Update kernel headers
   * efa: Introduce create extended QP support
   * efa: Store verbs_qp in EFA's QP
   * efa: Split send validation function
   * efa: Split efa_post_send to auxiliary functions
   * efa: Split post send SGL API to auxiliary functions
   * efa: Set errno upon verbs failure
   * mlx5: Report ODP capabilities for DC transport
   * Document how to setup rxe/siw.
   * debian: Depend on python3-docutils instead of python-docutils
   * mlx5: Use ilog32 instead of mlx5_ilog2
   * libhns: Modify pi vlaue when cq overflows
   * libhns: Remove unused headerfiles
   * libhns: Adjust resource release order
   * libhns: Refactor for creating qp
   * libhns: Change type of wqe_shift to unsigned
   * libhns: Remove unnecessary memset calls
   * siw: Change user mmapped CQ notifications flags to 32bit.
   * verbs: Add unspecified node/transport types
   * efa: Fill send operation type in TX descriptor
   * efa: Protect WQ access with a lock on poll CQ flow
   * efa: Remove various unused fields from structs
   * cxgb4: remove unused c4iw_match_device
   * cxgb4: fix chipversion initialization
   * efa: Remove redundant zero of port_attr
   * efa: Use {} for zero initialization of structs
   * efa: Add missing initialization of command structs
   * efa: Use proper error labels in alloc context flow
   * efa: Handle memory leaks in free context flow
   * efa: Don't use opportunistic TX inline
   * efa: Fix direct verbs wrong version number in debian symbols
   * efa: Remove reimplementation of field_avail macro
   * srp_daemon: check that port LID is valid before calling create_ah
   * build/azp: Fix centos6 spec file to version 26
   * Update library version to be 26.0
   * kernel-boot: Set default prefix for RDMA devices with unknown protocol
   * kernel-boot: Separate PCI fill function
   * efa: Add query AH direct verb
   * efa: Add query device direct verb
   * build/azp: Have Azure Pipelines create releases when tags are made
   * build: Use the CMake variable -DENABLE_WERROR to turn on WERROR mode
   * build/azp: Run lintian over the bionic .debs
   * build/azp: Add centos6 to the test distributions
   * build/azp: Reduce the package list
   * build/cbuild: Update cbuild to work with python3
   * build/azp: Update check-build to work with python3
   * build/azp: Add Fedora 30 to the distro testing
   * build/azp: Run a test compile on ppc64el as well
   * build/azp: Use clang 8.0 for building
   * build/azp: Use gcc 9.3 for building
   * build/cbuild: Add push-azp-images
   * build/azp: Use a version number for the docker images
   * build/travis: Do not cross compile for ARM64
   * build/travis: Do not run checkpatch
   * build/travis: Do not build packages in travis anymore
   * build/cbuild: Remove docker-gc
   * util: Enable uninitialized_var on powerpc
   * rdmacm: Fix missing libraries on centos6 build
   * kernel-boot: Instrument rename utility to allow sane bug reports
-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1m3YD37UfMCUQBNwp8NhrnBAZsQUCXZSDHQAKCRAp8NhrnBAZ
se+kAP9FBCNBL9QL+KaBFgp4aCA/HIA2mi+5lZcKxjWPiDwXRAEA0pHUFeULDumG
gSejMstxQ/oYbCAcaV3fQO84S88omw8=
=XLl8
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases
