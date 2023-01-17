Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D591F66E419
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAQQwe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 11:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjAQQw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 11:52:28 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B10376AF
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 08:52:27 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-142b72a728fso32556428fac.9
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/XdMSOae0BD+0wnQ05CZo9f7E7WI/zTXug4pZekq3g=;
        b=LQ6DN0kuhmSnn01DBu8324wMM8UF7zMvOsOu+P323fB20dXqoiAKw/h4wEDi8aqazr
         Uj0C/kY8nWZLQY0Nl/RdUi7kutjUQzpZZVqkD5WBZnCfHrOCQmxnyGB8qCnb5lAeZQSd
         SKvub8h12nT61Tyt3NHVULBcPJvA2+dN50O9TiDgKm7u3S1nUzkBqcSKRo2o8eQmz6Tk
         agUhoi+HMyuRTxYw0ra7159bvtGzx87yopB7gMcbzFTP6Q9EyxottX+zrlMyGhpltZyh
         yIod9/yMzKqOYVcm2kUoOZfs2IvfNmVVH8qo7CBGxbj64SqCba9+IegFfRbNhb7WiDj1
         P3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/XdMSOae0BD+0wnQ05CZo9f7E7WI/zTXug4pZekq3g=;
        b=MZvUg+vTwu7ZACo2pMQUh9pXI4/cMzxljMY3A5TZdf46Yml72giIVI/2VbyY99Qg2k
         TB6qQoikz/40eG+cicZv9AN2hVnebokA0dUbVrNmSgYVQ/BoiucUWTWzDvaoKO+eRc4R
         ZxOB+FeNKKMyz3+ifQErDeo4Rq+QEtvhCvAA+ZR9f+apfmRTj2xHt9u4zF063ypgweaG
         Ga7+tKR3bn4GBq3BhVAtU6DNgo0aj0H3lVo7JaUUFJgtoprPbyDxdXP7byoCci+AL9Zk
         b5noE8dJ0XVK51FAmVQ97DDbfuP0ht93OWqa2uOatuRt1uz/wizONC3jlvQtCwcRYEsG
         928A==
X-Gm-Message-State: AFqh2koJ4lC1X9iX7d6n5EqjFd7Il9V8naMvz2gufs+shMzpqXNPOhbx
        f8i4b4GcZcQL4SrsAmzkB2s=
X-Google-Smtp-Source: AMrXdXvWyux5jK2vgEQFpiJGT7/EtR+RjJnAJiRFZihVvONExbNxExZUdapUoIUupe37a4iUT+LKhg==
X-Received: by 2002:a05:6870:610d:b0:15f:fcb:6da0 with SMTP id s13-20020a056870610d00b0015f0fcb6da0mr2532978oae.39.1673974346472;
        Tue, 17 Jan 2023 08:52:26 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:ea18:3ee9:26d1:7526? (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id b10-20020a056870390a00b001435fe636f2sm16573784oap.53.2023.01.17.08.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 08:52:26 -0800 (PST)
Message-ID: <2e0aba02-464f-f988-c013-8944acbd6ae9@gmail.com>
Date:   Tue, 17 Jan 2023 10:52:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v5 3/6] RDMA-rxe: Isolate mr code from
 atomic_reply()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-4-rpearsonhpe@gmail.com> <Y8a6MQmBqiuhfwKy@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y8a6MQmBqiuhfwKy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/17/23 09:09, Jason Gunthorpe wrote:
> On Mon, Jan 16, 2023 at 05:56:00PM -0600, Bob Pearson wrote:
> 
>> +		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
>> +					  atmeth_comp(pkt),
>> +					  atmeth_swap_add(pkt),
>> +					  &res->atomic.orig_val);
>> +		if (unlikely(err)) {
>> +			if (err == -RXE_ERR_NOT_ALIGNED)
>> +				return RESPST_ERR_MISALIGNED_ATOMIC;
>> +			else
>> +				return RESPST_ERR_RKEY_VIOLATION;
> 
> Why not just return these RESPST_ constants directly from
> rxe_mr_do_atomic_op ?
> 
> Jason

The main reason is that the responder state machine is fairly complicated and hiding bits of
it in other files just makes it more difficult to follow. Originally all the code was inline here
but I felt it would be better to keep all the mr specific detail in one file.

Bob
