Return-Path: <linux-rdma+bounces-3717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF292A0BA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E28280AAE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3878C70;
	Mon,  8 Jul 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cvs+AVcC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDC482DE
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jul 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437130; cv=none; b=q7sLAbQVANmfzvSkRzn/D5Y053Mh7jBYQ59vtlQDNGFM9sRh/o824Oh/V/UeInZYGm2CNhEuRh+8cvkYxikKPW8z2igWY4fIdFH17gqzM1L4pmFwbY6EoAn8Kw+qoE9VAOMt9cCGLzJ5Zuxh82QU85gQkYR3LSenX8NaesA9ShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437130; c=relaxed/simple;
	bh=qWnjy7Y5pHAW7UV2TE7pDAG6zxOsaMqL85xaLWWOj7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmzXdSlrB38Mzr9IRO8eHip66M3IfffHRApJ92PfYSTIyC6dN332oRIHX9KM5RIxk9jkO6RQ6GrT0Sv1dWNk8nFDbjOSRc+/2yRI+/BFK4t9KSZiktIM/oOqj/ocT9PBB6nR0Ekv87ZeyMLCxc2HAx432sdh5monuap05na21fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cvs+AVcC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720437126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwRxo3am+BH28tltDF3Sm1iQk0SpyWcyddEqFxpN47k=;
	b=Cvs+AVcCEuyCim4s9gvNVgyWZATa8jm/PzEhXryXEsZKvR5cTKd8HqivKDejxVAgaIzs86
	acN+8afCOX4T8loagmssCN3NdfbPKNcTSu3ua+rK1OIZmmO/t7zSU1zbLSkW7m7RjILeyR
	f16aF/5xBEjFxLU7Xq4mcnfJhG+3yaM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-ONM5FSogOs2V0ocSKFDKDA-1; Mon, 08 Jul 2024 07:11:58 -0400
X-MC-Unique: ONM5FSogOs2V0ocSKFDKDA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ea96517a6so2605901e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2024 04:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437116; x=1721041916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwRxo3am+BH28tltDF3Sm1iQk0SpyWcyddEqFxpN47k=;
        b=WIW6G9lBmr/T6neRIUaiWCCPXGCmzW1uCtHtBUeCcq84D7jPejXIU+y5tWLrnHIs1O
         FeRE32tiVnxQEFAKqfkCQfaIqbaXvEqc24c75iopVB3HqI0BjsERKeA1DJ17aBjUQRB2
         dBUzHHIkXaNywuY4tCE1zIFdxVj8syrT+zZmLEjiQ6paThaWFdpNzlCbekeVMG5HfDu3
         Uq0HRfJQu4SRFdHnea7ZAoEnd/GcQUU5eUFVjv2ja9EU1cI4JcQ2tDTapwqhNPbNv3mc
         oS3fNo7ZrZD5FqFcVaZ6u8mdXHWm+51ewET/Uqv2PF5qjNrjajvEzJYrb0qXxtO/NK21
         m0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVhVTfeQjnVvTUh/sU+hzbZaVjqUZqNBeEz8nE65wywhCozIva7Fg6ycZtYDctg8Mi0VPAQX68HwVTYn+UgwKC+3O0OVwP1K0ghw==
X-Gm-Message-State: AOJu0Yw8VepfA3EaqqtNR4g+fQh2M/DbBJv4SJaTvw63GGfq+w2fLmc5
	wrM0t7H9Qv1Nw6c4RzQfGLsMfV7ks3t2QJDmFOvrViphAjzAKpCvpy3lr/3DmLDEwK5/tiSZKIm
	ujPjSeE7b9pjjYbP+0RnVZATYz6HkoQR707+JcMWqIBAHY7eUTEeEadvtCfg=
X-Received: by 2002:a19:ee12:0:b0:52e:74d5:4bf9 with SMTP id 2adb3069b0e04-52ea06b2c85mr7572719e87.54.1720437116326;
        Mon, 08 Jul 2024 04:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeEKuXNCSRpv6QLGrM808zaQwAlNiRzR9v23kEbEO2+nfzlRZd7OeERy4dYwGIpxAQPDLwsg==
X-Received: by 2002:a19:ee12:0:b0:52e:74d5:4bf9 with SMTP id 2adb3069b0e04-52ea06b2c85mr7572697e87.54.1720437115663;
        Mon, 08 Jul 2024 04:11:55 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc8bcsm161168965e9.44.2024.07.08.04.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:11:55 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:11:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Tariq Toukan <tariqt@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Message-ID: <20240708071005-mutt-send-email-mst@kernel.org>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
 <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
 <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
 <c6dc541919a0cc78521364dbf4db32293cf1071e.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6dc541919a0cc78521364dbf4db32293cf1071e.camel@nvidia.com>

