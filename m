Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26B311CC01
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 12:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfLLLPG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 06:15:06 -0500
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:4558
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbfLLLPG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 06:15:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIq7FU2nAMR5EW4sHP3yrC/GO/A0qOJj+Qkl5MZN97Tlsqpse5egS4PK+sL2er/8UTQy1MEeY/vZ9g0s3AtRj7C2SvpBBfR7nsGNfFakS7qxm+hz0XSLMPLgjZVaHxtqsJ9wzQm34ttNXhfhXvzdwug1n2AUOhpKJh4vizwXETyrFN3awyTGwal0M7tYuRq2X3wcD6+wMltvLHPM8sPzYmK7Qv93ua0fQ3RjvRQRoHTNls21OWr5E9bc0+Dl7Tl8mS4SN8ufRGzy1hDhcw897Hzyn2TXQf6ovzxhTkDquSZcnVP5pZrt/iBV9ERw0PTvYhH7TAluees3I0Zzv++FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWBsACJKyhEC5282Hc8YzXdCCzdGHifHjf9AC4xyMqs=;
 b=gcHjCaqvjScKJSTURpWVVTBBsu7u9nzIbrsMAxUV04jzZeKu1Mqd4qq57MhIxjwmtJywwNLaHvodxq1kj99KAK5tzDwX37IIHTOG5E+ytIe+L+oTAKHYDfYAZLJphLClC4IIoeHdfTFxiawjBtYPLLVcOaK8wuMRlo0K2GXRpod4Su0152ktvaqy+a3cVQywH+6LQ3EwmGX/y8gm2VT3FooP3/aatyniYf8HDdX/LxzGguyWfitwBTzS9ikxEwKGcmjPyHl6bWkg7YvX5sqyrOUL3DMBdMZstW7IkMZnD6q3V33A5tApAHjVtFJM9UHJ4Yo9ScmRnYPTwv8KiK4GFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWBsACJKyhEC5282Hc8YzXdCCzdGHifHjf9AC4xyMqs=;
 b=UDgAKXiZ4nmsQT/NhP7Ikk4kw3Cb7/hsCipkwAjmXLftStpzcRAytiJqAjEbAw78DF7Kdm/mzzObf6R0gtcdet3pGDuHJN31pDEcQkLacVhxczX4LWMFn+u9yR59XodQdBId//9V16CD/JvcxFmEphaE86pmDi+zVwxeg6fyGpI=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3425.eurprd05.prod.outlook.com (10.171.190.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Thu, 12 Dec 2019 11:15:01 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398%7]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 11:15:01 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
Thread-Topic: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
Thread-Index: AQHVsNNPQtlOwkoNwEy8CNbUEyEWTqe2WR+A
Date:   Thu, 12 Dec 2019 11:15:01 +0000
Message-ID: <20191212111457.GV67461@unreal>
References: <20191212100237.330654-1-leon@kernel.org>
 <20191212100237.330654-3-leon@kernel.org>
