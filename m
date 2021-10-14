Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC542E26E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 22:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhJNUKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 16:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhJNUKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Oct 2021 16:10:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EFC061570
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 13:08:02 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so9797591otr.7
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1WR+0nmUj3Qa8GMe/hwrpTAeGUO67aqunzPdMbCMnzM=;
        b=PHDmz6DOyk9sNcPGm2+iooND9bHCBNDeT6IwD7J5AEwX1dKticyzRCmCnG6MnTnBoy
         //PgsOCR+03cGefeV4v30qOBycA6I7puwoEkpGyX+xZd+13GKwZ2UXQSKcE+7297/Qfe
         gwqg6P1tM8rNNKd5QR3+e85qBgW3abnPP4sMcoQAVYcmwXR2cdSkcKaPNrWwH2iqnoSi
         f6IPUCFk8pjX9hshF0Mly2k/mLqDMuRkSnyWMsibnBwb3AdppDP9r3Jdk5HD/KpPzcgU
         Tu69Vw21PIoKqH+AUie1udlWpJkR/3DdKIc972lX7V6ue9AhrlChm+Xa9rF0zJJU1qs5
         tAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1WR+0nmUj3Qa8GMe/hwrpTAeGUO67aqunzPdMbCMnzM=;
        b=n2Vv2vJe8NoQxRiLRbssx73pVKT18UtofFlSCyzxajym8+bE5bwafnar1rQ8/qW/FN
         eDHm+fd30sAIQ00+A3kouF/mv0anZv4km9Q8l0TeZbPrZ5nX8uphSyn8AVk44SmA9xYw
         0AvXvkiV3K5vwL4prukwkNbfqGQGk6K1BOsN68bKZb4HsQwZonnSCJdxskaRkKufOsOe
         901MCRRGWNrMQUwUPavEgLzPBc1Vp1f5ja8D0AJD41GaPcJujdEEhuHHkzuXo64yggJp
         D9l5mOInvieK6cFcog9ew7EHonmcQD07z8EhbjYHcexLkS9PnabzviZdFkqnvFNPg7AK
         ZYdA==
X-Gm-Message-State: AOAM530QEq2y2DR0HALOQ2vWJF7nqRAgLP+ocq/w6MaRv97hE6kqumzE
        wK6iOWzIuEv7gfpZpl7IrLFb1kJL+Is=
X-Google-Smtp-Source: ABdhPJzslkuXnqRBf+cA/3IATw2edaojz/dj97CvorWq7VrzgCMSL364wMX2HkBTwVBckI+XFH39zQ==
X-Received: by 2002:a05:6830:4428:: with SMTP id q40mr3432557otv.184.1634242082170;
        Thu, 14 Oct 2021 13:08:02 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:35f7:7ac2:d6d9:8195? (2603-8081-140c-1a00-35f7-7ac2-d6d9-8195.res6.spectrum.com. [2603:8081:140c:1a00:35f7:7ac2:d6d9:8195])
        by smtp.gmail.com with ESMTPSA id f10sm811766otc.26.2021.10.14.13.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 13:08:01 -0700 (PDT)
Subject: Re: Bad behavior by rdma-core ?
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <414e99de-9b1b-edcc-4547-f8002adecd69@gmail.com>
 <3bda5d0b-dc04-7640-b832-867858ef7a12@gmail.com>
 <20211014183235.GX2744544@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <d1833db1-541e-1cfd-27fd-9a83df098000@gmail.com>
Date:   Thu, 14 Oct 2021 15:08:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014183235.GX2744544@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/14/21 1:32 PM, Jason Gunthorpe wrote:
> On Thu, Oct 14, 2021 at 11:14:57AM -0500, Bob Pearson wrote:
> 
>> But ib_uverbs_destroy_ah does *not* call rdma_uverbs_destroy_ah() it just
>> deletes the object.
> 
> ib_uverbs_destroy_ah
>  uobj_perform_destroy
>   __uobj_perform_destroy
>    __uobj_get_destroy
>     uobj_destroy
>      uverbs_destroy_uobject:
> 
>     	} else if (uobj->object) {
> 		ret = uobj->uapi_object->type_class->destroy_hw(uobj, reason,
> 								attrs);
> 
> Which calls 
> 
> destroy_hw_idr_uobject
>   	int ret = idr_type->destroy_object(uobj, why, attrs);
> 
> Which links to this:
> 
> DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_AH,
> 			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_ah),
> 			    &UVERBS_METHOD(UVERBS_METHOD_AH_DESTROY));
> 
> And thus calls
> 
> static int uverbs_free_ah(struct ib_uobject *uobject,
> 			  enum rdma_remove_reason why,
> 			  struct uverbs_attr_bundle *attrs)
> {
> 	return rdma_destroy_ah_user((struct ib_ah *)uobject->object,
> 				    RDMA_DESTROY_AH_SLEEPABLE,
> 				    &attrs->driver_udata);
> }
> 
> So, look along that path and find out where it goes wrong?
> 
> Jason
> 
Thanks

I had more or less figured that out. I looked at other objects and saw a similar pattern.
I think I've traced the problem back to myself.

Bob
