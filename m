Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16A061645D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKBOEv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKBOEv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 10:04:51 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1DD558E
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 07:04:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l9so11736458qkk.11
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UxCbt6GBlHFNsva2O9CSyNdHFgQ68KjAZd8NP1fsebM=;
        b=Cpdc/HjABelVjjq+JmD/HhooC9Wv0cfVJX9GgUAFyGqXoikcPgvxru/aliRrHNTJRH
         a0ouaWt9haGY3qPab8om+FWVehWLBpmxunLK0fQ2HO2lJItT01/+j3s0kya52+xPj/4j
         igtW9CFq+mxMHE1/HkhjjEDBZww57EHREcIkP5mbiVCS32yMaAVG8LjiQpzgRYVPwHIz
         pMOo+jXVfe8b1OB44KhgD54jAXHel3GqzBqZjs7ng6xWpsUFvnkmYxU5x0zRCMfVnyNP
         PdrmjPkbe0FHN/OIpbZrv3YKuVnoNPdAchi+5xeoHTSsTvsa5Egvg9GyskzEZbaQrPaG
         +nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxCbt6GBlHFNsva2O9CSyNdHFgQ68KjAZd8NP1fsebM=;
        b=boPinWF6yykRot/RYg20/LXJl8OhvGziJ0UzkrrEIEy/VyFEhiS6jwhXTnM3WHYg6k
         Rba8RsCgsUMXURXFjQCbnugFtR5ZurIAcRSbzzvlHyTaQJ9mh41V8FOjIL4dIKXobv+u
         tU/5hMa3KvtwZ57cL1KBWoYi5Kx97AkSxaA7eHPxyWPDN4kw9pl/0BMdyGMtyvwi5HO2
         OwO/C16IKv709XEX2Rx2CgCOnVeBvs7+VtwVyxyb0ejp5A7ZXyCUzTMPYIFUIPQhgMCc
         wUzKVDpkIXgv8w0dsEEnwDhMlPYzduViCu0Zh2n0w+EG5Fu3Hnza+zNK8B9Jmh/g8OHr
         vflg==
X-Gm-Message-State: ACrzQf0VIQLE5ODElYNvTBloZ6fQlmk0XjryrJ4DMSXyoT9AQWLEhJvp
        DwQoQFSOfKo//gprXUA0APbEhw==
X-Google-Smtp-Source: AMsMyM7PPoih6qSc1/c/Hi5+95iahhedIDtPlcV3jX5SWInhXF9cqQyjWeca7jo2lQzqIZIwEI3wUA==
X-Received: by 2002:a37:bec6:0:b0:6f7:27c3:3110 with SMTP id o189-20020a37bec6000000b006f727c33110mr17265921qkf.46.1667397885486;
        Wed, 02 Nov 2022 07:04:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id k26-20020ac8475a000000b00398313f286dsm4942251qtp.40.2022.11.02.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:04:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oqEMG-004f46-C3;
        Wed, 02 Nov 2022 11:04:44 -0300
Date:   Wed, 2 Nov 2022 11:04:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leonid Ravich <leonid.ravich@toganetworks.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Leon Ravich <lravich@gmail.com>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <Y2J4/NQMhRORqnZ0@ziepe.ca>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <20221102074457.08f538a8@rorschach.local.home>
 <Y2JqX3vC1mG/JDex@ziepe.ca>
 <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 02, 2022 at 02:02:49PM +0000, Leonid Ravich wrote:
> > > > before starting throwing some patch into the the air  I would like to align with you the approach we should take here. 
> > > > 
> > > > my suggestion here : 
> > > >- ftrace infra should verify no migration happen  (end and start happens on same CPU)  in case not we will  throw warning for the issue  .
> > >
> > >The scheduler should have. On entering the ring buffer code
> > >ring_buffer_lock_reserver() it disables preemption and does not
> > >re-enable it until ring_buffer_unlock_commit().
> > >
> > >The only way to migrate is if you re-enable preemption. WHICH IS A
> > >BUG!
> 
> >So what on earth did that?
> 
> >I'm guessing some driver's query_pkey op, but AFAIK we don't have any
> >explicit pre-emption reenablements in the code - unless it is sneaky..
> trace infra uses preempt_disable_notrace/preempt_enable_notrace  to disable/enable preemtion but  my kernel compiled without CONFIG_PREEMPTION so this functions are only barriers - looks like the idea behind was to avoid involuntary preemtion  but in our case it is a voluntary (there is a wait_for_completion in the query_pkey  rabbit hole).

So this tracepoint is just wrong, you can't call a sleepable function
from a tracepoint like that?

Presumably lockdep would/should warn about this?

Delete the pkey logging from the tracepoint, it can't work, I guess.

Jason
