Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7280167B23
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2019 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfGMQAq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 Jul 2019 12:00:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41166 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfGMQAq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 13 Jul 2019 12:00:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so9572346oia.8
        for <linux-rdma@vger.kernel.org>; Sat, 13 Jul 2019 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xm/HPpHVEH6XRYIcBZPCxAy7V5Bh6Zbt+6torrb9C1U=;
        b=PXOEzaJQN4oI0dgW7sxq3GdoZ5OvVe4Iv1gbmyd3hre+O6lWXAT6TIKock5RqRphKS
         f0RsSlPAGS0pO/GvWIQ/8OL+Bl7D6rgNdDfKnbTAMh5f0bdRoUmd3Nvq0yvd+1QQmGU7
         GRPjK+qMore0drUaCJBouN6n6RdHXWH03Fb2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xm/HPpHVEH6XRYIcBZPCxAy7V5Bh6Zbt+6torrb9C1U=;
        b=b0vh7diquynN8Gp1KVbQNmfENkNtI4F2zObt9m3AmMJYz1OCtkc5uYx96DO3dNFtgg
         7wEebcNwgtjjBhVmSnAk5IUrWEznBR7wU5Zv4hVDlYs1CG0koTf4rBVOBabtpBPH8QrK
         Y1bYJeg+gcpuuGcCeU5FPhRBpYFSNuBlo/RmpM9k2lLPJP4i/XPbmSikqpEk8zgwHjdA
         uV4Vfh+/xMdWZ5K2F4H/S8deraNRioLypzcN0n/9XvWCIAmS5lBvk+gE8bbIQO4FPxWx
         dLOLiDfjIsMUNEyQA+/cnhTUqA7cIl27QiR4lsqcQyUwrtSftZ83rez7PEreJ9dmkjd0
         mJTQ==
X-Gm-Message-State: APjAAAU6UMyjkbQyW4PqF76Z+c8Er8U6oZHzOxzp7cBTMtwDANMZQ2ZG
        4HqkIiAJact35ODGtuN2SOAxtWRNR/1CMafmcTaiCg==
X-Google-Smtp-Source: APXvYqySlezV5bXMHSq+vqFQnsyRMAysjMJg1YtCg1OgCL+SifsMtQ3UsZx9zMr4KqoBak2iYUZow6CbMaNhJRfINsY=
X-Received: by 2002:aca:ed04:: with SMTP id l4mr9181275oih.26.1563033644266;
 Sat, 13 Jul 2019 09:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com> <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com> <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW0KPjJaQcoxFLny30tdMij7ycbxADCHKkVpL2LcQW-dTw@mail.gmail.com> <5496cdb1-3c07-2d44-cb1f-2d084e5a7919@redhat.com>
In-Reply-To: <5496cdb1-3c07-2d44-cb1f-2d084e5a7919@redhat.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Sat, 13 Jul 2019 21:30:32 +0530
Message-ID: <CA+sbYW0v4c0GUosHoMJv4-mpT3iVhazgaTKFDktPLbwMr5o9Bw@mail.gmail.com>
Subject: Re: regression: nvme rdma with bnxt_re0 broken
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 13, 2019 at 1:26 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hi Salvin
>
> Confirmed the patch fixed the login issue.
>
Thanks Yi for the confirmation. I will post this patch.

> And from the dmesg I found there is only one I/O queue created, is that
> reasonable? there are more queues created during my testing for IB/iWARP.
num_comp_vectors exported by bnxt_re is 1 and this is expected due to that.
This can be increased. I will post a patch after doing some testing
for the same.

