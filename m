Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902D37A515D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 19:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjIRR5c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIRR5a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 13:57:30 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B1A102
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 10:57:25 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id iFhKqkUVnyYOwiIUsqHqo2; Mon, 18 Sep 2023 17:57:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id iIUrqDQ3DWB2viIUrqgf66; Mon, 18 Sep 2023 17:57:21 +0000
X-Authority-Analysis: v=2.4 cv=HNPQq6hv c=1 sm=1 tr=0 ts=65088f81
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=x2q-Q_5hSYYoW0-ZbgkA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cNTm+n0prBabhDiuzBL/lY2C7Js3MHb27iGHM7ixly0=; b=LK0LfAMnALG/1sjjcruihPHoEZ
        OTtfwOPkW6PUJGAWj2eXVP3UjJmv7lDTtICahD2p7cthn3tjspNMk9k5Pzgq9IWSzoD2Xo+Qg+BtQ
        lehOsScxQXPCaf+vbHtHOlImY4Ldkm2ug2CHM1o80BPt1u54UMyaudk2EjMDBEW87B1egQrrJ0wrs
        IV+W7WrVmn+M9J/f4j3YL1vzDARkCBHUynsPaWBc+L44UTXBhYFuNgoVRDzkaL+tJ4j4efn2hAbCS
        MmF0FJ2+Xd9NK92h8XxjCP1Hpfw+nCFSTkWUu7KJhJnbjNpQe1sqDvlI89GdiF6bIU48NsAzt8e1j
        2l0mLBiw==;
Received: from [94.239.20.48] (port=59520 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qiIUq-002041-0k;
        Mon, 18 Sep 2023 12:57:20 -0500
Message-ID: <93f70187-3992-ee22-843e-e3912d169875@embeddedor.com>
Date:   Sun, 17 Sep 2023 19:58:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2][next] RDMA/core: Use size_{add,mul}() in calls to
 struct_size()
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZP+if342EMhModzZ@work> <202309142029.D432EEB8C@keescook>
 <2594c7ff-0301-90aa-d48c-6b4d674f850e@embeddedor.com>
 <20230918104938.GD13757@unreal>
 <4067fb33-2172-b132-e8c4-0ba21c31b42a@embeddedor.com>
 <20230918124120.GE103601@unreal>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230918124120.GE103601@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qiIUq-002041-0k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:59520
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG7gKktiVWOv/vfmsaPhiL+YqnjImYwpEsJIOglRX5mk4AhQwz5bi2JrwG/1sKFTSkNjl3LjbB1V4z/4YauF3Rjccoubgw4RmTUrdx9zg1F231NfBd++
 2ebOqZk26MYsSsUo7YKGukWHrogMk+QRVeFraPqWjLZjMcbwLGQzuDFf9CL0fkDHooQocnHA4L0009HBs/FdNBz09WQPf5hEkf0H0yLfqZJmI/O5ZruDm2Mz
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/18/23 06:41, Leon Romanovsky wrote:
> On Sun, Sep 17, 2023 at 01:59:26PM -0600, Gustavo A. R. Silva wrote:
>>
>>
>> On 9/18/23 04:49, Leon Romanovsky wrote:
>>> On Fri, Sep 15, 2023 at 12:06:21PM -0600, Gustavo A. R. Silva wrote:
>>>>
>>>>
>>>> On 9/14/23 21:29, Kees Cook wrote:
>>>>> On Mon, Sep 11, 2023 at 05:27:59PM -0600, Gustavo A. R. Silva wrote:
>>>>>> Harden calls to struct_size() with size_add() and size_mul().
>>>>>
>>>>> Specifically, make sure that open-coded arithmetic cannot cause an
>>>>> overflow/wraparound. (i.e. it will stay saturated at SIZE_MAX.)
>>>>
>>>> Yep; I have another patch where I explain this in similar terms.
>>>>
>>>> I'll send it, shortly.
>>>
>>> You missed other places with similar arithmetic.
>>> drivers/infiniband/core/device.c:       pdata_rcu = kzalloc(struct_size(pdata_rcu, pdata,
>>> drivers/infiniband/core/device.c-                                       rdma_end_port(device) + 1),
>>> drivers/infiniband/core/device.c-                           GFP_KERNEL);
>>>
>>> drivers/infiniband/core/sa_query.c:     sa_dev = kzalloc(struct_size(sa_dev, port, e - s + 1), GFP_KERNEL);
>>> drivers/infiniband/core/user_mad.c:     umad_dev = kzalloc(struct_size(umad_dev, ports, e - s + 1), GFP_KERNEL);
>>
>> I haven't sent all my patches.
> 
> Please sent one patch for whole drivers/infiniband/core/ folder as your
> title: "RDMA/core ..." suggests.

OK. Done:

https://lore.kernel.org/linux-hardening/ZQdt4NsJFwwOYxUR@work/

Thanks
--
Gustavo
