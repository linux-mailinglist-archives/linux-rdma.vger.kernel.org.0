Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D245A00A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfF1Pzq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 11:55:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39436 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbfF1Pzq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 11:55:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E6AA2AF2BAF9936C94E8;
        Fri, 28 Jun 2019 23:55:42 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 23:55:35 +0800
Subject: =?UTF-8?Q?Re:_=e3=80=90A_question_about_kernel_verbs_API=e3=80=91?=
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <pandit.parav@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <8e80779d-7c1f-4644-3fa7-6fca24734eb8@huawei.com>
 <20190618201940.GF6945@mellanox.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <69864727-4cfb-8fcc-a2bb-ce4e46ddb8bb@huawei.com>
Date:   Fri, 28 Jun 2019 23:55:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190618201940.GF6945@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/6/19 4:19, Jason Gunthorpe 写道:
> On Fri, Jun 14, 2019 at 09:16:15AM +0800, oulijun wrote:
>> Hi， Jason Gunthorpe & Leon Romanovsky& Parav Pandit
>>    Recently when I was learning kernel ofed code, I found an interesting thing about verbs, the implementation rely on
>> roce driver,  taking ib_dereg_mr for example.
>>
>> When the driver returns error, the reference count of rdma
>> resource(pd, mr, etc.) won't be decreased. I worried that it will
>> cause a memory leak.
> The object was not destroyed, the caller has to try again.
>
> Jason

Thank your reply. I see.


