Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C8E1642D3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 12:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSLBn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 06:01:43 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43818 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSLBm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 06:01:42 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so10581624qvo.10
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSCHLZmR4+cmvWJoFA0Sxb4S5sx/KSicl7zZdvBviGU=;
        b=UNANKDJOlB3qZA6mdrf4Mv9IFCk9Qo2FxXKlX5wBk4JZPRQ2U0vDrYqohndwyhN/+a
         M9/NA7xI5Z2oLu77CzaV5+P3n8P1IyHoi6FBiDV0z6doP91p7RMOv+d6f6O1RSXVNHQE
         yHm7m3TK99eEm6SS1kameQgNZc6aEfcnRvioVKoYAPuJOGThze3G5hNZOrZmJL46KR9Q
         rtrBft+Oq5vzOLb1YLNXm7LhFGPq0dZh0pZy2gNB5dNEmdP5I/pMzoz0lemMFcXO5593
         NJoLY2oXKrXvPzWWjCzPM7um53COBjwUuIJ9qQvAgJQavkNQ3RdoBWtgZ9wsN8Yg3Ruv
         caug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSCHLZmR4+cmvWJoFA0Sxb4S5sx/KSicl7zZdvBviGU=;
        b=i40BWhhrHAKISl2wu9C5WGPdtl8Z/qSeGsDcvhjzUnd0+AwjHdXPGpzmTlodtZOiYH
         SFiMXZSUdtpRcRm+7Ed1YwQ8DT0GLYS2IYogdoqW5pzJnv/mxEQ+zd9MkbH2iLv9o719
         mwDO/pw+khwVhqgH/TZoSFhigJP/8bYs28Syc70kabPjXa90h8qLGPEUGIqAuqcXBNBw
         /z2mBQ9hrY1ZyJ4KYG5nUEKyfRfg3GCGzcp6cQK1Pt24xXM0G0vV55FLz5YcFicEHRv6
         AH/zpQ700KWYwF1d5MGF+AF6xRu/I869KLi60syF4zgDNnBWXzaa3TrObyij55Dw5xCq
         upcQ==
X-Gm-Message-State: APjAAAVYTm8g+Ar1Deuxg9s2WHV2Fq5zaoq1Xf8fLtSbJcVD2fMzDDAM
        s5J0h+hrIW503Bwy+2wkK94nFvzFW1UF+bGfhPVh+g==
X-Google-Smtp-Source: APXvYqzUnMfzBwHUrY7A+Fc6O/NV7gkoMBXL6UR/ZsUcxn8RGCJY8Th59YOHfizKPl3VTdn1NU5R5fe6m3cyINYn2fs=
X-Received: by 2002:ad4:56a7:: with SMTP id bd7mr20721954qvb.238.1582110101081;
 Wed, 19 Feb 2020 03:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com> <20200210131850.87776.40842.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210131850.87776.40842.stgit@awfm-01.aw.intel.com>
