Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049886C2AD
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfGQVhZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 17:37:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34920 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfGQVhY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 17:37:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HLXxwE147611;
        Wed, 17 Jul 2019 21:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=d0wUA1yvA+dL63dmC+wApSjkN3KEZ4oet082s8/ShIU=;
 b=NAZxUskqHSgT1xfR0Nqz2SmYjQtwNCECJbaCp6E0sIpOtlAKrr9hjyXYGBUTLpbfV0fk
 JOzptAqbb0jJ+tKc3Whnq335i49s5WUaAKIK0phaYh1Uk5KzRLBm9Oz4z5FkU99FgiAR
 CU6ZJg8w6Gp3Z9FJG9OsTyQYlJ98tIX3nsead4bcrg4GvturfgOTzeFCNSLNf2bFQrM/
 sENZCRBgo9oqQv7tJOIARXtw+tS4u3dmLNLN4IShwFs3h7fn6ocdAyVJVKqgdEa4dvzp
 aMukXULpwOsXPAcbWfgniVwohXgR5b2XW+6g3DGln9pxEUaKyWzdQBwYPEI1KSgQ30XZ BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tq78pwdap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 21:36:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HLRwsI012678;
        Wed, 17 Jul 2019 21:36:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tt77hcaw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 21:36:51 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6HLakYW013504;
        Wed, 17 Jul 2019 21:36:47 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 21:36:46 +0000
Date:   Thu, 18 Jul 2019 00:36:37 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190717213636.GA2797@lap1>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
 <20190717193313.GN12119@ziepe.ca>
 <20190717203112.GA7307@lap1>
 <20190717204505.GD32320@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717204505.GD32320@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170239
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=872 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170240
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 01:45:05PM -0700, Matthew Wilcox wrote:
> On Wed, Jul 17, 2019 at 11:31:12PM +0300, Yuval Shaia wrote:
> > On Wed, Jul 17, 2019 at 04:33:13PM -0300, Jason Gunthorpe wrote:
> > > Like I said, drivers that require the creating ucontext as part of the
> > > PD and MR cannot support sharing.
> > 
> > Even if we can make sure the process that creates the MR stays alive until
> > all reference to this MR completes?
> 
> The kernel can't rely on userspace to do that.

ok, how about this: we know that for MR to be shared the memory behinds it
should also be shared.

In this case, i know it sounds horrifying but do we care that the process
that originally created this MR exits? i.e. how about just before the
process leaves this world we will find some other ucontext to hold these
memory mappings that driver holds?
Or how about moving this mapping from ucontext pointed by ib_mr directly to
ib_mr?

Yuval
