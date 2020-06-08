Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5D1F1B3F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2020 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgFHOqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jun 2020 10:46:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbgFHOqe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jun 2020 10:46:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058EcDgU096384;
        Mon, 8 Jun 2020 14:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=WbGBBzWBgaHtrxRJxw5NrKuajctvYp+XZBeYx3b9Yg4=;
 b=Cp8DftuEj1YZh+zqAwz4YO1DTouUjbm9oLTDid3ZKuIBr46JNdQLIVnp6Y8tWAfw2Pbm
 TEbWeDGQJyoQuzNBLnAKUIE/uqnlv14V96bJMSEp1+ZlGr9+94cKhcbxM+LnJa45fvTW
 h06SbUaXiI6MrfZJ8+TlaGxU+DWnjC6Wn4Nhg480/ammGdBh8wKCKFA5zfhBM+vXC5jm
 hrNQFCvaJiRCdx1/Y55xDErGWDrjQALOeVvvsizZ6dGQAlLTQ4mmetX9MtdyiweRBLWJ
 T9oUq0XuOk/34gm+XGgyksSyTE2f6rxejs+4FyJ0JCgP+hhBcmZh9fh9UYC9//M6uNPC Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jqy9gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 14:46:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058EgIAn132818;
        Mon, 8 Jun 2020 14:46:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31gn22yn8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 14:46:28 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058EkP4U021311;
        Mon, 8 Jun 2020 14:46:25 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 07:46:25 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Review Request 
Date:   Mon,  8 Jun 2020 07:46:15 -0700
Message-Id: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=940
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=2
 lowpriorityscore=0 bulkscore=0 mlxlogscore=976 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg

Hi,

Please review the patch that follows. 

v3 addresses the previously raised concerns. Changes include -

1. To resolve the race where the timer can kick in before request
has been sent out, we now add the request to the list after sending out
the request.

2. To handle the race where the response can come in before we got a 
chance to add the req to the list, sending and adding the request to
request list is done under spinlock - request_lock.

3. To make sure there is no blocking op/delay while holding the spinlock,
using GFP_NOWAIT for memory allocation.

Thanks Jason for providing your valuable feedback. 

Let me know if you have any suggestions or concerns.

Thanks,
Divya
