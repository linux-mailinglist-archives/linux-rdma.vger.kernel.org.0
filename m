Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2754439430B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhE1M5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 08:57:46 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2397 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhE1M5o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 08:57:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fs4Mv4WDyz65pS;
        Fri, 28 May 2021 20:52:27 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 20:56:06 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 20:56:06 +0800
Subject: Re: [PATCH v2 -next] RDMA/srp: use DEVICE_ATTR_*() macro
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <bvanassche@acm.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210528123039.10668-1-yuehaibing@huawei.com>
 <20210528123334.GI1096940@ziepe.ca>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <0a12ba49-b020-2417-3618-2a42ff147838@huawei.com>
Date:   Fri, 28 May 2021 20:56:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210528123334.GI1096940@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/5/28 20:33, Jason Gunthorpe wrote:
> On Fri, May 28, 2021 at 08:30:39PM +0800, YueHaibing wrote:
>> @@ -3040,22 +3040,22 @@ static ssize_t show_allow_ext_sg(struct device *dev,
>>  	return sysfs_emit(buf, "%s\n", target->allow_ext_sg ? "true" : "false");
>>  }
>>  
>> -static DEVICE_ATTR(id_ext,	    S_IRUGO, show_id_ext,	   NULL);
>> -static DEVICE_ATTR(ioc_guid,	    S_IRUGO, show_ioc_guid,	   NULL);
>> -static DEVICE_ATTR(service_id,	    S_IRUGO, show_service_id,	   NULL);
>> -static DEVICE_ATTR(pkey,	    S_IRUGO, show_pkey,		   NULL);
>> -static DEVICE_ATTR(sgid,	    S_IRUGO, show_sgid,		   NULL);
>> -static DEVICE_ATTR(dgid,	    S_IRUGO, show_dgid,		   NULL);
>> -static DEVICE_ATTR(orig_dgid,	    S_IRUGO, show_orig_dgid,	   NULL);
>> -static DEVICE_ATTR(req_lim,         S_IRUGO, show_req_lim,         NULL);
>> -static DEVICE_ATTR(zero_req_lim,    S_IRUGO, show_zero_req_lim,	   NULL);
>> -static DEVICE_ATTR(local_ib_port,   S_IRUGO, show_local_ib_port,   NULL);
>> -static DEVICE_ATTR(local_ib_device, S_IRUGO, show_local_ib_device, NULL);
>> -static DEVICE_ATTR(ch_count,        S_IRUGO, show_ch_count,        NULL);
>> -static DEVICE_ATTR(comp_vector,     S_IRUGO, show_comp_vector,     NULL);
>> -static DEVICE_ATTR(tl_retry_count,  S_IRUGO, show_tl_retry_count,  NULL);
>> -static DEVICE_ATTR(cmd_sg_entries,  S_IRUGO, show_cmd_sg_entries,  NULL);
>> -static DEVICE_ATTR(allow_ext_sg,    S_IRUGO, show_allow_ext_sg,    NULL);
>> +static DEVICE_ATTR_RO(id_ext);
>> +static DEVICE_ATTR_RO(ioc_guid);
>> +static DEVICE_ATTR_RO(service_id);
>> +static DEVICE_ATTR_RO(pkey);
>> +static DEVICE_ATTR_RO(sgid);
>> +static DEVICE_ATTR_RO(dgid);
>> +static DEVICE_ATTR_RO(orig_dgid);
>> +static DEVICE_ATTR_RO(req_lim);
>> +static DEVICE_ATTR_RO(zero_req_lim);
>> +static DEVICE_ATTR_RO(local_ib_port);
>> +static DEVICE_ATTR_RO(local_ib_device);
>> +static DEVICE_ATTR_RO(ch_count);
>> +static DEVICE_ATTR_RO(comp_vector);
>> +static DEVICE_ATTR_RO(tl_retry_count);
>> +static DEVICE_ATTR_RO(cmd_sg_entries);
>> +static DEVICE_ATTR_RO(allow_ext_sg);
> 
> can you also organize this so the ATTR's are placed after their
> functions, as is normal?

Ok, v3 on the way.
> 
> Thanks,
> Jason
> .
> 
