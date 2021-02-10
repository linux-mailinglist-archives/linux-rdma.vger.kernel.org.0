Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EFA315FD2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 08:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhBJHD5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 02:03:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49170 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBJHD4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 02:03:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A6xxso133277;
        Wed, 10 Feb 2021 07:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NwGsLKGeep21OlLyx582O7FLfyqm1Jbx6i2Su2RRuLI=;
 b=F37Zy3d4+4wxE1SEKXsOXzltv4SXwOaoxR1ir/yuVyldYlL6XyR+VgofNHAfrBvtPxUO
 VQJHmIngBWym06BDoW+rzUIFq1p1mNgNoya/RFxdKrRRQfkdmwH3OlUp/DUTAcCYV5Tr
 ewNNSjvihrPUTnsZQ3TRyrYo8ppzStLvfHjmyb8syDU57DatYlF6vgckpn6lQNfffn0u
 VydejJ6V1net+ku3hk6TZyMSmtX56ATxjvQZBmaqruL3ZnQZSRnAkAec9k0tq9tuK2JW
 5bSz2E8HtiDqPysdBbj/H0PY0SiREQNDEjFNVlJprRvTzWOmcQpbZOTCUbPmSHVWWi6E Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36m4uprq3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 07:03:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A7128I014712;
        Wed, 10 Feb 2021 07:03:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 36j51x6jxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 07:03:11 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11A73AGG014218;
        Wed, 10 Feb 2021 07:03:10 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 09 Feb 2021 23:02:49 -0800
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20210210070238.GR20820@kadam>
Date:   Tue, 9 Feb 2021 23:02:38 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Roi Dayan <roid@nvidia.com>, Feras Daoud <ferasda@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] net/mxl5e: Add change profile method
References: <YBz2CSKUBlUCRxsZ@mwanda>
 <82d9b9b7b0b063aaab358041906baf3ac48ec4a9.camel@nvidia.com>
In-Reply-To: <82d9b9b7b0b063aaab358041906baf3ac48ec4a9.camel@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100072
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100072
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 10, 2021 at 06:12:58AM +0000, Saeed Mahameed wrote:
> On Fri, 2021-02-05 at 15:45 +0300, Dan Carpenter wrote:
> > Hello Saeed Mahameed and Feras Daoud,
> > 
> 
> Hi Dan, thanks for the report, adding Roi the owner of this change.
> 
> > I'm not exactly sure if I should blame commit c4d7eb57687f:
> > "net/mxl5e:
> > Add change profile method" fomr Mar 22, 2020 or commit 182570b26223
> > ("net/mlx5e: Gather common netdev init/cleanup functionality in one
> > place") from Oct 2, 2018.
> > 
> > drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5658
> > mlx5e_netdev_change_profile() warn: 'priv->htb.qos_sq_stats' double
> > freed
> > drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5658
> > mlx5e_netdev_change_profile() warn: 'priv->scratchpad.cpumask' double
> > freed
> > drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5789 mlx5e_probe()
> > warn: 'priv->htb.qos_sq_stats' double freed
> > drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5789 mlx5e_probe()
> > warn: 'priv->scratchpad.cpumask' double freed
> > drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5802 mlx5e_remove()
> > warn: 'priv->htb.qos_sq_stats' double freed
> > drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5802 mlx5e_remove()
> > warn: 'priv->scratchpad.cpumask' double freed
> > drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:1317
> > mlx5e_vport_rep_unload() warn: 'priv->htb.qos_sq_stats' double freed
> > drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:1317
> > mlx5e_vport_rep_unload() warn: 'priv->scratchpad.cpumask' double
> > freed
> 
> If I may ask,
> What is this report ? Coverity ? static checker ? or runtime checks ?
> 

This is a Smatch check but you have to have the cross function database
built.  And the code is from 2018 so something must have improved in how
the cross function DB is working recently for it to generate this
warning...  I'm not sure exactly what I improved or if I have pushed
that change yet...

regards,
dan carpenter

