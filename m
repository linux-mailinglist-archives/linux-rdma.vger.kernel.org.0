Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375305752D8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiGNQci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiGNQch (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 12:32:37 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C271D65D5B
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:32:36 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s204so2999757oif.5
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6zvKYrJYB/yHUL9TcnqzJDCE7lPdcIm+/vMeXUhABbw=;
        b=n10qXM5mVtbOt2QKVIWPOQHSqoh3N1TEUtMhYPGvW/9Wr194topETjV1w8c3uWZz8g
         /CjC9sOecS66KiQCwrbfPE50sKIuvK0XQejeqEng8mAsEpSNtuzkqFVbcqJyX9S25vSI
         zUEbHHCIcC0WKX0tLCf3QqTmJvMc/DQ1C43iJuKXrSkg/65FKSLE3xAXLGyYQ73Rtrfx
         kCYvQ2HvmDsezHWiYEBE4XpWOR5Kg/ImMan/xElz8GP/Oh5PdTaFtLNrs69pkT2a4tSe
         iLFMtxN0dfHJInb9WDVS0FvT5+dE2EsmqV7otBL84Er6NwEEGurxyg1/pHYWQhvcV9pV
         145g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6zvKYrJYB/yHUL9TcnqzJDCE7lPdcIm+/vMeXUhABbw=;
        b=hH/1BV7QDbx37S0cYje+0nHELidDNMber7kxUjyMxb1NUHKXtC3/h1sa6otscmMbJb
         gqxjeVsQ3Op813oVrxKsRobz3hHI472kTTaczfMz5MaV+c0EHva5+v2H+QfWBw/5YamS
         mavQ9OV5REH/czroeR/jwc9QpIhQQ4ddhKuooFEjlhVnh6ppx9tFdlC9BbzZ1sWclsMU
         jZmRJl5NTjOCUWyLBOWg2dKmJ9hYJbAh7Iq2U0aXUESVqjti/vmDnq8igAaYNjlqSu81
         qoT5JW1TSI1/IUKUD/bsUPvJy7sv3JB4fOZ1WIB2if9f2mtca3rlLwCgW0lOtKPUuxcO
         RyrA==
X-Gm-Message-State: AJIora9CR0nJ138Q7oOpQ+6ANYTZDgp6sGKcB+Au3MUYo3fnaBZAgytR
        rwplKC7/8LU1VARkYhL9ecW/FIT9miw=
X-Google-Smtp-Source: AGRyM1vlasiUbprGgXL0Qw+EBjfGMx0AXVvw/lZz8ywbRKuuM1NJG3nSI3tq2seHc/xoqJDK5/FCEg==
X-Received: by 2002:a05:6808:1b12:b0:33a:2570:ab16 with SMTP id bx18-20020a0568081b1200b0033a2570ab16mr5797353oib.57.1657816356165;
        Thu, 14 Jul 2022 09:32:36 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id bu27-20020a0568300d1b00b0061b8653b0c9sm856140otb.22.2022.07.14.09.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:32:35 -0700 (PDT)
Message-ID: <7a7b35e6-f798-a694-9efa-fcbcfdefa8fd@gmail.com>
Date:   Thu, 14 Jul 2022 11:32:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Remove unused mask parameter
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220708053014.1823332-1-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220708053014.1823332-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/8/22 00:23, lizhijian@fujitsu.com wrote:
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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

This is correct but should have a body describing what you are doing and why.
A target branch would also help. E.g. [PATCH for-next].

Bob
