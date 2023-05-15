Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CDF703D88
	for <lists+linux-rdma@lfdr.de>; Mon, 15 May 2023 21:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbjEOTQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 15:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbjEOTQX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 15:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C30183D4
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684178060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NyqukO6Ya/VIHIhNAkh6hDQgz9DKtcV+p+OFb9aF6Xg=;
        b=V4nMfZCsBYPuCYSJwVBgotsu03z7TSd+z9oMz+sO9O7tiX2JeSWvyrUBzvr3Y//1qNkQWm
        dJeHl1bXgU6dKpDmxW/TQyElqiLe1oL81KooLqwKO3avjglszr3L/PwPW1zu6RtZwNTk+K
        pD05zi3DsM8Ujw9Uoqf6bRrlW2ZOBnM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-QHyYlCNQP5amO-qwNr9YwA-1; Mon, 15 May 2023 15:14:18 -0400
X-MC-Unique: QHyYlCNQP5amO-qwNr9YwA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7578369dff3so11587585a.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 12:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178058; x=1686770058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyqukO6Ya/VIHIhNAkh6hDQgz9DKtcV+p+OFb9aF6Xg=;
        b=Ac2ZmxDkAv68BTBPGrhDrxDdRBbvT6GE7qInZ/lA4IFGX2WUmgXADTwVw8gBG5vUqM
         1wrsldm7vRgWvCAzhUV/O5P3szYjC6c90/XloD6AKLEewT+/1lJCtZbD3uW01vsG5dSP
         WiezBRMgOuNSUpt8ss/CSDbEvVPcqXI5zalXnKBMtFBIDnXCW7KZFx+jPMrtL1XgECrX
         nqBe5HgkcAeIc64I5Zqlftm7wdO+oJF7GAc1lf1nC55J7utSOGk4we1NKhrHEUVz/z+a
         9WOC6wYU3k3kCMd0ThnPBLlaoDqnja2OzQF5HdyrM6ad2EF6SMelBUH+njA0gKTfq5sA
         q5XQ==
X-Gm-Message-State: AC+VfDzlMRxmrGazbBevCXtSh3xgu7PErZiYqcgG+fIdeneCyv6sfXxI
        MNEoxhOD1W4wS6N54o89SuRIwLTO8ZymXqC/TAShBp2qE6WQ8r60L/fYGq63pZbKbR6yhx8qDA5
        FyRP2N5ccc5Ip1WQLyDeCPCsPB4RAgw==
X-Received: by 2002:ac8:5751:0:b0:3f4:f210:50ba with SMTP id 17-20020ac85751000000b003f4f21050bamr24433448qtx.9.1684178057881;
        Mon, 15 May 2023 12:14:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ652dAnfE8u/aOPgD3sY/fHXwCSvcXvnZeDe0uEmAnBff1150omvDJN8LA/421vGerHWCdaNQ==
X-Received: by 2002:ac8:5751:0:b0:3f4:f210:50ba with SMTP id 17-20020ac85751000000b003f4f21050bamr24433413qtx.9.1684178057593;
        Mon, 15 May 2023 12:14:17 -0700 (PDT)
Received: from [192.168.2.101] (bras-base-toroon01zb3-grc-50-142-115-133-205.dsl.bell.ca. [142.115.133.205])
        by smtp.gmail.com with ESMTPSA id bq6-20020a05622a1c0600b003f4fa14decbsm2952763qtb.52.2023.05.15.12.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 12:14:17 -0700 (PDT)
Message-ID: <0abc56d7-7b14-702f-a974-f18b69103ed0@redhat.com>
Date:   Mon, 15 May 2023 15:14:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] RDMA/iRDMA: Return void from irdma_init_iw_device()
Content-Language: en-US
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230509145127.33734-1-kheib@redhat.com>
 <20230509145127.33734-2-kheib@redhat.com>
 <MWHPR11MB0029473794101834A57328A6E9779@MWHPR11MB0029.namprd11.prod.outlook.com>
From:   Kamal Heib <kheib@redhat.com>
In-Reply-To: <MWHPR11MB0029473794101834A57328A6E9779@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023-05-10 10:48, Saleem, Shiraz wrote:
>> Subject: [PATCH 1/3] RDMA/iRDMA: Return void from irdma_init_iw_device()
>>
>> The return value from irdma_init_iw_device() is always 0 - change it to be void.
>>
>> Signed-off-by: Kamal Heib <kheib@redhat.com>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index ab5cdf782785..b405cc961187 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -4515,7 +4515,7 @@ static void irdma_init_roce_device(struct irdma_device
>> *iwdev)
>>    * irdma_init_iw_device - initialization of iwarp rdma device
>>    * @iwdev: irdma device
>>    */
>> -static int irdma_init_iw_device(struct irdma_device *iwdev)
>> +static void irdma_init_iw_device(struct irdma_device *iwdev)
>>   {
>>   	struct net_device *netdev = iwdev->netdev;
>>
>> @@ -4533,8 +4533,6 @@ static int irdma_init_iw_device(struct irdma_device
>> *iwdev)
>>   	memcpy(iwdev->ibdev.iw_ifname, netdev->name,
>>   	       sizeof(iwdev->ibdev.iw_ifname));
>>   	ib_set_device_ops(&iwdev->ibdev, &irdma_iw_dev_ops);
>> -
>> -	return 0;
>>   }
>>
>>   /**
>> @@ -4544,14 +4542,11 @@ static int irdma_init_iw_device(struct irdma_device
>> *iwdev)  static int irdma_init_rdma_device(struct irdma_device *iwdev)  {
>>   	struct pci_dev *pcidev = iwdev->rf->pcidev;
>> -	int ret;
>>
>>   	if (iwdev->roce_mode) {
>>   		irdma_init_roce_device(iwdev);
>>   	} else {
>> -		ret = irdma_init_iw_device(iwdev);
>> -		if (ret)
>> -			return ret;
>> +		irdma_init_iw_device(iwdev);
>>   	}
> 
> checkpatch doesn't complain here? This becomes a single statement if/else now. No {} required.
> 
It complains when running it over the file, fixed in v2.

Thanks,
Kamal


>>   	iwdev->ibdev.phys_port_cnt = 1;
>>   	iwdev->ibdev.num_comp_vectors = iwdev->rf->ceqs_count;
>> --
>> 2.40.1
> 

