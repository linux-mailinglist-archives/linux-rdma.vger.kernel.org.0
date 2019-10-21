Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5EDF4E1
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfJUSKP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:10:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38567 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfJUSKP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 14:10:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so7009617plq.5
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 11:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oRbIskBaL1aL4BucIlvtGeeYDkL36JmkKgAYi6onRhg=;
        b=bSfSpdMt8PhyxV4OPUM9O/olzkHtae941iS4qugMeQ/S+W1sKsOwvIPFi/6WOYw76s
         Pk59olP6fkLr6iJkaROHcJWyGgQKU20XJro6svECjD50uwSErHr2Vf1z7nMDBqEgz9S2
         eOuXEIfj20H4rk1ugexddJb61LZE/bcLDf0bQHZQ/yBDGa2aBedCXrhJt2rof5fV0T9b
         2Qv+GUmdv05hxxZgGVDbAD1fP+vHPhu7J3fUXF4Hg26df/7bf+2Rdt89m7S5aMeuNQZA
         /YN6Egr29u0jME9Me0FZxBAF6dhaBkorr3w/xdRc97moJFteQ5EZKJAWGTJs2cPwOaPJ
         mcKA==
X-Gm-Message-State: APjAAAWqzD+0DfereonrsmDeSRcfzFIoubT3RnqBfd4CGZzTQ7HjckYX
        2f/oMksC9CkeEKU4qIwyGxw=
X-Google-Smtp-Source: APXvYqzho0RawTs2mNddceg4GlxVuBRcSZquvvA7zeEHbhLPzSRpKBJ+YWq6LSZ8qi0i3wdHaDo03g==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7mr25259248plb.181.1571681414742;
        Mon, 21 Oct 2019 11:10:14 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id j128sm18002698pfg.51.2019.10.21.11.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:10:13 -0700 (PDT)
Subject: Re: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
References: <20191021021030.1037-1-bvanassche@acm.org>
 <20191021021030.1037-3-bvanassche@acm.org> <20191021141039.GC25178@ziepe.ca>
 <61d89948-de40-5e6b-f368-353476292093@acm.org>
 <9DD61F30A802C4429A01CA4200E302A7B6B0D6EE@fmsmsx124.amr.corp.intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4d1fb001-ead8-81ce-893e-1ff94214c389@acm.org>
Date:   Mon, 21 Oct 2019 11:10:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7B6B0D6EE@fmsmsx124.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/19 10:44 AM, Saleem, Shiraz wrote:
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index a667636f74bf..a523d844ad9d 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1199,9 +1199,21 @@ static void setup_dma_device(struct ib_device *device)
>>    		WARN_ON_ONCE(!parent);
>>    		device->dma_device = parent;
>>    	}
>> -	/* Setup default max segment size for all IB devices */
>> -	dma_set_max_seg_size(device->dma_device, SZ_2G);
>>
>> +	if (!device->dev.dma_parms) {
>> +		if (parent) {
>> +			/*
>> +			 * The caller did not provide DMA parameters, so
>> +			 * 'parent' probably represents a PCI device. The PCI
>> +			 * core sets the maximum segment size to 64
>> +			 * KB. Increase this parameter to 2G.
>> +			 */
>> +			device->dev.dma_parms = parent->dma_parms;
>> +			dma_set_max_seg_size(device->dma_device, SZ_2G);
> 
> Did you mean dma_set_max_seg_size(&device->dev, SZ_2G)?

Have you realized that that call has the same effect as what I proposed 
since both devices share the dma_parms parameter?

> device->dma_device could be pointing to parent if the caller
> did not provide dma_ops. So wont this update the parent device
> dma params?

That's correct, this will update the parent device DMA parameters.

> Also do we want to ensure all callers device max_seg_sz
> params >= threshold (=2G)? If so, perhaps we can do something
> similar to vb2_dma_contig_set_max_seg_size()
> 
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/media/common/videobuf2/videobuf2-dma-contig.c#L734

It depends on what PCIe RDMA adapters support. If all PCIe RDMA adapters 
supported by the Linux kernel support max_segment_size >= 2G the above 
code is probably the easiest approach.

Thanks,

Bart.
