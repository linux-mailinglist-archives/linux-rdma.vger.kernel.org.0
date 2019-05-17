Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C321ADB
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2019 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfEQPm4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 11:42:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfEQPm4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 May 2019 11:42:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4HFcpSx144254;
        Fri, 17 May 2019 15:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3CM987q037k3bX5mzRYTr6wnvS5FFAhILuIVJie0AyA=;
 b=f/ae1aSGcf9WpwnG/tGRi9RsrCz9zA2Zc3Qxojdvl+4HbwIN0Cxl66E/eV4jLADx3IzJ
 KlB1Zgg0p0AIxlRzVEWK8Ek8p/002sV2z4WUh4dQqTDEZFil6BEn90I0VRhGtQIiyGTQ
 pHE9dXTdLdcVhKAiu1iLyu1wpgqAMW6W1xDdStOObjw2VvSkGp8+Vozv/4Ow9EZe8xMh
 9G7UXiYmrfrnwdXmc0W8CWqKDmseXDw5YxSZ1OyX9ri7qQ6rNLtTttmiMhg5WHatBY5t
 LQIxdPtqx8Vx6m2Z1BXbVsF4kIB/fY3e4bqs98zvPuunNQST34saNQJ2jY3ynCCkiAto iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2sdq1r2fqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 15:42:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4HFgI1n083341;
        Fri, 17 May 2019 15:42:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sgkx4rx6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 15:42:53 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4HFgqcH023522;
        Fri, 17 May 2019 15:42:53 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 May 2019 08:42:52 -0700
Subject: Re: rdma-core debian packages
To:     Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <1774023a-1767-9884-7322-281e6873e167@oracle.com>
Date:   Fri, 17 May 2019 23:42:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9260 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905170095
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9260 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905170095
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/5/17 22:14, Steve Wise wrote:
> Hey,
>
> Is there a how-to somewhere on building the Debian rdma-core packages?

Which rdma-core version do you need?

Zhu Yanjun

>
> Thanks,
>
> Steve.
>
