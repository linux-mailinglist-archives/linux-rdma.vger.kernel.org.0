Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE4A7B6ADE
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbjJCNsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 09:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjJCNsg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 09:48:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE989CE;
        Tue,  3 Oct 2023 06:48:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3bd829b86so7269635ad.0;
        Tue, 03 Oct 2023 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696340912; x=1696945712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXx12Xh5OdYtcd2fycn71joB20ZrxlQW7gPZtnETXlo=;
        b=mKLq2HCLhhDbAHq8pgijmTb4r8AecHT82AFn8KNdFz1t0P78zthCotoMDghTSVLqmz
         uSBOGDYpxCKtr+AQ5XoqFFYZWpAsa3NtH30Z8WJtAEe/lnStogNVYyZTdClwf1iwkebA
         /Dsv/vkBHiA3J/A5J/SjJcBaGV8SFtlyYz5gjv9rRSNUUkx3BMxBK8I2rVmHQAg25NLw
         g5Hsfn2oD2nmlhSonFvRZKZcueAL3RZFoC8/KzjTNGvLoUwSNG/sh3+22+en/nCvrpEF
         9i04W0Nmp7W1nnraYkd/WZmr6PRBiPIauDzSq+MiVHixrmkbzdT28jL5Z61h3j7otMZK
         neYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340912; x=1696945712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXx12Xh5OdYtcd2fycn71joB20ZrxlQW7gPZtnETXlo=;
        b=Q5DF+QGbcFeBQMDDFyRJ+P1gP4KqjFgoh3dKJHtKpHcj40pt9W/hCKtZN+wEgHRFpo
         KiDYEc1uKRyH4iFaEludd/9d6UmSFzhQ5AkFeg7TLtEE4Sbrxm42N3XmS8u+l2qPyzOU
         JRLTVI5c0SLYTYyf/yEXVbyF/uhueDI4E2t4drCOmrsV+6smuF+OCnViU1N7ZcsrSTev
         pRGAG7pVK6Vi+Dw5j9kL82l6cbkCM2AoJLllepJh9D/RXWf/Pz8UcKzq/P02bzT+95Vl
         EyINWXok5GL6IDW0Sk2zL8fRDp4MtOsgWzeMxG18YmwYtu0iZyndS/X47wQgMYx86mSl
         on0Q==
X-Gm-Message-State: AOJu0YyZN2wtLTuBOBSw7Q1lsgfB/Wp2j+Qxx5QaBF3mmDT1O0Fz+p/y
        1G5gu1T+uWTMSlnZDISdWXA=
X-Google-Smtp-Source: AGHT+IGtPt1XVtqOzSLe+Y3WiKfioYBDClQ2Vrf/pQc1OE1nxhWQT7+sKkPapeNUz5KRMqBCjwFElA==
X-Received: by 2002:a17:903:22c7:b0:1bf:3c10:1d70 with SMTP id y7-20020a17090322c700b001bf3c101d70mr14808390plg.6.1696340912142;
        Tue, 03 Oct 2023 06:48:32 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c627413e87sm1543164plz.290.2023.10.03.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:48:31 -0700 (PDT)
Date:   Tue, 3 Oct 2023 06:46:17 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, Tariq Toukan <ttoukan.linux@gmail.com>,
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
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
Message-ID: <ZRwbKRnnKY/tDqCF@yury-ThinkPad>
References: <20230925020528.777578-1-yury.norov@gmail.com>
 <20230925020528.777578-2-yury.norov@gmail.com>
 <2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 03, 2023 at 12:04:01PM +0200, Paolo Abeni wrote:
> On Sun, 2023-09-24 at 19:05 -0700, Yury Norov wrote:
> > The function duplicates existing cpumask_local_spread(), and it's O(N),
> > while cpumask_local_spread() implementation is based on bsearch, and
> > thus is O(log n), so drop mlx5_cpumask_default_spread() and use generic
> > cpumask_local_spread().
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 28 ++------------------
> >  1 file changed, 2 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > index ea0405e0a43f..bd9f857cc52d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > @@ -828,30 +828,6 @@ static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
> >  	mlx5_irq_release_vector(irq);
> >  }
> >  
> > -static int mlx5_cpumask_default_spread(int numa_node, int index)
> > -{
> > -	const struct cpumask *prev = cpu_none_mask;
> > -	const struct cpumask *mask;
> > -	int found_cpu = 0;
> > -	int i = 0;
> > -	int cpu;
> > -
> > -	rcu_read_lock();
> > -	for_each_numa_hop_mask(mask, numa_node) {
> > -		for_each_cpu_andnot(cpu, mask, prev) {
> > -			if (i++ == index) {
> > -				found_cpu = cpu;
> > -				goto spread_done;
> > -			}
> > -		}
> > -		prev = mask;
> > -	}
> > -
> > -spread_done:
> > -	rcu_read_unlock();
> > -	return found_cpu;
> > -}
> > -
> >  static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev *dev)
> >  {
> >  #ifdef CONFIG_RFS_ACCEL
> > @@ -873,7 +849,7 @@ static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
> >  	int cpu;
> >  
> >  	rmap = mlx5_eq_table_get_pci_rmap(dev);
> > -	cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
> > +	cpu = cpumask_local_spread(vecidx, dev->priv.numa_node);
> >  	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
> >  	if (IS_ERR(irq))
> >  		return PTR_ERR(irq);
> > @@ -1125,7 +1101,7 @@ int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector)
> >  	if (mask)
> >  		cpu = cpumask_first(mask);
> >  	else
> > -		cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
> > +		cpu = cpumask_local_spread(vector, dev->priv.numa_node);
> >  
> >  	return cpu;
> >  }
> 
> It looks like this series is going to cause some later conflicts
> regardless of the target tree. I think the whole series could go via
> the net-next tree, am I missing any relevant point?

Hi Paolo,

Can you elaborate on the conflicts you see? For me it applies cleanly
on current master, and with some 3-way merging on latest -next...

Thanks,
Yury
