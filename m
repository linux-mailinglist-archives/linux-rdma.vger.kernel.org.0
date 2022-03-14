Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A54D8AF1
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 18:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiCNRlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiCNRlT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 13:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD3811C06
        for <linux-rdma@vger.kernel.org>; Mon, 14 Mar 2022 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647279608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLstmHH+5CbsnPnWXdtuRqA7kvqe8GYqa2Jz6JEJP/I=;
        b=L1/FulpDo4JD3BbYS8A8eQwodhzyZCs0Jb5vrO0qv/ByMlmQVa3zgER266AkbHuFTE80hD
        KPFBex5gHIjylWhUXy4HowETw52Ql4WyvkgAnq95pXOrSq5QDac30FDjyiDqRtnUX4Ma84
        ZBt65JU8x3R4MvdvPjVMwX29F/7J4U4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-RiDDM4URPDG9jaByO7yaUw-1; Mon, 14 Mar 2022 13:40:05 -0400
X-MC-Unique: RiDDM4URPDG9jaByO7yaUw-1
Received: by mail-ot1-f69.google.com with SMTP id 92-20020a9d0de5000000b005b2731fb946so10351503ots.4
        for <linux-rdma@vger.kernel.org>; Mon, 14 Mar 2022 10:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLstmHH+5CbsnPnWXdtuRqA7kvqe8GYqa2Jz6JEJP/I=;
        b=K6jCn16d77nJTKYtR/XMRyHbWXk/6vP/qnVevqUkN1In72i5n1pRR5xOux1pGO/JPT
         GWAyic+RmNBjf2u+sWItYavn/iTulICIWPgnuczegVDs3eADEaTuPeQDN6lmvsv6HU6T
         dze8m0ja7BFo6Yoq1loBD/JMmtTdP7seA+co7zYCXS0mZZMAST2EWy8GM9zGcghEKLm/
         GpwwkR9w9G3Vk8PuH89o4IsvyrB0qJWlmiy92Luzzh767BgG7lY1UuGscMrGgvDtdjpi
         7LxqFCwfgv+Gb7md3OW/HZsE9bM4Ck+D/wF6nhucd7zVKn9EO5Cv3lfTIubdaK75vi32
         8G+g==
X-Gm-Message-State: AOAM53189eSTxMqKln1fuS2XjNYcLdR8hfZSUwnUa/yT271iQQtrBHg7
        FHVjlcM9+7bGzRagmFY+lYqaLGaePJkyqU4SklNls30RkPawQiONCvlHrZAWbrRoNO39/isalIJ
        lZbGFC0JTyMeB8YHvG719Sg==
X-Received: by 2002:a05:6808:128e:b0:2da:6d08:8704 with SMTP id a14-20020a056808128e00b002da6d088704mr167345oiw.9.1647279604779;
        Mon, 14 Mar 2022 10:40:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvKon1rAQEfTVIuqF2qBmJjJWOza7UxNLEW6n8+Qxdxp8wU5eo0UPDzK9UYDBRVSRQoqbLBQ==
X-Received: by 2002:a05:6808:128e:b0:2da:6d08:8704 with SMTP id a14-20020a056808128e00b002da6d088704mr167338oiw.9.1647279604475;
        Mon, 14 Mar 2022 10:40:04 -0700 (PDT)
Received: from loberhel ([2600:6c64:4e7f:cee0:729d:61b6:700c:6b56])
        by smtp.gmail.com with ESMTPSA id l84-20020aca3e57000000b002d97bda3872sm8132617oia.55.2022.03.14.10.40.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2022 10:40:03 -0700 (PDT)
Message-ID: <f18f7a350bf5b0f0651083d9a592d35d0d5a68f4.camel@redhat.com>
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
From:   Laurence Oberman <loberman@redhat.com>
To:     David Jeffery <djeffery@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Mon, 14 Mar 2022 13:40:02 -0400
In-Reply-To: <CA+-xHTHK1y7JFAeBN=NVq=vaRBXfRNPbF5ZxmdQ2trhhU+E0tQ@mail.gmail.com>
References: <20220311175713.2344960-1-djeffery@redhat.com>
         <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
         <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
         <e39a032f-9e95-a038-c29c-30bb58e45fc0@nvidia.com>
         <CA+-xHTHK1y7JFAeBN=NVq=vaRBXfRNPbF5ZxmdQ2trhhU+E0tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2022-03-14 at 11:55 -0400, David Jeffery wrote:
> On Mon, Mar 14, 2022 at 10:52 AM Max Gurtovoy <mgurtovoy@nvidia.com>
> wrote:
> > 
> > 
> > On 3/14/2022 3:57 PM, David Jeffery wrote:
> > > On Sun, Mar 13, 2022 at 5:59 AM Max Gurtovoy <
> > > mgurtovoy@nvidia.com> wrote:
> > > > Hi David,
> > > > 
> > > > thanks for the report.
> > > > 
> > > > Please check how we fixed that in NVMf in Sagi's commit:
> > > > 
> > > > nvmet-rdma: fix possible bogus dereference under heavy load
> > > > (commit:
> > > > 8407879c4e0d77)
> > > > 
> > > > Maybe this can be done in isert and will solve this problem in
> > > > a simpler
> > > > way.
> > > > 
> > > > is it necessary to change max_cmd_sn ?
> > > > 
> > > > 
> > > 
> > > Hello,
> > > 
> > > Sure, there are alternative methods which could fix this
> > > immediate
> > > issue. e.g. We could make the command structs for scsi commands
> > > get
> > > allocated from a mempool. Is there a particular reason you don't
> > > want
> > > to do anything to modify max_cmd_sn behavior?
> > 
> > according to the description the command was parsed successful and
> > sent
> > to the initiator.
> > 
> 
> Yes.
> 
> > Why do we need to change the window ? it's just a race of putting
> > the
> > context back to the pool.
> > 
> > And this race is rare.
> > 
> 
> Sure, it's going to be rare. Systems using isert targets with
> infiniband are going to be naturally rare. It's part of why I left
> the
> max_cmd_sn behavior untouched for non-isert iscsit since they seem to
> be fine as is. But it's easily and regularly triggered by some
> systems
> which use isert, so worth fixing.
> 
> > > 
> > > I didn't do something like this as it seems to me to go against
> > > the
> > > intent of the design. It makes the iscsi window mostly
> > > meaningless in
> > > some conditions and complicates any allocation path since it now
> > > must
> > > gracefully and sanely handle an iscsi_cmd/isert_cmd not existing.
> > > I
> > > assume special commands like task-management, logouts, and pings
> > > would
> > > need a separate allocation source to keep from being dropped
> > > under
> > > memory load.
> > 
> > it won't be dropped. It would be allocated dynamically and freed
> > (instead of putting it back to the pool).
> > 
> 
> If it waits indefinitely for an allocation it ends up with a
> variation
> of the original problem under memory pressure. If it waits for
> allocation on isert receive, then receive stalls under memory
> pressure
> and won't process the completions which would have released the other
> iscsi_cmd structs just needing final acknowledgement.
> 
> David Jeffery
> 

Folks this is a pending issue stopping a customer from making progress.
They run Oracle and very high workloads on EDR 100 so David fixed this
fosusing on the needs of the isert target changes etc. 

Are you able to give us technical reasons why David's patch is not
suitable and why we he would have to start from scratch.

We literally spent weeks on this and built another special lab for
fully testing EDR 100.
This issue was pending in a BZ for some time and Mellnox had eyes on it
then but this latest suggestion was never put forward in that BZ to us.

Sincerely
Laurence 

