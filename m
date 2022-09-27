Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339795EC9E1
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiI0QqC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiI0Qp3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 12:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62124167C7
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664297126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aYh91Y5WzQL9iD8Qk6Vf/HhWFbftIWDiE0GIw3ZzEc=;
        b=DuvPYxMaPZz6de2Pu/n5Ju+6Uqk5E0TouIj7nMzlxMMJ4M6eNiiiq6+hGcPPGZf8dRoBpk
        qGaKXE8HdmyOeTlQL+DcapxPWOoH8VLJdGHFbW4vlnvtoIkMIuA/Syt9VDcicMICdPOAyf
        We8x1AGKbueiL/n8kyslIPUSz79KHMU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-wCAvQuliP0u-DeoVkoQ8UA-1; Tue, 27 Sep 2022 12:45:24 -0400
X-MC-Unique: wCAvQuliP0u-DeoVkoQ8UA-1
Received: by mail-wm1-f71.google.com with SMTP id 5-20020a05600c028500b003b4d2247d3eso946240wmk.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 09:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=3aYh91Y5WzQL9iD8Qk6Vf/HhWFbftIWDiE0GIw3ZzEc=;
        b=WySKi9E6lzS+XU1Nq3KVC+fch8du+MfCVFlH8nOMVgk/YGLTt6n+T/c25Bobnqc3W0
         9P8JMwjhXpuc5XG3p04TkGJSyIN4wnzZPE4RPJna5daIrPYGFzrRBkUIYPL7uisTeKMS
         PrRm5usCQNECLHpkK0aq6SAp/qSOcIrAYSYzpNcb6IlvCJh6Wet5TWypIDknooO7OhXK
         DM61OBHws9jquAMBhLTqcWq6xGPw3ZOV+bH9Dq54zm6JUmbCz5lds7jKKcXS/AKaa65h
         q89aJFg6mi3Esk0GjqgDcwg7VDgKwGFi+N+3jtoVMrbCXoKUztxD0+rPrgk00wvItF8Z
         zZ9g==
X-Gm-Message-State: ACrzQf1AUuS5w4hclKGJB/q+2+hkFdS4ksSAS8kyYffvHbN3tWijTsNP
        vGknjPmsZBwsJiWwVIBAz/alygkZCUw0eF+YV2AklLF3uiBKNS3U7lugISyv9rmAO/G/FqkVk8G
        gYhQjKtTjLkQwIMSBHlO1Bg==
X-Received: by 2002:a05:6000:1081:b0:22a:2ecf:9cf8 with SMTP id y1-20020a056000108100b0022a2ecf9cf8mr16895814wrw.205.1664297123830;
        Tue, 27 Sep 2022 09:45:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xfXd99KDnmORegLCH4Mobu+mrKA/QfOT4UCXrEVf80cwvr7snphoIuQO9+NR1l/RPhKpcDQ==
X-Received: by 2002:a05:6000:1081:b0:22a:2ecf:9cf8 with SMTP id y1-20020a056000108100b0022a2ecf9cf8mr16895793wrw.205.1664297123592;
        Tue, 27 Sep 2022 09:45:23 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id t18-20020adfe452000000b00228cd9f6349sm2287334wrm.106.2022.09.27.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:45:22 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v4 6/7] sched/topology: Introduce for_each_numa_hop_cpu()
In-Reply-To: <YzBsonBFi9OJ29UT@yury-laptop>
References: <20220923132527.1001870-1-vschneid@redhat.com>
 <20220923155542.1212814-5-vschneid@redhat.com>
 <YzBsonBFi9OJ29UT@yury-laptop>
Date:   Tue, 27 Sep 2022 17:45:21 +0100
Message-ID: <xhsmhedvw4vha.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/09/22 07:58, Yury Norov wrote:
> On Fri, Sep 23, 2022 at 04:55:41PM +0100, Valentin Schneider wrote:
>> +/**
>> + * for_each_numa_hop_cpu - iterate over CPUs by increasing NUMA distance,
>> + *                         starting from a given node.
>> + * @cpu: the iteration variable.
>> + * @node: the NUMA node to start the search from.
>> + *
>> + * Requires rcu_lock to be held.
>> + * Careful: this is a double loop, 'break' won't work as expected.
>
> This warning concerns me not only because new iteration loop hides
> complexity and breaks 'break' (sic!), but also because it looks too
> specific. Why don't you split it, so instead:
>
>        for_each_numa_hop_cpu(cpu, dev->priv.numa_node) {
>                cpus[i] = cpu;
>                if (++i == ncomp_eqs)
>                        goto spread_done;
>        }
>
> in the following patch you would have something like this:
>
>        for_each_node_hop(hop, node) {
>                struct cpumask hop_cpus = sched_numa_hop_mask(node, hop);
>
>                for_each_cpu_andnot(cpu, hop_cpus, ...) {
>                        cpus[i] = cpu;
>                        if (++i == ncomp_eqs)
>                                goto spread_done;
>                }
>        }
>
> It looks more bulky, but I believe there will be more users for
> for_each_node_hop() alone.
>
> On top of that, if you really like it, you can implement
> for_each_numa_hop_cpu() if you want.
>

IIUC you're suggesting to introduce an iterator for the cpumasks first, and
then maybe add one on top for the individual cpus.

I'm happy to do that, though I have to say I'm keen to keep the CPU
iterator - IMO the complexity is justified if it is centralized in one
location and saves us from boring old boilerplate code.

>> + * Implementation notes:
>> + *
>> + * Providing it is valid, the mask returned by
>> + *  sched_numa_hop_mask(node, hops+1)
>> + * is a superset of the one returned by
>> + *   sched_numa_hop_mask(node, hops)
>> + * which may not be that useful for drivers that try to spread things out and
>> + * want to visit a CPU not more than once.
>> + *
>> + * To accommodate for that, we use for_each_cpu_andnot() to iterate over the cpus
>> + * of sched_numa_hop_mask(node, hops+1) with the CPUs of
>> + * sched_numa_hop_mask(node, hops) removed, IOW we only iterate over CPUs
>> + * a given distance away (rather than *up to* a given distance).
>> + *
>> + * hops=0 forces us to play silly games: we pass cpu_none_mask to
>> + * for_each_cpu_andnot(), which turns it into for_each_cpu().
>> + */
>> +#define for_each_numa_hop_cpu(cpu, node)				       \
>> +	for (struct { const struct cpumask *curr, *prev; int hops; } __v =     \
>> +		     { sched_numa_hop_mask(node, 0), NULL, 0 };		       \
>
> This anonymous structure is never used as structure. What for you
> define it? Why not just declare hops, prev and curr without packing
> them?
>

I haven't found a way to do this that doesn't involve a struct - apparently
you can't mix types in a for loop declaration clause.

> Thanks,
> Yury
>

