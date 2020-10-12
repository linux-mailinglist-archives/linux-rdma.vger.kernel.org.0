Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB84228BBF1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389771AbgJLPcX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 11:32:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52709 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389340AbgJLPcX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 11:32:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kRzoD-00041a-BW; Mon, 12 Oct 2020 15:32:21 +0000
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <yanjunz@nvidia.com>,
        "Doug Ledford <dledford"@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()
Message-ID: <9ca5205a-ee1c-0ad6-3e9d-3287e92714a1@canonical.com>
Date:   Mon, 12 Oct 2020 16:32:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Static analysis with Coverity has detected a potential issue with the
following commit:

commit e7ec96fc7932f48a6d6cdd05bf82004a1a04285b
Author: Bob Pearson <rpearsonhpe@gmail.com>
Date:   Thu Oct 8 15:36:52 2020 -0500

    RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()

The analysis is as follows:

   16. Condition mce->qp_list.next != &mcg->qp_list, taking true branch.

269                if (mce->qp_list.next != &mcg->qp_list)

   17. returned_null: skb_clone returns NULL (checked 153 out of 178 times).
   18. var_assigned: Assigning: per_qp_skb = NULL return value from
skb_clone.
   19. Falling through to end of if statement.
270                        per_qp_skb = skb_clone(skb, GFP_ATOMIC);
271                else
272                        per_qp_skb = skb;
273
274                per_qp_pkt = SKB_TO_PKT(per_qp_skb);
275                per_qp_pkt->qp = qp;
276                rxe_add_ref(qp);

Dereference null return value (NULL_RETURNS)
    20. dereference: Dereferencing a pointer that might be NULL
per_qp_skb when calling rxe_rcv_pkt.
277                rxe_rcv_pkt(per_qp_pkt, per_qp_skb);
278        }
279

It is possible for skb_clone to return NULL, so dereferencing the NULL
return pointer per_qp_skb is a potential issue.

Colin

