Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2155717A0C4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 09:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCEIA3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 03:00:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43290 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCEIA3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Mar 2020 03:00:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0257w7Li123308;
        Thu, 5 Mar 2020 08:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tGxrfxnsYHWmjW6L+VGIvzPWMrDbApWGxS/7d/RBRbg=;
 b=IJfOiyXmVGsbERPj4dCy+ZqeA6zC4posUFIz8gxZb1qdNKJkKd42YSfE8DcM3hAjiRGB
 +yiXfzBArDIy5HnvqUYlKgxEI19xX3smlY7dVq0XXbjZ9RW/7u5xy4dwTyA4ekG2hKQ/
 IMgCdEvTu14u0MgO88OBS8AErs49iZY8rmbHajo70c+wjmY1GFxp+H/yx115y0/IQuoC
 jSddqA8sCaweyTSA4B0me719CamDJCHXz/Bg0i4T/dKkIgHwpZRkSrcuR8zHK6NXw3ao
 2Cd0sw0M73Oha4RviLxcYfA/GJ/R+MQgB5yrtTiChntJoI4W18vjM+ubljS7Mxhz7ZD3 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwr3e9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 08:00:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0257uZJp194450;
        Thu, 5 Mar 2020 08:00:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yg1p9ungw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 08:00:16 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02580F9D016770;
        Thu, 5 Mar 2020 08:00:15 GMT
Received: from kadam (/41.210.146.162)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Mar 2020 00:00:14 -0800
Date:   Thu, 5 Mar 2020 11:00:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     Eli Cohen <eli@mellanox.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] net/mlx5e: Fix an IS_ERR() vs NULL check
Message-ID: <20200305080004.GA19839@kadam>
References: <20200304142151.qivcobp6ngrynb2p@kili.mountain>
 <10527910074442142431505e9d424af9128e8c5c.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10527910074442142431505e9d424af9128e8c5c.camel@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050050
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 04, 2020 at 08:31:13PM +0000, Saeed Mahameed wrote:
> On Wed, 2020-03-04 at 17:22 +0300, Dan Carpenter wrote:
> > The esw_vport_tbl_get() function returns error pointers on error.
> > 
> > Fixes: 96e326878fa5 ("net/mlx5e: Eswitch, Use per vport tables for
> > mirroring")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Hi Dan the patch looks fine, but you didn't cc netdev mailing list
> Two options:
> 
> 1) I can pick this patch up and repost it myself in a future pull
> request

I assumed we would do this, because the original patch didn't have
Dave's signed-off-by.

> 2) you can re-post it and cc netdev also mark it for net [PATCH net]

If we were going to go that route then it would have to [PATCH net-next]
because it doesn't apply to the net tree.

regards,
dan carpenter


