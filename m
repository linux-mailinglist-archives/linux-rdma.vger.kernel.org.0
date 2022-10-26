Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0560DD7B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 10:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiJZIrG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZIrF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 04:47:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DDC75CD2
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 01:47:03 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4My2Qc0G3qzpVt6;
        Wed, 26 Oct 2022 16:43:36 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:47:01 +0800
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:47:01 +0800
Subject: Re: [PATCH 2/5] RDMA/hns: Fix the problem of sge nums
To:     kernel test robot <lkp@intel.com>, <jgg@nvidia.com>,
        <leon@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20221025105244.204570-3-xuhaoyue1@hisilicon.com>
 <202210252038.R76mzmoZ-lkp@intel.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <1789493b-ca0b-3912-e40c-91a201043155@hisilicon.com>
Date:   Wed, 26 Oct 2022 16:47:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202210252038.R76mzmoZ-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


I will send V2 to fix it.
On 2022/10/25 20:47:33, kernel test robot wrote:
> Hi Haoyue,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on linus/master v6.1-rc2 next-20221025]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Haoyue-Xu/Fix-sge_num-bug-and-add-cqe-inline-refactor-rq-inline/20221025-185626
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20221025105244.204570-3-xuhaoyue1%40hisilicon.com
> patch subject: [PATCH 2/5] RDMA/hns: Fix the problem of sge nums
> config: ia64-allyesconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/b277a5cdd36f6cfac1e387afd3b670052041e9df
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Haoyue-Xu/Fix-sge_num-bug-and-add-cqe-inline-refactor-rq-inline/20221025-185626
>         git checkout b277a5cdd36f6cfac1e387afd3b670052041e9df
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/infiniband/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/infiniband/hw/hns/hns_roce_qp.c:510: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     *  Calculated sge num according to attr's max_send_sge
>    drivers/infiniband/hw/hns/hns_roce_qp.c:525: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     *  Calculated sge num according to attr's max_inline_data
> 
> 
> vim +510 drivers/infiniband/hw/hns/hns_roce_qp.c
> 
>    508	
>    509	/**
>  > 510	 *  Calculated sge num according to attr's max_send_sge
>    511	 */
>    512	static u32 get_sge_num_from_max_send_sge(bool is_ud_or_gsi,
>    513						 u32 max_send_sge)
>    514	{
>    515		unsigned int std_sge_num;
>    516		unsigned int min_sge;
>    517	
>    518		std_sge_num = is_ud_or_gsi ? 0 : HNS_ROCE_SGE_IN_WQE;
>    519		min_sge = is_ud_or_gsi ? 1 : 0;
>    520		return max_send_sge > std_sge_num ? (max_send_sge - std_sge_num) :
>    521					min_sge;
>    522	}
>    523	
> 
