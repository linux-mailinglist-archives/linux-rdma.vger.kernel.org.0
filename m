Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0763EB2AF9
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfINKXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Sep 2019 06:23:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfINKXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 14 Sep 2019 06:23:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8EAJZRS082514;
        Sat, 14 Sep 2019 10:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2019-08-05;
 bh=8cAlFpQWmXb+MUsbOx1IXdmIuwnRPgO45Rg1qMMMhU8=;
 b=G1vYo9DoukTark08vCkOlGzUH+iZ05RIMiq2fqApK55lPn3hBsYdigIjOUMTsM/nPLZe
 zVuJBR+NTPUxl1WB/s+JsKF1fSpvcA7w7ke16AFc9ianEkKumC6yBesmAa4qaLSipd+8
 DffIOsa0J+DmDRyLHkrLpP15XAXYOL0HEsYJ42Crd2G+Z2b+GG/tbH+oe1GNwz6Fx6X7
 q7oZ2LMqm8yxlPrIy7tTrDhO2VHmGJ0ecZXDbzL6NgiFq1JO/yta2/7k+RBFUXlbN7c0
 nyV8U76bSkjv7dh9oBddOYpOO4bi+1ybX6jyRgz1e1wnnhiBrugYRg98aDfn7jba5qp6 xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v0ruq8tnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 10:23:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8EAJOqg137945;
        Sat, 14 Sep 2019 10:23:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v0nb1m1ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 10:23:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8EAN3kn030428;
        Sat, 14 Sep 2019 10:23:04 GMT
Received: from dhcp-10-65-145-190.vpn.oracle.com (/10.65.145.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 14 Sep 2019 03:23:03 -0700
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: rdma_restrack_add/del in uverbs_cmd.c
Message-Id: <7259675D-4D9D-4204-9D9F-BCA3048442E4@oracle.com>
Date:   Sat, 14 Sep 2019 12:23:00 +0200
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
To:     OFED mailing list <linux-rdma@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=710
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909140107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=793 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909140107
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Sorry if this question has an obvious answer.

In uverbs_cmd.c::create_cq(), there is a call to rdma_restrack_add(). I =
cannot find the parenthetical corresponding rdma_restrack_del(). I do =
not see it in rdma_core.c nor in uverbs_cmd.c.

uverbs_destroy_uobject() calls the destroy_hw(), so it bypasses the (in =
this case)  ib_destroy_cq_user() which would have called =
rdma_restrack_del().

I am probably missing something obvious, so my apologies for this noise =
in advance.


Thxs, H=C3=A5kon

