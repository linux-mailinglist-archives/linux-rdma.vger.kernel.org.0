Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B73346FE7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 04:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhCXDIn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 23 Mar 2021 23:08:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3318 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhCXDIN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 23:08:13 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F4tPd6JrLz147Jg;
        Wed, 24 Mar 2021 11:04:37 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Mar 2021 11:07:47 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 24 Mar 2021 11:07:47 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Wed, 24 Mar 2021 11:07:47 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Support query information of
 functions from FW
Thread-Topic: [PATCH for-next 1/2] RDMA/hns: Support query information of
 functions from FW
Thread-Index: AQHXFyVSLcvKaZUM2kuvfESrfUUvaw==
Date:   Wed, 24 Mar 2021 03:07:47 +0000
Message-ID: <74c5373f541f4f3282795f7763f198da@huawei.com>
References: <1615542507-40018-1-git-send-email-liweihang@huawei.com>
 <1615542507-40018-2-git-send-email-liweihang@huawei.com>
 <20210323195627.GA398808@nvidia.com>
 <df637ff2c0dc4d20b2a01c8400c4ed9b@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/3/24 9:55, liweihang wrote:
> On 2021/3/24 3:56, Jason Gunthorpe wrote:
>> On Fri, Mar 12, 2021 at 05:48:26PM +0800, Weihang Li wrote:
>>
>>> +static int hns_roce_query_func_info(struct hns_roce_dev *hr_dev)
>>> +{
>>> +	struct hns_roce_pf_func_info *resp;
>>> +	struct hns_roce_cmq_desc desc;
>>> +	int ret;
>>> +
>>> +	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
>>> +		return 0;
>>> +
>>> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_FUNC_INFO,
>>> +				      true);
>>> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	resp = (struct hns_roce_pf_func_info *)desc.data;
>>
>> WTF is this cast?
>>
>> struct hns_roce_cmq_desc {
>>         __le16 opcode;
>>         __le16 flag;
>>         __le16 retval;
>>         __le16 rsv;
>>         __le32 data[6];
>> };
>>
>> Casting __le32 to a pointer is wrong
>>
>> Jason
>>
> 
> Hi Jason
> 
> desc.data is the address of array 'data[6]', it is got from the firmware, we
> cast it to 'struct hns_roce_pf_func_info *' to parse its contents. I think this
> is a cast from '__le32 *' to 'struct hns_roce_pf_func_info *'.
> 
> Thanks
> Weihang
> 
> 

Jason, do you mean the current code is not written correctly? Do you have any
suggestions for achieving our purpose?

Weihang
