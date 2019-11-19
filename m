Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EB103075
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 00:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKSX5s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 18:57:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfKSX5r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 18:57:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJNnfIb066835;
        Tue, 19 Nov 2019 23:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=tfuEuFk0YvAERfq+sH36ftSgtj/+gMSIC9nQN57hpgw=;
 b=MfMZQu0C+huaUzWzUspz03OIco+elBoNw1syMizQ9zgArUITChgtfCnMlzBVO8puxQxZ
 7MahJQNU3SUPR8uCEkTvZLq5e/z+1fSlr7+XaaJEIYl3tKPto4wap1BBV+vdo6FP1y/t
 ZsMhSKS89NOAUvOuEyWWORV2Wthy1C3yx+bUgRbn+4TES+N2VoKWhBh49E4OZs/n848y
 lZ2rk/HEtEOPP7sEPR5CE20o8SqE1RMNTNvPpjCM0PTnCapeKw0M4KwNsGehYbEu31af
 Hv8gtV1T90ejxleBxfLdDyFCRdZnKTLf/Msf6APl5F7j0VMwvz9k0L+0zxt9tp0wobIM aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wa9rqj8ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 23:57:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJNmjF5119257;
        Tue, 19 Nov 2019 23:55:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wc09y8518-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 23:55:38 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJNtad2008965;
        Tue, 19 Nov 2019 23:55:37 GMT
Received: from [10.159.234.241] (/10.159.234.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 15:55:36 -0800
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
 <20191119231334.GO4991@ziepe.ca>
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
Date:   Tue, 19 Nov 2019 15:55:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191119231334.GO4991@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190188
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/19/19 3:13 PM, Jason Gunthorpe wrote:
> On Tue, Nov 19, 2019 at 02:38:23PM -0800, Rao Shoaib wrote:
>> On 11/19/19 12:31 PM, Jason Gunthorpe wrote:
>>> On Mon, Nov 18, 2019 at 11:54:38AM -0800, rao Shoaib wrote:
>>>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>>>
>>>> Introduce maximum WQE size to impose limits on max SGE's and inline data
>>>>
>>>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>>>>    drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
>>>>    drivers/infiniband/sw/rxe/rxe_qp.c    | 7 +++++--
>>>>    2 files changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>>>> index 1b596fb..31fb5c7 100644
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>>>> @@ -68,7 +68,6 @@ enum rxe_device_param {
>>>>    	RXE_HW_VER			= 0,
>>>>    	RXE_MAX_QP			= 0x10000,
>>>>    	RXE_MAX_QP_WR			= 0x4000,
>>>> -	RXE_MAX_INLINE_DATA		= 400,
>>>>    	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>>>>    					| IB_DEVICE_BAD_QKEY_CNTR
>>>>    					| IB_DEVICE_AUTO_PATH_MIG
>>>> @@ -79,7 +78,9 @@ enum rxe_device_param {
>>>>    					| IB_DEVICE_RC_RNR_NAK_GEN
>>>>    					| IB_DEVICE_SRQ_RESIZE
>>>>    					| IB_DEVICE_MEM_MGT_EXTENSIONS,
>>>> +	RXE_MAX_WQE_SIZE		= 0x2d0, /* For RXE_MAX_SGE */
>>> This shouldn't just be a random constant, I think you are trying to
>>> say:
>>>
>>>     RXE_MAX_WQE_SIZE = sizeof(struct rxe_send_wqe) + sizeof(struct ib_sge)*RXE_MAX_SGE
>> I thought you wanted this value to be independent of RXE_MAX_SGE, else why
>> are defining it.
> Then define
>
>     RXE_MAX_SGE = (RXE_MAX_WQE_SIZE - sizeof(rxe_send_wqe))/sizeof(rxe_sge)
>
> And drive everything off RXE_MAX_WQE_SIZE, which sounds good
>
>>> Just say that
>>>
>>>>    	RXE_MAX_SGE			= 32,
>>>> +	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE,
>>> This is mixed up now, it should be
>>>
>>>     RXE_MAX_INLINE_DATA = RXE_MAX_WQE_SIZE - sizeof(rxe_send_wqe)
>> I agree to what you are suggesting, it will make the current patch better.
>> However, In my previous patch I had
>>
>> RXE_MAX_INLINE_DATA		= RXE_MAX_SGE * sizeof(struct ib_sge)
>>
>> IMHO that conveys the intent much better. I do not see the reason for
>> defining RXE_MAX_WQE_SIZE, ib_device_attr does not even have an entry for it
>> and hence the value is not used anywhere by rxe or by any other relevant
>> driver.
> Because WQE_SIZE is what you are actually concerned with here, using
> MAX_SGE as a proxy for the max WQE is confusing
>
> Jason

My intent is that we calculate and use the maximum buffer size using the 
maximum of, number of SGE's and inline data requested, not controlling 
the size of WQE buffer. If I was trying to limit WQE size I would agree 
with you. Defining MAX_WQE_SIZE based on MAX_SGE and recalculating 
MAX_SGE does not make sense to me. MAX_SGE and inline_data are 
independent variables and define the size of wqe size not the other wise 
around. I did make inline_dependent on MAX_SGE.

Your and my preferences can be different but you are the maintainer and 
what you say goes. We have had a good discussion and I am going with 
your previous suggestion.

Kind Regards,

Shoaib

