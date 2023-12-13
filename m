Return-Path: <linux-rdma+bounces-326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3937E809C28
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 07:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A33F1C20BF9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19477479;
	Fri,  8 Dec 2023 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HYgJWurX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6DD71720;
	Thu,  7 Dec 2023 22:05:39 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 3433420B74C0; Thu,  7 Dec 2023 22:05:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3433420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702015539;
	bh=7Lj8rKh+wOzCHoSYdcOz0CkBbfIdTFOALmKdop036KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYgJWurXoYetYgiR4cHME4T8Yw5jxBAx5MDtwqSfCX3yOb80pgFvfOp1oJT4bMLI/
	 ac4QMRxYRmXVyb0oakaMce/Dt7pS+X9GRs87pvR6PMQGCGY4RA0ipoVhQ2YM9hjrI6
	 VkiZ3/8AgR2ZBppPiYZsCrWjdGo6XuCh6jWPXm3E=
Date: Thu, 7 Dec 2023 22:05:39 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	sch^Crabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH V4 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <20231208060539.GA5744@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1701679841-9359-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZW3om2dfA4U0lhVY@yury-ThinkPad>
 <20231205110138.GA31232@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZW+plvYrNvdcSFCB@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW+plvYrNvdcSFCB@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Dec 05, 2023 at 02:52:06PM -0800, Yury Norov wrote:
