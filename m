Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED428D89
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 00:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfEWW5i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 18:57:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59446 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfEWW5h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 18:57:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4NMn50I049673;
        Thu, 23 May 2019 22:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=r97GFBWHVFnmnZT11YzSCpLXMvyRyF1lpX2DQ00xREI=;
 b=WgGhh/5P6QVrkzWbGKrXZN4atlM0NOXpcBssaKz5xNDzE1A6IoaAQXXFf2E1UFjAp2UI
 AvQ4CRBrqyxx+km4pNyBxXE7b3x85fpNZex6EC0GzC8UjJVJw1ibyfDhy6mkjRj5UEn+
 DZ0bxs4+ww2DXDgOeLh6LsxlaRoFfFb3B6SE/UkPjSKsR/RzS7f/dFYgvsqUIZ9Tm1QF
 TkeUP4yd/R4suSu+VlW71YoTWHlUgassi9HfGVhoHDkMjnO8r6bLHCraIS/BYQon9Fn0
 Aw+KxpXfNN3GR6+0lNRhzGl3JICyU6D07m2Mw6IQVrd0PpgrPl4kkH0ZmDLJ1aOsim0w 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2smsk5dg7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 22:57:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4NMu9aA128273;
        Thu, 23 May 2019 22:57:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2smsh2hncg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 22:57:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4NMvVHK001050;
        Thu, 23 May 2019 22:57:31 GMT
Received: from [10.211.54.54] (/10.211.54.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 May 2019 22:57:30 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Subject: <infiniband/verbs.h> & ICC
Message-ID: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
Date:   Thu, 23 May 2019 15:57:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905230147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905230147
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Trying to compile <infiniband/verbs.h> with ICC (Intel's C/C++ Compiler)
leads to the following error:

--------%<--------%<--------%<--------%<--------
error: enumeration value is out of "int" range
         IBV_RX_HASH_INNER = (1UL << 31),
--------%<--------%<--------%<--------%<--------

IMO, ICC is correct here, because according to ISO-C99:
--------%<--------%<--------%<--------%<--------%<--------
6.4.4.3  Enumeration constants
 Semantics
  identifier declared as an enumeration constant has type int
--------%<--------%<--------%<--------%<--------%<--------

Since "int" is signed, it can't hold the unsigned value of 1UL<<31
on target platforms with sizeof(int) <= 4.

(In other words: that would be the sign-bit on two's complement machines).

The line causing this was introduced by:
--------%<--------%<--------%<--------%<--------%<--------
commit 3a4e353e9030a7d066e6f39f4f561f7b3f01a857
Author: Maor Gottlieb <maorg@mellanox.com>
Date:   Thu Aug 17 15:00:05 2017 +0300

    verbs: Add support in RSS of the inner packet
    
    Some user space application would like to do RSS on the inner packet
    fields instead of the outer. When user will set the IBV_RX_HASH_INNER
    bit with one of the other hash fields, then the RSS will be on the inner
    packet.
    
    Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
    Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
--------%<--------%<--------%<--------%<--------%<--------


Can you shed some light on whether or not verbs.h is supposed
to compile with ICC (i.e. if it's supported), and what the level
of appetite is to make this work?

It's trivial to fix this, but there's benefit in making this part
of a regression test suite (e.g. Travis).


Thanks,

  Gerd
