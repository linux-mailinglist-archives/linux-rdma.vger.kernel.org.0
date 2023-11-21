Return-Path: <linux-rdma+bounces-10-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11067F2DDC
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD1D2829B2
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFA482D8;
	Tue, 21 Nov 2023 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hHfJuFgz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE01A2
	for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:02:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-543923af573so8053904a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700571764; x=1701176564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFt6n5rHbI0HwULfr/KukpjbYH4NiemjaACC6ffhpus=;
        b=hHfJuFgz2J3zyPdVJThzkpVtJ0MM+EuFBoFcTqwTorA52EG6lesfFSBVwcQPOWUoLT
         c0rmNFM7kwYb3QKh56EiDRPYnCJQAR16QQi5P8qYN8hbVMJjBflO+E0K9GT4EaNkZ22i
         ORz6EnEtGx5Qir9NyRDgHeo15OPzt4v/bSHHAcMaGiwU09CoFFbJB/jRPXarhMJj2sMJ
         nVGyA3H7Nn5eAAsOimOowpiO/ezK8HZzDnjpFmkRhEJaAdZ5n7pTH9x5UGYUGpnJ9dEt
         3oGGJVqwsPdvYnBFmBdnA2nQsNp+/ISpmGJMUFaUIq0Lp28CIiC/8vVlUs0METC1RwzG
         NIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571764; x=1701176564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFt6n5rHbI0HwULfr/KukpjbYH4NiemjaACC6ffhpus=;
        b=lLmNJgfkiQhUaEDUKMNvJtv74MC/6LLOo+a2bJG5cAwjx3DiadzhsNh8yOFmWuWqHX
         el0bWCayPuO5aYpaxsGpCujvUL/NLePgAdj4wdPdTxH1TRtY024hSy+TMnwqaSGGp0d3
         kP0iWVfdOotJgG6rzkGF8k2QPA7kAebbQw9Iak+rOCqa8ZCbZYXbrb/mu/wxMpbPVi8k
         WCRlx1P3UJ/Jn3N/OcqcKQPschfoSFYTCJKxhguxOCmOMcPegARqdiOKh2d4MMzTITIA
         10Ocmw0FI+xn6ffSnjs6Qe9PlssNxI58dHYt4uDIgjhTgRJ+h8IpoMclu+/vF10OfGCz
         rVCg==
X-Gm-Message-State: AOJu0Yz7QroeX2yoGXtchaF52UlkvwvXZCv+cKdk9IOT8rEFDHcGNNYj
	egkmG8hhfQuHXXq27GrgCGGW5xCw5eryOfPjnoF+HsevTNF7xEHU
X-Google-Smtp-Source: AGHT+IGWGL0ZoI3Y+EkYJuJkGe/XxfyZtINkiB3Q4u85Bfvlhn4jfqmJoJjqU5tpja2B4eDAnbNjnLwl8MUCkZi7uD4=
X-Received: by 2002:a05:6402:518a:b0:544:1fb7:d5e8 with SMTP id
 q10-20020a056402518a00b005441fb7d5e8mr2352828edd.0.1700571764003; Tue, 21 Nov
 2023 05:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120203501.321587-1-jinpu.wang@ionos.com> <20231121001640.GG10140@ziepe.ca>
In-Reply-To: <20231121001640.GG10140@ziepe.ca>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 21 Nov 2023 14:02:32 +0100
Message-ID: <CAMGffE=joZidAC1+VbymTqLuBs=PzCCXv9w14yaAxzzcLZJPFQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] bugfix for ipoib
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason.

On Tue, Nov 21, 2023 at 1:16=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Nov 20, 2023 at 09:34:59PM +0100, Jack Wang wrote:
> > We run into queue timeout often with call trace as such:
> > NETDEV WATCHDOG: ib0.beef (): transmit queue 26 timed out
> > Call Trace:
> > call_timer_fn+0x27/0x100
> > __run_timers.part.0+0x1be/0x230
> > ? mlx5_cq_tasklet_cb+0x6d/0x140 [mlx5_core]
> > run_timer_softirq+0x26/0x50
> > __do_softirq+0xbc/0x26d
> > asm_call_irq_on_stack+0xf/0x20
> > ib0.beef: transmit timeout: latency 10 msecs
> > ib0.beef: queue stopped 0, tx_head 0, tx_tail 0, global_tx_head 0, glob=
al_tx_tail 0
> >
> > The last two message repeated for days.
>
> You shouldn't get tx timeouts and fully stuck queues like that, it
> suggests something else is very wrong in that system.
We hit such warnings from time to time over years in different
locations, but can't reproduce at will in staging environment.

There are problems around.
>
> > After cross check with Mellanox OFED, I noticed some bugfix are missing=
 in
> > upstream, hence I take the liberty to send them out.
>
> Recovery is recovery, it is just RAS

I managed to trigger the situation by an extra debug interface

 static DEVICE_ATTR_RW(umcast);

+static ssize_t timeout_store(struct device *dev, struct device_attribute *=
attr,
+                            const char *buf, size_t count)
+{
+       unsigned long val =3D simple_strtoul(buf, NULL, 0);
+
+       netif_stop_queue(to_net_dev(dev));
+       ipoib_timeout(to_net_dev(dev), val);
+
+       return count;
+}
+
 int ipoib_add_umcast_attr(struct net_device *dev)
 {
        return device_create_file(&dev->dev, &dev_attr_umcast);
 }

+static DEVICE_ATTR_WO(timeout);
+
+int ipoib_add_timeout_attr(struct net_device *dev)
+{
+       return device_create_file(&dev->dev, &dev_attr_timeout);
+}
+
 static void set_base_guid(struct ipoib_dev_priv *priv, union ib_gid *gid)
 {
        struct ipoib_dev_priv *child_priv;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 0322dc75396f..9b5dd628da2e 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -148,6 +148,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv,
struct ipoib_dev_priv *priv,
                        goto sysfs_failed;
                if (ipoib_add_umcast_attr(ndev))
                        goto sysfs_failed;
+               if (ipoib_add_timeout_attr(ndev))
+                       goto sysfs_failed;

                if (device_create_file(&ndev->dev, &dev_attr_parent))
                        goto sysfs_failed;



running iperf3 on child interface, and trigger the timeout via sysfs,
I'm able to trigger the WATCHDOG and timeout without the recover
patch, but can't trigger it with the fix.

I will send v2 version for the napi api change reported by bot.
>
> Jason

