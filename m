Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540911ECBEC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 10:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFCIyI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 04:54:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCIyI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 04:54:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0538kShS010894
        for <linux-rdma@vger.kernel.org>; Wed, 3 Jun 2020 08:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=4CyeZg2PFTV0/j6ryEHgI2gem2Vm0ihJk+LFe9H15Ls=;
 b=EzXsvpTS2ZZAHIRqz9jSiDAH0yNqqpLB8qgoHBBXyObQfXGDOnwGBoEheTRBxdmsAw21
 dHvvxJi52y0f87Cai3mvu/GnuuPFKmYq3PPS7pKryGoFRle760Fg/PJQ5q3FL8gO4K63
 WOiPD+THwS/l6CA+bExSBpiimliWNyxm2IqV9oTrqH/nIYSNiC9nvqxl4W4Xm80+T0nD
 g131AhUBoGJJNE/oyfox7ch9lkanxswAMLbexVdDAhSHJeqYhSVEZT9ysa6g+XN/cypL
 eRyjBRbUFVPcKd20lBbfRvQtkel0aOQb8US4KMwWzIYrY1983aJ9mXXlphmd8TINCTpV Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfem8342-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 08:54:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0538m1Ap152350
        for <linux-rdma@vger.kernel.org>; Wed, 3 Jun 2020 08:54:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31dju2wntq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 08:54:06 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0538s5m2023713
        for <linux-rdma@vger.kernel.org>; Wed, 3 Jun 2020 08:54:05 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 01:54:04 -0700
To:     linux-rdma@vger.kernel.org
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Subject: A question about cm_destroy_id()
Organization: Oracle Corporation
Message-ID: <8d6802a1-1706-0c01-78bf-0cdd3fea0881@oracle.com>
Date:   Wed, 3 Jun 2020 16:53:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=731
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=785 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030069
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Suppose the cm_id state is IB_CM_REP_SENT when cm_destroy_id() is
called.  Then it calls cm_send_rej_locked().  In cm_send_rej_locked(),
it calls cm_enter_timewait() and the state is changed to IB_CM_TIMEWAIT.
Now back to cm_destroy_id(), it breaks from the switch statement.  And
the next call is WARN_ON(cm_id->state != IB_CM_IDLE).  The cm_id state
is IB_CM_TIMEWAIT so it will log a warning.  Is the warning intended in
this case?

Thanks.


-- 
K. Poon
ka-cheong.poon@oracle.com


