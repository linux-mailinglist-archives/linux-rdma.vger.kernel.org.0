Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDBD7D1127
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377405AbjJTOBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377376AbjJTOBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 10:01:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B17891
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 07:01:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7788ebea620so48578985a.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697810501; x=1698415301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCEwJ3Bm56bdzhQjcrJ8/r1TgXjpUlkUj25pkDayWCs=;
        b=P7cf3MYyVPnc5Hd0pdlmOEkd5mdAMPlw7D4kl6DyDH2XVdQ3S3YvrNhUp37dYbymhJ
         1gv+muX0VojqAT2t+a0cmbnn29n0gsy2Jud/lLSwbLDdWjLAeAeQWMsNgnzS0Uw7fW97
         fQvhp0s2RSNMDfkBvGMEkd4ft8nBbtt650z1bcB+cqwK4UpcxCbT3aUXIeEgIH/8N4YQ
         0rAjphkkkS2Mrm+p8NwwKofro2aWQyDP/QQ4BLSpWqvMbgYM5wN1e0Ye9MwFFC1x7c6a
         OkUoLTXxt+R+s6fsTVAzmTzhDy1OYDMWbIq6DS3mMF3lGXd3sftGQh6rlauIAUWttWE/
         R9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697810501; x=1698415301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCEwJ3Bm56bdzhQjcrJ8/r1TgXjpUlkUj25pkDayWCs=;
        b=O163FBqlsznmfK/75P75UnPysvJAOqo0lQJoqwSrreaxiEvpF1o/gKQnLZi1fKUQdC
         2o92E6chKOsX2gL7fAC/T434BBkAI4J1Lwevw4TtR8iQRvhMHpnBqhQoI5GcNLcq04ja
         O/SY2Yf71jSCdYnwXGjo5mPjOk0K/RD8UxJ7eGZD1uPMvHu3CJkrcjPaoGENrA/Da+DJ
         mEopwUM2l4DE1uFsGlOeytVmjz6G8RRJWqfk6/uIaUcBMw7U3KGvflqyMvFbYPdFvWbT
         FOrOkMSquMYfBlLfY9qTu/rKU9CWwm0QBxRIUWsbkTaiBkNhNlZKPL2qfNr+wrGFI1Ja
         rDXw==
X-Gm-Message-State: AOJu0YwPmqL+/VCZxPupELp1XBfsAS+OeDMQMWNy9P59+XJn3x/pBYWN
        RP6EVlgNRK6JgD2XMp8xg1RmJcY1QFCzD7x+IfCxmQ==
X-Google-Smtp-Source: AGHT+IG9gM3t64H59i84UBr7qIPfNMUG/CQkWx/cnNJ/VNVTb079+O4R5ehvZqZdqESY92LRzekmZw==
X-Received: by 2002:a05:620a:414b:b0:773:b2b1:6f62 with SMTP id k11-20020a05620a414b00b00773b2b16f62mr2210139qko.34.1697810501280;
        Fri, 20 Oct 2023 07:01:41 -0700 (PDT)
Received: from ziepe.ca ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a112b00b007788d2f3d4asm630806qkk.39.2023.10.20.07.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:01:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qtq4J-003JSW-AH;
        Fri, 20 Oct 2023 11:01:39 -0300
Date:   Fri, 20 Oct 2023 11:01:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Message-ID: <20231020140139.GF691768@ziepe.ca>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 20, 2023 at 03:47:05AM +0000, Zhijian Li (Fujitsu) wrote:
> CC Bart
> 
> On 13/10/2023 20:01, Daisuke Matsuda (Fujitsu) wrote:
> > On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
> >> From: Zhu Yanjun<yanjun.zhu@linux.dev>
> >>
> >> The page_size of mr is set in infiniband core originally. In the commit
> >> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
> >> page_size is also set. Sometime this will cause conflict.
> > I appreciate your prompt action, but I do not think this commit deals with
> > the root cause. I agree that the problem lies in rxe driver, but what is wrong
> > with assigning actual page size to ibmr.page_size?
> > 
> > IMO, the problem comes from the device attribute of rxe driver, which is used
> > in ulp/srp layer to calculate the page_size.
> > =====
> > static int srp_add_one(struct ib_device *device)
> > {
> >          struct srp_device *srp_dev;
> >          struct ib_device_attr *attr = &device->attrs;
> > <...>
> >          /*
> >           * Use the smallest page size supported by the HCA, down to a
> >           * minimum of 4096 bytes. We're unlikely to build large sglists
> >           * out of smaller entries.
> >           */
> >          mr_page_shift           = max(12, ffs(attr->page_size_cap) - 1);
> 
> 
> You light me up.
> RXE provides attr.page_size_cap(RXE_PAGE_SIZE_CAP) which means it can support 4K-2G page size

That doesn't seem right even in concept.

I think the multi-size support in the new xarray code does not work
right, just looking at it makes me think it does not work right. It
looks like it can do less than PAGE_SIZE but more than PAGE_SIZE will
explode because kmap_local_page() does only 4K.

If RXE_PAGE_SIZE_CAP == PAGE_SIZE will everything work?

Jason
