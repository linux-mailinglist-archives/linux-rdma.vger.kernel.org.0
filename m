Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A1254C579
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 12:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347506AbiFOKIg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbiFOKIb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 06:08:31 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B42B26F
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 03:08:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VGSd2q1_1655287705;
Received: from 30.43.105.181(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VGSd2q1_1655287705)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 18:08:26 +0800
Message-ID: <070fc3c2-69ec-9ad0-1bf5-8aa97d1564df@linux.alibaba.com>
Date:   Wed, 15 Jun 2022 18:08:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] rdma/siw: start mpa timer before calling
 siw_send_mpareqrep()
Content-Language: en-US
To:     Stefan Metzmacher <metze@samba.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
References: <cover.1655248086.git.metze@samba.org>
 <505a18c83a283963174c9e567ce73d055e26ec7b.1655248086.git.metze@samba.org>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <505a18c83a283963174c9e567ce73d055e26ec7b.1655248086.git.metze@samba.org>
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
> The mpa timer will also span the non-blocking connect
> in the final patch.
> 
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> Cc: Bernard Metzler <bmt@zurich.ibm.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>   drivers/infiniband/sw/siw/siw_cm.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index b19a2b777814..3fee1d4ef252 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1476,6 +1476,11 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
>   		cep->mpa.hdr.params.pd_len = pd_len;
>   	}
>   
> +	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
> +	if (rv != 0) {
> +		goto error;
> +	}
> +
>   	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
>   

Here starts the MPA timer, but the cep->state is SIW_EPSTATE_CONNECTING.

Consider the case when the connection timeout: the MPA timeout handler
will release resources if cep->state is SIW_EPSTATE_AWAIT_MPAREP and
SIW_EPSTATE_AWAIT_MPAREQ, not including SIW_EPSTATE_CONNECTING.

I think you should handle this case in the MPA timeout handler: report
a cm event and set release_cep with 1. Otherwise it will cause resource
leak.

Thanks,
Cheng Xu

