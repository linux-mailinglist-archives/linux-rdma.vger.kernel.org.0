Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603257280A7
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjFHMzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 08:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjFHMze (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 08:55:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F430E0
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686228910; x=1717764910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cLjpHafC+0MSRQ44rJRs7NcnLIPmgKcrv5Oc5c7r6Z8=;
  b=GvjTv3zCM5nFXGvqYOwMjMkC/rBjtlvDOPCJgupC/ugt+a3+ESyx0+Ch
   XG7A27oUhz0ZNi8BF+rCk2RfjXQq+NnpB391p+1CTddfdpCVCmmoNvBPo
   Dz6acHKWl/pSzN0nXX4NIFWFQXnZFA1GFi/o9h86Te8CdBdKfJv/Iyi3y
   gqmHJyuz4DpCx7g8Soaeb84tgMlY2RQpLdFnzQT8STgqk044IcpYdRUB+
   sEHMsGk9pUQKe89L20f6ViKJZtF/GOUjnxScAz8i2h92NF6wKT71rJnm5
   RC8q/7bgj5L6oDkz9WRgHDiLT607V/AH6GvDbvvyDJcUNeX9Lk3TtLs1c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346912543"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="346912543"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 05:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="743098963"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="743098963"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2023 05:54:08 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7F9U-0007mu-0t;
        Thu, 08 Jun 2023 12:54:08 +0000
Date:   Thu, 8 Jun 2023 20:53:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 10/17] RDMA/bnxt_re: handle command completions
 after driver detect a timedout
Message-ID: <202306082023.3MJIBDhd-lkp@intel.com>
References: <1686219908-11181-11-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686219908-11181-11-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on next-20230608]
[cannot apply to linus/master v6.4-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-wraparound-mbox-producer-index/20230608-184033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1686219908-11181-11-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next 10/17] RDMA/bnxt_re: handle command completions after driver detect a timedout
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20230608/202306082023.3MJIBDhd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add rdma https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
        git fetch rdma for-next
        git checkout rdma/for-next
        b4 shazam https://lore.kernel.org/r/1686219908-11181-11-git-send-email-selvin.xavier@broadcom.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/infiniband/hw/bnxt_re/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082023.3MJIBDhd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c: In function '__wait_for_resp':
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:108:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     108 |         int ret;
         |             ^~~
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c: In function '__send_message':
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:173:20: warning: variable 'opcode' set but not used [-Wunused-but-set-variable]
     173 |         u32 bsize, opcode, free_slots, required_slots;
         |                    ^~~~~~
   drivers/infiniband/hw/bnxt_re/qplib_rcfw.c: In function 'bnxt_qplib_process_qp_event':
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:502:17: warning: variable 'mcookie' set but not used [-Wunused-but-set-variable]
     502 |         __le16  mcookie;
         |                 ^~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
   Selected by [y]:
   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]


vim +/mcookie +502 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c

