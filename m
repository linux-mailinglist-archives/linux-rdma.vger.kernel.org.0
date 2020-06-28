Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B020C516
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgF1BCl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Jun 2020 21:02:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:56414 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgF1BCk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 27 Jun 2020 21:02:40 -0400
IronPort-SDR: 6ijb80xiSRGUlluyEx4gmIH79F+cNZI5SN9Sj9V2BuPnHJK6/l3yjQMjb21XmpCNo5ctDpZRIV
 BOfOW1GtbUGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="144805865"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="144805865"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 18:02:40 -0700
IronPort-SDR: UznROVWPkqBH+GE0Jf0xJtoabc4riNS25UhFGBpMLL9jnewd9mXp0+BFQD0GHoYcwxxOzFiyHt
 T/V2eUVV46vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="320327355"
Received: from unknown (HELO [10.238.4.3]) ([10.238.4.3])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2020 18:02:38 -0700
Subject: Re: [kbuild-all] Re: [RFC PATCH stable] RDMA/qedr: qedr_iw_load_qp()
 can be static
To:     Jason Gunthorpe <jgg@mellanox.com>,
        kernel test robot <lkp@intel.com>
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ariel Elior <ariel.elior@marvell.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202006130434.950ZY2zY%lkp@intel.com>
 <20200612201903.GA57396@0a3611e7790e> <20200619002627.GM65026@mellanox.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <c247b253-708e-be32-5bea-dbf22f9c32e9@intel.com>
Date:   Sun, 28 Jun 2020 09:02:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619002627.GM65026@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/19/2020 8:26 AM, Jason Gunthorpe wrote:
> On Sat, Jun 13, 2020 at 04:19:03AM +0800, kernel test robot wrote:
>> Fixes: 8a69220b659c ("RDMA/qedr: Fix synchronization methods and memory leaks in qedr")
>> Signed-off-by: kernel test robot <lkp@intel.com>
>> ---
>>   qedr_iw_cm.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> What is this report??

Hi Jason,

The report was lost and it should be:

tree:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git  linux-5.4.y
head:   5e3c511539228fa03c8d00d61b5b5f32333ed0b0
commit: 8a69220b659c31ccd481538193220d732814b324 [5532/5583] RDMA/qedr: Fix synchronization methods and memory leaks in qedr
config: ia64-randconfig-s031-20200612 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
         # apt-get install sparse
         # sparse version: v0.6.1-250-g42323db3-dirty
         git checkout 8a69220b659c31ccd481538193220d732814b324
         # save the attached .config to linux build tree
         make W=1 C=1 ARCH=ia64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot<lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

    ./arch/ia64/include/generated/uapi/asm/unistd_64.h:348:39: sparse: sparse: no newline at end of file

>> drivers/infiniband/hw/qedr/qedr_iw_cm.c:509:16: sparse: sparse: symbol 'qedr_iw_load_qp' was not declared. Should it be static?

We'll fix the problem recently.

Best Regards,
Rong Chen

>
> commit 9a5407d74c22821f7944e2be4209bdfc5faf8143
> Author: Kamal Heib <kamalheib1@gmail.com>
> Date:   Sun Nov 10 13:36:45 2019 +0200
>
>      RDMA/qedr: Make qedr_iw_load_qp() static
>      
>      The function qedr_iw_load_qp() is only used in qedr_iw_cm.c
>
>
> Jason
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

