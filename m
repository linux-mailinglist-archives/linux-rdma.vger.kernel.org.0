Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDB6E81FA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDSTiG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 15:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDSTiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 15:38:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0865FDD;
        Wed, 19 Apr 2023 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681933085; x=1713469085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t1OsSZQnF1LZH4+Xjffqd401TNQIEsaRxkp8+pmezZ8=;
  b=jt6G4hhcqWl20ycmhlcEWjbY6v1MZ99wzDoJbWpx6ljOpE4+bDT9ACmo
   1oVZ1iPuJ+jraVYQLsl+HgXoPRPYhyqo2uFs5te/r7E00JmUZQlJNwgen
   hTWDx+Y5pmfNk7Yg4QzmS+klP6lSRHO3gGzQ7FgUj7L52fDcqtD1Yy7m7
   K4LFdU6b6BqWys5lPToTWjcmFLW4DIGfN7zEwAYRkpTBw8/uoQT8gSV36
   gvoUz858w3eHn4EHjTBW+gn26M+6JjE9CrfdXbs4tuqXvzXcafM0BE5y0
   lXyRJy/cPje0uB6jILB1EGD0u+lTPyOE2vcvTJUU5XmG9T1kTsg7VWZR4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373430548"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="373430548"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 12:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="835436561"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="835436561"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2023 12:38:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppDcv-000f8Q-2a;
        Wed, 19 Apr 2023 19:38:01 +0000
Date:   Thu, 20 Apr 2023 03:37:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next v4 2/8] RDMA/rxe: Always schedule works before
 accessing user MRs
Message-ID: <202304200354.oGlN33Lg-lkp@intel.com>
References: <7441c59fcea601c03c70ec03b5d17a69032e51f8.1681882651.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7441c59fcea601c03c70ec03b5d17a69032e51f8.1681882651.git.matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Daisuke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f605f26ea196a3b49bea249330cbd18dba61a33e]

url:    https://github.com/intel-lab-lkp/linux/commits/Daisuke-Matsuda/RDMA-rxe-Tentative-workqueue-implementation/20230419-135731
base:   f605f26ea196a3b49bea249330cbd18dba61a33e
patch link:    https://lore.kernel.org/r/7441c59fcea601c03c70ec03b5d17a69032e51f8.1681882651.git.matsuda-daisuke%40fujitsu.com
patch subject: [PATCH for-next v4 2/8] RDMA/rxe: Always schedule works before accessing user MRs
config: x86_64-randconfig-a011-20230417 (https://download.01.org/0day-ci/archive/20230420/202304200354.oGlN33Lg-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/493fb0777100e2e1b6358176e84b4b29372105ae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daisuke-Matsuda/RDMA-rxe-Tentative-workqueue-implementation/20230419-135731
        git checkout 493fb0777100e2e1b6358176e84b4b29372105ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/infiniband/sw/rxe/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200354.oGlN33Lg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/rxe/rxe_comp.c:139:36: warning: converting the enum constant to a boolean [-Wint-in-bool-context]
           if (pkt->mask | (RXE_PAYLOAD_MASK || RXE_ATMACK_MASK))
                                             ^
   1 warning generated.


vim +139 drivers/infiniband/sw/rxe/rxe_comp.c

   128	
   129	void rxe_comp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
   130	{
   131		struct rxe_qp *qp = pkt->qp;
   132		int must_sched;
   133	
   134		skb_queue_tail(&qp->resp_pkts, skb);
   135	
   136		/* Schedule the task if processing Read responses or Atomic acks.
   137		 * In these cases, completer may sleep to access ODP-enabled MRs.
   138		 */
 > 139		if (pkt->mask | (RXE_PAYLOAD_MASK || RXE_ATMACK_MASK))
   140			must_sched = 1;
   141		else
   142			must_sched = skb_queue_len(&qp->resp_pkts) > 1;
   143	
   144		if (must_sched != 0)
   145			rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
   146	
   147		if (must_sched)
   148			rxe_sched_task(&qp->comp.task);
   149		else
   150			rxe_run_task(&qp->comp.task);
   151	}
   152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
