Return-Path: <linux-rdma+bounces-3409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B391392E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3101F2152E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9101A58ADD;
	Sun, 23 Jun 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MooANSBd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251587E0F1
	for <linux-rdma@vger.kernel.org>; Sun, 23 Jun 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719134215; cv=none; b=kjHYvCWA5FtErlwj5XkxZ4q9TAaJw+jYBZTcmvXGe6BffsgCIkn2GsRHUMoD/UVC1NdOhCR5Z//MR3dbcliIZPoG03s00mIXlq1YiM24XDgbOXqE7I6yPy3d/joqu0xARmAk/wrx5hsA4dfspbDBNyBShAEbhIcfGWZWnuDKAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719134215; c=relaxed/simple;
	bh=Aqrk/aqxV8DdiYpEHizCWRW+kQU+YSIVfR3ogq9PMNg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fB4lmXXYfw6wC8cTtjC6bnYhgmGLmP0qo9pDLyJB+VOpMXVrhmaiFWKBuccEa+EJo/dx0kMYcS5t2egqKVtkUF5FMjAqyLaaHY/3X0nPieT0SOeZbmFXSCvAjNzzLe0Edj6b2EpFP7CXDU6jckOZXtIHhMvl6lwJdNDFk1uzltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MooANSBd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719134214; x=1750670214;
  h=date:from:to:cc:subject:message-id;
  bh=Aqrk/aqxV8DdiYpEHizCWRW+kQU+YSIVfR3ogq9PMNg=;
  b=MooANSBdg8c1cKUg7z59fh3U7NyQA9T9n/VvysSs2uEmq/UPN1E6TFuq
   y8HAB9FzhRt15b8rKeJV1F//+y8GhfM+l/Iy1U11Kw2wDESIaQHwNRYs3
   /BxLU/uuXuWMZLQILN0QEcxpyEMItrFxhELov4iAYDrSZDZd+OlC0952A
   80U2s/8FxNNUVikH7QZAuQbbp4hB61d6p0EuPo1ky4AHbTDKH552kfEqE
   JIyM08U7KVXpZ5ts8cnBLUvMsrSQNhus8lRL3Depk85whSLhg38JDyM/L
   uhr80SA4F+A46Z6Rz9L9JfA32Z5LHZUEUFljeKCH1QMRTqi9WHxI6SzYl
   A==;
X-CSE-ConnectionGUID: GiPfiIefSsqVWDtnNRNULQ==
X-CSE-MsgGUID: NplzueGOQZaOtIwo5w3rIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="26707983"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="26707983"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:16:53 -0700
X-CSE-ConnectionGUID: 23sjHJYwRoW72jKtDNtMuA==
X-CSE-MsgGUID: mpw7MV3oSZShzB2KrKDVXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="80531406"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jun 2024 02:16:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLJL6-000APG-2d;
	Sun, 23 Jun 2024 09:16:48 +0000
Date: Sun, 23 Jun 2024 17:16:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 82a5cc783d49b86afd2f60e297ecd85223c39f88
Message-ID: <202406231733.hJDUBhiC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 82a5cc783d49b86afd2f60e297ecd85223c39f88  RDMA/mana_ib: Ignore optional access flags for MRs

elapsed time: 2613m

