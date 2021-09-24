Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88A5416959
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 03:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbhIXB11 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 21:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXB1Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Sep 2021 21:27:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8492C061574
        for <linux-rdma@vger.kernel.org>; Thu, 23 Sep 2021 18:25:52 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 24so12435778oix.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Sep 2021 18:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TtvJt2oni6LkmWs+0o77ybVSQFmA3nb0CxIaDC2Rzaw=;
        b=EjPrGpWrG38K0dqNM6rvturl6BNh7ZmXIV+l4aSDnNTK3GO94VfvoIJH2bX4JyMYFB
         kBgA4OUy6jWr+FHPu5kGpZEfOeN168BP5p6RT6N+ECa2i91FUxV0FljB34l6ICWv7cU5
         JjZBgB2zqGS3kQEp+QD9mocMm4XHLCzlChhhUYxVBNi52b/c3k47bvNWPCLul9tEqP2T
         lUhJpV+Bn01ZonrOX+HwZkWUV8IdOkz0Wab0vp4+ozlVvQ0ZdvepyAZeAYsGZvl4JJPr
         XU0xos/meJBm8YTwBqCF6C+MdU/IMbG24/8L4VQ73PIcw/gwp1AOzXfOFQ98KYbqSs4R
         WULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TtvJt2oni6LkmWs+0o77ybVSQFmA3nb0CxIaDC2Rzaw=;
        b=Tcp660o3wrFsD9LBQk92lbokkwNnmw6AL1C/qE/G3i1VB0ht9a5GDes6WdrTETlBFj
         LEKhYZNHDMQuO29U4ojXraTd439MnJMQFmXz1olNWGY1lJ8VvZARhDKz8Jm3U5xFDmyb
         sFFyD/itlS9mMgg5/p/5I3VWTNl/buLgjGp1qyafFg9t1SsZsb1uvSAs8Wgi34H3F1Vu
         IKJW8sPEGkp3M18yRME6ZzYRaBI19QCISg7khCCxoFpSe3QHMZEs7oSd5Fa8WYKu/XZA
         Ry/+20HNQyfdvOopJ0Ko8c4CMXuPJnX9YDSynu8Dtqz/3IcH8FckvsoBIPn2sry8Y0WU
         aqWA==
X-Gm-Message-State: AOAM531trUO1+Bn8jgJqjUdmoBxf39rQc3hAM2C6AzxMy4788L46ZzX7
        LnOUzfFKM9A9G8KdaEdEAec=
X-Google-Smtp-Source: ABdhPJxg81NZjQcFVatKNkWfPlauSfa+TpLVo/w/u/UWtfN3l1cXFQGKo/L8AWhBETdDoyyY1fjksg==
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr6148042oic.105.1632446752132;
        Thu, 23 Sep 2021 18:25:52 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:1f57:e7c7:fed2:ae25? (2603-8081-140c-1a00-1f57-e7c7-fed2-ae25.res6.spectrum.com. [2603:8081:140c:1a00:1f57:e7c7:fed2:ae25])
        by smtp.gmail.com with ESMTPSA id i4sm1694867otj.9.2021.09.23.18.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 18:25:51 -0700 (PDT)
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Yi Zhang <yi.zhang@redhat.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>, bvanassche@acm.org,
        mie@igel.co.jp, rao.shoaib@oracle.com
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
 <CAN-5tyF6vJQEK3+FJ44+7T223nMqs_dSXYKOKz-fPJ=3OHK12Q@mail.gmail.com>
 <20210923195629.GQ964074@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <b67381d8-89d2-7239-981e-dd50ea6929bd@gmail.com>
Date:   Thu, 23 Sep 2021 20:25:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923195629.GQ964074@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>
>> Hi Bob,
>>
>> After applying these patches only top of 5.15-rc1. rping and mount
>> NFSoRDMA works.
> 
> I've lost track with all the mails, are we good on this series now or
> was there still more fixing needed?
> 
> Jason
> 

There is one remaining report of a problem from Yi Zhang, on 9/17/21, who sees an error in blktest.
Unfortunately I am unable to figure out how to reproduce the error and the code he shows is not directly
in rxe. I suspect it may be related to resource limits if anything which has nothing to do with
the patch series. I believe they are all good.

Bob
