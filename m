Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2448D353549
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Apr 2021 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhDCTAq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Apr 2021 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhDCTAn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Apr 2021 15:00:43 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C221EC0613E6
        for <linux-rdma@vger.kernel.org>; Sat,  3 Apr 2021 12:00:39 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x207so7996788oif.1
        for <linux-rdma@vger.kernel.org>; Sat, 03 Apr 2021 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e73afFUvslMR6Clox3F/Uz/6VCIoYcJRuqUqyqdrvi4=;
        b=SLkQ9UOGloLL4crb88/dfG0TVnHya+zT7ez8B/159v/XrZMP1Tip0kvGEtgVoJwTnd
         GEKuFUJqssBHjmhbSzNL7QaesFCgSYopX3NGB4j2f70kmhkBLRW7Q+vIpEZ74+Knyi5B
         D8I24/nWUG9795y8KnVg2bVLl5Or7l0/9Oh9Z9FqdgNg12VvafvkHvOpuIaKFeWezNnw
         ssNMlDhoJjBoY0dbfmcBaponF8pEpKLrGWNBhOndeWRx2dPVwbNqpZDgoVLBOYpgcYTL
         ukkOSvZNp0qX2cjDMxM0PG9lkj+c/7lqQCMVUT199VbS3cn9I02OhqcwDkUmPagLvZ1k
         gQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e73afFUvslMR6Clox3F/Uz/6VCIoYcJRuqUqyqdrvi4=;
        b=Bbw5LJKkpB/fSaX8YAYP1QnAAjD6iWELWR+DbH+TcETN+HCm0LJWFcKLkFoGGiM/0F
         Wr3iHHUlFl+JmwSu1+iY3p3AkTDHvfGzhhQKF/1EOVZRTipnqLRZ3uVbTqRxAHURhKyu
         52g8IRJdnJ2j5XgsSlOpYIHm7o4ji+QANwHLrJq+yxR2O2sCm977+MNKKItSbsWO6ePY
         REVCTKB2VdEYCuM26OMrBZJ1geVibsgGA9Rd99p5R8NizPIBzF0fmqzIsAkWC+hhEZDh
         ki50Pima1Ai/5QKKFIQrKZTt9r9OcJAkLp2BdzpVDh4ugXJNOvuvJ4QwniQvkUPZiIS1
         g8FA==
X-Gm-Message-State: AOAM530S+x3++4zfLE1FqLkU3nfPSs9aVpRnJyyHl5Itzh5t3Y630Fd1
        c+4RjKdJkOS7jhauRg1nZBE=
X-Google-Smtp-Source: ABdhPJxVYEcU3OyQUpxKfbhieNC2M0K/k+8TYRg/rtwnYiSsjrzKvwUI7nUgLg4qwg15een8LELvqg==
X-Received: by 2002:a05:6808:2d5:: with SMTP id a21mr13646277oid.88.1617476438532;
        Sat, 03 Apr 2021 12:00:38 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d617:9cd:c0c1:f9b2? (2603-8081-140c-1a00-d617-09cd-c0c1-f9b2.res6.spectrum.com. [2603:8081:140c:1a00:d617:9cd:c0c1:f9b2])
        by smtp.gmail.com with ESMTPSA id a13sm2455325ooj.14.2021.04.03.12.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 12:00:37 -0700 (PDT)
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
 <20210330201245.GA1447467@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <d008b9f1-ba94-725b-2753-d586a4e400bb@gmail.com>
Date:   Sat, 3 Apr 2021 14:00:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330201245.GA1447467@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/30/21 3:12 PM, Jason Gunthorpe wrote:
> On Thu, Mar 25, 2021 at 04:24:26PM -0500, Bob Pearson wrote:
>> In the original rxe implementation it was intended to use a common
>> object to represent MRs and MWs but they are different enough to
>> separate these into two objects.
>>
>> This allows replacing the mem name with mr for MRs which is more
>> consistent with the style for the other objects and less likely
>> to be confusing. This is a long patch that mostly changes mem to
>> mr where it makes sense and adds a new rxe_mw struct.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>> ---
>> v2:
>>  v1 of this patch included some fields in the new rxe_mw struct
>>  which were not yet needed. They are removed in v2.
>>  This patch includes changes needed to address the fact that
>>  the ib_mw struct is now being allocated in rdma/core.
> 
> Applied to for-next
> 
> I touched it with clang-format first though, lots of little whitespace
> issues
> 
> Thanks,
> Jason
> 

When you apply to for-next where does it go? Until it shows up somewhere
I need to apply the patch but since you changed it I don't know what it
ended up as. If I knew which tree contained the patch I could figure it out.

Thanks,

Bob
