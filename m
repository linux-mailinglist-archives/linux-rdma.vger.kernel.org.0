Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1036A4FA2B5
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 06:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiDIEfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiDIEfn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 00:35:43 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431D19C36
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 21:33:35 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so1339985pjb.4
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 21:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6IE0Z9E3kPr7g1CEcexV2WONEy/5P/XN1twOS67kJ34=;
        b=zN05v8lNGKMGauYGxLH4eku3noY6TwcaJIa/Iy59q6KyMYD8Utkkw796/BNS4a+Vy3
         s4NJVhnyXbZJEkwtsXrqMvBIrTvR5bYyK41BfazzZdikQcEAPKCiux8Zwejx0uY/RKmZ
         +7MOEBJrnvdBpL727CDk44BdRBsmbzNvtVKDfEkuPOtjVriwvgPV1wXZLlTf0LQc46hH
         5dnFiDGQFYbuZqiiWFlrhfVEJpGQvGkC1SJVl1LUYKsc4YnNGI0Q0BNq5kam/bdwcq71
         iNzP7Z3weal3vT0LkyMGPFUR0i2oG0CM0Dos5rnQuT9wpUw8C8Bm6pae5A3knRnQLm7m
         XRgA==
X-Gm-Message-State: AOAM531d29705OI8Cb/8Hn0cOEhj6isWG6oFCGJozOPyI0Q5n/XPPc6v
        7BMpO0Jk2c4VWUH5SuQ8VH2i3K/VaYg=
X-Google-Smtp-Source: ABdhPJyqTb9TvjV7WyDgzFJlIlzpaqekOQ2hGVDXTQeKnyVGdoR+uUCsPnQcGuCRHdWkx9boN9d8mw==
X-Received: by 2002:a17:90a:7145:b0:1ca:97b5:96ae with SMTP id g5-20020a17090a714500b001ca97b596aemr25660090pjs.64.1649478815313;
        Fri, 08 Apr 2022 21:33:35 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 75-20020a62174e000000b0050579f94ed2sm4240984pfx.96.2022.04.08.21.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 21:33:34 -0700 (PDT)
Message-ID: <dd7a3483-06b3-f417-da81-dd99900b9dc6@acm.org>
Date:   Fri, 8 Apr 2022 21:33:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktest failures
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
 <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com>
 <98f2a27d-7fa6-074f-a3e5-6b172c79ccd7@acm.org>
 <CAHj4cs8Z7LAWQxf2H8wX18rxOMUEy6bogo-dPCY8mVef4iR=cw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs8Z7LAWQxf2H8wX18rxOMUEy6bogo-dPCY8mVef4iR=cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/22 17:31, Yi Zhang wrote:
> I reported/bisected for this issue last week, not sure if it helped.
> https://lore.kernel.org/linux-block/CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com/T/#t

That definitely helps :-) Since reverting the scsi_debug patch that has 
been identified as the root cause unbreaks blktests, I will post a 
revert of that patch.

Thanks,

Bart.
