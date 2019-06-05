Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CAA36782
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFEWb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:31:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40887 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfFEWb2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 18:31:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so205413oie.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 15:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z2lOXoT7yh/PseXP+bBPFiPTASL9dhuVpJLazAu5Hdk=;
        b=E/I00hW2kLhP3mHwzpaD9DMg4mLARJzCifSpBrCFALDIBm4ZncdV2Q6lIvx2cozOlI
         7uRlETw1gdeSUZag4I0LQk1bYPOpTVxoHDo4yjdiUG6R60fpzrau+76Yh9/NOemuF+Vc
         Scsqzg8CAw/y3kUg9fuKjqzV5sZvZn4izg8bOlLGhH71dSdmUCAxrfxpvhVZTwYAKZNJ
         vROnAWCMqpuC8JSM8CDW3BA97sPL3jp7jJNXy4+PjGKl14ZjEsBJgmul/hw/AZelmX7N
         a2z6t7gqkHoTed9gdL2PNNgm5T7uCo3uma4ln4Vr+dlf56RQ1cvoEJ/7gy5U+4lbtSA4
         vjdQ==
X-Gm-Message-State: APjAAAVIsrvkun0iZtNMoWzvtZxP738s2gMpCpf1/9yR8XvilIC8C6CP
        YXOowwwzxBXpPPsvQji6IRw=
X-Google-Smtp-Source: APXvYqwE+xdjQClOHp/KEgai74UdwSOzEkvtG1OHMdpzzeRO3NoBmjXWkjdPkv30VAYZY3b8prXI2g==
X-Received: by 2002:aca:3485:: with SMTP id b127mr7871287oia.86.1559773887975;
        Wed, 05 Jun 2019 15:31:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id k25sm7856601otj.47.2019.06.05.15.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:31:27 -0700 (PDT)
Subject: Re: [PATCH 04/20] RDMA/core: Introduce ib_map_mr_sg_pi to map
 data/protection sgl's
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-5-git-send-email-maxg@mellanox.com>
 <b9c0f67c-e690-b6db-b326-2c76cfcab7b9@grimberg.me>
 <0d18b282-3950-44f9-c0cd-50c0a87df301@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <25ae4114-2ea6-6c2e-f6f9-e476dc56cf87@grimberg.me>
Date:   Wed, 5 Jun 2019 15:31:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0d18b282-3950-44f9-c0cd-50c0a87df301@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> +/**
>>> + * ib_map_mr_sg_pi() - Map the dma mapped SG lists for PI (protection
>>> + *     information) and set an appropriate memory region for 
>>> registration.
>>> + * @mr:             memory region
>>> + * @data_sg:        dma mapped scatterlist for data
>>> + * @data_sg_nents:  number of entries in data_sg
>>> + * @data_sg_offset: offset in bytes into data_sg
>>> + * @meta_sg:        dma mapped scatterlist for metadata
>>> + * @meta_sg_nents:  number of entries in meta_sg
>>> + * @meta_sg_offset: offset in bytes into meta_sg
>>> + * @page_size:      page vector desired page size
>>> + *
>>> + * Constraints:
>>> + * - The MR must be allocated with type IB_MR_TYPE_INTEGRITY.
>>> + *
>>> + * Returns the number of sg elements that were mapped to the memory 
>>> region.
>>
>> Question, is it possible that all data sges were mapped but not all
>> meta sges? Given that there is a non-trivial accounting on the relations
>> between data and meta sges maybe the return value should be
>> success/failure?
> 
> if data_sges will be mapped but not all meta_sges then the check of 
> return value n == data_nents + meta_nents will fail.

That check is in the ulp, the API preferably should not assume that the
ulp will do that and not try to map the remaining sges with a different
mr as it is much less trivial to do than the normal mr mapping.

That's why I suggest to return success/fail and not the number of
SG elems that were mapped.

> I don't understand the concern here.
> 
> Can you give an example ?

In case your max nents for data+meta is 16 but you get data_sg=15
and meta_sg=2, its not that if you map 15+1 you can trivially continue
from that point.

>> Or, if this cannot happen we need to describe why here.
> 
> failures can always happen :)

Yes, but what I was referring to is the difference between the normal
mr_map_sg and the mr_map_sg_pi. srp for example actually uses the
continuation of the number of mapped sg returned, it cannot do the
same with the pi version.
