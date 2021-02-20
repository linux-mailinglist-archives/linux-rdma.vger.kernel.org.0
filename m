Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621DB320421
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Feb 2021 07:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhBTGNe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 20 Feb 2021 01:13:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3447 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTGNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 20 Feb 2021 01:13:34 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DjJ3h69zFz5V4S;
        Sat, 20 Feb 2021 14:11:12 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 20 Feb 2021 14:12:44 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 20 Feb 2021 14:12:45 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Sat, 20 Feb 2021 14:12:44 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 2/5] libhns: Introduce DCA for RC QP
Thread-Topic: [PATCH RFC rdma-core 2/5] libhns: Introduce DCA for RC QP
Thread-Index: AQHW/P+gFy6BoBRq0kWqgOMQlgE0MA==
Date:   Sat, 20 Feb 2021 06:12:44 +0000
Message-ID: <f7c3b09d9607456c8a4b2926fc15407a@huawei.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
 <1612667574-56673-3-git-send-email-liweihang@huawei.com>
 <20210209194400.GS4247@nvidia.com>
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

On 2021/2/10 3:44, Jason Gunthorpe wrote:
> On Sun, Feb 07, 2021 at 11:12:51AM +0800, Weihang Li wrote:
> 
>> +static int register_dca_mem(struct hns_roce_context *ctx, uint64_t key,
>> +			    void *addr, uint32_t size, uint32_t *handle)
>> +{
>> +	struct ib_uverbs_attr *attr;
>> +	int ret;
>> +
>> +	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
>> +			       HNS_IB_METHOD_DCA_MEM_REG, 4);
>> +	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_REG_LEN, size);
>> +	fill_attr_in_uint64(cmd, HNS_IB_ATTR_DCA_MEM_REG_ADDR, (intptr_t)addr);
> 
> This should use ioctl_ptr_to_u64(), the place this was copied from
> should also be fixed
> 

OK, I will fix it. The kernel part has been defined as u64, so it doesn't
need to be modified.

> 
>> +	fill_attr_in_uint64(cmd, HNS_IB_ATTR_DCA_MEM_REG_KEY, key);
>> +	attr = fill_attr_out_obj(cmd, HNS_IB_ATTR_DCA_MEM_REG_HANDLE);
>> +
>> +	ret = execute_ioctl(&ctx->ibv_ctx.context, cmd);
>> +	if (!ret)
>> +		*handle = read_attr_obj(HNS_IB_ATTR_DCA_MEM_REG_HANDLE, attr);
> 
> Success oriented flow everywhere please
> > Jason
> 
OK, thank you.

Weihang
