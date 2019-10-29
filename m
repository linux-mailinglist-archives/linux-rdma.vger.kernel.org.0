Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9FE854E
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 11:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfJ2KQF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 06:16:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43579 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfJ2KQE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 06:16:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1so5501414wra.10
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPLTmhqKa5MP4G8n0e7WEl8SERHVlOUwHbNqzvLE+cc=;
        b=uqOrX5ezWZtW7Fmcy+dlhdUqve7G3SDFm9HM4wwb1RcmwdaQDx5pR5iiOj9dpJjoRg
         7Qy0R8SrFqJ4/cpb+zWVaSqP+6lZDosR7fWyYzA2S1TFz8O3P8fkBWPgtgWCjdCCzFgq
         hkawieEW+trDqbUjO5/ZHJ8bNB1CWVt0/HgdoQaKUZeloO2EHxa3ErfpbCZJ48WDsQ/K
         Dx218eowuyAzjcRwZPHh0abd3gn14OLSGWRDspXSeHn/VPIhtAMayq2ogxyzu6QLKkX/
         YG7pv9ZQ8a4HxIb/sSBP9wJCaOlFeluVh7DBSs3UDBYUOXSyf6GUMLFgTLKCqkl8ENOj
         qk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPLTmhqKa5MP4G8n0e7WEl8SERHVlOUwHbNqzvLE+cc=;
        b=Lbcs5JT3iqwoftjLiuqfdOzhR3oN/Pymvs7IMp0KFGM/8Zw/7nJEp0f6Zfjj9a3oB1
         N29sdePP567IDBkACc6nxXHwwdQ6FZaOLqeunDKHl6U4UAc67LQs3uX7RYk0a0/wz1IE
         lkrUd9nXKg9aZsUJhofXXJ3HW07EPYr0zcgnY7wIZ7TsIJPC+XhgZbrWOSS+rxrYYxRs
         H3+M8LBrbMZpg9dKsHlMgywdwjNMuNYWdvKoB53qwP1tA4+PAiszCQDLgL8X191FLGiI
         yPNoUOE6tqeZcwei8W9Dbz3AczAxTDRggMHq6jXmz4oEdRipXejb7/J3GLUR2/OsXxrn
         3xlw==
X-Gm-Message-State: APjAAAVl29L0smYAyeuqpx6xbFK8JYW1A0TGE0ZyTfxlgiMVSf7zSKJe
        /mUTFeEcH9qDwSIHNzwl9o4ShN64wc8=
X-Google-Smtp-Source: APXvYqwrYqzpN0gVOhMWOIc6YT0khaJFXe/KK9Vf3/56hObeDFA8XyuKMUkyeswRXRj/w39YvoIjlg==
X-Received: by 2002:a05:6000:12cd:: with SMTP id l13mr19038622wrx.181.1572344162451;
        Tue, 29 Oct 2019 03:16:02 -0700 (PDT)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id e12sm15475378wrs.49.2019.10.29.03.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:16:01 -0700 (PDT)
Subject: Re: [PATCH rdma-core 2/6] verbs: custom parent-domain allocators
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        haggaie@mellanox.com, jgg@mellanox.com, maorg@mellanox.com
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
 <1572254099-30864-3-git-send-email-yishaih@mellanox.com>
 <20191028094850.GB5146@unreal>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <e035115c-7811-7157-751c-16edabc127cd@dev.mellanox.co.il>
Date:   Tue, 29 Oct 2019 12:16:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028094850.GB5146@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/2019 11:48 AM, Leon Romanovsky wrote:
> On Mon, Oct 28, 2019 at 11:14:55AM +0200, Yishai Hadas wrote:
>> From: Haggai Eran <haggaie@mellanox.com>
>>
>> Extend the parent domain object with custom allocation callbacks that
>> can be used by user-applications to override the provider allocation.
>>
>> This can be used for example to add NUMA aware allocation.
>>
>> The new allocator receives context information about the parent domain,
>> as well as the requested size and alignment of the buffer. It also
>> receives a vendor-specific resource type code to allow customizing it
>> for specific resources.
>>
>> The allocator then allocates the memory or returns an
>> IBV_ALLOCATOR_USE_DEFAULT value to request that the provider driver use
>> its own allocation method.
>>
>> Signed-off-by: Haggai Eran <haggaie@mellanox.com>
>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>> ---
>>   libibverbs/man/ibv_alloc_parent_domain.3 | 54 ++++++++++++++++++++++++++++++++
>>   libibverbs/verbs.h                       | 12 +++++++
>>   2 files changed, 66 insertions(+)
>>
> 
> It is unclear to me how and maybe it is not possible for this API. but I
> would expect any changes in public API be accompanied by relevant tests.
> 

The current pyverbs infrastructure has some lack in this area to enable 
adding a simple test over.
The infrastructure team is working to find a solution and may push it 
once be ready later on.

Yishai
