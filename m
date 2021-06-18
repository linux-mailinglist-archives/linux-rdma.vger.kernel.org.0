Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDD3AD26E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhFRTBB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 15:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhFRTBA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 15:01:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199EC061574
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 11:58:50 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so11605155oig.12
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eeEk+g+NlqllAB0X42BY49mULUzTThPPBJ9Hf1lLSF4=;
        b=ahCgP7WSCQjLOHUNLwL6hrGGtwXRp1YztatQqG6y1LvwQ0CIOS1vOMGnKs+Occq4dx
         36+JMxbZxJOk1/Fa63MJQEYuo4PVtH1vjieb4ZEumxgf0jRzf3qP1K1yFCZFMdKRkMHV
         gl1BJkxckK5MHpMDn7vHNqlQDluPGsWYG6u/RrbNDljW9QCC4Uzaf8Tu5i5JOHwZePZG
         vTPTvvCqooCOzgfM8tzPvbGDC5ULpiq9Bwrw/mGg/I3lntmgosv6O2ubfITCZUnO65j4
         4b18tz1JIW6BuogYMXbw2dsO0A0QxUaLxMfoSoh15EUYjnoPYuPqlC38xQplbKaK3G/U
         w02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eeEk+g+NlqllAB0X42BY49mULUzTThPPBJ9Hf1lLSF4=;
        b=uYsEYAtIjtQkFIEKZE4VGP7+tIWI0LHEBUUUg45pwyN+zy1LOdxvme/rq2tY4Btyyr
         2O7jPjh5uRlUTfRkTRRxCm2xCT1Ytszr60HvlndJg51lc12bH/1jCMEwzKm2Iv7J3zJF
         TflDyF5LohHcYg/9Tj7eJts9wdvc5HnKNaYh+esGTTZLJF11zg6KDR4ro5xjWDljRqdD
         PTKz7sj0Dzpmt6xf4Xc7r5Bk1xz+8PPhUipk/Rsi2Df84vCWaNcB0gypN5g1Q7aRhTAo
         L1NokU/xuJkZ1dL2v1Vf8zlLI+pOtwRDYgjQWE/6YN/m0aUzx/fWChaoY4ogGJPg093w
         8QdQ==
X-Gm-Message-State: AOAM532s5VKUIgq5+yzQioqVQByOSBBihDxM9L3KB610Le3B5fuI0pRk
        2KajQt2bWGRxSWWrbr66vowxQTk4D1o=
X-Google-Smtp-Source: ABdhPJybQ0CFioL+hdYkkn6fHbBM5fBliH8xaEtQ1pdfajaoHatnAez1q7qyzynoopc0vKN96gbg7Q==
X-Received: by 2002:aca:4141:: with SMTP id o62mr9180447oia.42.1624042729516;
        Fri, 18 Jun 2021 11:58:49 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:2fce:3453:431e:5204? (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id e23sm2195997otk.67.2021.06.18.11.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 11:58:49 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shoaib Rao <rao.shoaib@oracle.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
 <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
 <20210618163359.GA1096940@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <14e2c2a4-6067-c657-6ea4-91cd3c19d032@gmail.com>
Date:   Fri, 18 Jun 2021 13:58:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618163359.GA1096940@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/18/21 11:33 AM, Jason Gunthorpe wrote:
> On Thu, Jun 17, 2021 at 10:56:58PM -0500, Bob Pearson wrote:
>  
>> It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson
> 
> Can we just delete the concept completely?
> 
> Jason
> 
Not sure where you are headed here. Do you mean just lift the limits all together?
That would not be in the spirit of the IBA even if that is not very meaningful.
One of the useful things rxe does is to provide a cheap 'reference' implementation of the spec.
If OTOH you want to put it in production then the limits are not very useful.

Bob
