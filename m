Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8937A71D0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 07:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjITFSQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 01:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITFSP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 01:18:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7D9F;
        Tue, 19 Sep 2023 22:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695187088; x=1726723088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RwF545D3aEX3rCro9ClSaDFWR4O8eRSEXZYKHUxDEJ8=;
  b=PAR2E9u+mYTBm70hoMynkJ/y5fFUouhwBzHdtEc1IICnWop+HP54CHLA
   YA0XjEF9w8NTKqRJhKELFhiiuuohtCAaKmyXbnTcGckpHAZ3zLvRLT05n
   71sOUUQ6oW0fzMuoocM7oKct9lESoCCZSswHa909EK9o+17uTdfNM9VXf
   HiiaJM5rNtFkuB7TYoD0w98jb/8g3tnQaR/WtJSZv3VjtE0n2896LyY5R
   CYnH7uDxiGDg0t/bjq2iBQ2ru4WEwGEnKyU38QTu6de48jtyWCUMk1JXq
   J6youBalBwUZzFOag6wDHAnUrPYBy/FVQWcoMdezRmMZb0dwK3Wltpa+/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359515762"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="359515762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="812001424"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="812001424"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 19 Sep 2023 22:18:06 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qipb9-0008Ko-3B;
        Wed, 20 Sep 2023 05:18:03 +0000
Date:   Wed, 20 Sep 2023 13:17:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com
Subject: Re: [PATCH for-next] RDMA/hns: Support SRQ record doorbell
Message-ID: <202309201334.ecTzlCD0-lkp@intel.com>
References: <20230920033005.1557-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920033005.1557-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Junxian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junxian-Huang/RDMA-hns-Support-SRQ-record-doorbell/20230920-113419
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20230920033005.1557-1-huangjunxian6%40hisilicon.com
patch subject: [PATCH for-next] RDMA/hns: Support SRQ record doorbell
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230920/202309201334.ecTzlCD0-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201334.ecTzlCD0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201334.ecTzlCD0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'hns_roce_v2_post_srq_recv':
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:960:30: warning: unused variable 'hr_dev' [-Wunused-variable]
     960 |         struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
         |                              ^~~~~~


vim +/hr_dev +960 drivers/infiniband/hw/hns/hns_roce_hw_v2.c

2b035e7312b508 Yixing Liu    2021-06-21   955  
ffb1308b88b602 Yixian Liu    2020-04-28   956  static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
ffb1308b88b602 Yixian Liu    2020-04-28   957  				     const struct ib_recv_wr *wr,
ffb1308b88b602 Yixian Liu    2020-04-28   958  				     const struct ib_recv_wr **bad_wr)
ffb1308b88b602 Yixian Liu    2020-04-28   959  {
ffb1308b88b602 Yixian Liu    2020-04-28  @960  	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
ffb1308b88b602 Yixian Liu    2020-04-28   961  	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
ffb1308b88b602 Yixian Liu    2020-04-28   962  	unsigned long flags;
ffb1308b88b602 Yixian Liu    2020-04-28   963  	int ret = 0;
2e07a3d945851f Wenpeng Liang 2021-01-30   964  	u32 max_sge;
2e07a3d945851f Wenpeng Liang 2021-01-30   965  	u32 wqe_idx;
ffb1308b88b602 Yixian Liu    2020-04-28   966  	void *wqe;
2e07a3d945851f Wenpeng Liang 2021-01-30   967  	u32 nreq;
ffb1308b88b602 Yixian Liu    2020-04-28   968  
ffb1308b88b602 Yixian Liu    2020-04-28   969  	spin_lock_irqsave(&srq->lock, flags);
ffb1308b88b602 Yixian Liu    2020-04-28   970  
9dd052474a2645 Lang Cheng    2021-01-30   971  	max_sge = srq->max_gs - srq->rsv_sge;
ffb1308b88b602 Yixian Liu    2020-04-28   972  	for (nreq = 0; wr; ++nreq, wr = wr->next) {
2e07a3d945851f Wenpeng Liang 2021-01-30   973  		ret = check_post_srq_valid(srq, max_sge, wr);
2e07a3d945851f Wenpeng Liang 2021-01-30   974  		if (ret) {
ffb1308b88b602 Yixian Liu    2020-04-28   975  			*bad_wr = wr;
ffb1308b88b602 Yixian Liu    2020-04-28   976  			break;
ffb1308b88b602 Yixian Liu    2020-04-28   977  		}
ffb1308b88b602 Yixian Liu    2020-04-28   978  
6b981e2bd9251f Xi Wang       2021-01-30   979  		ret = get_srq_wqe_idx(srq, &wqe_idx);
6b981e2bd9251f Xi Wang       2021-01-30   980  		if (unlikely(ret)) {
ffb1308b88b602 Yixian Liu    2020-04-28   981  			*bad_wr = wr;
ffb1308b88b602 Yixian Liu    2020-04-28   982  			break;
ffb1308b88b602 Yixian Liu    2020-04-28   983  		}
ffb1308b88b602 Yixian Liu    2020-04-28   984  
6b981e2bd9251f Xi Wang       2021-01-30   985  		wqe = get_srq_wqe_buf(srq, wqe_idx);
6b981e2bd9251f Xi Wang       2021-01-30   986  		fill_recv_sge_to_wqe(wr, wqe, max_sge, srq->rsv_sge);
2e07a3d945851f Wenpeng Liang 2021-01-30   987  		fill_wqe_idx(srq, wqe_idx);
ffb1308b88b602 Yixian Liu    2020-04-28   988  		srq->wrid[wqe_idx] = wr->wr_id;
ffb1308b88b602 Yixian Liu    2020-04-28   989  	}
ffb1308b88b602 Yixian Liu    2020-04-28   990  
ffb1308b88b602 Yixian Liu    2020-04-28   991  	if (likely(nreq)) {
14d4b5285cbe41 Yangyang Li   2023-09-20   992  		if (srq->cap_flags & HNS_ROCE_SRQ_CAP_RECORD_DB)
14d4b5285cbe41 Yangyang Li   2023-09-20   993  			*srq->rdb.db_record = srq->idx_que.head &
14d4b5285cbe41 Yangyang Li   2023-09-20   994  					      V2_DB_PRODUCER_IDX_M;
14d4b5285cbe41 Yangyang Li   2023-09-20   995  		else
14d4b5285cbe41 Yangyang Li   2023-09-20   996  			update_srq_db(srq);
ffb1308b88b602 Yixian Liu    2020-04-28   997  	}
ffb1308b88b602 Yixian Liu    2020-04-28   998  
ffb1308b88b602 Yixian Liu    2020-04-28   999  	spin_unlock_irqrestore(&srq->lock, flags);
ffb1308b88b602 Yixian Liu    2020-04-28  1000  
ffb1308b88b602 Yixian Liu    2020-04-28  1001  	return ret;
ffb1308b88b602 Yixian Liu    2020-04-28  1002  }
ffb1308b88b602 Yixian Liu    2020-04-28  1003  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
