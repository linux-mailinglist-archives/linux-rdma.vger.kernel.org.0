Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664A46EF106
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Apr 2023 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbjDZJXm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Apr 2023 05:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjDZJXj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Apr 2023 05:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4461146BA
        for <linux-rdma@vger.kernel.org>; Wed, 26 Apr 2023 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682500860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hb1p3qZAdlHU1l6iLXytZzmouo7Dtxmm/TUeo1IcTKg=;
        b=eOe4LWKiBowmpWCS0YJKHhMMk94+kr5NdMcrEzLY1MMfJ50ITb2TSuKNzTOQAuEnGwimkE
        Lk+QYwsAfLiuuVBzDA8U4e+fyxeWZp3j1YWkvmh07dKNOkdjPp22oZmavvJfdYy8FIhuTK
        cIvr1Z3gIw7RJZuSKpmon9JGHN8tn3M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-qev4stNbNn-i1c7KcjVaKA-1; Wed, 26 Apr 2023 05:17:15 -0400
X-MC-Unique: qev4stNbNn-i1c7KcjVaKA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f195129aa4so31949965e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 26 Apr 2023 02:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682500635; x=1685092635;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hb1p3qZAdlHU1l6iLXytZzmouo7Dtxmm/TUeo1IcTKg=;
        b=aU6Xk9Wgi7VfBOieHVQxrhoSBENtlKCvYNb81eCGKHQQ71DrPeiHCpoem9rImoxkL/
         ysOD12+jnitmppiEF37sQRyzyDbjBCjOq3ouJ47g3Nv2R7LURefcRFUSLP3CpkmtPZE1
         J0TTLVM8/Lk9Lfnrvf0Uv7nQaETmivQ/pr7i9JX1AN9wHC9Nb18nuDyBUtXKMIN6vyZx
         Q1PyyKjSBColmt5h/o68ehHDbLM4CCFpMu444OdkvyHP/JfXZS8reQ0m6Z1b2cMnx6Iz
         uKX0sQVunR8YTdGrOvhdPpXgKkbX1jGdiuUWXZ694omWfZyPHN9rca4O84IOzraPsB35
         OYsA==
X-Gm-Message-State: AAQBX9eRUKN6gQe+zuEGNQcvhq7Vw+mTkTUyFcJfijVMTdOtkysWx1T4
        MCliMvkHNiOUp9QasnwEtXM39MM2mATmEHqaS7FABLVXLbfWwuMsru8zMN6lwtvfC0R3KFl+dDK
        N1sBq7Vmjj3u/moIzdE4eMg==
X-Received: by 2002:a05:600c:d6:b0:3f1:75b0:dc47 with SMTP id u22-20020a05600c00d600b003f175b0dc47mr13169966wmm.15.1682500634753;
        Wed, 26 Apr 2023 02:17:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350YEVlQWGWn9MXHPZbupRZG32H3oU+0xy3h1QTn2pkKjRSNMnr+VdpDuWb9ZAW4i29YDBnhrOA==
X-Received: by 2002:a05:600c:d6:b0:3f1:75b0:dc47 with SMTP id u22-20020a05600c00d600b003f175b0dc47mr13169945wmm.15.1682500634432;
        Wed, 26 Apr 2023 02:17:14 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c16d400b003f19bca8f03sm10736304wmn.43.2023.04.26.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:17:13 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 2/8] sched/topology: introduce
 sched_numa_find_next_cpu()
In-Reply-To: <ZEi1/zO9cGccogea@yury-ThinkPad>
References: <20230420051946.7463-1-yury.norov@gmail.com>
 <20230420051946.7463-3-yury.norov@gmail.com>
 <xhsmh354ol21b.mognet@vschneid.remote.csb>
 <ZEi1/zO9cGccogea@yury-ThinkPad>
Date:   Wed, 26 Apr 2023 10:17:12 +0100
Message-ID: <xhsmhwn1zj947.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/04/23 22:26, Yury Norov wrote:
> On Tue, Apr 25, 2023 at 10:54:56AM +0100, Valentin Schneider wrote:
>> On 19/04/23 22:19, Yury Norov wrote:
>> > +/*
>> > + * sched_numa_find_next_cpu() - given the NUMA topology, find the next cpu
>> > + * cpumask: cpumask to find a cpu from
>> > + * cpu: current cpu
>> > + * node: local node
>> > + * hop: (in/out) indicates distance order of current CPU to a local node
>> > + *
>> > + * The function searches for next cpu at a given NUMA distance, indicated
>> > + * by hop, and if nothing found, tries to find CPUs at a greater distance,
>> > + * starting from the beginning.
>> > + *
>> > + * Return: cpu, or >= nr_cpu_ids when nothing found.
>> > + */
>> > +int sched_numa_find_next_cpu(const struct cpumask *cpus, int cpu, int node, unsigned int *hop)
>> > +{
>> > +	unsigned long *cur, *prev;
>> > +	struct cpumask ***masks;
>> > +	unsigned int ret;
>> > +
>> > +	if (*hop >= sched_domains_numa_levels)
>> > +		return nr_cpu_ids;
>> > +
>> > +	masks = rcu_dereference(sched_domains_numa_masks);
>> > +	cur = cpumask_bits(masks[*hop][node]);
>> > +	if (*hop == 0)
>> > +		ret = find_next_and_bit(cpumask_bits(cpus), cur, nr_cpu_ids, cpu);
>> > +	else {
>> > +		prev = cpumask_bits(masks[*hop - 1][node]);
>> > +		ret = find_next_and_andnot_bit(cpumask_bits(cpus), cur, prev, nr_cpu_ids, cpu);
>> > +	}
>> > +
>> > +	if (ret < nr_cpu_ids)
>> > +		return ret;
>> > +
>> > +	*hop += 1;
>> > +	return sched_numa_find_next_cpu(cpus, 0, node, hop);
>> 
>> sched_domains_numa_levels is a fairly small number, so the recursion depth
>> isn't something we really need to worry about - still, the iterative
>> variant of this is fairly straightforward to get to:
>
> This is a tail recursion. Compiler normally converts it into the loop just
> as well. At least, my GCC does.

I'd hope so in 2023! I still prefer the iterative approach as I find it
more readable, but I'm not /too/ strongly attached to it.

