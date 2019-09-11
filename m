Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BFAFCF5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 14:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfIKMlF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 11 Sep 2019 08:41:05 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50876 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726928AbfIKMlF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 08:41:05 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 42396EE4EAF17BAA33B9;
        Wed, 11 Sep 2019 20:41:02 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.213]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0439.000; Wed, 11 Sep 2019 20:40:54 +0800
From:   liweihang <liweihang@hisilicon.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH rdma-core 5/5] libhns: Support configuring loopback mode
 by user
Thread-Topic: [PATCH rdma-core 5/5] libhns: Support configuring loopback
 mode by user
Thread-Index: AQHVZ9K10ToxRyH8Ikm3MUtNvGR+d6clkyIAgACIbJA=
Date:   Wed, 11 Sep 2019 12:40:54 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0207E95E@DGGEML522-MBX.china.huawei.com>
References: <1568118052-33380-1-git-send-email-liweihang@hisilicon.com>
 <1568118052-33380-6-git-send-email-liweihang@hisilicon.com>
 <20190911074222.GD6601@unreal>
In-Reply-To: <20190911074222.GD6601@unreal>
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
> Sent: Wednesday, September 11, 2019 3:42 PM
> To: liweihang <liweihang@hisilicon.com>
> Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH rdma-core 5/5] libhns: Support configuring loopback
> mode by user
> 
> On Tue, Sep 10, 2019 at 08:20:52PM +0800, Weihang Li wrote:
> > User can configure whether hardware working on loopback mode or not by
> > export an environment variable "HNS_ROCE_LOOPBACK".
> 
> It is definitely wrong interface to configure behaviour of application.
> Environment variables make sense if you need to change library behaviour.
> 
> Thanks

Hi Leon,

Could you please give some advices on how to get configurations from users?

Thanks,
Weihang
