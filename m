Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1EE798038
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 03:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjIHBfM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Sep 2023 21:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjIHBfL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Sep 2023 21:35:11 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4B1BD9
        for <linux-rdma@vger.kernel.org>; Thu,  7 Sep 2023 18:35:05 -0700 (PDT)
Message-ID: <332d5cd8-c0ab-3657-513d-0d385fc4bdca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694136903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LP/y5xGfIbK4Rs5aCZwdj37gLU9jDNrII6xvBf338hU=;
        b=jM/p+Cbhhyt3mr1q04p/FPcA9UDDB2wwaC5gqdSxxWawnjGubnquUmFMvFTfVND0Jaz7af
        RNlKqHPmh1MeqmkJ9QEMrBfoPZin6yHbGpYl4PVfS1g8voSVAhhCXuEFDm9Ln1OsriSAhS
        e94EG4LSmuA7G9AGyWxqbOBvT/QygIo=
Date:   Fri, 8 Sep 2023 09:34:54 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2] RDMA/siw: Fix connection failure handling
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org
References: <20230905145822.446263-1-bmt@zurich.ibm.com>
Content-Language: en-US
In-Reply-To: <20230905145822.446263-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 9/5/23 22:58, Bernard Metzler wrote:
> In case immediate MPA request processing fails, the newly
> created endpoint unlinks the listening endpoint and is
> ready to be dropped. This special case was not handled
> correctly by the code handling the later TCP socket close,
> causing a NULL dereference crash in siw_cm_work_handler()
> when dereferencing a NULL listener. We now also cancel
> the useless MPA timeout, if immediate MPA request
> processing fails.
>
> This patch furthermore simplifies MPA processing in general:
> Scheduling a useless TCP socket read in sk_data_ready() upcall
> is now surpressed, if the socket is already moved out of
> TCP_ESTABLISHED state.
>
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Signed-off-by: Bernard Metzler<bmt@zurich.ibm.com>
> ---
> ChangeLog v1->v2:
> - Move debug message to now conditional listener drop
> ---
>   drivers/infiniband/sw/siw/siw_cm.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index a2605178f4ed..43e776073f49 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -976,6 +976,7 @@ static void siw_accept_newconn(struct siw_cep *cep)
>   			siw_cep_put(cep);
>   			new_cep->listen_cep = NULL;
>   			if (rv) {
> +				siw_cancel_mpatimer(new_cep);

One question, why siw_cm_work_handler set cep->mpa_timer to NULL instead 
of call
siw_cancel_mpatimer like above? Could it be memory leak issue for 
cep->mpa_timer?
Let's say mpa_timer is set to NULL before  call siw_cancel_mpatimer.

>   				siw_cep_set_free(new_cep);
>   				goto error;
>   			}
> @@ -1100,9 +1101,12 @@ static void siw_cm_work_handler(struct work_struct *w)
>   				/*
>   				 * Socket close before MPA request received.
>   				 */
> -				siw_dbg_cep(cep, "no mpareq: drop listener\n");
> -				siw_cep_put(cep->listen_cep);
> -				cep->listen_cep = NULL;
> +				if (cep->listen_cep) {
> +					siw_dbg_cep(cep,
> +						"no mpareq: drop listener\n");
> +					siw_cep_put(cep->listen_cep);
> +					cep->listen_cep = NULL;
> +				}
>   			}
>   		}
>   		release_cep = 1;
> @@ -1227,7 +1231,11 @@ static void siw_cm_llp_data_ready(struct sock *sk)
>   	if (!cep)
>   		goto out;
>   
> -	siw_dbg_cep(cep, "state: %d\n", cep->state);
> +	siw_dbg_cep(cep, "cep state: %d, socket state %d\n",
> +		    cep->state, sk->sk_state);
> +
> +	if (sk->sk_state != TCP_ESTABLISHED)
> +		goto out;
>   

Maybe split above to another patch makes more sense, just my $0.02.

Thanks,
Guoqing
