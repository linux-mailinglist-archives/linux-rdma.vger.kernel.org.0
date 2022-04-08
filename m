Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF804F9C55
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiDHSRn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 14:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiDHSRm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 14:17:42 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF118B21
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 11:15:38 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id e4so9664837oif.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GwKbUIwrzFW/zhpts7GiwJ4tNjikkjYo71Z3H5x+xOQ=;
        b=pTxV1ktEB2NZAr0tH1rWYBNTOzZ3Oj1Ij+2v9vn2zA0zUHAdPaGjyDA0cfaYJ07s92
         dq2K131rhJigqdel2d6FBdQd56TzVWK+pJ18uF1HnMzlTUDSuGnVac+5r1MlI8axX3jF
         YbLd9yINU+Lw/pAAetCQFw9AWAuXEfqrx9pRvVFDYb5Si1jEDFrs+/IjCCbWzyFn9i0J
         IN7pvTM7PjuPYic5Vk36bDisuSihQGD1UUijzvn00CcnMzkHU0Ba/pBBFsX+IlUxtg2d
         rfIT0cRNyLWEcqBRxhqzcEr64xTcwG4sTpktD1HbCfWH49CUbF/IcEr+X8yNdYC4tXCP
         q/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GwKbUIwrzFW/zhpts7GiwJ4tNjikkjYo71Z3H5x+xOQ=;
        b=i1nWVBKa5g+YUq2H9WGcN2G5Ks7cBoqwNNhdX6gKy+pt92b01AwQmPMvGQnKpE5ydm
         7K1IWuYZ8cFqBjjzWEG4hhgtdvcesAsrE15QrLZruFYwU8eFmby0+A+r53LRyIEtiajG
         6jA+/nvK7K7jLCr/zOFpiJAfq6wgauKqR/XJTqVNaAo5A7k38+xNMhBP41E0tW97etWU
         H7VG9QESlU28rHL+ajRh0ZT9h2I+jBuozjJqwOQqTY1bq0yokUk9UeaXO93lgfeRvewo
         KmMKvsdQc2lmWUeKqaNh09GY4APKjs3WDdsW/eaiM5yim3L5kDn4iSla910PuksKRzrK
         OJGA==
X-Gm-Message-State: AOAM531f9Bl8AREHgVyae6kJ8afotFBvO/k1m0iLhOOimBh79M+20kLU
        vqsMhfaTrT1HGn/Qh1xjlArhj+CokyI=
X-Google-Smtp-Source: ABdhPJz7bA0cafZJ2K149v4A7b5AxS9T+LTznd2T/GSqYYqH1uHXd6lPK6x1JwrLabndwBPhmSSlqg==
X-Received: by 2002:a05:6808:1496:b0:2da:8662:4346 with SMTP id e22-20020a056808149600b002da86624346mr505288oiw.9.1649441737855;
        Fri, 08 Apr 2022 11:15:37 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d36a:c09a:7579:af8a? (2603-8081-140c-1a00-d36a-c09a-7579-af8a.res6.spectrum.com. [2603:8081:140c:1a00:d36a:c09a:7579:af8a])
        by smtp.gmail.com with ESMTPSA id m187-20020aca58c4000000b002ef721352easm9026464oib.14.2022.04.08.11.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:15:37 -0700 (PDT)
Message-ID: <c77a90de-5e0f-71cc-a647-d9a62f40abf7@gmail.com>
Date:   Fri, 8 Apr 2022 13:15:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH for-next v13 00/10] Fix race conditions in rxe_pool
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
 <20220408180659.GA3646477@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220408180659.GA3646477@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/22 13:06, Jason Gunthorpe wrote:
> On Mon, Apr 04, 2022 at 04:50:50PM -0500, Bob Pearson wrote:
>> There are several race conditions discovered in the current rdma_rxe
>> driver.  They mostly relate to races between normal operations and
>> destroying objects.  This patch series
>>  - Makes several minor cleanups in rxe_pool.[ch]
>>  - Adds wait for completions to the paths in verbs APIs which destroy
>>    objects.
>>  - Changes read side locking to rcu.
>>  - Moves object cleanup code to after ref count is zero
> 
> This all seems fine to me now, except for the question about the
> tasklets
> 
> Thanks,
> Jason
Thanks. At the moment the first priority is to figure out how
blktest regressed in 5.18-rc1+. Hopefully it will be easy to figure out.

Bob
