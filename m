Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F041B7081B7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 May 2023 14:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjERMr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 08:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjERMrz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 08:47:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5640E51
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 05:47:54 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ab1a20aa12so1397777a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684414074; x=1687006074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mr01WEiGgK9SvPVg8xkqj/SMBMoFxeJukOSq2gzkP9w=;
        b=rTpiFFj8URldjoJfxADx4F7zeNHzh08T/QXY5SItydIL/T4E4OuCBr9cekdsLenH+8
         ntmsLTlFhh8rBycQzpz/VlVAiycfJYHSELr5+ww061i/VGsDQNbYL1wb/M5XQGc4w6ZI
         XiTE+AG35UwGUvIzrWmma5LGHD0o12Ge4AcAtK7SNUYPF0INcmbkajMMyN1flNIM5TWe
         RZnlFeDXBkBYJOdZcIRICL2mDaHe7qiKIsDVbinSF4IROf06+xSW8LbKn23ykHJxVkZD
         NSy7bDOTzd69rVUUZC7gDQCPXgL+vJcJzTHGZ/8kW7Quz7tZU4jlQGhGzy1j5lNM36e8
         bpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684414074; x=1687006074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr01WEiGgK9SvPVg8xkqj/SMBMoFxeJukOSq2gzkP9w=;
        b=CCoPsPNsMLUK8bcHRjkO5vJngBpQmB/aPP7y/uB/Ov0s7JqwPUja3C7Ky3luUlsH8L
         NqWDGYOKCowzdlxub8vdSy2cmqc5O1BhpNTnLk5K/QGqrKGFLxIZBqxmofpdgtzTM6vi
         f5ZqZF1u3r0VRfoO18N9dxp1497ir1VkHbwSsOA7fAmQfKeI08SqsfyLNHcYpUwvQDvN
         l2qr2PuDfv3punahPIVUvNWQxlU5ZDeCHbJB1+jwQcZe9cypR+DFcfO29TNoldoNneTp
         AJUyahNdLbXb8e5ZU819HxPklnaTeNeHeROmfcn7UIEk7ouzM6PgRYV+/8SbqriaISWI
         YNOQ==
X-Gm-Message-State: AC+VfDzvC2/PxSxSo2uQrCjmE2E3j5ykWHgDx5twkUJJKB4lb7u0ez0Y
        2HgZCrkBGfnjcwidmw3n+os=
X-Google-Smtp-Source: ACHHUZ7z1L4M2+UMyqnK19yxDCZ71CEHktP0KVah/7u6CUubOhsqwdbt+pehqEas1r5fNqk5cvioVg==
X-Received: by 2002:a9d:6f96:0:b0:6aa:e18e:b78a with SMTP id h22-20020a9d6f96000000b006aae18eb78amr1296469otq.1.1684414074050;
        Thu, 18 May 2023 05:47:54 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:72ad:3982:4004:eb02? (2603-8081-140c-1a00-72ad-3982-4004-eb02.res6.spectrum.com. [2603:8081:140c:1a00:72ad:3982:4004:eb02])
        by smtp.gmail.com with ESMTPSA id z11-20020a9d62cb000000b006ac98aae2d3sm608965otk.40.2023.05.18.05.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 05:47:53 -0700 (PDT)
Message-ID: <2b91a79b-29dd-2695-988a-33ba5360f3fe@gmail.com>
Date:   Thu, 18 May 2023 07:47:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH jgg-for-next] RDMA/rxe: Fix comments about removed
 tasklets
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, jgg@nvidia.com
Cc:     leonro@nvidia.com, zyjzyj2000@gmail.com
References: <20230518070027.942715-1-matsuda-daisuke@fujitsu.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230518070027.942715-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 02:00, Daisuke Matsuda wrote:
> The commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> removed tasklets and replaced them with a workqueue, but relevant comments
> are still remaining in the source code.
> 
> Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c  | 2 +-
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  drivers/infiniband/sw/rxe/rxe_req.c   | 2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index db18ace74d2b..0c0ae214c3a9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -826,7 +826,7 @@ int rxe_completer(struct rxe_qp *qp)
>  	}
>  
>  	/* A non-zero return value will cause rxe_do_task to
> -	 * exit its loop and end the tasklet. A zero return
> +	 * exit its loop and end the work item. A zero return
>  	 * will continue looping and return to rxe_completer
>  	 */
>  done:
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 7b41d79e72b2..d2f57ead78ad 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -112,7 +112,7 @@ enum rxe_device_param {
>  	RXE_INFLIGHT_SKBS_PER_QP_HIGH	= 64,
>  	RXE_INFLIGHT_SKBS_PER_QP_LOW	= 16,
>  
> -	/* Max number of interations of each tasklet
> +	/* Max number of interations of each work item
>  	 * before yielding the cpu to let other
>  	 * work make progress
>  	 */
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 65134a9aefe7..400840c913a9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -853,7 +853,7 @@ int rxe_requester(struct rxe_qp *qp)
>  	update_state(qp, &pkt);
>  
>  	/* A non-zero return value will cause rxe_do_task to
> -	 * exit its loop and end the tasklet. A zero return
> +	 * exit its loop and end the work item. A zero return
>  	 * will continue looping and return to rxe_requester
>  	 */
>  done:
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 68f6cd188d8e..b92c41cdb620 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1654,7 +1654,7 @@ int rxe_responder(struct rxe_qp *qp)
>  	}
>  
>  	/* A non-zero return value will cause rxe_do_task to
> -	 * exit its loop and end the tasklet. A zero return
> +	 * exit its loop and end the work item. A zero return
>  	 * will continue looping and return to rxe_responder
>  	 */
>  done:

Looks fine. Thanks.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
