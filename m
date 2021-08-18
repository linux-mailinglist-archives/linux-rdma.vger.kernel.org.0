Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFD63EFF1C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbhHRI31 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbhHRI3Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 04:29:25 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED9CC061764
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 01:28:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so2011039oth.7
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XTnu9ASnzFiqsNd5eZN9ZBy6DTLEA1Ohk+cA0uH6TQ=;
        b=ri0dmF7U4Id3i18XJ327hSWbht0YxuEX31BY+rrgzRqU+m1eEC0tuK4QWGcwCEzRwi
         LnZ8+Fv3pb9i95eAOe+swuqdpiNFC8yg9WgehfzsnsI1GS7drLJnbjYuIEAdI67Mog+p
         y2W0jjjHp0OKT1GCIjgGsk3YDdtipuEbky5QoYuJr8cUqvW3LIVs65tmiND1c5NkBqGG
         yaVYJS5tRzOjQjDaq/USSEpgZH9v8uR+qAyizFz1cDjjCbrrulpNHDto4qR51eOuXSe1
         QJxV0kohFcdIvEOGsSnix51Uq/g7UKAzGPBJcX1h3PcsAawC+kghhcayPMov8R1SHBB0
         6RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XTnu9ASnzFiqsNd5eZN9ZBy6DTLEA1Ohk+cA0uH6TQ=;
        b=RV4zDiNvVsa1oATaam9r5i2o2wlGlSROLeGLw3dVKdmUSuWdNQaEw1f4v6h+YxmLiD
         TR2T1i3SrnCvQxTLFHn9j997koPKF7q1V1A3azNG2GKSxKcSbbmzYeROlaR54KX1Kqim
         vTpiiAVCcV8L1zqGjdiL+Kzva3SBPCPi9Gmh2syx6OQu0gXPDwlpxcz3t5KgnMe+ct4+
         mgaeV2RLP8MCI8HBIOwcmlcg1Weom9AqWqm5XI0f5ZsyBQYFKuXMxIti7nBfN8rWF3vH
         uOX2HtZAOGA+EU0/1K2MOGa5lZ8MdcmMDX4E9tecQWTwl/UVerE+Xsj0IhVb41jEm7yN
         ccng==
X-Gm-Message-State: AOAM531cMRF7dYVr0fZO6aJBAvU7kbPU2aTptuANJsNvK97za0fY+uJr
        DWD1QLscQZPGV1K/feYcRsD6Odh1PSf9/agFt3U=
X-Google-Smtp-Source: ABdhPJzvuXJrLUD9RRZvVJFxSUuT709NIY32Nr0cnTpErD4X6Mp3rqBrX8QEa+6/7Valg89KfVtsS68Y9pGVGpJR3go=
X-Received: by 2002:a9d:541:: with SMTP id 59mr4260358otw.278.1629275330245;
 Wed, 18 Aug 2021 01:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <YQmF9506lsmeaOBZ@unreal> <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal> <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com>
 <611CABE6.3010700@fujitsu.com> <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
 <611CBA42.9020002@fujitsu.com>
In-Reply-To: <611CBA42.9020002@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 18 Aug 2021 16:28:39 +0800
Message-ID: <CAD=hENcE12nKdRn04K9Zbd1CyOQureYb44fp9occ=R4P6XrgZQ@mail.gmail.com>
Subject: Re: RXE status in the upstream rping using rxe
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 3:44 PM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> On 2021/8/18 15:20, Zhu Yanjun wrote:
> > Can you let me know how to reproduce the panic?
> >
> > 1. linux upstream<  ----rping---->  linux upstream?
> rdma_client on v5.13<  --->  rdma_server on upstream kernel.
>
> > 2. just run rping?
> Running rdma_client on v5.13 and rdma_server on upstream can reproduce
> the issue.
>
> Note: running rping can reproduce the issue as well.

rping and rdma_server/rdma_client are from the latest rdma-core?

Thanks
Zhu Yanjun

> > 3. how do you create rxe? with rdma link or rxe_cfg?
> rdma link add
> > 4. do you make other operations?
> No
> > 5. other operations?
> No
> > Thanks.
> > Zhu Yanjun
> >
