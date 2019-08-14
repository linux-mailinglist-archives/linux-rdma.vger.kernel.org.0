Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B951C8D57B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfHNOAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 10:00:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfHNOAm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Aug 2019 10:00:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EDwbw5070362;
        Wed, 14 Aug 2019 14:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=90xGyy1ITT+ME0I1VV4EmGapgnMTBq2qrf2gaMSB2Sg=;
 b=h4sMk7gfy57lzDfcRa12wBKOOOld4PhpXYP3zG2WMe22hsBydxymmNNcjdytcMlzNKcL
 PSsUs2aiMhJMUClEh6G82ejeN3DZxH1WFD80Woc2dJ2aGexfAlhFChldd3EzoCaigvVC
 msuaXjIZJ/te3Tc1QHIqwnUl7oSFCGa5Hsr0ymJGH86t1AN0+TYum2O8doxRfZapl6i0
 4Z7WIC99EO0XzZzig8OsqFzoAtYs2AoXVcnSO+//UTq1mwxSm/JDb0HMrTv3NsUw/NLT
 lZel1iQoM59mKQdg+r2GfYqZSXN5d5RsEBG310zOTA7nd+5SRdCLpMxnyt0zPsL2Rmvp OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u9nbtn31c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 14:00:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EDvOFc194164;
        Wed, 14 Aug 2019 14:00:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ubwqt8ku7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 14:00:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7EE0YSP025068;
        Wed, 14 Aug 2019 14:00:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 07:00:33 -0700
Date:   Wed, 14 Aug 2019 17:00:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vlad Buslov <vladbu@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] net/mlx5e: Extend encap entry with reference counter
Message-ID: <20190814140025.GA24910@kadam>
References: <20190814105302.GA14514@mwanda>
 <vbfpnl73lhc.fsf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbfpnl73lhc.fsf@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140145
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 14, 2019 at 01:49:54PM +0000, Vlad Buslov wrote:
> >   1447
> >   1448                          if (mlx5e_is_offloaded_flow(flow)) {
> >   1449                                  counter = mlx5e_tc_get_counter(flow);
> >   1450                                  lastuse = mlx5_fc_query_lastuse(counter);
> >   1451                                  if (time_after((unsigned long)lastuse, nhe->reported_lastuse)) {
> >   1452                                          mlx5e_flow_put(netdev_priv(e->out_dev), flow);
> >   1453                                          neigh_used = true;
> >   1454                                          break;
> >
> > I think we need to call mlx5e_encap_put(netdev_priv(e->out_dev), e);
> > before this break;
> 
> We are breaking from the inner loop (not returning from the function,
> just breaking the innermost loop) here after releasing the reference to
> flow which was obtained at the beginning of the loop.
> 

Oh...  Duh.  I am embarrassed.  I misread it to think we were breaking
from the outer loop.

regards,
dan carpenter

