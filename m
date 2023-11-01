Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4603F7DDDC3
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Nov 2023 09:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjKAIhH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Nov 2023 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKAIhH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Nov 2023 04:37:07 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D8FDF;
        Wed,  1 Nov 2023 01:37:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VvQscqP_1698827813;
Received: from 30.221.145.165(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VvQscqP_1698827813)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 16:36:54 +0800
Message-ID: <966f6d4d-722e-045c-891c-2e3553c6b81a@linux.alibaba.com>
Date:   Wed, 1 Nov 2023 16:36:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 2/3] net/smc: allow cdc msg send rather than drop it
 with NULL sndbuf_desc
Content-Language: en-US
To:     dust.li@linux.alibaba.com, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1698810177-69740-1-git-send-email-alibuda@linux.alibaba.com>
 <1698810177-69740-3-git-send-email-alibuda@linux.alibaba.com>
 <20231101081916.GG92403@linux.alibaba.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231101081916.GG92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




On 11/1/23 4:19 PM, Dust Li wrote:
> On Wed, Nov 01, 2023 at 11:42:56AM +0800, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch re-fix the issues memtianed by commit 22a825c541d7
> memtianed -> mentioned ?
>
>> ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").
>>
>> Blocking sending message do solve the issues though, but it also
>> prevents the peer to receive the final message. Besides, in logic,
>> whether the sndbuf_desc is NULL or not have no impact on the processing
>> of cdc message sending.
>>
>> Hence that, this patch allow the cdc message sending but to check the
> allows
>
>> sndbuf_desc with care in smc_cdc_tx_handler().
>>
>> Fixes: 22a825c541d7 ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()")
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks for that. I will fix them in next version.

> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> ---
>> net/smc/smc_cdc.c | 9 ++++-----
>> 1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>> index 01bdb79..3c06625 100644
>> --- a/net/smc/smc_cdc.c
>> +++ b/net/smc/smc_cdc.c
>> @@ -28,13 +28,15 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
>> {
>> 	struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend *)pnd_snd;
>> 	struct smc_connection *conn = cdcpend->conn;
>> +	struct smc_buf_desc *sndbuf_desc;
>> 	struct smc_sock *smc;
>> 	int diff;
>>
>> +	sndbuf_desc = conn->sndbuf_desc;
>> 	smc = container_of(conn, struct smc_sock, conn);
>> 	bh_lock_sock(&smc->sk);
>> -	if (!wc_status) {
>> -		diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
>> +	if (!wc_status && sndbuf_desc) {
>> +		diff = smc_curs_diff(sndbuf_desc->len,
>> 				     &cdcpend->conn->tx_curs_fin,
>> 				     &cdcpend->cursor);
>> 		/* sndbuf_space is decreased in smc_sendmsg */
>> @@ -114,9 +116,6 @@ int smc_cdc_msg_send(struct smc_connection *conn,
>> 	union smc_host_cursor cfed;
>> 	int rc;
>>
>> -	if (unlikely(!READ_ONCE(conn->sndbuf_desc)))
>> -		return -ENOBUFS;
>> -
>> 	smc_cdc_add_pending_send(conn, pend);
>>
>> 	conn->tx_cdc_seq++;
>> -- 
>> 1.8.3.1

