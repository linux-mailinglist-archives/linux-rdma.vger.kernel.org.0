Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440F413CD94
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 20:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgAOT5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 14:57:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42652 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAOT5V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 14:57:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FJsV6a174162;
        Wed, 15 Jan 2020 19:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=5ZDwyoI8+PLdwrash2W6XsD4UspgG+i2MlaqGgMjC4U=;
 b=QJ/JIVZvc28zM+OFKfi+yCenziwV0YsPWO9EoKy/5xXTUElQFXFjsbWQoI2NyUuylp26
 xTUhp/MjkZYKg10uugDmezyYyLoxaTPIW/1G/LFmePIcJ6xDDv9T4Va1aUYqwjtx7tBt
 I4OnOHuby3/eoIgKToM51xBJdjuqQ2RJ0q1b58JlVzx3xL/vZy/ldno2OxgkYQOXwaKK
 ZKir6VIQPpK2M21kItZIb8T6hxX0ZZjC8jt571fMqWevhy1EyypQh6b9LbNdAtSrY4QE
 4a9a67droZEHA+COn4sRjOP7LaPLxdqhcvBK+PaHjHHKk/zk7t7+2+Jh64JxDx7L/0Wu ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73ypd47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 19:57:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FJsaXx191225;
        Wed, 15 Jan 2020 19:57:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xhy2201yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 19:57:12 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FJvABT004993;
        Wed, 15 Jan 2020 19:57:10 GMT
Received: from [10.159.151.219] (/10.159.151.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 11:57:10 -0800
Subject: Re: [PATCH v3 2/2] SGE buffer and max_inline data must have same size
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, monis@mellanox.com,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-kernel@vger.kernel.org
References: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
 <1578962480-17814-3-git-send-email-rao.shoaib@oracle.com>
 <20200115182721.GE25201@ziepe.ca>
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <93b8e890-c4a9-6050-88b7-3667c023dd34@oracle.com>
Date:   Wed, 15 Jan 2020 11:57:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115182721.GE25201@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150153
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/15/20 10:27 AM, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2020 at 04:41:20PM -0800, rao Shoaib wrote:
>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>
>> SGE buffer size and max_inline data should be same. Maximum of the
>> two values requested is used.
>>
>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>>   drivers/infiniband/sw/rxe/rxe_qp.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index aeea994..41c669c 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -235,18 +235,17 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   		return err;
>>   	qp->sk->sk->sk_user_data = qp;
>>   
>> -	qp->sq.max_wr		= init->cap.max_send_wr;
>> -	qp->sq.max_sge		= init->cap.max_send_sge;
>> -	qp->sq.max_inline	= init->cap.max_inline_data;
>> -
>> -	wqe_size = max_t(int, sizeof(struct rxe_send_wqe) +
>> -			 qp->sq.max_sge * sizeof(struct ib_sge),
>> -			 sizeof(struct rxe_send_wqe) +
>> -			 qp->sq.max_inline);
>> -
>> -	qp->sq.queue = rxe_queue_init(rxe,
>> -				      &qp->sq.max_wr,
>> -				      wqe_size);
>> +	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
>> +			 init->cap.max_inline_data);
>> +	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
>> +	qp->sq.max_inline = wqe_size;
>> +
>> +	wqe_size += sizeof(struct rxe_send_wqe);
> Where does this limit the user's request to RXE_MAX_WQE_SIZE ?

My understanding is that the user request can only specify sge's and/or 
inline data. The check for those is made in rxe_qp_chk_cap. Since max 
sge's and max inline data are constrained by RXE_MAX_WQE_SIZE the limit 
is enforced.

>
> I seem to recall the if the requested max can't be satisified then
> that is an EINVAL?
>
> And the init->cap should be updated with the actual allocation.

Since the user request for both (sge's and inline data) has been 
satisfied I decided not to update the values in case the return values 
are being checked. If you prefer that I update the values I can do that.

Shoaib

>
> So more like:
>
>          if (init->cap.max_send_sge > RXE_MAX_SGE ||
>             init->cap.max_inline_data > RXE_MAX_INLINE)
>              return -EINVAL;
>
> 	wqe_size = max_t(int, init->cap.max_sge * sizeof(struct ib_sge),
> 			 init->cap.max_inline_data)
>                     sizeof(struct rxe_send_wqe);
> 	qp->sq.max_sge = init->cap.max_send_sge = wqe_size/sizeof(struct ib_sge);
> 	qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
> 	wqe_size += sizeof(struct rxe_send_wqe);
>
> Jason
