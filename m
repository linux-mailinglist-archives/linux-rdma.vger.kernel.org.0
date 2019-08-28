Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA89FD67
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfH1Iqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 04:46:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfH1Iqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 04:46:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S8heEr192155;
        Wed, 28 Aug 2019 08:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=i/WG5lLpvR2QlYr6xajAlZ26fFzhmzepxxLL+X3o7tA=;
 b=DfJeBvQzgZvC8JyEerDM1WFWHkEgpVBwpBbDjOoveb00bjo0hfVm4w3Rn25X7R5hqLQe
 H+UEO4lyPGoDLlGuS+bP7Y1jQOKpRFMQDzYk1Z8G7chVqECP3+QKDpsJromxd+Kqnw5Z
 RIHZsZZH1p/9BBTk28DlE79a0RUnwCFQZ+J0j7mQ6l1ALq/fYliikxILGwctHX3e++Dc
 lRzoQ2SKj4SBWWmtr6S/vCWdobV1K0TnBZ7Txj0aR41nTIov1WcazzQxUQIP4YReqQhd
 l0MZUZOPcfz8z5vmIkjXMhCRZSoVLIpMNIzlMZ3FWMaHvAADG/wCnWvbRuUYOPVhGOdu kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2unnbhgfaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 08:46:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S8hQ00148958;
        Wed, 28 Aug 2019 08:46:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2unduppy1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 08:46:25 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7S8kO3E002971;
        Wed, 28 Aug 2019 08:46:24 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 01:46:23 -0700
Date:   Wed, 28 Aug 2019 11:46:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Eran Ben Elisha <eranbe@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [bug report] net/mlx5e: Add mlx5e HV VHCA stats agent
Message-ID: <20190828084616.GA8372@kadam>
References: <20190826125645.GA32067@mwanda>
 <c48f8323-553f-b726-3b4e-79ab8167e1c3@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48f8323-553f-b726-3b4e-79ab8167e1c3@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 07:41:14AM +0000, Eran Ben Elisha wrote:
> 
> 
> On 8/26/2019 3:56 PM, Dan Carpenter wrote:
> > Hello Eran Ben Elisha,
> > 
> > The patch cef35af34d6d: "net/mlx5e: Add mlx5e HV VHCA stats agent"
> > from Aug 22, 2019, leads to the following static checker warning:
> > 
> > 	drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c:41 mlx5e_hv_vhca_fill_stats()
> > 	warn: potential pointer math issue ('buf' is a u64 pointer)
> > 
> > drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
> >      33  static void mlx5e_hv_vhca_fill_stats(struct mlx5e_priv *priv, u64 *data,
> >                                                                        ^^^^^^^^^
> > data is a u64 pointer.
> > 
> >      34                                       int buf_len)
> >      35  {
> >      36          int ch, i = 0;
> >      37
> >      38          for (ch = 0; ch < priv->max_nch; ch++) {
> >      39                  u64 *buf = data + i;
> >                          ^^^^^^^^
> > 
> >      40
> >      41                  if (WARN_ON_ONCE(buf +
> >      42                                   sizeof(struct mlx5e_hv_vhca_per_ring_stats) >
> >                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This pointer math doesn't work.  I'm surprised the warning doesn't
> > trigger.
> 
> It it not triggered as both 'data' and 'buf' are u64*,
> and sizeof(struct mlx5e_hv_vhca_per_ring_stats) < buf_len as expected.
> This checker does the work, but over wrong range.

Ah.  Of course.  Thanks!

regards,
dan carpenter

