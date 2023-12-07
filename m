Return-Path: <linux-rdma+bounces-295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1581F808054
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 06:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68234B20E2D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 05:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BA7125A4;
	Thu,  7 Dec 2023 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb71r+Cr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA7DE;
	Wed,  6 Dec 2023 21:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701927723; x=1733463723;
  h=date:from:to:cc:subject:message-id;
  bh=uKfMX7B7AelUiYi9YjjS3dGRw+Gxe2MWxWgi3QPMihQ=;
  b=Pb71r+CrdpfpvxZjW9u8ukpVYnr5+XIeNSv5dWTMwJqFIhu6uCFu5cJW
   P4jndM7P1am0u+74iLJRa82WJq3lK636W1WWcBSfAn3LMZgecxYG9SHSw
   3TLDT8H49AMN71PKrwcFJI9oi+9HoKJ+RaPdnEBrJytm4HvCWz3O1BxuQ
   ZrsGXaDrp56xOAHyz8R/rRwYabi3Ui2bg/G5YdcSERr3SASzRG1V5NbU4
   V/yDFHzEc2CYtSsCuiH6ARvTAf0vciufBAPazlM4d+S59uvDRAJRSyyC8
   taG2mpBEHXV7FOvydjCfrOiFzfIPt9Y3xTSu324y9+KonwWHrizqXMG7J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7537557"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7537557"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 21:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="895013884"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="895013884"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2023 21:41:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rB78z-000Btc-2F;
	Thu, 07 Dec 2023 05:41:53 +0000
Date: Thu, 07 Dec 2023 13:41:02 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 577a4ee0b96fb043c9cf4a533c550ff587e526cf
Message-ID: <202312071357.ypE0yrPf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 577a4ee0b96fb043c9cf4a533c550ff587e526cf  Add linux-next specific files for 20231206

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202312061337.WNVSk0AL-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312061837.tbKWaozM-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312062242.RFPPozG9-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

/tmp/cco4BMDv.s:387: Error: selected processor does not support requested special purpose register -- `mrs r1,cpsr'
drivers/perf/riscv_pmu_sbi.c:1008:19: error: incompatible function pointer types initializing 'proc_handler *' (aka 'int (*)(const struct ctl_table *, int, void *, unsigned long *, long long *)') with an expression of type 'int (struct ctl_table *, int, void *, size_t *, loff_t *)' (aka 'int (struct ctl_table *, int, void *, unsigned long *, long long *)') [-Wincompatible-function-pointer-types]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r132-20231206
|   |-- arch-alpha-mm-fault.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-atm-fore200e.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-int-usertype-b-got-restricted-__le32-usertype
|   |-- drivers-iio-imu-bmi323-bmi323_i2c.c:sparse:sparse:symbol-bmi323_i2c_regmap_config-was-not-declared.-Should-it-be-static
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- arm-allyesconfig
|   `-- qcom_stats.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- arm-randconfig-r016-20220626
|   `-- :Error:selected-processor-does-not-support-requested-special-purpose-register-mrs-r1-cpsr
|-- csky-randconfig-r122-20231206
|   |-- arch-csky-kernel-vdso-vgettimeofday.c:sparse:sparse:function-__vdso_clock_gettime-with-external-linkage-has-definition
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- microblaze-randconfig-r121-20231206
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- mips-allyesconfig
|   `-- qcom_stats.c:(.text.qcom_ddr_stats_show):undefined-reference-to-__udivdi3
|-- mips-randconfig-r123-20231206
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- parisc-randconfig-r113-20231206
|   |-- drivers-iio-imu-bmi323-bmi323_i2c.c:sparse:sparse:symbol-bmi323_i2c_regmap_config-was-not-declared.-Should-it-be-static
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-opcode-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-owner-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-type-got-int
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- sh-randconfig-m031-20230727
|   `-- standard-input:Error:unknown-pseudo-op:cfi_def_cfa_regist
|-- sh-randconfig-r112-20231206
|   |-- arch-sh-kernel-crash_dump.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-addr-got-void-noderef-__iomem
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-opcode-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-owner-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-type-got-int
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc-allnoconfig
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-001-20231206
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-002-20231206
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-r061-20231206
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-001-20231206
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-002-20231206
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-r133-20231206
|   |-- drivers-infiniband-hw-vmw_pvrdma-pvrdma.h:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-int-usertype-l-got-restricted-__le32-usertype
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-randconfig-121-20231206
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_process.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_process.c:sparse:struct-dma_fence
|   |-- drivers-gpu-drm-amd-amdgpu-..-amdkfd-kfd_process.c:sparse:struct-dma_fence-noderef-__rcu
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_amdkfd_gpuvm.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_amdkfd_gpuvm.c:sparse:struct-dma_fence
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_amdkfd_gpuvm.c:sparse:struct-dma_fence-noderef-__rcu
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-opcode-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-owner-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-type-got-int
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
`-- x86_64-randconfig-122-20231206
    `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
clang_recent_errors
|-- arm64-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- arm64-randconfig-003-20231206
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- arm64-randconfig-004-20231206
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- hexagon-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- hexagon-allyesconfig
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- ld.lld:error:vmlinux.a(arch-hexagon-kernel-head.o):(.init.text):relocation-R_HEX_B22_PCREL-out-of-range:is-not-in-references-__vmnewmap
|   |-- ld.lld:error:vmlinux.a(arch-hexagon-kernel-head.o):(.init.text):relocation-R_HEX_B22_PCREL-out-of-range:is-not-in-references-__vmsetvec
|   `-- ld.lld:error:vmlinux.a(arch-hexagon-kernel-head.o):(.init.text):relocation-R_HEX_B22_PCREL-out-of-range:is-not-in-references-memset
|-- hexagon-randconfig-002-20231206
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- i386-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- i386-randconfig-061-20231206
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-opcode-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-owner-got-int
|   |-- drivers-soc-qcom-pmic_pdcharger_ulog.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-type-got-int
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-141-20231206
|   |-- block-bdev.c-bdev_open_by_dev()-warn:possible-memory-leak-of-handle
|   |-- drivers-hwtracing-stm-core.c-stm_register_device()-error:double-free-of-stm
|   |-- lib-zstd-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros64()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
|   `-- mm-slub.c-__put_partials()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
|-- powerpc-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- powerpc-allyesconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- powerpc-randconfig-r064-20231206
|   `-- drivers-leds-leds-sun50i-a100.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:FIELD_PREP:value-too-large-for-the-field
|-- powerpc64-randconfig-002-20231206
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- powerpc64-randconfig-003-20231206
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- riscv-randconfig-001-20231206
|   `-- drivers-perf-riscv_pmu_sbi.c:error:incompatible-function-pointer-types-initializing-proc_handler-(aka-int-(-)(const-struct-ctl_table-int-void-unsigned-long-long-long-)-)-with-an-expression-of-type-int
|-- riscv-randconfig-002-20231206
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|-- s390-randconfig-r111-20231206
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-allmodconfig
|   `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
`-- x86_64-allyesconfig
    `-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used

