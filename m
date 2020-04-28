Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03951BBD95
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgD1M2V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 28 Apr 2020 08:28:21 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:38716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgD1M2V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 08:28:21 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id AF85F2FC018862FE824B;
        Tue, 28 Apr 2020 20:28:18 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 28 Apr 2020 20:28:18 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.242]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0487.000;
 Tue, 28 Apr 2020 20:28:11 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
CC:     kbuild test robot <lkp@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linuxarm <linuxarm@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v3 for-next 1/5] RDMA/hns: Optimize PBL buffer
 allocation process
Thread-Topic: [PATCH v3 for-next 1/5] RDMA/hns: Optimize PBL buffer
 allocation process
Thread-Index: AQHWG5YJYnszuwJ0jUanNYXVoU5kFQ==
Date:   Tue, 28 Apr 2020 12:28:10 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0232A3A9@DGGEML522-MBX.china.huawei.com>
References: <1587883377-22975-2-git-send-email-liweihang@huawei.com>
 <202004280904.BP6w786k%lkp@intel.com>
 <B82435381E3B2943AA4D2826ADEF0B3A0232A154@DGGEML522-MBX.china.huawei.com>
 <20200428121013.00001041@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/4/28 19:10, Jonathan Cameron wrote:
> On Tue, 28 Apr 2020 16:12:39 +0800
> liweihang <liweihang@huawei.com> wrote:
> 
>> On 2020/4/28 10:53, kbuild test robot wrote:
>>> Hi Weihang,
>>>
>>> I love your patch! Perhaps something to improve:
>>>
>>> [auto build test WARNING on rdma/for-next]
>>> [also build test WARNING on linus/master v5.7-rc3 next-20200424]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Weihang-Li/RDMA-hns-Refactor-process-of-buffer-allocation-and-calculation/20200428-015905
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
>>> reproduce:
>>>         # apt-get install sparse
>>>         # sparse version: v0.6.1-191-gc51a0382-dirty
>>>         make ARCH=x86_64 allmodconfig
>>>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>>
>>> sparse warnings: (new ones prefixed by >>)
>>>   
>>>>> drivers/infiniband/hw/hns/hns_roce_mr.c:375:6: sparse: sparse: symbol 'hns_roce_mr_free' was not declared. Should it be static?  
>>>
>>> Please review and possibly fold the followup patch.
>>>
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>   
>>
>> It will be used out of this file in later series, but it's better to add
>> a static currently. Will fix it, thanks.
> 
> Alternative would be to declare it in the header at this stage.
> 
> Jonathan
> 

Hi Jonathan,

I see, but I have already sent v4. Thanks for your advice and I will follow
your comments next time.

Thanks
Weihang

> 
>>
>> Weihang
>>
>>
>> _______________________________________________
>> Linuxarm mailing list
>> Linuxarm@huawei.com
>> http://hulk.huawei.com/mailman/listinfo/linuxarm
> 
> 
> 

