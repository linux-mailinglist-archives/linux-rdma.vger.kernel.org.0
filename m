Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B7D7E71B2
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 19:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbjKISt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 13:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKIStZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 13:49:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1AD185;
        Thu,  9 Nov 2023 10:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699555764; x=1731091764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pn7fi9X3+8b67fGa5JWM/IqMf8NynHWVA8y/+7uZeoA=;
  b=lhix2s5IOqGEew6NAVokhC8srJ2WTxF0SMjpcqA+nMERlO1ywLJWAo1C
   T6fAzG6TlGsRRank/PpBH9Nd5kRK87Oa0mEbWN+8GcE2XifJWvxE6YLfC
   a/y1yUU+HxHpgFgOdHfvXEtZUTX7PkKeZpCK41WYbHlPR4/aWnZZfdlgR
   BWhS8lA00OTrbHeB6dBPCMMv0Lxv8cikbIpjJQ74B921F90zxZxXMy1DK
   iwtdXXp4v+QflRRoTEQkKY2sLsttECHCLgfdqO98RE5lVD9YLu5PYjfHZ
   HfdkyjQ/grWUBPeGSlYJ3dwHIsofydZAgSc6yG6CEPAwjla3KJeox74GA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3033663"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="3033663"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 10:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829414673"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="829414673"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2023 10:49:20 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1A5d-00092s-1r;
        Thu, 09 Nov 2023 18:49:17 +0000
Date:   Fri, 10 Nov 2023 02:49:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next v7 5/7] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Message-ID: <202311100130.efgRVVKL-lkp@intel.com>
References: <5d46bd682aa8e3d5cabc38ca1cd67d2976f2731d.1699503619.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d46bd682aa8e3d5cabc38ca1cd67d2976f2731d.1699503619.git.matsuda-daisuke@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Daisuke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.6 next-20231109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daisuke-Matsuda/RDMA-rxe-Always-defer-tasks-on-responder-and-completer-to-workqueue/20231109-185612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/5d46bd682aa8e3d5cabc38ca1cd67d2976f2731d.1699503619.git.matsuda-daisuke%40fujitsu.com
patch subject: [PATCH for-next v7 5/7] RDMA/rxe: Allow registering MRs for On-Demand Paging
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231110/202311100130.efgRVVKL-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100130.efgRVVKL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100130.efgRVVKL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/sw/rxe/rxe_odp.c: In function 'rxe_mr_set_xarray':
>> drivers/infiniband/sw/rxe/rxe_odp.c:35:22: warning: variable 'entry' set but not used [-Wunused-but-set-variable]
      35 |         void *page, *entry;
         |                      ^~~~~


vim +/entry +35 drivers/infiniband/sw/rxe/rxe_odp.c

    29	
    30	static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
    31				      unsigned long end, unsigned long *pfn_list)
    32	{
    33		unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
    34		unsigned long lower = rxe_mr_iova_to_index(mr, start);
  > 35		void *page, *entry;
    36	
    37		XA_STATE(xas, &mr->page_list, lower);
    38	
    39		xas_lock(&xas);
    40		while (xas.xa_index <= upper) {
    41			if (pfn_list[xas.xa_index] & HMM_PFN_WRITE) {
    42				page = xa_tag_pointer(hmm_pfn_to_page(pfn_list[xas.xa_index]),
    43						      RXE_ODP_WRITABLE_BIT);
    44			} else
    45				page = hmm_pfn_to_page(pfn_list[xas.xa_index]);
    46	
    47			xas_store(&xas, page);
    48			entry = xas_next(&xas);
    49		}
    50		xas_unlock(&xas);
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
