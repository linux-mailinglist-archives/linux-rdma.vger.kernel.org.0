Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D8857E4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 03:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfHHB7b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 21:59:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730038AbfHHB7b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 21:59:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7AB4C678FD00CB725A9E;
        Thu,  8 Aug 2019 09:59:27 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.88) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 09:59:18 +0800
Subject: Re: [bug report] rdma: rtnl_lock deadlock?
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <5D4A3597.5020406@huawei.com> <20190807121037.GC1557@ziepe.ca>
CC:     <bvanassche@acm.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <yebiaoxiang@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>
From:   Jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5D4B81F6.7010002@huawei.com>
Date:   Thu, 8 Aug 2019 09:59:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20190807121037.GC1557@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.88]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On 2019/8/7 20:10, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2019 at 10:21:11AM +0800, Jiangyiwen wrote:
>> Hello,
>>
>> I find a scenario may cause deadlock of rtnl_lock as follows:
>>
>> 1. CPU1 add rtnl_lock and wait kworker finished.
>> CPU1 add rtnl_lock before call unregister_netdevice_queue() and
>> then wait sport->work(function srpt_refresh_port_work) finished
>> in srpt_remove_one().
> This is an old kernel, this issue has been fixed
>
> Jason
>
Thank you for your reply, and can you tell me the commit id?
I use the kernel version is Linux4.19.36.

Thanks,
Yiwen.

