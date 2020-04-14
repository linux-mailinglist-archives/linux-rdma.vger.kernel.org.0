Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD33C1A8047
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405136AbgDNOsv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 10:48:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404893AbgDNOst (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 10:48:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EEjXqb009667
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 10:48:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30cxxqm13m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 10:48:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Tue, 14 Apr 2020 15:48:26 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 15:48:23 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03EEmehS47317270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 14:48:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 153CD4C046;
        Tue, 14 Apr 2020 14:48:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3B054C040;
        Tue, 14 Apr 2020 14:48:39 +0000 (GMT)
Received: from flex20.zurich.ibm.com (unknown [9.4.244.20])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 14:48:39 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        krishna2@chelsio.com
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO usage.
Date:   Tue, 14 Apr 2020 16:48:22 +0200
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041414-0012-0000-0000-000003A465E5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041414-0013-0000-0000-000021E19DAE
Message-Id: <20200414144822.2365-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_06:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=676 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140108
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Disabling GS0 usage lets siw create FPDUs fitting MTU size.
Enabling GSO usage lets siw form larger FPDUs fitting up to one
current GSO frame. As a software only iWarp implementation, for
large messages, siw bandwidth performance severly suffers from not
using GSO, reducing available single stream bandwidth on fast links
by more than 50%, while increasing CPU load.

Experimental GSO usage handshake is implemented by using one spare
bit of the MPA header, which is used to signal GSO framing at
initiator side and GSO framing acceptance at responder side.
Typical iWarp hardware implementations will not set or interpret
that header bit. Against such peer, siw will adhere to forming
FPDUs fitting with MTU size. This assures interoperability with
peer iWarp implementations unable to process FPDUs larger than
MTU size.

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 5cd40fb9e20c..a2dbdbcacf72 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -36,7 +36,7 @@ const bool zcopy_tx = true;
  * large packets. try_gso = true lets siw try to use local GSO,
  * if peer agrees.  Not using GSO severly limits siw maximum tx bandwidth.
  */
-const bool try_gso;
+const bool try_gso = true;
 
 /* Attach siw also with loopback devices */
 const bool loopback_enabled = true;
-- 
2.20.1

