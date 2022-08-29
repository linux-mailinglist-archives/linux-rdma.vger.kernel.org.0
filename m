Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E155A45B4
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH2JGX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiH2JGU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 05:06:20 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C49237DD
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 02:06:18 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id b16so1690473wru.7
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 02:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dUT6fA9d8r820XadYjeIsKVsw5zT8dmP/mI6xQ6wTNo=;
        b=txyav2A97JdLMm3gjHSdYLliDSolraqZg+8DCiuA0jLRo+VJ16KT7o+YvlRKnQ4BQu
         LG9dl2JvzPfivXwzlcBl8f29IMnLuetbv8towNQGB2ErTWSN/LHnlYuKkHQhprYbQ9oW
         j30lWPhBLEkRWPq+78pcl3hjZ7azlVtTD+pdGbtC543AxM1cvm5IFBDWwRUoPJ5A89vx
         n7ENuJBS3b2mjGlPtirewtq5xxNyry9ZVrcKwV7RoqcugwHnavBxuXugo6nv3nFP073J
         DbbI5GVm2srjVkOqum0Jh+nk1uKgHbMxNigWb4kvt91Vue9bx9FOejlbVAGR3zI/1sk3
         1EBg==
X-Gm-Message-State: ACgBeo3TEyKW4Nzqex+4xcqercfYoqsmBEv9YnBRreznkaEOSdHrx7tW
        F5mTRr1TePmAC9iZqueRSUM=
X-Google-Smtp-Source: AA6agR7iApFvdlU2T/4MzdkD9sp0Y5WMdA7CfNnyj94odG0IknFW271OkgTQw1WRGnBOjuZyyw0b3g==
X-Received: by 2002:a5d:6484:0:b0:226:dd0e:b09c with SMTP id o4-20020a5d6484000000b00226dd0eb09cmr1278618wri.388.1661763977162;
        Mon, 29 Aug 2022 02:06:17 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g13-20020adfe40d000000b002252751629dsm6393794wrm.24.2022.08.29.02.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:06:16 -0700 (PDT)
Message-ID: <3030fbb2-5c63-54ea-5be3-b88cf63c6b75@grimberg.me>
Date:   Mon, 29 Aug 2022 12:06:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
 <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
 <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
 <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>> If so, which devices did you use ?
>>> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
>>> The switch and storage are huawei equipments.
>>> In principle, switches and storage devices from other vendors
>>> have the same problem.
>>> If you think it is necessary, we can test the other vendor switchs
>>> and linux target.
>>
>> Why is the 2s default chosen, what is the downside for a 250ms seconds 
>> ack timeout? and why is nvme-rdma different than all other kernel rdma
> The downside is redundant retransmit if the packets delay more than
> 250ms in the networks and finally reaches the receiver.
> Only in extreme scenarios, the packet delay may exceed 250 ms.

Sounds like the default needs to be changed if it only addresses the
extreme scenarios...

>> consumers that it needs to set this explicitly?
> The real-time transaction services are sensitive to the delay.
> nvme-rdma will be used in real-time transactions.
> The real-time transaction services do not allow that the packets
> delay more than 250ms in the networks.
> So we need to set the ack timeout to 262ms.

While I don't disagree with the change itself, I do disagree why this
needs to be driven by nvme-rdma locally. If all kernel rdma consumers
need this (and if not, I'd like to understand why), this needs to be set 
in the rdma core.
