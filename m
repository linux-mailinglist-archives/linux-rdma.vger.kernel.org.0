Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB93959C831
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiHVTLW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 15:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiHVTJh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 15:09:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DA5116B
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:08:39 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r10so7541827oie.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BkUPsnIh4YU1I+UO1XiITp28gCPTikiHRfnJ1CCGhWI=;
        b=OEDnhAOX8101byzoFst5XFQM/qfN/kU1dZdumAEGRFxsAB53Akh36mf9onHKl/a6gv
         hoXevsaMqRtTWV+PcE5NSO8nWrYAUnBXD3KnNGtyOsdjHdPe+5jzCgyjNtfRWe0ep8I9
         MltwaXjoBAePc4/G0sS/xcgRB19b0gxgjVmdAq375IAXosA8xWHD3zcRqZ53/MnDEY0W
         uWVdIBWLybu8QcpQJO9pgAxPtX4vUQBj6T6w8YwfgF634xCsAmnQv7kVDU1jaK72N2co
         I1n059dKncFRG939SC0IvJPiD3ADwo17k7cW5AXZZ9VtoxDOlDYPVwUwUJ/m7+JXecbd
         /tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BkUPsnIh4YU1I+UO1XiITp28gCPTikiHRfnJ1CCGhWI=;
        b=pPrkZAgGLOI4tL1Dww56GoaXXflSJcUkT7/gXCmTx+1G3/B7p/8Tm5iNzpH65YazkL
         Y3+cL0RLi02slzskGGnjh3Syn3COp3LFVKbkF2/2kPbJ/p4TktkrS7uKHi5j5SZqr/kY
         jwqJtxlJHxFSNEMLbHxmgMHq2NpP8suADGIvL0kDVS/PTkFw6LBT/v9voVt2tRloxkNL
         aF1TVIU7LXv8RFrEWeMX1A+08eYh9O63ggQNY4+VPqFJT25UkecRHK4EcK1XRJZVKZYr
         yPDeHJvAPkk65D3hyfDx+i+KBzui0Pp8+OKLXoTYT9/YepdYBom7XpKqI4DU6Zvq/LGY
         HDIA==
X-Gm-Message-State: ACgBeo12zxaU0id5gwaXZ5y5FkdWzyvUmDCQ06//XTri6GiemBoMv2CW
        B9nrKcoPKUc6uOyMzm1tAfs=
X-Google-Smtp-Source: AA6agR7BzVspwHhNm9q8QP8Lun6opXxTXYrb5JIXfvjpqly9tUeInNAHIr4nmZG53hiVWHbcKLxy1Q==
X-Received: by 2002:a05:6808:a04:b0:344:bb33:95b9 with SMTP id n4-20020a0568080a0400b00344bb3395b9mr9482036oij.271.1661195318522;
        Mon, 22 Aug 2022 12:08:38 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fd1d:d13f:3b8b:5104? (2603-8081-140c-1a00-fd1d-d13f-3b8b-5104.res6.spectrum.com. [2603:8081:140c:1a00:fd1d:d13f:3b8b:5104])
        by smtp.gmail.com with ESMTPSA id g61-20020a9d12c3000000b006392c93c5aasm768193otg.42.2022.08.22.12.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 12:08:38 -0700 (PDT)
Message-ID: <8cf06c36-b42b-e274-0b88-0452d28fb0c7@gmail.com>
Date:   Mon, 22 Aug 2022 14:08:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 for-next 2/2] RDMA/rxe: Test mr->umem before releasing
 umem
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220805183153.32007-1-rpearsonhpe@gmail.com>
 <20220805183153.32007-3-rpearsonhpe@gmail.com>
 <TYCPR01MB93052D25FB7FDB83DCF7AD90A5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB93052D25FB7FDB83DCF7AD90A5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/22/22 00:50, lizhijian@fujitsu.com wrote:
> 
> 
>> -----Original Message-----
>> From: Bob Pearson <rpearsonhpe@gmail.com>
>> Sent: Saturday, August 6, 2022 2:32 AM
>> To: jgg@nvidia.com; zyjzyj2000@gmail.com; Li, Zhijian/李 智坚
>> <lizhijian@fujitsu.com>; jhack@hpe.com; linux-rdma@vger.kernel.org
>> Cc: Bob Pearson <rpearsonhpe@gmail.com>
>> Subject: [PATCH v5 for-next 2/2] RDMA/rxe: Test mr->umem before releasing
>> umem
>>
>> In rxe_mr_cleanup() test mr->umem before calling ib_umem_release() since in
>> some error paths it may not be set.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_mr.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
>> b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index af34f198e645..f0726e8ee855 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -627,7 +627,9 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
>>  	int i;
>>
>>  	rxe_put(mr_pd(mr));
>> -	ib_umem_release(mr->umem);
>> +
>> +	if (mr->umem)
>> +		ib_umem_release(mr->umem);
> 
> It's safe to pass a NULL to ib_umem_release() where it has a such check.
> 
> 
> Thanks
> Zhijian
> 
>>
>>  	if (mr->map) {
>>  		for (i = 0; i < mr->num_map; i++)
>> --
>> 2.34.1
> 
OK we can just drop this patch.

Bob
