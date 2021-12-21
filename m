Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E573547BF30
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 12:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhLUL56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 06:57:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:32045 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhLUL56 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 06:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640087878; x=1671623878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCJ5MwsforBAFoewQTKw32dd/n1f7+H0JiRPmXrjV24=;
  b=jO2xG6hjPyt5FZyZTsBRZvX4myvpwJKM5yP0p6U4bJEgZoryDQe5h7C/
   eX0FnbpLAEDiAYCp1QBXSYCXdaaH+FQNiU6isxLcEZc4ycDC76bEH91fY
   itZLgmeZu7MjVZoANcrU2honXZzw5BV1fzp2DuvY4T2wV+V6TrQFf3nMl
   WTaSWLOxKgrUq5cWatVnrQ9ZPlDmy9hzVtajtHqteLxrKSW5EpoqJahjz
   iYyXOHZIA2/lGtRK9h5h6weDtlTE4bJaZdHuqfbNzN76m0ScZ2M9YWdQu
   tJR+hRS8UWLYs2wKzpEKUalN9Q4fqERqloPn8XSA+iocu16XRg8iua+aI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303749459"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="303749459"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 03:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="484392979"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Dec 2021 03:57:55 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzdmF-00093V-3l; Tue, 21 Dec 2021 11:57:55 +0000
Date:   Tue, 21 Dec 2021 19:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     kbuild-all@lists.01.org, leon@kernel.org,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 10/11] RDMA/erdma: Add the ABI definitions
Message-ID: <202112211925.cA7D5851-lkp@intel.com>
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
[also build test ERROR on linus/master v5.16-rc6 next-20211220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20211221-105044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: x86_64-randconfig-a004-20211220 (https://download.01.org/0day-ci/archive/20211221/202112211925.cA7D5851-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/8bafa2877f1dd44153ce36bb8a0a0c491f990b6b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20211221-105044
        git checkout 8bafa2877f1dd44153ce36bb8a0a0c491f990b6b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/rdma/erdma-abi.h:14:2: error: unknown type name 'u64'
      14 |  u64 db_record_va;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:15:2: error: unknown type name 'u64'
      15 |  u64 qbuf_va;
         |  ^~~
>> ./usr/include/rdma/erdma-abi.h:16:2: error: unknown type name 'u32'
      16 |  u32 qbuf_len;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:17:2: error: unknown type name 'u32'
      17 |  u32 rsvd0;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:21:2: error: unknown type name 'u32'
      21 |  u32 cq_id;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:22:2: error: unknown type name 'u32'
      22 |  u32 num_cqe;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:26:2: error: unknown type name 'u64'
      26 |  u64 db_record_va;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:27:2: error: unknown type name 'u64'
      27 |  u64 qbuf_va;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:28:2: error: unknown type name 'u32'
      28 |  u32 qbuf_len;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:29:2: error: unknown type name 'u32'
      29 |  u32 rsvd0;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:33:2: error: unknown type name 'u32'
      33 |  u32 qp_id;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:34:2: error: unknown type name 'u32'
      34 |  u32 num_sqe;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:35:2: error: unknown type name 'u32'
      35 |  u32 num_rqe;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:36:2: error: unknown type name 'u32'
      36 |  u32 rq_offset;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:40:2: error: unknown type name 'u32'
      40 |  u32 dev_id;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:41:2: error: unknown type name 'u32'
      41 |  u32 pad;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:42:2: error: unknown type name 'u32'
      42 |  u32 sdb_type;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:43:2: error: unknown type name 'u32'
      43 |  u32 sdb_offset;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:44:2: error: unknown type name 'u64'
      44 |  u64 sdb;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:45:2: error: unknown type name 'u64'
      45 |  u64 rdb;
         |  ^~~
   ./usr/include/rdma/erdma-abi.h:46:2: error: unknown type name 'u64'
      46 |  u64 cdb;
         |  ^~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
