Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA422A99E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgGWHZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 03:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGWHZv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jul 2020 03:25:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB81C0619DC
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 00:25:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so4005672wmi.3
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 00:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=95JqaQ3T5sU0jYy1fGUcAB6HjUzH41K844x/1DqqxJ0=;
        b=rcMaCTUVpnMxjaSuvmhdq8MjRi807LyTkuFdWUMlWIfEHdOeZBmaqNcRTfNmxckUBT
         mM8qTgmW0GcAhh65tFfihzuiB+o6TxlFgQBHjQ94NTrNceya3khYlC+Ef6j+dqupVL36
         Qh3iVOQ4Ar4k/P3cmmFoqsYVx8YWDSgAmbrchS8GtXULOLRXU0WQfc09STxoHc7eEsTD
         KwZd574JgNQwz6mOT9llkKHhb7QZJfP6vPRYOl8+kCxpwOaBXUfrVBgXVId9IDXHzJgP
         rFmMNodZ+QuHRodKc1wI0GrUaiQLJ5gz5xPLN5NFITqN57JzG6dmAx3wrw/9Qz1xaEtq
         P7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=95JqaQ3T5sU0jYy1fGUcAB6HjUzH41K844x/1DqqxJ0=;
        b=ahHosCkD6E2oDbpg/NAIvZkZ4SAddhr7NVAsWXpNRYJJa9k866L1baKww9n44AZOM2
         s+9iLEKJ0nFIFum7BUct6xVTfkdg5hzX3kw1++2oVAhgxPOtywKXyBHxajl+J7uGWmon
         0QrPdIKNG1md56e0xEb1ZpU9o2p0w2QmhSwqtsN+VF8VDWo4+Bn96CMuyitqvxbOUA4J
         k6XKLokRUPaBmFL4/dCff4zy74wUiacXBqqLpZp6HKU3R6OS/AvgnF6MhawWaOQNZ0Os
         YA20pgX5+jSGcI4+JaIlVVC0E9qnxX7LMWYx8RuLEjvf60QIgFtMoMrNWAQEPcgGbg6h
         EzFg==
X-Gm-Message-State: AOAM533FocXkgQQQUS6BlhDf2ksQw3MaiyQV68XWf5kc5cTy3lWHLs71
        u67EQfZaHLZS+XdVO46HRmQ=
X-Google-Smtp-Source: ABdhPJzem3jmu3MRRkUs2igOk2T/jD0xKzB6bAUHDQlzP63jgMnFWtyXtWlGuOdiHsIikVLX5jUsEg==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr2835138wmc.96.1595489150189;
        Thu, 23 Jul 2020 00:25:50 -0700 (PDT)
Received: from kheib-workstation ([77.137.112.102])
        by smtp.gmail.com with ESMTPSA id c194sm2530237wme.8.2020.07.23.00.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:25:49 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:25:46 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Yanjun Zhu <yanjunz@mellanox.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
Message-ID: <20200723072546.GA835185@kheib-workstation>
References: <20200721101618.686110-1-kamalheib1@gmail.com>
 <AM6PR05MB6263CFB337190B1740CDF4B7D8780@AM6PR05MB6263.eurprd05.prod.outlook.com>
 <CAD=hENePPVzfaC_YtCL1izsFSi+U_T=0m18MujARznsWbj=q5g@mail.gmail.com>
 <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
> On 7/23/2020 1:57 PM, Kamal Heib wrote:
> > On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
> > > On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Kamal Heib <kamalheib1@gmail.com>
> > > > Sent: Tuesday, July 21, 2020 6:16 PM
> > > > To: linux-rdma@vger.kernel.org
> > > > Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> > > > Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
> > > > 
> > > > The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
> > > > 
> > > Hi Kamal
> > > 
> > > After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
> > > 
> > > The SoftRoCE should work well with the mlx hardware.
> > > 
> > > Zhu Yanjun
> > > 
> > Hi Zhu,
> > 
> > Yes, please see below:
> > 
> > $ ibv_rc_pingpong -d mlx5_0 -g 11
> >    local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
> 
> Can you make tests with GSI QP?
> 
> Zhu Yanjun
> 

