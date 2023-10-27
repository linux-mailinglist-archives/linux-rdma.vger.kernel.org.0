Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524BB7DA29B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 23:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjJ0Vrg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 17:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346611AbjJ0Vrd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 17:47:33 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F57D7F;
        Fri, 27 Oct 2023 14:47:30 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c9d407bb15so23198555ad.0;
        Fri, 27 Oct 2023 14:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698443250; x=1699048050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9C2uMQY3gPOITkkV1qWxC4PQ2GSEW3yaZLRSMMWF1E=;
        b=THftEffewox/CkCSvQ/YjCyDh9abAt2IKARS0nU40rBOgf6RlMeQvZASvPuQKZHa8N
         AU7uxG2r6/77z1wQlmvaiVaRZAI7Wd4r0GqUqWO1TH034j8FKtfDBXQk9zJ7Grfv5cAa
         H8tYdkexvWXzsUVJk/hYwJJpfwA9Bu2EXaxYsEyWYS77K5gSVdFK4cEJLxgWDqEShD6n
         uh/oCt9bdRsWpUpQog6vT2QM+FU12Mw2LjrdktGnb0yd1n2us+PbT/a1V7tp5273mKO3
         QnDqwXVA0v6b7/K4QJNNtdp2U2tPxjxO2uTZfByTGrtYxTEqJQW9fCcLRMbEJdLcwBI5
         bFdA==
X-Gm-Message-State: AOJu0YzMf/cinpN+6Y/s98jRKHSSgNLWApmOEFzVOfiW7kI7XhEhoCoF
        Lg/Tzdv6RRNT0x/LbabrxyQ=
X-Google-Smtp-Source: AGHT+IG0JuujmHuhY30rCBEAwB9oCDpz6rvc3u2cXhre2PDbE+vOXqqiFVzKsYTNPxIuBO/udNrTRg==
X-Received: by 2002:a17:902:f54c:b0:1c9:cc88:5029 with SMTP id h12-20020a170902f54c00b001c9cc885029mr4548420plf.32.1698443249670;
        Fri, 27 Oct 2023 14:47:29 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001b9f032bb3dsm2084436pln.3.2023.10.27.14.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 14:47:29 -0700 (PDT)
Message-ID: <7f568746-5de3-4de7-b367-9cc869cab0a2@acm.org>
Date:   Fri, 27 Oct 2023 14:47:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <20231027054154.2935054-2-lizhijian@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231027054154.2935054-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/26/23 22:41, Li Zhijian wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index d2f57ead78ad..b1cf1e1c0ce1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -38,7 +38,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>   /* default/initial rxe device parameter settings */
>   enum rxe_device_param {
>   	RXE_MAX_MR_SIZE			= -1ull,
> -	RXE_PAGE_SIZE_CAP		= 0xfffff000,
> +	RXE_PAGE_SIZE_CAP		= PAGE_SIZE,
>   	RXE_MAX_QP_WR			= DEFAULT_MAX_VALUE,
>   	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>   					| IB_DEVICE_BAD_QKEY_CNTR

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
