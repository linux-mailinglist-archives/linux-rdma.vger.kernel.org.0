Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1F7BD7BD
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbjJIJzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345989AbjJIJzv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 05:55:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B99C5
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696845348; x=1728381348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JVNqKkR5qwbo2qWTMUgh18TU2knKIf7RNluIkUMDHyA=;
  b=mL1rj1PdKbtaTS8o4XSQLhqfbSFw+rB0mFTXoiU7h9uFo7S7YWCtqD7f
   l/QFf8SYlw9v1gC9zRiWP+Rzk7qiM525PYTaAIHkrEMrlERJTRSbFqVSB
   nviZvQsGC62BT+3kKAhA0iU4HiH2pXvmSDZ3hTFRooxTXzZWQ710M0ucA
   R7rS22TuVP0Mv2kJ6ABUWvujnn5aiZ7jt+ONqfpIj4loBU/6+6EXlkq1f
   u5af75zCbvL9WcBaPDDM8qOe+xSo9RM15Jhp1tatC+hJ3mT1DwC5vfIRP
   DoTRhVVIXg9rdSyxd+88mB3iqYf887A/k3dUq8qBHlul3x8T3byG8Du5G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="369171903"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369171903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 02:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="843644504"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="843644504"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2023 02:55:35 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpmz6-00004q-2G;
        Mon, 09 Oct 2023 09:55:32 +0000
Date:   Mon, 9 Oct 2023 17:54:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, bmt@zurich.ibm.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 19/19] RDMA/siw: Introduce siw_destroy_cep_sock
Message-ID: <202310091735.oG7bTvLR-lkp@intel.com>
References: <20231009071801.10210-20-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009071801.10210-20-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Guoqing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.6-rc5 next-20231009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guoqing-Jiang/RDMA-siw-Introduce-siw_get_page/20231009-152705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20231009071801.10210-20-guoqing.jiang%40linux.dev
patch subject: [PATCH 19/19] RDMA/siw: Introduce siw_destroy_cep_sock
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231009/202310091735.oG7bTvLR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310091735.oG7bTvLR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310091735.oG7bTvLR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/sw/siw/siw_cm.c:360:6: warning: no previous prototype for 'siw_free_cm_id' [-Wmissing-prototypes]
     360 | void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
         |      ^~~~~~~~~~~~~~
>> drivers/infiniband/sw/siw/siw_cm.c:371:6: warning: no previous prototype for 'siw_destroy_cep_sock' [-Wmissing-prototypes]
     371 | void siw_destroy_cep_sock(struct siw_cep *cep)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/siw_destroy_cep_sock +371 drivers/infiniband/sw/siw/siw_cm.c

   370	
 > 371	void siw_destroy_cep_sock(struct siw_cep *cep)
   372	{
   373		if (cep->sock) {
   374			siw_socket_disassoc(cep->sock);
   375			sock_release(cep->sock);
   376			cep->sock = NULL;
   377		}
   378	}
   379	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
