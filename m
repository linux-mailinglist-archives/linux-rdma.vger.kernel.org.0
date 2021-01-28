Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E3F306BCC
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 05:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhA1EDl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 23:03:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:62979 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhA1EBc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 23:01:32 -0500
IronPort-SDR: JqgqekCUOjAdFYaiuxz4kHIq+PCr5P5nMhP3jI/PWbdgrb34zAG1wZSSpXgCQKqJ6JAmU7JuOc
 crKSZcbx2yYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177612828"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="177612828"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 19:59:54 -0800
IronPort-SDR: qmWsk478swtCvr3rjM4omKyv6UiU/FQvlN+aG12JAOXYLXUPlxSZ9qT14KGoTct4ZhNEEA3RtZ
 cFk00zwGtbaA==
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="357282462"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.251.6.196])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 19:59:54 -0800
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 0/5] Add irdma user space provider for Intel Ethernet RDMA
Date:   Wed, 27 Jan 2021 21:56:59 -0600
Message-Id: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series replaces the current i40iw library with
a unified Intel Ethernet RDMA library that supports
a new network device E810 (iWARP and RoCEv2 capable)
and the existing X722 iWARP device. The new library is fully
backward compatible with the i40iw driver and is designed
to be used with multiple future HW generations.

The corresponding irdma driver patch series is at
https://lore.kernel.org/linux-rdma/20210122234827.1353-1-shiraz.saleem@intel.com/

Tatyana Nikolova (5):
  rdma-core/i40iw: Remove provider i40iw
  rdma-core/irdma: Add Makefile and ABI definitions
  rdma-core/irdma: Add user/kernel shared libraries
  rdma-core/irdma: Add library setup and utility definitions
  rdma-core/irdma: Implement device supported verb APIs

 CMakeLists.txt                            |    2 +-
 MAINTAINERS                               |    7 +-
 debian/control                            |    2 +-
 debian/copyright                          |    8 +-
 kernel-headers/CMakeLists.txt             |    4 +-
 kernel-headers/rdma/i40iw-abi.h           |  107 --
 kernel-headers/rdma/ib_user_ioctl_verbs.h |    2 +-
 kernel-headers/rdma/irdma-abi.h           |  140 ++
 libibverbs/verbs.h                        |    2 +-
 providers/i40iw/CMakeLists.txt            |    5 -
 providers/i40iw/i40e_devids.h             |   72 --
 providers/i40iw/i40iw-abi.h               |   55 -
 providers/i40iw/i40iw_d.h                 | 1746 -------------------------
 providers/i40iw/i40iw_osdep.h             |  108 --
 providers/i40iw/i40iw_register.h          | 1030 ---------------
 providers/i40iw/i40iw_status.h            |  101 --
 providers/i40iw/i40iw_uk.c                | 1266 ------------------
 providers/i40iw/i40iw_umain.c             |  226 ----
 providers/i40iw/i40iw_umain.h             |  181 ---
 providers/i40iw/i40iw_user.h              |  456 -------
 providers/i40iw/i40iw_uverbs.c            |  983 --------------
 providers/irdma/CMakeLists.txt            |    8 +
 providers/irdma/abi.h                     |   43 +
 providers/irdma/defs.h                    |  497 +++++++
 providers/irdma/i40e_devids.h             |   36 +
 providers/irdma/i40iw_hw.h                |   31 +
 providers/irdma/ice_devids.h              |   59 +
 providers/irdma/irdma.h                   |   54 +
 providers/irdma/osdep.h                   |   23 +
 providers/irdma/status.h                  |   69 +
 providers/irdma/uk.c                      | 1724 +++++++++++++++++++++++++
 providers/irdma/umain.c                   |  329 +++++
 providers/irdma/umain.h                   |  200 +++
 providers/irdma/user.h                    |  454 +++++++
 providers/irdma/uverbs.c                  | 1990 +++++++++++++++++++++++++++++
 redhat/rdma-core.spec                     |    6 +-
 suse/rdma-core.spec                       |    4 +-
 37 files changed, 5676 insertions(+), 6354 deletions(-)
 delete mode 100644 kernel-headers/rdma/i40iw-abi.h
 create mode 100644 kernel-headers/rdma/irdma-abi.h
 delete mode 100644 providers/i40iw/CMakeLists.txt
 delete mode 100644 providers/i40iw/i40e_devids.h
 delete mode 100644 providers/i40iw/i40iw-abi.h
 delete mode 100644 providers/i40iw/i40iw_d.h
 delete mode 100644 providers/i40iw/i40iw_osdep.h
 delete mode 100644 providers/i40iw/i40iw_register.h
 delete mode 100644 providers/i40iw/i40iw_status.h
 delete mode 100644 providers/i40iw/i40iw_uk.c
 delete mode 100644 providers/i40iw/i40iw_umain.c
 delete mode 100644 providers/i40iw/i40iw_umain.h
 delete mode 100644 providers/i40iw/i40iw_user.h
 delete mode 100644 providers/i40iw/i40iw_uverbs.c
 create mode 100644 providers/irdma/CMakeLists.txt
 create mode 100644 providers/irdma/abi.h
 create mode 100644 providers/irdma/defs.h
 create mode 100644 providers/irdma/i40e_devids.h
 create mode 100644 providers/irdma/i40iw_hw.h
 create mode 100644 providers/irdma/ice_devids.h
 create mode 100644 providers/irdma/irdma.h
 create mode 100644 providers/irdma/osdep.h
 create mode 100644 providers/irdma/status.h
 create mode 100644 providers/irdma/uk.c
 create mode 100644 providers/irdma/umain.c
 create mode 100644 providers/irdma/umain.h
 create mode 100644 providers/irdma/user.h
 create mode 100644 providers/irdma/uverbs.c

-- 
1.8.3.1

