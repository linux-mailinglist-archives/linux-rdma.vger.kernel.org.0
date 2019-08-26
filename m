Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54919CCDB
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfHZJwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 05:52:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59974 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfHZJwN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 05:52:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q9njep148812;
        Mon, 26 Aug 2019 09:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=AofGiavqy7kN80UK0w7Mf+Oih3479kgW4tmzEhq9JX4=;
 b=WXAanZjEerFFS+0GkqpFocsmxKZibDLJCIBB71nSTvaVG2/JatedwFbCT3O/BgLxWKqn
 ju4u9p36yBKnG2sVbxOQxeafMewaheHZ8qLvb0eHpzc9U6GzOCMYeNn3dbc1AgoC6gq2
 aAmQ88WrodhuAi5ot+3QOYGtQNK7j3Lt2jVpjmVu4lf0w51bteLrTV5XlXsRjq0rJjJt
 gM2iEvNGT01etnc6goigKkZGEKW+6HTBPmi8mw+Q+9IiHRlmqAZXpuTN6yXJxCVMA07Y
 WqebmCDrOqqJQ5ZlMvCfTBATlvIp3LUSx1x3M6PMHqYlXvp0wjgAn3NcW7h0+C0y1noH Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ujw6yyy8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 09:51:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q9mx9I110135;
        Mon, 26 Aug 2019 09:51:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ujw79bu71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 09:51:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7Q9paOU019924;
        Mon, 26 Aug 2019 09:51:36 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 09:51:36 +0000
Date:   Mon, 26 Aug 2019 12:51:26 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190826095126.GC3698@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
 <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=988 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > 
> > > 
> > > What is the "key" that allows a MR to be shared among 2 processes?  Do you
> > > introduce some PD identifier?  And then some {PDID, lkey} tuple is used to ID
> > > the MR?
> > > 
> > > I assume you have to share the PD first and then any MR in the shared PD can be
> > > shared?  If so how does the MR get shared?
> > 
> > Sorry, i'm not following.
> > I think the term 'share' is somehow mistake, it is actually a process
> > 'imports' objects into it's context. And yes, the workflow is first to
> > import the PD and then import the MR.
> 
> Ok fair enough but the title of the thread is "Sharing PD and MR" so I used the

You are right, my bad, will change the cover letter and some commit
messages accordingly.

> term Share.  And I expect that any random process can't import objects to which
> the owning process does not allow them to right?
> 
> I mean you can't just have any process grab a PD and MR and start using it.  So
> I assume there is some "sharing" by the originating process.

Any process that connects to the socket that the SCM_RIGHT message is
relayed on. I guess that if this mechanism exist then importing the actual
objects is just a supplemental service.

> 
> > 
