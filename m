Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311A639B0D8
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 05:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFDDZn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 23:25:43 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34470 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFDDZn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 23:25:43 -0400
Received: by mail-ot1-f51.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so4747890ott.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jun 2021 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mz2Hnb4p5MSXVSHu1HVDJaqwt3pS8toEgnmSrd0E9eg=;
        b=c3RlvvnifzogJzOVvLszueIVS26uMElRQq7/mfJUAOLlMCTMkvyUV9Rg4tioPb/usN
         gYwPYAQW/qNVh1mASR+LTY1nYSc9a7igUc9GovDKZId0KiOnyKEYKmFg2lmAZl5A9NbW
         TsBoDxI++6z/1zbJTjbvb8P+30YIM19MI+JZ7AlL/c09n6fF+LabDEoe2xUJzONqWfxk
         O+UzsgKoM8215kwe8aLgB1NLBw0AT+kZbeZCjkPmcDVIfzw62Q7ukAZVuMSEdwfs9H9p
         eKmMGQNTN6i7/HAcWapes7q1NS6bTzIpT9HZkG+bTiOazBTziWZB8aa5dG1yyK52GENP
         nzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mz2Hnb4p5MSXVSHu1HVDJaqwt3pS8toEgnmSrd0E9eg=;
        b=Zw7W/eIrlV4pDKdDA7rhHge0/E3s1Y72VVVodJxbRHZ0hBUvuXKLiqJUxQC9AOXlDV
         nz4T/d+ifmfsQ545n+4rhc+SF6Uo1/RPqqRN8EbGl+nnS+Yu0AGi05jGuzjTEUuB429W
         NYw9rkNmD+IM2I2MzT2ok+xWPaVrWV9Ee21+RZQq0hZhfw4iAUXhHOmH13anjQctPeRl
         0ZFw70T84uIktE/n7sVXiW1ffuloO6lNP0+Xyv1XL2XfAjWsd0TcIdChAotzO/QHNd4c
         qjFfYaDMLlbymD/L46771h9/NS+Ica+SUsJLKJELDnBVVc05BFHkslIpJ2dvbiQwHcVJ
         p40g==
X-Gm-Message-State: AOAM530ancHQVQMbRcRydse1ojSDyjROP1u/eaCDjBujUGUwJdkzPa6X
        MTGRMsdFRMkcLXZi8Fo3w/fFxO4YEFQ=
X-Google-Smtp-Source: ABdhPJwaFsfMdS6Knhnj9L/18GGf798H8xv9uWN3CGJYzv6/XA4fmtwzH10rtkbG4U2GSmgKy1D9eA==
X-Received: by 2002:a9d:1b05:: with SMTP id l5mr1987126otl.335.1622776960796;
        Thu, 03 Jun 2021 20:22:40 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:a85e:36ac:5229:4a3a? (2603-8081-140c-1a00-a85e-36ac-5229-4a3a.res6.spectrum.com. [2603:8081:140c:1a00:a85e:36ac:5229:4a3a])
        by smtp.gmail.com with ESMTPSA id w13sm213227otp.10.2021.06.03.20.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 20:22:40 -0700 (PDT)
Subject: Re: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
 <20210603185804.GA317620@nvidia.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <93a42766-9a35-5ccf-5950-6337d54b3354@gmail.com>
Date:   Thu, 3 Jun 2021 22:22:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603185804.GA317620@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/3/2021 1:58 PM, Jason Gunthorpe wrote:
> On Tue, May 25, 2021 at 04:37:42PM -0500, Bob Pearson wrote:
>> This series of patches implement memory windows for the rdma_rxe
>> driver. This is a shorter reimplementation of an earlier patch set.
>> They apply to and depend on the current for-next linux rdma tree.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>> v8:
>>    Dropped wr.mw.flags in the rxe_send_wr struct in rdma_user_rxe.h.
>> v7:
>>    Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
>> v6:
>>    Added rxe_ prefix to subroutine names in lines that changed
>>    from Zhu's review of v5.
>> v5:
>>    Fixed a typo in 10th patch.
>> v4:
>>    Added a 10th patch to check when MRs have bound MWs
>>    and disallow dereg and invalidate operations.
>> v3:
>>    cleaned up void return and lower case enums from
>>    Zhu's review.
>> v2:
>>    cleaned up an issue in rdma_user_rxe.h
>>    cleaned up a collision in rxe_resp.c
>>
>> Bob Pearson (10):
>>    RDMA/rxe: Add bind MW fields to rxe_send_wr
>>    RDMA/rxe: Return errors for add index and key
>>    RDMA/rxe: Enable MW object pool
>>    RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
>>    RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
>>    RDMA/rxe: Move local ops to subroutine
>>    RDMA/rxe: Add support for bind MW work requests
>>    RDMA/rxe: Implement invalidate MW operations
>>    RDMA/rxe: Implement memory access through MWs
>>    RDMA/rxe: Disallow MR dereg and invalidate when bound
> This is all ready now, right?
>
> Can you put the userspace part on the github please?
>
> Jason

I think so. The user space change is in my tree at github but I have to 
admit I forgot how to submit the pull requests.

I think you sent me instructions a while back but I can't find them.

Bob

