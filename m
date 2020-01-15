Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF1813CDAC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 21:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgAOUFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 15:05:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41698 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgAOUFP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 15:05:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FJsYRj159328;
        Wed, 15 Jan 2020 20:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=gyDthlyFU7qngJOjt5wFT45Eoa0mJNNxsALA0YG9p84=;
 b=Fbq1ONyfo9UVx9WRUhdV4aIidvDS22t/9x7pEnMlD7QJi2vTr6JzzFLOFnGUWDUMbOev
 bRxUcoPUtCxaR8kozJktbGJBun0Lobzqoq+sozLeR6GJbIN0Xm1S5vJ8Y59rEhvNwKbJ
 ohSxcQHUsPW3PHTBKhLdugkWSnP5ms1V9/5FqvFjVb32jRC2dRz3rAIK5DYWpJLJ7Asf
 I6uSBopo54KARJOmfRnS5P31jjEqIslzsvsX8IX1iVjBnRnKz2cShSpDKSvubudF/QI4
 vlo6nIQfVq2jl3goR2CWGDTPCxNLz6yNHe2K+j0/gw7cRd1n2gxAfzm4S0SOyjZHbGKF lQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xf73txc97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 20:05:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FJsag8191303;
        Wed, 15 Jan 2020 20:05:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xhy220edh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 20:05:06 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00FK54CV004135;
        Wed, 15 Jan 2020 20:05:04 GMT
Received: from [10.159.151.219] (/10.159.151.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 12:05:04 -0800
Subject: Re: [PATCH v3 2/2] SGE buffer and max_inline data must have same size
From:   Rao Shoaib <rao.shoaib@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, monis@mellanox.com,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-kernel@vger.kernel.org
References: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
 <1578962480-17814-3-git-send-email-rao.shoaib@oracle.com>
 <20200115182721.GE25201@ziepe.ca>
 <93b8e890-c4a9-6050-88b7-3667c023dd34@oracle.com>
Message-ID: <70651c3f-e5cb-2a33-1682-6564255e2307@oracle.com>
Date:   Wed, 15 Jan 2020 12:05:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <93b8e890-c4a9-6050-88b7-3667c023dd34@oracle.com>
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


On 1/15/20 11:57 AM, Rao Shoaib wrote:
>
>> I seem to recall the if the requested max can't be satisified then
>> that is an EINVAL?
>>
>> And the init->cap should be updated with the actual allocation.
>
> Since the user request for both (sge's and inline data) has been 
> satisfied I decided not to update the values in case the return values 
> are being checked. If you prefer that I update the values I can do that.
>
> Shoaib
>
In my original v1 patch I did update init->cap, I must have overlooked 
it. I will resubmit the patch with that change once I hear back from you 
about the enforcement.

Shoaib

