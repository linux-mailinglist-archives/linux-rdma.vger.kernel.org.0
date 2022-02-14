Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BDB4B5B43
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiBNUvG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 15:51:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiBNUvF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 15:51:05 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04BF9E542
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 12:50:42 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id om7so15642309pjb.5
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 12:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sXz7CSUg7MoXLb+OX27tc6YtbrnTsSs+qqZymzHoHhU=;
        b=AuPWGD579/uRFnekgadFOsJNuQacoOEJEduSamCbWYspG61fTkD2o1RGvwcyoJCjHz
         eLJEt7+Ydp2aci/vNLgOHEvQitGzh7+39XC8sCgetn2sH73elXBecEJ2UF9rFzxD9F7s
         cs/343biLLNhFv0D8qZX0dSXmTktlQU/ACX+UZAn9hJskYodvS2iEJWIFOVg5eUJwFJh
         gWKGvJ20slKgM2J/8jqH/16mjEGQAmglhtsEQSePI+JEq6/WQskYTP51GEMLRGrjAcDJ
         GmlsSanmhely2ncN6xbVU7Owf+j4rimsyjRK5mLj7GqKCenVdVerFdIaZKkgxdwJ5vlJ
         sJqQ==
X-Gm-Message-State: AOAM533cy5DiBWMRuhnj/WqpPQi+zw3Bz78MHO2uvVxWBralQH3JSRQ3
        XYlqlK7cEVx0nPph3yrh1N0TLalX4iE=
X-Google-Smtp-Source: ABdhPJwDIy53zBu3OA29cfQBsL35QH/4XCIYf19y616VWIk3JIvGIOWf2UiTTEo11xJc6/RCBk5kTA==
X-Received: by 2002:a17:903:2308:: with SMTP id d8mr732001plh.52.1644871737124;
        Mon, 14 Feb 2022 12:48:57 -0800 (PST)
Received: from ?IPV6:2600:1010:b05a:bf8:cd06:5464:d61e:f6b4? ([2600:1010:b05a:bf8:cd06:5464:d61e:f6b4])
        by smtp.gmail.com with ESMTPSA id f8sm37978203pfv.24.2022.02.14.12.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:48:56 -0800 (PST)
Message-ID: <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
Date:   Mon, 14 Feb 2022 12:48:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/22 12:25, Bob Pearson wrote:
> It helps. I am trying to run blktests -q srp but I need to install
> xfs first it seems. Do I need two nodes or can I run it with just
> one?

XFS? All SRP tests use the null_blk driver if I remember correctly and 
hence don't need any physical block device. Some tests outside the SRP 
directory require xfstools but the SRP tests do not. If blktests are run 
as follows, XFS should not be required:

./check -q srp

Thanks,

Bart.
