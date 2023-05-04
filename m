Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23BD6F6ABC
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 14:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjEDMCH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 08:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjEDMCC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 08:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737059F1
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683201677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIKjcXbXt4J8uhPw59CYqy1sDmbjD4HLo3LB8qW0Zt4=;
        b=hxqiHOafH2FEKNhgxeynFds2X/eTNvwzouGkTGDop8+9LJf20nBp/K6LcyeYqhFPRSsVhu
        u8Apf8qKVhQeF9iOdz2BQnLNAbr/4CFbz5rHVSvqQVF5YIsWqXK9XBVldQ5VZBKpzgjyLv
        7nmZBFPow5qbgm26XO7vbbvUl3jUV4c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-t2XOFscRPdmte5gTG5pAwA-1; Thu, 04 May 2023 08:01:16 -0400
X-MC-Unique: t2XOFscRPdmte5gTG5pAwA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61b738ecf88so2531916d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 May 2023 05:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201676; x=1685793676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIKjcXbXt4J8uhPw59CYqy1sDmbjD4HLo3LB8qW0Zt4=;
        b=AHdIrgm3DtOZLyMCtTzJi4oBTCZqlJxPFfYdjL/Iv9aYDKxVvMamIimiGh70VmGkTj
         1H6eMMi7KCEBC0zRkGBEqruUot3k9D4FMcWikpvz53K/Df0HF26i2fb4vCTkFNyIw+iB
         ZGAVCpuv3NSajftiGKKQOBlMoAauq7ENaHbeUaRM8FI8vO71p9upPA6tziA6xYvIzc8x
         Qo8VR1S98KYkjIxBqL6fNFsSGoQkqx82Vlrqp2R5wrFqlo4VZiE/onybcgJynXoipe4C
         C+J63j9qjR1eTN5rSNMSGpiLUwfo7woOS05RuM4/W2MnwxW1iHCeSLfB9DxxcL2PAhtB
         GIHQ==
X-Gm-Message-State: AC+VfDzq9fml1YmFYCLJudDBFss93mdkAiNdvHkt7wk9N24iPg2jc/3S
        qWnfxKMyC2cpcO5S41epA9dR2sBymmqEQhfFIBKty0zzjnXTIG5R9Xg229rKQortD759oEukdj+
        AuozPFc5JcvIOl4uNygsw8rl05ufc4Q==
X-Received: by 2002:a05:6214:246a:b0:5e0:ad80:6846 with SMTP id im10-20020a056214246a00b005e0ad806846mr15121480qvb.0.1683201675944;
        Thu, 04 May 2023 05:01:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zCd37cGrYnqLsDvIDNom+W3hrB0fw7HXsoSUmBoJMxEocsUb+eLYvdoPE0p7kosvipZum3Q==
X-Received: by 2002:a05:6214:246a:b0:5e0:ad80:6846 with SMTP id im10-20020a056214246a00b005e0ad806846mr15121443qvb.0.1683201675672;
        Thu, 04 May 2023 05:01:15 -0700 (PDT)
Received: from [192.168.2.12] (bras-base-toroon01zb3-grc-50-142-115-133-205.dsl.bell.ca. [142.115.133.205])
        by smtp.gmail.com with ESMTPSA id w14-20020a0ce10e000000b005e37909a7fcsm11396142qvk.13.2023.05.04.05.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:01:15 -0700 (PDT)
Message-ID: <3486407a-a357-5194-300d-d646c2fc5bf8@redhat.com>
Date:   Thu, 4 May 2023 08:01:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH iproute2-next] rdma: Report device protocol
Content-Language: en-US
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20230503210342.66155-1-kheib@redhat.com>
 <20230504074842.GR525452@unreal>
From:   Kamal Heib <kheib@redhat.com>
In-Reply-To: <20230504074842.GR525452@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023-05-04 03:48, Leon Romanovsky wrote:
> On Wed, May 03, 2023 at 05:03:42PM -0400, Kamal Heib wrote:
>> Add support for reporting the device protocol.
>>
>> $ rdma dev
>> 11: mlx5_0: node_type ca proto roce fw 12.28.2006
>>      node_guid 248a:0703:004b:f094 sys_image_guid 248a:0703:004b:f094
>> 12: mlx5_1: node_type ca proto ib fw 12.28.2006
>>      node_guid 248a:0703:0049:d4f0 sys_image_guid 248a:0703:0049:d4f0
>> 13: mlx5_2: node_type ca proto ib fw 12.28.2006
>>      node_guid 248a:0703:0049:d4f1 sys_image_guid 248a:0703:0049:d4f0
>> 17: siw0: node_type rnic proto iw node_guid
>>      0200:00ff:fe00:0000 sys_image_guid 0200:00ff:fe00:0000
>>
>> Signed-off-by: Kamal Heib <kheib@redhat.com>
>> ---
>>   rdma/dev.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/rdma/dev.c b/rdma/dev.c
>> index c684dde4a56f..04c2a574405c 100644
>> --- a/rdma/dev.c
>> +++ b/rdma/dev.c
>> @@ -189,6 +189,16 @@ static void dev_print_node_type(struct rd *rd, struct nlattr **tb)
>>   			   node_str);
>>   }
>>   
>> +static void dev_print_dev_proto(struct rd *rd, struct nlattr **tb)
>> +{
>> +       const char *str;
>> +       if (!tb[RDMA_NLDEV_ATTR_DEV_PROTOCOL])
>> +               return;
>> +
>> +       str = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_PROTOCOL]);
>> +       print_color_string(PRINT_ANY, COLOR_NONE, "proto", "proto %s ", str);
> 
> Please, let's use full word "protocol" and not "proto".
> 
> Other than that,
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> 

Thank you for reviewing the patch, I'll fix it in v2.

