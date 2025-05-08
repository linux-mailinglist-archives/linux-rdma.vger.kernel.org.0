Return-Path: <linux-rdma+bounces-10150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC2AAF4C0
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 09:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15AB1C0646A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEE221F0B;
	Thu,  8 May 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S+A/3Cg7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F121D596
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689823; cv=none; b=jWXI2F426ptpZt/4CeFKPQzoy8X4RuXz4Yspdv/TESvu1HlXTEylBtvw2i8k/RieWEWVzYFe2zu+zPa2Ue1YKgzmWYSkoeb2o0sWKI2oAOJUX0eqVCh3QcD4A8mci5dKJaX8N1p3rP7Q/BrGIhGXhgroPKlME8Vh3KLiE7HUTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689823; c=relaxed/simple;
	bh=aV9GSRXkFpfrXUDnQdF5YMiuhIbSpZGgZyqtfUaSdZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edLF61uf1X5g/bAYAuHuYhnwosqdlzYqQtHpJKBRYZdJYtVirvJT7yuTgPW91c0p23NMad+8cFA7Jcm7MC23tqMLbm+WM4QLu40bs/n4wl4a9nXHmHkaVmoU6gjYyIUKw9OC4R2vZHrkRhj8QItQC43jRB62fSMh/eWTHGLy+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S+A/3Cg7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso934395b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 May 2025 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746689819; x=1747294619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XrT0dMZXA7jGZJH7z2Wk9Vn/fV/CXKfd2L11bqedvhY=;
        b=S+A/3Cg7iihOaEpprFhSIFIVTXo1LSWoJvVPzx3zJ4my01iReU3ALtYjGarOU6E3Tz
         RGr5JmcIxbLqUo/QlglYMFrRdwNoFgn+UpVNGO9yU9btILiOJhhC5dXpfKeMItkQKTuJ
         vY5pOSE29IJ21TvOOxJKQhDaRlscbqjhvpsaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746689819; x=1747294619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrT0dMZXA7jGZJH7z2Wk9Vn/fV/CXKfd2L11bqedvhY=;
        b=WEvn4IdcmHkuDO8xWfW1yO+eaM0Gcn+q0wbvWjUmCKWiPnkFTanrJCC7DpTu/ziRYB
         px2zbjPgAT+HA0g5mKap/2dx8hyyJf9FjriFRI40/R4rP6+oX0FSk4AjFgMJ2SFUBN76
         EaKc7Z+1sSwF4WcEE3A1e4R60aDN+nl9QxdyqJySzm6/KghImi7hjJKsfC0cWbRIWPQy
         9ooLbBog4Z0ENGyIJ9XtVKQebCd0tx3dW4vfJD9qLGxXXEhFFOpq7PirzrUSvQ9R7k6c
         2BSkioVQF5cYGKWgkNzS0OPEptIjy6jm4ZVkKqcNEIMUuFv/sAb3RZ+VmUoSVpQeuWCf
         GDyg==
X-Forwarded-Encrypted: i=1; AJvYcCXvQOXIHt8s4AswWS0b4UomDBiRV5JyFvvF+GeVs7oE/F0Zz3H1aRCVdLV6ZwFgY7CCxTCAiABegoE6@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9ZvmgniE36UNIGhmyxkupgoKs6hwy6rlx/NLPDC4K85dDVp9
	AUsF6Pbk3GJhB+m21sQAXCEe3z/3jXj0wnAP2rpewjFIuSIUWGM5bM2en4RuqfBuM7uPg5Hg4eC
	JwN/n3NKX72/EwgBWa0tYeOdB0UGg2ex7yAnU
X-Gm-Gg: ASbGncuB/aKFeFYfbrKUPG3Zk3vIITk9bTVCAgA/63+UFdUaoJ22DaJiw7mkvXoHAz5
	MrQH/k7BcpVDO/lohjlSIQGnUOjzxEXpkIGOL6sVhfwK0MTmbtxyISTZ2txlXVWf4MM9Uhi6EjG
	qYKid4Uj++6N46pa+rkeJV
X-Google-Smtp-Source: AGHT+IFB8JkFGRlbnlOVYykX7v/f06YcLbeGlLW2aAxnTBsvwBu08mIWRTh3ZelYym01WYd+YNsc/0ZnZEOLCsunXrY=
X-Received: by 2002:aa7:9316:0:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-7409cfef303mr9062460b3a.21.1746689819508; Thu, 08 May 2025
 00:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com> <20250508045957.2823318-9-abhijit.gangurde@amd.com>
