Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF06729A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGLPkr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 11:40:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36067 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGLPkq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 11:40:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so8529246qtc.3
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U+/8FfyqinrLL+QkufZo4wseGUN4idZVsiXGF43Tx1Y=;
        b=hMUS0yHLh+smxQ7MwIpEmZxae946P1yCFBaYlmTBZDSkPN4OvKB4XHUQbRpxp5DqQp
         E812Rl+zNJ6Fw5pr3doQHE9aurVCEJekrAHkVMnXxBDaBsIqSbMhUEuIzy36nGavfp5g
         9zvpdM0UARhSgFGRDbUvPJoe1btp8ILORjsVQU6IigRkL30pkj9vjLgCrXIGlaUwWCP7
         iDtZ1MR2qs5H4QQzewHjhUXTcFjCWQSXx4uYyZqPKwFowsFZgtjN51cMxGJ21+KPDyfP
         eaefvbeY59HQgjOA2++Edg+KTB9/1+YBzyllOhAqXxJ6keHZxM8QXKqDnry/9Mm7yoXn
         9u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U+/8FfyqinrLL+QkufZo4wseGUN4idZVsiXGF43Tx1Y=;
        b=o+RdRyABgAquW5EX/99+sjtHnJE4JbpRl5Rr/op2rF8T8BoJi03DQHftlkh6jSOxm3
         gYnDPb9a4ggDPmBBIMJXjZWcAo2lDi0V4Xb9V7k+3jEMSMqxWryRistrMczo2T0U5Vvm
         roj3MR/GRwMSkxjTvLzcRSHvKETnR4MM+mcqK4lehTscUFu/lnzeCQtiL9eTnBWXzHI1
         G7IHdjKXYOHOxjOAQ1dXttqC79XQY7qPrhLfYFKNEL0jzDgDcUJzjHOGB76yN3/H9Ick
         MG9mEc38mLzCzho8prvYBjovHo6LEPO5HyEjRmTqEKemQcPSecaHyS+UpCb69FmY7RjM
         yQ7Q==
X-Gm-Message-State: APjAAAWonkjN8DmLDXkRAHiepnSoSGk2Flp0dvK+44aq9Q/vxzgN0YfH
        cCwY40mwWJn588OVbKvWqrIjAg==
X-Google-Smtp-Source: APXvYqw285ILCxWcu36MujQjdLj65jN6CAzLdwt7b4oRkspwpQqOzIREFQvGc3Z/XDKIlSuBQFEzGQ==
X-Received: by 2002:a0c:99e9:: with SMTP id y41mr7161405qve.186.1562946045397;
        Fri, 12 Jul 2019 08:40:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h40sm4868825qth.4.2019.07.12.08.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 08:40:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlxfA-0002wk-C8; Fri, 12 Jul 2019 12:40:44 -0300
Date:   Fri, 12 Jul 2019 12:40:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: regression: nvme rdma with bnxt_re0 broken
Message-ID: <20190712154044.GJ27512@ziepe.ca>
References: <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
 <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 12:52:24PM +0000, Parav Pandit wrote:
> 
> 
> > From: Yi Zhang <yi.zhang@redhat.com>
> > Sent: Friday, July 12, 2019 5:11 PM
> > To: Parav Pandit <parav@mellanox.com>; Selvin Xavier
> > <selvin.xavier@broadcom.com>
> > Cc: Daniel Jurgens <danielj@mellanox.com>; linux-rdma@vger.kernel.org;
> > Devesh Sharma <devesh.sharma@broadcom.com>; linux-
> > nvme@lists.infradead.org
> > Subject: Re: regression: nvme rdma with bnxt_re0 broken
> > 
> > Hi Parav
> > The nvme connect still failed[1], I've paste all the dmesg log to[2], pls check it.
> > 
> > 
> > [1]
> > [root@rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420 -n
> > testnqn
> > Failed to write to /dev/nvme-fabrics: Connection reset by peer
> > [2]
> > https://pastebin.com/ipvak0Sp
> > 
> 
> I think vlan_id is not initialized to 0xffff due to which ipv4 entry addition also failed with my patch.
> This is probably solves it. Not sure. I am not much familiar with it.
> 
> Selvin,
> Can you please take a look?
> 
> From 7b55e1d4500259cf7c02fb4d9fbbeb5ad1cfc623 Mon Sep 17 00:00:00 2001
> From: Parav Pandit <parav@mellanox.com>
> Date: Fri, 12 Jul 2019 04:34:52 -0500
> Subject: [PATCH v1] IB/bnxt_re: Honor vlan_id in GID entry comparison
> 
> GID entry consist of GID, vlan, netdev and smac.
> Extend GID duplicate check companions to consider vlan_id as well
> to support IPv6 VLAN based link local addresses.
> 
> GID deletion based on only GID comparision is not correct.
> It needs further fixes.
> 
> Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
> Change-Id: I2e026ec8065c8425ba24fad8525323d112a2f4e4
> Signed-off-by: Parav Pandit <parav@mellanox.com>
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 5 +++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 7 ++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> index 37928b1111df..216648b640ce 100644
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -488,6 +488,8 @@ static int bnxt_qplib_alloc_sgid_tbl(struct bnxt_qplib_res *res,
>  				     struct bnxt_qplib_sgid_tbl *sgid_tbl,
>  				     u16 max)
>  {
> +	u16 i;
> +
>  	sgid_tbl->tbl = kcalloc(max, sizeof(struct bnxt_qplib_gid), GFP_KERNEL);
>  	if (!sgid_tbl->tbl)
>  		return -ENOMEM;
> @@ -500,6 +502,9 @@ static int bnxt_qplib_alloc_sgid_tbl(struct bnxt_qplib_res *res,
>  	if (!sgid_tbl->ctx)
>  		goto out_free2;
>  
> +	for (i = 0; i < max; i++)
> +		sgid_tbl->tbl[i].vlan_id = 0xffff;
> +
>  	sgid_tbl->vlan = kcalloc(max, sizeof(u8), GFP_KERNEL);
>  	if (!sgid_tbl->vlan)
>  		goto out_free3;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index 48793d3512ac..0d90be88685f 100644
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -236,6 +236,9 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
>  		return -ENOMEM;
>  	}
>  	for (index = 0; index < sgid_tbl->max; index++) {
> +		/* FIXME: GID delete should happen based on index
> +		 * and refcount
> +		 */
>  		if (!memcmp(&sgid_tbl->tbl[index], gid, sizeof(*gid)))
>  			break;
>  	}
> @@ -296,7 +299,8 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
>  	}
>  	free_idx = sgid_tbl->max;
>  	for (i = 0; i < sgid_tbl->max; i++) {
> -		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
> +		if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid)) &&
> +		    sgid_tbl->tbl[i].vlan_id == vlan_id) {
>  			dev_dbg(&res->pdev->dev,
>  				"SGID entry already exist in entry %d!\n", i);

bnxt guys: please just delete this duplicate detection code from the
driver. Every GID provided from the core must be programmed into the
given gid table index.

Jason