In-Reply-To: <20191212100237.330654-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 895bda33-bda0-46f3-c90e-08d77ef487b0
x-ms-traffictypediagnostic: AM4PR05MB3425:|AM4PR05MB3425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB34251757D87D7292D9D81564B0550@AM4PR05MB3425.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(33656002)(66556008)(4326008)(66446008)(52116002)(6506007)(64756008)(66476007)(316002)(6636002)(1076003)(86362001)(66946007)(26005)(33716001)(6486002)(2906002)(107886003)(9686003)(6512007)(81156014)(478600001)(8676002)(110136005)(54906003)(71200400001)(81166006)(186003)(8936002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3425;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNgYn5dP/tUL6NxUNMfrFw+1lHQ2P9gMQAlzWa3NhHQ/BJ53cmZu4L24NIu3/uZFc45fz8NDs0iNX5UrB7AvIw8QSdZy6HFarYUbKQqLgMyxZdgW9pIgf8pgqhx925XEfi9dil3NZ69VUKpQRJ5i32VRPPL6p1Pwtzp+l231IARETsjjb+BlOi6tXAeWf4TvvKwqEvTAv1TNcLyw4x0qz9Mf7bzf4NOPl7lfgMOkYVQvs5hnJHZSHMqY9YwMAXJ5xKNrLgX2B2LkrJiSjPjNG/sMlVilPxqVwnXEWimKYKTxYofefqIsuVG/wzNeLgUd4qcsh0h/JPF+TELw67sT03cuEeCzH/QRGWjSYpnnGwioagQ6cBNrrwQU1NKMQ6s97QK0bIN+R8zevgztsykOW9IP6PNChfDjJkdB/RIi+o+KFSRl/zz22XwixqiftyDQ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CC58D2627D80C46B042426719A426DC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895bda33-bda0-46f3-c90e-08d77ef487b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 11:15:01.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CamOFgnTUq4DvfKyBPeDxE9Lrtiz2ZZQyTW3QKRdPEgR5OgBcqpr8Jfq+sAlLBXwNXeBfQUbyZbRLAACfPhWBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3425
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 12:02:37PM +0200, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
>
> Fix device memory flows so that only once there will be no live mmaped
> VA to a given allocation the matching object will be destroyed.
>
> This prevents a potential scenario that existing VA that was mmaped by
> one process might still be used post its deallocation despite that it's
> owned now by other process.
>
> The above is achieved by integrating with IB core APIs to manage
> mmap/munmap. Only once the refcount will become 0 the DM object and its
> underlay area will be freed.
>
> Fixes: 3b113a1ec3d4 ("IB/mlx5: Support device memory type attribute")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/cmd.c     |  16 ++--
>  drivers/infiniband/hw/mlx5/cmd.h     |   2 +-
>  drivers/infiniband/hw/mlx5/main.c    | 120 ++++++++++++++++++---------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  19 ++++-
>  4 files changed, 105 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx=
5/cmd.c
> index 4937947400cd..4c26492ab8a3 100644
> --- a/drivers/infiniband/hw/mlx5/cmd.c
> +++ b/drivers/infiniband/hw/mlx5/cmd.c
> @@ -157,7 +157,7 @@ int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_add=
r_t *addr,
>  	return -ENOMEM;
>  }
>
> -int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 len=
gth)
> +void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 le=
ngth)
>  {
>  	struct mlx5_core_dev *dev =3D dm->dev;
>  	u64 hw_start_addr =3D MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr);
> @@ -175,15 +175,13 @@ int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys=
_addr_t addr, u64 length)
>  	MLX5_SET(dealloc_memic_in, in, memic_size, length);
>
>  	err =3D  mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
> +	if (err)
> +		return;
>
> -	if (!err) {
> -		spin_lock(&dm->lock);
> -		bitmap_clear(dm->memic_alloc_pages,
> -			     start_page_idx, num_pages);
> -		spin_unlock(&dm->lock);
> -	}
> -
> -	return err;
> +	spin_lock(&dm->lock);
> +	bitmap_clear(dm->memic_alloc_pages,
> +		     start_page_idx, num_pages);
> +	spin_unlock(&dm->lock);
>  }
>
>  int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *o=
ut)
> diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx=
5/cmd.h
> index 169cab4915e3..945ebce73613 100644
> --- a/drivers/infiniband/hw/mlx5/cmd.h
> +++ b/drivers/infiniband/hw/mlx5/cmd.h
> @@ -46,7 +46,7 @@ int mlx5_cmd_modify_cong_params(struct mlx5_core_dev *m=
dev,
>  				void *in, int in_size);
>  int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
>  			 u64 length, u32 alignment);
> -int mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 len=
gth);
> +void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 le=
ngth);
>  void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
>  void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid);
>  void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid);
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
> index 2f5a159cbe1c..4d89d85226c2 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2074,6 +2074,24 @@ static int mlx5_ib_mmap_clock_info_page(struct mlx=
5_ib_dev *dev,
>  			      virt_to_page(dev->mdev->clock_info));
>  }
>
> +static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
> +{
> +	struct mlx5_user_mmap_entry *mentry =3D to_mmmap(entry);
> +	struct mlx5_ib_dev *dev =3D to_mdev(entry->ucontext->device);
> +	struct mlx5_ib_dm *mdm;
> +
> +	switch (mentry->mmap_flag) {
> +	case MLX5_IB_MMAP_TYPE_MEMIC:
> +		mdm =3D container_of(mentry, struct mlx5_ib_dm, mentry);
> +		mlx5_cmd_dealloc_memic(&dev->dm, mdm->dev_addr,
> +				       mdm->size);
> +		kfree(mdm);
> +		break;
> +	default:
> +		WARN_ON(true);
> +	}
> +}
> +
>  static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
>  		    struct vm_area_struct *vma,
>  		    struct mlx5_ib_ucontext *context)
> @@ -2186,26 +2204,55 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum=
 mlx5_ib_mmap_cmd cmd,
