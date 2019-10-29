Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1857E8FFA
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 20:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfJ2TbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 15:31:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55262 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJ2TbW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 15:31:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TJSmcH030842;
        Tue, 29 Oct 2019 19:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Je70oog1C51FTi7jCQQ1fCUjNy5E69wjO9Mhp3rlIp4=;
 b=rohmjOlQHx42xiyy428MvtqAkoyKLQRY8/xoiGlo/DrtanFMknfwJcYra2M8FuRbwxnP
 68mHtPiNJpjOESliTkFL6Fcji48/7tqiMObcPQQm2dgdXAjPmKuyJifyE3VykOezJuNo
 T3vSRm/8QqnoW0SWa4KtvBSpNRJLqTncvfCzQ/F3pde1kvVdboKm0zCqlb9uDpHE9vwb
 6iMtnc39oV05fKzElvL4YC3GZH48qSdD0dgNWsvrmXZfyP5JqA9KTid2HB+6M4dlQTtH
 +wYr5CHLvFpFASYm1/ZmhDLiZxPd33pjqnAWlnO3xN0ZoCQBu3EGhPKE6/zLh+JF1EBh iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vve3qbewy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 19:31:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TJTWq0064195;
        Tue, 29 Oct 2019 19:31:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vxpgfh960-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 19:31:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TJV4qs022644;
        Tue, 29 Oct 2019 19:31:04 GMT
Received: from [10.159.243.118] (/10.159.243.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 12:31:04 -0700
Subject: Re: [PATCH v1 1/1] rxe: calculate inline data size based on requested
 values
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1571851957-3524-1-git-send-email-rao.shoaib@oracle.com>
 <1571851957-3524-2-git-send-email-rao.shoaib@oracle.com>
 <20191029191155.GA10841@ziepe.ca>
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <4c23244e-44bf-2927-6b9d-17c4d279ebe3@oracle.com>
Date:   Tue, 29 Oct 2019 12:31:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029191155.GA10841@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290167
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Thanks for the comments, please see inline.

On 10/29/19 12:11 PM, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2019 at 10:32:37AM -0700, rao Shoaib wrote:
>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>
>> rxe driver has a hard coded value for the size of inline data, where as
>> mlx5 driver calculates number of SGE's and inline data size based on the
>> values in the qp request. This patch modifies rxe driver to do the same
>> so that applications can work seamlessly across drivers.
> This description doesn't seem accurate at all, and this patch seems to
> be doing two things:
I thought the note described the change, I will try harder next time.
>
>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>>   drivers/infiniband/sw/rxe/rxe_qp.c    | 4 ++++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 1b596fb..657f9303 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -68,7 +68,6 @@ enum rxe_device_param {
>>   	RXE_HW_VER			= 0,
>>   	RXE_MAX_QP			= 0x10000,
>>   	RXE_MAX_QP_WR			= 0x4000,
>> -	RXE_MAX_INLINE_DATA		= 400,
>>   	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>>   					| IB_DEVICE_BAD_QKEY_CNTR
>>   					| IB_DEVICE_AUTO_PATH_MIG
>> @@ -81,6 +80,7 @@ enum rxe_device_param {
>>   					| IB_DEVICE_MEM_MGT_EXTENSIONS,
>>   	RXE_MAX_SGE			= 32,
>>   	RXE_MAX_SGE_RD			= 32,
>> +	RXE_MAX_INLINE_DATA		= RXE_MAX_SGE * sizeof(struct ib_sge),
>>   	RXE_MAX_CQ			= 16384,
>>   	RXE_MAX_LOG_CQE			= 15,
>>   	RXE_MAX_MR			= 2 * 1024,
> Increasing RXE_MAX_INLINE_DATA to match the WQE size limited the
> MAX_SGE. IMHO this is done in a hacky way, instead we should define a
> maximim WQE size and from there derive the MAX_INLINE_DATA and MAX_SGE
> limitations.
There was already RXE_MAX_SGE defined so I did not define MAX_WQE. If 
that is what is preference I can submit a patch with that. What is a 
good value for MAX_WQE?
>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index aeea994..45b5da5 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -229,6 +229,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   {
>>   	int err;
>>   	int wqe_size;
>> +	unsigned int inline_size;
>>   
>>   	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>>   	if (err < 0)
>> @@ -244,6 +245,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   			 sizeof(struct rxe_send_wqe) +
>>   			 qp->sq.max_inline);
>>   
>> +	inline_size = wqe_size - sizeof(struct rxe_send_wqe);
>> +	qp->sq.max_inline = inline_size;
>> +	init->cap.max_inline_data = inline_size;
> Whatever this is doing. Is this trying to expand the supported inline
> data when max_sge is provided? That seems reasonable but
> peculiar. Should be it's own patch.
Yes that is what it is dong same as mlx5 which takes the larger of the 
two values reqquested and bumps the other. I will submit a separate patch.
>
> Also don't double initialize qp->sq.max_inline in the same function,
> and there is no need for the temporary 'inline_size'

I used a separate variable as I would have to repeat the calculation 
twice. I do not understand your comment about double initialization, can 
you please clarify that for me.

Thanks,

Shoaib

>
> Jason
>
>
>>   	qp->sq.queue = rxe_queue_init(rxe,
>>   				      &qp->sq.max_wr,
>>   				      wqe_size);
>> -- 
>> 1.8.3.1
>>
