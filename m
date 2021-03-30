Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A734F25F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhC3Uqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3Uq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 16:46:26 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD41AC061574
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 13:46:25 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id x2so17827537oiv.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8UVm9bvDiulW1YZadVpUoOgBILJSQjcTphV2YHDxP4=;
        b=TxhRwbMrVlO7DR+Q2NIAhAv7KNcpweTTkDU3dgm7DYnZ88P8DtmqsGl4L6Qh/sQZ3x
         VPA/Dq2MW4uWywie8ikl/Eurfr0UZIfcWufJMHvEwY1Ai3P/j0Ci5T6rsJrEptOLjEte
         T9jtfD0o7qyem45TznV0QsQBtJ2UrPBb1o4u2dONyyNVjXEAMpmBb2XCTCLxlfQ2+DwW
         cNz920gQIYw3iCKdLZhjI58KOJIhGkGbVmseWztSws8MKrl0VBr60MCseFlQ+aJfHo+N
         a1mMiOI2eZnulqfFr5yNe++D5VbdhAt+Se96wnjsGx7ZxJsdoDtHDps73PYqUkS3ZDsG
         uuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8UVm9bvDiulW1YZadVpUoOgBILJSQjcTphV2YHDxP4=;
        b=hXKJo9NCEZs3oZTA3DFaDOqew6MU3SkMx2mFRdHIlgJGr2h4UR8r6za5iPOOT3L4G+
         VqZHzuLKvtNw/zMEKdBo2OIQcM0oZc6/WrC8WH7NreJj7Dw6Kd3U0CpQUdAQ3BfPyPE4
         RVLKxQ582xiyoQN5sOPODqC4pgY1mIDuLevT1Xki994Xdw4f4HoFXXNgILYFnkzPw2VK
         xoyZtv/AFOkotanskLsiIWBsm/6kqZvSIUvbPf21oUn1AVNLUtxeT07uB1Qlx2aGnJpw
         NL4FRZpORIQlqJDMKqDHi3R7przh3M/3yv4d8nuHs87dL1lreftkrG0L7l2TClyfxX6d
         8Y/Q==
X-Gm-Message-State: AOAM531c//EWAnBWo6CiBybytRSZeRua7xDajMfuFY76zvQ6OB7eHOfx
        /Sf7Dtx0oZeFdU0zpz+M7dA=
X-Google-Smtp-Source: ABdhPJzUtaEuDjvWPmLZRnjluD7Mj0P5NbV+wExblnBzWGdNjro3lyX5h4/UxxmKuKezzQQps2Ezow==
X-Received: by 2002:aca:5945:: with SMTP id n66mr4490770oib.11.1617137185377;
        Tue, 30 Mar 2021 13:46:25 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:51df:b5a7:cad6:349f? (2603-8081-140c-1a00-51df-b5a7-cad6-349f.res6.spectrum.com. [2603:8081:140c:1a00:51df:b5a7:cad6:349f])
        by smtp.gmail.com with ESMTPSA id w11sm4568620ooc.35.2021.03.30.13.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 13:46:25 -0700 (PDT)
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
 <20210330201245.GA1447467@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <54ec9b7c-5c43-2c36-ea51-684fd63368f9@gmail.com>
Date:   Tue, 30 Mar 2021 15:46:24 -0500
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
Thanks. Is that a stand along app or a git sub-command?

bob
