Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7872D1ADC1F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgDQL0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 07:26:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42686 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgDQL0t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Apr 2020 07:26:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HBOxtT112760;
        Fri, 17 Apr 2020 11:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2O0V3yblK/29tvWyAvBHQUZ86B8G/e/jVaheTAg9ans=;
 b=NW9h3C7l12IBiw3dwnhbItGHVe+6NB4UKB4+7UPW5vT91Y60g/arwqpQ3lh5UGmbyeqO
 p2eEbhI74qD+NqeKdDkkoIuB4UbK3eTKI13UpccLSwMuyTrAMhUBS7Hx4NMmBC7d8RyF
 SfrBD6hBkk9WWK4QQwFFqUG6A2pfMA8yLMNHvvRmVwdhBNFzBOsx7xoEHxwsPp5th4rj
 cAubsGgVjpyVHc2KT17rEZ7a6DBA19GSf91Oi8L2FNNy991jl0+tN8AAKWA1J3V3UYW2
 Zhw132HJLj0yiB5DwLmE4jRP41oym7DpKrTBxdb4TIMR42l4cgO6kQcHhT7TNBqSfQOO Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30dn95xk6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 11:26:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HBLMwB040528;
        Fri, 17 Apr 2020 11:26:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30dn91c893-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 11:26:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03HBQb78005629;
        Fri, 17 Apr 2020 11:26:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 04:26:37 -0700
Date:   Fri, 17 Apr 2020 14:26:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        roland@purestorage.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200417112624.GS1163@kadam>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
 <20200416184754.GZ5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416184754.GZ5100@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9593 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170091
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 03:47:54PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 16, 2020 at 04:08:47PM +0300, Dan Carpenter wrote:
> > On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> > > The memcpy is still kind of silly right? What about this:
> > > 
> > > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > > {
> > > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > > 	int cpy_len;
> > > 
> > > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > > 	if (cpy_len >= len || cpy_len < 0) {
> > 
> > The kernel version of snprintf() doesn't and will never return
> > negatives.  It would cause a huge security headache if it started
> > returning negatives.
> 
> Begs the question why it returns an int then :)

People should use "int" as their default type.  "int i;".  It means
"This is a normal number.  Nothing special about it.  It's not too high.
It's not defined by hardware requirements."  Other types call attention
to themselves, but int is the humble datatype.

regards,
dan carpenter
