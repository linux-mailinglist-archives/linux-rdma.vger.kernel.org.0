Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268444F6D54
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Apr 2022 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiDFVvJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Apr 2022 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiDFVuz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Apr 2022 17:50:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DEE06AA63;
        Wed,  6 Apr 2022 14:39:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C0212FC;
        Wed,  6 Apr 2022 14:39:54 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50ABB3F718;
        Wed,  6 Apr 2022 14:39:53 -0700 (PDT)
Message-ID: <87075d61-c51c-8d94-9263-17aa40f7d70e@arm.com>
Date:   Wed, 6 Apr 2022 22:39:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Content-Language: en-GB
To:     kernel test robot <lkp@intel.com>, benve@cisco.com,
        neescoba@cisco.com, jgg@ziepe.ca
Cc:     kbuild-all@lists.01.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
 <202204070316.vOzwORw5-lkp@intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <202204070316.vOzwORw5-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022-04-06 20:54, kernel test robot wrote:
> Hi Robin,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on rdma/for-next]
> [also build test ERROR on v5.18-rc1 next-20220406]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Oops, I failed to notice that this does actually depend on the other 
patch I sent cleaning up iommu_present()[1] - I should have sent them 
together as a series, sorry about that.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/f707b4248e1d33b6d2c7f1d7c94febb802cf9890.1649161199.git.robin.murphy@arm.com/
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/RDMA-usnic-Refactor-usnic_uiom_alloc_pd/20220406-133657
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220407/202204070316.vOzwORw5-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
> reproduce (this is a W=1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/0aa6215010a083081b26ccb23d0aa2b4089bbbfd
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Robin-Murphy/RDMA-usnic-Refactor-usnic_uiom_alloc_pd/20220406-133657
>          git checkout 0aa6215010a083081b26ccb23d0aa2b4089bbbfd
>          # save the config file to linux build tree
>          mkdir build_dir
>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/infiniband/hw/usnic/usnic_uiom.c: In function 'usnic_uiom_init':
>>> drivers/infiniband/hw/usnic/usnic_uiom.c:561:29: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'bus_type'?
>       561 |         if (!iommu_present(&pci_bus_type)) {
>           |                             ^~~~~~~~~~~~
>           |                             bus_type
>     drivers/infiniband/hw/usnic/usnic_uiom.c:561:29: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +561 drivers/infiniband/hw/usnic/usnic_uiom.c
> 
> e3cf00d0a87f02 Upinder Malhi 2013-09-10  558
> e3cf00d0a87f02 Upinder Malhi 2013-09-10  559  int usnic_uiom_init(char *drv_name)
> e3cf00d0a87f02 Upinder Malhi 2013-09-10  560  {
> e3cf00d0a87f02 Upinder Malhi 2013-09-10 @561  	if (!iommu_present(&pci_bus_type)) {
> 
