Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE46292550
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 15:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfHSNk2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 09:40:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32813 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfHSNk1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 09:40:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so1902875qtb.0
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=INf+VFKPO2m565domq567dUmdkVMV4jYkBmZ6kOEpU0=;
        b=YIyIgjOb3pKvTEN1GMZCmS5LYoVmHsVI/Y2JSBh38AsApHstCbQ17Dy1MIdtKH05EA
         uACvTA0J9AWf5S6ZPQUhtEYyiGIS9uFZFIz60GsmYMa+9gR0ArwbESXAKQmTXAA7yH5Q
         PUkqhWcinCOOQTdZDqr1bnyAVkkZoN+qbUxBkMOBPliRK5kRwjyUnz8K5diroNbZ9tQb
         UfxY4XG3eSkWt2jjh/dln4qHopYLR/hhzqQxWH0iTQReszPovYHoJGkQuO1i2MOp4Bg8
         lq0g+KqQgjWMLmH/nxyj2t6JbTqYB8l9TQVue1KVcM+b9aYoS2w3q5iPc+NUf6u7x/KY
         axsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=INf+VFKPO2m565domq567dUmdkVMV4jYkBmZ6kOEpU0=;
        b=EL6nRpTHE8vwuBD1DX6rwIJ6dKuUkQ7Gnd5+AT8NgqbRJPmzQBm8KfYdyveHDXKsiK
         WKH2VOvsvH2ZAfqZQitIu0s1TqLiYMUrmGMfU+bH7xMmGjT1zaqsJXHzjMt3ESH4U/n9
         NcgR53c5QQgVVEfvEKkLNYCP8s0TcpdoRUnvBtMsWPNw/Xctozg8lohVv76093vpStbf
         7hZjx3VczgeaIbePTe7U5hEasIODk/ctJxp2fD1X9WMBfny+ldRa7qZIYrMRD0C2aTZd
         /gZ/7IfV+o5h42/202dsA/SMsH6pkSqYmssn74b15iytHxcPrd7+8ZY0RGoHP1u+ITBM
         VNzQ==
X-Gm-Message-State: APjAAAWkXl/44PXtaf1zQvMlqV0uHPuh7yxfGgiYDrSQRmtEOohgNRez
        zxfBh3gkWQUM6i2HPzGsSxUh/UGcdXA=
X-Google-Smtp-Source: APXvYqy+cqQ3+i2AiHz/cPCRnMz3wdoUop01JfTokd0AI1uCpwemT9543vfHRXhVn30lcg6JXJknrw==
X-Received: by 2002:a0c:b92c:: with SMTP id u44mr10151328qvf.146.1566222026756;
        Mon, 19 Aug 2019 06:40:26 -0700 (PDT)
Received: from [192.168.1.119] (c-67-189-171-39.hsd1.ma.comcast.net. [67.189.171.39])
        by smtp.googlemail.com with ESMTPSA id 6sm8129956qtu.15.2019.08.19.06.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 06:40:25 -0700 (PDT)
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hal Rosenstock <hal@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
From:   Hal Rosenstock <hal@dev.mellanox.co.il>
Message-ID: <c8bf9c9e-6f4b-b3f3-2c12-72fab52f6a05@dev.mellanox.co.il>
Date:   Mon, 19 Aug 2019 09:40:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819122126.GA6509@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/19/2019 8:21 AM, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2019 at 08:15:07AM -0700, Bart Van Assche wrote:
>> The ib_srpt driver derives its default service GUID from the node GUID
>> of the first encountered HCA. Since that service GUID is passed to
>> ib_cm_listen(), the AGN bits must not be set. Since the AGN bits can
>> be set in the node GUID of RoCE HCAs, filter these bits out. This
>> patch avoids that loading the ib_srpt driver fails as follows for the
>> hns driver:
>>
>>   ib_srpt srpt_add_one(hns_0) failed.
>>
>> Cc: oulijun <oulijun@huawei.com>
>> Reported-by: oulijun <oulijun@huawei.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index e25c70a56be6..114bf8d6c82b 100644
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>>  	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
>>  
>>  	if (!srpt_service_guid)
>> -		srpt_service_guid = be64_to_cpu(device->node_guid);
>> +		srpt_service_guid = be64_to_cpu(device->node_guid) &
>> +			~IB_SERVICE_ID_AGN_MASK;
> 
> This seems kind of sketchy, masking bits in the GUID is going to make
> it non-unique.. Should we do this only for roce or something?
> 
> Hal, do you have any insight?

include/rdma/ib_cm.h:#define IB_SERVICE_ID_AGN_MASK
cpu_to_be64(0xFF00000000000000ULL)

IB_SERVICE_ID_AGN_MASK masks entire first byte of OUI which seems like
too much to me as it contains company related bits.

Would it work just masking the first 2 bits (local/global and X bits) ?

-- Hal

> Jason
> 
