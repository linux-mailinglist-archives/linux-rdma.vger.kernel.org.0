Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA15169BCE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 02:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBXB31 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 23 Feb 2020 20:29:27 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbgBXB31 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 23 Feb 2020 20:29:27 -0500
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 196D76A9260780FFEC95;
        Mon, 24 Feb 2020 09:29:25 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Feb 2020 09:29:24 +0800
Received: from DGGEML502-MBX.china.huawei.com ([169.254.2.2]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0439.000;
 Mon, 24 Feb 2020 09:29:16 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Optimize qp doorbell
 allocation flow
Thread-Topic: [PATCH v2 for-next 7/7] RDMA/hns: Optimize qp doorbell
 allocation flow
Thread-Index: AQHV3/JLYfj8wY1BCEqy8KZ6qePNqw==
Date:   Mon, 24 Feb 2020 01:29:15 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0225163A@DGGEML502-MBX.china.huawei.com>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
 <1581325720-12975-8-git-send-email-liweihang@huawei.com>
 <20200219005225.GA25540@ziepe.ca>
 <04b1c2e6-a3e1-9e29-708d-4ae29c1e1602@huawei.com>
 <20200219131901.GP31668@ziepe.ca>
 <2032cac3-b31f-8f86-64d2-a931b973fdfa@huawei.com>
 <20200222233800.GN31668@ziepe.ca>
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

On 2020/2/23 7:38, Jason Gunthorpe wrote:
>> Hi Jason,
>>
>> Do you means
>>
>> 	udata->outlen >= sizeof(*resp)
>>
>> should be changed into:
>>
>> 	udata->out_len >= offsetof(typeof(*resp), cap_flags)
>>
>> If yes, I will fix other similar codes with this issue in hns drivers.
> Probably offsetofend though, right?
> 
> But yes, that is how the general 'feature test for old userspace with
> old kernel ABI' should look
> 
> Jason
> 

Yes, you are right, I made a mistake :)
Thanks for your comments.

Weihang
