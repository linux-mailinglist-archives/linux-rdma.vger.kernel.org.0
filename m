Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD65AFAF
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2019 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF3Kvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jun 2019 06:51:49 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:32816 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfF3Kvt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jun 2019 06:51:49 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Jun 2019 06:51:48 EDT
Received: from [212.51.138.162] (helo=[192.168.70.47])
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92)
        id 1hhX3y-000195-4Y; Sun, 30 Jun 2019 12:28:02 +0200
To:     monis@mellanox.com, yanjun.zhu@oracle.com
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, dledford@redhat.com
Subject: Unclear comment or a potential bug
Message-ID: <6cf62aae-9537-a34a-be6a-b115d8d9a287@os.inf.tu-dresden.de>
Date:   Sun, 30 Jun 2019 12:27:56 +0200
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

I'm reading through SoftRoCE implementation and I stumbled across 
implementation of rxe_requester in file 
drivers/infiniband/sw/rxe/rxe_resp.c function. This function implements 
a state machine to represent states of the packet.

The function duplicate_request inside rxe_resp.c may decide to 
retransmit the packet (line 1133) by calling rxe_xmit_packet. Then the 
else branch falls through to execute the line 1142. There is a following 
comment before this line:

   Resource not found. Class D error. Drop the request.

If the code is correct, executing line 1142 after 1133 can be a result 
of an error. Furthermore, the result of executing line 1142 is that 
further the packet memory will be freed in cleanup function. Although a 
reference to this memory may still exist, because the packet may still 
stay in transmission.

Unfortunately, I do not have enough expertise to give a confident 
judgment, but I'm sure that there is one of two cases: either the 
comment is incorrect, or the line should not be hit after re-transmission.

-- 
Regards,
Maksym Planeta
