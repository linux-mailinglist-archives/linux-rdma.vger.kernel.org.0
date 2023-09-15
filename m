Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268D7A25D2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjIOSc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Sep 2023 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjIOScd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Sep 2023 14:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B0532105
        for <linux-rdma@vger.kernel.org>; Fri, 15 Sep 2023 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694802704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SaSD233V2JprFrxsR+IJQ2YX++yb9Le/vDfJSvpImI=;
        b=cVNbVpYL+YphdTLB1ukxn6CPTlP4gKuVvYSXYBOBNPotURelkLKsx8OUHYouZNV2t754SF
        Qf6r7IyQzlukqaJjXHRTOoDWkgg32pPuuPxWQ0xlSdd3eer4F4pU7/heOV7mmJaq/1orGF
        tN0lMQXeTjdtIeVClnjTh24msnbV1bI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-jc5Ve6zSP6-x_YkxiqGPsA-1; Fri, 15 Sep 2023 14:31:42 -0400
X-MC-Unique: jc5Ve6zSP6-x_YkxiqGPsA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76dcf1d8905so317560485a.1
        for <linux-rdma@vger.kernel.org>; Fri, 15 Sep 2023 11:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802702; x=1695407502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SaSD233V2JprFrxsR+IJQ2YX++yb9Le/vDfJSvpImI=;
        b=MXN7JZyS754gOl2jNtJBEwurbOCJyJEo83ob512pBdd2cM/jYdybhJBOwJPpW00B28
         PGvG9dYkm1Tb8x9eyRDmLzNcb+CN0Gde9NrSnazezMkH4D1lpgmwT21PGIQN34ODxHlW
         GGJvwkxpnRQP3A9AEKIMUCwlUf/EdaK3rYb6/bHEp+eDSxmXp8zzD9n7HyKC+JUT89TW
         OxUnctCtFwidrGVVVL7mXiU9Z24pnPEgnTiArAqgJkDLQjvFFWd98/AB4MGvI5Wp+qux
         DzMucihYdb+ia2bytqKJ9iwti3V4BuknOjIr+YA+byOWSAJ1p0RJHgHtAMPEYrqgM3rZ
         bbaA==
X-Gm-Message-State: AOJu0YwUC/0+0LQyGeb1GTNyg2Eh5IjqG3nEybCdAG4xGMZ0DSFtKB96
        jFvvlNJHyIk91njx1sUkdPcCxZbabXSq0YKa+UGGd5f8PiAbLcDt9eo3kpYAVhO46YjjNTvo5Ca
        ijNIiCdgiO1V9Z7TgiCZ98utBczResA==
X-Received: by 2002:a05:620a:2906:b0:768:3975:6b5b with SMTP id m6-20020a05620a290600b0076839756b5bmr3259920qkp.34.1694802702094;
        Fri, 15 Sep 2023 11:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3zjsDxXeWulWP6v5U5tHQl9aiWNFTD7UqHVBA6BlKw3h1x3FGomXkeXC0m8Wwoj5z9MVOJw==
X-Received: by 2002:a05:620a:2906:b0:768:3975:6b5b with SMTP id m6-20020a05620a290600b0076839756b5bmr3259905qkp.34.1694802701827;
        Fri, 15 Sep 2023 11:31:41 -0700 (PDT)
Received: from ?IPV6:2605:b100:310:ba94:443c:cb99:91b:4389? ([2605:b100:310:ba94:443c:cb99:91b:4389])
        by smtp.gmail.com with ESMTPSA id a8-20020a05620a102800b00772662b77fesm1392680qkk.99.2023.09.15.11.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 11:31:41 -0700 (PDT)
Message-ID: <7cd9ba68-988c-07c1-22c3-f3e9876d7dbc@redhat.com>
Date:   Fri, 15 Sep 2023 14:31:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next] RDMA/nldev: Add support for reporting ipoib
 netdev
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
References: <20230831142225.588762-1-kheib@redhat.com>
 <ZPEqK2tbPPKmtktF@ziepe.ca>
From:   Kamal Heib <kheib@redhat.com>
In-Reply-To: <ZPEqK2tbPPKmtktF@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023-08-31 20:02, Jason Gunthorpe wrote:
> On Thu, Aug 31, 2023 at 10:22:25AM -0400, Kamal Heib wrote:
>> This patch adds support for reporting the ipoib net device for a given
>> RDMA device by calling ib_get_net_dev_by_params() when filling the
>> port's info.
>>
>> $ rdma link show mlx5_0/1
>> link mlx5_0/1 subnet_prefix fe80:0000:0000:0000 lid 66 sm_lid 3 lmc 0
>> 	state ACTIVE physical_state LINK_UP netdev ibp196s0f0
>>
>> Signed-off-by: Kamal Heib <kheib@redhat.com>
>> ---
>>   drivers/infiniband/core/nldev.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
> 
> Are we sure we want to do this? How does it work with namespaces?

You are right, I'll fix it.
> 
>> @@ -340,6 +341,21 @@ static int fill_port_info(struct sk_buff *msg,
>>   			return -EMSGSIZE;
>>   		if (nla_put_u8(msg, RDMA_NLDEV_ATTR_LMC, attr.lmc))
>>   			return -EMSGSIZE;
>> +		ipoib_netdev = ib_get_net_dev_by_params(device, port,
>> +							IB_DEFAULT_PKEY_FULL,
>> +							NULL, NULL);
> 
> And it doesn't work at all for non-default ipoib interfaces?
> 
I'll fix it.

Thanks,
Kamal

> Jason
> 

