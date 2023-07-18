Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2361D758339
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 19:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGRRGh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjGRRGf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 13:06:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F21739;
        Tue, 18 Jul 2023 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689699967; x=1721235967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CEwwrjwPfBcE3oHaafHaOcaByORj1Xv2apS2NjCY/9c=;
  b=IGR5rkqaOeSM7p5JhFVdy+RPyiKbpBG2yODuN9SFU5x6rQ6XddgBXZ53
   n4uunr3P99/HRbEaKChxTKDql3WYvTGpmo4rKu5Qa10XRNxvbWNqp1lw6
   Nnc5yzcqd9jyjCbQLrd/7EyGry/ESVF5JBLLYk6l/IRfwJ06uP6M59ekl
   ynt29aYr9v1BJdW/JDFl+HP3c4jFW4QvgLC1gRwpiruFv8pY5f/B8A4OI
   xhTVi0aoE6KeL0I7rBS/6JP/kNoheudVkyXhNnIqt7mjlonIFhT0mvarq
   AyPOPzQ1n2Q06GrT4fN05W+Y9m4Ie5mSBHf37QkxUAAJxv9HROcvTYWDx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369818793"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="369818793"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="813831154"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="813831154"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jul 2023 10:05:24 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLo7t-0001jn-25;
        Tue, 18 Jul 2023 17:04:48 +0000
Date:   Wed, 19 Jul 2023 01:02:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Junxian Huang <huangjunxian6@hisilicon.com>, jgg@nvidia.com,
        leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com
Subject: Re: [PATCH v2 for-rc 3/3] RDMA/hns: Add check and adjust for
 function resource values
Message-ID: <202307190042.hWzQQIOk-lkp@intel.com>
References: <20230717060340.453850-4-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717060340.453850-4-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Junxian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junxian-Huang/RDMA-hns-support-get-xrcd-num-from-firmware/20230718-171525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20230717060340.453850-4-huangjunxian6%40hisilicon.com
patch subject: [PATCH v2 for-rc 3/3] RDMA/hns: Add check and adjust for function resource values
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230719/202307190042.hWzQQIOk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307190042.hWzQQIOk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307190042.hWzQQIOk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'adjust_res_caps':
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1709:53: warning: passing argument 2 of 'check_res_is_supported' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1709 |                 if (!check_res_is_supported(hr_dev, &bt_num_table[i]))
         |                                                     ^~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1673:60: note: expected 'struct hns_roce_bt_num *' but argument is of type 'const struct hns_roce_bt_num *'
    1673 |                                    struct hns_roce_bt_num *bt_num_entry)
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~


vim +1709 drivers/infiniband/hw/hns/hns_roce_hw_v2.c

  1699	
  1700	static u16 adjust_res_caps(struct hns_roce_dev *hr_dev)
  1701	{
  1702		struct hns_roce_caps *caps = &hr_dev->caps;
  1703		u16 invalid_flag = 0;
  1704		u32 min, max;
  1705		u32 *res;
  1706		int i;
  1707	
  1708		for (i = 0; i < ARRAY_SIZE(bt_num_table); i++) {
> 1709			if (!check_res_is_supported(hr_dev, &bt_num_table[i]))
  1710				continue;
  1711	
  1712			res = (u32 *)((void *)caps + bt_num_table[i].res_offset);
  1713			min = bt_num_table[i].min;
  1714			max = bt_num_table[i].max;
  1715			if (*res < min || *res > max) {
  1716				*res = *res < min ? min : max;
  1717				invalid_flag |= 1 << bt_num_table[i].invalid_flag;
  1718			}
  1719		}
  1720	
  1721		adjust_eqc_bt_num(caps, &invalid_flag);
  1722	
  1723		return invalid_flag;
  1724	}
  1725	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
