Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8620A14B1C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfEFNps (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:45:48 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:33343 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFNps (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 09:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557150346; x=1588686346;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZdDbaK5bgpulStjhGh/WcyjdeOPB6ca2t/UBRDr1KpE=;
  b=SR1jImrKM/t0HoI53rtrxzkVn1a4jrcLJbu+CVCG//Lt1sHaV2glRFWw
   WZECrbqW54OXOJ85cSE10jXVr5XK+BdjQTwVMhQW1OIonD47uOLB3x8da
   UULTNlaD9VXJR3Ii2Jupuv6pgifT7r1BtqO7aNBlPJ/H51pNR4gkS60lp
   o=;
X-IronPort-AV: E=Sophos;i="5.60,438,1549929600"; 
   d="scan'208";a="731947636"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2019 13:45:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x46DjfhQ015020
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 May 2019 13:45:43 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 May 2019 13:45:42 +0000
Received: from [10.218.62.23] (10.43.161.10) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 6 May
 2019 13:45:39 +0000
Subject: Re: [PATCH rdma-next] RDMA/ipoib: Allow user space differentiate
 between valid dev_port
To:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
References: <20190506102107.14817-1-leon@kernel.org>
 <4c4c560a-d3ec-4b32-203f-178bddde478d@amazon.com>
 <20190506104952.GL6938@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3410a5ca-ab69-8c35-9754-356500d1b9c9@amazon.com>
Date:   Mon, 6 May 2019 16:45:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506104952.GL6938@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.10]
X-ClientProxiedBy: EX13D17UWB001.ant.amazon.com (10.43.161.252) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06-May-19 13:49, Leon Romanovsky wrote:
> On Mon, May 06, 2019 at 01:35:07PM +0300, Gal Pressman wrote:
>> On 06-May-19 13:21, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@mellanox.com>
>>>
>>> Systemd triggers the following warning during IPoIB device load:
>>>
>>>  mlx5_core 0000:00:0c.0 ib0: "systemd-udevd" wants to know my dev_id.
>>>         Should it look at dev_port instead?
>>>         See Documentation/ABI/testing/sysfs-class-net for more info.
>>>
>>> This is caused due to user space attempt to differentiate old systems
>>> without dev_port and new systems with dev_port. In case dev_port will
>>> be zero, the systemd will try to read dev_id instead.
>>>
>>> There is no need to print a warning in such case, because it is valid
>>> situation and it is needed to ensure systemd compatibility with old
>>> kernels.
>>>
>>> Link: https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
>>> Cc: <stable@vger.kernel.org> # 4.19
>>> Fixes: f6350da41dc7 ("IB/ipoib: Log sysfs 'dev_id' accesses from userspace")
>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>> ---
>>>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
>>> index 48eda16db1a7..34e6495aa8c5 100644
>>> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
>>> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
>>> @@ -2402,7 +2402,17 @@ static ssize_t dev_id_show(struct device *dev,
>>>  {
>>>  	struct net_device *ndev = to_net_dev(dev);
>>>
>>> -	if (ndev->dev_id == ndev->dev_port)
>>> +	/*
>>> +	 * ndev->dev_port will be equal to 0 in old kernel prior to commit
>>> +	 * 9b8b2a323008 ("IB/ipoib: Use dev_port to expose network interface port numbers")
>>> +	 * Zero was chosen as special case for user space applications to fallback
>>> +	 * and query dev_id to check if it has different value or not.
>>> +	 *
>>> +	 * Don't pring warning in such scenario.
>>
>> "pring" -> "print".
> 
> Are you ok with other changes and I can add your ROB tag?

To my understanding, the test should be for just:
if (ndev->dev_port)

As if dev_port is set then there's no reason to use dev_id, regardless of its value.
But I'm not really familiar with this flow..

>>
>>> +	 *
>>> +	 * https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
>>> +	 */
>>> +	if (ndev->dev_port && ndev->dev_id == ndev->dev_port)
>>>  		netdev_info_once(ndev,
>>>  			"\"%s\" wants to know my dev_id. Should it look at dev_port instead? See Documentation/ABI/testing/sysfs-class-net for more info.\n",
>>>  			current->comm);
>>>
>>

