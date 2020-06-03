Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9A1ED025
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCMs0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 08:48:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58048 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgFCMsY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 08:48:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053CmIMd015704;
        Wed, 3 Jun 2020 12:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LK18kfHfIcf6ndEoZk28n33cQSqV40zTpBxSFMJrxjo=;
 b=qCeWg8Hb98ydboU3z5GjY6doMPPbmw7M7G+TtDWcW/sx1pUNTQsZ0qUdDt8bSSCCNjPc
 T+vfzB7jtEbfkg41TZBuzq1aIS8JbhchnkqzelnGsEWZnLVIqITSTsyNUcwyKruLEgkz
 t5V93Fa849mGuVn7r57fnKjviCA8dUaPSLIiyUdJ1gyXt3Vr3FMEigNMHHgfErevwISd
 xcPWMxnBQ/NO5Hn9vy/33YME2bQIdxxEaoIHAI3L/1niFERXHktxtWhZRlIbxPHriHD/
 PlhEUUIqUaMcm5NAJA3/ehp4L4R876BuMzvV7pkGSALrF6xdM6awb527IUPd6DzWBcHo BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31bewr14r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 12:48:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053Ci06D112868;
        Wed, 3 Jun 2020 12:46:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31c25s1nh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 12:46:21 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053CkKl0003345;
        Wed, 3 Jun 2020 12:46:20 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 05:46:19 -0700
Subject: Re: A question about cm_destroy_id()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <8d6802a1-1706-0c01-78bf-0cdd3fea0881@oracle.com>
 <20200603115532.GG6578@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <134e6cca-5e7e-25c6-7504-b785f60727a0@oracle.com>
Date:   Wed, 3 Jun 2020 20:46:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603115532.GG6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030100
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/3/20 7:55 PM, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2020 at 04:53:57PM +0800, Ka-Cheong Poon wrote:
>> Suppose the cm_id state is IB_CM_REP_SENT when cm_destroy_id() is
>> called.  Then it calls cm_send_rej_locked().  In cm_send_rej_locked(),
>> it calls cm_enter_timewait() and the state is changed to IB_CM_TIMEWAIT.
>> Now back to cm_destroy_id(), it breaks from the switch statement.  And
>> the next call is WARN_ON(cm_id->state != IB_CM_IDLE).  The cm_id state
>> is IB_CM_TIMEWAIT so it will log a warning.  Is the warning intended in
>> this case?
> 
> Yes the warning is intended, most likely the break should be changed
> to goto retest


Like this?

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 17f14e0..1c2bf18 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1076,7 +1076,9 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
         case IB_CM_REP_SENT:
         case IB_CM_MRA_REP_RCVD:
                 ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-               /* Fall through */
+               cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
+                                  0, NULL, 0);
+               goto retest;
         case IB_CM_MRA_REQ_SENT:
         case IB_CM_REP_RCVD:
         case IB_CM_MRA_REP_SENT:




-- 
K. Poon
ka-cheong.poon@oracle.com