1ac5a404797523 Selvin Xavier         2017-02-10  487  
1ac5a404797523 Selvin Xavier         2017-02-10  488  static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
1020ce59adaac6 Kashyap Desai         2023-06-08  489  				       struct creq_qp_event *qp_event,
1020ce59adaac6 Kashyap Desai         2023-06-08  490  				       u32 *num_wait)
1ac5a404797523 Selvin Xavier         2017-02-10  491  {
f218d67ef00431 Selvin Xavier         2017-06-29  492  	struct creq_qp_error_notification *err_event;
cee0c7bba48691 Devesh Sharma         2020-02-15  493  	struct bnxt_qplib_hwq *hwq = &rcfw->cmdq.hwq;
cee0c7bba48691 Devesh Sharma         2020-02-15  494  	struct bnxt_qplib_crsqe *crsqe;
9a38dbbd424de0 Kashyap Desai         2023-06-08  495  	u32 qp_id, tbl_indx, req_size;
f218d67ef00431 Selvin Xavier         2017-06-29  496  	struct bnxt_qplib_qp *qp;
cc1ec769b87c7d Devesh Sharma         2017-05-22  497  	u16 cbit, blocked = 0;
9a38dbbd424de0 Kashyap Desai         2023-06-08  498  	bool is_waiter_alive;
cee0c7bba48691 Devesh Sharma         2020-02-15  499  	struct pci_dev *pdev;
cee0c7bba48691 Devesh Sharma         2020-02-15  500  	unsigned long flags;
1020ce59adaac6 Kashyap Desai         2023-06-08  501  	u32 wait_cmds = 0;
cc1ec769b87c7d Devesh Sharma         2017-05-22 @502  	__le16  mcookie;
cee0c7bba48691 Devesh Sharma         2020-02-15  503  	u16 cookie;
cee0c7bba48691 Devesh Sharma         2020-02-15  504  	int rc = 0;
1ac5a404797523 Selvin Xavier         2017-02-10  505  
cee0c7bba48691 Devesh Sharma         2020-02-15  506  	pdev = rcfw->pdev;
1ac5a404797523 Selvin Xavier         2017-02-10  507  	switch (qp_event->event) {
1ac5a404797523 Selvin Xavier         2017-02-10  508  	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
f218d67ef00431 Selvin Xavier         2017-06-29  509  		err_event = (struct creq_qp_error_notification *)qp_event;
f218d67ef00431 Selvin Xavier         2017-06-29  510  		qp_id = le32_to_cpu(err_event->xid);
84cf229f4001c1 Selvin Xavier         2020-08-24  511  		tbl_indx = map_qp_id_to_tbl_indx(qp_id, rcfw);
84cf229f4001c1 Selvin Xavier         2020-08-24  512  		qp = rcfw->qp_tbl[tbl_indx].qp_handle;
cee0c7bba48691 Devesh Sharma         2020-02-15  513  		dev_dbg(&pdev->dev, "Received QP error notification\n");
cee0c7bba48691 Devesh Sharma         2020-02-15  514  		dev_dbg(&pdev->dev,
08920b8f5d2d3b Joe Perches           2018-08-10  515  			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
f218d67ef00431 Selvin Xavier         2017-06-29  516  			qp_id, err_event->req_err_state_reason,
f218d67ef00431 Selvin Xavier         2017-06-29  517  			err_event->res_err_state_reason);
d6d5c59905c8af Sriharsha Basavapatna 2017-10-31  518  		if (!qp)
d6d5c59905c8af Sriharsha Basavapatna 2017-10-31  519  			break;
f218d67ef00431 Selvin Xavier         2017-06-29  520  		bnxt_qplib_mark_qp_error(qp);
cee0c7bba48691 Devesh Sharma         2020-02-15  521  		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
1ac5a404797523 Selvin Xavier         2017-02-10  522  		break;
1ac5a404797523 Selvin Xavier         2017-02-10  523  	default:
d455f29f6d76a5 Selvin Xavier         2018-10-08  524  		/*
d455f29f6d76a5 Selvin Xavier         2018-10-08  525  		 * Command Response
d455f29f6d76a5 Selvin Xavier         2018-10-08  526  		 * cmdq->lock needs to be acquired to synchronie
d455f29f6d76a5 Selvin Xavier         2018-10-08  527  		 * the command send and completion reaping. This function
d455f29f6d76a5 Selvin Xavier         2018-10-08  528  		 * is always called with creq->lock held. Using
d455f29f6d76a5 Selvin Xavier         2018-10-08  529  		 * the nested variant of spin_lock.
d455f29f6d76a5 Selvin Xavier         2018-10-08  530  		 *
d455f29f6d76a5 Selvin Xavier         2018-10-08  531  		 */
d455f29f6d76a5 Selvin Xavier         2018-10-08  532  
cee0c7bba48691 Devesh Sharma         2020-02-15  533  		spin_lock_irqsave_nested(&hwq->lock, flags,
d455f29f6d76a5 Selvin Xavier         2018-10-08  534  					 SINGLE_DEPTH_NESTING);
cc1ec769b87c7d Devesh Sharma         2017-05-22  535  		cookie = le16_to_cpu(qp_event->cookie);
cc1ec769b87c7d Devesh Sharma         2017-05-22  536  		mcookie = qp_event->cookie;
1ac5a404797523 Selvin Xavier         2017-02-10  537  		blocked = cookie & RCFW_CMD_IS_BLOCKING;
1ac5a404797523 Selvin Xavier         2017-02-10  538  		cookie &= RCFW_MAX_COOKIE_VALUE;
bd1c24ccf9eb07 Devesh Sharma         2018-12-12  539  		cbit = cookie % rcfw->cmdq_depth;
cc1ec769b87c7d Devesh Sharma         2017-05-22  540  		crsqe = &rcfw->crsqe_tbl[cbit];
cee0c7bba48691 Devesh Sharma         2020-02-15  541  		if (!test_and_clear_bit(cbit, rcfw->cmdq.cmdq_bitmap))
cee0c7bba48691 Devesh Sharma         2020-02-15  542  			dev_warn(&pdev->dev,
08920b8f5d2d3b Joe Perches           2018-08-10  543  				 "CMD bit %d was not requested\n", cbit);
cc1ec769b87c7d Devesh Sharma         2017-05-22  544  
9a38dbbd424de0 Kashyap Desai         2023-06-08  545  		if (crsqe->is_waiter_alive) {
9a38dbbd424de0 Kashyap Desai         2023-06-08  546  			if (crsqe->resp)
9a38dbbd424de0 Kashyap Desai         2023-06-08  547  				memcpy(crsqe->resp, qp_event, sizeof(*qp_event));
1ac5a404797523 Selvin Xavier         2017-02-10  548  			if (!blocked)
1020ce59adaac6 Kashyap Desai         2023-06-08  549  				wait_cmds++;
9a38dbbd424de0 Kashyap Desai         2023-06-08  550  		}
9a38dbbd424de0 Kashyap Desai         2023-06-08  551  
9a38dbbd424de0 Kashyap Desai         2023-06-08  552  		req_size = crsqe->req_size;
9a38dbbd424de0 Kashyap Desai         2023-06-08  553  		is_waiter_alive = crsqe->is_waiter_alive;
9a38dbbd424de0 Kashyap Desai         2023-06-08  554  
9a38dbbd424de0 Kashyap Desai         2023-06-08  555  		crsqe->req_size = 0;
9a38dbbd424de0 Kashyap Desai         2023-06-08  556  		if (!is_waiter_alive)
9a38dbbd424de0 Kashyap Desai         2023-06-08  557  			crsqe->resp = NULL;
9a38dbbd424de0 Kashyap Desai         2023-06-08  558  
9a38dbbd424de0 Kashyap Desai         2023-06-08  559  		hwq->cons += req_size;
cee0c7bba48691 Devesh Sharma         2020-02-15  560  		spin_unlock_irqrestore(&hwq->lock, flags);
1ac5a404797523 Selvin Xavier         2017-02-10  561  	}
1020ce59adaac6 Kashyap Desai         2023-06-08  562  	*num_wait += wait_cmds;
cee0c7bba48691 Devesh Sharma         2020-02-15  563  	return rc;
1ac5a404797523 Selvin Xavier         2017-02-10  564  }
1ac5a404797523 Selvin Xavier         2017-02-10  565  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
