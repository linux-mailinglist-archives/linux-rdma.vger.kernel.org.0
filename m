Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46C234E4E
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Aug 2020 01:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGaXQm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 19:16:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59478 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaXQl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 19:16:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VN4Kpr022212;
        Fri, 31 Jul 2020 23:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=5sWs0WGedzdHSQgMqmPHEFlx9f0iJX49gAPJaoBvslI=;
 b=Ou+Xo2rJCtA8cMMek84hrnkB2Mwx7JpxEgcGdgYdHpXLvbnnowP7CVYRUmBD4T/bDuK0
 QL+ErbEFSToMUrLMKcfiaIkzvjQeRTZ0Nlcm1yhSjWBcnnH9c0U7I+f2Y2ryt/9pW6CX
 3X1RVHVpsuoIT6xhMUSJps8c/SXtDopPbZrCq5tNotuPyvf6sjH7A5wAfpvyB1+ndHGV
 QXTVaKN/f+cEAfffK57FWiiYHUq5b2BuarNPDNOI4lw1UyB0VW+ha9gcIrZ4ArlgmKIv
 bY8AfZaTMegWNdqajCvJzKsQl4U9S3xNl0DgdwB7iqJ9jtsRB91xK0k3Zfd+SVEym98Z Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1jum07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 23:16:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VN2tDl108487;
        Fri, 31 Jul 2020 23:14:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32hu60hkgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 23:14:37 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VNEa0b030111;
        Fri, 31 Jul 2020 23:14:36 GMT
Received: from [10.65.174.86] (/10.65.174.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 16:14:36 -0700
To:     linux-rdma@vger.kernel.org, ayal@mellanox.com, tariqt@mellanox.com
From:   sharath.srinivasan@oracle.com
Subject: ibv_devinfo -ve max_mcast_qp_attach value with MLX4 driver - known
 issue?
Organization: Oracle Corporation
Message-ID: <2e49ee91-6e22-a5b5-a3e1-fdc2e6c96106@oracle.com>
Date:   Fri, 31 Jul 2020 16:14:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310164
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I have a CX3/IB card (MLX4 driver) assigned to a Xen VM and notice the 
following with/without the below patch applied. Is this a known issue 
and are there any fixes available for it? I couldn't find any references 
to it and thought I should check with the list/author. I do not see this 
issue with baremetal or KVM, but only on a Xen VM. Thanks.

1. ibv_devinfo with patch a40ded604365 applied (all other HCA attribs 
are OK):/
# ibv_devinfo -v | grep max_mcast_qp_attach/
/max_mcast_qp_attach: -8
/

2. ibv_devinfo without patch a40ded604365 applied:/
///# ibv_devinfo -v | grep max_mcast_qp_attach/
/max_mcast_qp_attach: 248
/ /

//

-----------------------------------------------------------------------------
commit a40ded6043658444ee4dd6ee374119e4e98b33fc
Author: Aya Levin <ayal@mellanox.com>
Date:   Tue Jan 22 15:19:44 2019 +0200

     net/mlx4_core: Add masking for a few queries on HCA caps

     Driver reads the query HCA capabilities without the corresponding 
masks.
     Without the correct masks, the base addresses of the queues are
     unaligned.  In addition some reserved bits were wrongly read.  
Using the
     correct masks, ensures alignment of the base addresses and allows 
future
     firmware versions safe use of the reserved bits.

     Fixes: ab9c17a009ee ("mlx4_core: Modify driver initialization flow 
to accommodate SRIOV for Ethernet")
     Fixes: 0ff1fb654bec ("{NET, IB}/mlx4: Add device managed flow 
steering firmware API")
     Signed-off-by: Aya Levin <ayal@mellanox.com>
     Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>
-----------------------------------------------------------------------------

Thanks,
Sharath

