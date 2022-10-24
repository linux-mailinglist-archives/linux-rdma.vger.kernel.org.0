Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397676098E1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 05:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJXDah (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 23:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJXDaH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 23:30:07 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18D664D6;
        Sun, 23 Oct 2022 20:26:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="92959263"
X-IronPort-AV: E=Sophos;i="5.95,207,1661785200"; 
   d="scan'208";a="92959263"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Oct 2022 12:26:43 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C7B22D6476;
        Mon, 24 Oct 2022 12:26:41 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C663ED4BE5;
        Mon, 24 Oct 2022 12:26:40 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 207812340C17;
        Mon, 24 Oct 2022 12:26:38 +0900 (JST)
Message-ID: <58522e46-9d45-53f3-9a19-351cc58c88e9@fujitsu.com>
Date:   Mon, 24 Oct 2022 11:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
Content-Language: en-US
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
 <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27220.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27220.004
X-TMASE-Result: 10--10.295300-10.000000
X-TMASE-MatchedRID: a3o/0593/lqPvrMjLFD6eLFpbR9jggy4C//1TMV5chNWjSWvFszxq01N
        J2MN+nPkH3zzqJhH7/QB11rlDcR0Vj+7nvNv6fe6qhcdnP91eXHBOVz0Jwcxl6vCrG0TnfVUilv
        Ab18i4hNvF9oQ/B54yP+UfwCF49dBGAdnzrnkM485f9Xw/xqKXZwhktVkBBrQeFIQTy0Zb4b7H+
        hZKy6/KwtuKBGekqUpI/NGWt0UYPCAWRagkK8OlcpPWztRNE55WOAKjUHD68q6kZurkcq+ZnQEk
        Bs4wl7w
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just noticed i didn't post [2/2] successfully, will sent it in next version.



On 21/10/2022 15:52, Li Zhijian wrote:
> Before the testing, we already passed it to rxe_mr_copy() where mr could
> be dereferenced. so this checking is not exactly correct.
>
> I tried to figure out the details how/when mr could be NULL, but failed
> at last. Add a WARN_ON(!mr) to that path to tell us more when it
> happends.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index ed5a09e86417..218c14fb07c6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	if (res->state == rdatm_res_state_new) {
>   		if (!res->replay) {
>   			mr = qp->resp.mr;
> +			WARN_ON(!mr);
>   			qp->resp.mr = NULL;
>   		} else {
>   			mr = rxe_recheck_mr(qp, res->read.rkey);
> @@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   
>   	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>   		    payload, RXE_FROM_MR_OBJ);
> -	if (mr)
> -		rxe_put(mr);
> +	rxe_put(mr);
>   
>   	if (bth_pad(&ack_pkt)) {
>   		u8 *pad = payload_addr(&ack_pkt) + payload;

