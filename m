Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7D97A09
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfHUM5P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 08:57:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUM5P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 08:57:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LCrpiH193860;
        Wed, 21 Aug 2019 12:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=FqRMXuoagecAv6BT0jIeDP4/ljzxgl7Gd7buLWT/xm4=;
 b=i9/omhZPf5Dwqmn0+kHPmTJ5Vk++xoxsAPS2Kb8TNu+8tLmS731SBCtHb51incH6SfuA
 KKw3+aVwHiNU6gRtbwDSN0rPpkh1nIxkP7suy5ExSEBMdX1LLwi0E0Vcqor+adn3J47d
 a31pTT1a1zoUsNAyEgiEbH37pzDM7toRBrlChOOVi6E+mKTPow6hOjCF5yhlvjQvXJEQ
 1Rk407/f5ZX08JdN3XRQ032vihuLJEOprb5TQ9LkqLFx92G+ALme3GKUZjx7zPBJW1QZ
 scevpCz2UQSpHyjL9EUXm5DNa+Q8zUQQD71H4d14Gn9iSUOzTZlUDuc/T63rgp5dHyHJ UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uea7qwcs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 12:57:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LCrvGq056574;
        Wed, 21 Aug 2019 12:57:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ug26a0cqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 12:57:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LCv10X002062;
        Wed, 21 Aug 2019 12:57:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 05:57:01 -0700
Date:   Wed, 21 Aug 2019 15:56:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
Message-ID: <20190821125645.GE3964@kadam>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
 <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210142
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 20, 2019 at 12:05:33PM -0400, Doug Ledford wrote:
> Please take a look (I pushed it out to my wip/dl-for-rc branch) so you
> can see what I mean about how to make both a simple subject line and a
> decent commit message.  Also, no final punctuation on the subject line,
> and try to keep the subject length <= 50 chars total.  If you have to go
> over to have a decent subject, then so be it, but we strive for that 50
> char limit to make a subject stay on one line when displayed using git
> log --oneline.

50 is really small.  If it were based on git log --oneline output the
limit would be 67 characters.  If you look at actual kernel git commits
then the average subject is 52.4 characters and probably the upper bound
is 60+ or so.

I was surprised how well I had done personally at generating subjects
when I looked at my own git log.

My shortest subject was commit 0746556beab1 ("bna: off by one").  That
was from 10 years ago and is not up to my current standards.  My longest
was commit 49d3d6c37a32 ("drivers/misc/sgi-gru/grukdump.c: unlocking
should be conditional in gru_dump_context()"), but originally I used
"gru:" as the patch prefix and Andrew changed it.  :P

regards,
dan carpenter
