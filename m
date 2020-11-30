Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7F32C7D8B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 05:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgK3EId (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Nov 2020 23:08:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46070 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgK3EId (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Nov 2020 23:08:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id e23so4441486pgk.12
        for <linux-rdma@vger.kernel.org>; Sun, 29 Nov 2020 20:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NIiQfdxupl97garY21VhVsH1ic9ExBPQ5IjiB87+7DE=;
        b=D0h27gXezC9AGIZLv7GrHpuZTCpeyW7290ujzHRiS3KH+NPYxPp7NMmCDQIsl1zt7+
         fik6rN960HXJJs60VuHUgu8/p4+3nK4F2bXbeOz4WdPVi/ZsxGyusLiCiiNe6BE99c6D
         wkcBngenUbev/Dhu15S3zqi+EofpZYR0ls+ZSJzCaiyfPprJdK6mHPnLgVQjYqdPho3W
         Q0Yz3Dn2NSUyDQEk3uch1ZFX5hMQpv8A9sOz7WBMD/GTcPSIoNCWjS4srC+nsxNsJea0
         IejkOzQwtJJzSXO9juNbUd830SJk9/rcfbcvDGVnV8NWyaixI0slCNy4Con6v9GMZNjj
         1sfg==
X-Gm-Message-State: AOAM530QL27srz72BzNUj3ssZjXPLzqRHRTOgRmiPDNXmPSTbMVm9mSX
        s1n3fdNnhHb8RfuC5BKzJYM=
X-Google-Smtp-Source: ABdhPJyQeOqljhxI5kxbd4+AnAFz29UVc9wr1vnPJwXzHg/lXxF1Smj6ZkcELheGGGZW40P+6cEgaQ==
X-Received: by 2002:a62:68c7:0:b029:197:c7e0:6d8f with SMTP id d190-20020a6268c70000b0290197c7e06d8fmr17031417pfc.74.1606709271904;
        Sun, 29 Nov 2020 20:07:51 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id o2sm6537695pgq.63.2020.11.29.20.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 20:07:50 -0800 (PST)
Subject: Re: [PATCH] RDMA/srp: Fix support for unpopulated NUMA nodes
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
References: <6c9f38f6-de5b-d01f-f67a-52a518d2a26d@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <efe241f7-6acf-3d39-b29c-fadefc7939d3@acm.org>
Date:   Sun, 29 Nov 2020 20:07:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <6c9f38f6-de5b-d01f-f67a-52a518d2a26d@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/25/20 10:26 AM, Nicolas Morey-Chaisemartin wrote:
> +static int srp_get_num_populated_nodes(void)
> +{
> +    int num_populated_nodes = 0;
> +    int node, cpu;
> +
> +    for_each_online_node(node) {
> +        bool populated = false;
> +        for_each_online_cpu(cpu) {
> +            if (cpu_to_node(cpu) == node){
> +                populated = true;
> +                break;
> +            }
> +        }
> +        if (populated) {
> +            num_populated_nodes++;
> +            break;
> +        }
> +    }
> +
> +    return num_populated_nodes;
> +}

Does the above code do what it should do? Will the outer loop be left as
soon as one populated node has been found? Can the 'populated' variable
be left out, e.g. as follows (untested):

+    for_each_online_node(node) {
+        for_each_online_cpu(cpu) {
+            if (cpu_to_node(cpu) == node){
+                num_populated_nodes++;
+                break;
+            }
+        }
+    }

>      if (target->ch_count == 0)
>          target->ch_count =
> -            max_t(unsigned int, num_online_nodes(),
> -                  min(ch_count ?:
> -                      min(4 * num_online_nodes(),
> -                          ibdev->num_comp_vectors),
> -                  num_online_cpus()));
> +            min(ch_count ?:
> +                min(4 * num_populated_nodes,
> +                    ibdev->num_comp_vectors),
> +                num_online_cpus());

It seems like "max_t(unsigned int, num_populated_nodes," is missing from
the above expression? I think there should be at least one channel per
NUMA node even if the number of completion vectors is less than the
number of NUMA nodes.

> -        node_idx++;
> +        if(cpu_idx)
> +            node_idx++;

Has this patch been verified with checkpatch? I think a space is missing
between "if" and "(".

Thanks,

Bart.
