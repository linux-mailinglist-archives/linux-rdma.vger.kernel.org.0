Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE897D59EB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjJXRsE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 13:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjJXRsD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 13:48:03 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5EB133
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 10:48:01 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57ad95c555eso2901848eaf.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698169681; x=1698774481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCEV2aLV8ei1dEDFCeFBsjYQfp9yklNVwexl7JqAOQo=;
        b=EPo7VfTW3Q5mLO3WMArlyrYkUv91y6VLYMolG+Ij7jESzrAcY7rb4fbvtQccI++PkS
         XPbKWjXGZYD18Gd+vcE8KPLhW0SQf1so6ozPrwd/Mq1aojnUQ4isvtuStZDAGTF7cynY
         W2Lgx3c/0eXa3hTl5o2jSBpJ+Li+PnqH/FBxLthJHHLAL4U/F0yAux3Z6Iwy7rnQ60iE
         dRHISYodDuMY4pE9TtxiyisEdSfUEdmdTj505vwD2guFKQPNJgbAjnMWP6hrBVj8yrQ7
         IGoG/P+pMpEIkt/UHiPkYroNwVrmADQbCMfgXVsrJjjjh6Xo1hRZ9AGZNH5QtJaDsZUm
         40TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169681; x=1698774481;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCEV2aLV8ei1dEDFCeFBsjYQfp9yklNVwexl7JqAOQo=;
        b=ZE1tlqEj6FbIVf4HdLrgRQQiYFusGlC4dqtuzOt1BRrX57jRu78dan4LaSBZrIrsYU
         anSlE1HA/JDW08g7/R0nKXoXs2870htxMN3bfPRfk/QA89r52h8Sp68JfwbG9K+exHIw
         JG53ldi8bBSPQ1/52VwI7vtb1qL/doMu3FE1oPoPJziGMPExl4vD06X9UoKxXYEIfXIn
         15sCw3BXAwSMbpHasp79AAPkLLGcr7+IV1GeCT5H/bInFufI2bcLhx333dh84Wahw9UT
         /37s+AWkZGHks8VsfXhcrQHPYJwVcXsP01BkjoYEcLdf44doWg9FkyerFSgHxm5cEmQk
         ru+w==
X-Gm-Message-State: AOJu0YxeWsAELdxEcLOImMwUFpvKS/nd9fL4lUo5hpUwIA3Q85MyOYmH
        mDVdt9krzwe+yII32LQHDHerfxaiiEXP/A==
X-Google-Smtp-Source: AGHT+IGX3Te8QMHbn6KM+oA70uHBoOwSftT/dmGowhVfzGPns8lp3ffj2y4A3VbPS9weuODiqwVgoA==
X-Received: by 2002:a4a:dc88:0:b0:57b:dcc4:8f1 with SMTP id g8-20020a4adc88000000b0057bdcc408f1mr12620879oou.8.1698169680922;
        Tue, 24 Oct 2023 10:48:00 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:2301:d8a4:1c8f:de7? (2603-8081-1405-679b-2301-d8a4-1c8f-0de7.res6.spectrum.com. [2603:8081:1405:679b:2301:d8a4:1c8f:de7])
        by smtp.gmail.com with ESMTPSA id w1-20020a4ab6c1000000b00581fedcb06csm2013563ooo.19.2023.10.24.10.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 10:48:00 -0700 (PDT)
Message-ID: <99cafadf-a7c5-4217-9162-38fb6f8b56bf@gmail.com>
Date:   Tue, 24 Oct 2023 12:47:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: modify srq pyverbs test (new?) failing for the rxe driver
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     edwards@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <401221fd-b41d-4db9-be22-b1af17b0d456@gmail.com>
In-Reply-To: <401221fd-b41d-4db9-be22-b1af17b0d456@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/23/23 17:47, Bob Pearson wrote:
> Edward,
> 
> There is a test which may be new since this failure didn't happen
> before. Modify srq tries to set max_wr to 4094 but the rxe driver
> rounds this up to 2^n-1 or 4095. My understanding of the IBA
> spec is that queue sizes can be set larger than requested.
> Also this same test tries to change max_sge using the same
> MAX_WR mask bit. There is no mention (as far as I can recall)
> in the IBA spec of being able to change the max_sge setting.
> 
> Is this really the correct behavior?
> 
> Bob Pearson

Just for reference

11.2.3.3 MODIFY SHARED RECEIVE QUEUE
Description:
   Modifies the attributes of an SRQ for the specified HCA.
   If any of the modify attributes are invalid, none of the attributes
   shall be modified.
   Input Modifiers:
     •HCA handle.
     •SRQ handle.
     •The SRQ attributes to modify and their new values. The SRQ at-
     tributes that can be modified after the SRQ has been created are:
       •The maximum number of outstanding Work Requests the
       Consumer expects to submit to the Shared Receive Queue, if
       resizing of the SRQ is supported by the HCA.

[It does *not* include max_sge.]

       •SRQ Limit. If the SRQ Limit is greater than zero, then it shall
       be armed upon returning from this verb.
   Output Modifiers:
     •The actual number of outstanding Work Requests supported on
     the Shared Receive Queue. If an error is not returned, this is
     guaranteed to be greater than or equal to the number requested.
     (This may require the Consumer to increase the size of the CQ.)

[Unfortunately the rdma verbs API does not support returning the
new value of max_wr. You have to call ib_query_srq to get the new
value which does *not* have to equal the requested size.]

     •Verb Results:
     •Operation completed successfully.
     •Insufficient resources to complete request.
     •Invalid HCA handle.
     •Invalid SRQ handle.
     •SRQ is in the Error State.
     •HCA does not support resizing SRQ.
     •Maximum number of Work Requests requested exceeds HCA
     capability.
     •SRQ Limit exceeds maximum number of Work Requests al-
     lowed on the SRQ.
     •More outstanding entries on WQ than size specified.
     •HCA does not support SRQ.

[The test_modify_srq just seems incorrect.]
