Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935321D34A8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgENPL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 11:11:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgENPL6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 11:11:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EF7Yx0156344;
        Thu, 14 May 2020 15:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=W5qVfAEYN6DvUKh3fbVgysVbZ0iYZ+xqjITUo/qjVxk=;
 b=vh56I13QxGTIITfiUHrhUTHX1C69DL5dswVXWOhJgt1GTxSGJu6UCC3OQCoelYFLUI42
 5AXk7SnDYRLjda1fNfMNfihjSHbionRzzdW1qz1etVbX9kBx/1/C1Y7hPStxkwPKdirL
 JcNkyGEBnZlm/Vs7zeSbSV/+MvMUx9OOoseMSkF/8DdfZwCWKjpOsBmXbZw8NVSlBGUB
 +8Umb+9fGHW/GxYrxJeuroTjqaigdWTMYxSjX82EfYekfZlOoc5wffgD5zcWa9GFiLGX
 y1EWv/qTP5L4SL36wg8oKbgzd9VxUCWvn7271qWdh7nYvxK/61hz5gd15FKqsjlL754o Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3100xwk60e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 15:11:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EF8PYm047021;
        Thu, 14 May 2020 15:11:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3100ygy1ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 15:11:52 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04EFBoxQ005948;
        Thu, 14 May 2020 15:11:51 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 08:11:46 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Review Request
Date:   Thu, 14 May 2020 08:11:23 -0700
Message-Id: <1589469084-15125-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=2 adultscore=0 mlxscore=0 mlxlogscore=929
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=2 mlxlogscore=951 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140133
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[PATCH v2] IB/sa: Resolving use-after-free in ib_nl_send_msg.

Hi,

This is the v2 of the patch that addresses the comments received for v1 -

- Using atomic bit ops for setting and testing IB_SA_NL_QUERY_SENT.
- Rewording and adding comments.


Thanks,
Divya
