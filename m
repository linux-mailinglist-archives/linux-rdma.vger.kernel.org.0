Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245CF4B2C09
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiBKRsv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 12:48:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiBKRsu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 12:48:50 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9E2C9
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 09:48:48 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so11128860ooa.11
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Q4vrRD/M34hRAvrgidn/GlqnliTM8w6e6cWF7LtVDvQ=;
        b=AtYO73ajnCbJlXRl/HKPlKwLQ8lJltjnX7d7Py1MMRbAQ+Z4u9CEzTO8ys5u77WMZv
         wmuhf4Niq51Q1nPJKR9IEss7gxj8llQA0W4W3312I52RJWDmlsolA/B104zuuyR8P//C
         IGJl1IYNSZWEVSKgomhfCQ3KBVGy8kYjwh4FCphN4dHgD9J356z1NLYt2ID0HQPcwlZ3
         GI7ZoQFYLNovSSVjhjMRN5WMpfgo0a8vZ+Ju0tgAcT/LkdFOLR10QoMjOHAHzV9ykA3q
         8/TckVoP7KXIJRhFhCdcsW3xzf3XvdbJpqcTl3SURoSAb+BamCwHUxSrDckKiJkcGFwf
         u+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q4vrRD/M34hRAvrgidn/GlqnliTM8w6e6cWF7LtVDvQ=;
        b=51txDutbkrDp/Hdo4ZLasfX3elUuI/ObX7u1jOuxecbQ3EGu0olwoiotJy80qKeQEl
         hlUtnUnkLisMpI0l5Z0+rYci+cmK2D0+zUIqtFFFfcAbQ8lpediDlJ8/vLVUy/hv5dSD
         WlUIrGPqCbsfEFSb/0PWWwNAMfepNVH5c4VvbXl86dnjvCqMmHRwqmB+EA5mhk5+Gzsv
         UqdJFr9Bx90eVFxLndDUQpOAYFQcF5WvSrwDLD8PXLgxd2uVtHMIU0l5468ShPxRGKtT
         YSvI7FrmAT+gK5gVPgGgUx7hNjT9CMvEB2u/6y/8YvLfp6wY8w6G0GWkA6WnrHjbRbA5
         pT7w==
X-Gm-Message-State: AOAM5317/jdBjAcB9yV8uXVWjra7HYoWkOx11m48cii5Ne5GS+SH8bZc
        OgLvTjhXomkxA+2qf4hDqPpq35hAQvI=
X-Google-Smtp-Source: ABdhPJwWJZVU8L4EY88yOLW2Q99/w4YqfeHRWfqciAEGfJCB0pVy94aVEbJQBLwMPjrTPe8bii8JDA==
X-Received: by 2002:a05:6870:d247:: with SMTP id h7mr486628oac.251.1644601728057;
        Fri, 11 Feb 2022 09:48:48 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:4354:ebed:9b2:4ca2? (2603-8081-140c-1a00-4354-ebed-09b2-4ca2.res6.spectrum.com. [2603:8081:140c:1a00:4354:ebed:9b2:4ca2])
        by smtp.gmail.com with ESMTPSA id 16sm8722618oat.8.2022.02.11.09.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:48:47 -0800 (PST)
Message-ID: <6ea9199c-bae4-bfde-e45a-a6cda9acd58b@gmail.com>
Date:   Fri, 11 Feb 2022 11:48:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Soft-RoCE performance
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Christian Blume <chr.blume@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
 <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <11e71fc4-6194-9290-df0e-f062af91cc8c@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <11e71fc4-6194-9290-df0e-f062af91cc8c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/10/22 08:04, Yanjun Zhu wrote:

> 
> Thanks, I have also reached the big bandwidth with the same methods.
> How about latency of soft roce?
> 
> Zhu Yanjun

In loopback on my system with ib_write_lat I see the following. It isn't very exciting. The use case I am interested in doesn't require super low latency though.


 #bytes #iterations    t_min[usec]    t_max[usec]  t_typical[usec]    t_avg[usec]    t_stdev[usec]   99% percentile[usec]   99.9% percentile[usec] 

 2       1000          1.57           9.65         1.84     	       2.04        	0.69   		5.02    		9.65   

 4       1000          1.58           7.89         1.82     	       1.99        	0.54   		4.68    		7.89   

 8       1000          1.60           6.86         1.79     	       1.95        	0.51   		4.08    		6.86   

 16      1000          1.59           5.28         1.83     	       1.95        	0.42   		3.72    		5.28   

 32      1000          1.64           8.18         1.84     	       1.99        	0.52   		4.07    		8.18   

 64      1000          1.65           8.58         1.84     	       1.99        	0.48   		3.92    		8.58   

 128     1000          1.80           10.58        1.96     	       2.10        	0.47   		3.94    		10.58  

 256     1000          1.76           12.54        2.00     	       2.17        	0.52   		4.00    		12.54  

 512     1000          1.69           11.09        1.95     	       2.21        	0.66   		3.97    		11.09  

 1024    1000          1.80           12.91        2.00     	       2.22        	0.56   		3.89    		12.91  

 2048    1000          2.04           9.29         2.20     	       2.37        	0.50   		4.03    		9.29   

 4096    1000          2.39           11.66        2.58     	       2.76        	0.56   		4.67    		11.66  

