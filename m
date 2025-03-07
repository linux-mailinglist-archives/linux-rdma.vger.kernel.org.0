Return-Path: <linux-rdma+bounces-8472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC62A5692E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 14:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503E4188D0F6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7621A42B;
	Fri,  7 Mar 2025 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiwRX6Vh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B7EBE
	for <linux-rdma@vger.kernel.org>; Fri,  7 Mar 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355024; cv=none; b=iGmM3Ln1PZpPH5SG3vC5UGFxPpecTSesPeQncI8jrVuk6LKBOqVf7FFAqt+twYdW2XQcCGSaER/A3a7O0h+qpB0dHH22Kp41ESCF7sF7EwzLXRoMyvM3vx4B2WCPEz2gRUdjFulOq52n4mwLIIozVuj7OtAisCIyVILqB3fkKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355024; c=relaxed/simple;
	bh=RMX6yGqcHOhsgOCJ6x/F+StW/OYEZ90JZEE/qB4ymTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HTdEH1MzA3eYzlVnrkFzeLSQaPZeROA9WCvGjlYZ4m3x6mtihGYTAEWW5y+FjrfOVt+WXSfqT+2IWgFdP1h0tXiSYPlscDSBc1NPVQHDcG/MmS3RRHZxbWyEwwmxcxiL+S6FZhTSIP/MqcSG/9sRiUt9gJmJbsooZ54HUdCzYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiwRX6Vh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741355024; x=1772891024;
  h=date:from:to:cc:subject:message-id;
  bh=RMX6yGqcHOhsgOCJ6x/F+StW/OYEZ90JZEE/qB4ymTs=;
  b=GiwRX6VhS5CwzqYIjvON+dTPql+xJapMEFiUSHhHlojeldQuuTinAc9/
   scpeUZPV4a9wIcmS7iIu5Ip1cLtjjcKq3JaQONgjg9DqtZa/8rZTeLlmB
   IGu55KVL7tn9dNfzjPYIa/4E293n/G/uHNF0LhfOhUW4UaaUHbc9wJRix
   HVn4YiQxGs81P6n8mCtq6QV0tnexdPhEpD3yg+K4ndZon+cu8gJePZgTz
   biG0Mk7MC00LcUC0DTDpzY+NF+ZARePLuE+2w6B8/1WCpracfbxbGgTOd
   SKFu5oW8Ph/wo5Saw2qNURFAtD+ud+Eh8tSTr929ZH0zN3vXo5EMFUt8x
   A==;
X-CSE-ConnectionGUID: hDgpuHFjRtSeGe2zxtMT9w==
X-CSE-MsgGUID: 70MTKL2QQGqG30E2fo+zMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42437779"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42437779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:43:43 -0800
X-CSE-ConnectionGUID: eDPlRjsRQrS4F5qo2Wpm0g==
X-CSE-MsgGUID: EwZJL2rFQMq2QRklIxL0Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="120018162"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 07 Mar 2025 05:43:41 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqXzG-0000XB-37;
	Fri, 07 Mar 2025 13:43:38 +0000
Date: Fri, 07 Mar 2025 21:42:43 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 83437689249e6a17b25e27712fbee292e42e7855
Message-ID: <202503072136.K5NpiyVj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 83437689249e6a17b25e27712fbee292e42e7855  RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()

elapsed time: 1449m

configs tested: 72
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250306    gcc-13.2.0
arc                  randconfig-002-20250306    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250306    gcc-14.2.0
arm                  randconfig-002-20250306    gcc-14.2.0
arm                  randconfig-003-20250306    gcc-14.2.0
arm                  randconfig-004-20250306    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250306    gcc-14.2.0
arm64                randconfig-002-20250306    gcc-14.2.0
arm64                randconfig-003-20250306    gcc-14.2.0
arm64                randconfig-004-20250306    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon                          allnoconfig    clang-21
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386       buildonly-randconfig-001-20250306    clang-19
i386       buildonly-randconfig-002-20250306    clang-19
i386       buildonly-randconfig-003-20250306    clang-19
i386       buildonly-randconfig-004-20250306    gcc-12
i386       buildonly-randconfig-005-20250306    gcc-12
i386       buildonly-randconfig-006-20250306    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250307    gcc-14.2.0
loongarch            randconfig-002-20250307    gcc-14.2.0
nios2                randconfig-001-20250307    gcc-14.2.0
nios2                randconfig-002-20250307    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250307    gcc-14.2.0
parisc               randconfig-002-20250307    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250307    gcc-14.2.0
powerpc              randconfig-002-20250307    clang-21
powerpc              randconfig-003-20250307    clang-19
powerpc64            randconfig-001-20250307    clang-21
powerpc64            randconfig-002-20250307    gcc-14.2.0
powerpc64            randconfig-003-20250307    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250306    clang-18
riscv                randconfig-002-20250306    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250306    gcc-14.2.0
s390                 randconfig-002-20250306    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250306    gcc-14.2.0
sh                   randconfig-002-20250306    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250306    gcc-14.2.0
sparc                randconfig-002-20250306    gcc-14.2.0
sparc64              randconfig-001-20250306    gcc-14.2.0
sparc64              randconfig-002-20250306    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250306    gcc-12
um                   randconfig-002-20250306    clang-16
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250306    gcc-11
x86_64     buildonly-randconfig-002-20250306    clang-19
x86_64     buildonly-randconfig-003-20250306    clang-19
x86_64     buildonly-randconfig-004-20250306    clang-19
x86_64     buildonly-randconfig-005-20250306    clang-19
x86_64     buildonly-randconfig-006-20250306    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250306    gcc-14.2.0
xtensa               randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

