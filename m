Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2068B7E491B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Nov 2023 20:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjKGTWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Nov 2023 14:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjKGTWG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Nov 2023 14:22:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3968F
        for <linux-rdma@vger.kernel.org>; Tue,  7 Nov 2023 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699384924; x=1730920924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bq0CBJNm7x6CyH3CjMrhzf+CxNC1+YToHhVahC03PxU=;
  b=iErz9KSLHkEbAIuhg8tYkl5b7h6w6c28RbxYbzkxz37Iu4TAN05KQVHR
   exO65WtJxIMLkVDQVBP4SWsx5wij1xXiBE/PAlG5OHjMTuFUUfRoK/Mvv
   SaUbOKb02vZ5Gh2swRiUJRZFNFdbBNjC9blffeEV41XFNAIfvySd8HB3x
   kLinDW8T9hw+aSfN3TROvNwHslN8Ri63axmdo3/RF5+G/MuIkG9xshjU5
   0Lz4tvhnAd7HNUS3PXy6sJmS81Nr29SKLI7rtcNBHJzlJQkZgEmS8tJDc
   OcB3pXy/buaOiGON9RBeoiqp/riFMeMJlFJkQBQ0tqz/N9aSxiYwdVb/Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="475831156"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="475831156"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="3902614"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Nov 2023 11:22:03 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0ReB-0007Ls-2p;
        Tue, 07 Nov 2023 19:21:59 +0000
Date:   Wed, 8 Nov 2023 03:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v2 3/6] RDMA/rxe: Register IP mcast address
Message-ID: <202311080240.accUSSHq-lkp@intel.com>
References: <20231106152928.47869-4-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106152928.47869-4-rpearsonhpe@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.6 next-20231107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bob-Pearson/RDMA-rxe-Cleanup-rxe_ah-av_chk_attr/20231107-005913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20231106152928.47869-4-rpearsonhpe%40gmail.com
patch subject: [PATCH for-next v2 3/6] RDMA/rxe: Register IP mcast address
config: csky-randconfig-002-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080240.accUSSHq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080240.accUSSHq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080240.accUSSHq-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/infiniband/sw/rxe/rxe_mcast.o: in function `rxe_mcast_add':
>> rxe_mcast.c:(.text+0x42): undefined reference to `ipv6_sock_mc_join'
>> csky-linux-ld: rxe_mcast.c:(.text+0xa6): undefined reference to `ipv6_sock_mc_drop'
   csky-linux-ld: drivers/infiniband/sw/rxe/rxe_mcast.o: in function `__rxe_init_mca':
   rxe_mcast.c:(.text+0x1a8): undefined reference to `ipv6_sock_mc_join'
   csky-linux-ld: rxe_mcast.c:(.text+0x1b4): undefined reference to `ipv6_sock_mc_drop'
   csky-linux-ld: drivers/infiniband/sw/rxe/rxe_mcast.o: in function `rxe_attach_mcast':
>> rxe_mcast.c:(.text+0x5d6): undefined reference to `ipv6_sock_mc_drop'
   csky-linux-ld: rxe_mcast.c:(.text+0x60c): undefined reference to `ipv6_sock_mc_drop'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