From:   Erez Shitrit <erezsh@dev.mellanox.co.il>
Date:   Wed, 19 Feb 2020 13:01:30 +0200
Message-ID: <CAAk-MO-NZbL8WjUB+eupK_0uYAJXEyvKjEVX8Bo5DzkExNnweg@mail.gmail.com>
Subject: Re: [PATCH for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marcinisyzn@intel.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 3:18 PM Dennis Dalessandro
<dennis.dalessandro@intel.com> wrote:
>
> From: Sadanand Warrier <sadanand.warrier@intel.com>
>
> Currently the ipoib UD mtu is restricted to 4K bytes. Remove this
> limitation so that the IPOIB module can potentially use an MTU (in UD
> mode) that is bounded by the MTU of the underlying device. A field is
> added to the ib_port_attr structure to indicate the maximum physical
> MTU the underlying device supports.
>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Reviewed-by: Mike Marciniszyn <mike.marcinisyzn@intel.com>
> Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/qp.c                |   18 +------
>  drivers/infiniband/hw/hfi1/verbs.c             |    2 +
>  drivers/infiniband/ulp/ipoib/ipoib_main.c      |    5 ++
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   11 ++--
>  include/rdma/ib_verbs.h                        |   60 ++++++++++++++++++++++++
>  include/rdma/opa_port_info.h                   |   10 ----
>  6 files changed, 74 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
> index f8e733a..0c2ae9f 100644
> --- a/drivers/infiniband/hw/hfi1/qp.c
> +++ b/drivers/infiniband/hw/hfi1/qp.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright(c) 2015 - 2019 Intel Corporation.
> + * Copyright(c) 2015 - 2020 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
>   * redistributing this file, you may do so under either license.
> @@ -186,15 +186,6 @@ static void flush_iowait(struct rvt_qp *qp)
>         write_sequnlock_irqrestore(lock, flags);
>  }
>
> -static inline int opa_mtu_enum_to_int(int mtu)
> -{
> -       switch (mtu) {
> -       case OPA_MTU_8192:  return 8192;
> -       case OPA_MTU_10240: return 10240;
> -       default:            return -1;
> -       }
> -}
> -
>  /**
>   * This function is what we would push to the core layer if we wanted to be a
>   * "first class citizen".  Instead we hide this here and rely on Verbs ULPs
> @@ -202,15 +193,10 @@ static inline int opa_mtu_enum_to_int(int mtu)
>   */
>  static inline int verbs_mtu_enum_to_int(struct ib_device *dev, enum ib_mtu mtu)
>  {
> -       int val;
> -
>         /* Constraining 10KB packets to 8KB packets */
>         if (mtu == (enum ib_mtu)OPA_MTU_10240)
>                 mtu = OPA_MTU_8192;
> -       val = opa_mtu_enum_to_int((int)mtu);
> -       if (val > 0)
> -               return val;
> -       return ib_mtu_enum_to_int(mtu);
> +       return opa_mtu_enum_to_int((enum opa_mtu)mtu);
>  }
>
>  int hfi1_check_modify_qp(struct rvt_qp *qp, struct ib_qp_attr *attr,
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index 8061e93..04f0206 100644
> --- a/drivers/infiniband/hw/hfi1/verbs.c
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -1437,6 +1437,8 @@ static int query_port(struct rvt_dev_info *rdi, u8 port_num,
>                                       4096 : hfi1_max_mtu), IB_MTU_4096);
>         props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
>                 mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
> +       props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
> +                               ib_mtu_enum_to_int(props->max_mtu);
>
>         return 0;
>  }
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index e5f438a..5c1cf68 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1862,7 +1862,10 @@ static int ipoib_parent_init(struct net_device *ndev)
>                         priv->port);
>                 return result;
>         }
> -       priv->max_ib_mtu = ib_mtu_enum_to_int(attr.max_mtu);
> +       if (rdma_core_cap_opa_port(priv->ca, priv->port))

Why not to use something like you did in rdma_mtu_enum_to_int, in
order to hide all the "_opa_" stuff from IPoIB ?

