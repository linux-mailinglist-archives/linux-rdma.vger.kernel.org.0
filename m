Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1830284DA8
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJFO3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 10:29:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33688 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFO3W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 10:29:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id o25so8089209pgm.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 07:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eao464HHS1rqlZcfj/iQFeWSUysRZcdmgrZHsdAt3/0=;
        b=cJ7SzldxD1JOi6xjYLDP8irKczHaV/W7/UDK2tbda19VTAc0t4/zixpRLapZmeJKYV
         KzIl3/QM53fokueLItPm3SBPCcgQycbx+eEZrFQpFKqAm6ov4YOh3Ds+zgoyG55fYFBj
         AJaZ/7UF3U4iTEV2uEgZHH1c4XYZbIRmf8/4aDOj0gj9kqxUND/xcI0n8DBv209q/QWK
         XSveUDcyiH4w8DPNkr6c60NpxlIN0dgXmsg5pXUbHD68HrmrjZGRKimNQniUhoBuZvcq
         koKNeaID0ynLm4VXfYL0liZQK62NuP/ZOFlSVgeWKzohMl3DcJb2JzMwqotQXRDZOFm3
         nsTw==
X-Gm-Message-State: AOAM531IsWnGTMXk9Y2K19LqaNmNjZNEklEfrOWYgSWss9eQFsX43JM7
        0fOSzFxdULGT97C/DJpyiZY=
X-Google-Smtp-Source: ABdhPJzNyEJ2XXpw85y6YmyoRXyb5NBdj1lUSA7MU8oPpSl7xqPskEYj4fu0HSDNsBDNSOuIwpeJug==
X-Received: by 2002:a65:4ccd:: with SMTP id n13mr4459281pgt.268.1601994560360;
        Tue, 06 Oct 2020 07:29:20 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id v10sm2959768pjf.34.2020.10.06.07.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 07:29:19 -0700 (PDT)
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
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
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f20a4639-7674-8d2c-66dc-ebc028b14ef0@acm.org>
Date:   Tue, 6 Oct 2020 07:29:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924114940.GE9475@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/24/20 4:49 AM, Jason Gunthorpe wrote:
> On Thu, Sep 24, 2020 at 06:49:07AM +0100, Christoph Hellwig wrote:
>>>>> +	} else {
>>>>> +		device->dev.dma_parms = dma_device->dma_parms;
>>>>>   		/*
>>>>> +		 * Auto setup the segment size if a DMA device was passed in.
>>>>> +		 * The PCI core sets the maximum segment size to 64 KB. Increase
>>>>> +		 * this parameter to 2 GB.
>>>>>   		 */
>>>>> +		dma_set_max_seg_size(dma_device, SZ_2G);
>>>>
>>>> You can't just inherity DMA properties like this this.  Please
>>>> fix all code that looks at the seg size to look at the DMA device.
>>>
>>> Inherit? This is overriding the PCI default of 64K to be 2G for RDMA
>>> devices.
>>
>> With inherit I mean the
>>
>> 		device->dev.dma_parms = dma_device->dma_parms;
>>
>> line, which is completely bogus.  All DMA mapping is done on the
>> dma_device in the RDMA core and ULPs, so it also can't have an effect.
> 
> Oh. Yes, no idea why that is there..
> 
> commit c9121262d57b8a3be4f08073546436ba0128ca6a
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Fri Oct 25 15:58:30 2019 -0700
> 
>      RDMA/core: Set DMA parameters correctly
>      
>      The dma_set_max_seg_size() call in setup_dma_device() does not have any
>      effect since device->dev.dma_parms is NULL. Fix this by initializing
>      device->dev.dma_parms first.
> 
> Bart?

(just noticed this email)

Hi Jason,

That code may be a leftover from when the ib_dma_*() functions used &dev->dev as
their first argument instead of dev->dma_device. See also commit 0957c29f78af
("IB/core: Restore I/O MMU, s390 and powerpc support").

Bart.
