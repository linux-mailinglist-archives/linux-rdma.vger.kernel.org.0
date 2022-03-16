Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E464DB060
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 14:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348165AbiCPNIs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiCPNIr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 09:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E94496663B
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647436052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iBEu/qAkyIw2/yF01t6xN6wJ+YnDej9+Q9nI2N1Ny8=;
        b=DepqNtIiIQyZbYdelV5LCzf9mJJknzOd0aPuwZLfE6uBCWkIlHUyswaigjafgSD5T4cf7P
        wjmr2HRL/OiadU42tbFmRdAyewPOBpsqLgH8zRPY70jkUgdJLAg5cbBkt1RfZoHOK3u9tP
        Gs5zkk1jgHP8pUMhXUP2FLNx/nG9ruA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-mD44T4rEOwGhwmkD1Z9drQ-1; Wed, 16 Mar 2022 09:07:30 -0400
X-MC-Unique: mD44T4rEOwGhwmkD1Z9drQ-1
Received: by mail-oo1-f70.google.com with SMTP id n17-20020a4a6111000000b003240a200d74so1379480ooc.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 06:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iBEu/qAkyIw2/yF01t6xN6wJ+YnDej9+Q9nI2N1Ny8=;
        b=7Sq53i4t9ii3MuT2SQTI+kAvm3lxCWZH8CB/12+gHIAUXSd5ATDEFHP/ABSnSzwusV
         XvOwf0x+V+eKMcWrAc8uzpSQYqpk/vkYp2e9Yne8MISQiX3QCYQYz3KinJcVpCFdVRGg
         XkA+aszCTYc3OHFYFul4FAlsOE2HTDtDPp0BxT/ZF+dQV3OdwxK+JZqULgTQVFfcPMVs
         NAYFPBXJQXSjSnPwr0gIZQvLjOvxxsMzpLrXnuUjYEmdtNLIRqV1n+8/UsyWtHJtjTvN
         oGLAYQ0OOY25HZjgrVaPqI3i2a8Z6qI1aQSj6p685tuewDSNiTp7KV1PU0GWacKm/RI1
         mJDA==
X-Gm-Message-State: AOAM5319uEaMgrW1OLbiZ83CgF6KD/NZsBfKGCN2r+r8YGoNHOXtG/QP
        VUfs/TLyBv5kidF03ZF3OvYVZQG5x8N/r8UfwMhblA0F9LUVxcFbREIloNmv5lQQzBvfUrYjGyL
        r6WbIaTInbiFc+QQLhG0uUg==
X-Received: by 2002:a4a:c10c:0:b0:321:1db4:8147 with SMTP id s12-20020a4ac10c000000b003211db48147mr12802322oop.27.1647436048818;
        Wed, 16 Mar 2022 06:07:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH9b/xPihaCnSZihQAeyepa6JivHhYLzDi/TKpiF7hAs1VezKyOz1cINS3LJIoyFWZXoSJHg==
X-Received: by 2002:a4a:c10c:0:b0:321:1db4:8147 with SMTP id s12-20020a4ac10c000000b003211db48147mr12802257oop.27.1647436047061;
        Wed, 16 Mar 2022 06:07:27 -0700 (PDT)
Received: from loberhel ([2600:6c64:4e7f:cee0:729d:61b6:700c:6b56])
        by smtp.gmail.com with ESMTPSA id w22-20020aca3016000000b002ecbddcc67asm867647oiw.29.2022.03.16.06.07.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2022 06:07:26 -0700 (PDT)
Message-ID: <720ebd1f98ab3c709443176011f51d6e3ed37272.camel@redhat.com>
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
From:   Laurence Oberman <loberman@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Wed, 16 Mar 2022 09:07:24 -0400
In-Reply-To: <a1cc6842-1429-eea5-aa0d-47b3f2bab843@nvidia.com>
References: <20220311175713.2344960-1-djeffery@redhat.com>
         <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
         <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
         <e39a032f-9e95-a038-c29c-30bb58e45fc0@nvidia.com>
         <CA+-xHTHK1y7JFAeBN=NVq=vaRBXfRNPbF5ZxmdQ2trhhU+E0tQ@mail.gmail.com>
         <f18f7a350bf5b0f0651083d9a592d35d0d5a68f4.camel@redhat.com>
         <a1cc6842-1429-eea5-aa0d-47b3f2bab843@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2022-03-16 at 12:38 +0200, Max Gurtovoy wrote:
> On 3/14/2022 7:40 PM, Laurence Oberman wrote:
> > On Mon, 2022-03-14 at 11:55 -0400, David Jeffery wrote:
> > > On Mon, Mar 14, 2022 at 10:52 AM Max Gurtovoy <
> > > mgurtovoy@nvidia.com>
> > > wrote:
> > > > 
> > > > On 3/14/2022 3:57 PM, David Jeffery wrote:
> > > > > On Sun, Mar 13, 2022 at 5:59 AM Max Gurtovoy <
> > > > > mgurtovoy@nvidia.com> wrote:
> > > > > > Hi David,
> > > > > > 
> > > > > > thanks for the report.
> > > > > > 
> > > > > > Please check how we fixed that in NVMf in Sagi's commit:
> > > > > > 
> > > > > > nvmet-rdma: fix possible bogus dereference under heavy load
> > > > > > (commit:
> > > > > > 8407879c4e0d77)
> > > > > > 
> > > > > > Maybe this can be done in isert and will solve this problem
> > > > > > in
> > > > > > a simpler
> > > > > > way.
> > > > > > 
> > > > > > is it necessary to change max_cmd_sn ?
> > > > > > 
> > > > > > 
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > Sure, there are alternative methods which could fix this
> > > > > immediate
> > > > > issue. e.g. We could make the command structs for scsi
> > > > > commands
> > > > > get
> > > > > allocated from a mempool. Is there a particular reason you
> > > > > don't
> > > > > want
> > > > > to do anything to modify max_cmd_sn behavior?
> > > > 
> > > > according to the description the command was parsed successful
> > > > and
> > > > sent
> > > > to the initiator.
> > > > 
> > > 
> > > Yes.
> > > 
> > > > Why do we need to change the window ? it's just a race of
> > > > putting
> > > > the
> > > > context back to the pool.
> > > > 
> > > > And this race is rare.
> > > > 
> > > 
> > > Sure, it's going to be rare. Systems using isert targets with
> > > infiniband are going to be naturally rare. It's part of why I
> > > left
> > > the
> > > max_cmd_sn behavior untouched for non-isert iscsit since they
> > > seem to
> > > be fine as is. But it's easily and regularly triggered by some
> > > systems
> > > which use isert, so worth fixing.
> > > 
> > > > > I didn't do something like this as it seems to me to go
> > > > > against
> > > > > the
> > > > > intent of the design. It makes the iscsi window mostly
> > > > > meaningless in
> > > > > some conditions and complicates any allocation path since it
> > > > > now
> > > > > must
> > > > > gracefully and sanely handle an iscsi_cmd/isert_cmd not
> > > > > existing.
> > > > > I
> > > > > assume special commands like task-management, logouts, and
> > > > > pings
> > > > > would
> > > > > need a separate allocation source to keep from being dropped
> > > > > under
> > > > > memory load.
> > > > 
> > > > it won't be dropped. It would be allocated dynamically and
> > > > freed
> > > > (instead of putting it back to the pool).
> > > > 
> > > 
> > > If it waits indefinitely for an allocation it ends up with a
> > > variation
> > > of the original problem under memory pressure. If it waits for
> > > allocation on isert receive, then receive stalls under memory
> > > pressure
> > > and won't process the completions which would have released the
> > > other
> > > iscsi_cmd structs just needing final acknowledgement.
> 
> If your system is under such memory pressure can you can't allocate
> few 
> bytes for isert response, the silent drop
> 
> of the command is your smallest problem. You need to keep the system 
> from crashing. And we do that in my suggestion.
> 
> > > 
> > > David Jeffery
> > > 
> > 
> > Folks this is a pending issue stopping a customer from making
> > progress.
> > They run Oracle and very high workloads on EDR 100 so David fixed
> > this
> > fosusing on the needs of the isert target changes etc.
> > 
> > Are you able to give us technical reasons why David's patch is not
> > suitable and why we he would have to start from scratch.
> 
> You shouldn't start from scratch. You did all the investigation and
> the 
> debugging already.
> 
> Coding a solution is the small part after you understand the root
> cause.
> 
> > 
> > We literally spent weeks on this and built another special lab for
> > fully testing EDR 100.
> > This issue was pending in a BZ for some time and Mellnox had eyes
> > on it
> > then but this latest suggestion was never put forward in that BZ to
> > us.
> 
> Mellanox maintainers saw this issue few days before you sent it 
> upstream. I suggested sending it upstream and have a discussion here 
> since it has nothing to do with Mellanox adapters and Mellanox SW
> stack 
> MLNX_OFED.
> 
> Our job as maintainers and reviewers in the community is to see the
> big 
> picture and suggest solutions that not always same as posted in the 
> mailing list.
> 
> > 
> > Sincerely
> > Laurence
> > 
> 
> 

Hi Max 

The issue was reported with the OFED stack at the customer, so its why
we opened the BZ to get the Mallnox partners engineers engaged.
We had them then see if it also existed with the inbox stack which it
did. 
Sergey worked a little bit on the issue but did not have the same
suggestion you provivided and asked David for help.

We will be happy to take the fix you propose doing it your way. May I
that the engineewrs to work on this the most and understand the code
best propose a fix your way.

I will take on the responsibility to do all the kernel building and
testing.

Regards
Laurence


