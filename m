Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B974E49FDDD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350013AbiA1QSt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 11:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350017AbiA1QSs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jan 2022 11:18:48 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A4AC061747
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jan 2022 08:18:47 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id q19-20020a056830441300b0059a54d66106so6245517otv.0
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jan 2022 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BbBrBkbC00p3a2mcPLycQ1gWAceCOl57umXlCuNH0YE=;
        b=X3RKsFSxQt2rmMBqvnNZXJOBqf9uQlM1MRUVBS9GIfMJrZb6hOo7WZYj7nOirlhtJq
         gV6UfW+6KILYi0E/SBCmwQ1xK7lArXUfhLRmcf/+X+jQNnwkhEtJqnK1gfLA30E/CitM
         A8XgkpuSbq94HeRXFGhyMcxATcsqDT6DkOATy//fPhWC2xDXv+hdJmo7nMijf3lb2/po
         ebXWWpSySIuhqs+nvIvkdGNwRNqqOntm1g8ABALhcMNjQWp3zLb4vGo4omsRLoWlyInb
         oBZ8cxszBB2+zPotB2fXBa/Am/XAsp+dl8CzYF1VdKg1IcJqHXD1k+p4fNoTi/ZVqiIW
         zqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BbBrBkbC00p3a2mcPLycQ1gWAceCOl57umXlCuNH0YE=;
        b=0cx9M61fkDU+815FXFcWgLq5bz4uGgT24gMx2YNJi71lhPP6cVyiPDpdYrLIkI6Lu4
         qZFS9I/mcsAfzQfcmeSe2e/+6d0rlBX06zsepGJsmHlkvHEnLRFVoqGqbreK9etmGz8y
         uDzfVECuXnZo0hV3Yc+nm+HcLbbKjt/0nkz9gQGpa23OV9im5ur8GEEhm/Uh0j1BJIYJ
         U4KzDCdzNfyh6ygiMKRxg2LnrtUB26uSBWM9cHrkA4gaAY/IM6ooaCDuu6xjHgekvPl1
         pRoHtX/U5fmf6NKUl8Q5SL50lFAlC9bEANc6rHI88Q9LSso2XE0BUw6uWST3NsFuY+fr
         Md7g==
X-Gm-Message-State: AOAM530iJgeDbKiDeOgJjZGGi/xZH8WGfb58AkXJ+cLGwhYH0LXS92tH
        RNoiwAwVxGAmlF0RSCz82WOrClAFdxU=
X-Google-Smtp-Source: ABdhPJw+NWYHatyNMxJxjkQ/n8Uwtcyuu8n/g9G1Ati96swtuv7oqSPf09yfeLS74BW0Nlwll8tOTA==
X-Received: by 2002:a9d:224e:: with SMTP id o72mr5278754ota.133.1643386727206;
        Fri, 28 Jan 2022 08:18:47 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id o144sm8406754ooo.25.2022.01.28.08.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 08:18:46 -0800 (PST)
Message-ID: <14f2d91e-729d-6be0-a2c7-0175db27d293@gmail.com>
Date:   Fri, 28 Jan 2022 10:18:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v9 04/26] RDMA/rxe: Enforce IBA o10-2.2.3
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-5-rpearsonhpe@gmail.com>
 <20220128125319.GC84788@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220128125319.GC84788@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/28/22 06:53, Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 03:37:33PM -0600, Bob Pearson wrote:
>> Add code to check if a QP is attached to one or more multicast groups
>> when destroy_qp is called and return an error if so.
> 
> The core code already does some of this anyhow..
> 
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> index 949784198d80..34e3c52f0b72 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> @@ -114,6 +114,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>>  	grp->num_qp++;
>>  	elem->qp = qp;
>>  	elem->grp = grp;
>> +	atomic_inc(&qp->mcg_num);
> 
> eg what prevents qp from being concurrently destroyed here?
> 
> The core code because it doesn't allow a multicast group to be added
> concurrently with destruction of a QP.
> 
>> +int rxe_qp_chk_destroy(struct rxe_qp *qp)
>> +{
>> +	/* See IBA o10-2.2.3
>> +	 * An attempt to destroy a QP while attached to a mcast group
>> +	 * will fail immediately.
>> +	 */
>> +	if (atomic_read(&qp->mcg_num)) {
>> +		pr_warn_once("Attempt to destroy QP while attached to multicast group\n");
>> +		return -EBUSY;
> 
> Don't print
> 
> But yes, I think drivers are expected to do this, though most likely
> this is already happening for other reasons and this is mearly
> protective against bugs.
> 
> Jason

The real reason for this patch becomes apparent in the next one or two. With this no longer an issue half the complexity of rxe_mcast goes away. I'll get rid of the print.
Personally I find them helpful when debugging user code. Maybe a pr_debug?

Bob