>
> # nvme connect-all -t rdma -a 172.31.40.125 -s 4420
>
> # lsblk
> NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> sda       8:0    0 931.5G  0 disk
> =E2=94=9C=E2=94=80sda1    8:1    0     1G  0 part /boot
> =E2=94=9C=E2=94=80sda2    8:2    0    25G  0 part /mnt/rdma-ext4
> =E2=94=9C=E2=94=80sda3    8:3    0    25G  0 part /mnt/rdma-xfs
> =E2=94=9C=E2=94=80sda4    8:4    0     1K  0 part
> =E2=94=9C=E2=94=80sda5    8:5    0  15.7G  0 part [SWAP]
> =E2=94=94=E2=94=80sda6    8:6    0 864.9G  0 part /
> nvme0n1 259:405  0   250G  0 disk
>
> # dmesg
> [ 4311.635430] nvme nvme0: new ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.40.125:4420
> [ 4311.646687] nvme nvme0: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [ 4311.706052] nvme nvme0: creating 1 I/O queues.
> [ 4311.717848] nvme nvme0: mapped 1/0/0 default/read/poll queues.
> [ 4311.727384] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.40.125:44=
20
>
> # lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              16
> On-line CPU(s) list: 0-15
> Thread(s) per core:  2
> Core(s) per socket:  4
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               63
> Model name:          Intel(R) Xeon(R) CPU E5-2623 v3 @ 3.00GHz
> Stepping:            2
> CPU MHz:             3283.306
> CPU max MHz:         3500.0000
> CPU min MHz:         1200.0000
> BogoMIPS:            5993.72
> Virtualization:      VT-x
> L1d cache:           32K
> L1i cache:           32K
> L2 cache:            256K
> L3 cache:            10240K
> NUMA node0 CPU(s):   0,2,4,6,8,10,12,14
> NUMA node1 CPU(s):   1,3,5,7,9,11,13,15
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good
> nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
> ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1
> sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp
> tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1
> avx2 smep bmi2 erms invpcid cqm xsaveopt cqm_llc cqm_occup_llc dtherm
> ida arat pln pts flush_l1d
>
> On 7/13/19 12:18 AM, Selvin Xavier wrote:
> > On Fri, Jul 12, 2019 at 6:22 PM Parav Pandit <parav@mellanox.com> wrote=
:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Yi Zhang <yi.zhang@redhat.com>
> >>> Sent: Friday, July 12, 2019 5:11 PM
> >>> To: Parav Pandit <parav@mellanox.com>; Selvin Xavier
> >>> <selvin.xavier@broadcom.com>
> >>> Cc: Daniel Jurgens <danielj@mellanox.com>; linux-rdma@vger.kernel.org=
;
> >>> Devesh Sharma <devesh.sharma@broadcom.com>; linux-
> >>> nvme@lists.infradead.org
> >>> Subject: Re: regression: nvme rdma with bnxt_re0 broken
> >>>
> >>> Hi Parav
> >>> The nvme connect still failed[1], I've paste all the dmesg log to[2],=
 pls check it.
