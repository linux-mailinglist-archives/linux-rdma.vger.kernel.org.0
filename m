Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6E784E8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 08:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfG2G0X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 02:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2G0X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 02:26:23 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3412070B
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2019 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564381582;
        bh=F8gTNxlnoz+Q5IakKo7HLPC+JB1fAEnQZSdG+krmTW8=;
        h=From:To:Subject:Date:From;
        b=kQRV46wpuZ6JFogEoBdLFWUQLI76sDOjrT92oz4SNckbm3PG1wHRtDFwdDut/Geum
         LTZEQUB/LND5LDGPbcH/7L9HsMOmjgZIyVHFZbdC+EuJJfvalK5MWmL5nPE5yNHQYh
         6DH34eUuAg0Ula4VrkgZDQwklXLP4KXEgafwSSig=
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org
Subject: [ANNOUNCE] rdma-core v25.0 has been tagged/released
Date:   Mon, 29 Jul 2019 09:26:12 +0300
Message-Id: <20190729062612.2111-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v25.0
Tagger: Leon Romanovsky <leonro@mellanox.com>
Date:   Mon Jul 29 09:17:13 2019 +0300

rdma-core-25.0:

Updates from version 24.0
   * srp_daemon: improve the debug message for is_enabled_by_rules_file
   * verbs: Initialize reserved attributes in create AH command
   * build: Do not open code compiler flag detection
   * verbs: Introduce a new reg_mr API for virtual address space
   * azp: Add some documentation describing azure pipelines
   * siw: Use only VERBS_DRIVER_ID matching
   * rdmacm: Use open_cdev and netlink to open the rdma_cm char device
   * verbs: Get the fw_ver from netlink
   * verbs: Get the node guid from netlink
   * verbs: Use open_cdev to open the uverbs0 char device
   * util: Add open_cdev
   * verbs: Revise how init is sequenced
   * verbs: Retrieve the node_type from netlink
   * verbs: Use CHARDEV info from netlink to bind drivers
   * verbs: Use netlink to determine the uverbs chardev
   * verbs: Use netlink to discover uverbs devices instead of sysfs
   * util: Move RDMA netlink code into rdma_nl.h
   * build: Shim netlink headers instead of using NL_KIND
   * Remove obsolete libnl constructs
   * verbs: Remove 'zero_socket' from neigh.c
   * util: Add missing include to util.h
   * verbs: Add ibv_read_ibdev_sysfs_file
   * verbs: Remove verbs_device sysfs_path
   * verbs: Read device/modalias on demand
   * providers: Remove unused hca_type
   * debian: Skip installing efa if arch lacks coherent DMA support
   * Fix spelling mistakes in documentation
   * debian: Fix provided libefa1 name
   * debian: Add Pre-Depends on ${misc:Pre-Depends}
   * debian: Bump Standards-Version to 4.4.0
   * pyverbs: Fix assignments of bad work requests
   * pyverbs: Avoid casting pointers to object type
   * build: Remove warning-causing compilation flag from pyverbs
   * pyverbs: Fix Cython future warning during build
   * kernel-boot: Fix garbage name due to wrong usage of netlink API
   * cbuild: Upgrade PyYAML load call to v5.1
   * mlx5: Fix mlx5_ifc metadata fields spelling
   * mlx5: Fix bucket allocation check
   * mlx5: Allow matching of source QP regardless the source port
   * mlx5: Set the proper flags upon dr_fill_data_segs
   * mlx5: Expose DEVX API to read asynchronous event
   * mlx5: Introduce DEX APIs to subscribe for asynchronous events
   * mlx5: Introduce DEVX APIs to create and destroy asynchronous event channel
   * Update kernel headers
   * rsockets: fix variable initialization
   * Adding Soft-iWarp user library
   * ibacm: only open InfiniBand port
   * ibdiags: Fix linkage error on PPC platform due to typo
   * RDMA/hns: Bugfix for identify the last srq sge
   * RDMA/hns: Clean up unnecessary check of qp type
   * suse: drop obsolete dracut script
   * libhns: Adjust the order of parameter checking
   * libhns: Fix bug type inconsistent
   * libhns: Avoid dseg cross-page risk
   * libhns: Keep qp buffer size aligned for userspace
   * libhns: Limit the index of wr id
   * libhns: Bugfix for computing valid sge
   * azp: Set up CI with Azure Pipelines
   * ibdiags: Do not use a post increment in a macro context
   * Update library version to be 25.0
   * kernel-boot: Reset buffer before refill
   * Update kernel headers
   * ibdiags: Perform substitution on the RST include files as well
   * ibdiags: Remove @BUILD_DATE@ from the man pages
   * ibdiags: Remove obsolete build system and related files
   * ibdiags: Flatten the infiniband-diags tools into one directory
   * libibnetdiscover: Flatten libibnetdiscover into one directory
   * libibmad: Flatten libibmad into one directory
   * ibdiags: Obsolete mad_osd.h, ibnetdisc_osd.h
   * ibdiags: Add suse packaging
   * ibdiags: Add Fedora packaging
   * ibdiags: Add Debian packaging
   * suse: fix dracut support
-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1m3YD37UfMCUQBNwp8NhrnBAZsQUCXT6QtwAKCRAp8NhrnBAZ
scc9APsEFlO+fVMvMHPvtxuzRFx/rAptOMS9dxPAJslO0NE5/gD/Z7ME9ChguGI0
L5GhSEAiSQHWvWXnIICgey1bpjw8DQU=
=RcwD
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases
