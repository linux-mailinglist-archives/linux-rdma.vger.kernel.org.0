Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB37BE321
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjJIOkI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIOkI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 10:40:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E989E
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696862406; x=1728398406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uXn/96kJnN3Eu+KyOgnQKBGPfvPAwt8m3cgkG8ntCQ=;
  b=iJ4Fk20sdy2RrKsJ7jyI0lhGDXKFOUHUaq7P2bkTb8cfPh4ui2ZZQ58U
   GI/soYxzBHZk+Z8XKAca4yl4Hpya9ynUmpmH1/E6CZY0d2h/EflnMPj8Z
   wjuOMRlwVFviMLdbjQJ8EgJds/a8iWRBFcCP2pf2JxjBKOFfkqLg2deTm
   f6TRQBTJvhPhbxW46ok5ENUk+kbXguiDQh5XOn9HWStf+bC+Ei2AHJjJV
   YRHpiZ9Ee3u73FYqam21OejvhvCAlpTiQ3CZbFQ8pveSX76zKgrb8BOfq
   Noi0cPt/QwO1RUDqVbpw+QxH5O4h+V5FXkvras1pAfqeH57EtEeULbOHn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448346034"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="448346034"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 07:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="876811190"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="876811190"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Oct 2023 07:40:03 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qprQP-0000Hq-0j;
        Mon, 09 Oct 2023 14:40:01 +0000
Date:   Mon, 9 Oct 2023 22:39:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, bmt@zurich.ibm.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
Message-ID: <202310092226.zEUwIrFa-lkp@intel.com>
References: <20231009071801.10210-13-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009071801.10210-13-guoqing.jiang@linux.dev>
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
patch link:    https://lore.kernel.org/r/20231009071801.10210-13-guoqing.jiang%40linux.dev
patch subject: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
config: x86_64-randconfig-071-20231009 (https://download.01.org/0day-ci/archive/20231009/202310092226.zEUwIrFa-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310092226.zEUwIrFa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310092226.zEUwIrFa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/siw/siw_cm.c:367:6: warning: no previous declaration for 'siw_free_cm_id' [-Wmissing-declarations]
    void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
         ^~~~~~~~~~~~~~


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