>  	return err;
>  }
>
> -static int dm_mmap(struct ib_ucontext *context, struct vm_area_struct *v=
ma)
> +static int add_dm_mmap_entry(struct ib_ucontext *context,
> +			     struct mlx5_ib_dm *mdm,
> +			     u64 address)
> +{
> +	mdm->mentry.mmap_flag =3D MLX5_IB_MMAP_TYPE_MEMIC;
> +	mdm->mentry.address =3D address;
> +	return rdma_user_mmap_entry_insert_range(
> +			context, &mdm->mentry.rdma_entry,
> +			mdm->size,
> +			MLX5_IB_MMAP_DEVICE_MEM << 16,
> +			(MLX5_IB_MMAP_DEVICE_MEM << 16) + (1UL << 16) - 1);
> +}
> +
> +static unsigned long mlx5_vma_to_pgoff(struct vm_area_struct *vma)
> +{
> +	unsigned long idx;
> +	u8 command;
> +
> +	command =3D get_command(vma->vm_pgoff);
> +	idx =3D get_extended_index(vma->vm_pgoff);
> +
> +	return (command << 16 | idx);
> +}
> +
> +static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
> +			       struct vm_area_struct *vma,
> +			       struct ib_ucontext *ucontext)
>  {
> -	struct mlx5_ib_ucontext *mctx =3D to_mucontext(context);
> -	struct mlx5_ib_dev *dev =3D to_mdev(context->device);
> -	u16 page_idx =3D get_extended_index(vma->vm_pgoff);
> -	size_t map_size =3D vma->vm_end - vma->vm_start;
> -	u32 npages =3D map_size >> PAGE_SHIFT;
> +	struct mlx5_user_mmap_entry *mentry;
> +	struct rdma_user_mmap_entry *entry;
> +	unsigned long pgoff;
> +	pgprot_t prot;
>  	phys_addr_t pfn;
> +	int ret;
>
> -	if (find_next_zero_bit(mctx->dm_pages, page_idx + npages, page_idx) !=
=3D
> -	    page_idx + npages)
> +	pgoff =3D mlx5_vma_to_pgoff(vma);
> +	entry =3D rdma_user_mmap_entry_get_pgoff(ucontext, pgoff);
> +	if (!entry)
>  		return -EINVAL;
>
> -	pfn =3D ((dev->mdev->bar_addr +
> -	      MLX5_CAP64_DEV_MEM(dev->mdev, memic_bar_start_addr)) >>
> -	      PAGE_SHIFT) +
> -	      page_idx;
> -	return rdma_user_mmap_io(context, vma, pfn, map_size,
> -				 pgprot_writecombine(vma->vm_page_prot),
> -				 NULL);
> +	mentry =3D to_mmmap(entry);
> +	pfn =3D (mentry->address >> PAGE_SHIFT);
> +	prot =3D pgprot_writecombine(vma->vm_page_prot);
> +	ret =3D rdma_user_mmap_io(ucontext, vma, pfn,
> +				entry->npages * PAGE_SIZE,
> +				prot,
> +				entry);
> +	rdma_user_mmap_entry_put(&mentry->rdma_entry);
> +	return ret;
>  }
>
>  static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_st=
ruct *vma)
> @@ -2248,11 +2295,8 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcont=
ext, struct vm_area_struct *vm
>  	case MLX5_IB_MMAP_CLOCK_INFO:
>  		return mlx5_ib_mmap_clock_info_page(dev, vma, context);
>
> -	case MLX5_IB_MMAP_DEVICE_MEM:
> -		return dm_mmap(ibcontext, vma);
> -
>  	default:
> -		return -EINVAL;
> +		return mlx5_ib_mmap_offset(dev, vma, ibcontext);
>  	}
>
>  	return 0;
> @@ -2288,8 +2332,9 @@ static int handle_alloc_dm_memic(struct ib_ucontext=
 *ctx,
>  {
>  	struct mlx5_dm *dm_db =3D &to_mdev(ctx->device)->dm;
>  	u64 start_offset;
> -	u32 page_idx;
> +	u16 page_idx =3D 0;

This hunk is not needed.

Thanks
