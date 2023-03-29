Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF06CF33D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjC2Tiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Tix (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:38:53 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F14223
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:38:52 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r84so11187800oih.11
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680118732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAyMyG3AYVqdZuZZaSGsVkjBloYVJvjyf4VIidh09Qk=;
        b=YNWgsTqu18BdH4AfYWp0kIy4ZLEs5YaddAUgrQcx3TdQnrLhCPtLTKJspVN/2b866i
         4FCUk4QdfekPDgjJgOa4Te8Zv90NcdPkKVLJnOSneXrCGa7da/2O+XWSFU5DL4Q/8nHl
         oQcq6nI0ShsIdZQDBJ6XXptS66mwwuK+thhsabRuPr3xEipx6htN3JJLay6j0iVI6XQ9
         Tx7lGnxHBgDn9O4yVPSHm5MKZt5XOdCWreak2rSAP+Lm5wI9kv0kUr8aO280L9fkCQCc
         g22Suz/XLC0ISphPXtAwpxksesxpQ68owIGWpEsL85pBHiJQRuGtnJTrY82bA6QFkB3G
         klfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAyMyG3AYVqdZuZZaSGsVkjBloYVJvjyf4VIidh09Qk=;
        b=P266EX2eivF9PYuxzZWk7v05X80o35Pi8+flGBpnnrCLVTWtTGUwDfEQlHlhNUqppp
         mwEYg6Em6QnxPxMyGzKjOmRxJdy0SyonbCba08kb/Z9qE5fzpKejFXXJ2STg4J6HeaM/
         UPoi9TdEJLfGnPWJ67nVOsq7s7OQIypbrM2iwC+H/Eac5j6KlbZSjjGJNBNj8xQGu7L6
         vARZ0rVy2aiU3/jcOC0HnbtsNL7HZHQV+IBz6G5mTba5pxPQp70XyZ7o9rWVAGB5FYa5
         eh3mSyuMkEZuniWhVhSP4RFDVprsMgGnAoqJdYYcRlGXEUB0peWTpyuuF5WZHXXPm2La
         sI3g==
X-Gm-Message-State: AO0yUKXv1LNnPqwlmK+eRjXWRdOYgXMuFOthpBdnU/6tVovdxCzFlC7P
        P42al0bqVSryCCTTci2DwJgaroi2N5M=
X-Google-Smtp-Source: AK7set8z719RVkeVNk+vyidfEnu4xhwNnQkGKGR6clDY9IsbrarlfOfxTcw3X8IV17ceP3VUksNpVw==
X-Received: by 2002:a05:6808:150b:b0:387:1ac9:182 with SMTP id u11-20020a056808150b00b003871ac90182mr10068734oiw.40.1680118732303;
        Wed, 29 Mar 2023 12:38:52 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c? (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id s129-20020acadb87000000b0038756901d1esm7835682oig.35.2023.03.29.12.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:38:51 -0700 (PDT)
Message-ID: <ca8803af-da19-9a77-188a-bef19498d8eb@gmail.com>
Date:   Wed, 29 Mar 2023 14:38:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bug report] RDMA/rxe: Add error messages
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-rdma@vger.kernel.org
References: <ea43486f-43dd-4054-b1d5-3a0d202be621@kili.mountain>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ea43486f-43dd-4054-b1d5-3a0d202be621@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/29/23 01:30, Dan Carpenter wrote:
> Hello Bob Pearson,
> 
> The patch 5bf944f24129: "RDMA/rxe: Add error messages" from Mar 3,
> 2023, leads to the following Smatch static checker warning:
> 
> 	drivers/infiniband/sw/rxe/rxe_verbs.c:1294 rxe_alloc_mr()
> 	error: potential null dereference 'mr'.  (kzalloc returns null)
> 
> drivers/infiniband/sw/rxe/rxe_verbs.c
>     1276 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>     1277                                   u32 max_num_sg)
>     1278 {
>     1279         struct rxe_dev *rxe = to_rdev(ibpd->device);
>     1280         struct rxe_pd *pd = to_rpd(ibpd);
>     1281         struct rxe_mr *mr;
>     1282         int err, cleanup_err;
>     1283 
>     1284         if (mr_type != IB_MR_TYPE_MEM_REG) {
>     1285                 err = -EINVAL;
>     1286                 rxe_dbg_pd(pd, "mr type %d not supported, err = %d",
>     1287                            mr_type, err);
>     1288                 goto err_out;
>     1289         }
>     1290 
>     1291         mr = kzalloc(sizeof(*mr), GFP_KERNEL);
>     1292         if (!mr) {
>     1293                 err = -ENOMEM;
> --> 1294                 rxe_dbg_mr(mr, "no memory for mr");
>                                     ^^
> NULL dereference.
> 
>     1295                 goto err_out;
>     1296         }
>     1297 
>     1298         err = rxe_add_to_pool(&rxe->mr_pool, mr);
>     1299         if (err) {
>     1300                 rxe_dbg_mr(mr, "unable to create mr, err = %d", err);
>                                     ^^
> mr->ibmr.device is not set yet so this doesn't work.
> 
>     1301                 goto err_free;
>     1302         }
>     1303 
>     1304         rxe_get(pd);
>     1305         mr->ibmr.pd = ibpd;
>     1306         mr->ibmr.device = ibpd->device;
>                  ^^^^^^^^^^^^^^^
> 
>     1307 
>     1308         err = rxe_mr_init_fast(max_num_sg, mr);
>     1309         if (err) {
>     1310                 rxe_dbg_mr(mr, "alloc_mr failed, err = %d", err);
>     1311                 goto err_cleanup;
>     1312         }
>     1313 
>     1314         rxe_finalize(mr);
>     1315         return &mr->ibmr;
>     1316 
>     1317 err_cleanup:
>     1318         cleanup_err = rxe_cleanup(mr);
>     1319         if (cleanup_err)
>     1320                 rxe_err_mr(mr, "cleanup failed, err = %d", err);
>     1321 err_free:
>     1322         kfree(mr);
>     1323 err_out:
>     1324         rxe_err_pd(pd, "returned err = %d", err);
>     1325         return ERR_PTR(err);
>     1326 }
> 
> regards,
> dan carpenter

Thanks Dan, good call. -- Bob
