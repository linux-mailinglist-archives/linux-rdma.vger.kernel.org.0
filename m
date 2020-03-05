Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA0179FC7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 07:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCEGJP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 5 Mar 2020 01:09:15 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbgCEGJO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 01:09:14 -0500
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 8A04E3CC1E0318BCE4F1;
        Thu,  5 Mar 2020 14:09:10 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.20]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0439.000; Thu, 5 Mar 2020 14:09:00 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 4/5] RDMA/hns: Optimize base address table
 config flow for qp buffer
Thread-Topic: [PATCH for-next 4/5] RDMA/hns: Optimize base address table
 config flow for qp buffer
Thread-Index: AQHV8IxGEPtoHaEe8k6K7X6fFZ5hYA==
Date:   Thu, 5 Mar 2020 06:08:59 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A02273E6B@DGGEML522-MBX.china.huawei.com>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-5-git-send-email-liweihang@huawei.com>
 <20200304191823.GA15415@ziepe.ca>
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

On 2020/3/5 3:18, Jason Gunthorpe wrote:
> On Mon, Mar 02, 2020 at 08:11:32PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Currently, before the qp is created, a page size needs to be calculated for
>> the base address table to store all base addresses in the mtr. As a result,
>> the parameter configuration of the mtr is complex. So integrate the process
>> of calculating the base table page size into the hem related interface to
>> simplify the process of using mtr.
> 
> This patch doesn't apply, and somehow it didn't get linked to the
> series in patchworks too. Looks like this patch was replaced somehow
> as it references the wrong In-Reply-To
> 
> Please be more careful that things go into patchworks properly and
> resend this series so it applies
> 
> Jason
> 

Sorry for that, I will resend a new version.
But I couldn't find the reason for this, maybe there were some network issues
with the machine I sent this series from.

Thanks,
Weihang
