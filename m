Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDBC36D8B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFFHnh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 03:43:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42848 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHng (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 03:43:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x567cR4L172223
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 07:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ompnr7uDAyI7oD2G+wA5L5iWSPcHjYrrQHjiGbk2dwE=;
 b=SNQ6MwrwnGIqsXFd8XjDyan3BvoDYW3YAZ/IJ0i9iuWn3MPl7Joo+7IKXbfZL6fIyZmX
 sEXS80NC5lm8rT92xQNU32G8GmijUe6uTEeJ5AJvbXf3n+OmiM+MvTk/TkKACQuzshTa
 wkH7b1U1QTUBp+9rbrHSOvc/INAJI2Br9sZVO7FnOlIYCctp72l8UZUhDfzc8A2s1H/k
 fRrUzqr1e7uM0Ok441k6O3MMcYbCqfFBeFy3GvYopTaV+654zl/96h7PNbSBkPm9EoAl
 gchUOZV7dEzllByFTb7cke/xUtCZGdrIXCOMdm3GvW2PxprLJJco47SRa54TWqT12FLs 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2suevdq1xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 07:43:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x567gbnQ111575
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 07:43:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2swnham801-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 07:43:34 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x567hXmG027889
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 07:43:33 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 00:43:32 -0700
Subject: Re: cma::addr_handler
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
References: <3B7DEF8D-966E-4C75-9A6D-A55A7B323A4F@oracle.com>
 <200e4a4b-1151-bcb1-08a8-55e21a393e9c@oracle.com>
 <3D94AAFD-3023-4721-94F3-B2937F14A4E5@oracle.com>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <17744e0d-9a0a-e533-0d34-0347f91ce443@oracle.com>
Date:   Thu, 6 Jun 2019 15:43:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3D94AAFD-3023-4721-94F3-B2937F14A4E5@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060055
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/6/6 15:14, Håkon Bugge wrote:
>
>> On 6 Jun 2019, at 08:24, Yanjun Zhu <yanjun.zhu@oracle.com> wrote:
>>
>> How to handle "status = 0 && id_priv->cma_dev !=NULL"?
>>
>> "if (!status && !id_priv->cma_dev)"  is false.
>>
>> "} else if (status) {" is also false.
> Exactly, we do not want to print an error message (status != 0) when there is no error (status == 0).

status  cma_dev

0          NULL                           "if (!status && 
!id_priv->cma_dev)" is true

0          !NULL                          No print

!0         NULL                           "} else if (status) {" is true

!0         !NULL                          "} else if (status) {" is true

I think your change is good.:-(

Zhu Yanjun

>
> Thxs, Håkon
>
>> Zhu Yanjun
>>
>> On 2019/6/5 21:40, Håkon Bugge wrote:
>>> Said function contains:

>>>
>>> 	if (!status && !id_priv->cma_dev) {
>>> 		status = cma_acquire_dev_by_src_ip(id_priv);
>>> 		if (status)
>>> 			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to acquire device. status %d\n",
>>> 					     status);
>>> 	} else {
>>> 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
>>> 	}
>>>
>>> Now, assuming status == 0 and the device already has been acquired (id_priv->cma_dev != NULL), we get the "error" message:
>>>
>>> RDMA CM: ADDR_ERROR: failed to resolve IP. status 0
>>>
>>> Probably not intentional.
>>>
>>> So, would we agree to have:
>>>
>>> 	} else if (status) {
>>> 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
>>> 	}
>>>
>>>
>>> instead?
>>>
>>>
>>> Thxs, Håkon
>>>
>>>
