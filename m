Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB111CC1F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 12:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfLLLVz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 06:21:55 -0500
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:3968
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728871AbfLLLVz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 06:21:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7Sg1GAY1WybFRFPAWoaQkwwOVLnF4WnxEzCwytyeyEuV3B/wCkFgNNMXta/+CsUGSCgoJRFwo69mP8nh4X/g3HC62cUFfmMs1fE45i/iWnXQeUHLqY52hHFLj+tHBlqEZumAqRDrSt+DdY7NGbvDt4bA8U1INvZLW11++g+XaiEhuKDLdenD8vStrzItU+2HHXmtohl4VHcNiMktJVO+ggzPcsWRdE7bSb07LnoBS0SYCNiC4V15r1hMCbOQDtRagut42WCTtgkOT8r+ABHl3tJKRMk1rd2SUEky0EV0HgzCwddnaY0WFgEAnIT4LZhb1J9C3UbE5SyTeC0WNYD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdYZ6TD/SbuY8VGAeWTrzpdUv6s5XRYM0wgO231fQNs=;
 b=QMInzT1qekJWOClE+rvBOQ49sGQy84kQBrd9MkPJyf2FNbeVOIbsJY2OuONjs4AkDSblOEd1M+aQE0aR0LKIu8/EobMC5EklXKDaMABPIutHUk4biGulTONyQKnuq7dUCNwJvT6Nq7Ns5r8yS2NOa+p37QTHtoHs3RtbvP7W3g0JeKEaym9hGUfXhnOO9CaaS73H72UVKjvBE1e5BP/UXW5huTteH1SDtH8v3Sm2IJzVhEwCrfGOvSp1SmX/BoELcTgEr8qAFHaLrP9w31ge4cHuj6xLoY3tS7oEdXLyFmcXp5JD2CFaA4zWRCbZQjMT3xVYOPc8iJDZ8QYzoZx7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdYZ6TD/SbuY8VGAeWTrzpdUv6s5XRYM0wgO231fQNs=;
 b=tGxHWHzCGOhNr8HDAhQZaZiPEjmMH60y9qfdyaB332QEF+/kyEBetAB0w2baO1xCl4dFu/xm7Tw1pYewyLiqsht4rrxMoaRn2mSOElUBwoo/+qpw0VwXKNZJprnCVoJXsPw2lf6G2HvXcLgFrtbBAru3GtmYkontEcD0oRqjd44=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3425.eurprd05.prod.outlook.com (10.171.190.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Thu, 12 Dec 2019 11:21:47 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398%7]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 11:21:47 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
Thread-Topic: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
Thread-Index: AQHVsNNPQtlOwkoNwEy8CNbUEyEWTqe2WR+AgAAB5QA=
Date:   Thu, 12 Dec 2019 11:21:46 +0000
Message-ID: <20191212112144.GW67461@unreal>
References: <20191212100237.330654-1-leon@kernel.org>
 <20191212100237.330654-3-leon@kernel.org> <20191212111457.GV67461@unreal>
