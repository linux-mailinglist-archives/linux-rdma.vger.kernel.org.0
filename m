Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233BB7B6609
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjJCKFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbjJCKE5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 06:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE81A3
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696327447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfgzT7dblsbnLe9E8D8npioQvHy4Ol8QEwV/2aJSdcY=;
        b=HeKi6SH5YwjF488U5BMSkigDHAO8GlvV04ZMWsUEbKgg+HRKcS05ZcbnMd1C3Nx4B5tJpb
        ANLJMM40w8uPifH+gP83ALewB+NgAikWuMMI2ehsdxuhYqv/8/RnUQPvreEavhgKjrfSAW
        EPGiDopCRpMlnZbWAut7yBOjGgcz6GI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ORB34fG2PN2PSS_Jm9IAdA-1; Tue, 03 Oct 2023 06:04:06 -0400
X-MC-Unique: ORB34fG2PN2PSS_Jm9IAdA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5386aefc01eso125646a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Oct 2023 03:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696327445; x=1696932245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfgzT7dblsbnLe9E8D8npioQvHy4Ol8QEwV/2aJSdcY=;
        b=HchKePqNw5yi/xIDO8o8dufJU6qwz+OD5KSZ/pa9WgcibWbKrvjRKd9UG9hofATeWO
         QftKu/7r3ScEywZaIQ9eN0+sY0azk8abti+5cJZdge36TfckKc4UIpOZUaB3gbgfCCP/
         6ckIEPKkSh6cN7G/NK5FfvRSgjPkb6EXWh5MVLK74u3LiZRmdjWyNHNO5nrFfXyQ23KR
         8bP7SHcotIsJOTzaVInSVa20jlCNQraQx5GKzgO5H7DZf7gHJku18n1SAiwrHfn1azP3
         gsh6r03dMpU4l9P0yQ8H3NfBl+Ri59q9HMZkaL+4UnLSpXbEFCJa+9ukaf+sEMM4t3tK
         TkCA==
X-Gm-Message-State: AOJu0Yz6EUqY0NsSG9w8eqfUtMPfVs/Wf8JWGVdy0Z/Vd/fCpfFtltiN
        RnqOsgMlBopuyXZsy048q5T6riXG2vd4WcRu2D/OYreyGNHHWOnxOZF5O3GRUCeHvqsduQ+kNxI
        eCRWVKtgVJhyVy6aBJmOCtw==
X-Received: by 2002:a05:6402:42c7:b0:51e:5dd8:fc59 with SMTP id i7-20020a05640242c700b0051e5dd8fc59mr14600409edc.1.1696327445031;
        Tue, 03 Oct 2023 03:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKo/lsiY8VL6sFsslqGDy+eu1dcCABvmDtzR1hIGuq84a0yGZ62b+pvxxgewsKJG/LfHcPZw==
X-Received: by 2002:a05:6402:42c7:b0:51e:5dd8:fc59 with SMTP id i7-20020a05640242c700b0051e5dd8fc59mr14600381edc.1.1696327444638;
        Tue, 03 Oct 2023 03:04:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id m3-20020aa7d343000000b00530ccd180a3sm600522edr.97.2023.10.03.03.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:04:03 -0700 (PDT)
Message-ID: <2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Yury Norov <ynorov@nvidia.com>
Date:   Tue, 03 Oct 2023 12:04:01 +0200
In-Reply-To: <20230925020528.777578-2-yury.norov@gmail.com>
References: <20230925020528.777578-1-yury.norov@gmail.com>
         <20230925020528.777578-2-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 2023-09-24 at 19:05 -0700, Yury Norov wrote:
> The function duplicates existing cpumask_local_spread(), and it's O(N),
> while cpumask_local_spread() implementation is based on bsearch, and
> thus is O(log n), so drop mlx5_cpumask_default_spread() and use generic
> cpumask_local_spread().
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 28 ++------------------
>  1 file changed, 2 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/e=
thernet/mellanox/mlx5/core/eq.c
> index ea0405e0a43f..bd9f857cc52d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -828,30 +828,6 @@ static void comp_irq_release_pci(struct mlx5_core_de=
v *dev, u16 vecidx)
>  	mlx5_irq_release_vector(irq);
>  }
> =20
> -static int mlx5_cpumask_default_spread(int numa_node, int index)
> -{
> -	const struct cpumask *prev =3D cpu_none_mask;
> -	const struct cpumask *mask;
> -	int found_cpu =3D 0;
> -	int i =3D 0;
> -	int cpu;
> -
> -	rcu_read_lock();
> -	for_each_numa_hop_mask(mask, numa_node) {
> -		for_each_cpu_andnot(cpu, mask, prev) {
> -			if (i++ =3D=3D index) {
> -				found_cpu =3D cpu;
> -				goto spread_done;
> -			}
> -		}
> -		prev =3D mask;
> -	}
> -
> -spread_done:
> -	rcu_read_unlock();
> -	return found_cpu;
> -}
> -
>  static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev =
*dev)
>  {
>  #ifdef CONFIG_RFS_ACCEL
> @@ -873,7 +849,7 @@ static int comp_irq_request_pci(struct mlx5_core_dev =
*dev, u16 vecidx)
>  	int cpu;
> =20
>  	rmap =3D mlx5_eq_table_get_pci_rmap(dev);
> -	cpu =3D mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
> +	cpu =3D cpumask_local_spread(vecidx, dev->priv.numa_node);
>  	irq =3D mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
>  	if (IS_ERR(irq))
>  		return PTR_ERR(irq);
> @@ -1125,7 +1101,7 @@ int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *=
dev, int vector)
>  	if (mask)
>  		cpu =3D cpumask_first(mask);
>  	else
> -		cpu =3D mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
> +		cpu =3D cpumask_local_spread(vector, dev->priv.numa_node);
> =20
>  	return cpu;
>  }

It looks like this series is going to cause some later conflicts
regardless of the target tree. I think the whole series could go via
the net-next tree, am I missing any relevant point?

Thanks!

Paolo

