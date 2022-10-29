Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E852611FAD
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJ2DPm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2DPk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:15:40 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA29B3D598;
        Fri, 28 Oct 2022 20:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667013336; i=@fujitsu.com;
        bh=N9UlAQL52K8DlauZDIfKvNoDwJZcdmog4BpC05SNtqM=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=RAMFxah2plSBOp2+BnO9g1p+OhTiSpOuXynUWPDkM/ihW4j8o/fF1LmdkOiafS2SU
         oOObWIvryOO0NU9wUtIry8hI2f0vsVEtwjcsqKnvDE1DX+moHL9UkfO5IMtxfEohUs
         9+cB2MsDFMdUyfYxSC9wbZVPJPH8n5gZr1RKmw9/nPiiwsF/agHDBdKIQCbyp0GLkQ
         vfS8eHstd7IExMJe1A9DELmk3/H0pNl7nlqknw5c1+N6ONdMh9RpY8fvuDSzWKi27u
         DQQJnjusZ0ShARIpEPIFl5BzR779MYBZghOao71pSXLQzHVFrO6Kw+SefvYF11PPJe
         vioq/jEU4RKtg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRWlGSWpSXmKPExsViZ8ORqHt1Vky
  ywarX4hbTp15gtLjybw+jxZRfS5ktzv31s7i8aw6bxbNDvSwWH6YeYbb4MnUas8WpX6eYLP5e
  +sdmcf5YP7sDt8fOWXfZPVqOvGX1WLznJZPHplWdbB69ze/YPC4/ucLo8XmTXAB7FGtmXlJ+R
  QJrxs99j9kKDnNUHJ61n7GB8SNbFyMXh5DAFkaJJbNfMEM4y5kktk/fAORwAjnbGCWOLawHsX
  kF7CQ+3VzJ2MXIwcEioCqxcbMnRFhQ4uTMJywgtqhAhMTDR5PAbGGBaIkFn+cxgtjMAuISt57
  MZwKxRQRUJE6cOMMOsotZ4CaTxNE3t5kgFncwSixsXsMOUsUmoCFxr+Um2DJOAS2JA82ZEIMs
  JBa/OcgOYctLNG+dDXanhICixJHOvywQdoXErFltTBC2msTVc5uYJzAKz0Jy6ywkN81CMnYWk
  rELGFlWMZoVpxaVpRbpGhroJRVlpmeU5CZm5uglVukm6qWW6panFpfoGukllhfrpRYX6xVX5i
  bnpOjlpZZsYgRGbkqxSt8OxrfL/ugdYpTkYFIS5e01i0kW4kvKT6nMSCzOiC8qzUktPsQow8G
  hJMGrOw0oJ1iUmp5akZaZA0wiMGkJDh4lEd7YCUBp3uKCxNzizHSI1ClGRSlx3nPTgRICIImM
  0jy4NljiusQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmLdsCtAUnsy8Erjpr4AWMwEtTp8UB
  bK4JBEhJdXANIHliumdGcwyc6LF9C/6asZPXRo+j/X5ptxbsdVuTwK+9Ug/nB285Z36L4btfW
  IHvn7+07duyZ6sxHrPGJf1bnJqf/rzdFU6mUSMbW/YRTc1ZXfYiBpl+kj8rNcp8lkvsMb4lXb
  r9/8yJ5a+SI6fEWrVKzvx38fTO7ZIKiX2HfRmZQ7ZtvvYro6DulmtEwQtLHU4vniq3Wmb7P5l
  akrGEVODJRxy+zU+aCU9thI0MkwU2Km9uftWcmJQ0+0QTolnW6aY3Trt6lbnWPLj+Iw9rzL6n
  pRLmmbPjV0hr+cnZap99JnyK6/Lr7mefXNL0+1tUSzNCrQ93VmRrH3f0yUo+POX1pxma26/r1
  lH+ZRYijMSDbWYi4oTAYnjuF/XAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-20.tower-571.messagelabs.com!1667013333!676692!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10590 invoked from network); 29 Oct 2022 03:15:33 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-20.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Oct 2022 03:15:33 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 0D39510018D;
        Sat, 29 Oct 2022 04:15:33 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 00D75100043;
        Sat, 29 Oct 2022 04:15:33 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 29 Oct 2022 04:15:23 +0100
Message-ID: <63c3eec8-bef3-f9c4-a552-0c075cd51b46@fujitsu.com>
Date:   Sat, 29 Oct 2022 11:15:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-next PATCH v5 03/11] RDMA: Extend RDMA kernel verbs ABI to
 support flush
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <tom@talpey.com>,
        <tomasz.gromadzki@intel.com>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-4-lizhijian@fujitsu.com> <Y1wVFm2SVQ/ZLUpU@nvidia.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <Y1wVFm2SVQ/ZLUpU@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 29/10/2022 01:44, Jason Gunthorpe wrote:
> On Tue, Sep 27, 2022 at 01:53:29PM +0800, Li Zhijian wrote:
>> @@ -4321,6 +4330,8 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
>>   static inline int ib_check_mr_access(struct ib_device *ib_dev,
>>   				     unsigned int flags)
>>   {
>> +	u64 device_cap = ib_dev->attrs.device_cap_flags;
>> +
>>   	/*
>>   	 * Local write permission is required if remote write or
>>   	 * remote atomic permission is also requested.
>> @@ -4335,6 +4346,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
>>   	if (flags & IB_ACCESS_ON_DEMAND &&
>>   	    !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
>>   		return -EINVAL;
>> +
>> +	if ((flags & IB_ACCESS_FLUSH_GLOBAL &&
>> +	    !(device_cap & IB_DEVICE_FLUSH_GLOBAL)) ||
>> +	    (flags & IB_ACCESS_FLUSH_PERSISTENT &&
>> +	    !(device_cap & IB_DEVICE_FLUSH_PERSISTENT)))
>> +		return -EINVAL;
> This should be -EOPNOTSUPP as the above is changed to in for-next
Yes,  my local tree(V6) had updated this. will repost this later.



>
> Jason

