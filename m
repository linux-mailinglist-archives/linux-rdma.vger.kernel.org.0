Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97EE1278F6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 11:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLTKNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 05:13:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727235AbfLTKNG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Dec 2019 05:13:06 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BD44B9CFF79908F03D0;
        Fri, 20 Dec 2019 18:13:02 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Dec 2019
 18:12:52 +0800
Subject: Re: [PATCH v3 for-next 0/2] Fix crash due to sleepy mutex while
 holding lock in post_{send|recv|poll}
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1574335200-34923-1-git-send-email-liuyixian@huawei.com>
 <c6d0f4bb-aca6-86f6-f909-d91ed9e58216@huawei.com>
 <20191218140026.GF17227@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <8e7fd052-1d3e-c408-5589-af0344084874@huawei.com>
Date:   Fri, 20 Dec 2019 18:12:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20191218140026.GF17227@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/12/18 22:00, Jason Gunthorpe wrote:
> On Mon, Dec 16, 2019 at 08:51:03PM +0800, Liuyixian (Eason) wrote:
>> Hi Jason,
>>
>> I want to make sure that is there any further comments on this patch set?
> 
> I still dislike it alot.
> 

Hi Jason,

Thanks for reply :)
Let us recall the previous discussions and check is there anything is pending on.

Comments in patch set V1:
1: why do you need a dedicated HIGHPRI work queue?
   -- Accepted. The HIGHPRI flag was moved out from v2.
2. As far as I could tell the only thing the triggered the work to run
   was some variable which was only set in another work queue 'hns_roce_irq_work_handle()'
   -- Accepted. No new work queue is created but the irq WQ is reused from v2.
3. don't do allocations at all if you can't allow them to fail.
   -- Accepted. The flush_work structure is initialized at compile time.

Comments in patch set V2:
1. It kind of looks like this can be called multiple times? It won't work
   right unless it is called exactly once.
   -- Agreed. So I proposed to fall back to V1 in V3 again.
2. Why do you need more than one work in parallel for this? Once you
   start to move the HW to error that only has to happen once, surely?
   -- Explained. This question has raised out the key point of our solution.
      Flush operation should be implemented once the QP state is going to
      be error or the producer index is updated for the QP in error state.
3. The work function does something that looks like it only has to happen
   once per QP. One do you need to keep re-queing this thing every time the user posts
   a WR?
   -- Explained. The root cause is that hip08 needs the newest PI to flush the outstanding
      wqe every time the PI is updated. That's re-queuing is needed.

In conclusion, we have accepted all the comments in V1, and explained to all 3 comments in V2
but no further response. Do I have missed to cover any of your concerns?

I would really appreciate it if you could help to point out the unsolved issue.

Thanks.

