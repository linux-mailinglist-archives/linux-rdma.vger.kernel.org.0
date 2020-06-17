Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491DF1FC9B5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFQJU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgFQJU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 05:20:58 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837DDC06174E
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 02:20:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m21so1327064eds.13
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KOGDrIGSTQHdhbcmrj6V2Dmcy4x1v8SuADz9bu5WO38=;
        b=q9VbAJPQvgoXZBcVIywwZi7fjmdAfLMXjoKwS6dOlQ/FL4lOC1KcO2MsbC+fZhbtcb
         Y0yBM+z2b1iI8eIbivfkG5eZLvHFuvluWBuRrtnXnP6/mOo1lW3pcHqtgt9Dq+VNNWwf
         M41aitIVi5IEUcJ84iI1g1w3To2nQZk/W+n/3ZdJJjFyk/GGnBWr46Yj3Xnc0qijhRut
         1GzvNeF9u8DMqvZEdDfCky21gDKeIwDVKuZNfEbMUWzSOzCLaV7lDfxDDR1Y3NyeZLIA
         lmUAv1R3GX3Bwe8ArbzDRzIpKr++tjV4q9cmEFl37qrsbzsFyZfW0v6yc+SZKL9UajiR
         h9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOGDrIGSTQHdhbcmrj6V2Dmcy4x1v8SuADz9bu5WO38=;
        b=otIzNlm+CcGlBB/Da+yl9m8hXy9GDo5A5d+BXxTFzhwE8z75OKSjczlj3IYvQxbTeU
         FtN6N7rBfkl7+gyN1PYEWfv/91VP9Q9wsXXn+qIsEjDGUceZJa6m4xr1Ovpwcwvjz6qI
         YvXTWzzJvYCwDI5ec5LcS0HBNead7nWH3ERbXjDFgWAPol/OEDn7LZkK3l/CVbH/N/B8
         CZvFDsFMIcOEMDI898DnJGuicn+pfQbCs3I70Z1SmB2Gyk/yymF8/J93ga6k7cjTY5vg
         EyeB22t3zfJR/uQ+iHm2D9ngaZ6IYdGWbdvyR4tZ7OxugXLU1Dhy4rq5Ynie5fE6Sra0
         C73g==
X-Gm-Message-State: AOAM530cSI2jPwRlf5Uc3m5TFjjEGK3P7opfA6Eq3RhiweGq4Cgt0p/A
        giMWr08JqMmqlDJDRELNH0Ws4A==
X-Google-Smtp-Source: ABdhPJwVvVPLNr78je6q4NC5LIWu8iJGohIpNbDKeWcyosOA8MeAN/+/A/Y8hiEqAenFJlQAZ6d/fA==
X-Received: by 2002:a05:6402:7d4:: with SMTP id u20mr6290190edy.30.1592385656214;
        Wed, 17 Jun 2020 02:20:56 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.189])
        by smtp.googlemail.com with ESMTPSA id k23sm12947657ejo.120.2020.06.17.02.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 02:20:55 -0700 (PDT)
Subject: Re: [PATCH rdma-next 0/7] Introduce KABIs to query UCONTEXT, PD and
 MR properties
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
References: <20200616105531.2428010-1-leon@kernel.org>
 <20200617082916.GA13188@infradead.org> <20200617083138.GI2383158@unreal>
 <20200617083450.GA25700@infradead.org>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <73708880-55d0-0f39-9195-9627d0da2d60@dev.mellanox.co.il>
Date:   Wed, 17 Jun 2020 12:20:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617083450.GA25700@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/2020 11:34 AM, Christoph Hellwig wrote:
> On Wed, Jun 17, 2020 at 11:31:38AM +0300, Leon Romanovsky wrote:
>> On Wed, Jun 17, 2020 at 01:29:16AM -0700, Christoph Hellwig wrote:
>>> I think you are talking about UABIs (which in linux we actually call
>>> uapis).
>>
>> Yes, I used Yishai's cover letter as is.
> 

We used in the past the "kABI" notation in the rdma sub system when we 
referred to the ioctl interface that kernel exposes to user space.

See the below [1] from Jason and the below [2] mentioned by Linus as of 
Doug's pull request.

However,
We may better refers to UAPI to make things clearer.

[1] https://patchwork.kernel.org/patch/10226945/
[2] commit 004e390d8133b96485e1ab9af5351c2db4300c63
Merge: 24180a6008ac f45765872e7a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Feb 22 11:57:39 2018 -0800

     Merge tag 'for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma

     Pull rdma fixes from Doug Ledford:
      "Nothing in this is overly interesting, it's mostly your garden 
variety
       fixes.

       There was some work in this merge cycle around the new ioctl kABI, so
       there are fixes in here related to that (probably with more to come).


Yishai
