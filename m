Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660B31D120A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgEML7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 07:59:34 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:44485 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgEML7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 07:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589371174; x=1620907174;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+J5cgQA4iibrLd8OXpNWZhGgsDFrI6Lx9GX9JFvbkgs=;
  b=UZwPMlpwWHFJooO/ncucTQ+/KWjTe7F2oxEeGn4sXietd1pyOPD85TpC
   KC3mURVEJi/i31tGKorhjzHDthh+EOcbzn9zMQlFcppQjG8eCWOIdHbvg
   I/9Mr6itGWszeeRbNN2Jm0srdbXRdF6xu9NhSp1hESpowO+MckyyQUon0
   w=;
IronPort-SDR: 7bQ3Sk6u/Wnf6EuLIbvH1XaX9J9hEy13UD5ksCX+V1EIpXbU+b653A9pGqmtVtqAGe7LqjlQLJ
 vMTO86Ta/mpQ==
X-IronPort-AV: E=Sophos;i="5.73,387,1583193600"; 
   d="scan'208";a="34780455"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 13 May 2020 11:59:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 5C6F82256C0;
        Wed, 13 May 2020 11:59:31 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 13 May 2020 11:59:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.193) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 13 May 2020 11:59:26 +0000
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
To:     Kamal Heib <kamalheib1@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
 <20200513072203.GR4814@unreal> <20200513100204.GA92901@kheib-workstation>
 <20200513102132.GW4814@unreal> <20200513104536.GA120318@kheib-workstation>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <1e5e1e3b-7e18-50a0-6133-db76c39985be@amazon.com>
Date:   Wed, 13 May 2020 14:59:21 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513104536.GA120318@kheib-workstation>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.193]
X-ClientProxiedBy: EX13D44UWB003.ant.amazon.com (10.43.161.52) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 13/05/2020 13:45, Kamal Heib wrote:
> On Wed, May 13, 2020 at 01:21:32PM +0300, Leon Romanovsky wrote:
>> On Wed, May 13, 2020 at 01:02:04PM +0300, Kamal Heib wrote:
>>> On Wed, May 13, 2020 at 10:22:03AM +0300, Leon Romanovsky wrote:
>>>> On Tue, May 12, 2020 at 01:29:18AM +0300, Kamal Heib wrote:
>>>>> Avoid disabling device management for devices that don't support
>>>>> Management datagrams (MADs) by checking if the "mad_agent" pointer is
>>>>> initialized before calling ib_modify_port, also change the error message
>>>>> to a warning and make it more informative.
>>>>>
>>>>> Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
>>>>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>>>>> ---
>>>>>  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>>> index 7ed38d1cb997..7b21792ab6f7 100644
>>>>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>>> @@ -625,14 +625,18 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
>>>>>  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
>>>>>  	};
>>>>>  	struct srpt_port *sport;
>>>>> +	int ret;
>>>>>  	int i;
>>>>>
>>>>>  	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
>>>>>  		sport = &sdev->port[i - 1];
>>>>>  		WARN_ON(sport->port != i);
>>>>> -		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
>>>>> -			pr_err("disabling MAD processing failed.\n");
>>>>>  		if (sport->mad_agent) {
>>>>> +			ret = ib_modify_port(sdev->device, i, 0, &port_modify);
>>>>> +			if (ret < 0)
>>>>> +				pr_warn("%s-%d: disabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
>>>>> +					dev_name(&sport->sdev->device->dev),
>>>>
>>>> The ib_modify_port() shouldn't be called if it expected to fail.
>>>>
>>>> Thanks
>>>
>>> OK, Do you know if there is a way to check if the created ib device is
>>> for VF to avoid calling ib_modify_port()?
>>
>> The "is_virtfn" field inside pci_dev will give this information,
>> but I don't know why it is expected to fail here.
>>
>> Thanks
>>
> 
> Looks like there a more trivial way, I mean checking if
> IB_DEVICE_VIRTUAL_FUNCTION cap is set, probably there is a need to make
> to sure that this cap is set for all providers when the IB device is
> created for a VF.

It's not, I think this bit is used for ipoib stuff only or something?
