Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB998C48
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfHVHMs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 03:12:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfHVHMs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 03:12:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M78pAi031486;
        Thu, 22 Aug 2019 07:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=0NRxzX8BxNs4uWBHiIcfM60enfXRWDPox17XpmTwAlY=;
 b=hGvojV7U0jRzW56AnydHJk0PQFT88zIbpFmSFdQjhFmBsiCKyN93taZsdVvV9qS6SJhn
 i6sHr2pZsQnNTrDzqowzt0DOgrPkl75Qu95UDF08F1bbx0Nw1pnMlGrVxAKU3Pf7f35/
 Eifd4OM6REUYpawqnaV4ico+IhYcu9yoQDDLZK3fZdLt495h6JCdZU6YMlFeJhWIXfDh
 h8zBtt9Fw5cS1h/zWmRzW5FF0p6tIFy83WXTFTxGc2LFoyqD8wy9XlNrQFo6bqUS6Lw+
 kqPWaX2IxL2Bkq4MBAugyhjF2LMFyoA6NqsQxwmf8Jor6GlQXNDuHl7B/NeU6Y25Vpl1 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ue9hpu56y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 07:12:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M79FRi037955;
        Thu, 22 Aug 2019 07:10:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uh2q5gsj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 07:10:31 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7M7ATHf006548;
        Thu, 22 Aug 2019 07:10:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 00:10:29 -0700
Date:   Thu, 22 Aug 2019 10:10:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
Message-ID: <20190822071023.GF3964@kadam>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
 <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
 <20190821125645.GE3964@kadam>
 <adc716f5d2105a3cc7978873cd0f14503ae323d8.camel@redhat.com>
 <20190821141225.GB8653@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821141225.GB8653@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220078
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 11:12:25AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 09:39:50AM -0400, Doug Ledford wrote:
> > On Wed, 2019-08-21 at 15:56 +0300, Dan Carpenter wrote:
> > > On Tue, Aug 20, 2019 at 12:05:33PM -0400, Doug Ledford wrote:
> > > > Please take a look (I pushed it out to my wip/dl-for-rc branch) so
> > > > you
> > > > can see what I mean about how to make both a simple subject line and
> > > > a
> > > > decent commit message.  Also, no final punctuation on the subject
> > > > line,
> > > > and try to keep the subject length <= 50 chars total.  If you have
> > > > to go
> > > > over to have a decent subject, then so be it, but we strive for that
> > > > 50
> > > > char limit to make a subject stay on one line when displayed using
> > > > git
> > > > log --oneline.
> > > 
> > > 50 is really small.
> > 
> > 50 is the vim syntax highlighting suggested limit.  You can go over,
> > which is why I indicated it was a soft limit, but there you are.  It
> > leaves room for the displayed hash length to grow as well.
> 
> I use 75 for all text in the commit message, as per
> Documentation/process/submitting-patches.rst
> 

My limit is 57 characters for the subject (because otherwise mutt
introduces a newline).  I sometimes go over but I'm annoyed when forced
to do that.

72 characters for the commit message because that's my limit for emails.

> People using 'git log --oneline' should have terminals wider than 80
> :)
> 
> The bigger question is if the first character after the subject tag
> should be uppper case or lower case <hum>

I feel like more and more people are moving to upper case.  There are
some people who insist on upper case and no one who insists on lower
case so it's easier to just make everything upper case.

regards,
dan carpenter

