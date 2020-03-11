Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E09180D5B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 02:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCKBPG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 10 Mar 2020 21:15:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbgCKBPF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 21:15:05 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id C452F7373EC35D034B74;
        Wed, 11 Mar 2020 09:15:03 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.20]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0439.000; Wed, 11 Mar 2020 09:14:57 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 0/5] RDMA/hns: Refactor wqe related codes
Thread-Topic: [PATCH v3 for-next 0/5] RDMA/hns: Refactor wqe related codes
Thread-Index: AQHV9s4fFon+zYFs7kG37DjatH/hkw==
Date:   Wed, 11 Mar 2020 01:14:57 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0227A580@DGGEML522-MBX.china.huawei.com>
References: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
 <9221956f-cbbb-213d-9031-2ca7e9b9f7d4@huawei.com>
 <20200310144243.GZ31668@ziepe.ca>
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

On 2020/3/10 22:42, Jason Gunthorpe wrote:
> On Tue, Mar 10, 2020 at 08:53:22PM +0800, Weihang Li wrote:
>> Hi Jason,
>>
>> Sorry, I didn't notice that the first three patches of this series had
>> been applied to you for-next branch, so I sent this new version. Need
>> I resend the last two patches in a new series?
> 
> Oh, something got out of sorts, I did not intend to push those four
> patches, I will drop them an this v3 will supersede and the 'minimum
> depth of qp to 0' should be resent with comments addressed.
> 
> Jason
> 

OK, thank you :)

Weihang
