Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7329B102F6E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 23:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfKSWio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 17:38:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37872 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKSWio (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 17:38:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJMY7KZ038676;
        Tue, 19 Nov 2019 22:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=D3oARNJ2UQxodD4sfGGWeqhqmbKMgFluXMZC7zvMJNw=;
 b=qg+dVJqD7i4qTBlf+jZOFX4Rm/4NJ2ydIaKS9lV5JcuAY8oLnke2NOQ10Smlvv8u6oub
 uvWalHqrjWUHGu7ltBnGoEiZbsbN3yZqaCi7qlgrpls/E3QbvJt7mi4eAXaVJB3SKum+
 M5xSBC/PEZmU1h81APmviZFakiV0cDMDDhOT5tz2dLzgOvTOuryORB7O/FJFTM/Vi9oq
 4PiT1k3U4ZIu+PSFK9bwKq2qk80uQz8CPFZ8cK3YZe55n5hCtZyBPWtiX99G88wt6sBd
 kVMsve7859y731n42uC/MIBRg7TsoDWnBlGEch0i+xI9Japr+FaMbxXU//jafEwscJKO /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htt4a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 22:38:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJMcREK168207;
        Tue, 19 Nov 2019 22:38:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wc0ah5feg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 22:38:28 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJMcO6o028111;
        Tue, 19 Nov 2019 22:38:25 GMT
Received: from [192.168.1.2] (/98.210.179.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 14:38:24 -0800
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
Date:   Tue, 19 Nov 2019 14:38:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191119203138.GA13145@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190180
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/19/19 12:31 PM, Jason Gunthorpe wrote:
> On Mon, Nov 18, 2019 at 11:54:38AM -0800, rao Shoaib wrote:
>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>
>> Introduce maximum WQE size to impose limits on max SGE's and inline data
>>
>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>>   drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
>>   drivers/infiniband/sw/rxe/rxe_qp.c    | 7 +++++--
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 1b596fb..31fb5c7 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -68,7 +68,6 @@ enum rxe_device_param {
>>   	RXE_HW_VER			= 0,
>>   	RXE_MAX_QP			= 0x10000,
>>   	RXE_MAX_QP_WR			= 0x4000,
>> -	RXE_MAX_INLINE_DATA		= 400,
>>   	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>>   					| IB_DEVICE_BAD_QKEY_CNTR
>>   					| IB_DEVICE_AUTO_PATH_MIG
>> @@ -79,7 +78,9 @@ enum rxe_device_param {
>>   					| IB_DEVICE_RC_RNR_NAK_GEN
>>   					| IB_DEVICE_SRQ_RESIZE
>>   					| IB_DEVICE_MEM_MGT_EXTENSIONS,
>> +	RXE_MAX_WQE_SIZE		= 0x2d0, /* For RXE_MAX_SGE */
> This shouldn't just be a random constant, I think you are trying to
> say:
>
>    RXE_MAX_WQE_SIZE = sizeof(struct rxe_send_wqe) + sizeof(struct ib_sge)*RXE_MAX_SGE
I thought you wanted this value to be independent of RXE_MAX_SGE, else 
why are defining it.
>
> Just say that
>
>>   	RXE_MAX_SGE			= 32,
>> +	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE,
> This is mixed up now, it should be
>
>    RXE_MAX_INLINE_DATA = RXE_MAX_WQE_SIZE - sizeof(rxe_send_wqe)

I agree to what you are suggesting, it will make the current patch 
better. However, In my previous patch I had

RXE_MAX_INLINE_DATA		= RXE_MAX_SGE * sizeof(struct ib_sge)

IMHO that conveys the intent much better. I do not see the reason for 
defining RXE_MAX_WQE_SIZE, ib_device_attr does not even have an entry 
for it and hence the value is not used anywhere by rxe or by any other 
relevant driver.

I will re-submit with the changes you have suggested.

Shoaib


>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index aeea994..323e43d 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -78,9 +78,12 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
>>   		}
>>   	}
>>   
>> -	if (cap->max_inline_data > rxe->max_inline_data) {
>> +	if (cap->max_inline_data >
>> +	    rxe->max_inline_data - sizeof(struct rxe_send_wqe)) {
>>   		pr_warn("invalid max inline data = %d > %d\n",
>> -			cap->max_inline_data, rxe->max_inline_data);
>> +			cap->max_inline_data,
>> +			rxe->max_inline_data -
>> +			    (u32)sizeof(struct rxe_send_wqe));
> Then this isn't needed
>
> And this code in the other patch:
>
> +	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
> +			 init->cap.max_inline_data);
> +	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
> +	qp->sq.max_inline = wqe_size;
>
> Makes sense as both max_inline_data and 'init->cap.max_send_sge *
> sizeof(struct ib_sge)' are exclusive of the wqe header
>
> Jason
