Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44108B422
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfHMJby (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 05:31:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfHMJbx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 05:31:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7965BAF3B0021DC987E1;
        Tue, 13 Aug 2019 17:31:49 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 17:31:38 +0800
Subject: Re: [PATCH V4 for-next 14/14] RDMA/hns: Use the new APIs for printing
 log
From:   oulijun <oulijun@huawei.com>
To:     Doug Ledford <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
 <1565276034-97329-15-git-send-email-oulijun@huawei.com>
 <e89dd9d3c6b38f826252c00d1f7becb96cac7bad.camel@redhat.com>
 <0466fce2-1cde-73d5-fc98-25930dd9957b@huawei.com>
Message-ID: <e741a9b0-a716-3cb0-4635-1e71a431fb33@huawei.com>
Date:   Tue, 13 Aug 2019 17:31:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <0466fce2-1cde-73d5-fc98-25930dd9957b@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/8/13 17:13, oulijun 写道:
> 在 2019/8/12 22:48, Doug Ledford 写道:
>> On Thu, 2019-08-08 at 22:53 +0800, Lijun Ou wrote:
>>> -               dev_err(&hr_dev->dev, "Destroy qp 0x%06lx
>>> failed(%d)\n",
>>> -                       hr_qp->qpn, ret);
>>> +               ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx
>>> failed(%d)\n",
>>> +                         hr_qp->qpn, ret);
>> And then fixed it up here too.
>>
> Thanks. I will be more careless in the next time.
>
>
>
> .
>
Sorry, I will be more careful in the next time.


