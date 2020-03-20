Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AFC18C4E4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 02:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTBos convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 19 Mar 2020 21:44:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:41308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgCTBor (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 21:44:47 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 99F433FC9D5ECB2B81AF;
        Fri, 20 Mar 2020 09:44:45 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 20 Mar 2020 09:44:45 +0800
Received: from DGGEML502-MBS.china.huawei.com ([169.254.3.252]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0487.000;
 Fri, 20 Mar 2020 09:44:36 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 03/11] RDMA/hns: Check return value of kmalloc
 with macro
Thread-Topic: [PATCH for-next 03/11] RDMA/hns: Check return value of kmalloc
 with macro
Thread-Index: AQHV/hrL2iCm98tuLUOa/drFv65Flg==
Date:   Fri, 20 Mar 2020 01:44:35 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022AA212@DGGEML502-MBS.china.huawei.com>
References: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
 <1584624298-23841-4-git-send-email-liweihang@huawei.com>
 <20200319181824.GL20941@ziepe.ca>
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

On 2020/3/20 2:18, Jason Gunthorpe wrote:
> On Thu, Mar 19, 2020 at 09:24:50PM +0800, Weihang Li wrote:
>> From: Yixian Liu <liuyixian@huawei.com>
>>
>> As the return value of kmalloc may be null or error code, use kernel macro
>> to do return value check.
> 
> kmalloc always returns null, do not use IS_ERR_OR_NULL
> 
> Jason
> 

OK, will drop this one in v2.

Thank you
Weihang
