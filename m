Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD7E4C0B58
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 06:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiBWFBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 00:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiBWFBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 00:01:32 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1260CD8
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 21:01:05 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so20771977ooi.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 21:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=joZixsFToec05mNpuz6Kfiel4syoCGXqE9sxKdGuzy0=;
        b=TpAaZPZbb7v25CzBlzDs2hgJF1yoSSSmkvptNcA8g7hEQ6VFyKZ+enzg0lpSpiJYqr
         TPxdHNXzRUjBdVSfX745N1gisWsVwWGp1BsNf84twC05PTYHDDULMoMJs6bJHT09d5Fk
         inu8U1UTuh+twI7KS4uiC6XaiyqKf1MhtJUZ9lx93/FRi9X6b4yIIjY3Xook9DfT+LrS
         16uYnHbVpmgNo3QSl8NIO9ZC+J55e4rP9d/O1Ru4VSgIoriPT4cnnw7y+fQHd6uV3iHU
         eGVXgF+YHpXlGKmvvg2q73an0nh+ZL09Pf6TsqlXYLxlOyW7iHbmAEvl90VXV4TwHG5A
         dw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=joZixsFToec05mNpuz6Kfiel4syoCGXqE9sxKdGuzy0=;
        b=t7WQ3dSTxoOPwBKf4ENCMzJ+s8yiIfSQVMHt0uPMKuFHLNbKB4CpVrcXyNqx0xCSqn
         xTdjdjWoazBvVv18VxPrBMYZq5owGsyP2maHtFXYvcntZ4NeMsTck6/jan51hL/HkBEA
         RiDcdZ1DWJkOyDk88zvQtkByQOMJTtLPdlq/p6Q2XxRjZ1FuThv10J9Saryyypg569Ec
         TOMGYEKzgP2edPt8wdkajjKDmV3vxG+YB1EWGXgkOi7IVOMZNcnSKl0u+kSgEHibOom8
         AMO4SYYTqlRMgD6EmMiqSVbZzy9kC4QSrfa/iqBvkHhEqY7OzU6ZRpzL8uMCsQbNVTze
         xWDQ==
X-Gm-Message-State: AOAM533mk42NJjEyIJCojo5REs0gyWtg6utgchrWF9RD6912cuBI1CN/
        XGAkL78hAgKttiAA88LP6HM=
X-Google-Smtp-Source: ABdhPJxYbYXx+cAM0O71mfkkL9nU0k54BHE3Y6V+RktIlqWq54v3HcFG24AbXkRA6/8WsbajxHnpsw==
X-Received: by 2002:a4a:decd:0:b0:31c:a9fe:f78e with SMTP id w13-20020a4adecd000000b0031ca9fef78emr2030125oou.55.1645592464608;
        Tue, 22 Feb 2022 21:01:04 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:3cc9:79df:2807:e0a7? (2603-8081-140c-1a00-3cc9-79df-2807-e0a7.res6.spectrum.com. [2603:8081:140c:1a00:3cc9:79df:2807:e0a7])
        by smtp.gmail.com with ESMTPSA id k12sm9633438oil.35.2022.02.22.21.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 21:01:04 -0800 (PST)
Message-ID: <3ecd3493-662c-7c08-f2f2-59c1c97f8d59@gmail.com>
Date:   Tue, 22 Feb 2022 23:01:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: bug report for rxe
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
 <473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev>
 <CAD=hENeU=cf4_AZPYBDke-kv3Lv3+AUkkEjZm4Drkc6YLJOeLQ@mail.gmail.com>
 <PH7PR84MB1488DB95EFB4F86FCDC7B8E6BC3B9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <3b6ddb23-6dfa-29e2-27fd-741c1e3e576d@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <3b6ddb23-6dfa-29e2-27fd-741c1e3e576d@linux.dev>
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

On 2/22/22 22:43, Guoqing Jiang wrote:
> 
> 
> On 2/23/22 12:58 AM, Pearson, Robert B wrote:
>>> After investigation, seems the culprit is commit 647bf13ce944 ("RDMA/rxe:
>>> Create duplicate mapping tables for FMRs"). The problem is
>>> mr_check_range returns -EFAULT after find iova and length are not
>>> valid, so connection between two VMs can't be established.
>>>
>>> Revert the commit manually or apply below temporary change,  rxe works
>>> again with rnbd/rtrs though I don't think it is the right thing to do.
>>> Could experts provide a proper solution? Thanks.
>>>
>> This patch fixed failures in blktests and srp which were discussed at length. See e.g.
>>
>> https://lore.kernel.org/linux-rdma/20210907163939.GW1200268@ziepe.ca/
> 
> Thanks for the link, which reminds me the always_invalidate parameter in rtrs_server.
> 
>> and related messages. The conclusion was that two mappings were required. One owned by the
>> driver and one by the 'hardware', i.e. bottom half in the rxe case, allowing updating a new mapping
>> while the old one is still active and then switching them.
>>
>> If this case has iova and length not valid as indicated is there a problem with the test case?
> 
> And after disable always_invalidate (which is enabled by default), rnbd/rtrs over roce
> works either. So I suppose there might be potential issue for always_invalidate=Y in
> rtrs server side since invalidate works for srp IIUC, @Jinpu.
> 
> Thanks,
> Guoqing

It would help to understand what you are running. My main concern is that mr_check_range
shouldn't fail unless there is something very wrong.
