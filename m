Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6576736A3C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjFTLFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFTLFQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 07:05:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71CAE41
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687259115; x=1718795115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FlD9EqEAehVX55CqKmIz5nVWbCKGN9LWDUnA94CZ798=;
  b=NFEluB2de+QJ/miya2frA6FeVM4Zf34ZHygcYSZCWM662xQrx31hLPsr
   FhO2gBKWmz4Der7MPJ5EZfLJYwIYBfDdvi1LetG1mhqB9bVt8HbJLJT1u
   6vkmlh5NaxQCucooixx9WFo6n83RVM536UBYzALShJwKyhsUFPm7whogz
   CwwkljOVhKRGr8J9O82SbDeEwzFdbOoaAtGN47FRpwnXH5eeetBVlFwpV
   ua3ryUjpCaWajMWtMqZYtEdlWOEaFY3JsHsDHfqxvI7sSYiM7HkA64VJT
   sJGzkF/EkLi8s/IKAG2DUK7vNRC3yT25U8pW/MIGwoLI32VVzP+6QLsZF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="363251780"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="363251780"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 04:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="784032418"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="784032418"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2023 04:05:13 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBZAe-0005pY-0h;
        Tue, 20 Jun 2023 11:05:12 +0000
Date:   Tue, 20 Jun 2023 19:04:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next 3/3] RDMA/rxe: Fix rxe_m-dify_srq
Message-ID: <202306201807.sCYZpuDH-lkp@intel.com>
References: <20230619202110.45680-4-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619202110.45680-4-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 830f93f47068b1632cc127871fbf27e918efdf46]