In-Reply-To: <20191212111457.GV67461@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::44) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67c4a049-4c09-4b33-ac63-08d77ef57999
x-ms-traffictypediagnostic: AM4PR05MB3425:|AM4PR05MB3425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3425F3D4E6E157196CB75661B0550@AM4PR05MB3425.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(8676002)(81156014)(478600001)(33716001)(26005)(9686003)(6512007)(6486002)(2906002)(107886003)(81166006)(186003)(8936002)(5660300002)(54906003)(71200400001)(110136005)(6506007)(52116002)(64756008)(66476007)(4326008)(66446008)(33656002)(66556008)(86362001)(1076003)(66946007)(316002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3425;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAscHlbfN/rMK3/z/5/jNkR2XcwJrqhjXjzxv66DBYrVRidnqwLjaraGlJW7s+U8XbPssfmDkmsM81lZxkwDNnwNMRK7kTt8DWJjtn9FBm/CxLsNdPSc27ebhXEd+9CLeJxTIYVj7nNEgDsqQRpaNMlz/qCt+g7b4gvYuu8+gTYd2CVUJAO2DM8CyYFrzTBPzXf9NckSqT/OXDrtuYWxbkD3D8y6S2mI7UpiADqKHpWzEih1f2TU30geGzGg0/JJhkJJi61vnCcRR6Y95QD7nD1vw/6yEeOsVwJXnagp1/XxoP1tDsmCWd+YGXyX+EcwE4ammyg+BsbuTIlrcvXTcL/T/WyYX3X9EkihcTFrUKT1cToZztOod5259jjdxGxcKvqPO0JN8l/GMotf4Eh2bgy0tzSU6ksdXYECBK5ZW68h0HEYhVKT+5mktODn0VN3
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E25AB1F6B8177E4E8A0F05644B61E3F0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c4a049-4c09-4b33-ac63-08d77ef57999
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 11:21:46.9385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZxxsHJ1sa/vL1XKs0PJtYG/tm7L66oWO5ZiHHNZC4v2PwJ7Yo+YlUdOAYnzoRb+xo2MdERp4kGhv5pGWUQhHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3425
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 11:15:01AM +0000, Leon Romanovsky wrote:
> On Thu, Dec 12, 2019 at 12:02:37PM +0200, Leon Romanovsky wrote:
> > From: Yishai Hadas <yishaih@mellanox.com>
> >
> > Fix device memory flows so that only once there will be no live mmaped
> > VA to a given allocation the matching object will be destroyed.
> >
> > This prevents a potential scenario that existing VA that was mmaped by
> > one process might still be used post its deallocation despite that it's
> > owned now by other process.
> >
> > The above is achieved by integrating with IB core APIs to manage
> > mmap/munmap. Only once the refcount will become 0 the DM object and its
> > underlay area will be freed.
> >
> > Fixes: 3b113a1ec3d4 ("IB/mlx5: Support device memory type attribute")
> > Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/hw/mlx5/cmd.c     |  16 ++--
> >  drivers/infiniband/hw/mlx5/cmd.h     |   2 +-
> >  drivers/infiniband/hw/mlx5/main.c    | 120 ++++++++++++++++++---------
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h |  19 ++++-
> >  4 files changed, 105 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/m=
lx5/cmd.c
> > index 4937947400cd..4c26492ab8a3 100644
> > --- a/drivers/infiniband/hw/mlx5/cmd.c
> > +++ b/drivers/infiniband/hw/mlx5/cmd.c
> > @@ -157,7 +157,7 @@ int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_a=
ddr_t *addr,
> >  	return -ENOMEM;
> >  }
> >
> > -int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 l=
ength)
> > +void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 =
length)
> >  {
> >  	struct mlx5_core_dev *dev =3D dm->dev;
> >  	u64 hw_start_addr =3D MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr);
> > @@ -175,15 +175,13 @@ int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, ph=
ys_addr_t addr, u64 length)
> >  	MLX5_SET(dealloc_memic_in, in, memic_size, length);
> >
> >  	err =3D  mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
> > +	if (err)
> > +		return;
> >
> > -	if (!err) {
> > -		spin_lock(&dm->lock);
> > -		bitmap_clear(dm->memic_alloc_pages,
> > -			     start_page_idx, num_pages);
> > -		spin_unlock(&dm->lock);
> > -	}
> > -
> > -	return err;
> > +	spin_lock(&dm->lock);
> > +	bitmap_clear(dm->memic_alloc_pages,
> > +		     start_page_idx, num_pages);
> > +	spin_unlock(&dm->lock);
> >  }
> >
> >  int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void =
*out)
> > diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/m=
lx5/cmd.h
> > index 169cab4915e3..945ebce73613 100644
> > --- a/drivers/infiniband/hw/mlx5/cmd.h
> > +++ b/drivers/infiniband/hw/mlx5/cmd.h
> > @@ -46,7 +46,7 @@ int mlx5_cmd_modify_cong_params(struct mlx5_core_dev =
*mdev,
> >  				void *in, int in_size);
> >  int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
> >  			 u64 length, u32 alignment);
> > -int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 l=
ength);
> > +void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 =
length);
> >  void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
> >  void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid=
);
> >  void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid=
);
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/=
mlx5/main.c
> > index 2f5a159cbe1c..4d89d85226c2 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -2074,6 +2074,24 @@ static int mlx5_ib_mmap_clock_info_page(struct m=
lx5_ib_dev *dev,
> >  			      virt_to_page(dev->mdev->clock_info));
> >  }
> >
> > +static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
> > +{
> > +	struct mlx5_user_mmap_entry *mentry =3D to_mmmap(entry);
> > +	struct mlx5_ib_dev *dev =3D to_mdev(entry->ucontext->device);
> > +	struct mlx5_ib_dm *mdm;
> > +
> > +	switch (mentry->mmap_flag) {
> > +	case MLX5_IB_MMAP_TYPE_MEMIC:
> > +		mdm =3D container_of(mentry, struct mlx5_ib_dm, mentry);
> > +		mlx5_cmd_dealloc_memic(&dev->dm, mdm->dev_addr,
> > +				       mdm->size);
> > +		kfree(mdm);
> > +		break;
> > +	default:
> > +		WARN_ON(true);
> > +	}
> > +}
> > +
> >  static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd=
,
> >  		    struct vm_area_struct *vma,
> >  		    struct mlx5_ib_ucontext *context)
> > @@ -2186,26 +2204,55 @@ static int uar_mmap(struct mlx5_ib_dev *dev, en=
um mlx5_ib_mmap_cmd cmd,
> >  	return err;
> >  }
> >
> > -static int dm_mmap(struct ib_ucontext *context, struct vm_area_struct =
*vma)
> > +static int add_dm_mmap_entry(struct ib_ucontext *context,
> > +			     struct mlx5_ib_dm *mdm,
> > +			     u64 address)
> > +{
> > +	mdm->mentry.mmap_flag =3D MLX5_IB_MMAP_TYPE_MEMIC;
> > +	mdm->mentry.address =3D address;
> > +	return rdma_user_mmap_entry_insert_range(
> > +			context, &mdm->mentry.rdma_entry,
> > +			mdm->size,
> > +			MLX5_IB_MMAP_DEVICE_MEM << 16,
> > +			(MLX5_IB_MMAP_DEVICE_MEM << 16) + (1UL << 16) - 1);
> > +}
> > +
> > +static unsigned long mlx5_vma_to_pgoff(struct vm_area_struct *vma)
> > +{
> > +	unsigned long idx;
> > +	u8 command;
> > +
> > +	command =3D get_command(vma->vm_pgoff);
> > +	idx =3D get_extended_index(vma->vm_pgoff);
> > +
> > +	return (command << 16 | idx);
> > +}
> > +
> > +static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
> > +			       struct vm_area_struct *vma,
> > +			       struct ib_ucontext *ucontext)
> >  {
> > -	struct mlx5_ib_ucontext *mctx =3D to_mucontext(context);
> > -	struct mlx5_ib_dev *dev =3D to_mdev(context->device);
> > -	u16 page_idx =3D get_extended_index(vma->vm_pgoff);
> > -	size_t map_size =3D vma->vm_end - vma->vm_start;
> > -	u32 npages =3D map_size >> PAGE_SHIFT;
> > +	struct mlx5_user_mmap_entry *mentry;
> > +	struct rdma_user_mmap_entry *entry;
> > +	unsigned long pgoff;
> > +	pgprot_t prot;
> >  	phys_addr_t pfn;
> > +	int ret;
> >
> > -	if (find_next_zero_bit(mctx->dm_pages, page_idx + npages, page_idx) !=
=3D
> > -	    page_idx + npages)
> > +	pgoff =3D mlx5_vma_to_pgoff(vma);
> > +	entry =3D rdma_user_mmap_entry_get_pgoff(ucontext, pgoff);
> > +	if (!entry)
> >  		return -EINVAL;
> >
> > -	pfn =3D ((dev->mdev->bar_addr +
> > -	      MLX5_CAP64_DEV_MEM(dev->mdev, memic_bar_start_addr)) >>
> > -	      PAGE_SHIFT) +
> > -	      page_idx;
> > -	return rdma_user_mmap_io(context, vma, pfn, map_size,
> > -				 pgprot_writecombine(vma->vm_page_prot),
> > -				 NULL);
> > +	mentry =3D to_mmmap(entry);
> > +	pfn =3D (mentry->address >> PAGE_SHIFT);
> > +	prot =3D pgprot_writecombine(vma->vm_page_prot);
> > +	ret =3D rdma_user_mmap_io(ucontext, vma, pfn,
> > +				entry->npages * PAGE_SIZE,
> > +				prot,
> > +				entry);
> > +	rdma_user_mmap_entry_put(&mentry->rdma_entry);
> > +	return ret;
> >  }
> >
> >  static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_=
struct *vma)
> > @@ -2248,11 +2295,8 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibco=
ntext, struct vm_area_struct *vm
> >  	case MLX5_IB_MMAP_CLOCK_INFO:
> >  		return mlx5_ib_mmap_clock_info_page(dev, vma, context);
> >
> > -	case MLX5_IB_MMAP_DEVICE_MEM:
> > -		return dm_mmap(ibcontext, vma);
> > -
> >  	default:
> > -		return -EINVAL;
> > +		return mlx5_ib_mmap_offset(dev, vma, ibcontext);
> >  	}
> >
> >  	return 0;
> > @@ -2288,8 +2332,9 @@ static int handle_alloc_dm_memic(struct ib_uconte=
xt *ctx,
> >  {
> >  	struct mlx5_dm *dm_db =3D &to_mdev(ctx->device)->dm;
> >  	u64 start_offset;
> > -	u32 page_idx;
> > +	u16 page_idx =3D 0;
>
> This hunk is not needed.

To be clear, I wanted to say this about "=3D 0" part. The change of the
type is still needed.

Thanks

>
> Thanks
