Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33A52D519
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 07:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfE2FgW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 01:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2FgV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 01:36:21 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5A1208CB;
        Wed, 29 May 2019 05:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559108180;
        bh=uD+YlVHRZtdqkc4erE9DG99MkP9wdiozGXg7DPFsIsU=;
        h=From:To:Cc:Subject:Date:From;
        b=PmPAtAR3hohLWCrvuTg8xS1SxK0SKBcxbVI3zRr3W8K25rpyv0L5CVK20DAHaY48Y
         hUuemN9uOH+ZLPd8mmxYYJMQykPZjpha/n/yLg6XJ6nhdwBz5deMQxNGCYL0vHcuEM
         RqcXxetyWQKKVSxj72YKOPuy2HWAmtYDeC1oou38=
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leonro@mellanox.com>
Subject: [ANNOUNCE] rdma-core v24.0 has been tagged/released
Date:   Wed, 29 May 2019 08:36:01 +0300
Message-Id: <20190529053601.31571-1-leon@kernel.org>
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
tag v24.0
Tagger: Leon Romanovsky <leonro@mellanox.com>
Date:   Wed May 29 08:31:25 2019 +0300

rdma-core-24.0:

Updates from version 23.0
   * Remove unneeded malloc.h
   * buildlib: Fix gen-sparse for xenial
   * rdma-ndd: Don't emit warnings for missing device folder
   * efa: Elastic Fabric Adapter (EFA) direct verbs man pages
   * efa: Elastic Fabric Adapter (EFA) direct verbs
   * efa: Elastic Fabric Adapter (EFA) userspace RDMA provider
   * Update kernel headers
   * Add align and roundup_pow_of_two helpers
   * mlx5: Expose the direct rules functionality to applications
   * mlx5: Expose steering rule functionality
   * mlx5: Expose steering action functionality
   * mlx5: Expose steering matcher functionality
   * mlx5: Expose steering table functionality
   * mlx5: Expose steering domain functionality
   * mlx5: Add Steering entry (STE) utilities
   * mlx5: Expose an internal API to issue RDMA operations for direct rules
   * mlx5: ICM pool memory allocator
   * mlx5: Add direct rule utilities over DEVX
   * mlx5: Add the internal header file
   * mlx5: Expose DV APIs for direct rule managing
   * mlx5: Set devx object information
   * mlx5: Save the original errno upon mlx5_dbg
   * build: Expose the cbuild machinery to build the release .tar.gz
   * cbuild: Do not require yaml to always be installed
   * build: Revise how gen-sparse finds the system headers
   * build: Support glibc 2.27 with sparse
   * build: Use the system PYTHON_EXECUTABLE for gen-sparse
   * hns: Remove unneeded malloc.h
   * ibacm: Fix format string warning on 32 bit compile
   * mlx5: Fix man page of mlx5dv_create_flow_action_modify_header()
   * verbs: Extend async_event function in all providers to get ibv_context
   * build: Enable more warnings
   * cbuild: Do not use the http proxy for tumbleweed
   * cbuild: Use gcc-9 for debian experimental
   * cbuild: Remove ubuntu trusty
   * cbuild: Make pyverbs build with epel
   * kernel-boot: Fix build failure with ancient libnl3 versions
   * cbuild: Update to Fedora Core 30
   * srp_daemon: Print the correct device name for error
   * docs: Document stable names
   * suse: Package persistence name UDEV rule and utility
   * redhat: Add persistent naming installation
   * debian: Install UDEV persistence rule and utility
   * kernel-boot: Perform device rename to make stable names
   * mlx5: Allow creating a matcher for a FDB flow table
   * mlx5: Add SW steering ICM DM type support
   * mlx5: Add device memory type attribute support via DV api
   * mlx5: Expose device TIR ICM address for RAW and RSS QPs
   * Update kernel headers
   * Documentation: Document QP creation and basic usage with pyverbs
   * pyverbs/tests: Add control-path unittests for QP class
   * pyverbs: Add missing device capabilities
   * pyverbs: Introducing QP class
   * pyverbs: Add QP related classes
   * pyverbs: Add work requests related classes
   * Documentation: Document Address Handle creation with pyverbs
   * pyverbs: Add unittests for address handle creation
   * pyverbs: Add support for address handle creation
   * libhns: Optimize some codes for hns userspace
   * libhns: Update prompt message for hip08
   * libhns: Bugfix for flush cqe in case multi-process
   * mlx5: Support scatter to CQE over DCT QP
   * Update kernel headers
   * pyverbs: Add events support
   * pyverbs/tests: Improvements
   * pyverbs: Changes to print-related functions
   * pyverbs: Add missing enums
   * MAINTAINERS: Update libibumad maintainer
   * README.md: Fix incorrect package name in zypper install command
   * ibacm: fix double hint.ai_family assignment in ib_acm_connect_open()
   * ibacm: acme does not work if server_mode != unix
   * ibacm: ib_acm_connect() is doing too much
   * suse: remove %if..%endif guards that do not affect the build result
   * suse: make sure LTO is disabled
   * suse: move udev.md into the right package
   * suse: use _udevrulesdir macro
   * suse: Update rdma-core.spec with the latest OBS parser
   * cmake: Explicitly convert build type to be STRING
   * mlx5: Fix masking service level in mlx5_create_ah
   * verbs: The ibv_xsrq_pingpong "-c" option is broken
   * verbs: Don't check IBV_ODP_SUPPORT_RECV in ibv_{xsrq,srq}_pingpong
   * mlx5: Fix a compiler warning when -Wcast-qual is used
   * mlx5: Introduce mlx5dv_wr_mr_list post send builder
   * mlx5: Introduce mlx5dv_wr_mr_interleaved post send builder
   * verbs: Introduce IBV_WR/WC_DRIVER opcodes
   * mlx5: Expose DV APIs to create and destroy indirect mkey
   * .mailmap: add Steve Wise aliases
   * mlx5: Introduce a new send API in direct verbs
   * verbs: Demonstrate the usage of new post send API
   * mlx5: Support raw packet QPT over new post send API
   * mlx5: Support inline data WR over new post send API
   * mlx5: Support new post send API
   * verbs: Introduce a new post send API
   * buildlib: Ensure stanza is properly sorted
   * pyverbs/tests: Pylint fixes
   * Documentation: Document creation of CQs using pyverbs
   * pyverbs: Add unittests for extended completion-related classes
   * pyverbs: Introducing extended completions related classes
   * pyverbs: Add unittests for completion-related classes
   * pyverbs: Introducing completions related classes
   * libhns: Bugfix for filtering zero length sge
   * libhns: Package for creating qp function
   * Update library version to be 24.0
-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1m3YD37UfMCUQBNwp8NhrnBAZsQUCXO4ZOQAKCRAp8NhrnBAZ
sRzrAP0VV35UDVYlaGlPwArh2OiRvjREhc/jQalLDLsPkQpjxAEA3EJHxMIR8Jp9
LypazQcIc3xPxUVg/PkGJQVp07BZTQQ=
=oENt
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases
