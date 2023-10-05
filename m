Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA847BA5AD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbjJEQTF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbjJEQQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 12:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED735C36
        for <linux-rdma@vger.kernel.org>; Thu,  5 Oct 2023 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696517557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/yNHt/CLpU1k87Q82jDDK9Qnc6mSBeqZnRL1JtCpEw=;
        b=Z7vGndEzlHlRKdqzsgmCwStyYeq2HEkHVvZqBwm8038hJmTrmVIGe3/5z4DoaB2hku2eeW
        Jc+g850Rxk1nculotEKm/9ewmUyLR4Gb+cU09NDOWWlMHO5Gqhjsx75+kT/7mPxP6L1uUc
        ScEL2S7AvE9jlUzrQwJ6uRlh613gfK8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-GGogC4AsPD-Ohd1Q7eWpAw-1; Thu, 05 Oct 2023 10:49:04 -0400
X-MC-Unique: GGogC4AsPD-Ohd1Q7eWpAw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-59f4f2a9ef0so15485487b3.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Oct 2023 07:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517343; x=1697122143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/yNHt/CLpU1k87Q82jDDK9Qnc6mSBeqZnRL1JtCpEw=;
        b=nBnAMjGKwT+rAZlnX6nd3H+5H9pe3F5QX0v+bOL/Wbn/EoSraByJ8WNzt/b/3si1b1
         rZoExPtX1f4EvMYX6S2sV93Oa2w7lBsRg9eyjsWtnfn5Pf6aqhr1BVblsbvdwuEAG7S3
         NLWjwRf+UDHihOdsNkSWLQ0H5XAbJbiDLzoqizoZ2WayL0lx1+C6+2kUKJuzyc9KOWb9
         CRGc1sF7i+JjkcqMfSEstFVpijh9krLIWK7BgPXL9KlbHYOubDud00Up1YaikIN3Vszv
         AbAgBieT6vOd5XYI81zwJN9HUZEkgJD7UTsLbhCXEdXe6L/Tn9iFp4aaUzknlAdpsGUU
         +Jzg==
X-Gm-Message-State: AOJu0YwsxvWPStW7inFHH2I2JajS7H4SwGqs+BeNxZz7cziYkzNKM+g3
        P75FAw/aHIdGgCjotirYwlXMFbN+H2RiMJkUAXSRUaeuaEyhU4TFNytNd0qBku0WK3+Km17h2/S
        nHhW0/+DXsefVgFJbchBFUj5Wp6dLKiFwjuwfaA==
X-Received: by 2002:a0d:d4c4:0:b0:59f:4c3a:711d with SMTP id w187-20020a0dd4c4000000b0059f4c3a711dmr5539979ywd.11.1696517343000;
        Thu, 05 Oct 2023 07:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8JZNkhK4RosNSHOVvt6DiJr3wTa8hoYOfAU8v71Y0P2njDI2akXwHoO4KlZ+xhR2ScGqHb3TX4k1sBDGrx0I=
X-Received: by 2002:a0d:d4c4:0:b0:59f:4c3a:711d with SMTP id
 w187-20020a0dd4c4000000b0059f4c3a711dmr5539962ywd.11.1696517342733; Thu, 05
 Oct 2023 07:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-16-dtatulea@nvidia.com>
 <CAJaqyWeRhJNZ8wbpEFARwBBNbE07n4xQdd-RvUoZooCeB4piPA@mail.gmail.com> <9f0ef4ebd801a35873561384b2aedc920faecd03.camel@nvidia.com>
In-Reply-To: <9f0ef4ebd801a35873561384b2aedc920faecd03.camel@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 5 Oct 2023 16:48:26 +0200
Message-ID: <CAJaqyWeOXQiZ885vP_ffSnwhs0rAdORYHyROe-eXjLj2Xred1Q@mail.gmail.com>
Subject: Re: [PATCH vhost 14/16] vdpa/mlx5: Enable hw support for vq
 descriptor mapping
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 5, 2023 at 2:16=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Thu, 2023-10-05 at 11:42 +0200, Eugenio Perez Martin wrote:
> > On Thu, Sep 28, 2023 at 6:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > Vq descriptor mappings are supported in hardware by filling in an
> > > additional mkey which contains the descriptor mappings to the hw vq.
> > >
> > > A previous patch in this series added support for hw mkey (mr) creati=
on
> > > for ASID 1.
> > >
> > > This patch fills in both the vq data and vq descriptor mkeys based on
> > > group ASID mapping.
> > >
> > > The feature is signaled to the vdpa core through the presence of the
> > > .get_vq_desc_group op.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 26 ++++++++++++++++++++++++--
> > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  7 ++++++-
> > >  2 files changed, 30 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 25bd2c324f5b..46441e41892c 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -823,6 +823,7 @@ static int create_virtqueue(struct mlx5_vdpa_net =
*ndev,
> > > struct mlx5_vdpa_virtque
> > >         u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] =3D {};
> > >         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
> > >         struct mlx5_vdpa_mr *vq_mr;
> > > +       struct mlx5_vdpa_mr *vq_desc_mr;
> > >         void *obj_context;
> > >         u16 mlx_features;
> > >         void *cmd_hdr;
> > > @@ -878,6 +879,11 @@ static int create_virtqueue(struct mlx5_vdpa_net=
 *ndev,
> > > struct mlx5_vdpa_virtque
> > >         vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]=
];
> > >         if (vq_mr)
> > >                 MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey=
);
> > > +
> > > +       vq_desc_mr =3D mvdev->mr[mvdev-
> > > >group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
> > > +       if (vq_desc_mr)
> > > +               MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_m=
r-
> > > >mkey);
> > > +
> > >         MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> > >         MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> > >         MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > > @@ -2265,6 +2271,16 @@ static u32 mlx5_vdpa_get_vq_group(struct vdpa_=
device
> > > *vdev, u16 idx)
> > >         return MLX5_VDPA_DATAVQ_GROUP;
> > >  }
> > >
> > > +static u32 mlx5_vdpa_get_vq_desc_group(struct vdpa_device *vdev, u16=
 idx)
