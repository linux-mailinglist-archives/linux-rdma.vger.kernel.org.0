Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDB163EED
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 09:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgBSIWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 03:22:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbgBSIWe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 03:22:34 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5C22BC2C2E0CFE147572;
        Wed, 19 Feb 2020 16:22:27 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Feb 2020
 16:22:17 +0800
Subject: Re: [PATCH v2 for-next 0/7] RDMA/hns: Refactor qp related code
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
 <20200219005243.GB25540@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <79fc6359-7e8d-5da2-eb26-bd4d90350845@huawei.com>
Date:   Wed, 19 Feb 2020 16:22:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200219005243.GB25540@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/19 8:52, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2020 at 05:08:33PM +0800, Weihang Li wrote:
>> This series refactor qp related code, including creating, destroying qp and
>> so on to make the processs easier to understand and maintain.
>>
>> Previous disscussion can be found at:
>> https://patchwork.kernel.org/cover/11341265/
>>
>> Changes since v1:
>> - Reduce the number of prints as Leon suggested.
>> - Fix a wrong function name in description of patch 4/7.
>>
>> Xi Wang (7):
>>   RDMA/hns: Optimize qp destroy flow
>>   RDMA/hns: Optimize qp context create and destroy flow
>>   RDMA/hns: Optimize qp number assign flow
>>   RDMA/hns: Optimize qp buffer allocation flow
>>   RDMA/hns: Optimize qp param setup flow
>>   RDMA/hns: Optimize kernel qp wrid allocation flow
>>   RDMA/hns: Optimize qp doorbell allocation flow
> 
> These don't apply, please resend.
> 
> Jason
> 

OK, will resend a new version. Thank you.

Weihang

> 

