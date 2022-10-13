Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3D5FD3B5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 06:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJMEOo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 00:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJMEOn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 00:14:43 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509125D9
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 21:14:40 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="91583039"
X-IronPort-AV: E=Sophos;i="5.95,180,1661785200"; 
   d="scan'208";a="91583039"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Oct 2022 13:14:39 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id AA97CD4324
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 13:14:37 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com [192.51.207.12])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E0B93110972
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 13:14:36 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7BD72867EC;
        Thu, 13 Oct 2022 13:14:34 +0900 (JST)
Message-ID: <dade75f2-136c-2844-4fb6-b789e3cf9ffd@fujitsu.com>
Date:   Thu, 13 Oct 2022 12:14:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] RDMA/rxe: Make responder handle RDMA Read failures
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
References: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27198.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27198.004
X-TMASE-Result: 10--10.487300-10.000000
X-TMASE-MatchedRID: AvuQOGDihJqPvrMjLFD6eK5i3jK3KDOoofZV/2Xa0cJ8i9rpXhiyZyyF
        honDXgSEQMOJEqjTDADZiF640lFUcAPr39AlikWtXYn+KMALFMb2W3gEBC4gVH+JnVo2xgbuXvb
        V/VnUv0oi+t+0AiFaYvL3NxFKQpq18gFf6MN9cauXfrypKnpvnn0tCKdnhB58vqq8s2MNhPAir3
        kOMJmHTCYG93cCja46v79FIUygvZzEQdG7H66TyH4gKq42LRYkQHIrPXFLZewcWiwA4bFLm/+br
        TwcWBnA1FQauo5y1Gt+3BndfXUhXQ==
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
> Currently, responder can reply packets with invalid payloads if it fails to
> copy messages to the packets. Add an error handling in read_reply() to
> inform a requesting node of the failure.
>
> Suggested-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

thx
Zhijian

> ---
> FOR REVIEWERS:
>    I referred to IB Specification Vol 1-Revision-1.5 to make this patch.
>    Please see Ch.9.7.5.2.4, Ch.9.7.4.1.5 and Ch.9.7.5.1.3.
>
>   drivers/infiniband/sw/rxe/rxe_resp.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index ed5a09e86417..82b74e926e09 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -809,10 +809,14 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	if (!skb)
>   		return RESPST_ERR_RNR;
>   
> -	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> -		    payload, RXE_FROM_MR_OBJ);
> +	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> +			  payload, RXE_FROM_MR_OBJ);
>   	if (mr)
>   		rxe_put(mr);
> +	if (err) {
> +		kfree_skb(skb);
> +		return RESPST_ERR_RKEY_VIOLATION;
> +	}
>   
>   	if (bth_pad(&ack_pkt)) {
>   		u8 *pad = payload_addr(&ack_pkt) + payload;

