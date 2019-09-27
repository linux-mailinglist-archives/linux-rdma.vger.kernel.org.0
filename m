Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D6C0A47
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 19:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfI0RYr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 13:24:47 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34885 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfI0RYr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 13:24:47 -0400
Received: by mail-pf1-f172.google.com with SMTP id 205so1977520pfw.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 10:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPOFKJ120+6ElptFEXuMyrzvICYAINVgbVeMx4PddyM=;
        b=pfe4g+jnVf/bqjOTyhV8MRGKigCnLVpAVcse8qEh7XwOZovNExPvUJB2AVHGMLun2f
         xP+nAwmPBNaAJaMK+lPgtbWe9Enp88FT429V8VenFZTUmA0Y2YFOo0UxXx/Gsx1OLRKe
         saYTvf2vJnn+e60DonHT9Vjp75DguPlIp7oZOLNE6CsCGrQ1WaC1laB6LA63LKNKzWWm
         QulrMEaWsBxTC/CCFQOu3Fa6HgBi+FRxsvsPQLnNfEYkyfAWYrjpN2S5914+jWhwyO00
         gXsDuH1V76ieaLfzW25NBgF6L/T6Bjt3PSWk1hMcXZ7ENeQM6/+4nFzSe56b9pJ9XxYt
         7A0Q==
X-Gm-Message-State: APjAAAWrNOJBL4DlX9PlTTwY4wIqwfL1OrLiZWui2nLDynfdwXlV+b5x
        QAcBqE6JO55cZvc60MhzKYYNvOA5
X-Google-Smtp-Source: APXvYqxGKZqZ444VLYU73I7ouV+z7ZPccP9n7W4ATmeLuwBzjHlktv9htL4J3q7vSXZ8u+R00QLgcw==
X-Received: by 2002:a63:1d0e:: with SMTP id d14mr10493759pgd.324.1569605085835;
        Fri, 27 Sep 2019 10:24:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f14sm3748840pfq.187.2019.09.27.10.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:24:45 -0700 (PDT)
Subject: Re: [patch v3 2/2] RDMA/srp: calculate max_it_iu_size if remote
 max_it_iu length available
To:     Honggang LI <honli@redhat.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20190919035032.31373-1-honli@redhat.com>
 <20190919035032.31373-2-honli@redhat.com>
 <c0ab625a-d029-37b4-753f-312e7877a6fc@acm.org>
 <20190923033339.GB8298@dhcp-128-227.nay.redhat.com>
 <0f2331d1-6a4a-6c30-6e53-9662c2a59708@acm.org>
 <20190927171814.GA13717@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <083088f9-e276-7221-5219-296ed7b7a94c@acm.org>
Date:   Fri, 27 Sep 2019 10:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927171814.GA13717@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/27/19 10:18 AM, Honggang LI wrote:
> On Mon, Sep 23, 2019 at 08:10:48AM -0700, Bart Van Assche wrote:
>> On 9/22/19 8:33 PM, Honggang LI wrote:
>>> On Fri, Sep 20, 2019 at 09:18:49AM -0700, Bart Van Assche wrote:
>>>> On 9/18/19 8:50 PM, Honggang LI wrote:
>>>>> The maximum initiator to target iu length can be get from the subnet
>>>>                                                      ^^^
>>>>                                            retrieved? obtained?
>>>
>>> OK, will replace it with 'retrieved'.
>>>
>>>>> manager, such as opensm and opafm. We should calculate the
>>>>     ^^^^^^^
>>>>
>>>> Are you sure that information comes from the subnet manager?
>>>> Isn't the LID passed to get_ioc_prof() in the srp_daemon the LID of the SRP
>>>> target?
>>>
>>> Yes, you are right. But srp_daemon/get_ioc_prof() send MAD packet
>>> to subnet manager to obtain the maximum initiator to target iu length.
>>   I do not agree that the maximum initiator to target IU length comes from
>> the subnet manager. This is how I think the srp_daemon works:
>> 1. The srp_daemon process sends a query to the subnet manager and asks
>>     the subnet manager to report all IB ports that support device
>>     management.
>> 2. The subnet manager sends back information about all ports that
>>     support device management (struct srp_sa_port_info_rec).
>> 3. The srp_daemon sends a query to the SRP target(s) to retrieve the
>>     IOUnitInfo (struct srp_dm_iou_info) and IOControllerProfile
>>     (struct srp_dm_ioc_prof). The maximum initiator to target IU length
>>     is present in that data structure (srp_dm_ioc_prof.send_size).
> 
> Yes, your description is more accurate.
> 
> [1] "The maximum initiator to target iu length can be retrieved from the subnet
> manager, such as opensm and opafm."
> 
> [2] "The maximum initiator to target iu length can be obtained by sending
> MAD packets to query subnet manager port and SRP target ports."
> 
> How about replacing sentence [1] with [2] in commit message?

[2] sounds a little bit confusing to me but I think we have already 
spent way too much time on discussing the commit message, so I'm fine 
with [2].

Bart.

