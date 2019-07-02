Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61A55CE89
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2019 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGBLjP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 07:39:15 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:37244 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBLjP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 07:39:15 -0400
Received: from [195.176.96.212] (helo=[10.3.4.72])
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92)
        id 1hiH7w-0002le-Sh; Tue, 02 Jul 2019 13:39:12 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [infiniband/rxe] Inconsistent locking in SoftRoCE
To:     monis@mellanox.com, yanjun.zhu@oracle.com
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, dledford@redhat.com
Message-ID: <3e349129-5de6-88a5-1ef9-b7a34c242769@os.inf.tu-dresden.de>
Date:   Tue, 2 Jul 2019 13:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear All,

I'm reading through SoftRoCE implementation further and I stumbled 
across following inconsistent locking.

Sometimes access to qp->req.state is protected by lock qp->state_lock, 
like for example here: 
https://elixir.bootlin.com/linux/v5.2-rc7/source/drivers/infiniband/sw/rxe/rxe_comp.c#L488

But it is not protected inside rxe_qp_error function here:

https://elixir.bootlin.com/linux/v5.2-rc7/source/drivers/infiniband/sw/rxe/rxe_qp.c#L574

Moreover the comment to the state_lock says it protects both requester 
and completer. First, completer does not have "state" variable inside 
rxe_comp_info structure. Second, there is such variable inside 
"rxe_resp_info" structure that is not protected.

If the goal is to protect only the state of requster, th it makes sense 
to keep state_lock inside struct rxe_req_info.

If the goal is to protect all state variables, then state inside struct 
rxe_resp_info should be protected.

-- 
Regards,
Maksym Planeta
