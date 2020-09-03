Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C290825C68B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgICQSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 12:18:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgICQSn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 12:18:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083E3eub034459
        for <linux-rdma@vger.kernel.org>; Thu, 3 Sep 2020 14:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cSAHFLZMKXXeB8h3AYJ+bcAPeLW2/Pbvgir0hcPB4cY=;
 b=bazdg4y+GtMHsPtZQnjeBuziWnFWAE92IRrMvuNtJbtoYYI3PwcRXrhFbZ9zGMivU/57
 I6i/kPmYEZE/8PiELZFhA05JUXuaSTPqweNe1xKMfUSHj8fV5AqRS0Q4UoCZz/GacTmj
 lTotzCRo4TePlPACEP+ssEN6wj7ryuqPbAaxaBPGSKoE50VKvL+wXxBlCgDJBDbIhyVP
 FyX7B8H/Veg7ySdqW/aV4U97xKkDIC6l4wFyjam9SkN6iC8MYw6drbQzvI7SogknCX5A
 c3U66lFy8EerNBkWw98J9jizmIwppx9aYYEUo7CJI2mSBRUT7wxoOFcnbcIBoiJVK2I2 +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmn7cgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 14:04:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083E18B7055766
        for <linux-rdma@vger.kernel.org>; Thu, 3 Sep 2020 14:02:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380sw88w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 14:02:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 083E28vO004331
        for <linux-rdma@vger.kernel.org>; Thu, 3 Sep 2020 14:02:08 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 07:02:08 -0700
To:     linux-rdma@vger.kernel.org
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Subject: Finding the namespace of a struct ib_device
Organization: Oracle Corporation
Message-ID: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
Date:   Thu, 3 Sep 2020 22:02:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030131
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When a struct ib_client's add() function is called. is there a
supported method to find out the namespace of the passed in
struct ib_device?  There is rdma_dev_access_netns() but it does
not return the namespace.  It seems that it needs to have
something like the following.

struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
{
        return read_pnet(&ib_dev->coredev.rdma_net);
}

Comments?

Thanks.


-- 
K. Poon
ka-cheong.poon@oracle.com


