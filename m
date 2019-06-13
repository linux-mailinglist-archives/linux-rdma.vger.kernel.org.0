Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BDE445A0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfFMQpM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 12:45:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbfFMGID (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 02:08:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D63qqV176201;
        Thu, 13 Jun 2019 06:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=brt7ejG03HkNmk1GNVjb6IlhfoJkTWrsNhNa3NwDIh0=;
 b=pvEqreaysHPDto5rBCa+vVIkz/d8RXBxEmkZnvuWz3JLjm1FR6g72rm6p5MgyivhAY1i
 sWYvDrzsEhiudWMuPiJU4Sr2fQZHxNo/q55Bfnn+3/ZTcDW/qUO/Oeyc1aqMJ1vx+neN
 fj4kqzY1jtDaV3m5hk5+ZmeAVt4Lx5mpSjiGbvK9SX1qe7QrJSKzEROUUyh1lUf/6Z8t
 W3l10b9rgA/K0XO2/e16yQJdQcbzzbQ4gT8tWfzNKsbtwe9Tutf9e3+DvgxwZoCVHmra
 Lw2FA8ImquFUPnFwjvqvk8DC6SG7CJx6FGmY3iBpyplcaZ5PMhMMHkscEHSchZktEsnW NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t05nqyaju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 06:07:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D64wVu055937;
        Thu, 13 Jun 2019 06:05:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t04j09jbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 06:05:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5D65R4J002458;
        Thu, 13 Jun 2019 06:05:27 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 23:05:25 -0700
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20190613060517.GF1915@kadam>
Date:   Wed, 12 Jun 2019 23:05:17 -0700 (PDT)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_set_user_sq_size()
References: <20190608092714.GE28890@mwanda>
 <20190612172316.GU6369@mtr-leonro.mtl.com>
In-Reply-To: <20190612172316.GU6369@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=892
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=942 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130049
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 08:23:16PM +0300, Leon Romanovsky wrote:
> On Sat, Jun 08, 2019 at 12:27:14PM +0300, Dan Carpenter wrote:
> > This function is supposed to return negative kernel error codes but here
> > it returns CMD_RST_PRC_EBUSY (2).  The error code eventually gets passed
> > to IS_ERR() and since it's not an error pointer it leads to an Oops in
> > hns_roce_v1_rsv_lp_qp()
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Static analysis.  Not tested.
> >
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > index ac017c24b200..018ff302ab9e 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -1098,7 +1098,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
> >  	if (ret == CMD_RST_PRC_SUCCESS)
> >  		return 0;
> >  	if (ret == CMD_RST_PRC_EBUSY)
> 
> The better fix will be to remove CMD_RST_PRC_* definitions in favor of
> normal errno.
> 

Yes.

I've looked at that idea and I would almost feel like it's easy enough
to send a patch like that without testing it at all.  But it would be
better if the people with the hardware sent it.  I reported this bug
months ago...

regards,
dan carpenter
