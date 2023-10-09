Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C173E7BD61B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 11:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbjJIJDX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 05:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345719AbjJIJDT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 05:03:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDDFAC
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696842196; x=1728378196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UqkdLgO+1YNE6cx0J68k6qImrNrQtBBB57h9OlynnQM=;
  b=IpXT90KvY9yn2QSYQXNqdMDWw/Vz+C4ADDTfSVwSkVT4mzJHi+UddcwV
   l2C/f9fYnLIxEj5xwvQjkToCbb9aZVkaXgohSBKheJDr/FuyNaSxsBvvL
   Df3K84CWQxHDgsEskqo/wF2Zu+P8IdlOI86fL+sRSou3kbfSYHgrF7tUk
   h4XP3/teL+13DAveu6YksTMB1W/H7dyWiDAsPVkzT+ydgQ4DYjkgqarXp
   N6enYQBc7JsSeF8fEoqewXyZ4zamgY5FFioRQQoF5dGjAscW/EZfusXA1
   F66WlEjBIKee20B5gSEr+mai9qC1u/XgdzqHl73RsUv/ig+Hc6QqHBFMp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="382977274"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="382977274"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 02:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="756648026"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="756648026"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Oct 2023 02:03:13 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpmAR-00002o-34;
        Mon, 09 Oct 2023 09:03:11 +0000
Date:   Mon, 9 Oct 2023 17:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, bmt@zurich.ibm.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
Message-ID: <202310091656.JlrmcNXB-lkp@intel.com>
References: <20231009071801.10210-13-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009071801.10210-13-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20231009071801.10210-13-guoqing.jiang%40linux.dev
patch subject: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231009/202310091656.JlrmcNXB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310091656.JlrmcNXB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310091656.JlrmcNXB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/siw/siw_cm.c:367:6: warning: no previous prototype for 'siw_free_cm_id' [-Wmissing-prototypes]
     367 | void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
         |      ^~~~~~~~~~~~~~


vim +/siw_free_cm_id +367 drivers/infiniband/sw/siw/siw_cm.c

   366	
 > 367	void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
   368	{
   369		if (!cep->cm_id)
   370			return;
   371	
   372		cep->cm_id->rem_ref(cep->cm_id);
   373		cep->cm_id = NULL;
   374		if (put_cep)
   375			siw_cep_put(cep);
   376	}
   377	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
