Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAC98E6A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfHVIxR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 04:53:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbfHVIxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 04:53:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M8mjJH123836;
        Thu, 22 Aug 2019 08:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=X83Zf6t2ysawDB+ludLhW8/Gp1P4f5lPrmPlNaXIcHc=;
 b=G9EKpGbyAc4eJddSnBlfOfd1U92nYInH2HmgAEO2fmG39pMmVm1PA1XffQog59Rlo/VW
 tm2JhdDtkm3jronLa1bOXnC9n7yJm/s8ShQ1w/x3GlOkIlGJq4t+4AgjHAvc28xQ8r6u
 E4JRcacedhhMFCUK9IGfCzgv4PqFOTKpOXWec6lKviyoYyv+0Ix17j3xLkgQH972bbri
 Eyq1yv2HcH4yKxhVXIio+7h2647e5zGAq+f46vXS36xDtTqADcDOqZcyzaNEeNmzQy7G
 E5TF1QJU2UDZl0eIHhzMd5KSNU0xZ0snNAxmexSHBZDlClpAiBQUXyWy6dBIhjagbc0k SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uea7r3xsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:52:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M8mWA2066319;
        Thu, 22 Aug 2019 08:50:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ugj7qvd6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:50:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7M8odqF003142;
        Thu, 22 Aug 2019 08:50:39 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 01:50:38 -0700
Date:   Thu, 22 Aug 2019 11:50:30 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190822085029.GB2898@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821145011.GA8667@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821145011.GA8667@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220097
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 02:50:16PM +0000, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 05:21:01PM +0300, Yuval Shaia wrote:
> > Following patch-set introduce the shared object feature.
> > 
> > A shared object feature allows one process to create HW objects (currently
> > PD and MR) so that a second process can import.
> > 
> > Patch-set is logically splits to 4 parts as the following:
> > - patches 1 to 7 and 18 are preparation steps.
> > - patches 8 to 14 are the implementation of import PD
> > - patches 15 to 17 are the implementation of the verb
> > - patches 19 to 24 are the implementation of import MR
> 
> This is way too big. 10-14 patches at most in a series.

I agree with you.
Actually i had an offline discussion with Shamir on that.
Shamir view point here is that he wanted to split things to smaller pieces
to ease the maintenance (git bisect etc) and code review.

So we have two options now, one is to split this patch-set into two
separate patch-sets, one will deal with preparation (infrastructure and
cleanups) and second with the actual feature. Or second option is to merge
some patches, e.x. the patches that installs the hook in providers code
could be merged.

Not to break Shamir's work i tend to go with the first option.

Shamir, what do you think?

Yuval

> 
> Jason
