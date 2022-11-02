Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20E616E2A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKBUB3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKBUBY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 16:01:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85370194;
        Wed,  2 Nov 2022 13:01:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso119356wmp.5;
        Wed, 02 Nov 2022 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdmYTvu+zYpj7KgYKCU+/zaBOvuZZ8jatmz3kLIrPfg=;
        b=LHTa4kwK97AZu9XWzAgU7Ru4ce6dgEG3bB7pKdLyPyFxbvs7RASuKfWO+c88RO3ZlA
         NqhRNGXeRWleEUFpfrTUhDsQLYvN6WGBTtMCME0uragCWUKeaWcplcfGNWHoOUhYh+/F
         ix2JnFTMt4TYs/5Fvw5DVvHkXhHQQXPjykKB3d3dkimwpu/ZseyEPfGewc64vFSLXqEf
         hJQ47i/T69WUcpf5HIV5bDX1T7R2JovtVx0XRABVJ2921jzDrD5E1OgvWy20Tkk+1iA0
         6NTe2blaQSPBPBz7wVwqFTlCh6OVdBOTu9NjsF07bLsb7oH8FlocZbZkNEBDbG2qg3JL
         ToUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdmYTvu+zYpj7KgYKCU+/zaBOvuZZ8jatmz3kLIrPfg=;
        b=8BDQZVjtsRP66LSLViXqDpn5KPAvpaW8aGAMIReHYuy24fFHLVA2gXA7D4YJwNRLUI
         Zc4/ys9Ez3Xy6wd69Yr+Ihlx33s6ciuc//uV8W9XLPALJPJgijB9LVA7mjsUJw3XDliA
         Zml3pTWY+d4GfRlki5ruw5WJI/eR+SO7ospA2uKUGAS4o3eRgR+TdGU9TZakuN5o4BjT
         lSv1cbt1Txy/1E66kmHrYwoxnlsVETrM5F/U8ezxjDtrUJzOjRhQF/OW7r5HvOGz6sf3
         IFTtZUMMKEXNixSNvsTQxTCxPbmyIZhUr7VEp8DUpQ9Zaz12xFTJS+S7TO+lOmsj1/2K
         STnw==
X-Gm-Message-State: ACrzQf083ke3h4rqcWwERYzjIpNlpAm2mkk3kE7hqEh1YzbfrHjsaPIw
        PU9LfnVjsZt/L3gFeb8zPN+Cn5m5AmhQew==
X-Google-Smtp-Source: AMsMyM6MbmWWEKKewgppk+dMC8e39nJ0CkTBH2iM6ZEo5pt5EirJqQdLGrpbKFuWKQLhHZxm+6CqpQ==
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id fn5-20020a05600c688500b003bdd782623cmr16703442wmb.102.1667419281857;
        Wed, 02 Nov 2022 13:01:21 -0700 (PDT)
Received: from leonid-Inspiron-3421 (93-172-205-151.bb.netvision.net.il. [93.172.205.151])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003cf483ee8e0sm3649378wmp.24.2022.11.02.13.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:01:20 -0700 (PDT)
Date:   Wed, 2 Nov 2022 22:01:17 +0200
From:   Leonid Ravich <lravich@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leonid Ravich <leonid.ravich@toganetworks.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <Y2LMjYNAE5LwtcOp@leonid-Inspiron-3421>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <20221102074457.08f538a8@rorschach.local.home>
 <Y2JqX3vC1mG/JDex@ziepe.ca>
 <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <Y2J4/NQMhRORqnZ0@ziepe.ca>
 <20221102101719.6cbcca6b@rorschach.local.home>
 <Y2J9lAqBvjjPUmJf@ziepe.ca>
 <20221102115947.000897fa@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102115947.000897fa@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Wed, 2 Nov 2022 11:24:20 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > No, it doesn't muck with preemption, it will have some sleeping lock,
> > eg mlx5_ib_query_pkey() does a memory allocation as the first thing
> > 
> > It seems like a bug that calling kmalloc(GFP_KERNEL)/might_sleep()
> > from within a tracepoint doesn't trigger a warning?
> 
> Has nothing to do with tracepoints. You could call it a bug that it
> doesn't trigger a warning when preemption is disabled. But then again,
> it would if you enabled DEBUG_PREEMPT and possibly LOCKDEP too. So, I chalk
> this up to a lack of proper testing.
>

disagree, without CONFIG_PREEMPTION (which is the default case in some
destros) we will not get any warning, because there will not be
preamption disable.

second issue I see and maybe it is only me, is that the assuption of
atomicity in trace is not a common knowledge for trace users.     
