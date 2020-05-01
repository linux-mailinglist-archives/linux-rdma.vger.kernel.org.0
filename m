Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13FD1C17A7
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2020 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgEAOYr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 May 2020 10:24:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:43036 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbgEAOYq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 May 2020 10:24:46 -0400
IronPort-SDR: V0n0bkQ1pxcIrZQcRRHbTV2fqsEVXnWPfc9do4hgCaYzOvbJw52u0/kxhycZSUfGlzr27eBIu5
 unCOx5U/g4wQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 07:24:42 -0700
IronPort-SDR: zOaNdYO11+XZQaCIl1GflqhMCiQai0K1aX+aTLO1ivf5/8ehhE9ShWesKeZl2CNILjpT78v943
 LF6kbCbSCeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; 
   d="scan'208";a="283189248"
Received: from shatao-mobl.ccr.corp.intel.com (HELO [10.249.174.63]) ([10.249.174.63])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 07:24:38 -0700
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        kbuild test robot <lkp@intel.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
References: <20200427141020.655-24-danil.kipnis@cloud.ionos.com>
 <202004292210.aw7c2Yi3%lkp@intel.com>
 <CAHg0HuzGwonGEbRyN03RZ7TiD4NdFWmr+YR7u9EG4VHyTT7V4w@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <7faf09fa-f38d-f54f-bd28-b4c26c936846@intel.com>
Date:   Fri, 1 May 2020 22:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuzGwonGEbRyN03RZ7TiD4NdFWmr+YR7u9EG4VHyTT7V4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/30/2020 4:48 PM, Danil Kipnis wrote:
> On Wed, Apr 29, 2020 at 5:01 PM kbuild test robot <lkp@intel.com> wrote:
>> Hi Danil,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on block/for-next]
>> [also build test ERROR on driver-core/driver-core-testing rdma/for-next linus/master v5.7-rc3 next-20200428]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200428-080733
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
>> config: i386-allyesconfig (attached as .config)
>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from drivers/block/rnbd/rnbd-clt.c:19:0:
>>>> drivers/block/rnbd/rnbd-clt.h:19:10: fatal error: rtrs.h: No such file or directory
>>      #include "rtrs.h"
>>               ^~~~~~~~
>>     compilation terminated.
>> --
>>     In file included from drivers/block/rnbd/rnbd-srv.c:15:0:
>>>> drivers/block/rnbd/rnbd-srv.h:16:10: fatal error: rtrs.h: No such file or directory
>>      #include "rtrs.h"
>>               ^~~~~~~~
>>     compilation terminated.
>>
>> vim +19 drivers/block/rnbd/rnbd-clt.h
>>
>> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  18
>> 9e3ecd2f9c364e6 Jack Wang 2020-04-27 @19  #include "rtrs.h"
>> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  20  #include "rnbd-proto.h"
>> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  21  #include "rnbd-log.h"
>> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  22
>>
>> :::::: The code at line 19 was first introduced by commit
>> :::::: 9e3ecd2f9c364e67eaa3ad19424b0d7ad6daacaa block/rnbd: client: private header with client structs and functions
>>
>> :::::: TO: Jack Wang <jinpu.wang@cloud.ionos.com>
>> :::::: CC: 0day robot <lkp@intel.com>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> Dear kbuild test robot, dear All,
>
> the mentioned branch with the attached config compiles without errors
> on my machine. Does anybody knows how to reproduce this include file
> not found error or why does it come up in the kbuild test compilation?

Hi Danil,

The branch was generated by the bot, it may applied to a wrong base 
tree, could you take a look?

url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200428-080733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next


Best Regards,
Rong Chen
