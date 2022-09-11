Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B845B4F8F
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Sep 2022 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIKPJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Sep 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIKPJC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Sep 2022 11:09:02 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C812E6B6;
        Sun, 11 Sep 2022 08:09:01 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id o23so4494818pji.4;
        Sun, 11 Sep 2022 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tnxEpb6pf+fpk/khg6S5+1VA2aKHrO1P36M1MNHRA7w=;
        b=nJASzaLCelNKRznhA847c1UE4ar8IpIihax5UeQYeDgq0ESWQNYITeRbVlGAvsgOQE
         cfRWAF/a12Re++n47BNrbPJ39M5hsnlazAsHxlost98dWnS5jkXvVBH3ctNMZGk9KoR0
         4AlPbO8WhpzXiDfbszdGG2BJUMcC3U4QYgjTGNAZrw5QsxESGmU5BVHbTt8ak7ru4k9Y
         wI96mdLHIifQ7TD6MdO5DahoLB5GPMTiZ0b/rVmfkyxy1AYqBGxpYxjF2YkyKf+CEMEQ
         HCAK7IwJjuhQwsfX4bZq5Kd/KY58R8ybRNoBGpxQ8IMJvOUG6A3RSaZ+/kX+Ibji0Vcr
         na7Q==
X-Gm-Message-State: ACgBeo24yxj7+tFpvc1jPH1cD/hxOYZdeYqtKTjtKa/q9QDOn+JfOLU7
        0nLVGZUczUipMQnj7Lyt9Fc=
X-Google-Smtp-Source: AA6agR4rNPwx9VPnzfHkI3k7LIuzmTO9M+flEcD9XHbrrV7UG17q720pcwe/Vi78YoliZsPp6zC+Rg==
X-Received: by 2002:a17:90b:4a85:b0:202:4f3f:1f65 with SMTP id lp5-20020a17090b4a8500b002024f3f1f65mr19425015pjb.241.1662908941218;
        Sun, 11 Sep 2022 08:09:01 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d19-20020aa797b3000000b0053ea3d2ecd6sm3533917pfq.94.2022.09.11.08.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 08:09:00 -0700 (PDT)
Message-ID: <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
Date:   Sun, 11 Sep 2022 08:08:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <41e5476f4f14a0b77f4a8c3826e3ef943bf7c173.1662461897.git.matsuda-daisuke@fujitsu.com>
 <0b3366e6-c0ae-7242-5006-b638e629972d@linux.dev>
Content-Language: en-US
In-Reply-To: <0b3366e6-c0ae-7242-5006-b638e629972d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/11/22 00:10, Yanjun Zhu wrote:
> I also implemented a workqueue for rxe. IMO, can we add a variable to
> decide to use tasklet or workqueue?
> 
> If user prefer using tasklet, he can set the variable to use
> tasklet. And the default is tasklet. Set the variable to another
> value to use workqueue.

I'm in favor of removing all uses of the tasklet mechanism because of 
the disadvantages of that mechanism. See also:
* "Eliminating tasklets" (https://lwn.net/Articles/239633/).
* "Modernizing the tasklet API" (https://lwn.net/Articles/830964/).
* Sebastian Andrzej Siewior's opinion about tasklets 
(https://lore.kernel.org/all/YvovfXMJQAUBsvBZ@linutronix.de/).

Thanks,

Bart.

