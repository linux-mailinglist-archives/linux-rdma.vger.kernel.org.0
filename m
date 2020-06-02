Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6170F1EC1FB
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFBSjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 14:39:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33058 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgFBSjP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jun 2020 14:39:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052IWQaw023483;
        Tue, 2 Jun 2020 18:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xtfXkYTOk8D7WL7U+lHQ9ITr5AwuMgBCV1KLh2eKvPQ=;
 b=ajoYi9Pb635zGxmx5JfLm/UDp3nYiRhRDzWUvYeKfgRoDz2vjc13BnoCNQarr2zn+qIY
 S/jxiz+0DR6JLp6pQznnv54mibGN/TjK3fPm/Bn1ho54HsxEbMQv78THZ5GE5THbeV0A
 J22418WCD2HXW3TkkKe1ufOTIZvnHUlxY0k5dT6L3blh2ouJYWJjgB2WTkcw1WBZtRzX
 C13B2svLq2Cdj9Bd4hJMFIEfqDoAp7n22C78KNER9wn1R4EWhBSEdG98463TbNA7qTj+
 HvRUx9ZU8fqQQaWZ3KmMECLIQqfsEE27pl0/7KGtwT37AWecl1R5cFMGGq3NnmW33A2h sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfem5gk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 18:39:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052IXwVs106339;
        Tue, 2 Jun 2020 18:39:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25pq0hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 18:39:05 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052Id4F9006513;
        Tue, 2 Jun 2020 18:39:04 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 11:39:04 -0700
Date:   Tue, 2 Jun 2020 21:38:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, mike.marciniszyn@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, sadanand.warrier@intel.com,
        grzegorz.andrejczuk@intel.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] IB/hfi1: Use free_netdev() in hfi1_netdev_free()
Message-ID: <20200602183856.GY22511@kadam>
References: <20200601135644.GD4872@ziepe.ca>
 <20200602061635.31224-1-yuehaibing@huawei.com>
 <75257c20-3cf2-7ecc-0d66-e1f4155ba105@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75257c20-3cf2-7ecc-0d66-e1f4155ba105@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020134
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 02, 2020 at 11:30:13AM -0400, Dennis Dalessandro wrote:
> On 6/2/2020 2:16 AM, YueHaibing wrote:
> > dummy_netdev shold be freed by free_netdev() instead of
> > kfree(). Also remove unneeded variable 'priv'
> > 
> > Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >   drivers/infiniband/hw/hfi1/netdev_rx.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
> > index 58af6a454761..63688e85e8da 100644
> > --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> > +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> > @@ -371,12 +371,9 @@ int hfi1_netdev_alloc(struct hfi1_devdata *dd)
> >   void hfi1_netdev_free(struct hfi1_devdata *dd)
> >   {
> > -	struct hfi1_netdev_priv *priv;
> > -
> >   	if (dd->dummy_netdev) {
> > -		priv = hfi1_netdev_priv(dd->dummy_netdev);
> >   		dd_dev_info(dd, "hfi1 netdev freed\n");
> > -		kfree(dd->dummy_netdev);
> > +		free_netdev(dd->dummy_netdev);
> >   		dd->dummy_netdev = NULL;
> >   	}
> >   }
> > 
> 
> For the kfree->free_netdev, you probably want to add:
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

YueHaibing wasn't on the CC list when I sent forwarded that kbuild bot
email.  Forget about it.  Let's just apply this.

regards,
dan carpenter