In-Reply-To: <20250508045957.2823318-9-abhijit.gangurde@amd.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 8 May 2025 13:06:47 +0530
X-Gm-Features: ATxdqUGhazH4PlIoFulZVFyin8xyWDgso205DYpeeWHlQh8sghrJfFsB8Owk4B0
Message-ID: <CAH-L+nM86KduwFfEUDdGOSx865Dq=YHaVfUZU8GRqb2C3tq7dQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	jgg@ziepe.ca, leon@kernel.org, andrew+netdev@lunn.ch, allen.hubbe@amd.com, 
	nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Boyer <andrew.boyer@amd.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003f299e06349aeade"

--0000000000003f299e06349aeade
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:33=E2=80=AFAM Abhijit Gangurde
<abhijit.gangurde@amd.com> wrote:
>
> Register auxiliary module to create ibdevice for ionic
> ethernet adapter.
>
> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
> v1->v2
>   - Removed netdev references from ionic RDMA driver
>   - Moved to ionic_lif* instead of void* to convey information between
>     aux devices and drivers.
>
>  drivers/infiniband/hw/ionic/ionic_ibdev.c   | 135 ++++++++++++++++++++
>  drivers/infiniband/hw/ionic/ionic_ibdev.h   |  21 +++
>  drivers/infiniband/hw/ionic/ionic_lif_cfg.c | 121 ++++++++++++++++++
>  drivers/infiniband/hw/ionic/ionic_lif_cfg.h |  65 ++++++++++
>  4 files changed, 342 insertions(+)
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h
>
> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniba=
nd/hw/ionic/ionic_ibdev.c
> new file mode 100644
> index 000000000000..ca047a789378
> --- /dev/null
> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <net/addrconf.h>
> +
> +#include "ionic_ibdev.h"
> +
> +#define DRIVER_DESCRIPTION "AMD Pensando RoCE HCA driver"
> +#define DEVICE_DESCRIPTION "AMD Pensando RoCE HCA"
> +
> +MODULE_AUTHOR("Allen Hubbe <allen.hubbe@amd.com>");
> +MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("NET_IONIC");
> +
> +static const struct auxiliary_device_id ionic_aux_id_table[] =3D {
> +       { .name =3D "ionic.rdma", },
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, ionic_aux_id_table);
> +
> +static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
> +{
> +       ib_unregister_device(&dev->ibdev);
> +       ib_dealloc_device(&dev->ibdev);
> +}
> +
> +static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ioni=
c_adev)
> +{
> +       struct ib_device *ibdev;
> +       struct ionic_ibdev *dev;
> +       int rc;
> +
> +       rc =3D ionic_version_check(&ionic_adev->adev.dev, ionic_adev->lif=
);
> +       if (rc)
> +               goto err_dev;
You can return directly from here
> +
> +       dev =3D ib_alloc_device(ionic_ibdev, ibdev);
> +       if (!dev) {
> +               rc =3D -ENOMEM;
> +               goto err_dev;
You can return directly from here
> +       }
> +
> +       ionic_fill_lif_cfg(ionic_adev->lif, &dev->lif_cfg);
> +
> +       ibdev =3D &dev->ibdev;
> +       ibdev->dev.parent =3D dev->lif_cfg.hwdev;
> +
> +       strscpy(ibdev->name, "ionic_%d", IB_DEVICE_NAME_MAX);
> +       strscpy(ibdev->node_desc, DEVICE_DESCRIPTION, IB_DEVICE_NODE_DESC=
_MAX);
> +
> +       ibdev->node_type =3D RDMA_NODE_IB_CA;
> +       ibdev->phys_port_cnt =3D 1;
> +
> +       /* the first two eq are reserved for async events */
> +       ibdev->num_comp_vectors =3D dev->lif_cfg.eq_count - 2;
> +
> +       addrconf_ifid_eui48((u8 *)&ibdev->node_guid,
> +                           ionic_lif_netdev(ionic_adev->lif));
> +
> +       rc =3D ib_device_set_netdev(ibdev, ionic_lif_netdev(ionic_adev->l=
if), 1);
> +       if (rc)
> +               goto err_admin;
> +
> +       rc =3D ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
> +       if (rc)
> +               goto err_register;
> +
> +       return dev;
> +
> +err_register:
Unnecessary label
> +err_admin:
> +       ib_dealloc_device(&dev->ibdev);
> +err_dev:
> +       return ERR_PTR(rc);
> +}
> +
> +static int ionic_aux_probe(struct auxiliary_device *adev,
> +                          const struct auxiliary_device_id *id)
> +{
> +       struct ionic_aux_dev *ionic_adev;
> +       struct ionic_ibdev *dev;
> +
> +       ionic_adev =3D container_of(adev, struct ionic_aux_dev, adev);
> +       dev =3D ionic_create_ibdev(ionic_adev);
> +       if (IS_ERR(dev))
> +               return dev_err_probe(&adev->dev, PTR_ERR(dev),
> +                                    "Failed to register ibdev\n");
> +
> +       auxiliary_set_drvdata(adev, dev);
> +       ibdev_dbg(&dev->ibdev, "registered\n");
> +
> +       return 0;
> +}
> +
> +static void ionic_aux_remove(struct auxiliary_device *adev)
> +{
> +       struct ionic_ibdev *dev =3D auxiliary_get_drvdata(adev);
> +
> +       dev_dbg(&adev->dev, "unregister ibdev\n");
> +       ionic_destroy_ibdev(dev);
> +       dev_dbg(&adev->dev, "unregistered\n");
> +}
> +
> +static struct auxiliary_driver ionic_aux_r_driver =3D {
> +       .name =3D "rdma",
> +       .probe =3D ionic_aux_probe,
> +       .remove =3D ionic_aux_remove,
> +       .id_table =3D ionic_aux_id_table,
> +};
> +
> +static int __init ionic_mod_init(void)
> +{
> +       int rc;
> +
> +       rc =3D auxiliary_driver_register(&ionic_aux_r_driver);
> +       if (rc)
> +               goto err_aux;
> +
> +       return 0;
> +
> +err_aux:
> +       return rc;
You can simplify this function as "return
auxiliary_driver_register(&ionic_aux_r_driver);"
> +}
> +
> +static void __exit ionic_mod_exit(void)
> +{
> +       auxiliary_driver_unregister(&ionic_aux_r_driver);
> +}
> +
> +module_init(ionic_mod_init);
> +module_exit(ionic_mod_exit);
> diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniba=
nd/hw/ionic/ionic_ibdev.h
> new file mode 100644
> index 000000000000..e13adff390d7
> --- /dev/null
> +++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#ifndef _IONIC_IBDEV_H_
> +#define _IONIC_IBDEV_H_
> +
> +#include <rdma/ib_verbs.h>
> +#include <ionic_api.h>
> +
> +#include "ionic_lif_cfg.h"
> +
> +#define IONIC_MIN_RDMA_VERSION 0
> +#define IONIC_MAX_RDMA_VERSION 2
> +
> +struct ionic_ibdev {
> +       struct ib_device        ibdev;
> +
> +       struct ionic_lif_cfg    lif_cfg;
> +};
> +
> +#endif /* _IONIC_IBDEV_H_ */
> diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infini=
band/hw/ionic/ionic_lif_cfg.c
> new file mode 100644
> index 000000000000..a02eb2f5bd45
> --- /dev/null
> +++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#include <linux/kernel.h>
> +
> +#include <ionic.h>
> +#include <ionic_lif.h>
> +
> +#include "ionic_lif_cfg.h"
> +
> +#define IONIC_MIN_RDMA_VERSION 0
> +#define IONIC_MAX_RDMA_VERSION 2
> +
> +static u8 ionic_get_expdb(struct ionic_lif *lif)
> +{
> +       u8 expdb_support =3D 0;
> +
> +       if (lif->ionic->idev.phy_cmb_expdb64_pages)
> +               expdb_support |=3D IONIC_EXPDB_64B_WQE;
> +       if (lif->ionic->idev.phy_cmb_expdb128_pages)
> +               expdb_support |=3D IONIC_EXPDB_128B_WQE;
> +       if (lif->ionic->idev.phy_cmb_expdb256_pages)
> +               expdb_support |=3D IONIC_EXPDB_256B_WQE;
> +       if (lif->ionic->idev.phy_cmb_expdb512_pages)
> +               expdb_support |=3D IONIC_EXPDB_512B_WQE;
> +
> +       return expdb_support;
> +}
> +
> +void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg=
)
> +{
> +       union ionic_lif_identity *ident =3D &lif->ionic->ident.lif;
> +
> +       cfg->lif =3D lif;
> +       cfg->hwdev =3D &lif->ionic->pdev->dev;
> +       cfg->lif_index =3D lif->index;
> +       cfg->lif_hw_index =3D lif->hw_index;
> +
> +       cfg->dbid =3D lif->kern_pid;
> +       cfg->dbid_count =3D le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_=
lif);
> +       cfg->dbpage =3D lif->kern_dbpage;
> +       cfg->intr_ctrl =3D lif->ionic->idev.intr_ctrl;
> +
> +       cfg->db_phys =3D lif->ionic->bars[IONIC_PCI_BAR_DBELL].bus_addr;
> +
> +       if (IONIC_VERSION(ident->rdma.version, ident->rdma.minor_version)=
 >=3D
> +           IONIC_VERSION(2, 1))
> +               cfg->page_size_supported =3D
> +                   cpu_to_le64(ident->rdma.page_size_cap);
> +       else
> +               cfg->page_size_supported =3D IONIC_PAGE_SIZE_SUPPORTED;
> +
> +       cfg->rdma_version =3D ident->rdma.version;
> +       cfg->qp_opcodes =3D ident->rdma.qp_opcodes;
> +       cfg->admin_opcodes =3D ident->rdma.admin_opcodes;
> +
> +       cfg->stats_type =3D cpu_to_le16(ident->rdma.stats_type);
> +       cfg->npts_per_lif =3D le32_to_cpu(ident->rdma.npts_per_lif);
> +       cfg->nmrs_per_lif =3D le32_to_cpu(ident->rdma.nmrs_per_lif);
> +       cfg->nahs_per_lif =3D le32_to_cpu(ident->rdma.nahs_per_lif);
> +
> +       cfg->aq_base =3D le32_to_cpu(ident->rdma.aq_qtype.qid_base);
> +       cfg->cq_base =3D le32_to_cpu(ident->rdma.cq_qtype.qid_base);
> +       cfg->eq_base =3D le32_to_cpu(ident->rdma.eq_qtype.qid_base);
> +
> +       /*
> +        * ionic_create_rdma_admin() may reduce aq_count or eq_count if
> +        * it is unable to allocate all that were requested.
> +        * aq_count is tunable; see ionic_aq_count
> +        * eq_count is tunable; see ionic_eq_count
> +        */
> +       cfg->aq_count =3D le32_to_cpu(ident->rdma.aq_qtype.qid_count);
> +       cfg->eq_count =3D le32_to_cpu(ident->rdma.eq_qtype.qid_count);
> +       cfg->cq_count =3D le32_to_cpu(ident->rdma.cq_qtype.qid_count);
> +       cfg->qp_count =3D le32_to_cpu(ident->rdma.sq_qtype.qid_count);
> +       cfg->dbid_count =3D le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_=
lif);
> +
> +       cfg->aq_qtype =3D ident->rdma.aq_qtype.qtype;
> +       cfg->sq_qtype =3D ident->rdma.sq_qtype.qtype;
> +       cfg->rq_qtype =3D ident->rdma.rq_qtype.qtype;
> +       cfg->cq_qtype =3D ident->rdma.cq_qtype.qtype;
> +       cfg->eq_qtype =3D ident->rdma.eq_qtype.qtype;
> +       cfg->udma_qgrp_shift =3D ident->rdma.udma_shift;
> +       cfg->udma_count =3D 2;
> +
> +       cfg->max_stride =3D ident->rdma.max_stride;
> +       cfg->expdb_mask =3D ionic_get_expdb(lif);
> +
> +       cfg->sq_expdb =3D
> +           !!(lif->qtype_info[IONIC_QTYPE_TXQ].features & IONIC_QIDENT_F=
_EXPDB);
> +       cfg->rq_expdb =3D
> +           !!(lif->qtype_info[IONIC_QTYPE_RXQ].features & IONIC_QIDENT_F=
_EXPDB);
> +}
> +
> +struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
> +{
> +       return lif->netdev;
> +}
> +
> +int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
> +{
> +       union ionic_lif_identity *ident =3D &lif->ionic->ident.lif;
> +       int rc;
local variable "rc" is not needed here, you can return directly.
> +
> +       if (ident->rdma.version < IONIC_MIN_RDMA_VERSION ||
> +           ident->rdma.version > IONIC_MAX_RDMA_VERSION) {
> +               rc =3D -EINVAL;
> +               dev_err_probe(dev, rc,
> +                             "ionic_rdma: incompatible version, fw ver %=
u\n",
> +                             ident->rdma.version);
> +               dev_err_probe(dev, rc,
> +                             "ionic_rdma: Driver Min Version %u\n",
> +                             IONIC_MIN_RDMA_VERSION);
> +               dev_err_probe(dev, rc,
> +                             "ionic_rdma: Driver Max Version %u\n",
> +                             IONIC_MAX_RDMA_VERSION);
> +               return rc;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infini=
band/hw/ionic/ionic_lif_cfg.h
> new file mode 100644
> index 000000000000..b095637c54cf
> --- /dev/null
> +++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#ifndef _IONIC_LIF_CFG_H_
> +
> +#define IONIC_VERSION(a, b) (((a) << 16) + ((b) << 8))
> +#define IONIC_PAGE_SIZE_SUPPORTED      0x40201000 /* 4kb, 2Mb, 1Gb */
> +
> +#define IONIC_EXPDB_64B_WQE    BIT(0)
> +#define IONIC_EXPDB_128B_WQE   BIT(1)
> +#define IONIC_EXPDB_256B_WQE   BIT(2)
> +#define IONIC_EXPDB_512B_WQE   BIT(3)
> +
> +struct ionic_lif_cfg {
> +       struct device *hwdev;
> +       struct ionic_lif *lif;
> +
> +       int lif_index;
> +       int lif_hw_index;
> +
> +       u32 dbid;
> +       int dbid_count;
> +       u64 __iomem *dbpage;
> +       struct ionic_intr __iomem *intr_ctrl;
> +       phys_addr_t db_phys;
> +
> +       u64 page_size_supported;
> +       u32 npts_per_lif;
> +       u32 nmrs_per_lif;
> +       u32 nahs_per_lif;
> +
> +       u32 aq_base;
> +       u32 cq_base;
> +       u32 eq_base;
> +
> +       int aq_count;
> +       int eq_count;
> +       int cq_count;
> +       int qp_count;
> +
> +       u16 stats_type;
> +       u8 aq_qtype;
> +       u8 sq_qtype;
> +       u8 rq_qtype;
> +       u8 cq_qtype;
> +       u8 eq_qtype;
> +
> +       u8 udma_count;
> +       u8 udma_qgrp_shift;
> +
> +       u8 rdma_version;
> +       u8 qp_opcodes;
> +       u8 admin_opcodes;
> +
> +       u8 max_stride;
> +       bool sq_expdb;
> +       bool rq_expdb;
> +       u8 expdb_mask;
> +};
> +
> +int ionic_version_check(const struct device *dev, struct ionic_lif *lif)=
;
> +void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg=
);
> +struct net_device *ionic_lif_netdev(struct ionic_lif *lif);
> +
> +#endif /* _IONIC_LIF_CFG_H_ */
> --
> 2.34.1
>
>


--=20
Regards,
Kalesh AP

--0000000000003f299e06349aeade
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfgYJKoZIhvcNAQcCoIIQbzCCEGsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3iMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIDgR1CvKUA/YJ9TaZgbXzZS0o/ciG1B2oj/8Su/KrNyBMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUwODA3MzY1OVowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABk5PFg28mfGH4Yogmgxa1whmS1z
GsieMJFtSKO3NPCYcTEfRrh/HvoXgxW+7cNtNO0fp3+MZe4Y8SSGeDza7VnvZyMQEQvKdue7pEw/
PDFELuNUiqPDAQh/3n/R6kpTDECPQ2MV5IM7hRUgibfMQCyKBnCPrD9Ixdsto8Q3YX0k+JMDR1aN
+Bm3G1dEI8P4/WgwpebdbuYRVTZNAjlWtfg+j8W32NnuFUXKBG9p7cP6qBreGkgGJjirV3d5Hieh
IvkWILfMh2KymQelQB9abh2bVVWAbmkt+yG49Wx3CqXVeOll4KbLYip1reFPIBQAebv7YoZvfKcR
DJAeDEy0hKo=
--0000000000003f299e06349aeade--