> >>>
> >>>
> >>> [1]
> >>> [root@rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420 =
-n
> >>> testnqn
> >>> Failed to write to /dev/nvme-fabrics: Connection reset by peer
> >>> [2]
> >>> https://pastebin.com/ipvak0Sp
> >>>
> >> I think vlan_id is not initialized to 0xffff due to which ipv4 entry a=
ddition also failed with my patch.
> >> This is probably solves it. Not sure. I am not much familiar with it.
> >>
> >> Selvin,
> >> Can you please take a look?
> >>
> > Parav,
> >   Thanks for the patch. I removed the change you made in struct bnxt_qp=
lib_gid
> > and added a new structure struct bnxt_qplib_gid_info to include both
> > gid and vlan_id.
> > struct bnxt_qplib_gid is used in multiple places to memcpy or compare
> > the 16 bytes.
> > Also, added vlan checking in the destroy path also. Some more cleanup
> > possible in
> > delete_gid path. That can be done once the basic issue is fixed.
> >
> > Yi, Can you please test this patch and see if it is solving the issue?
> >
> > Thanks,
> > Selvin
> >
> >  From 3d83613cfc5993bf9dae529ab0d4d25ddefff29b Mon Sep 17 00:00:00 2001
> > From: Parav Pandit <parav@mellanox.com>
> > Date: Fri, 12 Jul 2019 10:32:51 -0400
> > Subject: [PATCH] IB/bnxt_re: Honor vlan_id in GID entry comparison
> >
> > GID entry consist of GID, vlan, netdev and smac.
> > Extend GID duplicate check companions to consider vlan_id as well
> > to support IPv6 VLAN based link local addresses.
> >
> > Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE=
 GIDs")
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >   drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  7 +++++--
> >   drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 +++++++++++++----
> >   drivers/infiniband/hw/bnxt_re/qplib_res.h |  2 +-
> >   drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 14 +++++++++-----
> >   drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  7 ++++++-
> >   5 files changed, 34 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > index a91653aabf38..098ab883733e 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -308,6 +308,7 @@ int bnxt_re_del_gid(const struct ib_gid_attr
> > *attr, void **context)
> >    struct bnxt_re_dev *rdev =3D to_bnxt_re_dev(attr->device, ibdev);
> >    struct bnxt_qplib_sgid_tbl *sgid_tbl =3D &rdev->qplib_res.sgid_tbl;
> >    struct bnxt_qplib_gid *gid_to_del;
> > + u16 vlan_id =3D 0xFFFF;
> >
> >    /* Delete the entry from the hardware */
> >    ctx =3D *context;
> > @@ -317,7 +318,8 @@ int bnxt_re_del_gid(const struct ib_gid_attr
> > *attr, void **context)
> >    if (sgid_tbl && sgid_tbl->active) {
> >    if (ctx->idx >=3D sgid_tbl->max)
> >    return -EINVAL;
> > - gid_to_del =3D &sgid_tbl->tbl[ctx->idx];
> > + gid_to_del =3D &sgid_tbl->tbl[ctx->idx].gid;
> > + vlan_id =3D sgid_tbl->tbl[ctx->idx].vlan_id;
> >    /* DEL_GID is called in WQ context(netdevice_event_work_handler)
> >    * or via the ib_unregister_device path. In the former case QP1
> >    * may not be destroyed yet, in which case just return as FW
> > @@ -335,7 +337,8 @@ int bnxt_re_del_gid(const struct ib_gid_attr
> > *attr, void **context)
> >    }
> >    ctx->refcnt--;
> >    if (!ctx->refcnt) {
> > - rc =3D bnxt_qplib_del_sgid(sgid_tbl, gid_to_del, true);
> > + rc =3D bnxt_qplib_del_sgid(sgid_tbl, gid_to_del,
> > + vlan_id,  true);
> >    if (rc) {
> >    dev_err(rdev_to_dev(rdev),
> >    "Failed to remove GID: %#x", rc);
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > index 37928b1111df..7f2571f7a13f 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > @@ -488,7 +488,10 @@ static int bnxt_qplib_alloc_sgid_tbl(struct
> > bnxt_qplib_res *res,
> >         struct bnxt_qplib_sgid_tbl *sgid_tbl,
> >         u16 max)
> >   {
> > - sgid_tbl->tbl =3D kcalloc(max, sizeof(struct bnxt_qplib_gid), GFP_KER=
NEL);
> > + u16 i;
> > +
> > + sgid_tbl->tbl =3D kcalloc(max, sizeof(struct bnxt_qplib_gid_info),
> > + GFP_KERNEL);
> >    if (!sgid_tbl->tbl)
> >    return -ENOMEM;
> >
> > @@ -500,6 +503,9 @@ static int bnxt_qplib_alloc_sgid_tbl(struct
> > bnxt_qplib_res *res,
> >    if (!sgid_tbl->ctx)
> >    goto out_free2;
> >
> > + for (i =3D 0; i < max; i++)
> > + sgid_tbl->tbl[i].vlan_id =3D 0xffff;
> > +
> >    sgid_tbl->vlan =3D kcalloc(max, sizeof(u8), GFP_KERNEL);
> >    if (!sgid_tbl->vlan)
> >    goto out_free3;
> > @@ -526,9 +532,11 @@ static void bnxt_qplib_cleanup_sgid_tbl(struct
> > bnxt_qplib_res *res,
> >    for (i =3D 0; i < sgid_tbl->max; i++) {
> >    if (memcmp(&sgid_tbl->tbl[i], &bnxt_qplib_gid_zero,
> >       sizeof(bnxt_qplib_gid_zero)))
> > - bnxt_qplib_del_sgid(sgid_tbl, &sgid_tbl->tbl[i], true);
> > + bnxt_qplib_del_sgid(sgid_tbl, &sgid_tbl->tbl[i].gid,
> > +     sgid_tbl->tbl[i].vlan_id, true);
> >    }
> > - memset(sgid_tbl->tbl, 0, sizeof(struct bnxt_qplib_gid) * sgid_tbl->ma=
x);
> > + memset(sgid_tbl->tbl, 0, sizeof(struct bnxt_qplib_gid_info) *
> > + sgid_tbl->max);
> >    memset(sgid_tbl->hw_id, -1, sizeof(u16) * sgid_tbl->max);
> >    memset(sgid_tbl->vlan, 0, sizeof(u8) * sgid_tbl->max);
> >    sgid_tbl->active =3D 0;
> > @@ -537,7 +545,8 @@ static void bnxt_qplib_cleanup_sgid_tbl(struct
> > bnxt_qplib_res *res,
> >   static void bnxt_qplib_init_sgid_tbl(struct bnxt_qplib_sgid_tbl *sgid=
_tbl,
> >         struct net_device *netdev)
> >   {
> > - memset(sgid_tbl->tbl, 0, sizeof(struct bnxt_qplib_gid) * sgid_tbl->ma=
x);
> > + memset(sgid_tbl->tbl, 0, sizeof(struct bnxt_qplib_gid_info) *
> > + sgid_tbl->max);
> >    memset(sgid_tbl->hw_id, -1, sizeof(u16) * sgid_tbl->max);
> >   }
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > index 30c42c92fac7..fbda11a7ab1a 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > @@ -111,7 +111,7 @@ struct bnxt_qplib_pd_tbl {
> >   };
> >
> >   struct bnxt_qplib_sgid_tbl {
> > - struct bnxt_qplib_gid *tbl;
> > + struct bnxt_qplib_gid_info *tbl;
> >    u16 *hw_id;
> >    u16 max;
> >    u16 active;
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > index 48793d3512ac..40296b97d21e 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > @@ -213,12 +213,12 @@ int bnxt_qplib_get_sgid(struct bnxt_qplib_res *re=
s,
> >    index, sgid_tbl->max);
> >    return -EINVAL;
> >    }
> > - memcpy(gid, &sgid_tbl->tbl[index], sizeof(*gid));
> > + memcpy(gid, &sgid_tbl->tbl[index].gid, sizeof(*gid));
> >    return 0;
> >   }
> >
> >   int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
> > - struct bnxt_qplib_gid *gid, bool update)
> > + struct bnxt_qplib_gid *gid, u16 vlan_id, bool update)
> >   {
> >    struct bnxt_qplib_res *res =3D to_bnxt_qplib(sgid_tbl,
> >       struct bnxt_qplib_res,
> > @@ -236,7 +236,8 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl
> > *sgid_tbl,
> >    return -ENOMEM;
> >    }
> >    for (index =3D 0; index < sgid_tbl->max; index++) {
> > - if (!memcmp(&sgid_tbl->tbl[index], gid, sizeof(*gid)))
> > + if (!memcmp(&sgid_tbl->tbl[index].gid, gid, sizeof(*gid)) &&
> > +     vlan_id =3D=3D sgid_tbl->tbl[index].vlan_id)
> >    break;
> >    }
> >    if (index =3D=3D sgid_tbl->max) {
> > @@ -262,8 +263,9 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl
> > *sgid_tbl,
> >    if (rc)
> >    return rc;
> >    }
> > - memcpy(&sgid_tbl->tbl[index], &bnxt_qplib_gid_zero,
> > + memcpy(&sgid_tbl->tbl[index].gid, &bnxt_qplib_gid_zero,
> >           sizeof(bnxt_qplib_gid_zero));
> > + sgid_tbl->tbl[index].vlan_id =3D 0xFFFF;
> >    sgid_tbl->vlan[index] =3D 0;
> >    sgid_tbl->active--;
> >    dev_dbg(&res->pdev->dev,
> > @@ -296,7 +298,8 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl
> > *sgid_tbl,
> >    }
> >    free_idx =3D sgid_tbl->max;
> >    for (i =3D 0; i < sgid_tbl->max; i++) {
> > - if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid))) {
> > + if (!memcmp(&sgid_tbl->tbl[i], gid, sizeof(*gid)) &&
> > +     sgid_tbl->tbl[i].vlan_id =3D=3D vlan_id) {
> >    dev_dbg(&res->pdev->dev,
> >    "SGID entry already exist in entry %d!\n", i);
> >    *index =3D i;
> > @@ -351,6 +354,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl
> > *sgid_tbl,
> >    }
> >    /* Add GID to the sgid_tbl */
> >    memcpy(&sgid_tbl->tbl[free_idx], gid, sizeof(*gid));
> > + sgid_tbl->tbl[free_idx].vlan_id =3D vlan_id;
> >    sgid_tbl->active++;
> >    if (vlan_id !=3D 0xFFFF)
> >    sgid_tbl->vlan[free_idx] =3D 1;
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > index 0ec3b12b0bcd..b5c4ce302c61 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > @@ -84,6 +84,11 @@ struct bnxt_qplib_gid {
> >    u8 data[16];
> >   };
> >
> > +struct bnxt_qplib_gid_info {
> > + struct bnxt_qplib_gid gid;
> > + u16 vlan_id;
> > +};
> > +
> >   struct bnxt_qplib_ah {
> >    struct bnxt_qplib_gid dgid;
> >    struct bnxt_qplib_pd *pd;
> > @@ -221,7 +226,7 @@ int bnxt_qplib_get_sgid(struct bnxt_qplib_res *res,
> >    struct bnxt_qplib_sgid_tbl *sgid_tbl, int index,
> >    struct bnxt_qplib_gid *gid);
> >   int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
> > - struct bnxt_qplib_gid *gid, bool update);
> > + struct bnxt_qplib_gid *gid, u16 vlan_id, bool update);
> >   int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
> >    struct bnxt_qplib_gid *gid, u8 *mac, u16 vlan_id,
> >    bool update, u32 *index);
