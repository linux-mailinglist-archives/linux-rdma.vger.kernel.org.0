Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC125CCAD
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgICVtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 17:49:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33877 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgICVtW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 17:49:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10so4785338wrv.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 14:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dy3NVf0ffkm+2anZcbOc6+dQ4j5x4uv4m/OjW/3l/Dc=;
        b=aolFdzJ7OSGufGJK7AeIKRSBlGnhVLJ9/Hf9zxsaxqwJgHM2xJ34uTvYghx3aWJLx7
         /tCVzKepX4BEWxP7PCAfMUdZSnsuPF6UXPu4dRf63h08bMYSVazaZp/VWfSMAQLBwnHL
         HJ5hVBUNVdrWa+d0FUJxjQEKNnTWy+ovUK6I4ueNGg9OuPZejwCbbYHIVnm/EhBn0+CF
         CKMVmIci0rb5T5zvKdHNzslxUFQA9zW8VAun4yUdqamr2bybLycLabYNWENcNnbo/zZJ
         ezWCVeJYAY7i3Bbq8TIubVagNYBO2AVOEfPs3zrhah0lZQ9EP2iqIUAPVYtJ/2Yw3Jrp
         /y3A==
X-Gm-Message-State: AOAM532sxHEx/Tn/KBuQJRQ4hARj/1Gfi+EEeILygsmTLRvWqR4G6C0V
        1KxWobEBN5kLoDhSqkfMrzhVLiN5/S62qw==
X-Google-Smtp-Source: ABdhPJyyql/eiE9IYbdFeeMKhvk7nd4n+mWu8VgXd0Aa3E9lntK7mL50JCAaQMFZbrH670fGQpVGTw==
X-Received: by 2002:adf:f885:: with SMTP id u5mr3280205wrp.382.1599169759804;
        Thu, 03 Sep 2020 14:49:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:79a5:e112:bd7c:4b29? ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id q15sm7392768wrr.8.2020.09.03.14.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 14:49:19 -0700 (PDT)
Subject: Re: [PATCH v2] IB/isert: fix unaligned immediate-data handling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
References: <20200901030826.140880-1-sagi@grimberg.me>
 <20200903055814.GB31262@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d92031bd-cc66-ff7a-9e23-51fa7b61385b@grimberg.me>
Date:   Thu, 3 Sep 2020 14:49:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903055814.GB31262@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Currently we allocate rx buffers in a single contiguous buffers for
>> headers (iser and iscsi) and data trailer. This means that most likely
>> the data starting offset is aligned to 76 bytes (size of both headers).
>>
>> This worked fine for years, but at some point this broke, resulting in
>> data corruptions in isert when a command comes with immediate data
>> and the underlying backend device assumes 512 bytes buffer alignment.
>>
>> We assume a hard-requirement for all direct I/O buffers to be 512 bytes
>> aligned. To fix this, we should avoid passing unaligned buffers for I/O.
>>
>> Instead, we allocate our recv buffers with some extra space such that we
>> can have the data portion align to 512 byte boundary. This also means
>> that we cannot reference headers or data using structure but rather
>> accessors (as they may move based on alignment). Also, get rid of the
>> wrong __packed annotation from iser_rx_desc as this has only harmful
>> effects (not aligned to anything).
>>
>> This affects the rx descriptors for iscsi login and data plane.
>>
>> Reported-by: Stephen Rust <srust@blockbridge.com>
>> Tested-by: Doug Dumitru <doug@dumitru.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Changes from v1:
>> - revised change log
>>
>>   drivers/infiniband/ulp/isert/ib_isert.c | 93 +++++++++++++------------
>>   drivers/infiniband/ulp/isert/ib_isert.h | 41 ++++++++---
>>   2 files changed, 79 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
>> index 61e2f7fc513d..5b6a0ad9faaa 100644
>> --- a/drivers/infiniband/ulp/isert/ib_isert.c
>> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
>> @@ -140,15 +140,16 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
>>   	rx_desc = isert_conn->rx_descs;
>>   
>>   	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
>> -		dma_addr = ib_dma_map_single(ib_dev, (void *)rx_desc,
>> -					ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
>> +		dma_addr = ib_dma_map_single(ib_dev,
>> +					rx_desc->buf,
> 
> Nit: no real need to the line break here.

Will fix.

> 
>> +	ib_dma_unmap_single(ib_dev, isert_conn->login_desc->dma_addr,
>> +			    ISER_RX_SIZE,
>>   			    DMA_FROM_DEVICE);
> 
> Same here.
> 
>> + * RX size is default of 8k plus headers, but data needs to align to
>> + * 512 boundary, so use 1024 to have the extra space for alignment.
>> + */
>> +#define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)
> 
> A 512 byte alignment is not the correct for e.g. the 4k Xen block
> device case.  Any reason we don't just separate allocations for headers
> vs the data and use another ib_sge?

We cannot guarantee the header size is fixed with a variable size cdbs,
and we don't have header padding support in iscsi/iser.
