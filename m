Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C005FC2F7D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 11:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfJAJCx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 05:02:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35614 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732876AbfJAJCx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 05:02:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x918Xvd8145892;
        Tue, 1 Oct 2019 09:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Ss5NpWoU0ZtQE+xaK30GI2odKGwGDndDFGiADsg5f+o=;
 b=AmIJP46eDWMeMGVOKdEbvWtj6RAv6kkkd8oyqL0pDdJvgRP42W+k5v+/WoT8r1OdETyE
 ZXtnX3GCpdVEuLtaNeUyuGJNn3mzp+kQQop1WfGBZYDYkXzBDZCyJC01XD5v/zrnjZiI
 vfiBhC/+tWx2OyMkQPMk8ZAOZsRJ9Uu598LsbnyR51jd+b2jAuas9M6yS8IoBt4CvmGX
 7RLuXT9ez+lnNIWUxW93nK5GZRQukgoc3H6Ne9DwJmydrVq95wqgqnseraWt8l+2atQJ
 sPaPhTBTsDqGrM9Xj5RX8clZj5ZShWNDK10V5y3FdwTJY+jAtDl1rOemfp3vrFJ0EpDt 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v9yfq4ebw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 09:02:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x918WrbG006916;
        Tue, 1 Oct 2019 09:02:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vbmpy4m96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 09:02:39 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9192bnF026280;
        Tue, 1 Oct 2019 09:02:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 02:02:36 -0700
Date:   Tue, 1 Oct 2019 12:02:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/iw_cgxb4: Fix an error handling path in
 'c4iw_connect()'
Message-ID: <20191001090229.GK27389@kadam>
References: <20190923190746.10964-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923190746.10964-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010083
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 09:07:46PM +0200, Christophe JAILLET wrote:
> We should jump to fail3 in order to undo the 'xa_insert_irq()' call.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure which Fixes tag to use because of the many refactorings in this
> area. So I've choosen to use none :).
> The issue was already there in 4a740838bf44c. This commit has renamed
> all labels because a new fail1 was introduced. I've not searched further.
> 
> Naming of error labels should be improved. Having nowadays a fail5
> between fail2 and fail3 (because fail5 was the last
> error handling path added) is not that readable.
> However, it goes beyong the purpose of this patch.
> 
> Maybe, just using a fail2a, just as already done in 9f5a9632e412 (which
> introduced fail5) would be enough.

I think/hope that you're joking.  Anyway, these are GW-BASIC style
labels.  The other anti-pattern that we sometimes see is come-from
labels where the code does:

	foo = kmalloc();
	if (!foo)
		goto kmalloc_failed;

We've no clue what the goto does.  And another anti-pattern is generic
names where we have "goto out;" instead of a better label name which
says what the goto does "goto unlock;".  Otherwise we have to scroll
down every time we encounter a goto.

Imagine if we used the same anti patterns for naming functions:

	called_from_frob_1();
	called_from_frob_2();

And with a string of error lables like this if we name the error labels
after what the label frees then it makes auditing the function very
easy.

	one = alloc();
	if (!one)
		return -ENOMEM;

	two = alloc();
	if (!two) {
		ret = -ENOMEM;
		goto free_one;
	}

	three = alloc();
	if (!three) {
		ret = -ENOMEM;
		goto free_two;
	}

We only need to remember the most recently allocated resource.  And if
we need to update the function later then the patch is minimal because
we only need to change the one goto and the error label.  No need to
re-number everything.  You can audit a patch with properly named labels
from directly within your email client instead of needing to re-review
the whole function in the source.

regards,
dan carpenter