configs tested: 86
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240622   gcc-13.2.0
arc                   randconfig-001-20240623   gcc-13.2.0
arc                   randconfig-002-20240622   gcc-13.2.0
arc                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-001-20240622   gcc-13.2.0
arm                   randconfig-001-20240623   gcc-13.2.0
arm                   randconfig-002-20240622   clang-19
arm                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-003-20240622   clang-14
arm                   randconfig-003-20240623   gcc-13.2.0
arm                   randconfig-004-20240622   gcc-13.2.0
arm                   randconfig-004-20240623   gcc-13.2.0
arm64                 randconfig-001-20240622   clang-19
arm64                 randconfig-002-20240622   clang-14
arm64                 randconfig-003-20240622   gcc-13.2.0
arm64                 randconfig-004-20240622   clang-19
csky                  randconfig-001-20240622   gcc-13.2.0
csky                  randconfig-002-20240622   gcc-13.2.0
hexagon               randconfig-001-20240622   clang-19
hexagon               randconfig-002-20240622   clang-19
i386         buildonly-randconfig-001-20240622   gcc-13
i386         buildonly-randconfig-002-20240622   clang-18
i386         buildonly-randconfig-003-20240622   clang-18
i386         buildonly-randconfig-004-20240622   gcc-13
i386         buildonly-randconfig-005-20240622   gcc-13
i386         buildonly-randconfig-006-20240622   clang-18
i386                  randconfig-001-20240622   gcc-10
i386                  randconfig-002-20240622   clang-18
i386                  randconfig-003-20240622   gcc-13
i386                  randconfig-004-20240622   gcc-13
i386                  randconfig-005-20240622   clang-18
i386                  randconfig-006-20240622   gcc-13
i386                  randconfig-011-20240622   gcc-9
i386                  randconfig-012-20240622   gcc-7
i386                  randconfig-013-20240622   clang-18
i386                  randconfig-014-20240622   clang-18
i386                  randconfig-015-20240622   clang-18
i386                  randconfig-016-20240622   clang-18
loongarch             randconfig-001-20240622   gcc-13.2.0
loongarch             randconfig-002-20240622   gcc-13.2.0
nios2                 randconfig-001-20240622   gcc-13.2.0
nios2                 randconfig-002-20240622   gcc-13.2.0
parisc                randconfig-001-20240622   gcc-13.2.0
parisc                randconfig-002-20240622   gcc-13.2.0
powerpc               randconfig-001-20240622   gcc-13.2.0
powerpc               randconfig-002-20240622   gcc-13.2.0
powerpc               randconfig-003-20240622   clang-19
powerpc64             randconfig-001-20240622   gcc-13.2.0
powerpc64             randconfig-002-20240622   gcc-13.2.0
powerpc64             randconfig-003-20240622   gcc-13.2.0
riscv                 randconfig-001-20240622   gcc-13.2.0
riscv                 randconfig-002-20240622   gcc-13.2.0
s390                  randconfig-001-20240622   clang-19
s390                  randconfig-002-20240622   clang-15
sh                    randconfig-001-20240622   gcc-13.2.0
sh                    randconfig-002-20240622   gcc-13.2.0
sparc64               randconfig-001-20240622   gcc-13.2.0
sparc64               randconfig-002-20240622   gcc-13.2.0
um                    randconfig-001-20240622   gcc-10
um                    randconfig-002-20240622   clang-19
x86_64       buildonly-randconfig-001-20240622   gcc-8
x86_64       buildonly-randconfig-002-20240622   clang-18
x86_64       buildonly-randconfig-003-20240622   gcc-12
x86_64       buildonly-randconfig-004-20240622   gcc-13
x86_64       buildonly-randconfig-005-20240622   clang-18
x86_64       buildonly-randconfig-006-20240622   gcc-13
x86_64                randconfig-001-20240622   clang-18
x86_64                randconfig-002-20240622   clang-18
x86_64                randconfig-003-20240622   clang-18
x86_64                randconfig-004-20240622   clang-18
x86_64                randconfig-005-20240622   clang-18
x86_64                randconfig-006-20240622   clang-18
x86_64                randconfig-011-20240622   gcc-12
x86_64                randconfig-012-20240622   gcc-8
x86_64                randconfig-013-20240622   clang-18
x86_64                randconfig-014-20240622   gcc-8
x86_64                randconfig-015-20240622   clang-18
x86_64                randconfig-016-20240622   gcc-12
x86_64                randconfig-071-20240622   clang-18
x86_64                randconfig-072-20240622   gcc-8
x86_64                randconfig-073-20240622   clang-18
x86_64                randconfig-074-20240622   gcc-12
x86_64                randconfig-075-20240622   gcc-13
x86_64                randconfig-076-20240622   gcc-10
xtensa                randconfig-001-20240622   gcc-13.2.0
xtensa                randconfig-002-20240622   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