elapsed time: 1467m

configs tested: 176
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20231206   gcc  
arc                   randconfig-002-20231206   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20231206   clang
arm                   randconfig-002-20231206   clang
arm                   randconfig-003-20231206   clang
arm                   randconfig-004-20231206   clang
arm                           spitz_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231206   clang
arm64                 randconfig-002-20231206   clang
arm64                 randconfig-003-20231206   clang
arm64                 randconfig-004-20231206   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231206   gcc  
csky                  randconfig-002-20231206   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231206   clang
hexagon               randconfig-002-20231206   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231206   clang
i386         buildonly-randconfig-002-20231206   clang
i386         buildonly-randconfig-003-20231206   clang
i386         buildonly-randconfig-004-20231206   clang
i386         buildonly-randconfig-005-20231206   clang
i386         buildonly-randconfig-006-20231206   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231206   clang
i386                  randconfig-002-20231206   clang
i386                  randconfig-003-20231206   clang
i386                  randconfig-004-20231206   clang
i386                  randconfig-005-20231206   clang
i386                  randconfig-006-20231206   clang
i386                  randconfig-011-20231206   gcc  
i386                  randconfig-012-20231206   gcc  
i386                  randconfig-013-20231206   gcc  
i386                  randconfig-014-20231206   gcc  
i386                  randconfig-015-20231206   gcc  
i386                  randconfig-016-20231206   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231206   gcc  
loongarch             randconfig-002-20231206   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231206   gcc  
nios2                 randconfig-002-20231206   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231206   gcc  
parisc                randconfig-002-20231206   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc               randconfig-001-20231206   clang
powerpc               randconfig-003-20231206   clang
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231206   clang
powerpc64             randconfig-002-20231206   clang
powerpc64             randconfig-003-20231206   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231206   clang
riscv                 randconfig-002-20231206   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231206   gcc  
s390                  randconfig-002-20231206   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231206   gcc  
sh                    randconfig-002-20231206   gcc  
sh                          rsk7269_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231206   gcc  
sparc64               randconfig-002-20231206   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231206   clang
um                    randconfig-002-20231206   clang
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231206   clang
x86_64       buildonly-randconfig-002-20231206   clang
x86_64       buildonly-randconfig-003-20231206   clang
x86_64       buildonly-randconfig-004-20231206   clang
x86_64       buildonly-randconfig-005-20231206   clang
x86_64       buildonly-randconfig-006-20231206   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231206   gcc  
x86_64                randconfig-002-20231206   gcc  
x86_64                randconfig-003-20231206   gcc  
x86_64                randconfig-004-20231206   gcc  
x86_64                randconfig-005-20231206   gcc  
x86_64                randconfig-006-20231206   gcc  
x86_64                randconfig-011-20231206   clang
x86_64                randconfig-012-20231206   clang
x86_64                randconfig-013-20231206   clang
x86_64                randconfig-014-20231206   clang
x86_64                randconfig-015-20231206   clang
x86_64                randconfig-016-20231206   clang
x86_64                randconfig-071-20231206   clang
x86_64                randconfig-072-20231206   clang
x86_64                randconfig-073-20231206   clang
x86_64                randconfig-074-20231206   clang
x86_64                randconfig-075-20231206   clang
x86_64                randconfig-076-20231206   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231206   gcc  
xtensa                randconfig-002-20231206   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