> On Tue, Dec 05, 2023 at 03:01:38AM -0800, Souradeep Chakrabarti wrote:
> > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > index 6367de0c2c2e..2194a53cce10 100644
> > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > @@ -1243,15 +1243,57 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> > > >  	r->size = 0;
> > > >  }
> > > >  
> > > > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > > > +{
> > > > +	int i = 0, cpu, err = 0;
> > > > +	const struct cpumask *node_cpumask;
> > > > +	unsigned int  next_node = start_numa_node;
> > > > +	cpumask_var_t visited_cpus, node_cpumask_temp;
> > > > +
> > > > +	if (!zalloc_cpumask_var(&visited_cpus, GFP_KERNEL)) {
> > > > +		err = ENOMEM;
> > > > +		return err;
> > > > +	}
> > > > +	if (!zalloc_cpumask_var(&node_cpumask_temp, GFP_KERNEL)) {
> > > > +		err = -ENOMEM;
> > > > +		return err;
> > > > +	}
> > > 
> > > Can you add a bit more of vertical spacing?
> > > 
> > > > +	rcu_read_lock();
> > > > +	for_each_numa_hop_mask(node_cpumask, next_node) {
> > > > +		cpumask_copy(node_cpumask_temp, node_cpumask);
> > > > +		for_each_cpu(cpu, node_cpumask_temp) {
> > > > +			cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> > > > +				       topology_sibling_cpumask(cpu));
> > > > +			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu));
> > > > +			if (++i == nvec)
> > > > +				goto free_mask;
> > > > +			cpumask_set_cpu(cpu, visited_cpus);
> > > > +			if (cpumask_empty(node_cpumask_temp)) {
> > > > +				cpumask_copy(node_cpumask_temp, node_cpumask);
> > > > +				cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
> > > > +					       visited_cpus);
> > > > +				cpu = 0;
> > > > +			}
> > > 
> > > It feels like you can calculate number of sibling groups in a hop in
> > > advance, so that you'll know how many IRQs you want to assign per each
> > > hop, and avoid resetting the node_cpumask_temp and spinning in inner
> > > loop for more than once...
> > > 
> > > Can you print your topology, and describe how you want to spread IRQs
> > > on it, and how your existing code does spread them?
> > >
> > The topology of one system is
> > > numactl -H
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> > 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
> > 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> > node 0 size: 459521 MB
> > node 0 free: 456316 MB
> > node 1 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
> > 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
> > 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168
> > 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
> > node 1 size: 459617 MB
> > node 1 free: 456864 MB
> > node distances:
> > node   0   1
> >   0:  10  21
> >   1:  21  10
> > and I want to spread the IRQs in numa0 node first with 
> > CPU0 - IRQ0
> > CPU2 - IRQ1
> > CPU4 - IRQ2
> > CPU6 - IRQ3
> > ---
> > ---
> > ---
> > CPU94 - IRQ47
> > then
> > CPU1 - IRQ48
> > CPU3 - IRQ49
> > CPU32 - IRQ64
> > 
> > In a topology where NUMA0 has 20 cores and NUMA1 has 20 cores, with total 80 CPUS, there I want
> > CPU0 - IRQ0
> > CPU2 - IRQ1
> > CPU4 - IRQ2
> > ---
> > ---
> > ---
> > CPU38 - IRQ19
> > Then
> > CPU1 - IRQ20
> > CPU3 - IRQ21
> > ---
> > ---
> > CPU39 - IRQ39
> > Node1
> > CPU40 - IRQ40
> > CPU42 - IRQ41
> > CPU44 - IRQ42
> > ---
> > CPU78 - IRQ58
> > CPU41 - IRQ59
> > CPU43 - IRQ60
> > ---
> > ---
> > CPU49 - IRQ64
> >  
> > 
> > Exisitng code : 
> > https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/microsoft/mana/gdma_main.c#L1246
> > 
> > This uses cpumask_local_spread, so in a system where node has 64 cores, it spreads all 64+1 IRQs on
> > 33 cores, rather than spreading it only on HT cores.
> 
> So from what you said, it looks like you're trying to implement the
> following heuristics:
> 
> 1. No more than one IRQ per CPU, if possible;
> 2. NUMA locality is the second priority;
> 3. Sibling dislocality is the last priority;
> 
> Can you confirm that?
> 
> If the above correct, your code is quite close to what you want except
> that for every new hop (outer loop) you have to clear CPUs belonging to
> previous hop, which is in you case the same as visited_cpus mask.
> 
> But I think you can do it even better if just account the number of
> assigned IRQs. That way you can get rid of the most of housekeeping
> code.
> 
> const struct cpumask *next, *prev = cpu_none_mask;
> 
> for_each_numa_hop_mask(next, node) {
>         cpumask_and_not(curr, next, prev);
> 
>         for (w = cpumask_weight(curr), cnt = 0; cnt < w; cnt++)
>                 cpumask_copy(cpus, curr);
>                 for_each_cpu(cpu, cpus) {
>                         if (i++ == nvec)
>                                 goto done;
> 
>                         cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
>                         irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu)); // [*]
>                 }
>         }
>         prev = next;
> }
I am experimenting with the proposal here, and based on the result will
update the V5 patch.
> 
> [*] I already mentioned that in v3, and also asking here: if you're saying
> that wrt IRQs distribution, all CPUs belonging to the same sibling group
> are the same, why don't you assign all the group to the IRQ. It gives the
> system flexibility to balance workload better.
> 
> Let's consider this topology:
> 
> Node            0               1
> Core        0       1       2       3
> CPU       0   1   2   3   4   5   6   7
> 
> The code above should create the following mapping for the IRQs:
> IRQ     Nodes   Cores   CPUs
> 0       1       0       0-1
> 1       1       1       2-3
> 2       1       0       0-1
> 3       1       1       2-3
> 4       2       2       4-5
> 5       2       3       6-7
> 6       2       2       4-5
> 7       2       3       6-7
> 
> This is pretty close to what I proposed in v3, except that it flips
> priorities of NUMA locality vs sibling dislocality. My original
> suggestion is simpler in implementation and aligns with my natural
> feeling of 'fair' IRQ distribution.
> 
> Can you make sure that your heuristics are the best wrt performance?
> 
> Regarding the rest of the discussion, I think that for_each_numa_hop_mask() 
> together with some basic cpumaks operations results quite a readable
> and maintainable code, and we don't need any more generic API to
> support this type of distribution tasks.
> 
> What do you think guys?
> 
> Thanks,
> Yury

