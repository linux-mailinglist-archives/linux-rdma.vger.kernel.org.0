Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FC46DF59
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 01:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhLIAT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 19:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhLIATz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 19:19:55 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD0C061746
        for <linux-rdma@vger.kernel.org>; Wed,  8 Dec 2021 16:16:23 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t23so6457059oiw.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 Dec 2021 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xswA+J/MBsy8LIWpJjUVs19wVZSemrxevGM1M64YiuY=;
        b=QepzbXjQCq9hOl0GVgryyaebhPuDoaj74ZJxUm/TwxI8QqJCRecEQvkEtmPHryaT0I
         s7td787fkhObVvNEv29PZ4UHokp4aLcgVNCTgGMvUgly/1Q2xpmvCCFJSuqEkvcGN2qh
         UwZ4Blhb+Qn2dZSRjxMV0dGv1rwbJQ1Aq3+8+lzVH6oO/9zGF84B6r9uFYHIozNVSv5H
         4mX8B6POAxWRwAiDiBODz1l6a+3qcwUthC229StLWgGqE+yXqigef5C7wkvDKFYpnvqA
         sVdjkDkOIm8zigUyUVr/cWZNiPVFpo3eepdfm/Q1veOd5S2Vt65TsSrxCKEbAS2cu9A8
         cggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xswA+J/MBsy8LIWpJjUVs19wVZSemrxevGM1M64YiuY=;
        b=5W65MMRTFMb0qP6wP/Gkrq/DkPjmyk0vuTP7O/g8SryuRIET0ue+SFPiD0urG0Dh+C
         sAd2vCW7j3uJ3uN4l0gf1oxNrWvF8Vf0OxBaP+zOOmKXSG0ifSFck0hCVl78k1VxAKY4
         bf4Dg0NgV6AykwTLY5WEEuZKcg1fnfZfada0Fu3edj+WDEFuYzeAYHLfN8tRxIKaspHD
         X87taBzL0eDPs4o7X1Qtp1YjiDXaNqwGMTb5LE8h470lQVIuvG4aBIcr0q0MzhMNEdl5
         ANhst02TPMIm57+ckVPJlhvZmnS4LK78H/1frUEagOhL08ugaJQfRNfN3FE1SgCyk+wU
         d5VA==
X-Gm-Message-State: AOAM533zgxn/MJ6ouW7yUWQ7yI/nzHIzBdDE8Z1Vby1lIvtgh7YaE21b
        ka5aGghrXCD9Cyp/GALtiiG6dqm+830=
X-Google-Smtp-Source: ABdhPJw2W2icX33xyGm117CLFZty8/n7CIB0SECAOoKsXFuUATtJy5iVP5rL805JtFr3Rmp5ter8sg==
X-Received: by 2002:a54:4614:: with SMTP id p20mr2924170oip.39.1639008982581;
        Wed, 08 Dec 2021 16:16:22 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:6c59:bf97:7747:3006? (2603-8081-140c-1a00-6c59-bf97-7747-3006.res6.spectrum.com. [2603:8081:140c:1a00:6c59:bf97:7747:3006])
        by smtp.gmail.com with ESMTPSA id y28sm909281oix.57.2021.12.08.16.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 16:16:22 -0800 (PST)
Message-ID: <dc322ec4-bbcc-77eb-0c84-5461d08c5378@gmail.com>
Date:   Wed, 8 Dec 2021 18:16:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH for-next v6 1/8] RDMA/rxe: Replace RB tree by xarray for
 indexes
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
 <20211206211242.15528-2-rpearsonhpe@gmail.com>
 <20211207190947.GH6385@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20211207190947.GH6385@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/7/21 13:09, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 03:12:36PM -0600, Bob Pearson wrote:
>>  	if (pool->flags & RXE_POOL_INDEX) {
>> -		pool->index.tree = RB_ROOT;
>> -		err = rxe_pool_init_index(pool, info->max_index,
>> -					  info->min_index);
>> -		if (err)
>> -			goto out;
>> +		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
>> +		pool->xarray.limit.max = info->max_index;
>> +		pool->xarray.limit.min = info->min_index;
>> +	} else {
>> +		/* if pool not indexed just use xa spin_lock */
>> +		spin_lock_init(&pool->xarray.xa.xa_lock);
> 
> xarray's don't cost anything to init, so there is no reason to do
> something like this.
OK
> 
>> +/* drop a reference to an object */
>> +static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
>> +{
>> +	bool ret;
>> +
>> +	rxe_pool_lock_bh(elem->pool);
>> +	ret = kref_put(&elem->ref_cnt, rxe_elem_release);
>> +	rxe_pool_unlock_bh(elem->pool);
> 
> This is a bit strange, why does something need to hold a lock around a
> kref?

This also relates to your comment on 8/8 patch. There seems to be a race opportunity
between the call to kref_put(&obj->elem, rxe_elem_release) and the call in
rxe_elem_release() to xa_erase(). If a duplicate or delayed packet arrives after the the
final kref_put() and before the xa_erase() one can still lookup the object from its index
(qpn, rkey, etc.) and take a reference to it. The use of kref_get_unless_zero and
locking around kref_put and __xa_erase was an attempt to fix this. Once you call kref_put
with the ref count going to zero there is no way to prevent the object getting its
cleanup routine called.

Bob

> Jason
> 

