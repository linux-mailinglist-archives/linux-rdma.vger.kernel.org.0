Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE583406A6
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 14:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhCRNOo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 09:14:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhCRNOk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Mar 2021 09:14:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IDC9j5153454;
        Thu, 18 Mar 2021 13:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Ecwrj8jb1QXZw/9K/vKdjiZiJTx3End40LMKibuERkg=;
 b=g497Wlyj1r6QTz2SePkPCPoaYbX5Oi+lBRSB7JH4FDlpnGC1pXgjQJ7JZtvHqdoY1tc0
 80CkwxeKHE0Gl/Pc5BV1/0X6n6qUSvhbS+9EVvtP4lPrjmQDooEpNVHwFmfePyIWAu7P
 K55Zyk127SBu8P5aYht3mXK9xoBFm1aXSLVBm/OsP5fF7ALd2OoP8gBtNbNyuxcLmOB/
 6XnJLdFHqxy3f6O/LP8iKpAgw2BclmLFMZABckDc0BrmqlRZ2/1o8xB499iHxcJYOqZx
 85wGXMyIzfyk4OY+hTNKTr/cMkZrrYWBET0V/kBpFkCpDRZQC7AQ0f3HV52FBLgU1Xpc rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 378p1nydbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 13:14:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ID5xRd103055;
        Thu, 18 Mar 2021 13:14:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3797a3xmbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 13:14:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12IDERop019064;
        Thu, 18 Mar 2021 13:14:27 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Mar 2021 06:14:27 -0700
Date:   Thu, 18 Mar 2021 16:14:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     liangwenpeng@huawei.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/hns: Add support for XRC on HIP09
Message-ID: <YFM1hQ4p/uL7zyRY@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=820 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=777 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180097
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Wenpeng Liang,

The patch 32548870d438: "RDMA/hns: Add support for XRC on HIP09" from
Mar 4, 2021, leads to the following static checker warning:

	drivers/infiniband/hw/hns/hns_roce_pd.c:143 hns_roce_xrcd_alloc()
	warn: passing casted pointer 'xrcdn' to 'hns_roce_bitmap_alloc()' 32 vs 64.

drivers/infiniband/hw/hns/hns_roce_pd.c
   141  static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
   142  {
   143          return hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap,
   144                                       (unsigned long *)xrcdn);

The hns_roce_bitmap_alloc() is going to write a ulong to &xrcd->xrcdn
so this will lead to memory corruption.

   145  }
   146  

regards,
dan carpenter
