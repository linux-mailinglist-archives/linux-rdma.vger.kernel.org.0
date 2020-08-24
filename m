Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE2250C92
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 01:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHXXww (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 19:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXXww (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 19:52:52 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2279C061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 16:52:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id h3so9999986oie.11
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AkvK8z1KziqPl34DDCu7wAWi7osslW18khtpLTiStlE=;
        b=clNt8Rc4bwl9rcZPA0UdtD5J6cHexFThX8t9kGVMglzzezWH8meW8CYoESVqvBD8IH
         Nj6VxxyFwyr9TuSM/6NOAt0O+lEIh2qaHon99OjSqmNnchQmJF9mRk2TDdYE+PkkSuYN
         B0+5Md/byMI+d2vVsnk5BEtF8xa3n6pdW4OsUH+olvwk4M6aWZFaE6fVgxCZivaSvGkd
         76LXXRpVSF3DAgEFajutRDliFdIqt9TtoZeiCI5kUI9gbvqK3JxIirrTdIoPtCuoCc1N
         TL4b9QlLcgmZj3o3W3nfOkpCIUy4upw5Bp0peVQiEtE6pSA5bahGOOTqc2j/w8EMtyHj
         BjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AkvK8z1KziqPl34DDCu7wAWi7osslW18khtpLTiStlE=;
        b=YK50t/W86KpIc0pcdW6mzFD+SvVTU5hdHIp5tH0dbJYdbmDOIrHO5G3eSCLCHMlltj
         GqnFQHUThldAzChoZVgQ+ByQO1nW0XgtE7+0UXTat2819DLvWa+YRNVmD0fWg43xeTzy
         n5KGv+pHXAW2QzWjpmf7s887WJO+m4oS+nz7PmK79sb9eC1HGEUXwiEhcZeMlPPL7KiL
         E+niyVm98/bGLEaVwbDCJIlaeAyiaFeiACoBc42v80bkQyETdrzlc82uC4X8wvV4P5vd
         Uk0RbDOfjEJabWNJ/IVRd50VSM/PUAwpEkMD/O5AloTo9AjTo2iQ0LqT1p0rgYjowPT0
         qDww==
X-Gm-Message-State: AOAM533Wbydf5TWOfXe1CL5qocBHSMLwHxlB3mET6guHAngab9Tz7S6U
        TcdR/RQ4Yce63JaZpWiyXjw=
X-Google-Smtp-Source: ABdhPJwJ01oXv1Jw+SOqAOhbrIEFVHm0dWAw9MjAG2aIrAiD53mUXYFuPSXBJuhuXteouGdd8bk72A==
X-Received: by 2002:aca:d70b:: with SMTP id o11mr1192612oig.30.1598313171190;
        Mon, 24 Aug 2020 16:52:51 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:ab9d:b15a:fdb:5727? ([2605:6000:8b03:f000:ab9d:b15a:fdb:5727])
        by smtp.gmail.com with ESMTPSA id y18sm2513057ool.16.2020.08.24.16.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 16:52:50 -0700 (PDT)
Subject: Re: [PATCH v3 11/17] rdma_rxe: Address an issue with hardened user
 copy
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-12-rpearson@hpe.com>
 <4fd91289-7cd7-a62c-54ee-4ace9eb45a14@gmail.com>
 <f69f8a27-e4e6-88ae-77d8-358fde60d72e@gmail.com>
 <20200824085243.GI571722@unreal>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <6ae29166-fbaa-8bc2-a160-119b310d1e21@gmail.com>
Date:   Mon, 24 Aug 2020 18:52:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824085243.GI571722@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/20 3:52 AM, Leon Romanovsky wrote:
> On Fri, Aug 21, 2020 at 11:16:59PM -0500, Bob Pearson wrote:
>> On 8/21/20 10:32 PM, Zhu Yanjun wrote:
>>> On 8/21/2020 6:46 AM, Bob Pearson wrote:
>>>> Added a new feature to pools to let driver white list a region of
>>>> a pool object. This removes a kernel oops caused when create qp
>>>> returns the qp number so the next patch will work without errors.
>>>>
>>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> 
> And we asked you to provide warning itself.
> 
> Thanks
> 

Thanks for your responses to this patch (11/17). I am not yet convinced that there is anything that needs fixing. If you read the code in __check_heap_object in mm/slab.c (see below) you can see that any memory reference to kernel space from the slab/slub allocator, even if it is otherwise perfectly fine, that is not contained in the usercopy region (useroffset to useroffset + usersize from the start of each object) will trigger a warning. This is intentional not a bug. If you create the cache with kmem_cache_create this region is NULL, if you use kmem_cache_create_usercopy you may set the limits on the usercopy region.

There at least two ways to mitigate this warning, set the usercopy region (whitelist it) or copy the data through some other memory (e.g. copy onto the stack and call user copy from there). I have tried both of these and they work but still you are looking for something else. Either of these changes makes rxe secure as you put it.

This user_copy warning is from drivers/infiniband/core and is referring to the qp objects. It has nothing to do with any of the other changes in the patches. It is caused by the addition of the checks below which are new to the mainline kernel.

#ifdef CONFIG_HARDENED_USERCOPY
/*
 * Rejects incorrectly sized objects and objects that are to be copied
 * to/from userspace but do not fall entirely within the containing slab
 * cache's usercopy region.
 *
 * Returns NULL if check passes, otherwise const char * to name of cache
 * to indicate an error.
 */
void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
                         bool to_user)
{
        struct kmem_cache *cachep;
        unsigned int objnr;       objnr = obj_to_index(cachep, page, (void *)ptr);
        BUG_ON(objnr >= cachep->num);

        /* Find offset within object. */
        offset = ptr - index_to_obj(cachep, page, objnr) - obj_offset(cachep);

        /* Allow address range falling entirely within usercopy region. */
        if (offset >= cachep->useroffset &&
            offset - cachep->useroffset <= cachep->usersize &&
            n <= cachep->useroffset - offset + cachep->usersize)
                return;
        if (usercopy_fallback &&
            offset <= cachep->object_size &&
            n <= cachep->object_size - offset) {
                usercopy_warn("SLAB object", cachep->name, to_user, offset, n);
                return;
        }

        usercopy_abort("SLAB object", cachep->name, to_user, offset, n);
}
#endif /* CONFIG_HARDENED_USERCOPY */

