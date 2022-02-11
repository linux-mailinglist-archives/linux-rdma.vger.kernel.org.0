Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53894B2D81
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 20:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbiBKT1o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 14:27:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiBKT1o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 14:27:44 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD99CF2
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 11:27:39 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so11481438oos.6
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rXEIK+rlpkg5UMoxo8PrvtjyPowU4u/Y56LUCll5/aE=;
        b=Hfd69IrTdPg1eH50Gy3L1yLxOJK6kNb16W0KI9Wkv8fDGWNzA3Wx7yCBPPa+jyTE/p
         AvA2eOfqf//TXYBogyi8g/5TPyV3x/YGkOtfampLK/SGMcu3geS8z5VtyfKmfTmGAzVm
         /oFQN0GI8UVc2NuB+qfxuz/lve/FfPjlOtL+RnpPQL2E2h1LZ7+3asxCtevcmDbMz9aI
         EFJ8DRYH0GDWjQcnQRIb688YWoVT1oa7mUmmB59pRLI7EdaPvClb+AeTl3dg5aNE0YiA
         tOXT0y1RMM1iXXJil1EmOkJqfPtW648YzCe61QXpzM5YHfDTovk242bmRVDM7ySODQVc
         1blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rXEIK+rlpkg5UMoxo8PrvtjyPowU4u/Y56LUCll5/aE=;
        b=btTOvJh6KgxoqQqR11P4E8jSZSCDdpEK4idXlgtDRReAADUVyu6QQcq0tEcfNcQ52f
         oytgXYkibHON2beSOZn4TzyzkOMVjJ01mJyKuZ4n1+4ib5rceYQ1AIz+Z7QLF9m2b1k1
         5r3bwkrY9aLaQBjhaj/X8BRqEZ6tGuzKzu7hVk5f0JHp9zj7yNmaUDaczN0zBNjWRveR
         jfXAIAtjzJ+Je1zjfLphYgLIrZO0poFPYcVhx8GV1Ufr719Nlm9IJ8EOMp1F9+C8XYla
         g61M9YbrawDlEuzUo1o2Vpspw4C9L3EDM9uNutNmDKdcUaISfHXKoUeS503UZw/B9DZY
         Qjkg==
X-Gm-Message-State: AOAM533pr1jpD8Wv+PlF6+jhh00/9EDEKLeB6NVJiABa6sNKq7MD+i9W
        q0+we6+9lK/nmhIHhGR7Vk4jaaAmTsI=
X-Google-Smtp-Source: ABdhPJz/l4uqO8lvDp/atlKnxpv1Q3j5+G5tmsxDdM9D4SCnfrqxVEgSkHtMcolvos5IKnRfSqs0jA==
X-Received: by 2002:a05:6870:85c2:: with SMTP id g2mr646670oal.151.1644607658875;
        Fri, 11 Feb 2022 11:27:38 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:4354:ebed:9b2:4ca2? (2603-8081-140c-1a00-4354-ebed-09b2-4ca2.res6.spectrum.com. [2603:8081:140c:1a00:4354:ebed:9b2:4ca2])
        by smtp.gmail.com with ESMTPSA id v31sm9702967ott.25.2022.02.11.11.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 11:27:38 -0800 (PST)
Message-ID: <1d4fc859-2f6b-eba9-01a0-a0246f0cdfc7@gmail.com>
Date:   Fri, 11 Feb 2022 13:27:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 01/11] RDMA/rxe: Move mcg_lock to rxe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-2-rpearsonhpe@gmail.com>
 <20220211190035.GA612278@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220211190035.GA612278@nvidia.com>
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

On 2/11/22 13:00, Jason Gunthorpe wrote:
> On Tue, Feb 08, 2022 at 03:16:35PM -0600, Bob Pearson wrote:
> 
>> @@ -62,7 +61,7 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
>>  	if (rxe->attr.max_mcast_qp_attach == 0)
>>  		return -EINVAL;
>>  
>> -	write_lock_bh(&pool->pool_lock);
>> +	spin_lock_bh(&rxe->mcg_lock);
> 
>>  	grp = rxe_pool_get_key_locked(pool, mgid);
> 
> Now this calls rxe_pool_get_key_locked() without the lock :\
> 
> This is all fixed up a few patches later, so it only hurts
> bisect-ability, do you want to fix it?
> 
> I looked up to 'Remove mcg from rxe pools' and it seems fine to me
> otherwise
> 
> Thanks,
> Jason
It is locked. Just a different lock. All uses of the red-black tree in rxe_pool for this object pool will be using the same lock. And as you say we are heading towards replacing it all. Just leave it.

Bob
