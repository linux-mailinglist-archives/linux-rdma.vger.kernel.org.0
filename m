Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74489E3AD7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406401AbfJXSVC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 14:21:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404839AbfJXSVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 14:21:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OIE4IB180616;
        Thu, 24 Oct 2019 18:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=69mEkWyKPJuOBslK+ikozLYlujnZRqf1n1Pfn/oZ9p8=;
 b=lQ+YOLsIPp4XyrrlEA2ljUWGi00PGRpP/hJpSQPbacOa1ZjVR9wbWUBeb2Tk2VAzTnmv
 fAjVbxYgdyqUMMWlVXLLkfRJdmLlJRaIcTlqGksiS5SMmrTH4euQyQVCkV4Sc5CyzseD
 gD60PXtSCXCDwyZy5oHSgsAreK9pJG5VT+LbKG1KxCCeGlmjbT5Q9an2IbJk7IzWLkaf
 XbUWFH1/GTgE9qK/wPfMpDkLh++YuJiIqGh/m10J0L+6QK3LdcQEO6x9WO9WtZfeOwSU
 0c47pBBRd1KgvsMXnraTMM07YJhiySWrAHQ+XuAVQg56DOyYsiSbKgV5oL3DcDgUorUX Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4r57xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 18:20:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OIDJwK154421;
        Thu, 24 Oct 2019 18:20:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vug0bvv23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 18:20:52 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9OIKoQv029693;
        Thu, 24 Oct 2019 18:20:50 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 18:20:50 +0000
Date:   Thu, 24 Oct 2019 21:20:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: prevent undefined behavior in
 hns_roce_set_user_sq_size()
Message-ID: <20191024182039.GB23523@kadam>
References: <20190608092514.GC28890@mwanda>
 <20191007121821.GI21515@kadam>
 <20191024163749.GX23952@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163749.GX23952@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240172
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 01:37:49PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2019 at 03:18:22PM +0300, Dan Carpenter wrote:
> > This one still needs to be applied.
> > 
> > regards,
> > dan carpenter
> 
> Weird, it is marked changes requested in patchworks. An email must
> have been lost??
>

Maybe you replied to a different thread?

> I think I probably wanted to say that:
> 
> > >  	/* Sanity check SQ size before proceeding */
> > > -	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
> > > +	if (ucmd->log_sq_bb_count > 31 ||
> > > +	    (u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes
> > > ||
> 
> Overall should probably be coded using check_shl_overflow(), as this
> later shift:
> 
> 	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;
> 
> Is storing it into an int and hardwring '31' because it magically
> matches that lower shift is pretty fragile.
> 
> More like this?
> 

Yeah.  I like your patch.  I'd feel silly claiming authorship though.
I'm willing to, because it's nice, but probably you should just give me
Reported-by credit instead.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

