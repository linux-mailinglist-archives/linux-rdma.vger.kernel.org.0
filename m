Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CBF6C660F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 12:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWLCk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCWLCi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 07:02:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80252BF15
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679569357; x=1711105357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cy/L6PcS6IdrKnZQhlSOnWX/s/1PZcdpOFMnQDt9HGU=;
  b=fG1lFateIWtWi1Bu5JTGuvdRm4kDpKC9l9wKJv7eML/+jVYB9Ztnig8Z
   YH1aGkzfcSZbvKpYqBzRldao56jtBTSvOBwnkSvJ+hG13QdNfJY0U5DLr
   JFGPTJHk3KAdP3aOoBeZj7ewrTUo+8bCQt+Xd/oLfFedT2eRVmuXAQIff
   7sf1ePyNTZYJVSihw8Iy5gCVNmuLY7GBJaO3o62UeIlSLD6OPs/K46vTZ
   Yg5IKyxrzkToAUb0Bbft767hyi1Zic/n8BfNjQu50KqhTL2D+uavu86gq
   sCY/OuYNxReYOhub132bY6CHr7Fb8oEYmUAs64lLSP3NhGC/ES0TX+kXu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="367194520"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="367194520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 04:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="712617065"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="712617065"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2023 04:02:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfIi6-000EGa-0l;
        Thu, 23 Mar 2023 11:02:22 +0000
Date:   Thu, 23 Mar 2023 19:01:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 7/7] RDMA/bnxt_re: Enable congestion control by
 default
Message-ID: <202303231827.oPu3RsK1-lkp@intel.com>
References: <1679562739-24472-8-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679562739-24472-8-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Selvin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-Update-HW-interface-headers/20230323-171441
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1679562739-24472-8-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next 7/7] RDMA/bnxt_re: Enable congestion control by default
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230323/202303231827.oPu3RsK1-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a8a24a74b6a3209329cc8c157309b156d507cb7d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Selvin-Xavier/RDMA-bnxt_re-Update-HW-interface-headers/20230323-171441
        git checkout a8a24a74b6a3209329cc8c157309b156d507cb7d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/infiniband/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303231827.oPu3RsK1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/bnxt_re/qplib_sp.c:854:6: warning: no previous prototype for 'bnxt_qplib_fill_cc_gen1' [-Wmissing-prototypes]
     854 | void bnxt_qplib_fill_cc_gen1(struct cmdq_modify_roce_cc_gen1_tlv *ext_req,
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/bnxt_qplib_fill_cc_gen1 +854 drivers/infiniband/hw/bnxt_re/qplib_sp.c

   853	
 > 854	void bnxt_qplib_fill_cc_gen1(struct cmdq_modify_roce_cc_gen1_tlv *ext_req,
   855				     struct bnxt_qplib_cc_param_ext *cc_ext)
   856	{
   857		ext_req->modify_mask = cpu_to_le64(cc_ext->ext_mask);
   858		cc_ext->ext_mask = 0;
   859		ext_req->inactivity_th_hi = cpu_to_le16(cc_ext->inact_th_hi);
   860		ext_req->min_time_between_cnps = cpu_to_le16(cc_ext->min_delta_cnp);
   861		ext_req->init_cp = cpu_to_le16(cc_ext->init_cp);
   862		ext_req->tr_update_mode = cc_ext->tr_update_mode;
   863		ext_req->tr_update_cycles = cc_ext->tr_update_cyls;
   864		ext_req->fr_num_rtts = cc_ext->fr_rtt;
   865		ext_req->ai_rate_increase = cc_ext->ai_rate_incr;
   866		ext_req->reduction_relax_rtts_th = cpu_to_le16(cc_ext->rr_rtt_th);
   867		ext_req->additional_relax_cr_th = cpu_to_le16(cc_ext->ar_cr_th);
   868		ext_req->cr_min_th = cpu_to_le16(cc_ext->cr_min_th);
   869		ext_req->bw_avg_weight = cc_ext->bw_avg_weight;
   870		ext_req->actual_cr_factor = cc_ext->cr_factor;
   871		ext_req->max_cp_cr_th = cpu_to_le16(cc_ext->cr_th_max_cp);
   872		ext_req->cp_bias_en = cc_ext->cp_bias_en;
   873		ext_req->cp_bias = cc_ext->cp_bias;
   874		ext_req->cnp_ecn = cc_ext->cnp_ecn;
   875		ext_req->rtt_jitter_en = cc_ext->rtt_jitter_en;
   876		ext_req->link_bytes_per_usec = cpu_to_le16(cc_ext->bytes_per_usec);
   877		ext_req->reset_cc_cr_th = cpu_to_le16(cc_ext->cc_cr_reset_th);
   878		ext_req->cr_width = cc_ext->cr_width;
   879		ext_req->quota_period_min = cc_ext->min_quota;
   880		ext_req->quota_period_max = cc_ext->max_quota;
   881		ext_req->quota_period_abs_max = cc_ext->abs_max_quota;
   882		ext_req->tr_lower_bound = cpu_to_le16(cc_ext->tr_lb);
   883		ext_req->cr_prob_factor = cc_ext->cr_prob_fac;
   884		ext_req->tr_prob_factor = cc_ext->tr_prob_fac;
   885		ext_req->fairness_cr_th = cpu_to_le16(cc_ext->fair_cr_th);
   886		ext_req->red_div = cc_ext->red_div;
   887		ext_req->cnp_ratio_th = cc_ext->cnp_ratio_th;
   888		ext_req->exp_ai_rtts = cpu_to_le16(cc_ext->ai_ext_rtt);
   889		ext_req->exp_ai_cr_cp_ratio = cc_ext->exp_crcp_ratio;
   890		ext_req->use_rate_table = cc_ext->low_rate_en;
   891		ext_req->cp_exp_update_th = cpu_to_le16(cc_ext->cpcr_update_th);
   892		ext_req->high_exp_ai_rtts_th1 = cpu_to_le16(cc_ext->ai_rtt_th1);
   893		ext_req->high_exp_ai_rtts_th2 = cpu_to_le16(cc_ext->ai_rtt_th2);
   894		ext_req->actual_cr_cong_free_rtts_th = cpu_to_le16(cc_ext->cf_rtt_th);
   895		ext_req->severe_cong_cr_th1 = cpu_to_le16(cc_ext->sc_cr_th1);
   896		ext_req->severe_cong_cr_th2 = cpu_to_le16(cc_ext->sc_cr_th2);
   897		ext_req->link64B_per_rtt = cpu_to_le32(cc_ext->l64B_per_rtt);
   898		ext_req->cc_ack_bytes = cc_ext->cc_ack_bytes;
   899	}
   900	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
