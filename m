Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9139CD49
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 12:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfHZKaU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 06:30:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35826 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfHZKaU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 06:30:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QASpLn172062;
        Mon, 26 Aug 2019 10:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=gg/F2008xLqqk04E+7/hujm1Y0Z7+qjs2mihTbYp3Bo=;
 b=jwzYomrWSG3mjAv+gXUVZOizc5TEcnaeWI04IntqCT4DHZvgYwgRwUFACjcuhgjcvjjl
 TJTPx7QYMOkYXkhfql33DrHZMsT4bBMY3GuoyZi45jxCF2dmniZ6xc8aF/ICcljIlL4K
 2Zva9ie500dyklekDkg95bsLGjsoN9uJJzCd8F52889chQMK+WpIFIFFoP9R/2Bj/xF/
 TPB9QW1uJAXwgeyA/+Z758ETqnGpWl8yYQALrJFkeAeqNV9rZnyS7sqc1/XeulwLTxz1
 GEgSnZiBJeFibtr+Gq/4ZuBMiyf6U57+4cDrJNTcXvNs0WLYxehL7NWnGu1hvOcNCEoF eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ujwvq80vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 10:29:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QAT6Ot169201;
        Mon, 26 Aug 2019 10:29:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ujw6upqse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 10:29:38 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7QATZZ2012133;
        Mon, 26 Aug 2019 10:29:35 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 03:29:35 -0700
Date:   Mon, 26 Aug 2019 13:29:27 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
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
Message-ID: <20190826102926.GF3698@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
 <20190822170309.GC8325@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822170309.GC8325@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260117
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 05:03:15PM +0000, Jason Gunthorpe wrote:
> On Thu, Aug 22, 2019 at 09:58:42AM -0700, Ira Weiny wrote:
> 
> > Add to your list "how does destruction of a MR in 1 process get communicated to
> > the other?"  Does the 2nd process just get failed WR's?
> 
> IHMO a object that has been shared can no longer be asynchronously
> destroyed. That is the whole point. A lkey/rkey # alone is inherently
> unsafe without also holding a refcount on the MR.

You meant to say "can no longer be synchronously destroyed", right?

> 
> > I have some of the same concerns as Doug WRT memory sharing.  FWIW I'm not sure
> > that what SCM_RIGHTS is doing is safe or correct.
> > 
> > For that work I'm really starting to think SCM_RIGHTS transfers should be
> > blocked.  
> 
> That isn't possible, SCM_RIGHTS is just some special case, fork(),
> exec(), etc all cause the same situation. Any solution that blocks
> those is a total non-starter.
> 
> > It just seems wrong that Process B gets references to Process A's
> > mm_struct and holds the memory Process A allocated.  
> 
> Except for ODP, a MR doesn't reference the mm_struct. It references
> the pages. It is not unlike a memfd.
> 
> Jason
