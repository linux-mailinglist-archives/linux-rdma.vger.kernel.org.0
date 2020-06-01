Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB01EA53F
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFANp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 09:45:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:23189 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFANp4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jun 2020 09:45:56 -0400
IronPort-SDR: J1iAgNkI/BaTElVYjwbXWZKRBaUhAeaF/lU38uJPacwe5v2WB5+X/wh1PtLE+CEVAVyRNbzNYn
 QZj/Za+1ARAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 06:45:55 -0700
IronPort-SDR: /Rgu7q7gUsns4oxFuTeGawdR2NTYZUveCKAghkLjDOlgIUVs1Mz9AMMXESFT8LpaHBOsTT0zo+
 be0HP0co2Qxg==
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="444294162"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.208]) ([10.254.204.208])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 06:45:54 -0700
Subject: Re: [PATCH -next] IB/hfi1: Remove set but not used variable 'priv'
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Dan Carpenter (dan.carpenter@oracle.com)" <dan.carpenter@oracle.com>
References: <20200528075946.123480-1-yuehaibing@huawei.com>
 <MN2PR11MB396654BC46500F828609C6A3868E0@MN2PR11MB3966.namprd11.prod.outlook.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <86634519-3dd8-0c6a-a8d2-19f4b986fd3d@intel.com>
Date:   Mon, 1 Jun 2020 09:45:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB396654BC46500F828609C6A3868E0@MN2PR11MB3966.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/28/2020 7:25 AM, Marciniszyn, Mike wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>> Sent: Thursday, May 28, 2020 4:00 AM
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/infiniband/hw/hfi1/netdev_rx.c | 11 +++--------
>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c
>> b/drivers/infiniband/hw/hfi1/netdev_rx.c
>> index 58af6a454761..bd6546b52159 100644
>> --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
>> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
>> @@ -371,14 +371,9 @@ int hfi1_netdev_alloc(struct hfi1_devdata *dd)
>>
>>   void hfi1_netdev_free(struct hfi1_devdata *dd)
>>   {
>> -struct hfi1_netdev_priv *priv;
>> -
>> -if (dd->dummy_netdev) {
>> -priv = hfi1_netdev_priv(dd->dummy_netdev);
>> -dd_dev_info(dd, "hfi1 netdev freed\n");
>> -kfree(dd->dummy_netdev);
>> -dd->dummy_netdev = NULL;
>> -}
>> +dd_dev_info(dd, "hfi1 netdev freed\n");
>> +kfree(dd->dummy_netdev);
> 
> Dan Carpenter has reported kfree() should be free_netdev()...
> 
> Mike
> 

I'm OK with this patch going in and then adding a separate one to fix 
the kfree. Or this one can be touched up to include that as well.

-Denny

