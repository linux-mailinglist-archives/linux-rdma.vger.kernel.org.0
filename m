Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA737A2551
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 20:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjIOSGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Sep 2023 14:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjIOSFo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Sep 2023 14:05:44 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2A19A9
        for <linux-rdma@vger.kernel.org>; Fri, 15 Sep 2023 11:05:38 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id hCX4q9JcZOzKlhDCEqH0sU; Fri, 15 Sep 2023 18:05:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hDCCqBCF5r4o2hDCDqh7uw; Fri, 15 Sep 2023 18:05:37 +0000
X-Authority-Analysis: v=2.4 cv=KIpJsXJo c=1 sm=1 tr=0 ts=65049cf1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=Wrtf5UCP7LI77WHjMVIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kIh9h+51ldocBU9TG/FuWYO4jPEoPniNky9hvQTOqbg=; b=G8Bu3gEKJrGszhS5XS0/ZMRosW
        6d/T9j7UU7MxDZvrj/IlDqRPPFsGp90IoU237SeEO0psbm25zc7Va9ThSAdrHHpqAiFoMoP0KCCyJ
        kDRMsHJUe+NECRuDeUDxLLg18Ba5VqJY5EvmcjWtbSt429z7ohaftrqg9+sNpYv+JFoOUcE6CvZqe
        lMXFl8qcPLkpGLjw4xrn69xiKliAlk7B1ltV0RPj6E2j2Lus4REHF8XpS1YIkR4MKnERzLEoqDPWH
        H6cz//NAWXwnOxEFSUGFNon2vw+oR6wX7q21DMzGsKbgR2L2/t5F7moJapvtTqAO0X4HA/uCnl8ao
        28ARowYw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:41712 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhDCC-000DpQ-05;
        Fri, 15 Sep 2023 13:05:36 -0500
Message-ID: <2594c7ff-0301-90aa-d48c-6b4d674f850e@embeddedor.com>
Date:   Fri, 15 Sep 2023 12:06:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2][next] RDMA/core: Use size_{add,mul}() in calls to
 struct_size()
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZP+if342EMhModzZ@work> <202309142029.D432EEB8C@keescook>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202309142029.D432EEB8C@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhDCC-000DpQ-05
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:41712
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfND65Tj4/o6ODEc64i4kBe36vj0zVouhmreIfDDAUAHdvsMw+5qJv9g40/EcnIeqkINzuX5dlsSmLlTzIMUOh9QrGT4y3SKnSuZrAf83BC63II72dEfP
 U2HUiERu/RXsmm8lEKztgU4Wa2KLYbtbgUpkoJEl+LOpQVzX6CwMZEFa9+HHK+MwURj0rQsLFmVNHWj/ScRlsQMeQYLZSOA0UlBkIwwDP8oUgu3Gguee7LLE
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/14/23 21:29, Kees Cook wrote:
> On Mon, Sep 11, 2023 at 05:27:59PM -0600, Gustavo A. R. Silva wrote:
>> Harden calls to struct_size() with size_add() and size_mul().
> 
> Specifically, make sure that open-coded arithmetic cannot cause an
> overflow/wraparound. (i.e. it will stay saturated at SIZE_MAX.)

Yep; I have another patch where I explain this in similar terms.

I'll send it, shortly.

> 
>>
>> Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
>> Fixes: a4676388e2e2 ("RDMA/core: Simplify how the gid_attrs sysfs is created")
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

--
Gustavo

> 
> -Kees
> 
>> ---
>> Changes in v2:
>>   - Update changelog text: remove the part about binary differences (it
>>     was added by mistake).
>>
>>   drivers/infiniband/core/sysfs.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
>> index ee59d7391568..ec5efdc16660 100644
>> --- a/drivers/infiniband/core/sysfs.c
>> +++ b/drivers/infiniband/core/sysfs.c
>> @@ -903,7 +903,7 @@ alloc_hw_stats_device(struct ib_device *ibdev)
>>   	 * Two extra attribue elements here, one for the lifespan entry and
>>   	 * one to NULL terminate the list for the sysfs core code
>>   	 */
>> -	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
>> +	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
>>   		       GFP_KERNEL);
>>   	if (!data)
>>   		goto err_free_stats;
>> @@ -1009,7 +1009,7 @@ alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
>>   	 * Two extra attribue elements here, one for the lifespan entry and
>>   	 * one to NULL terminate the list for the sysfs core code
>>   	 */
>> -	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
>> +	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
>>   		       GFP_KERNEL);
>>   	if (!data)
>>   		goto err_free_stats;
>> @@ -1140,7 +1140,7 @@ static int setup_gid_attrs(struct ib_port *port,
>>   	int ret;
>>   
>>   	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
>> -					     attr->gid_tbl_len * 2),
>> +					     size_mul(attr->gid_tbl_len, 2)),
>>   				 GFP_KERNEL);
>>   	if (!gid_attr_group)
>>   		return -ENOMEM;
>> @@ -1205,8 +1205,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
>>   	int ret;
>>   
>>   	p = kvzalloc(struct_size(p, attrs_list,
>> -				attr->gid_tbl_len + attr->pkey_tbl_len),
>> -		    GFP_KERNEL);
>> +				size_add(attr->gid_tbl_len, attr->pkey_tbl_len)),
>> +		     GFP_KERNEL);
>>   	if (!p)
>>   		return ERR_PTR(-ENOMEM);
>>   	p->ibdev = device;
>> -- 
>> 2.34.1
>>
> 
