Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A61F6C92EE
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Mar 2023 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCZHMm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Mar 2023 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCZHMl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Mar 2023 03:12:41 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370FB9EDF;
        Sun, 26 Mar 2023 00:12:37 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id i5so23956353eda.0;
        Sun, 26 Mar 2023 00:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679814755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2s6cgqtyHQC9upsmEZAwdtb5aFvaLxCWNrBqYDjKU6k=;
        b=INNa02fO3qkdCqgkLA6cU5yOoBJjyhG+ImiD33e8VkBJ/qYpNloTG1VAIiFc1fLBXs
         QaobtCJ7stzIwhAIdn3htb5soZ5db8gYlN0W7H6rcmgHpaxKj3cHZw+iyuqTkphaIKWE
         /4Pn3635cafj8i9jwZkhFU49fuD60VBxf/DngHi/o5VT8Wn7X0Zsl1mx8enKAn5DOfhq
         eecI791PRSI1qcPiAu9bpG5oz2oOtYqBKiEEmCLqir/VgwOwvbj7Vtywo9MRUOv8d622
         2GPhcD2fvzF5srqwwnQnKfoGX2iS0MhZtq8k5+YMoqsm6fhXKwgFpplSUv74ogTbUs/D
         aoDQ==
X-Gm-Message-State: AAQBX9cXyn4OzDdB4SzBmVxgYtSdZAFbIWcSNX+RD4HjvIN+XCTEu79G
        AycdYG32AtAbNk/cmgcAbXU=
X-Google-Smtp-Source: AKy350Z59FFbxqYQ3c6FUFkwDSCe0WvmExH2hVkE5OBDnCeIYjbMxg9DNM6zlzenSjxa9M44P7rC2w==
X-Received: by 2002:a05:6402:268e:b0:502:ffd:74a0 with SMTP id w14-20020a056402268e00b005020ffd74a0mr9556077edd.2.1679814755521;
        Sun, 26 Mar 2023 00:12:35 -0700 (PDT)
Received: from [10.100.102.33] (109-186-69-235.bb.netvision.net.il. [109.186.69.235])
        by smtp.gmail.com with ESMTPSA id m23-20020a509317000000b004fb95f51f54sm13066442eda.12.2023.03.26.00.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 00:12:35 -0700 (PDT)
Message-ID: <9a59298e-bdac-09ad-d648-ae00c55b8653@grimberg.me>
Date:   Sun, 26 Mar 2023 10:12:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca> <20230323120515.GE36557@unreal>
 <ZBxOHZwre3x8DkWN@ziepe.ca>
 <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
 <ZBx3AI5pothCuvTx@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBx3AI5pothCuvTx@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>>>>> No rdma device exposes its irq vectors affinity today. So the only
>>>>>>>> mapping that we have left, is the default blk_mq_map_queues, which
>>>>>>>> we fallback to anyways. Also fixup the only consumer of this helper
>>>>>>>> (nvme-rdma).
>>>>>>>
>>>>>>> This was the only caller of ib_get_vector_affinity() so please delete
>>>>>>> op get_vector_affinity and ib_get_vector_affinity() from verbs as well
>>>>>>
>>>>>> Yep, no problem.
>>>>>>
>>>>>> Given that nvme-rdma was the only consumer, do you prefer this goes from
>>>>>> the nvme tree?
>>>>>
>>>>> Sure, it is probably fine
>>>>
>>>> I tried to do it two+ years ago:
>>>> https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
>>>
>>> Christoph's points make sense, but I think we should still purge this
>>> code.
>>>
>>> If we want to do proper managed affinity the right RDMA API is to
>>> directly ask for the desired CPU binding when creating the CQ, and
>>> optionally a way to change the CPU binding of the CQ at runtime.
>>
>> I think the affinity management is referring to IRQD_AFFINITY_MANAGED
>> which IIRC is the case when the device passes `struct irq_affinity` to
>> pci_alloc_irq_vectors_affinity.
>>
>> Not sure what that has to do with passing a cpu to create_cq.
> 
> I took Christoph's remarks to be that the system should auto configure
> interrupts sensibly and not rely on userspace messing around in proc.

Yes, that is correct.

> For instance, I would expect that the NVMe driver work the same way on
> RDMA and PCI. For PCI it calls pci_alloc_irq_vectors_affinity(), RDMA
> should call some ib_alloc_cq_affinity() and generate the affinity in
> exactly the same way.

But an RDMA ulp does not own the EQs like the nvme driver does.
That is why NVMe is fine with managed affinity, and RDMA is not.
The initial attempt was to make RDMA use managed affinity, but then
users started complaining that they are unable to mangle with irq
vector affinity via procfs.

> So, I have no problem to delete these things as the
> get_vector_affinity API is not part of solving the affinity problem,
> and it seems NVMe PCI doesn't need blk_mq_rdma_map_queues() either.

Cool.
