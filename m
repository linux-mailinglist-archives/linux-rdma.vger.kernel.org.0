Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5899B703DA0
	for <lists+linux-rdma@lfdr.de>; Mon, 15 May 2023 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbjEOTWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbjEOTWL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 15:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9E16086
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684178472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pp4APFxz02YSu43CYNg2AWZ1c0V3qTcpu+euh+YvtgE=;
        b=OekXvFI6pKpH6KV2joOZTcevio9ppD2sKG9AmdjNG9i5YI8y5pq5JHUcs0PX/AkWFf4bUy
        qsAgXoasHaNGLLQ363tv+sTojdg0U3JffrF5kjuI4xrL6z8bRKB9FZQVirJItJmEgeNQto
        e9MMACpdM8sEzZqvfpupRK7N+qkj9TU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ygCxSA7DOrKtagB4q7jjgw-1; Mon, 15 May 2023 15:15:10 -0400
X-MC-Unique: ygCxSA7DOrKtagB4q7jjgw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f515907398so12662131cf.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 12:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178109; x=1686770109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp4APFxz02YSu43CYNg2AWZ1c0V3qTcpu+euh+YvtgE=;
        b=CkjweUGO3/Vaa9bW63Ce+EUnJ1WWPO4clkuZaN3LwxlvuxrxY0O5SIUEgc+da+27eR
         IwN257OTpifJWlrQlFiSgl5H8UcM8LSxztw8347/LQb1aXJShph2NLFe/LYQU4KIX5kW
         EFBqnWhhFt9iHD8N665octGbybZB9ZNy4/Xb1PcWVp6Ij/5NEFFTwCvZvD8lVEIdkE5B
         2X/YD7r5Y9Czo/2/EzyxqjEr9cWwRusxsafp6/o0qJk/xMYC3FB2AzTj/33D7SEg8NeZ
         98Qc2zKn2pub3bsx2JnMSRlH3SocR2UHsbHaM/6SHqBqR6dzxcVL7zMUMcm5nh9hBDbS
         nkqA==
X-Gm-Message-State: AC+VfDz7YzXYqa/A6oYvcv384uODnKUJ6FR4xmYsuOewRh5sg/1+IIaT
        jTDiUrGlPg+NSAFdyJ7hbDatGqxm6Qagf369wLA6fY3EHcheG/VWYlwcAMJR9cyP5MqKZqHbJ9D
        fTEK2Ro+HfcJaz7th2Xs1vR5zld1MVA==
X-Received: by 2002:a05:622a:14d4:b0:3ef:5bfc:de92 with SMTP id u20-20020a05622a14d400b003ef5bfcde92mr58834003qtx.55.1684178108974;
        Mon, 15 May 2023 12:15:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Io6d5wTCIV8/KFN4XRyAQMbtqxT/deVcfGRIz+ajvPlJBMEJng86QOvK6WmVJmTsJduy/PQ==
X-Received: by 2002:a05:622a:14d4:b0:3ef:5bfc:de92 with SMTP id u20-20020a05622a14d400b003ef5bfcde92mr58833973qtx.55.1684178108728;
        Mon, 15 May 2023 12:15:08 -0700 (PDT)
Received: from [192.168.2.101] (bras-base-toroon01zb3-grc-50-142-115-133-205.dsl.bell.ca. [142.115.133.205])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a018d00b003f018e18c35sm5562849qtw.27.2023.05.15.12.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 12:15:08 -0700 (PDT)
Message-ID: <1a3737cb-9f5c-89c4-4f21-97bdfa19ef4b@redhat.com>
Date:   Mon, 15 May 2023 15:15:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] RDMA/iRDMA: Cleanups and improvements
Content-Language: en-US
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230509145127.33734-1-kheib@redhat.com>
 <MWHPR11MB0029A7D0C0B0063D2F070586E9779@MWHPR11MB0029.namprd11.prod.outlook.com>
From:   Kamal Heib <kheib@redhat.com>
In-Reply-To: <MWHPR11MB0029A7D0C0B0063D2F070586E9779@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023-05-10 10:52, Saleem, Shiraz wrote:
>> Subject: [PATCH 0/3] RDMA/iRDMA: Cleanups and improvements
>>
>> This series includes a few cleanup patches for the iRDMA driver.
>>
>> Kamal Heib (3):
>>    RDMA/iRDMA: Return void from irdma_init_iw_device()
>>    RDMA/iRDMA: Return void from irdma_init_rdma_device()
>>    RDMA/iRDMA: Move iw device ops initialization
>>
>>   drivers/infiniband/hw/irdma/verbs.c | 35 +++++++++++------------------
>>   1 file changed, 13 insertions(+), 22 deletions(-)
>>
> 
> Thanks! some minor nits.
> 
> RDMA/iRDMA --> RDMA/irdma in subject line for the patches.
>
Thank you, The subject is fixed in v2.


> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> 


