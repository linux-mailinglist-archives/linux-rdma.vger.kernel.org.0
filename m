Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF011C700
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 09:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfLLISe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 03:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbfLLISe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 03:18:34 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5D6214AF;
        Thu, 12 Dec 2019 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576138713;
        bh=I+TTM/jJs8NR7kepmdxzkVUcyjd3gEY7+cqXSlrcNYE=;
        h=From:To:Cc:Subject:Date:From;
        b=d0Em7DaXvNgi4Z7oqvensXx/CPVqU12P6nGHkvPmDqbBoP5MkPdOQ44ougdLv2PS/
         hKe95zNXNrtg1jsy7gvQfBBdo4XtFARxxlwiSl6BWgkhU+8zWts9GYmztJy3JmgvKm
         EXJCpqrmm1MbvCX0mv1hgjBXK5w99ZUMx6vrmXoQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leonro@mellanox.com>
Subject: [ANNOUNCE] rdma-core v27.0 has been tagged/released
Date:   Thu, 12 Dec 2019 10:18:27 +0200
Message-Id: <20191212081827.311379-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
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
tag v27.0
Tagger: Leon Romanovsky <leonro@mellanox.com>
Date:   Thu Dec 12 10:08:59 2019 +0200

rdma-core-27.0:

Updates from version 26.0
   * tests: Fix exception handling in rdmacm test
   * efa: Support send with immediate
   * efa: Always memcpy the whole TX WQE
   * efa: Use int instead of ssize_t
   * efa: Support RDMA read using extended QP API
   * efa: Query device attributes for RDMA operations
   * Update kernel headers
   * efa: WQE format cleanups
   * mlx5: Add support to query HCA clock via mlx5dv_query_device
   * pyverbs: Return correct port number in QPAttr's AH property
   * bnxt_re/lib: Recognize additional 5750x device ID's
   * bnxt_re/lib: Add remaining pci ids for gen P5 devices
   * libhns: Return correct value of cqe num when flushing cqe failed
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for updating qp params
   * libhns: Bugfix for cleaning cq
   * suse: fix conflict with older librdmacm-tools package
   * suse: BuildRequire valgrind-client-headers instead of full valgrind-devel
   * tests: Add traffic tests using extended CQ
   * Documentation: Add mlx5 provider to documentation
   * pyverbs/mlx5: Add support for mlx5 CQ
   * pyverbs: Add support for provider extended CQ
   * pyverbs: Add default values for CQ creation
   * pyverbs/mlx5: Add support for mlx5 QP
   * pyverbs: Allow QP creation by provider
   * buildlib: Build devel stable branches on Azure
   * tests: Add a test for parent domain
   * pyverbs: Document ParentDomain class and add a simple example
   * pyverbs: Introduce ParentDomain class
   * pyverbs: Add mem_alloc module for memory allocation
   * mlx5: Extended modify header to support more than 8 modify actions
   * libhns: Bugfix for assigning sl
   * libhns: Optimize bind_mw for fixing null pointer access
   * libhns: Fix calculation errors with ilog32()
   * docs: Fix typo in udev documentation
   * README.md: Clarify software RDMA usage section
   * cbuild: Add Amazon Linux packaging support
   * cbuild: Check if file exists before creating a symbolic link
   * redhat: Trigger udev rules as part of the spec file
   * redhat: Add EFA to rdma.udev-rules
   * pyverbs: Allow users to set QP caps through QPInitAttr and QPInitAttrEx
   * libqedr: Fix doorbell recording compatibility
   * mlx5: Add support for bulk flow counters steering actions
   * Update kernel headers
   * build: Update to Fedora Core 31
   * cbuild: Force the umask
   * cbuild: Support newer Fedora
   * Documentation: Update testing.md
   * tests: Fix traffic methods for UD QP
   * mlx5: Add ConnectX-6 DX Bluefield 2 to the list of supported devices
   * Documentation: Document creation of CMID
   * tests: Add RDMACM synchronous traffic test
   * tests: New CMResources Class
   * tests: Fix PD API test
   * pyverbs: New CMID class
   * man: Fix return value for ibv_reg_dm_mr
   * vmw_pvrdma: Use resource ids from physical device if available
   * build: Run CI builds on the stable branches with azp support
   * pyverbs: Remove constants for cpdef enums
   * pyverbs: Add makefile dependencies for Cython
   * pyverbs: Use cython built-in cdef's for libc
   * libqedr: Add support for Doorbell Overflow Recovery
   * Update kernel headers
   * Update centos6 spec file to library version 27.0
   * Update library version to be 27.0
   * cxgb4: always query device before initializing chip version
   * cxgb4: free appropriate pointer in error case
   * mlx5: Allow insertion of duplicate rules using DR API
   * verbs: Set missing errno in ibv_cmd_reg_mr
   * pyverbs/mlx5: Add query device capability
   * pyverbs: Add providers to cmake build
   * pyverbs/mlx5: Add support for driver-specific context
   * pyverbs: Add support for providers' context
   * tests: Make unittest command line arguments work
   * tests: Add XRC ODP test case
   * tests: Add XRCResources class
   * tests: Fixes to to_rts() in RCResources
   * tests: Add missing constant in UDResources
   * Documentation: Document creation of XRCD and SRQ
   * pyverbs: Add XRC to ODPCaps
   * pyverbs: Support XRC QPs when modifying QP states
   * pyverbs: Introducing SRQ class
   * pyverbs: Introducing XRCD class
   * pyverbs: Remove TM enums
   * pyverbs: Fix CQ and PD assignment in QPAttr
   * pyverbs: Fix WC creation process
   * build: Add centos 8 to cbuild and azp
   * buildlib: Remove travis CI
   * srp_daemon: Use maximum initiator to target IU size
   * srp_daemon: Print maximum initiator to target IU size
   * mlx5: Fix typos
   * mlx5: Add support for Geneve packets SW steering
   * mlx5: Add HW bits and definitions for Geneve flex parser
   * mlx5: Refactor VXLAN GPE flex parser tunnel code for SW steering
   * mlx5: Improve SW steering HW bits and definitions
   * mlx5: Cleanup 'inline' from SW steering C files
   * man: Fix wrong field in ibv_wr_post's man page
   * mlx5: Add custom allocation support for SRQ buffer
   * mlx5: Add custom allocation support for DBR
   * mlx5: Add custom allocation support for QP and RWQ buffers
   * mlx5: Extend mlx5_alloc_parent_domain() to support custom allocator
   * verbs: custom parent-domain allocators
   * Update kernel headers
   * libnes: Remove libnes from rdma-core
   * libcxgb3: Remove libcxgb3 from rdma-core
   * Fix spelling mistakes in libibverbs man pages
   * debian: Drop libibverbs/nl1_compat.h
   * debian: Remove Debian revision from libibverbs1 symbols
   * tests: Avoid large allocation attempts of device memory
   * tests: A few fixes to QP tests
   * tests: Handle missing capabilities for extended CQ flags
   * tests: Fix variable override in test_query_qp
   * tests: Adaptations to AH tests
   * tests: Skip old tests when no IB devices are found
   * tests: Unify API tests' output
   * Documentation: Add background for rdma-core tests
   * tests: Fix test locating process
   * tests: Add ODP UD test
   * tests: Add ODP RC test
   * tests: Add traffic helper methods
   * tests: ODP requires decorator
   * tests: RCResources and UDResources classes
   * tests: TrafficResources class
   * tests: RDMATestCase
   * build: Do not enable -Wredundant-decls twice
   * tests: BaseResources Class
   * build: Add pyverbs-based test to the build
   * pyverbs: Move tests to a stand-alone directory
   * pyverbs/tests: Rename base class
-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1m3YD37UfMCUQBNwp8NhrnBAZsQUCXfH1ogAKCRAp8NhrnBAZ
sYceAQCkAMaxbGb55CEhoNaTSAUGTxBXqgPVZEwcK4PL0c4Y8QD+MF3hLYDhtqL0
BmyjeF7v6JgP4N8kN4rNmKCj2Z/EnQs=
=Al8A
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases
