Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4D8B380
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfHMJNk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 05:13:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfHMJNk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 05:13:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EA7E1BE070210E3401C4;
        Tue, 13 Aug 2019 17:13:38 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 17:13:32 +0800
Subject: Re: [PATCH V4 for-next 14/14] RDMA/hns: Use the new APIs for printing
 log
To:     Doug Ledford <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
 <1565276034-97329-15-git-send-email-oulijun@huawei.com>
 <e89dd9d3c6b38f826252c00d1f7becb96cac7bad.camel@redhat.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <0466fce2-1cde-73d5-fc98-25930dd9957b@huawei.com>
Date:   Tue, 13 Aug 2019 17:13:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <e89dd9d3c6b38f826252c00d1f7becb96cac7bad.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/8/12 22:48, Doug Ledford 写道:
> On Thu, 2019-08-08 at 22:53 +0800, Lijun Ou wrote:
>> -               dev_err(&hr_dev->dev, "Destroy qp 0x%06lx
>> failed(%d)\n",
>> -                       hr_qp->qpn, ret);
>> +               ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx
>> failed(%d)\n",
>> +                         hr_qp->qpn, ret);
> And then fixed it up here too.
>
Thanks. I will be more careless in the next time.


