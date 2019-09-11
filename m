Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499EDAF72A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 09:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfIKHum convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 11 Sep 2019 03:50:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:41710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfIKHum (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 03:50:42 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 12C574AEEB1EF227AB40;
        Wed, 11 Sep 2019 15:50:41 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Sep 2019 15:50:40 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.213]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0439.000;
 Wed, 11 Sep 2019 15:50:33 +0800
From:   liweihang <liweihang@hisilicon.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH rdma-core 3/5] libhns: Refactor for post send
Thread-Topic: [PATCH rdma-core 3/5] libhns: Refactor for post send
Thread-Index: AQHVZ9K2jRVGOt9uOUuq4H9FaamW1KclkUEAgACKFrA=
Date:   Wed, 11 Sep 2019 07:50:33 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0207DED9@DGGEML522-MBX.china.huawei.com>
References: <1568118052-33380-1-git-send-email-liweihang@hisilicon.com>
 <1568118052-33380-4-git-send-email-liweihang@hisilicon.com>
 <20190911073538.GC6601@unreal>
In-Reply-To: <20190911073538.GC6601@unreal>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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



> -----Original Message-----
> From: Leon Romanovsky [mailto:leon@kernel.org]
> Sent: Wednesday, September 11, 2019 3:36 PM
> To: liweihang <liweihang@hisilicon.com>
> Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH rdma-core 3/5] libhns: Refactor for post send
> 
> On Tue, Sep 10, 2019 at 08:20:50PM +0800, Weihang Li wrote:
> > From: Yixian Liu <liuyixian@huawei.com>
> >
> > This patch refactors the interface of hns_roce_u_v2_post_send, which
> > is now very complicated. We reduce the complexity with following points:
> > 1. Separate RC server into a function.
> > 2. Simplify and separate the process of sge.
> > 3. Keep the logic and consistence of all operations.
> >
> > Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> > Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> > ---
> >  providers/hns/hns_roce_u.h       |   7 +
> >  providers/hns/hns_roce_u_hw_v2.c | 427
> > ++++++++++++++++-----------------------
> >  2 files changed, 186 insertions(+), 248 deletions(-)
> >
> 
> No printf() calls in the providers code, please.
> 
> Thanks

OK, will modify them, thank you.
