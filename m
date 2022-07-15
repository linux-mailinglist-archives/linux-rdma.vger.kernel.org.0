Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C635765BE
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiGORVy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jul 2022 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiGORVx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jul 2022 13:21:53 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A983F2C
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 10:21:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r22-20020a056830419600b0061c6edc5dcfso3933108otu.12
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=0NsPGXaQ5/GTl6LitJ+y4uo+ZpvYDR2Tfzvvec3t6gM=;
        b=IAkv2sSr/cWz3PkRvE0slYCcRJMj5OtbGCoEKlrAdw0ARm9mQeIkAYk2AbuFeJjANG
         K1vPrY/mf8ZTc2XgUoMiQPhA3H5lbd61Qx6Zdgw5zhr0La7cl1wj+L/Qx6QI0c2Lj9bX
         n6l/D1WDiXfa7RdBXczfIgl09EMH1uAEUGcFSQRIIdThwansJ3p4pj8AWMI4OE2IUh96
         H3FZrKDfdor29me/qZEuUPKOOR/CZMEhNCnbirJBn8R3X3m22w2MtRJGGCcelf5IL9mb
         jMSq23P9gjCpPPwC3+CKl6+Gijci8AFueWrHaLTIYfvPCLbk2qW+moUQjOXSPPMZoYuK
         BH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0NsPGXaQ5/GTl6LitJ+y4uo+ZpvYDR2Tfzvvec3t6gM=;
        b=fe5IqvvRIV1f6BVUuoR/9c1B+K7qEAgRuuXO39vX24JWgU0E9G8/P73fE4MU8yGsMr
         Q3nrtz6ICqkG3qEhoGLXqtnFbbyorBqdgRx3GPdIikEWKSSwaYbdv4+SqvIXF3s2mV8g
         utPsXfdtKmosIprNr1VUdEVYvPwqM7wO6pxQu0X6healD5ctsyXyqqrSTobVFN/gf3Hp
         Ng28t6BcCmnubNs/k7Ou/mxDiUoLhj1KFD/QFza2c9bpe6cj+KwDv6hbN7z0zARhK3IX
         VjuY3uWrushJr2u5g50j64piC0oRKmolL6WLe1SB16hY1zQzHiRGRSunrXeCITdeWIi9
         +LAQ==
X-Gm-Message-State: AJIora8+4oZ/AYTBOHJ+xpla+ldfNfhO/Raob9ouVzDLu3HrYoSGP9oq
        xkTEuRP5IRAgMrPh/NH1SRY=
X-Google-Smtp-Source: AGRyM1vGUmu7QiKnAASZNMlM6wemGfWxNiq/1l/U4i/7Kek5iceZAgximTmsVVgQJdLlvYIILeGiWQ==
X-Received: by 2002:a05:6830:61c1:b0:61c:56e1:d7c3 with SMTP id cc1-20020a05683061c100b0061c56e1d7c3mr6088058otb.90.1657905712050;
        Fri, 15 Jul 2022 10:21:52 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d7fe:5e08:17b5:c1dc? (2603-8081-140c-1a00-d7fe-5e08-17b5-c1dc.res6.spectrum.com. [2603:8081:140c:1a00:d7fe:5e08:17b5:c1dc])
        by smtp.gmail.com with ESMTPSA id g5-20020a056870c14500b0010c0d04eb00sm2792224oad.2.2022.07.15.10.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 10:21:51 -0700 (PDT)
Message-ID: <dc5168c3-0d3c-970a-652d-6bd1447a17a5@gmail.com>
Date:   Fri, 15 Jul 2022 12:21:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next v2] RDMA/rxe: Remove unused mask parameter
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220715035340.1900168-1-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220715035340.1900168-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/14/22 22:46, lizhijian@fujitsu.com wrote:
> This parameter had beed deprecated since below commit:
> 1a7085b34291 ("RDMA/rxe: Skip adjusting remote addr for write in retry operation")
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Feel free to add above commit to fixes tag if needed.
> V2: add commit log.
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 69fc35485e60..35a249727435 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -15,8 +15,7 @@ static int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>  		       u32 opcode);
>  
>  static inline void retry_first_write_send(struct rxe_qp *qp,
> -					  struct rxe_send_wqe *wqe,
> -					  unsigned int mask, int npsn)
> +					  struct rxe_send_wqe *wqe, int npsn)
>  {
>  	int i;
>  
> @@ -83,7 +82,7 @@ static void req_retry(struct rxe_qp *qp)
>  			if (mask & WR_WRITE_OR_SEND_MASK) {
>  				npsn = (qp->comp.psn - wqe->first_psn) &
>  					BTH_PSN_MASK;
> -				retry_first_write_send(qp, wqe, mask, npsn);
> +				retry_first_write_send(qp, wqe, npsn);
>  			}
>  
>  			if (mask & WR_READ_MASK) {

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
