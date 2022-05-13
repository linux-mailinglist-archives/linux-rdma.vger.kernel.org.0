Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823A8526674
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbiEMPpr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 11:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378538AbiEMPpn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 11:45:43 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9908D6F49F
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 08:45:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q8so10548185oif.13
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H1D5w7fh/32Xge2ztFVlzGUCxVzIXnk4nlMdeRqySms=;
        b=pUh1O9JxyeRFgaxz4c5Jvgq82O2VY2eEjpnBhB9apMN1syTDmZlAllH6k5+KwoPhEk
         Y8F/LyQvjlY/M9d6UI3Q2lMGCOfWFO2XSN/DJcFvW8wl/8A/2tUEWk12xVaPmehb2oxE
         mOmeWr/3QjfiheDG+N8HF42yWjQSALZeUeeFMaWKwJgFXe4YEaBNw1S4hkJRcsgeCFBl
         BLHmuh9H60vEycIXjjzWdAlrC312s+BvA3aqUFJGKKKa1zxbsDuZA/QXvwi/N7CMg1a9
         VrohGlc8T/8TAh6rIDOtMK0G1uDxSrVh25fHSepFsT5V08j5tgdbKRivb1yWs9aIXgfn
         6KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H1D5w7fh/32Xge2ztFVlzGUCxVzIXnk4nlMdeRqySms=;
        b=lB+ziPw+hxi67vvf7zRfcFk8dmOKVAdghZ/nPreQDahhrhhZf0aSAZslInV6wm/G2B
         cPZqhy87B6V7vr2N/7U2Sdra2p/BBPc+qA5Ds2X+PXfs7Ukjslg0tKqLuEvaecEKakf2
         XrikcUJpWZIsANR+tWs6iCuwqgqIAV/D6FpYwTWSxcmX3By97qEN/Ynyank38iSVzHr7
         bojCNUW+gHf0zHl3VTjipUOaIuDndoboDTwFYWRkh+JW9qC+7/1jBSGLHiNaAlODsIXx
         VJxo5FIzUld3hweURK1T1fxhZCFOyW7IgBkFwqJBJmpXfZIz4bQjcEdDOhLvKW+IyuRy
         kUnw==
X-Gm-Message-State: AOAM531H9rZTP5WDIFIlIQ9Xgsc7XrfksEvUbbkO9m0p66FoFslANksi
        9gGCigRfqU9iT//MawBfock=
X-Google-Smtp-Source: ABdhPJwp/bL3JmI4pBREKdS9zYQ08wXZFMy7N3zshYX6bZqOkVPZnf7GtqK8j7QMtVsyw5MJvfa4tQ==
X-Received: by 2002:a05:6808:168b:b0:2f7:338b:7a55 with SMTP id bb11-20020a056808168b00b002f7338b7a55mr8179743oib.133.1652456742015;
        Fri, 13 May 2022 08:45:42 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7f98:64fc:d1b4:c63a? (2603-8081-140c-1a00-7f98-64fc-d1b4-c63a.res6.spectrum.com. [2603:8081:140c:1a00:7f98:64fc:d1b4:c63a])
        by smtp.gmail.com with ESMTPSA id s2-20020acadb02000000b00325cda1ffacsm1089781oig.43.2022.05.13.08.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 08:45:41 -0700 (PDT)
Message-ID: <617d7d26-e9a1-8919-1553-badf776a7f88@gmail.com>
Date:   Fri, 13 May 2022 10:45:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
 <8d88406f-cb19-134b-0a1b-ed2b2aea6a91@fujitsu.com>
 <20220513114643.GL1343366@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220513114643.GL1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/22 06:46, Jason Gunthorpe wrote:
> On Fri, May 13, 2022 at 03:46:00AM +0000, yangx.jy@fujitsu.com wrote:
>> Hi All,
>>
>> Ping. ^_^
>> Are there more comments on this patch set?
> 
> I think I said this already, but I'm waiting for all the rxe
> regressions to be fixed before looking any new rxe patches.
> 
> Jason

I am working on them. I am trying to reproduce Bart's claim that
he saw the blktests hangs go away with a merge of head of tree.

Bob 
