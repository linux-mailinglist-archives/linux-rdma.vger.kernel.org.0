Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1147D4EF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 17:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhLVQO6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Dec 2021 11:14:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:30193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhLVQO6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Dec 2021 11:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640189698; x=1671725698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=042g5HYpnl13PvSaI2VaFEyGeQULFxbMxcXpTzH36ZI=;
  b=eIVpx+nY9So3kJIfL2Pa1A+wjkmpj7GAEslD3i/btAlYvLBbhr8o2JEK
   ElySB/c6ztgioi+KMHMy+3tKOxgHSyq6xcCXkQ9ggpDG2hTIr5gJ961uy
   n3SNJERveOrJ87B7muHfcRw3wqhDdssFiWIoaUFx6txkVHqH8fT0sSdRG
   Rv0ykS8dUPYKrOnjeDEb7/x589g/9lRSw1VfCDJ8higospxHqNd9QxCn5
   1hxNnSOT17dP6hzy0aPDT/8h2BQA+4VBWbm9zM6OBhD3MeYk6qfPtQnVT
   ++55kfRhLBaEmwRJ8shYb97pMcFmRgTSbTvqGGh2WolOCWOPJRUaungkH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240875706"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="240875706"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 08:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="466711252"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 08:14:54 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n04GT-0000kA-Gx; Wed, 22 Dec 2021 16:14:53 +0000
Date:   Thu, 23 Dec 2021 00:14:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, leon@kernel.org,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Message-ID: <202112230027.47XqoqUH-lkp@intel.com>
References: <20211221024858.25938-11-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221024858.25938-11-chengyou@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Cheng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v5.16-rc6 next-20211222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20211221-105044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: i386-randconfig-a014-20211220 (https://download.01.org/0day-ci/archive/20211223/202112230027.47XqoqUH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 555eacf75f21cd1dfc6363d73ad187b730349543)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8bafa2877f1dd44153ce36bb8a0a0c491f990b6b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20211221-105044
        git checkout 8bafa2877f1dd44153ce36bb8a0a0c491f990b6b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/rdma/erdma-abi.h:14:2: error: unknown type name 'u64'
           u64 db_record_va;
           ^
   ./usr/include/rdma/erdma-abi.h:15:2: error: unknown type name 'u64'
           u64 qbuf_va;
           ^
>> ./usr/include/rdma/erdma-abi.h:16:2: error: unknown type name 'u32'
           u32 qbuf_len;
           ^
   ./usr/include/rdma/erdma-abi.h:17:2: error: unknown type name 'u32'
           u32 rsvd0;
           ^
   ./usr/include/rdma/erdma-abi.h:21:2: error: unknown type name 'u32'
           u32 cq_id;
           ^
   ./usr/include/rdma/erdma-abi.h:22:2: error: unknown type name 'u32'
           u32 num_cqe;
           ^
   ./usr/include/rdma/erdma-abi.h:26:2: error: unknown type name 'u64'
           u64 db_record_va;
           ^
   ./usr/include/rdma/erdma-abi.h:27:2: error: unknown type name 'u64'
           u64 qbuf_va;
           ^
   ./usr/include/rdma/erdma-abi.h:28:2: error: unknown type name 'u32'
           u32 qbuf_len;
           ^
   ./usr/include/rdma/erdma-abi.h:29:2: error: unknown type name 'u32'
           u32 rsvd0;
           ^
   ./usr/include/rdma/erdma-abi.h:33:2: error: unknown type name 'u32'
           u32 qp_id;
           ^
   ./usr/include/rdma/erdma-abi.h:34:2: error: unknown type name 'u32'
           u32 num_sqe;
           ^
   ./usr/include/rdma/erdma-abi.h:35:2: error: unknown type name 'u32'
           u32 num_rqe;
           ^
   ./usr/include/rdma/erdma-abi.h:36:2: error: unknown type name 'u32'
           u32 rq_offset;
           ^
   ./usr/include/rdma/erdma-abi.h:40:2: error: unknown type name 'u32'
           u32 dev_id;
           ^
   ./usr/include/rdma/erdma-abi.h:41:2: error: unknown type name 'u32'
           u32 pad;
           ^
   ./usr/include/rdma/erdma-abi.h:42:2: error: unknown type name 'u32'
           u32 sdb_type;
           ^
   ./usr/include/rdma/erdma-abi.h:43:2: error: unknown type name 'u32'
           u32 sdb_offset;
           ^
   ./usr/include/rdma/erdma-abi.h:44:2: error: unknown type name 'u64'
           u64 sdb;
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