On Mon, Jul 08, 2024 at 11:01:39AM +0000, Dragos Tatulea wrote:
> On Wed, 2024-07-03 at 18:01 +0200, Eugenio Perez Martin wrote:
> > On Wed, Jun 26, 2024 at 11:27 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > 
> > > On Wed, 2024-06-19 at 17:54 +0200, Eugenio Perez Martin wrote:
> > > > On Mon, Jun 17, 2024 at 5:09 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > > > 
> > > > > Currently, hardware VQs are created right when the vdpa device gets into
> > > > > DRIVER_OK state. That is easier because most of the VQ state is known by
> > > > > then.
> > > > > 
> > > > > This patch switches to creating all VQs and their associated resources
> > > > > at device creation time. The motivation is to reduce the vdpa device
> > > > > live migration downtime by moving the expensive operation of creating
> > > > > all the hardware VQs and their associated resources out of downtime on
> > > > > the destination VM.
> > > > > 
> > > > > The VQs are now created in a blank state. The VQ configuration will
> > > > > happen later, on DRIVER_OK. Then the configuration will be applied when
> > > > > the VQs are moved to the Ready state.
> > > > > 
> > > > > When .set_vq_ready() is called on a VQ before DRIVER_OK, special care is
> > > > > needed: now that the VQ is already created a resume_vq() will be
> > > > > triggered too early when no mr has been configured yet. Skip calling
> > > > > resume_vq() in this case, let it be handled during DRIVER_OK.
> > > > > 
> > > > > For virtio-vdpa, the device configuration is done earlier during
> > > > > .vdpa_dev_add() by vdpa_register_device(). Avoid calling
> > > > > setup_vq_resources() a second time in that case.
> > > > > 
> > > > 
> > > > I guess this happens if virtio_vdpa is already loaded, but I cannot
> > > > see how this is different here. Apart from the IOTLB, what else does
> > > > it change from the mlx5_vdpa POV?
> > > > 
> > > I don't understand your question, could you rephrase or provide more context
> > > please?
> > > 
> > 
> > My main point is that the vdpa parent driver should not be able to
> > tell the difference between vhost_vdpa and virtio_vdpa. The only
> > difference I can think of is because of the vhost IOTLB handling.
> > 
> > Do you also observe this behavior if you add the device with "vdpa
> > add" without the virtio_vdpa module loaded, and then modprobe
> > virtio_vdpa?
> > 
> Aah, now I understand what you mean. Indeed in my tests I was loading the
> virtio_vdpa module before adding the device. When doing it the other way around
> the device doesn't get configured during probe.
>  
> 
> > At least the comment should be something in the line of "If we have
> > all the information to initialize the device, pre-warm it here" or
> > similar.
> Makes sense. I will send a v3 with the commit + comment message update.


Is commit update the only change then?

> > 
> > > Thanks,
> > > Dragos
> > > 
> > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 ++++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 249b5afbe34a..b2836fd3d1dd 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > >         mvq = &ndev->vqs[idx];
> > > > >         if (!ready) {
> > > > >                 suspend_vq(ndev, mvq);
> > > > > -       } else {
> > > > > +       } else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> > > > >                 if (resume_vq(ndev, mvq))
> > > > >                         ready = false;
> > > > >         }
> > > > > @@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> > > > >                                 goto err_setup;
> > > > >                         }
> > > > >                         register_link_notifier(ndev);
> > > > > -                       err = setup_vq_resources(ndev, true);
> > > > > -                       if (err) {
> > > > > -                               mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> > > > > -                               goto err_driver;
> > > > > +                       if (ndev->setup) {
> > > > > +                               err = resume_vqs(ndev);
> > > > > +                               if (err) {
> > > > > +                                       mlx5_vdpa_warn(mvdev, "failed to resume VQs\n");
> > > > > +                                       goto err_driver;
> > > > > +                               }
> > > > > +                       } else {
> > > > > +                               err = setup_vq_resources(ndev, true);
> > > > > +                               if (err) {
> > > > > +                                       mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> > > > > +                                       goto err_driver;
> > > > > +                               }
> > > > >                         }
> > > > >                 } else {
> > > > >                         mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> > > > > @@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
> > > > >                 if (mlx5_vdpa_create_dma_mr(mvdev))
> > > > >                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
> > > > >         }
> > > > > +       setup_vq_resources(ndev, false);
> > > > >         up_write(&ndev->reslock);
> > > > > 
> > > > >         return 0;
> > > > > @@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > > > >                 goto err_reg;
> > > > > 
> > > > >         mgtdev->ndev = ndev;
> > > > > +
> > > > > +       /* For virtio-vdpa, the device was set up during device register. */
> > > > > +       if (ndev->setup)
> > > > > +               return 0;
> > > > > +
> > > > > +       down_write(&ndev->reslock);
> > > > > +       err = setup_vq_resources(ndev, false);
> > > > > +       up_write(&ndev->reslock);
> > > > > +       if (err)
> > > > > +               goto err_setup_vq_res;
> > > > > +
> > > > >         return 0;
> > > > > 
> > > > > +err_setup_vq_res:
> > > > > +       _vdpa_unregister_device(&mvdev->vdev);
> > > > >  err_reg:
> > > > >         destroy_workqueue(mvdev->wq);
> > > > >  err_res2:
> > > > > @@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> > > > > 
> > > > >         unregister_link_notifier(ndev);
> > > > >         _vdpa_unregister_device(dev);
> > > > > +
> > > > > +       down_write(&ndev->reslock);
> > > > > +       teardown_vq_resources(ndev);
> > > > > +       up_write(&ndev->reslock);
> > > > > +
> > > > >         wq = mvdev->wq;
> > > > >         mvdev->wq = NULL;
> > > > >         destroy_workqueue(wq);
> > > > > 
> > > > > --
> > > > > 2.45.1
> > > > > 
> > > > 
> > > 
> > 
> 


