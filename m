Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBC5FD443
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 07:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJMFga (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 01:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMFga (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 01:36:30 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39EB10CF82
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 22:36:27 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="79832366"
X-IronPort-AV: E=Sophos;i="5.95,180,1661785200"; 
   d="scan'208";a="79832366"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Oct 2022 14:36:22 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E9D3D63B7
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 14:36:22 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 418A0E4639
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 14:36:21 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 587391145514;
        Thu, 13 Oct 2022 14:36:18 +0900 (JST)
Message-ID: <bd695f2f-b2d2-02ef-bc4d-ba64e5cc59f9@fujitsu.com>
Date:   Thu, 13 Oct 2022 13:36:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] RDMA/rxe: Handle remote errors in the midst of a Read
 reply sequence
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
References: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
 <20221013014724.3786212-2-matsuda-daisuke@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20221013014724.3786212-2-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27198.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27198.005
X-TMASE-Result: 10--16.006000-10.000000
X-TMASE-MatchedRID: qeYWT+AUEkGPvrMjLFD6eK5i3jK3KDOot3aeg7g/usC5IifwYL1+qxmE
        2Lk72Kw+BHGj1qouCqsuP7aUpb/kCC+3xqQ44pFWIuN48JyY3bkJKBFX4vuNlH7zXMne3nXuDJ9
        d5gU5UUdEilqyAMpqsuaffHI8kAmiHY/bzRmIaZHknMSTG9lH+ARryDXHx6oXPnZ8FlI6TJoEFi
        2mbQuRNsfKOfbHJ4us7oMhxEU/K+ZUeqJ6nMEMp4knvYO5kHScqxxYRyql7kvtc7tD4TcR66PFj
        JEFr+oloTCA5Efyn8C3ApS8cfJcZd0H8LFZNFG7bkV4e2xSge7VxUvBnzYgQS/PRpEGV90Ae3ZU
        YVqFpi8StaR8nFzQUhyFdNnda6Rv
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 13/10/2022 09:47, Daisuke Matsuda wrote:
> Requesting nodes do not handle a reported error correctly if it is
> generated in the middle of multi-packet Read responses, and the node tries
> to resend the request endlessly. Let completer terminate the connection in
> that case.
>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
> FOR REVIEWERS:
>    I referred to IB Specification Vol 1-Revision-1.5 to make this patch.
>    Please see Ch.9.9.2.2, Ch.9.9.2.4.2 and Table 59.
>
>   drivers/infiniband/sw/rxe/rxe_comp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index fb0c008af78c..c9170dd99f3a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -200,6 +200,10 @@ static inline enum comp_state check_psn(struct rxe_qp *qp,
>   		 */
>   		if (pkt->psn == wqe->last_psn)
>   			return COMPST_COMP_ACK;
> +		else if (pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE &&
> +			 (qp->comp.opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST ||
> +			  qp->comp.opcode == IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE))
When IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST or IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE will be assigned to qp->comp.opcode ?
I wonder if "(pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE) "  is enough ?

Thanks
Zhijian


> +			return COMPST_CHECK_ACK;
>   		else
>   			return COMPST_DONE;
>   	} else if ((diff > 0) && (wqe->mask & WR_ATOMIC_OR_READ_MASK)) {
> @@ -228,6 +232,10 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
>   
>   	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
>   	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
> +		/* Check NAK code to handle a remote error */
> +		if (pkt->opcode == IB_OPCODE_RC_ACKNOWLEDGE)
> +			break;
> +
>   		if (pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE &&
>   		    pkt->opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST) {
>   			/* read retries of partial data may restart from

