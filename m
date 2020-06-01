Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715811EAE89
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 20:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgFASBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 14:01:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52670 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgFASBp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jun 2020 14:01:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051HrAJo101049;
        Mon, 1 Jun 2020 18:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AHke+bg16Z5eFtvtzQE+luqkCa/0wc68XqV/6ESZPME=;
 b=nTMVfaPdq7B4yo989SJoDn0hDwQ/Yoq8LnWD25djRrXr3/0t6tMByz1UakWsd25PKDbV
 bfc9zJ3U87FxkxrFiEAK7dLuH91B6dwN2xzUnIN1P410u4QoxuZg0+mJM3qBOlNSVl0j
 gk6sp6gKvgrebkWL6UXE/pLexaGfdcPpHQ8kQ44fvHEx2VYVvM7OzdFHktru890KitmE
 o/bhSc/YUCq5R1alF7gBNjkL+Y9t65MUkvCMaTkN3IWnLl50kR2L5AymTj7CBR/qj7Hu
 go4iJf33m64W8wi1DEVo5KcrApj9d1TGZNa3jku62pWgUO6e1U14rthZaw2jjEYBfmYE EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfem01sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 18:01:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051Hru8f029414;
        Mon, 1 Jun 2020 18:01:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31c18rvg12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 18:01:40 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 051I1cxv012436;
        Mon, 1 Jun 2020 18:01:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 11:01:38 -0700
Date:   Mon, 1 Jun 2020 21:01:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Message-ID: <20200601180131.GU22511@kadam>
References: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200530140224.GA1330098@mwanda>
 <20200601141450.GA24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601141450.GA24045@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006010134
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 01, 2020 at 11:14:50AM -0300, Jason Gunthorpe wrote:
> On Sat, May 30, 2020 at 05:02:24PM +0300, Dan Carpenter wrote:
> > The hfi1_vnic_up() function doesn't check whether hfi1_netdev_rx_init()
> > returns errors.  In hfi1_vnic_init() we need to change the code to
> > preserve the error code instead of returning success.
> > 
> > Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface Controller (VNIC) HW support")
> > Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2: Add error handling in hfi1_vnic_up() and add second fixes tag
> > 
> >  drivers/infiniband/hw/hfi1/vnic_main.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Applied to for-next with the 'if (rc)' fixup, thanks

Thanks.  I would have resent it, but it's a three day weekend here...

regards,
dan carpenter

