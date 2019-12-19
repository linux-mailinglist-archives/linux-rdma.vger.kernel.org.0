Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7E126DBE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 20:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfLSTL5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 14:11:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60540 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfLSSh3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Dec 2019 13:37:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJIRKut040429;
        Thu, 19 Dec 2019 18:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=6VMYi03ucpKRxaK+aRiAulrKES+92kJ5vwbETKnXJTg=;
 b=nP0dp7dl8t4EUJQ7Fi36v526PnHIr5hBJ1CC4MzOPmHOjnffyiYdVCZ5CP3OGWfYn6IZ
 XRwFksgGgXkNjofQI2nKX+5hAmif8v5PQx1v8WFHFlR+B5f22yQbc7S+1Hp/CDtHJNJD
 rW4+zELA/c+zkuO0QwUXNcG5/R4YGqzk5YGqMwL0AI+rsvDiyJk2DAmMb4EfU6LXWUSB
 AH2O5oMrzYSOSJTrQVVoNFYoiT47iHdhq13u6HFghFj6h7D9TYCJUrhnzbFr/Qn/Q4sD
 NQPrX1MBqADjqBFDvzjTVYG3TBM1p23/zJT2wkDqi2W9FCCji9nClagDdctNA38M3/50 ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2x0ag11p43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 18:37:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEKcj035094;
        Thu, 19 Dec 2019 18:37:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wyxqj3x8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 18:37:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJIbGuk032674;
        Thu, 19 Dec 2019 18:37:16 GMT
Received: from [192.168.1.2] (/98.210.179.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 10:37:16 -0800
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
 <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
 <20191120000840.GQ4991@ziepe.ca>
 <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
 <20191219182511.GI17227@ziepe.ca>
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <91987df4-8853-a087-97a0-a2f09f906340@oracle.com>
Date:   Thu, 19 Dec 2019 10:37:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219182511.GI17227@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=707
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=746 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

I thought I had addressed the comments and literally did what you 
suggested. Sorry if I missed something, can you please point it out.

Shoaib

On 12/19/19 10:25 AM, Jason Gunthorpe wrote:
> On Tue, Dec 17, 2019 at 11:38:52AM -0800, Rao Shoaib wrote:
>> Any update on my patch?
>>
>> If there is some change needed please let me know.
> You need to repost it with the comments addressed
>
> https://patchwork.kernel.org/patch/11250179/
>
> Jason
>
