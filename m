Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9102C3168A8
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhBJOEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 09:04:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43784 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBJOED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 09:04:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ADxv5I040543;
        Wed, 10 Feb 2021 14:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CGNgUEt/ajEOoX2g7nyT8+rxXEQkKZYA7Zbd1MRe12I=;
 b=OdTOjtNPiwUW+YhnqNJPNEdjDeHJxVhyPP+DN5o+2tzkxCb0iZPCc5IwO91E+LCHMVAn
 L06mvib5Vqj4bb13j94cYiJWLA+pE1tUvI4XaCn6uNcd2oj6/ZKrlaiZIv1zUzF7s1ai
 DBSVcFVa7XVOmzmRSsiwt8uoxKz+Yl4XIsomPRhCvmUf6UXKTo6Nqo8U+RPwq7yh7a6/
 IrgyLWsCsaitgkMhnlHI0wm6Nwk7clazuoqfu4/HHPnoXNCDLOrOTd429cO47RsKiME1
 vLBbYy3YMwcyDn9MPO8cDovOkjnf15J1h7NRmL7a5LBVi2AgQn7bocC6PT0zBJTvZLAj Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrn3dcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 14:03:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AE1S2H146030;
        Wed, 10 Feb 2021 14:03:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36j512pab4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 14:03:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11AE3BNQ025565;
        Wed, 10 Feb 2021 14:03:11 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 06:03:10 -0800
Date:   Wed, 10 Feb 2021 17:03:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     Ido Schimmel <idosch@idosch.org>, jiri@resnulli.us,
        linux-rdma@vger.kernel.org
Subject: Re: [bug report] net/mlx5e: Handle FIB events to update tunnel
 endpoint device
Message-ID: <20210210140301.GZ20820@kadam>
References: <YCO+nR+3Zs9jIAfp@mwanda>
 <ygnha6scgms4.fsf@nvidia.com>
 <20210210132137.GA296697@shredder.lan>
 <ygnh7dngghh0.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ygnh7dngghh0.fsf@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100134
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 10, 2021 at 03:50:03PM +0200, Vlad Buslov wrote:
> 
> On Wed 10 Feb 2021 at 15:21, Ido Schimmel <idosch@idosch.org> wrote:
> > On Wed, Feb 10, 2021 at 01:55:23PM +0200, Vlad Buslov wrote:
> >> On Wed 10 Feb 2021 at 13:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >> > Hello Vlad Buslov,
> >> >
> >> > The patch 8914add2c9e5: "net/mlx5e: Handle FIB events to update
> >> > tunnel endpoint device" from Jan 25, 2021, leads to the following
> >> > static checker warning:
> >> >
> >> > 	drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c:1639 mlx5e_tc_tun_init()
> >> > 	error: passing non negative 1 to ERR_PTR
> >> >
> >> > drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> >> >   1622  struct mlx5e_tc_tun_encap *mlx5e_tc_tun_init(struct mlx5e_priv *priv)
> >> >   1623  {
> >> >   1624          struct mlx5e_tc_tun_encap *encap;
> >> >   1625          int err;
> >> >   1626  
> >> >   1627          encap = kvzalloc(sizeof(*encap), GFP_KERNEL);
> >> >   1628          if (!encap)
> >> >   1629                  return ERR_PTR(-ENOMEM);
> >> >   1630  
> >> >   1631          encap->priv = priv;
> >> >   1632          encap->fib_nb.notifier_call = mlx5e_tc_tun_fib_event;
> >> >   1633          spin_lock_init(&encap->route_lock);
> >> >   1634          hash_init(encap->route_tbl);
> >> >   1635          err = register_fib_notifier(dev_net(priv->netdev), &encap->fib_nb,
> >> >   1636                                      NULL, NULL);
> >> >
> >> > register_fib_notifier() calls fib_net_dump() which eventually calls
> >> > fib6_walk_continue() which can return 1 if "walk is incomplete (i.e.
> >> > suspended)".
> >> >
> >> >   1637          if (err) {
> >> >   1638                  kvfree(encap);
> >> >   1639                  return ERR_PTR(err);
> >> >
> >> > If this returns 1 it will eventually lead to an Oops.
> >> 
> >> Hi Dan,
> >> 
> >> Thanks for the bug report!
> >> 
> >> This looks a bit strange to me because none of the other users of this
> >> API handle positive error code in any special way (including reference
> >> netdevsim implementation). Maybe API itself should be fixed? Jiri, Ido,
> >> what do you think?
> >
> > The other functions that call register_fib_notifier() return an int, but
> > mlx5e_tc_tun_init() returns a pointer. I think that's why it was
> > flagged: "error: passing non negative 1 to ERR_PTR".
> 
> Actually, some of them do. I mentioned netdevsim specifically because
> nsim_fib_create() returns pointer and also casts return value of
> register_fib_notifier() with ERR_PTR.
> 

Huh.  Smatch prints a warning for nsim_fib_create() but I never
forwarded the warning to anyone apparently.

regards,
dan carpenter

