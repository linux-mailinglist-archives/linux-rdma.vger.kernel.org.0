Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33E74BE7A0
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Feb 2022 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiBUKkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Feb 2022 05:40:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355263AbiBUKjv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Feb 2022 05:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBFFCBD
        for <linux-rdma@vger.kernel.org>; Mon, 21 Feb 2022 02:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645437653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yq/VFWoQHCTmo0AS/1tH7bEiaRHml5LeaqXeugP1G5A=;
        b=DSg51hvF1ZMw5zXtHY0wnSpv5kePcFKpFY4ibU3YF4vV2iZ2MthXGDvbToNcRj3k+kts13
        UkApBRlrzCuIEyDGxEe2cyXFNviipyeB05LsmmzNNfKQ83dZM1cfBbYMOqyQG/4SDdTAQn
        GeLCTajnkHJsflNzytr9urcq0941kY8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-jefsCZUIM1CQaqTtaI_QGw-1; Mon, 21 Feb 2022 05:00:51 -0500
X-MC-Unique: jefsCZUIM1CQaqTtaI_QGw-1
Received: by mail-pg1-f198.google.com with SMTP id b5-20020a631b05000000b00373bd90134dso6555929pgb.22
        for <linux-rdma@vger.kernel.org>; Mon, 21 Feb 2022 02:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yq/VFWoQHCTmo0AS/1tH7bEiaRHml5LeaqXeugP1G5A=;
        b=Wjv1ZfYDzrqds/x71FmKyZF11rLX0srFOXxC7GLRe7TiuFPO4XAwzEtfMTpvRrqGju
         ieACpUr4BjcjQbbj34PxMSN9q1XY+S6g7BMiBla3sSwSsON9x00aMOJ5WrXC+NdTMg5R
         3thD75/matTRJS+LOppIdeo4TjV14FRBl4EfozXOwITzkBbw6ReAVkjq1vJhWx69RVeN
         nI83/u105MGa3QIwUKOuAiBDsyW4lxrjm8079Zyd5MYN/3X07tOJNs90Jtlohv+COh0l
         4l1JeXzOZHAIV+HrGdJuqotjEHxmf/ucPXtdvpcw+8WV2+uFFfjRR1dzquFOj3h8pqUa
         Fhlw==
X-Gm-Message-State: AOAM532/vpTkDmGirIoN61nII1UmKLjzcN0vFECae6UheJCNtNWzsqAl
        NMVuBUHFwBlbh9xT7ePy/xLVvnvGruXvhCPYXR5cpTBHmFb7LwKGX9EYtCDx6yEt7HSpfi3fhEq
        B9v6bi+F/sJe2u5DeUktfQEKAR2pU0OsBvagslw==
X-Received: by 2002:a65:6246:0:b0:363:396a:a00f with SMTP id q6-20020a656246000000b00363396aa00fmr15347276pgv.28.1645437650678;
        Mon, 21 Feb 2022 02:00:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkLo4UfMKQcebDvyXtITkMIXLAOXsJukx4NbH4EG7ATLniHaXkyNwNpk8T/dZ0Cl7DPZezmLWlUFUMY2CxX14=
X-Received: by 2002:a65:6246:0:b0:363:396a:a00f with SMTP id
 q6-20020a656246000000b00363396aa00fmr15347259pgv.28.1645437650403; Mon, 21
 Feb 2022 02:00:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me> <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com> <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com> <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com> <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com> <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me> <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com> <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
In-Reply-To: <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 21 Feb 2022 18:00:38 +0800
Message-ID: <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Max

The patch fixed the timeout issue when I use one non-debug kernel,
but when I tested on debug kernel with your patches, the timeout still
can be triggered with "nvme reset/nvme disconnect-all" operations.

On Tue, Feb 15, 2022 at 10:31 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> Thanks Yi Zhang.
>
> Few years ago I've sent some patches that were supposed to fix the KA
> mechanism but eventually they weren't accepted.
>
> I haven't tested it since but maybe you can run some tests with it.
>
> The attached patches are partial and include only rdma transport for
> your testing.
>
> If it work for you we can work on it again and argue for correctness.
>
> Please don't use the workaround we suggested earlier with these patches.
>
> -Max.
>
> On 2/15/2022 3:52 PM, Yi Zhang wrote:
> > Hi Sagi/Max
> >
> > Changing the value to 10 or 15 fixed the timeout issue.
> > And the reset operation still needs more than 12s on my environment, I
> > also tried disabling the pi_enable, the reset operation will be back
> > to 3s, so seems the added 9s was due to the PI enabled code path.
> >
> > On Mon, Feb 14, 2022 at 8:12 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
> >>>> Hi Sagi/Max
> >>>> Here are more findings with the bisect:
> >>>>
> >>>> The time for reset operation changed from 3s[1] to 12s[2] after
> >>>> commit[3], and after commit[4], the reset operation timeout at the
> >>>> second reset[5], let me know if you need any testing for it, thanks.
> >>> Does this at least eliminate the timeout?
> >>> --
> >>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> >>> index a162f6c6da6e..60e415078893 100644
> >>> --- a/drivers/nvme/host/nvme.h
> >>> +++ b/drivers/nvme/host/nvme.h
> >>> @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> >>>   extern unsigned int admin_timeout;
> >>>   #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
> >>>
> >>> -#define NVME_DEFAULT_KATO      5
> >>> +#define NVME_DEFAULT_KATO      10
> >>>
> >>>   #ifdef CONFIG_ARCH_NO_SG_CHAIN
> >>>   #define  NVME_INLINE_SG_CNT  0
> >>> --
> >>>
> >> or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in
> >> the connect command
> >>
> >>>> [1]
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m3.049s
> >>>> user 0m0.000s
> >>>> sys 0m0.006s
> >>>> [2]
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m12.498s
> >>>> user 0m0.000s
> >>>> sys 0m0.006s
> >>>> [3]
> >>>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
> >>>> Author: Max Gurtovoy <maxg@mellanox.com>
> >>>> Date:   Tue May 19 17:05:56 2020 +0300
> >>>>
> >>>>       nvme-rdma: add metadata/T10-PI support
> >>>>
> >>>> [4]
> >>>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
> >>>> Author: Hannes Reinecke <hare@suse.de>
> >>>> Date:   Fri Apr 16 13:46:20 2021 +0200
> >>>>
> >>>>       nvme: sanitize KATO setting-
> >>> This change effectively changed the keep-alive timeout
> >>> from 15 to 5 and modified the host to send keepalives every
> >>> 2.5 seconds instead of 5.
> >>>
> >>> I guess that in combination that now it takes longer to
> >>> create and delete rdma resources (either qps or mrs)
> >>> it starts to timeout in setups where there are a lot of
> >>> queues.
> >



-- 
Best Regards,
  Yi Zhang

