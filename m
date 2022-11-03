Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24B617C71
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiKCMWJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiKCMWI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 08:22:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7EF69;
        Thu,  3 Nov 2022 05:22:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1076398wmo.1;
        Thu, 03 Nov 2022 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3XxTo7IpX7TqdyYgvc//56G/3r2F5+mPbQZ0vMiEFo=;
        b=Nr0ZeNZSad3dcoIAwU7msQDlzOl1I97puv+VDPnkBlQbiG+kOX94yfmGdj87/obumZ
         R7A6nMlsf/xjhCxr9KFkttou0lWShCDRhVNC2hzK0SGdVX6iKDplzIzCim2Co7pEiQVR
         raP/jnFYJQIPpBvbNNA5hsrYv1p5NtsIvqhnclWOvXS4RoLTMk9NAHTWQYV0dFnqeZlc
         jIN1XDQE/VKl+qxk/BLal27IQdPFcWTncgIBztfkPD34B7bOnO48TWv0Pt9rCd528Qb7
         cM0GktZ3IejdRkmgr/TKBiIWgyuLyJOeyVWHbv13MXr8lvvSq/fgluV5DS8qo4E4xIkZ
         VNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3XxTo7IpX7TqdyYgvc//56G/3r2F5+mPbQZ0vMiEFo=;
        b=gW6gwc/fiZvqNdPbz6T3VR4bUPzetWILxABqwm7C+f+AxdP4OxuDvx6WSKNznhmaL/
         oRjKRidW5sy96O2YVzQJbiwNTEF42wGl998hIKF96BBFIPxb7RuleBe3aQ/Rz7mCT5CB
         y36oR0c5bS3kBNKTIl1hrjRTHExIyiqJiDoSWFB1aOMEYJRCgSSeSvk2dQwRNQ6dlSLf
         Vs0j9OS//PIH9ys4qH8+8kjWo+kJPyfA2QivtomQKubJX3ba+xt6uskOk65xt+KUpyE6
         r9Gbl/Vn6qvfn516GJvtWjXO1DZHKk8elaoGxsr+FQ/+hNaVjAHDL13AlAjPZAEEp27P
         uvZQ==
X-Gm-Message-State: ACrzQf3+xiC6DbIRtMki1lLFVPsThVOFRjYrL3BwyolIS/UV3okvhnVC
        0L/jswM4VC7ckboedoSIE7ZoG1GQR6eH/A==
X-Google-Smtp-Source: AMsMyM4ipe0FNeWek+zT8c1jYgA6h5Ce1S08+MIdAaSHFLq6BV1jiTufVPW+0EoFjKAPXeoObWYs3Q==
X-Received: by 2002:a05:600c:3107:b0:3c6:ff0a:c42 with SMTP id g7-20020a05600c310700b003c6ff0a0c42mr28778299wmo.141.1667478125558;
        Thu, 03 Nov 2022 05:22:05 -0700 (PDT)
Received: from leonid-Inspiron-3421 (93-172-205-151.bb.netvision.net.il. [93.172.205.151])
        by smtp.gmail.com with ESMTPSA id y10-20020a056000108a00b0022cd96b3ba6sm847289wrw.90.2022.11.03.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:22:04 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:22:01 +0200
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
Message-ID: <Y2OyaSe7CrhJ9COo@leonid-Inspiron-3421>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <20221102074457.08f538a8@rorschach.local.home>
 <Y2JqX3vC1mG/JDex@ziepe.ca>
 <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <Y2J4/NQMhRORqnZ0@ziepe.ca>
 <20221102101719.6cbcca6b@rorschach.local.home>
 <Y2J9lAqBvjjPUmJf@ziepe.ca>
 <20221102115947.000897fa@rorschach.local.home>
 <Y2LMjYNAE5LwtcOp@leonid-Inspiron-3421>
 <20221102181900.5bc9812f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102181900.5bc9812f@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 02, 2022 at 06:19:00PM -0400, Steven Rostedt wrote:
> On Wed, 2 Nov 2022 22:01:17 +0200
> Leonid Ravich <lravich@gmail.com> wrote:
> 
> > disagree, without CONFIG_PREEMPTION (which is the default case in some
> > destros) we will not get any warning, because there will not be
> > preamption disable.
> 
> I test all for my code (NON_PREEMPT, VOLUNTEER_PREEMPT, PREEMPT) and
> with and without lockdep enabled.
> 
> This would be a bug if you called kmalloc(X, GFP_KERNEL) in *any* non
> preempt section.
yes, but for NON_PREEMPT trace is not non preempt section,
actualy the problem is with CONFIG_PREEMPT_COUNT not set. 

ftrace uses preemot_enable/disable_notrace macro to "mark" it as non preempt section
which do it only for CONFIG_PREEMPT_COUNT. 

from include/linux/preempt.h
if !CONFIG_PREEMPT_COUNT
#define preempt_enable_notrace()                barrier()

this is why there is no any warning on my system.
> 
> > 
> > second issue I see and maybe it is only me, is that the assuption of
> > atomicity in trace is not a common knowledge for trace users.     
> 
> Well, I suppose we could add more documentation. Would that help? Where
> would you see it? In the sample code?
> 
I think if we fix the first issue and make kernel cry for any miss
behave it we do the job. 
> I advise not even grabbing locks in trace events, because in most cases
> lockdep will not catch any issues with them (it will be hidden unless
> the trace event is enabled).
> 

-- Leonid 

