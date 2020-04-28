Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C91BB88E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgD1IMv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 28 Apr 2020 04:12:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbgD1IMu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 04:12:50 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 6AD22A89ECA926A08D2E;
        Tue, 28 Apr 2020 16:12:48 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 28 Apr 2020 16:12:48 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.242]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Tue, 28 Apr 2020 16:12:39 +0800
From:   liweihang <liweihang@huawei.com>
To:     kbuild test robot <lkp@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 1/5] RDMA/hns: Optimize PBL buffer
 allocation process
Thread-Topic: [PATCH v3 for-next 1/5] RDMA/hns: Optimize PBL buffer
 allocation process
Thread-Index: AQHWG5YJYnszuwJ0jUanNYXVoU5kFQ==
Date:   Tue, 28 Apr 2020 08:12:39 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0232A154@DGGEML522-MBX.china.huawei.com>
References: <1587883377-22975-2-git-send-email-liweihang@huawei.com>
 <202004280904.BP6w786k%lkp@intel.com>
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

On 2020/4/28 10:53, kbuild test robot wrote:
> Hi Weihang,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on linus/master v5.7-rc3 next-20200424]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Weihang-Li/RDMA-hns-Refactor-process-of-buffer-allocation-and-calculation/20200428-015905
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-191-gc51a0382-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>>> drivers/infiniband/hw/hns/hns_roce_mr.c:375:6: sparse: sparse: symbol 'hns_roce_mr_free' was not declared. Should it be static?
> 
> Please review and possibly fold the followup patch.
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

It will be used out of this file in later series, but it's better to add
a static currently. Will fix it, thanks.

Weihang

