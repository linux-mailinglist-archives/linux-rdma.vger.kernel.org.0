Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C989F16AE0B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 18:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgBXRwg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 12:52:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXRwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 12:52:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OHleB2078876;
        Mon, 24 Feb 2020 17:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4ryUop9jiRj86RDFaok9VEpBkXqfxpeaTvmO3NSFsN8=;
 b=x5T6lYhBoznphpA72OT02pM+fXIHGANbbl5ReTDzmUWa8/QtYYpv8cLIJmzQifyhDDek
 RqzzhQ593ymP8KxyJ+V6Cfu13bHNvzklWM3jRDbrb66Vf7Pg3IvQJZVZpUZmQFYdamQJ
 LyHcmeYvumjBeqYatNgvl2exxtiwKbJKheeh+o4NsPpCKmAqig0SQUPOMh2gCWV4pA5c
 hH1CwdxQfgt1N/u9cfEM9+pbVYezFs4tL/BbZ6f+1d2qFlZ2Gy0KPiogpBWi5jjqQMKF
 +TkWDD06FtimTIcJhgUVKl67GW2M8vXLIcGz3T3g5I4tY8nacGInfbDjkh56uKlOM57X Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ybvr4n90f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 17:52:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OHmYgb135304;
        Mon, 24 Feb 2020 17:52:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2ybduuvw2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 17:52:33 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01OHqWFA145303;
        Mon, 24 Feb 2020 17:52:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ybduuvw1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 17:52:32 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OHqVrJ014345;
        Mon, 24 Feb 2020 17:52:31 GMT
Received: from [10.209.227.41] (/10.209.227.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 09:52:31 -0800
Subject: Re: [PATCH] net/rds: Fix a debug message
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hans Westgaard Ry <hans.westgaard.ry@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, kernel-janitors@vger.kernel.org
References: <20200224103215.utw3zaa6nmcb5vrz@kili.mountain>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <d5188793-68c3-b2a3-d4d8-fbf8d5d9ff88@oracle.com>
Date:   Mon, 24 Feb 2020 09:52:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200224103215.utw3zaa6nmcb5vrz@kili.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240132
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/24/20 2:32 AM, Dan Carpenter wrote:
> This should display the error code but instead it just prints "1".
> 
> Fixes: 2eafa1746f17 ("net/rds: Handle ODP mr registration/unregistration")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
Right.

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
