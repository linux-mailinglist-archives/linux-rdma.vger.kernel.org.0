Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D266E283F
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDNQYj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDNQYj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 12:24:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE226A6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Apr 2023 09:24:37 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id op30so6724285qvb.3
        for <linux-rdma@vger.kernel.org>; Fri, 14 Apr 2023 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681489477; x=1684081477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6sAxG8hJSeNcAXBdsmq88PDCUczAm1wQfR7u1PFJS7A=;
        b=kSnw83++9UtW6krc/xb+iIMhgrW9nPxfXaCUjgGOa4UnTdVSiOpHQ8IM9Ldg8FoHn4
         OmTUTtqc3X6vnJBW4QNVu2DoEJ7/kK1Qn72+nCncb+odayDkgr6A+TMmbZXFSzIHGoKS
         sOjZ+T9c8z13za+hZDlb5c7fgTnAuqoGjH/lit3fr/9mF+WdPqWLx4ZYw6cXFdULOmm8
         1lBcA9RDuRCdUriysBdxqI9031DdUwslMvpbi8Udc6bCp+pAZ91UKYbLAg0/MQqGCwkN
         NKsJH4aN/iS+PqD/aRPZOY8HtLg4zcEle8IjcQh1obfzIMJpwITIhhB+m0JeZ34H6tgS
         SIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681489477; x=1684081477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sAxG8hJSeNcAXBdsmq88PDCUczAm1wQfR7u1PFJS7A=;
        b=ZYjdLrpi5s5ADLukj9W4la6UhSXXhhuDTsz6eBTuqqKrmg3YgrvuxWvb79F8Alo717
         IRffrtKsrIP4CorHW5bTpM8rwEe6umw9PyCIolJoLYgMKg/Q9mBPBq70VJsyXwg3hfu2
         art/87tSHCdycJSKgYPvzwHWyRUfadgKGAUw8DSuy6DIx5exc2QLWw2QKU4zsYDLI9xE
         faJ9bzviHFZJiML4vUI8mkzQ5d7CauXFMT7vuK23x3Sd+KEQWR7AT7P/mdGJix7Mh7ux
         eVl7ZI1qDDjxwd3viSbyOdW3jCJaRl045cJpLEVXo9R+3os3yMw2WqJTriomo8vz5uwc
         qLOA==
X-Gm-Message-State: AAQBX9cdKcUhSIgJDtuA+k74Na5bSxDpOo1z0nDuDAIMVyeJ5KMf5CBT
        FL/EGZO+Ken1ddLGOQcYTijwCKB2D6ffPAPKVHM=
X-Google-Smtp-Source: AKy350aZTPdzzTma2ZFCa7eBUOsOHXFxLiHO3y41Q6RmGnkMXu+h8n0oPdF84B6P+y6UWobda5Rb1/R/hRFL+yUMm1s=
X-Received: by 2002:a05:6214:c6f:b0:5e0:2461:d312 with SMTP id
 t15-20020a0562140c6f00b005e02461d312mr4605685qvj.13.1681489477082; Fri, 14
 Apr 2023 09:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230214060634.427162-1-yanjun.zhu@intel.com> <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev> <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
 <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXDBKiXi5hiaiwYh5_ShqW_EVBfLhwNbk+Yck8V7DQ-fQ@mail.gmail.com>
 <PH0PR12MB5481CA9F5AE04CE5295E7552DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <29e1ed5a-091a-1560-19e5-05c3aefb764b@linux.dev> <CADvaNzWfS5TFQ3b5JyaKFft06ihazadSJ15V3aXvWZh1jp1cCA@mail.gmail.com>
In-Reply-To: <CADvaNzWfS5TFQ3b5JyaKFft06ihazadSJ15V3aXvWZh1jp1cCA@mail.gmail.com>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Fri, 14 Apr 2023 10:24:26 -0600
Message-ID: <CADvaNzUuYK9Z6KdP+x2_qX4vhJ_GV5U1bHsYCqoxxP=MGjfbGw@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net namespace
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Parav Pandit <parav@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Apologies if you get this twice, lindbergh rejected my email for
admittedly legitimate reasons.

>> If you are in exclusive mode rdma devices must be in respective/appropriate net ns.
>
> After applying these commits, rxe works in the exclusive mode.

Yanjun,

Thanks again for the original patch.  It is good for the soft roce
driver to be a "reference" for proper rdma functionality.  What is
still needed for this fix to make it to mainline?

As an aside - is rdma_rxe now good enough for Red Hat to build it by
default again in EL10, or is more work needed?

I'm going to try making the nvme-fabrics set of modules use the
network namespace properly with RoCEv2.  TCP seems to work properly
already, so this should be more of a "port" than real development.
Are you (or anyone else) interested in working on this too?  I'm more
familiar with the video frame buffer area of the kernel, so first I'm
familiarizing myself with how nvme-fabrics works with TCP & netns.

Thanks,
Mark
