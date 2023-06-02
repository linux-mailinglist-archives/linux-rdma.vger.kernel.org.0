Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C02F71F8BD
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 05:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFBDKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 23:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFBDKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 23:10:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D099
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 20:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685675405; x=1717211405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Gt8st/ryKSg8qnsIEF7QXkgeLEpi4pVanUVqfCBXlI=;
  b=lW5KLZPZT18tGhq7ADZdhkeACLHohuZXPWjgxgQOKHflzVPv0P/T4YWY
   m+dthakxvSVDegQ5KCHzpJgYsO23Go/EYk6L9spvHiBmm55dBIg7UEpFS
   37JKpRRUmkjzvx/l8McjkTJzrb/JERNgILrnfvBFADQqFUvDswVOTyY7k
   oqgIt6E98c1puMxx9vUZefyNqySBZTCOtvCyc8mqw/2wUENMFhRnt+yQc
   Unvs9XoTWbI7StTiAugLeoCDu10lw00cMBN4YvWaOBRHO1FxSXJJ8vLh8
   OTXae8EFS+LGVvYgGSllHeZiFJ93vanSx3kdlD2QwmwnIO71h0M/VHFua
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353246165"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="353246165"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 20:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="954284983"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="954284983"
Received: from lkp-server01.sh.intel.com (HELO d1d49124694e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 20:10:00 -0700
Received: from kbuild by d1d49124694e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4vAu-00001o-11;
        Fri, 02 Jun 2023 03:10:00 +0000
Date:   Fri, 2 Jun 2023 11:09:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org,
        sagi@grimberg.me
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-rdma@vger.kernel.org,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH for-rc 1/3] IB/isert: Fix dead lock in ib_isert
Message-ID: <202306021038.ms6aIjpB-lkp@intel.com>
References: <20230601094220.64810-2-saravanan.vajravel@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094220.64810-2-saravanan.vajravel@broadcom.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Saravanan,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.4-rc4 next-20230601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saravanan-Vajravel/IB-isert-Fix-dead-lock-in-ib_isert/20230601-225628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20230601094220.64810-2-saravanan.vajravel%40broadcom.com
patch subject: [PATCH for-rc 1/3] IB/isert: Fix dead lock in ib_isert
config: arm64-randconfig-r025-20230531 (https://download.01.org/0day-ci/archive/20230602/202306021038.ms6aIjpB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/c7031144a2a9b6f14201977b35600ab80ee30e09
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Saravanan-Vajravel/IB-isert-Fix-dead-lock-in-ib_isert/20230601-225628
        git checkout c7031144a2a9b6f14201977b35600ab80ee30e09
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/infiniband/ulp/isert/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021038.ms6aIjpB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/infiniband/ulp/isert/ib_isert.c:2454:54: error: expected ';' after expression
                           list_move_tail(&isert_conn->node, &drop_conn_list)
                                                                             ^
                                                                             ;
   1 error generated.


vim +2454 drivers/infiniband/ulp/isert/ib_isert.c

  2428	
  2429	static void
  2430	isert_free_np(struct iscsi_np *np)
  2431	{
  2432		struct isert_np *isert_np = np->np_context;
  2433		struct isert_conn *isert_conn, *n;
  2434		LIST_HEAD(drop_conn_list);
  2435	
  2436		if (isert_np->cm_id)
  2437			rdma_destroy_id(isert_np->cm_id);
  2438	
  2439		/*
  2440		 * FIXME: At this point we don't have a good way to insure
  2441		 * that at this point we don't have hanging connections that
  2442		 * completed RDMA establishment but didn't start iscsi login
  2443		 * process. So work-around this by cleaning up what ever piled
  2444		 * up in accepted and pending lists.
  2445		 */
  2446		mutex_lock(&isert_np->mutex);
  2447		if (!list_empty(&isert_np->pending)) {
  2448			isert_info("Still have isert pending connections\n");
  2449			list_for_each_entry_safe(isert_conn, n,
  2450						 &isert_np->pending,
  2451						 node) {
  2452				isert_info("cleaning isert_conn %p state (%d)\n",
  2453					   isert_conn, isert_conn->state);
> 2454				list_move_tail(&isert_conn->node, &drop_conn_list)
  2455			}
  2456		}
  2457	
  2458		if (!list_empty(&isert_np->accepted)) {
  2459			isert_info("Still have isert accepted connections\n");
  2460			list_for_each_entry_safe(isert_conn, n,
  2461						 &isert_np->accepted,
  2462						 node) {
  2463				isert_info("cleaning isert_conn %p state (%d)\n",
  2464					   isert_conn, isert_conn->state);
  2465				list_move_tail(&isert_conn->node, &drop_conn_list);
  2466			}
  2467		}
  2468		mutex_unlock(&isert_np->mutex);
  2469	
  2470		list_for_each_entry_safe(isert_conn, n, &drop_conn_list, node) {
  2471			list_del_init(&isert_conn->node);
  2472			isert_connect_release(isert_conn);
  2473		}
  2474	
  2475		np->np_context = NULL;
  2476		kfree(isert_np);
  2477	}
  2478	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
