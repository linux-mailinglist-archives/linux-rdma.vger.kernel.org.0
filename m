Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5261840B8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 07:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgCMGCc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 13 Mar 2020 02:02:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgCMGCb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 02:02:31 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 7AF9263CF3FFA027A267;
        Fri, 13 Mar 2020 14:02:27 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.20]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0439.000; Fri, 13 Mar 2020 14:02:20 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Andrew Boyer <aboyer@pensando.io>
CC:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Topic: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Index: AQHV+ENGNL7jbDp/V0iDqULaY56J2A==
Date:   Fri, 13 Mar 2020 06:02:20 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal> <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
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

On 2020/3/13 1:27, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
>>    What would you say to a per-process env variable to disable locking in
>>    a userspace provider?
> 
> That is also a no. verbs now has 'thread domain' who's purpose is to
> allow data plane locks to be skipped.
> 
> Generally new env vars in verbs are going to face opposition from
> me.
> 
> Jason
> 


Hi Leon and Jason,

Thanks for your comments. Do you have some suggestions on how to
achieve lockless flows in kernel? Are there any similar interfaces
in kernel like the thread domain in userspace?

Weihang
