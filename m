Return-Path: <linux-rdma+bounces-1861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA789CFB8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 03:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D641C23B0C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7395C63B9;
	Tue,  9 Apr 2024 01:17:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF326116
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625470; cv=none; b=gR9pQLKgAfvQKU8c6REbnxIPGsqIVvVVN84HgoYoeYtW+/xEaymsYNCDQfLeTppPJExdbxWyW9lPXEmxd9r4UICEAR0S0r6MrPEpf7kn/ImdnoYVdbLDZ8CWsdwDS68pfCf2xRCYD+2yF6rCFrf/i6ESClLXgyY1/O7HsmDWD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625470; c=relaxed/simple;
	bh=PCI2rjoPb8jczQn2QVVw6oaaV8XybttpOlegWXQ7BZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KjU3lwrqyR8tJKzTPNsRKRPliVLjMk/Z8afzvfU2SqLjc9HrEGIxkuw4AuduMUPozTnto2gcwaVL0rUt+bZMMPQ9Ggk1R6QaOl+Nk2H7Mxfr4e+m6PvgH72qxmE6HVZFH2dPKTxcYMTeIM017lJ0hzzPPjkONyMBlWdbURpX49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VD7Kn0dZxz29lSL;
	Tue,  9 Apr 2024 09:14:53 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BA57B180063;
	Tue,  9 Apr 2024 09:17:43 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 09:17:43 +0800
Message-ID: <863c38c7-349d-42b0-4b0f-5512cf7d3cab@hisilicon.com>
Date: Tue, 9 Apr 2024 09:17:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [rdma:wip/leon-for-next] BUILD SUCCESS WITH WARNING
 c3236d538646c8e333370d71cb1d1e37e8996eaf
To: kernel test robot <lkp@intel.com>, Leon Romanovsky <leon@kernel.org>
CC: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg+lists@ziepe.ca>,
	<linux-rdma@vger.kernel.org>
References: <202404090846.K3NBrnkh-lkp@intel.com>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <202404090846.K3NBrnkh-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/4/9 8:08, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
> branch HEAD: c3236d538646c8e333370d71cb1d1e37e8996eaf  RDMA/hns: Support DSCP
> 
> Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202404090005.YRqvDvXD-lkp@intel.com
> 
> Warning: (recently discovered and may have been fixed)
> 
> drivers/infiniband/hw/hns/hns_roce_ah.c:65:13: warning: unused variable 'max_sl' [-Wunused-variable]
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4864:13: warning: unused variable 'sl_num' [-Wunused-variable]
> 

Sorry, will send a cleanup soon.

Junxian

> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- loongarch-allmodconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> |-- powerpc-allmodconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> |-- s390-allyesconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> |-- sparc-allmodconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> |-- sparc64-allmodconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> `-- sparc64-allyesconfig
>     |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
>     `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> clang_recent_errors
> |-- arm64-allmodconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> |-- powerpc-allyesconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> |-- riscv-allmodconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> |-- riscv-allyesconfig
> |   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
> |   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> `-- s390-allmodconfig
>     |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
>     `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
> 
> elapsed time: 721m
> 
> configs tested: 139
> configs skipped: 3
> 
> tested configs:
> alpha                             allnoconfig   gcc  
> alpha                            allyesconfig   gcc  
> alpha                               defconfig   gcc  
> arc                              allmodconfig   gcc  
> arc                               allnoconfig   gcc  
> arc                              allyesconfig   gcc  
> arc                                 defconfig   gcc  
> arc                   randconfig-001-20240409   gcc  
> arc                   randconfig-002-20240409   gcc  
> arm                              allmodconfig   gcc  
> arm                               allnoconfig   clang
> arm                              allyesconfig   gcc  
> arm                                 defconfig   clang
> arm                   randconfig-001-20240409   gcc  
> arm                   randconfig-002-20240409   clang
> arm                   randconfig-003-20240409   clang
> arm                   randconfig-004-20240409   gcc  
> arm64                            allmodconfig   clang
> arm64                             allnoconfig   gcc  
> arm64                               defconfig   gcc  
> arm64                 randconfig-001-20240409   gcc  
> arm64                 randconfig-002-20240409   gcc  
> arm64                 randconfig-003-20240409   clang
> arm64                 randconfig-004-20240409   clang
> csky                             allmodconfig   gcc  
> csky                              allnoconfig   gcc  
> csky                             allyesconfig   gcc  
> csky                                defconfig   gcc  
> csky                  randconfig-001-20240409   gcc  
> csky                  randconfig-002-20240409   gcc  
> hexagon                          allmodconfig   clang
> hexagon                           allnoconfig   clang
> hexagon                          allyesconfig   clang
> hexagon                             defconfig   clang
> hexagon               randconfig-001-20240409   clang
> hexagon               randconfig-002-20240409   clang
> i386                             allmodconfig   gcc  
> i386                              allnoconfig   gcc  
> i386                             allyesconfig   gcc  
> i386         buildonly-randconfig-001-20240409   clang
> i386         buildonly-randconfig-002-20240409   clang
> i386         buildonly-randconfig-003-20240409   gcc  
> i386         buildonly-randconfig-004-20240409   clang
> i386         buildonly-randconfig-005-20240409   gcc  
> i386         buildonly-randconfig-006-20240409   gcc  
> i386                                defconfig   clang
> i386                  randconfig-001-20240409   clang
> i386                  randconfig-002-20240409   gcc  
> i386                  randconfig-003-20240409   clang
> i386                  randconfig-004-20240409   gcc  
> i386                  randconfig-005-20240409   gcc  
> i386                  randconfig-006-20240409   clang
> i386                  randconfig-011-20240409   gcc  
> i386                  randconfig-012-20240409   clang
> i386                  randconfig-013-20240409   clang
> i386                  randconfig-014-20240409   clang
> i386                  randconfig-015-20240409   gcc  
> i386                  randconfig-016-20240409   clang
> loongarch                        allmodconfig   gcc  
> loongarch                         allnoconfig   gcc  
> loongarch                           defconfig   gcc  
> loongarch             randconfig-001-20240409   gcc  
> loongarch             randconfig-002-20240409   gcc  
> m68k                             allmodconfig   gcc  
> m68k                              allnoconfig   gcc  
> m68k                             allyesconfig   gcc  
> m68k                                defconfig   gcc  
> microblaze                       allmodconfig   gcc  
> microblaze                        allnoconfig   gcc  
> microblaze                       allyesconfig   gcc  
> microblaze                          defconfig   gcc  
> mips                              allnoconfig   gcc  
> mips                             allyesconfig   gcc  
> nios2                            allmodconfig   gcc  
> nios2                             allnoconfig   gcc  
> nios2                            allyesconfig   gcc  
> nios2                               defconfig   gcc  
> nios2                 randconfig-001-20240409   gcc  
> nios2                 randconfig-002-20240409   gcc  
> openrisc                          allnoconfig   gcc  
> openrisc                         allyesconfig   gcc  
> openrisc                            defconfig   gcc  
> parisc                           allmodconfig   gcc  
> parisc                            allnoconfig   gcc  
> parisc                           allyesconfig   gcc  
> parisc                              defconfig   gcc  
> parisc                randconfig-001-20240409   gcc  
> parisc                randconfig-002-20240409   gcc  
> parisc64                            defconfig   gcc  
> powerpc                          allmodconfig   gcc  
> powerpc                           allnoconfig   gcc  
> powerpc                          allyesconfig   clang
> powerpc               randconfig-001-20240409   clang
> powerpc               randconfig-002-20240409   gcc  
> powerpc               randconfig-003-20240409   clang
> powerpc64             randconfig-001-20240409   gcc  
> powerpc64             randconfig-002-20240409   clang
> powerpc64             randconfig-003-20240409   gcc  
> riscv                            allmodconfig   clang
> riscv                             allnoconfig   gcc  
> riscv                            allyesconfig   clang
> riscv                               defconfig   clang
> riscv                 randconfig-001-20240409   clang
> riscv                 randconfig-002-20240409   gcc  
> s390                             allmodconfig   clang
> s390                              allnoconfig   clang
> s390                             allyesconfig   gcc  
> s390                                defconfig   clang
> s390                  randconfig-001-20240409   gcc  
> s390                  randconfig-002-20240409   gcc  
> sh                               allmodconfig   gcc  
> sh                                allnoconfig   gcc  
> sh                               allyesconfig   gcc  
> sh                                  defconfig   gcc  
> sh                    randconfig-001-20240409   gcc  
> sh                    randconfig-002-20240409   gcc  
> sparc                            allmodconfig   gcc  
> sparc                             allnoconfig   gcc  
> sparc                               defconfig   gcc  
> sparc64                          allmodconfig   gcc  
> sparc64                          allyesconfig   gcc  
> sparc64                             defconfig   gcc  
> sparc64               randconfig-001-20240409   gcc  
> sparc64               randconfig-002-20240409   gcc  
> um                               allmodconfig   clang
> um                                allnoconfig   clang
> um                               allyesconfig   gcc  
> um                                  defconfig   clang
> um                             i386_defconfig   gcc  
> um                    randconfig-001-20240409   clang
> um                    randconfig-002-20240409   gcc  
> um                           x86_64_defconfig   clang
> x86_64                            allnoconfig   clang
> x86_64                           allyesconfig   clang
> x86_64                              defconfig   gcc  
> x86_64                          rhel-8.3-rust   clang
> xtensa                            allnoconfig   gcc  
> xtensa                randconfig-001-20240409   gcc  
> xtensa                randconfig-002-20240409   gcc  
> 

