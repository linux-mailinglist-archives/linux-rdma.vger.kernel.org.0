Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E70D3507A3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 21:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhCaTvo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 15:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhCaTvh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 15:51:37 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34BC061574
        for <linux-rdma@vger.kernel.org>; Wed, 31 Mar 2021 12:51:37 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso20051371ott.13
        for <linux-rdma@vger.kernel.org>; Wed, 31 Mar 2021 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u5OwXFAYL0nD7H+2g333NnonymIRRsm8kBjEQaZwohw=;
        b=pxvjVScCDWT0WebNL90RomHPJqY9WPYdXN//ecFleauNIH8i4hs/PqJrFp696wc99T
         qHrd7J8ny4cpqX7ShxM+tjJI5UqTJ5hcaI+hMLHOOAlo8x9AMEybwvG7PwIv48gcSitv
         AfqKf7+cgENwYagFw7bzvOEb7G5tTvnwUbQwHVMikwSx0hI/3sD9m7+78umg51k9JzeN
         WxoxUIfRR14tLI9C36MVB1RnR7BqgFt9xDGmRO5JWOKW/jqrQvVgYzSaNx3k0bYYoCDs
         xiuGkkjVkdzN4PjrSOCWBtlm33+QlCtaI+0/jn9yHoANwi3Sun0rOcr/ZH9ackgNlU64
         uEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u5OwXFAYL0nD7H+2g333NnonymIRRsm8kBjEQaZwohw=;
        b=V8VkofSSFqmHLduzlkGbJUyswieiy9nhxrPH0GIpMMLt1rXLcTLtW9lCnSJocYgle5
         7Kr8MoUgGmgxT+ANjR73nZIDg4fy0AoDSDi8M2/joJmAuCz2gIscnnicFbhiARk3jU7S
         hJOu7AEaXRzx95jlF5oAleGj1qGO9KsaYf/chh1feajUP4DeX1JYW228BPZOJTj6AVAY
         f8B7kMZLJidvftwSvh2iNvD8sY4refrtl2vaviXuVawTW97xW5lGnsTNB1A4KkoqgKFR
         JDscB27mi3+mz2Sp3Pt6nj1vF5dJA0HBk3QDGeLMZkjayJEWMuCSy5AZ72bt2sVS+6Jh
         vavg==
X-Gm-Message-State: AOAM530v/cHaK8/lyjI/rNedC6RjTkWuOErk0dO6WrfQbGbv8NmismLu
        H47B6CNtlvh+DuKs7UGbACs=
X-Google-Smtp-Source: ABdhPJzaHlqQn0X+p0tR8bG6BXdHRR8fQNh+6+Ukdlm216iD5ljlhvPCZhi6fDCVEOpUMD7LA8uREw==
X-Received: by 2002:a9d:7c99:: with SMTP id q25mr4005731otn.339.1617220297023;
        Wed, 31 Mar 2021 12:51:37 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:555b:611:3c2d:b176? (2603-8081-140c-1a00-555b-0611-3c2d-b176.res6.spectrum.com. [2603:8081:140c:1a00:555b:611:3c2d:b176])
        by smtp.gmail.com with ESMTPSA id e18sm712883otf.2.2021.03.31.12.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 12:51:36 -0700 (PDT)
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
 <20210330201245.GA1447467@nvidia.com>
 <54ec9b7c-5c43-2c36-ea51-684fd63368f9@gmail.com>
 <20210330225437.GD2356281@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <d542977c-54fa-b1e6-8717-616d6c5b5218@gmail.com>
Date:   Wed, 31 Mar 2021 14:51:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330225437.GD2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/30/21 5:54 PM, Jason Gunthorpe wrote:
> On Tue, Mar 30, 2021 at 03:46:24PM -0500, Bob Pearson wrote:
>> On 3/30/21 3:12 PM, Jason Gunthorpe wrote:
>>> On Thu, Mar 25, 2021 at 04:24:26PM -0500, Bob Pearson wrote:
>>>> In the original rxe implementation it was intended to use a common
>>>> object to represent MRs and MWs but they are different enough to
>>>> separate these into two objects.
>>>>
>>>> This allows replacing the mem name with mr for MRs which is more
>>>> consistent with the style for the other objects and less likely
>>>> to be confusing. This is a long patch that mostly changes mem to
>>>> mr where it makes sense and adds a new rxe_mw struct.
>>>>
>>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>>> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>>>> v2:
>>>>  v1 of this patch included some fields in the new rxe_mw struct
>>>>  which were not yet needed. They are removed in v2.
>>>>  This patch includes changes needed to address the fact that
>>>>  the ib_mw struct is now being allocated in rdma/core.
>>>
>>> Applied to for-next
>>>
>>> I touched it with clang-format first though, lots of little whitespace
>>> issues
>>>
>>> Thanks,
>>> Jason
>>>
>> Thanks. Is that a stand along app or a git sub-command?
> 
> It is part of clang
> 
> https://clang.llvm.org/docs/ClangFormat.html
> 
> The sequence at the bottom is useful
> 
> git diff -U0 --no-color HEAD^ | clang-format-diff.py -i -p1
> 
> But I also have it on a current-single-statement-only hotkey in my editor
> 
> Jason
> 

Is the long term goal to take clang-format as the default whitespace format?
If so should I just reformat all the files in rxe now and get it over with?

Bob
