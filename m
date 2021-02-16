Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75631CC68
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBPOur (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 09:50:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhBPOup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Feb 2021 09:50:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GEiHde031910;
        Tue, 16 Feb 2021 14:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=s8E34fpVYOJjv98pQmJAiDJ5VEBMaO0+JOmHubATa4w=;
 b=O0SIVD0hcvGAJN7MIp94S7Z8stdCJsGdMqC3MEB1KM8T+athzHj+JmpdR20Bk7Wj60Za
 Cyfl8ebkaw8KxRyrHC8TIQLmkvVQXf1sKHH1FWiJS9qZhMeSGOIpeR3ta8dOYrnUnKlO
 sZDSz1N/9eIdxhLwLvPmC3dOJ2/TFu+XpCPjkdQCdWWWOnrS1+EySAeRsWkBsnQQhg0Z
 ueHYeR/WDBVj6r8lyGcxo1ooht6VBXLWn2UNH0jHTAOEJnr5ch90UoOHmnhG9DeGOQTf
 //CSoiTmXwfANIGtnVNs48BgW5+rL1CjUeV+GJR+vDJA3rq75rxbQs/GyclWRkfASy21 QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dneye0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 14:49:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GEjWUD023419;
        Tue, 16 Feb 2021 14:49:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36prhrkvh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 14:49:49 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11GEnkmB026288;
        Tue, 16 Feb 2021 14:49:46 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Feb 2021 06:49:46 -0800
Date:   Tue, 16 Feb 2021 17:49:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: Suppress warnings passing zero to
 'PTR_ERR'
Message-ID: <20210216144938.GG2222@kadam>
References: <20210216143807.65923-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216143807.65923-1-jinpu.wang@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160136
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160136
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 16, 2021 at 03:38:07PM +0100, Jack Wang wrote:
> smatch warnings:
> drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'
> 
> Smatch seems confused by the refcount_read condition, the solution is
> protect move the list_add down after full initilization of rtrs_srv.

In theory if Smatch had a properly up to date DB then it would print a
different warning "passing a valid pointer to PTR_ERR()".

regards,
dan carpenter

