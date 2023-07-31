Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8976A027
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGaSQ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGaSQ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:16:57 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33860198B
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:16:51 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcae8c4072so186901a34.1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690827410; x=1691432210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exyhjbrQ78FvW5MPvWDSM/gDOxeULPUgtOq198TNdDk=;
        b=lTVIYW/43HA+QawQsSH/4sgLUJ8jM7/6DDZTSAlA2pjLAeffRJbDcJ8PdFWtw7tk8t
         enQdnag1u7oRMDxN9hJ23Vxo8/9d0OcMfNxq2zNb7ofO+97OOBAc76nwN1mpCDbAMNFX
         2V7eYGSa+qHAWi8/FqRz+2SnAnlZ6ZA0WrqMbkiQ8k+CWjwPdUt92gcZBajF8JiBcgqT
         oQuViseISRlYm+w3QhCnyiP3ZoQGv515dho0+WzgLCj5TYfKwGWLbjv8R3J9ZTD/ViqN
         BKxK99M/j5bEFMmdL3D9zZIfVK2I/F3A/flDKbsQLxEHRAS6VGaQmOcqMHuI8OROS6wP
         QN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827410; x=1691432210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exyhjbrQ78FvW5MPvWDSM/gDOxeULPUgtOq198TNdDk=;
        b=XyqoUuYmzcJDw4ZmbcW8dQp+HNbf53kKVrZIBNWx2WrAzcyBxuvT58Y3Yfi+8FP5p7
         0B0XiHpiUKdalOYx9nEuwIYeSbv7nEneUJ3ViTZ4hHma5HKJ83Qp77vQEQPeZo4AJlsh
         Gnvx15vUYm4h978F2suCmqG9+xOjfxiZsb2dvEjHzvM1d6uUDbnza0U4DRfNkKhLxQDJ
         6l8haGZUKFm33s5ekZ1QrmuhdckjZhaAIFBbFo85Lpcwg8I75Q9J+7LUUC3RlJ3ad9dJ
         hdZIDXLwXR2lSqzoitjofD4an9m/xNsr+tQpsqcqEqNTbtAQSg2sHRtkVV9fQbPdPbYt
         AsIQ==
X-Gm-Message-State: ABy/qLb6SpyXu9rXiQFeZf9uf18W+gxa8TNOXyf6PcBuid3P5MlRTEQM
        nobeKY4jad01W3a1pkY1zOg=
X-Google-Smtp-Source: APBJJlGVJhEWFYNsn9Z4wykAlsLsYrg8WavneDGhWhwKIAsoDfl1bc6Q75Nuo762QXgZvYYcoFpRvA==
X-Received: by 2002:a05:6830:1d93:b0:6b7:4411:505d with SMTP id y19-20020a0568301d9300b006b74411505dmr9379068oti.4.1690827410090;
        Mon, 31 Jul 2023 11:16:50 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8206:c67a:f41a:8567? (2603-8081-140c-1a00-8206-c67a-f41a-8567.res6.spectrum.com. [2603:8081:140c:1a00:8206:c67a:f41a:8567])
        by smtp.gmail.com with ESMTPSA id e15-20020a9d6e0f000000b006b94904baf5sm4261660otr.74.2023.07.31.11.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:16:49 -0700 (PDT)
Message-ID: <e8b4e355-be62-591f-a034-1888a891c846@gmail.com>
Date:   Mon, 31 Jul 2023 13:16:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 3/9] RDMA/rxe: Fix freeing busy objects
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-4-rpearsonhpe@gmail.com> <ZMf5RRowWoO5MkD5@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMf5RRowWoO5MkD5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/31/23 13:11, Jason Gunthorpe wrote:
> On Fri, Jul 21, 2023 at 03:50:16PM -0500, Bob Pearson wrote:
>> @@ -175,16 +175,17 @@ static void rxe_elem_release(struct kref *kref)
>>  {
>>  	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>>  
>> -	complete(&elem->complete);
>> +	complete_all(&elem->complete);
>>  }
>>  
>> -int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>> +void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>>  {
> 
> You should definately put this one change in its own patch doing just
> that.
> 
> Jason

Please explain a little more. I only found this change because the
change in rxe_complete to repeat the wait_for_completion call didn't work.
This seemed to fix it but the man page and comments didn't explain
complete_all very well.

Bob