> +               priv->max_ib_mtu = attr.phys_mtu;
> +       else
> +               priv->max_ib_mtu = ib_mtu_enum_to_int(attr.max_mtu);
>
>         result = ib_query_pkey(priv->ca, priv->port, 0, &priv->pkey);
>         if (result) {
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> index b9e9562..7166ee9b 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> @@ -218,6 +218,7 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
>         struct rdma_ah_attr av;
>         int ret;
>         int set_qkey = 0;
> +       int mtu;
>
>         mcast->mcmember = *mcmember;
>
> @@ -240,13 +241,11 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
>                 priv->broadcast->mcmember.flow_label = mcmember->flow_label;
>                 priv->broadcast->mcmember.hop_limit = mcmember->hop_limit;
>                 /* assume if the admin and the mcast are the same both can be changed */
> +               mtu = rdma_mtu_enum_to_int(priv->ca,  priv->port,
> +                                          priv->broadcast->mcmember.mtu);
>                 if (priv->mcast_mtu == priv->admin_mtu)
> -                       priv->admin_mtu =
> -                       priv->mcast_mtu =
> -                       IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> -               else
> -                       priv->mcast_mtu =
> -                       IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> +                       priv->admin_mtu = IPOIB_UD_MTU(mtu);
> +               priv->mcast_mtu = IPOIB_UD_MTU(mtu);
>
>                 priv->qkey = be32_to_cpu(priv->broadcast->mcmember.qkey);
>                 spin_unlock_irq(&priv->lock);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 8b805ab3..6ab343f 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -462,6 +462,11 @@ enum ib_mtu {
>         IB_MTU_4096 = 5
>  };
>
> +enum opa_mtu {
> +       OPA_MTU_8192 = 6,
> +       OPA_MTU_10240 = 7
> +};
> +
>  static inline int ib_mtu_enum_to_int(enum ib_mtu mtu)
>  {
>         switch (mtu) {
> @@ -488,6 +493,28 @@ static inline enum ib_mtu ib_mtu_int_to_enum(int mtu)
>                 return IB_MTU_256;
>  }
>
> +static inline int opa_mtu_enum_to_int(enum opa_mtu mtu)
> +{
> +       switch (mtu) {
> +       case OPA_MTU_8192:
> +               return 8192;
> +       case OPA_MTU_10240:
> +               return 10240;
> +       default:
> +               return(ib_mtu_enum_to_int((enum ib_mtu)mtu));
> +       }
> +}
> +
> +static inline enum opa_mtu opa_mtu_int_to_enum(int mtu)
> +{
> +       if (mtu >= 10240)
> +               return OPA_MTU_10240;
> +       else if (mtu >= 8192)
> +               return OPA_MTU_8192;
> +       else
> +               return ((enum opa_mtu)ib_mtu_int_to_enum(mtu));
> +}
> +
>  enum ib_port_state {
>         IB_PORT_NOP             = 0,
>         IB_PORT_DOWN            = 1,
> @@ -651,6 +678,7 @@ struct ib_port_attr {
>         enum ib_port_state      state;
>         enum ib_mtu             max_mtu;
>         enum ib_mtu             active_mtu;
> +       u32                     phys_mtu;
>         int                     gid_tbl_len;
>         unsigned int            ip_gids:1;
>         /* This is the value from PortInfo CapabilityMask, defined by IBA */
> @@ -3356,6 +3384,38 @@ static inline unsigned int rdma_find_pg_bit(unsigned long addr,
>         return __fls(pgsz);
>  }
>
> +/**
> + * rdma_core_cap_opa_port - Return whether the RDMA Port is OPA or not.
> + * @device: Device
> + * @port_num: 1 based Port number
> + *
> + * Return true if port is an Intel OPA port , false if not
> + */
> +static inline bool rdma_core_cap_opa_port(struct ib_device *device,
> +                                         u32 port_num)
> +{
> +       return (device->port_data[port_num].immutable.core_cap_flags &
> +               RDMA_CORE_PORT_INTEL_OPA) == RDMA_CORE_PORT_INTEL_OPA;
> +}
> +
> +/**
> + * rdma_mtu_enum_to_int - Return the mtu of the port as an integer value.
> + * @device: Device
> + * @port_num: Port number
> + * @mtu: enum value of MTU
> + *
> + * Return the MTU size supported by the port as an integer value. Will return
> + * -1 if enum value of mtu is not supported.
> + */
> +static inline int rdma_mtu_enum_to_int(struct ib_device *device, u8 port,
> +                                      int mtu)
> +{
> +       if (rdma_core_cap_opa_port(device, port))
> +               return opa_mtu_enum_to_int((enum opa_mtu)mtu);
> +       else
> +               return ib_mtu_enum_to_int((enum ib_mtu)mtu);
> +}
> +
>  int ib_set_vf_link_state(struct ib_device *device, int vf, u8 port,
>                          int state);
>  int ib_get_vf_config(struct ib_device *device, int vf, u8 port,
> diff --git a/include/rdma/opa_port_info.h b/include/rdma/opa_port_info.h
> index bdbfe25..0d9e6d7 100644
> --- a/include/rdma/opa_port_info.h
> +++ b/include/rdma/opa_port_info.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2014-2017 Intel Corporation.  All rights reserved.
> + * Copyright (c) 2014-2020 Intel Corporation.  All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
>   * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -139,14 +139,6 @@
>  #define OPA_CAP_MASK3_IsVLMarkerSupported         (1 << 1)
>  #define OPA_CAP_MASK3_IsVLrSupported              (1 << 0)
>
> -/**
> - * new MTU values
> - */
> -enum {
> -       OPA_MTU_8192  = 6,
> -       OPA_MTU_10240 = 7,
> -};
> -
>  enum {
>         OPA_PORT_PHYS_CONF_DISCONNECTED = 0,
>         OPA_PORT_PHYS_CONF_STANDARD     = 1,
>
