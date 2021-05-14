Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666E0380D26
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhENPdQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 11:33:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:25047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232626AbhENPdQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 11:33:16 -0400
IronPort-SDR: 7QR7iKCURDsaFh661PbB5pLsC3BA72mUnC11dN4ZQvQZG/Nyk122yeqMYbBh1gvmIMuhsuycoa
 xNPkuLQeqk+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="197107465"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="197107465"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 08:32:00 -0700
IronPort-SDR: Ui45u1I+8xr9Z0LvY9fqKdP1lNT8eFsAqHcilKdyPYTTAUlax9HHixQeKvjADsB3zfSCuAA8FL
 R9291cj5ufkA==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="624738879"
Received: from sremersa-mobl1.amr.corp.intel.com (HELO tenikolo-mobl1.amr.corp.intel.com) ([10.209.178.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 08:31:59 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 0/5] Add irdma user space provider for Intel Ethernet RDMA
Date:   Fri, 14 May 2021 10:31:30 -0500
Message-Id: <20210514153135.1972-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series replaces the current i40iw library with
a unified Intel Ethernet RDMA library that supports a new network
device E810 (iWARP and RoCEv2 capable) and the existing X722 iWARP device.
The new library is fully backward compatible with the i40iw driver and
is designed to be used with multiple future HW generations.

This patch series can be viewed at
https://github.com/tatyana-en/rdma-core/commits/libirdma-051321

The corresponding irdma driver patch series is at 
https://lore.kernel.org/linux-rdma/20210514141214.2120-1-shiraz.saleem@intel.com/

v2-->v3
* Limit "Remove provider i40iw" changes to code removal only 
* Use the rdma-core provided definition for modify_qp cmd
* Convert all single implementation indirect .ops into direct function calls 
* Misc. library fixes in irdma
  
v1-->v2:
* Replace mfence with a compiler barrier
* Replace ibv_cmd_create_cq() with the new ibv_cmd_create_ext()
* Remove unnecessary #ifdef ICE_DEV_ID_xxx
* Remove fprintf debug prints
* Do not bump ABI ver. to 6 in irdma. Maintain irdma ABI ver. at 5 for legacy i40iw user-provider compatibility.
* Use utility macros like FIELD_PREP/FIELD_GET/GENMASK/etc from rdma-core util.h
* Remove irdma-abi.h file since it is provided by the driver
* Misc. library fixes in irdma

The library passes the azp sparse, CI checks and pyverbs for RoCEv2 and iWARP.

Tatyana Nikolova (5):
  rdma-core/i40iw: Remove provider i40iw
  rdma-core/irdma: Add irdma to Makefiles, distro files and
    kernel-headers
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
 libibverbs/verbs.h                        |    2 +-
 providers/i40iw/CMakeLists.txt            |    5 -
 providers/i40iw/i40e_devids.h             |   72 --
 providers/i40iw/i40iw-abi.h               |   55 -
 providers/i40iw/i40iw_d.h                 | 1746 --------------------------
 providers/i40iw/i40iw_osdep.h             |  108 --
 providers/i40iw/i40iw_register.h          | 1030 ---------------
 providers/i40iw/i40iw_status.h            |  101 --
 providers/i40iw/i40iw_uk.c                | 1266 -------------------
 providers/i40iw/i40iw_umain.c             |  226 ----
 providers/i40iw/i40iw_umain.h             |  181 ---
 providers/i40iw/i40iw_user.h              |  456 -------
 providers/i40iw/i40iw_uverbs.c            |  983 ---------------
 providers/irdma/CMakeLists.txt            |    8 +
 providers/irdma/abi.h                     |   33 +
 providers/irdma/defs.h                    |  334 +++++
 providers/irdma/i40e_devids.h             |   36 +
 providers/irdma/i40iw_hw.h                |   31 +
 providers/irdma/ice_devids.h              |   59 +
 providers/irdma/irdma.h                   |   53 +
 providers/irdma/osdep.h                   |   21 +
 providers/irdma/status.h                  |   72 ++
 providers/irdma/uk.c                      | 1686 +++++++++++++++++++++++++
 providers/irdma/umain.c                   |  233 ++++
 providers/irdma/umain.h                   |  204 +++
 providers/irdma/user.h                    |  439 +++++++
 providers/irdma/uverbs.c                  | 1924 +++++++++++++++++++++++++++++
 redhat/rdma-core.spec                     |    6 +-
 suse/rdma-core.spec                       |    4 +-
 util/util.h                               |    8 +-
 37 files changed, 5158 insertions(+), 6356 deletions(-)
 delete mode 100644 kernel-headers/rdma/i40iw-abi.h
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

