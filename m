Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8254E61248A
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ2RCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2RCS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 13:02:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94C2793D
        for <linux-rdma@vger.kernel.org>; Sat, 29 Oct 2022 10:02:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y67so9206835oiy.1
        for <linux-rdma@vger.kernel.org>; Sat, 29 Oct 2022 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tr2UL87SzzQKUowh10dEusGUotVvgQ5fIN7/9G0axYI=;
        b=FhpKgix4ItBc1dry1H0LVoXpAtt0oDaXyUiqELpbT7IpK9I1pwFQhopp4XLEKZZfBD
         Hx9vXnxrO4hSPH3mOZaLhTJL6MM1KNgEohDPTgDac/loXnYGJzTineXJ59gnyOpNUYXt
         Tu3aXKQHqM28vMFL7QnDdc5WB1R0+toNoagMz5qP9T0SOXrpc2KMICj4175Kxxxjv5RV
         2dMtVPJjLSWVFGLJZyyg/pukBHi6LRnXnNV8++wXZZBQFedBQlfXyeKgaNGAd0m6GvkU
         udHNysdfH/T6diu/0eNsFsbqJwLjvt2BMfmzzSzg19i0oWkcUiouCPcu1+MstAl3y0mb
         PAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr2UL87SzzQKUowh10dEusGUotVvgQ5fIN7/9G0axYI=;
        b=uFJQlJ8ojU4N+x2sXyCzt6qC5huPwFsH921z5lxmPak7tDjEt86SfCT3iqx6dJhdIe
         CXg7yzhg3aNGta+gHSWKAMf+VowjM8HwEVk/IEA6UDFV3tFLqDvReFWFRRx37t62Y7K0
         Bj2b5GmLskt1GwHpah8/79p8JnAAGAXiPxRHeeH9/+xBF7IweU25A2M94Tx4Cxw72T7K
         zzxcyMoeQvTg3Rfslbl63e7jJEL8zrI5cfAAh4NKn1dJIZxNgm17qb4uB2lM8uTSWcZC
         ZFEqq4BSMrbut7OZwa+UB+R36W5XX3lUwjNqXtTzgc6WkEG/T9MJiS/xzMF4UTEDVZuw
         tGoA==
X-Gm-Message-State: ACrzQf3DFYE2tDNQjNRJcGeZqeAEEnozoSOKgILy8Ref0g4Cf9XVZKSO
        Kbx6w5OzDw0H6Ez5srxMvcdXqpWvXwI=
X-Google-Smtp-Source: AMsMyM6ZpsW9Sg3D8NTkEXmFFMT7BxbSOuV5nkawQCJd2cp8Fmog45ihiKeMaVE6W8DBVjqsh6MHxA==
X-Received: by 2002:a05:6808:1301:b0:359:b642:4f88 with SMTP id y1-20020a056808130100b00359b6424f88mr2483812oiv.36.1667062936141;
        Sat, 29 Oct 2022 10:02:16 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7572:7e19:a0eb:d4af? (2603-8081-140c-1a00-7572-7e19-a0eb-d4af.res6.spectrum.com. [2603:8081:140c:1a00:7572:7e19:a0eb:d4af])
        by smtp.gmail.com with ESMTPSA id k20-20020a056830169400b00667ff6b7e9esm814217otr.40.2022.10.29.10.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 10:02:15 -0700 (PDT)
Message-ID: <cc2c5c4c-0519-71bc-ff27-2752a0941c5c@gmail.com>
Date:   Sat, 29 Oct 2022 12:02:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: I resent 05/13 because it was missing the for-next
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <8cca8a95-f269-a85a-9104-6a259aec52f7@gmail.com>
 <Y11Py4dE9my3i3Ys@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y11Py4dE9my3i3Ys@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/29/22 11:07, Jason Gunthorpe wrote:
> On Fri, Oct 28, 2022 at 10:14:55PM -0500, Bob Pearson wrote:
>> I had put them in by hand and missed one.
> 
> Every time you do that it messes up patchworks
> 
> You need to find a flow that doesn't have these manual fixups in it
> 
> Jason
Apologies. I'll work on it.
