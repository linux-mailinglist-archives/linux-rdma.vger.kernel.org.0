Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6185628518A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFSWd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 14:22:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43644 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgJFSWd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 14:22:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id r10so1371167pgb.10
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 11:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJARDOshyT38zq3/ugz4Ao8VMxby11N49owkSr4XKmc=;
        b=AoWAx9CrSc8l5NE3O+2upIViEsEplbUEAKYOC+2UoCQNkeDU4+he8p1H21Lv6fdvXh
         WY1GfbjIXGFIcmqYSvflm6cjmtYkHmmCxXE2a/lLQMZT2R4cjVPn5MDxu2V29VkQIZuN
         meZsgda3RrCsNm4+YRhIfSkZzLbQF24wZ4QMmrRs3HJdmYV0ZGs1vgC5+xmHyaYkkWga
         6nHGqSj35aUdiIv7L+Tl/cQAII/j2QcLi96Lm8CYGS+rr1dQG3xwAuSuYg5llEIvuTCc
         Ae2lI5OHs1Z0zpRhtv1yL4p4ClntoMG2Hui0QM+XGiiTlV/Us0KIFu+5QRzVl6Kr6R9X
         ri4Q==
X-Gm-Message-State: AOAM533gv1GT6E4CYTFOByE9H1RL4VyHPqGccogiYNtQuVlBj5CIyyhI
        8DylGnG5+sPhx5rEBZ2oGJ0=
X-Google-Smtp-Source: ABdhPJx3yzlDbCst1t3p8ZfjHi4BcfOV0qRshYm77gyksE1vsgDTKz7K3ptup7Srf0v1vvlu7LveZA==
X-Received: by 2002:a63:2503:: with SMTP id l3mr5102946pgl.324.1602008550661;
        Tue, 06 Oct 2020 11:22:30 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z63sm4400054pfz.187.2020.10.06.11.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 11:22:29 -0700 (PDT)
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org> <20200923183409.GA9475@nvidia.com>
 <20200924054907.GA22045@infradead.org> <20200924114940.GE9475@nvidia.com>
 <f20a4639-7674-8d2c-66dc-ebc028b14ef0@acm.org>
 <20201006165346.GK4734@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <05c0f5fd-e1cd-0a02-8464-b18497b23341@acm.org>
Date:   Tue, 6 Oct 2020 11:22:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006165346.GK4734@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/6/20 9:53 AM, Jason Gunthorpe wrote:
> On Tue, Oct 06, 2020 at 07:29:16AM -0700, Bart Van Assche wrote:
>> On 9/24/20 4:49 AM, Jason Gunthorpe wrote:
>>> On Thu, Sep 24, 2020 at 06:49:07AM +0100, Christoph Hellwig wrote:
>>>>>>> +	} else {
>>>>>>> +		device->dev.dma_parms = dma_device->dma_parms;
>>>>>>>    		/*
>>>>>>> +		 * Auto setup the segment size if a DMA device was passed in.
>>>>>>> +		 * The PCI core sets the maximum segment size to 64 KB. Increase
>>>>>>> +		 * this parameter to 2 GB.
>>>>>>>    		 */
>>>>>>> +		dma_set_max_seg_size(dma_device, SZ_2G);
>>>>>>
>>>>>> You can't just inherity DMA properties like this this.  Please
>>>>>> fix all code that looks at the seg size to look at the DMA device.
>>>>>
>>>>> Inherit? This is overriding the PCI default of 64K to be 2G for RDMA
>>>>> devices.
>>>>
>>>> With inherit I mean the
>>>>
>>>> 		device->dev.dma_parms = dma_device->dma_parms;
>>>>
>>>> line, which is completely bogus.  All DMA mapping is done on the
>>>> dma_device in the RDMA core and ULPs, so it also can't have an effect.
>>>
>>> Oh. Yes, no idea why that is there..
>>>
>>> commit c9121262d57b8a3be4f08073546436ba0128ca6a
>>> Author: Bart Van Assche <bvanassche@acm.org>
>>> Date:   Fri Oct 25 15:58:30 2019 -0700
>>>
>>>       RDMA/core: Set DMA parameters correctly
>>>       The dma_set_max_seg_size() call in setup_dma_device() does not have any
>>>       effect since device->dev.dma_parms is NULL. Fix this by initializing
>>>       device->dev.dma_parms first.
>>>
>>> Bart?
>>
>> (just noticed this email)
>>
>> Hi Jason,
>>
>> That code may be a leftover from when the ib_dma_*() functions used &dev->dev as
>> their first argument instead of dev->dma_device.
> 
> Hmm the above was two years after the commit that added dma_device? I
> assumed you added this because you were doing testing with rxe?

Hi Jason,

In my previous email I was referring to the code that sets DMA parameters in 'device'.

The patch "RDMA/core: Set DMA parameters correctly" was the result of source reading
while I was chasing an unrelated rdma_rxe bug.

Bart.