url:    https://github.com/intel-lab-lkp/linux/commits/Bob-Pearson/RDMA-rxe-Move-work-queue-code-to-subroutines/20230620-042342
base:   830f93f47068b1632cc127871fbf27e918efdf46
patch link:    https://lore.kernel.org/r/20230619202110.45680-4-rpearsonhpe%40gmail.com
patch subject: [PATCH for-next 3/3] RDMA/rxe: Fix rxe_m-dify_srq
config: x86_64-randconfig-a005-20230620 (https://download.01.org/0day-ci/archive/20230620/202306201807.sCYZpuDH-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201807.sCYZpuDH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201807.sCYZpuDH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/rxe/rxe_srq.c:73:18: warning: variable 'q' is uninitialized when used here [-Wuninitialized]
           srq->rq.queue = q;
                           ^
   drivers/infiniband/sw/rxe/rxe_srq.c:50:21: note: initialize the variable 'q' to silence this warning
           struct rxe_queue *q;
                              ^
                               = NULL
   1 warning generated.


vim +/q +73 drivers/infiniband/sw/rxe/rxe_srq.c

8700e3e7c4857d Moni Shoua         2016-06-16   43  
8700e3e7c4857d Moni Shoua         2016-06-16   44  int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
ff23dfa134576e Shamir Rabinovitch 2019-03-31   45  		      struct ib_srq_init_attr *init, struct ib_udata *udata,
0c43ab371bcb07 Jason Gunthorpe    2018-03-13   46  		      struct rxe_create_srq_resp __user *uresp)
8700e3e7c4857d Moni Shoua         2016-06-16   47  {
8700e3e7c4857d Moni Shoua         2016-06-16   48  	int err;
06e1f13ffd8b02 Bob Pearson        2023-06-19   49  	int wqe_size;
8700e3e7c4857d Moni Shoua         2016-06-16   50  	struct rxe_queue *q;
8700e3e7c4857d Moni Shoua         2016-06-16   51  
8700e3e7c4857d Moni Shoua         2016-06-16   52  	srq->ibsrq.event_handler = init->event_handler;
8700e3e7c4857d Moni Shoua         2016-06-16   53  	srq->ibsrq.srq_context = init->srq_context;
8700e3e7c4857d Moni Shoua         2016-06-16   54  	srq->limit = init->attr.srq_limit;
02827b67085162 Bob Pearson        2021-11-03   55  	srq->srq_num = srq->elem.index;
8700e3e7c4857d Moni Shoua         2016-06-16   56  	srq->rq.max_wr = init->attr.max_wr;
8700e3e7c4857d Moni Shoua         2016-06-16   57  	srq->rq.max_sge = init->attr.max_sge;
8700e3e7c4857d Moni Shoua         2016-06-16   58  
06e1f13ffd8b02 Bob Pearson        2023-06-19   59  	wqe_size = sizeof(struct rxe_recv_wqe) +
06e1f13ffd8b02 Bob Pearson        2023-06-19   60  			srq->rq.max_sge*sizeof(struct ib_sge);
8700e3e7c4857d Moni Shoua         2016-06-16   61  
8700e3e7c4857d Moni Shoua         2016-06-16   62  	spin_lock_init(&srq->rq.producer_lock);
8700e3e7c4857d Moni Shoua         2016-06-16   63  	spin_lock_init(&srq->rq.consumer_lock);
8700e3e7c4857d Moni Shoua         2016-06-16   64  
06e1f13ffd8b02 Bob Pearson        2023-06-19   65  	srq->rq.queue = rxe_queue_init(rxe, &srq->rq.max_wr, wqe_size,
06e1f13ffd8b02 Bob Pearson        2023-06-19   66  				       QUEUE_TYPE_FROM_CLIENT);
06e1f13ffd8b02 Bob Pearson        2023-06-19   67  	if (!srq->rq.queue) {
0e6090024b3ebf Bob Pearson        2022-11-03   68  		rxe_dbg_srq(srq, "Unable to allocate queue\n");
06e1f13ffd8b02 Bob Pearson        2023-06-19   69  		err = -ENOMEM;
06e1f13ffd8b02 Bob Pearson        2023-06-19   70  		goto err_out;
8700e3e7c4857d Moni Shoua         2016-06-16   71  	}
8700e3e7c4857d Moni Shoua         2016-06-16   72  
8700e3e7c4857d Moni Shoua         2016-06-16  @73  	srq->rq.queue = q;
8700e3e7c4857d Moni Shoua         2016-06-16   74  
ff23dfa134576e Shamir Rabinovitch 2019-03-31   75  	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
8700e3e7c4857d Moni Shoua         2016-06-16   76  			   q->buf_size, &q->ip);
aae0484e15f062 Zhu Yanjun         2018-09-30   77  	if (err) {
06e1f13ffd8b02 Bob Pearson        2023-06-19   78  		rxe_dbg_srq(srq, "Unable to init mmap info for caller\n");
06e1f13ffd8b02 Bob Pearson        2023-06-19   79  		goto err_free;
aae0484e15f062 Zhu Yanjun         2018-09-30   80  	}
8700e3e7c4857d Moni Shoua         2016-06-16   81  
06e1f13ffd8b02 Bob Pearson        2023-06-19   82  	init->attr.max_wr = srq->rq.max_wr;
06e1f13ffd8b02 Bob Pearson        2023-06-19   83  
0c43ab371bcb07 Jason Gunthorpe    2018-03-13   84  	if (uresp) {
0c43ab371bcb07 Jason Gunthorpe    2018-03-13   85  		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
aae0484e15f062 Zhu Yanjun         2018-09-30   86  				 sizeof(uresp->srq_num))) {
aae0484e15f062 Zhu Yanjun         2018-09-30   87  			rxe_queue_cleanup(q);
8700e3e7c4857d Moni Shoua         2016-06-16   88  			return -EFAULT;
8700e3e7c4857d Moni Shoua         2016-06-16   89  		}
aae0484e15f062 Zhu Yanjun         2018-09-30   90  	}
0c43ab371bcb07 Jason Gunthorpe    2018-03-13   91  
8700e3e7c4857d Moni Shoua         2016-06-16   92  	return 0;
06e1f13ffd8b02 Bob Pearson        2023-06-19   93  
06e1f13ffd8b02 Bob Pearson        2023-06-19   94  err_free:
06e1f13ffd8b02 Bob Pearson        2023-06-19   95  	vfree(q->buf);
06e1f13ffd8b02 Bob Pearson        2023-06-19   96  	kfree(q);
06e1f13ffd8b02 Bob Pearson        2023-06-19   97  err_out:
06e1f13ffd8b02 Bob Pearson        2023-06-19   98  	return err;
8700e3e7c4857d Moni Shoua         2016-06-16   99  }
8700e3e7c4857d Moni Shoua         2016-06-16  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
