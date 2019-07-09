Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D8D633B2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGIJxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 05:53:40 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:51886 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfGIJxk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 05:53:40 -0400
Received: from [195.176.96.241] (helo=[10.3.4.34])
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92)
        id 1hkmod-0001TA-2j; Tue, 09 Jul 2019 11:53:39 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [RFC, BUG] ibverbs/rxe: Potential use after free
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Message-ID: <0f963bea-9c71-2def-f120-8f5fd93435e4@os.inf.tu-dresden.de>
Date:   Tue, 9 Jul 2019 11:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello All,

SoftRoCE driver (drivers/infiniband/sw/rxe) contains several tasklets: 
rxe_requester (in rxe_req.c), rxe_completer (rxe_comp.c), and 
rxe_responder (in rxe_resp.c).

All of these tasklets can be scheduled for asynchronous execution by 
calling function rxe_run_task (rxe_task.c) with sched=1. In this case 
the tasklet is passed to tasklet_schedule.

These tasklets receive as a parameter a queue pair (QP) object that is 
allocated from a dedicated memory pool implemented in rxe_pool.c and is 
reference counted.

The first thing this tasklets do is increasing reference count for a QP 
object by calling rxe_add_ref (call kref_get).

I thin this behavior is erroneous. It is possible for reference counter 
to go down to zero, when a tasklet is scheduled for execution. This can 
happen, for example, if a tasklet is scheduled and then the process that 
created a QP is destroyed before the tasklet runs. When a process is 
destroyed, the reference count for QP will go down and can reach zero.

As result, the QP object can be already destroyed by the time the 
tasklet is actually run. This will result into use-after-free.

The proper way to implement this case would be to call rxe_add_ref 
*before* tasklet_schedule: Either inside rxe_run_task, when sched equals 
1, or before rxe_run_task.

If you think my reasoning is correct, I can prepare a patch.

I would be happy to see any comment from you before that, as I'm new to 
kernel programming.

-- 
Regards,
Maksym Planeta