[root@rdma-dev-21 ~]$ rping -s -C 10 -a 172.31.40.121 -v 
server ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
server ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
server ping data: rdma-ping-2: CDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrst
server ping data: rdma-ping-3: DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu
server ping data: rdma-ping-4: EFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv
server ping data: rdma-ping-5: FGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvw
server ping data: rdma-ping-6: GHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwx
server ping data: rdma-ping-7: HIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy
server ping data: rdma-ping-8: IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
server ping data: rdma-ping-9: JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyzA
server DISCONNECT EVENT...
wait for RDMA_READ_ADV state 10
[root@rdma-dev-21 ~]$ ls /sys/class/infiniband/
mlx5_0

[root@rdma-dev-22 ~]$ rping -c -C 10 -a 172.31.40.121 -v
ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
ping data: rdma-ping-2: CDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrst
ping data: rdma-ping-3: DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu
ping data: rdma-ping-4: EFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv
ping data: rdma-ping-5: FGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvw
ping data: rdma-ping-6: GHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwx
ping data: rdma-ping-7: HIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy
ping data: rdma-ping-8: IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
ping data: rdma-ping-9: JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyzA
[root@rdma-dev-22 ~]$ ls /sys/class/infiniband
rxe0

Thanks,
Kamal

> >    remote address: LID 0x0000, QPN 0x000011, PSN 0xd67210, GID ::ffff:172.31.40.122
> > 8192000 bytes in 0.03 seconds = 2194.56 Mbit/sec
> > 1000 iters in 0.03 seconds = 29.86 usec/iter
> > 
> > $ ibv_rc_pingpong -d rxe0 -g 1 rdma-dev-21
> >    local address:  LID 0x0000, QPN 0x000011, PSN 0xd67210, GID ::ffff:172.31.40.122
> >    remote address: LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
> > 8192000 bytes in 0.03 seconds = 2192.72 Mbit/sec
> > 1000 iters in 0.03 seconds = 29.89 usec/iter
> > 
> > Thanks,
> > Kamal
> > 
> > > > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > ---
> > > >   drivers/infiniband/sw/rxe/rxe.c       | 34 +++------------------------
> > > >   drivers/infiniband/sw/rxe/rxe_param.h |  4 ++--  drivers/infiniband/sw/rxe/rxe_recv.c  | 29 ++++-------------------
> > > >   drivers/infiniband/sw/rxe/rxe_req.c   |  5 +---
> > > >   drivers/infiniband/sw/rxe/rxe_verbs.c | 17 +++-----------  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
> > > >   6 files changed, 13 insertions(+), 77 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c index efcb72c92be6..907203afbd99 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe.c
> > > > @@ -40,14 +40,6 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");  MODULE_DESCRIPTION("Soft RDMA transport");  MODULE_LICENSE("Dual BSD/GPL");
> > > > 
> > > > -/* free resources for all ports on a device */ -static void rxe_cleanup_ports(struct rxe_dev *rxe) -{
> > > > -       kfree(rxe->port.pkey_tbl);
> > > > -       rxe->port.pkey_tbl = NULL;
> > > > -
> > > > -}
> > > > -
> > > >   /* free resources for a rxe device all objects created for this device must
> > > >    * have been destroyed
> > > >    */
> > > > @@ -66,8 +58,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
> > > >          rxe_pool_cleanup(&rxe->mc_grp_pool);
> > > >          rxe_pool_cleanup(&rxe->mc_elem_pool);
> > > > 
> > > > -       rxe_cleanup_ports(rxe);
> > > > -
> > > >          if (rxe->tfm)
> > > >                  crypto_free_shash(rxe->tfm);
> > > >   }
> > > > @@ -139,25 +129,14 @@ static void rxe_init_port_param(struct rxe_port *port)
> > > >   /* initialize port state, note IB convention that HCA ports are always
> > > >    * numbered from 1
> > > >    */
> > > > -static int rxe_init_ports(struct rxe_dev *rxe)
> > > > +static void rxe_init_ports(struct rxe_dev *rxe)
> > > >   {
> > > >          struct rxe_port *port = &rxe->port;
> > > > 
> > > >          rxe_init_port_param(port);
> > > > -
> > > > -       port->pkey_tbl = kcalloc(port->attr.pkey_tbl_len,
> > > > -                       sizeof(*port->pkey_tbl), GFP_KERNEL);
> > > > -
> > > > -       if (!port->pkey_tbl)
> > > > -               return -ENOMEM;
> > > > -
> > > > -       port->pkey_tbl[0] = 0xffff;
> > > >          addrconf_addr_eui48((unsigned char *)&port->port_guid,
> > > >                              rxe->ndev->dev_addr);
> > > > -
> > > >          spin_lock_init(&port->port_lock);
> > > > -
> > > > -       return 0;
> > > >   }
> > > > 
> > > >   /* init pools of managed objects */
> > > > @@ -247,13 +226,11 @@ static int rxe_init(struct rxe_dev *rxe)
> > > >          /* init default device parameters */
> > > >          rxe_init_device_param(rxe);
> > > > 
> > > > -       err = rxe_init_ports(rxe);
> > > > -       if (err)
> > > > -               goto err1;
> > > > +       rxe_init_ports(rxe);
> > > > 
> > > >          err = rxe_init_pools(rxe);
> > > >          if (err)
> > > > -               goto err2;
> > > > +               return err;
> > > > 
> > > >          /* init pending mmap list */
> > > >          spin_lock_init(&rxe->mmap_offset_lock);
> > > > @@ -263,11 +240,6 @@ static int rxe_init(struct rxe_dev *rxe)
> > > >          mutex_init(&rxe->usdev_lock);
> > > > 
> > > >          return 0;
> > > > -
> > > > -err2:
> > > > -       rxe_cleanup_ports(rxe);
> > > > -err1:
> > > > -       return err;
> > > >   }
> > > > 
> > > >   void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu) diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> > > > index 99e9d8ba9767..2f381aeafcb5 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_param.h
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> > > > @@ -100,7 +100,7 @@ enum rxe_device_param {
> > > >          RXE_MAX_SRQ_SGE                 = 27,
> > > >          RXE_MIN_SRQ_SGE                 = 1,
> > > >          RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
> > > > -       RXE_MAX_PKEYS                   = 64,
> > > > +       RXE_MAX_PKEYS                   = 1,
> > > >          RXE_LOCAL_CA_ACK_DELAY          = 15,
> > > > 
> > > >          RXE_MAX_UCONTEXT                = 512,
> > > > @@ -148,7 +148,7 @@ enum rxe_port_param {
> > > >          RXE_PORT_INIT_TYPE_REPLY        = 0,
> > > >          RXE_PORT_ACTIVE_WIDTH           = IB_WIDTH_1X,
> > > >          RXE_PORT_ACTIVE_SPEED           = 1,
> > > > -       RXE_PORT_PKEY_TBL_LEN           = 64,
> > > > +       RXE_PORT_PKEY_TBL_LEN           = 1,
> > > >          RXE_PORT_PHYS_STATE             = IB_PORT_PHYS_STATE_POLLING,
> > > >          RXE_PORT_SUBNET_PREFIX          = 0xfe80000000000000ULL,
> > > >   };
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> > > > index 46e111c218fd..7e123d3c4d09 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> > > > @@ -101,36 +101,15 @@ static void set_qkey_viol_cntr(struct rxe_port *port)  static int check_keys(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
> > > >                        u32 qpn, struct rxe_qp *qp)
> > > >   {
> > > > -       int i;
> > > > -       int found_pkey = 0;
> > > >          struct rxe_port *port = &rxe->port;
> > > >          u16 pkey = bth_pkey(pkt);
> > > > 
> > > >          pkt->pkey_index = 0;
> > > > 
> > > > -       if (qpn == 1) {
> > > > -               for (i = 0; i < port->attr.pkey_tbl_len; i++) {
> > > > -                       if (pkey_match(pkey, port->pkey_tbl[i])) {
> > > > -                               pkt->pkey_index = i;
> > > > -                               found_pkey = 1;
> > > > -                               break;
> > > > -                       }
> > > > -               }
> > > > -
> > > > -               if (!found_pkey) {
> > > > -                       pr_warn_ratelimited("bad pkey = 0x%x\n", pkey);
> > > > -                       set_bad_pkey_cntr(port);
> > > > -                       goto err1;
> > > > -               }
> > > > -       } else {
> > > > -               if (unlikely(!pkey_match(pkey,
> > > > -                                        port->pkey_tbl[qp->attr.pkey_index]
> > > > -                                       ))) {
> > > > -                       pr_warn_ratelimited("bad pkey = 0x%0x\n", pkey);
> > > > -                       set_bad_pkey_cntr(port);
> > > > -                       goto err1;
> > > > -               }
> > > > -               pkt->pkey_index = qp->attr.pkey_index;
> > > > +       if (!pkey_match(pkey, IB_DEFAULT_PKEY_FULL)) {
> > > > +               pr_warn_ratelimited("bad pkey = 0x%x\n", pkey);
> > > > +               set_bad_pkey_cntr(port);
> > > > +               goto err1;
> > > >          }
> > > > 
> > > >          if ((qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_GSI) && diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> > > > index e5031172c019..34df2b55e650 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > > > @@ -381,7 +381,6 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
> > > >                                         struct rxe_pkt_info *pkt)
> > > >   {
> > > >          struct rxe_dev          *rxe = to_rdev(qp->ibqp.device);
> > > > -       struct rxe_port         *port = &rxe->port;
> > > >          struct sk_buff          *skb;
> > > >          struct rxe_send_wr      *ibwr = &wqe->wr;
> > > >          struct rxe_av           *av;
> > > > @@ -419,9 +418,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
> > > >                          (pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
> > > >                          (RXE_WRITE_MASK | RXE_IMMDT_MASK));
> > > > 
> > > > -       pkey = (qp_type(qp) == IB_QPT_GSI) ?
> > > > -                port->pkey_tbl[ibwr->wr.ud.pkey_index] :
> > > > -                port->pkey_tbl[qp->attr.pkey_index];
> > > > +       pkey = IB_DEFAULT_PKEY_FULL;
> > > > 
> > > >          qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
> > > >                                           qp->attr.dest_qp_num;
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > > index 74f071003690..779458ddd422 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > > @@ -83,22 +83,11 @@ static int rxe_query_port(struct ib_device *dev,  static int rxe_query_pkey(struct ib_device *device,
> > > >                            u8 port_num, u16 index, u16 *pkey)  {
> > > > -       struct rxe_dev *rxe = to_rdev(device);
> > > > -       struct rxe_port *port;
> > > > -
> > > > -       port = &rxe->port;
> > > > -
> > > > -       if (unlikely(index >= port->attr.pkey_tbl_len)) {
> > > > -               dev_warn(device->dev.parent, "invalid index = %d\n",
> > > > -                        index);
> > > > -               goto err1;
> > > > -       }
> > > > +       if (index > 0)
> > > > +               return -EINVAL;
> > > > 
> > > > -       *pkey = port->pkey_tbl[index];
> > > > +       *pkey = IB_DEFAULT_PKEY_FULL;
> > > >          return 0;
> > > > -
> > > > -err1:
> > > > -       return -EINVAL;
> > > >   }
> > > > 
> > > >   static int rxe_modify_device(struct ib_device *dev, diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > index 92de39c4a7c1..c664c7f36ab5 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > > > @@ -371,7 +371,6 @@ struct rxe_mc_elem {
> > > > 
> > > >   struct rxe_port {
> > > >          struct ib_port_attr     attr;
> > > > -       u16                     *pkey_tbl;
> > > >          __be64                  port_guid;
> > > >          __be64                  subnet_prefix;
> > > >          spinlock_t              port_lock; /* guard port */
> > > > --
> > > > 2.25.4
> > > > 
> 