> > > +{
> > > +       struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > +
> > > +       if (is_ctrl_vq_idx(mvdev, idx))
> > > +               return MLX5_VDPA_CVQ_GROUP;
> > > +
> > > +       return MLX5_VDPA_DATAVQ_DESC_GROUP;
> > > +}
> > > +
> > >  static u64 mlx_to_vritio_features(u16 dev_features)
> > >  {
> > >         u64 result =3D 0;
> > > @@ -3139,7 +3155,7 @@ static int mlx5_set_group_asid(struct vdpa_devi=
ce
> > > *vdev, u32 group,
> > >  {
> > >         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > >
> > > -       if (group >=3D MLX5_VDPA_NUMVQ_GROUPS)
> > > +       if (group >=3D MLX5_VDPA_NUMVQ_GROUPS || asid >=3D MLX5_VDPA_=
NUM_AS)
> >
> > Nit: the check for asid >=3D MLX5_VDPA_NUM_AS is redundant, as it will
> > be already checked by VHOST_VDPA_SET_GROUP_ASID handler in
> > drivers/vhost/vdpa.c:vhost_vdpa_vring_ioctl. Not a big deal.
> Ack.
>
> >
> > >                 return -EINVAL;
> > >
> > >         mvdev->group2asid[group] =3D asid;
> > > @@ -3160,6 +3176,7 @@ static const struct vdpa_config_ops mlx5_vdpa_o=
ps =3D {
> > >         .get_vq_irq =3D mlx5_get_vq_irq,
> > >         .get_vq_align =3D mlx5_vdpa_get_vq_align,
> > >         .get_vq_group =3D mlx5_vdpa_get_vq_group,
> > > +       .get_vq_desc_group =3D mlx5_vdpa_get_vq_desc_group, /* Op dis=
abled if
> > > not supported. */
> > >         .get_device_features =3D mlx5_vdpa_get_device_features,
> > >         .set_driver_features =3D mlx5_vdpa_set_driver_features,
> > >         .get_driver_features =3D mlx5_vdpa_get_driver_features,
> > > @@ -3258,6 +3275,7 @@ struct mlx5_vdpa_mgmtdev {
> > >         struct vdpa_mgmt_dev mgtdev;
> > >         struct mlx5_adev *madev;
> > >         struct mlx5_vdpa_net *ndev;
> > > +       struct vdpa_config_ops vdpa_ops;
> > >  };
> > >
> > >  static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
> > > @@ -3371,7 +3389,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_d=
ev
> > > *v_mdev, const char *name,
> > >                 max_vqs =3D 2;
> > >         }
> > >
> > > -       ndev =3D vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, =
mdev-
> > > >device, &mlx5_vdpa_ops,
> > > +       ndev =3D vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, =
mdev-
> > > >device, &mgtdev->vdpa_ops,
> > >                                  MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NU=
M_AS,
> > > name, false);
> > >         if (IS_ERR(ndev))
> > >                 return PTR_ERR(ndev);
> > > @@ -3546,6 +3564,10 @@ static int mlx5v_probe(struct auxiliary_device=
 *adev,
> > >                 MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queu=
es) +
> > > 1;
> > >         mgtdev->mgtdev.supported_features =3D get_supported_features(=
mdev);
> > >         mgtdev->madev =3D madev;
> > > +       mgtdev->vdpa_ops =3D mlx5_vdpa_ops;
> > > +
> > > +       if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, desc_group_mkey_suppor=
ted))
> > > +               mgtdev->vdpa_ops.get_vq_desc_group =3D NULL;
> >
> > I think this is better handled by splitting mlx5_vdpa_ops in two: One
> > with get_vq_desc_group and other without it. You can see an example of
> > this in the simulator, where one version supports .dma_map incremental
> > updating with .dma_map and the other supports .set_map. Otherwise,
> > this can get messy if more members opt-out or opt-in.
> >
> I implemented it this way because the upcoming resumable vq support will =
also
> need to selectively implement .resume if the hw capability is there. That=
 would
> result in needing 4 different ops for all combinations. The other option =
would
> be to force these two ops together (.get_vq_desc_group and .resume). But =
I would
> prefer to not do that.
>

That's a good point. As more features are optional per device, maybe
this approach is better.

I'm not sure what Jason prefers, but I think it would be easy to
change it on top.

Thanks!

> > But I'm ok with this too, so whatever version you choose:
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > >
> > >         err =3D vdpa_mgmtdev_register(&mgtdev->mgtdev);
> > >         if (err)
> > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > index 9becdc3fa503..b86d51a855f6 100644
> > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > @@ -74,7 +74,11 @@ struct mlx5_ifc_virtio_q_bits {
> > >         u8    reserved_at_320[0x8];
> > >         u8    pd[0x18];
> > >
> > > -       u8    reserved_at_340[0xc0];
> > > +       u8    reserved_at_340[0x20];
> > > +
> > > +       u8    desc_group_mkey[0x20];
> > > +
> > > +       u8    reserved_at_380[0x80];
> > >  };
> > >
> > >  struct mlx5_ifc_virtio_net_q_object_bits {
> > > @@ -141,6 +145,7 @@ enum {
> > >         MLX5_VIRTQ_MODIFY_MASK_STATE                    =3D (u64)1 <<=
 0,
> > >         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      =3D (u64)1 <<=
 3,
> > >         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE =3D (u64)1 <<=
 4,
> > > +       MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =3D (u64)1 <<=
 14,
> > >  };
> > >
> > >  enum {
> > > --
> > > 2.41.0
> > >
> >
>

