Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94251BBC01
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD1LKc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 07:10:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgD1LKc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 07:10:32 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 27A9738E9E473AD7641C;
        Tue, 28 Apr 2020 12:10:31 +0100 (IST)
Received: from localhost (10.47.94.202) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 28 Apr
 2020 12:10:30 +0100
Date:   Tue, 28 Apr 2020 12:10:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     liweihang <liweihang@huawei.com>
CC:     kbuild test robot <lkp@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linuxarm <linuxarm@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v3 for-next 1/5] RDMA/hns: Optimize PBL buffer
 allocation process
Message-ID: <20200428121013.00001041@Huawei.com>
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A0232A154@DGGEML522-MBX.china.huawei.com>
References: <1587883377-22975-2-git-send-email-liweihang@huawei.com>
        <202004280904.BP6w786k%lkp@intel.com>
        <B82435381E3B2943AA4D2826ADEF0B3A0232A154@DGGEML522-MBX.china.huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.202]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 28 Apr 2020 16:12:39 +0800
liweihang <liweihang@huawei.com> wrote:

> On 2020/4/28 10:53, kbuild test robot wrote:
> > Hi Weihang,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on rdma/for-next]
> > [also build test WARNING on linus/master v5.7-rc3 next-20200424]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Weihang-Li/RDMA-hns-Refactor-process-of-buffer-allocation-and-calculation/20200428-015905
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-191-gc51a0382-dirty
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> >   
> >>> drivers/infiniband/hw/hns/hns_roce_mr.c:375:6: sparse: sparse: symbol 'hns_roce_mr_free' was not declared. Should it be static?  
> > 
> > Please review and possibly fold the followup patch.
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >   
> 
> It will be used out of this file in later series, but it's better to add
> a static currently. Will fix it, thanks.

Alternative would be to declare it in the header at this stage.

Jonathan


> 
> Weihang
> 
> 
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm


