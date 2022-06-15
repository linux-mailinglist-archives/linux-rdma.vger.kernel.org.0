Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF554C535
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbiFOJ4l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiFOJ4l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 05:56:41 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105F149F21
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 02:56:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VGScdKJ_1655286995;
Received: from 30.43.105.181(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VGScdKJ_1655286995)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 17:56:36 +0800
Message-ID: <5f0f58b3-2357-a9dd-dba8-1b7615fe63f5@linux.alibaba.com>
Date:   Wed, 15 Jun 2022 17:56:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] rdma/siw: implement non-blocking connect.
Content-Language: en-US
To:     Stefan Metzmacher <metze@samba.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
References: <cover.1655248086.git.metze@samba.org>
 <56c6768ccff38b64feb4dbbded754da3138dbd50.1655248086.git.metze@samba.org>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <56c6768ccff38b64feb4dbbded754da3138dbd50.1655248086.git.metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/15/22 4:40 PM, Stefan Metzmacher wrote:

<...>

> @@ -1279,12 +1285,26 @@ static void siw_cm_llp_state_change(struct sock *sk)
>   
>   	switch (sk->sk_state) {
>   	case TCP_ESTABLISHED:
> -		/*
> -		 * handle accepting socket as special case where only
> -		 * new connection is possible
> -		 */
> -		siw_cm_queue_work(cep, SIW_CM_WORK_ACCEPT);
> -		break;
> +		if (cep->state == SIW_EPSTATE_CONNECTING) {
> +			/*
> +			 * handle accepting socket as special case where only
> +			 * new connection is possible
> +			 */
> +			siw_cm_queue_work(cep, SIW_CM_WORK_CONNECTED);
> +			break;
> +
> +		} else if (cep->state == SIW_EPSTATE_LISTENING) {
> +			/*
> +			 * handle accepting socket as special case where only
> +			 * new connection is possible
> +			 */
> +			siw_cm_queue_work(cep, SIW_CM_WORK_ACCEPT);
> +			break;
> +		}
> +		siw_dbg_cep(cep,
> +			    "unexpected socket state %d with cep state %d\n",
> +			    sk->sk_state, cep->state);
> +		fallthrough;
>   

Is "faillthrough" a annotation ?

Thanks,
Cheng Xu

