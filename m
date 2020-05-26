Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB491E19AC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 04:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgEZC5w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 25 May 2020 22:57:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:44740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgEZC5w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 22:57:52 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 865AC20A3E7DF7316F5D;
        Tue, 26 May 2020 10:57:48 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 26 May 2020 10:57:47 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.141]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Tue, 26 May 2020 10:57:40 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 2/9] RDMA/hns: Add CQ flag instead of
 independent enable flag
Thread-Topic: [PATCH for-next 2/9] RDMA/hns: Add CQ flag instead of
 independent enable flag
Thread-Index: AQHWLq4Z5aJwt2CsLEKPOa4qXyCpkg==
Date:   Tue, 26 May 2020 02:57:39 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A02387A2A@DGGEML522-MBX.china.huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
 <1589982799-28728-3-git-send-email-liweihang@huawei.com>
 <20200525170647.GA16200@ziepe.ca>
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

On 2020/5/26 1:06, Jason Gunthorpe wrote:
> On Wed, May 20, 2020 at 09:53:12PM +0800, Weihang Li wrote:
>> +	roce_set_bit(cq_context->byte_44_db_record,
>> +		     V2_CQC_BYTE_44_DB_RECORD_EN_S,
>> +		     (hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB) ? 1 : 0);
> 
> It seems like the if expression should be inside the roce_set_bit
> macro (just cast to bool) as something called 'bit' should have that
> safety built in.
> 

Hi Jason

Thanks for your comments, will prepare a patch to modify it.


> Also, if someone wants a project, all this endless stuff should be
> using genmask and field_prep instead of this home grown stuff.
> 
> Jason
> 

I took a look at this macro, FILED_PREP() can indeed simplify lots of
similar codes in the hns driver. I will take a try and maybe prepare a
patch/series to use it in v5.9.

Weihang
