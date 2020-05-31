Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF61E997C
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2020 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgEaRhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 May 2020 13:37:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48244 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgEaRhO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 May 2020 13:37:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04VHYFRc171807;
        Sun, 31 May 2020 17:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ttkPsoGr6ooWCAMJHELFBBHDDp33WWdK6AZclS+97HM=;
 b=G5yR3+z81oBRaf17XYK2WiS8c7qR+FsiuOWj1xf/dxgCIkpu3G3S3wEtjv6D/b8GSPru
 avHCgmPwJmkOrTZRFFGmnwPZFsKsxENU/88oUqFOUXXHA3lIxM5vuO8Ken/UZ2OfjUJF
 /4ELxoBsQKCwCZnSI9SRYee0QyLWoCc/30qYBXhCo/IVsrGLjNMTwv2Ixr2sd88kipgF
 YjIPsJn1J/A/pHNm2TMRBLd2DoxJ99rgsuspBEEuasIB9E9lZdTtP8ezdv9poNq3hFjq
 IQm8+JZgPjwR/Tpdzpr12LbbdTgjH+LDJzjNHDMuNMXM90zWgKsYPv4OdJeRl+uZkdbQ HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31bg4mun32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 31 May 2020 17:37:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04VHXqLI117038;
        Sun, 31 May 2020 17:37:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31c18qaybp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 May 2020 17:37:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04VHb1R5003656;
        Sun, 31 May 2020 17:37:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 May 2020 10:37:01 -0700
Date:   Sun, 31 May 2020 20:36:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Message-ID: <20200531173655.GT22511@kadam>
References: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200530140224.GA1330098@mwanda>
 <20200531100512.GH66309@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531100512.GH66309@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005310140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 cotscore=-2147483648 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005310140
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 31, 2020 at 01:05:12PM +0300, Leon Romanovsky wrote:
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
> >
> > diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
> > index b183c56b7b6a4..03f8be8e9488e 100644
> > --- a/drivers/infiniband/hw/hfi1/vnic_main.c
> > +++ b/drivers/infiniband/hw/hfi1/vnic_main.c
> > @@ -457,13 +457,19 @@ static int hfi1_vnic_up(struct hfi1_vnic_vport_info *vinfo)
> >  	if (rc < 0)
> >  		return rc;
> >
> > -	hfi1_netdev_rx_init(dd);
> > +	rc = hfi1_netdev_rx_init(dd);
> > +	if (rc < 0)
> > +		goto err_remove;
> 
> Why did you check for the negative value here and didn't check below?
> 

I just copied the pattern in the nearest code.  I didn't realize until
now that it was different in both functions...  The checking isn't done
consistently in this file.

I can resend on Tuesday though if you want.

regards,
dan carpenter

