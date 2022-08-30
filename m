Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AC5A6BD2
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 20:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiH3SKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiH3SKv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 14:10:51 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D4561112
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 11:10:46 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id w4so9090458qvs.4
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=svxxBWRJblo0VikbSjHk387+39adul8vpA4QgEgTU8o=;
        b=cTI66vuXHmWjIMiAkMA7sC7Q7FlTsFGMt5PJu4HM8JQQdcTMFJCusU3+afuRS84vP6
         dr/WzuYCyi3r/BL5OcvP0/NzSRuF/D/rcCXp3VTFYc6bw+gV2gfd51cRPYbrDlvu3VHN
         BOZPwBDiPvd9ewcZMjn7XkzO183S+oQq7/OtY5yqYWTlPD/Zp72up9DYM+EYS9/oKecR
         I2zZxcWDeNq897hdSDLssXvKSl4diBg/9aKef+3FuL8tyGsiv3JvWhIJgXGNsLiGsSlm
         TIMzw5I8pnwixAaqUf5d+mw3ztChkaYdjrErZETozLP+dlxSbP+5hScqpEVOGQ77cIKy
         ZJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=svxxBWRJblo0VikbSjHk387+39adul8vpA4QgEgTU8o=;
        b=EIQAH562f5WBLUyKdZXT2MkomL81w7E3BMLEnP8M1jaCXdt6cUWnsWWWeKdFM9LhRC
         oFSTicmanb10pRhl9QNa4RoDQY4oMDB1zrojfteEOsQPpbJ04Vk8pXnj5aiwe/2uPPuV
         gB/KrsX5UiJa9yU6S81Se2zMkenydO5SOLzrwpseHiS08EKOloJ5xNCLFt2xQO38BMSO
         5UM2DNEgr3Yl5Q4bICkrsPY6qEiynCd2W2cAYZ7R9V3RKBaNN/Kgms6xn/UXMPJWyTYs
         bweObHIRO4jnMjYa6AcSgYQbol9YwzWvUeMvehwNoIR4nmqyIkNArLTLBnycGPUCs3U7
         Fmdw==
X-Gm-Message-State: ACgBeo1Tmb3mlPCX9IX5sOpRHLpVW+L8AE3+i/quWgWqjQF7aWjQiFar
        kJCaRXaoV1YlF9HZhlZ12KRbRQ==
X-Google-Smtp-Source: AA6agR4j27UKtyIaqcF2DpY+BGR+M2qe8VW4jD1mHJqdUtHRpic9UiONh2YWCpTPsHwtyG0PlTjxig==
X-Received: by 2002:ad4:5bc7:0:b0:48b:e9ed:47a8 with SMTP id t7-20020ad45bc7000000b0048be9ed47a8mr16366824qvt.108.1661883045727;
        Tue, 30 Aug 2022 11:10:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r17-20020ae9d611000000b006bb53282393sm8313181qkk.81.2022.08.30.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:10:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oT5hC-003v3y-TQ;
        Tue, 30 Aug 2022 15:10:42 -0300
Date:   Tue, 30 Aug 2022 15:10:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/4] RDMA/srp: Handle dev_set_name() failure
Message-ID: <Yw5SolqHtQU2eh7a@ziepe.ca>
References: <20220825213900.864587-1-bvanassche@acm.org>
 <Yws9t6Xj/08izIdR@unreal>
 <f98c7a98-21e5-817b-df6c-04df777307c2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f98c7a98-21e5-817b-df6c-04df777307c2@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 28, 2022 at 12:50:28PM -0700, Bart Van Assche wrote:
> On 8/28/22 03:04, Leon Romanovsky wrote:
> > On Thu, Aug 25, 2022 at 02:38:56PM -0700, Bart Van Assche wrote:
> > > This patch series includes one patch that handles dev_set_name() failure and
> > > three refactoring patches. Please consider these patches for the next merge
> > > window.
> > 
> > You confuse me. "next merge window" means that patches are targeted to
> > -next, but you added stable@... tag and didn't add any Fixes lines.
> > 
> > I applied everything to rdma-next and removed stable@ tag.
> 
> Hi Leon,
> 
> Although it's not a big deal for this patch series, please do not modify patches
> without agreement from the patch author.
> 
> As far as I know adding a Fixes: tag if a Cc: stable tag is present is not required
> by any document in the Documentation/ directory?
> 
> I had not added a Fixes: tag because the issue fixed by patch 3/3 was introduced
> by the commit that added the ib_srp driver to the kernel tree. So it would be fine
> to backport the first three patches of this series to all older kernel versions to
> which the patches can be backported.

Generally I always want to see the Fixes tag because it aides everyone
in the ecosystem to know when they should consider the patch for
backporting with a simple uniform algorithm.

So marking the first commit as the thing being fixed is expected.

Jason
