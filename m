Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C995175151
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfGYOgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 10:36:24 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:47460 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfGYOgY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 10:36:24 -0400
Received: from [195.176.96.210] (helo=[10.3.5.246])
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92)
        id 1hqer0-0004Vr-D6; Thu, 25 Jul 2019 16:36:22 +0200
Subject: Re: [PATCH 10/10] Replace tasklets with workqueues
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-11-mplaneta@os.inf.tu-dresden.de>
 <20190722153205.GG7607@ziepe.ca>
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Message-ID: <21a4daf9-c77e-ec80-9da0-78ab512d248d@os.inf.tu-dresden.de>
Date:   Thu, 25 Jul 2019 16:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722153205.GG7607@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Is this one better?

Replace tasklets with workqueues in rxe driver. The reason for this 
replacement is that tasklets are supposed to run atomically, although 
the actual code may block.

Modify the SKB destructor for outgoing SKB's to schedule QP tasks only 
if the QP is not destroyed itself.

Add a variable "pending_skb_down" to ensure that reference counting for 
a QP is decremented only when QP access related to this skb is over.

Separate part of pool element cleanup code to allow this code to be 
called in the very end of cleanup, even if some of cleanup is scheduled 
for asynchronous execution. Example, when it was happening is destructor 
for a QP.

Disallow calling of task functions "directly". This allows to simplify 
logic inside rxe_task.c

Schedule rxe_qp_do_cleanup onto high-priority system workqueue, because 
this function can be scheduled from normal system workqueue.

Before destroying a QP, wait until all references to this QP are gone. 
Previously the problem was that outgoing SKBs could be freed after the 
QP these SKBs refer to is destroyed.

Add blocking rxe_run_task to replace __rxe_do_task that was calling task 
function directly.

On 22/07/2019 17:32, Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019 at 05:14:26PM +0200, Maksym Planeta wrote:
>> Replace tasklets with workqueues in rxe driver.
>>
>> Ensure that task is called only through a workqueue. This allows to
>> simplify task logic.
>>
>> Add additional dependencies to make sure that cleanup tasks do not
>> happen after object's memory is already reclaimed.
>>
>> Improve overal stability of the driver by removing multiple race
>> conditions and use-after-free situations.
> 
> This should be described more precisely
> 
> Jason
> 

-- 
Regards,
Maksym Planeta
