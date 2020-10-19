Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232EA292E29
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Oct 2020 21:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgJSTGl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbgJSTGl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Oct 2020 15:06:41 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D02C0613CE
        for <linux-rdma@vger.kernel.org>; Mon, 19 Oct 2020 12:06:41 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l85so1108315oih.10
        for <linux-rdma@vger.kernel.org>; Mon, 19 Oct 2020 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cnbv3SgE0nvi+Ik4GaN4gNNhMzQnDfvewQ2iJltTjWM=;
        b=oMjZeRdy1O0K3AwT/qYzNtP9kh5yvLfFTfsp5cYk3uYHovLTe0vaRo4NrVuHfjhDZw
         V4N26jHZz/RqApyFrFC4ldUNVMAhKWZOSSPNDNAG8WiLYlbt/xOkl7WiiDAtDcQQhXV+
         FY/TKb9Y5dMFfpG3CMpM0YSJ0pC0Q/bkUeyxhDtpzgZKLAacdIvPt88J/hAnWJKK04T1
         6dEpACWmxDoB1TEzUGO63Oq94MqXuY9RL2UymAh+6rlwzpBWeWEvWO0HafxjrrTUVTF2
         51qfAtWUC+R7RQH8Ah+JsVObAVkUbWpNgxqfpa2hIAGlcPT5D9d2Py+WNO1l6Kj82H2Y
         xiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cnbv3SgE0nvi+Ik4GaN4gNNhMzQnDfvewQ2iJltTjWM=;
        b=LhA1QZ47+QK1HUJ3VkXi7WT+nbHnzFlHiYdbHWw5ecKUICm02jlzkSe4cx+L6pt6oT
         lCLf3Kg4/NjIuuUig4dio0qTXnn9gpYkkBhuLljTft1q5L+NaEYQ+oruVrPMOeEop6c5
         V7b8tquPe7ExtPV1ex2YnhTWL6DC1su9gT0TglGrmhRwnVv9RRzJq+LRCxgqzd+p5dDm
         vtMP/4Xpxw6B5xqp7tuQZTt8R1SHyeZNgow6iz1ibAz4orBWIe2/fOBtkvlfvaXKHJ2a
         VZr1GrijzRliL+f/SNuKVXyUu8Yxm0+WWmbZjAdx8ou2elc1E8412TwU4gCY9sZY++Ua
         0Nqg==
X-Gm-Message-State: AOAM533pnqLoyzTTrDwuI+GY79Y5QLn/AylcxEPHvxWtIe9JgU6cQaqE
        H17HZCojnKMF4pUyqdOZPThvhbmB/bg=
X-Google-Smtp-Source: ABdhPJxMY0jwIu3M1xx3ESf6EX2zyfYcNSWWBHyR/aprvWQF8O/jGQWpU6jIydbx4UpQV0Ix1/hlaQ==
X-Received: by 2002:aca:1e09:: with SMTP id m9mr631714oic.60.1603134400586;
        Mon, 19 Oct 2020 12:06:40 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3241:1c4f:8926:de8b? (2603-8081-140c-1a00-3241-1c4f-8926-de8b.res6.spectrum.com. [2603:8081:140c:1a00:3241:1c4f:8926:de8b])
        by smtp.gmail.com with ESMTPSA id 7sm169411ois.3.2020.10.19.12.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 12:06:40 -0700 (PDT)
Subject: Re: [PATCH RFC] rdma_rxe: Stop passing AV from user space
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Bob Pearson <rpearson@hpe.com>
References: <20201016170147.11016-1-rpearson@hpe.com>
 <20201019185348.GZ6219@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <c8e69967-12aa-6f8e-18c5-96fbd9f1dc2b@gmail.com>
Date:   Mon, 19 Oct 2020 14:06:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019185348.GZ6219@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/19/20 1:53 PM, Jason Gunthorpe wrote:
> On Fri, Oct 16, 2020 at 12:01:48PM -0500, Bob Pearson wrote:
>>  
>> +static struct ib_ah *get_ah_from_handle(struct rxe_qp *qp, u32 handle)
>> +{
>> +	struct ib_uverbs_file *ufile;
>> +	struct uverbs_api *uapi;
>> +	const struct uverbs_api_object *type;
>> +	struct ib_uobject *uobj;
>> +
>> +	ufile = qp->ibqp.uobject->uevent.uobject.ufile;
>> +	uapi = ufile->device->uapi;
>> +	type = uapi_get_object(uapi, UVERBS_OBJECT_AH);
>> +	if (IS_ERR(type))
>> +		return NULL;
>> +	uobj = rdma_lookup_get_uobject(type, ufile, (s64)handle,
>> +				       UVERBS_LOOKUP_READ, NULL);
>> +	if (IS_ERR(uobj)) {
>> +		pr_warn("unable to lookup ah handle\n");
>> +		return NULL;
>> +	}
>> +
>> +	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_READ);
> 
> It can't be put and then return the data pointer, it is a use after free:
> 
>> +	return uobj->object;
> 
>> @@ -562,11 +563,6 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>>  
>>  	init_send_wr(qp, &wqe->wr, ibwr);
>>  
>> -	if (qp_type(qp) == IB_QPT_UD ||
>> -	    qp_type(qp) == IB_QPT_SMI ||
>> -	    qp_type(qp) == IB_QPT_GSI)
>> -		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
> 
> It needs some kind of negotiated compat, can't just break userspace
> like this
> 
> Jason
> 

1st point. I get it. uobj->object contains the address of one of the ib_xxx verbs objects.
Normally the driver never looks at this level but presumably has a kref on that object so it makes
sense to look it up. Perhaps better would be:

	void *object;

	...

	uobj = rdma_lookup_get_uobject(...);

	object = uobj->object;

	rdma_lookup_put_uobject(...);

	return (struct ib_ah *)object;

Here the caller has created the ib_ah but has not yet destroyed it so it must hold a kref on it.


2nd point. I also get. This suggestion imagines that there will come a day when we can change the user API.
May be a rare day but must happen occasionally. The current design is just plain wrong and needs to get fixed
eventually.

Thanks for looking at this.

Bob
