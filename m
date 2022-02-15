Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E122C4B6E16
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiBONw6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 08:52:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiBONw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 08:52:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E2D51074D0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644933167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBSGPnudzBrKEXp5NRVGAeF51JTUDG01yqHEiAX39T4=;
        b=GiY4LwhLwZO0T0DorFITrxNTq0iUI2m8o3s+7Jv6ol9tAqM0bDR/7Jg5mAP6sOKbzn7ckK
        n15o56SwyhOMZNLmPuFJCedlL68W5h0rUjSNT4f/kBgYclbtuzR9Zl7i5kDT103xabDafE
        XqcinO1eVX7HYXGOxb2WOTqOeEmCS6s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-Hs9-TUfePSGnBx4i3D7wGw-1; Tue, 15 Feb 2022 08:52:45 -0500
X-MC-Unique: Hs9-TUfePSGnBx4i3D7wGw-1
Received: by mail-pj1-f72.google.com with SMTP id y15-20020a17090a390f00b001b9fde42fd4so2462701pjb.0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 05:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBSGPnudzBrKEXp5NRVGAeF51JTUDG01yqHEiAX39T4=;
        b=75rAsfd6tEeOYxMZQ2iYI+CJXebpZ9c9Qe62vxs+UXA/y0A6VXSiUBUIWigjuJurTq
         glz8ZeqbfcVj5xUW6tUa8gMROuvzEPcszX7kK9Tzo/2frw7my5WafFSYfS0UjietT5YV
         ctTO8JcBf+bFhTYhuASDVSUB43PQV5A3sKDsRnb3oiXRyIP30qF3QW26iT1wr8HBO3NP
         EPRAH7caHKYcgYOusnVfDLXwDT0lDTJ+qr7olD263gWMijFQgRV3S2KwKBTblMrPDhe1
         P03uR7eK2tYFKGMI8Z3T7kR76S/S/nCPR9zyAsn6Nodwz0WQxRtjUzqyIv82zwNf9EMY
         dN2g==
X-Gm-Message-State: AOAM530usXjo16Nw1kL1R9muwLMrJcr2HzkhyxC6lFEJs9G5cWVjpa7I
        xTx6cUSS5bF/Eoz6vTaHntv3oDe7sSdzSdXnN0YxGOK/46oB6ts/z/5wRdfV0kkySIXA4HP8hjg
        nogPLLelmou/qHIGcTED1NqzbX6z5IuOCuYlXFw==
X-Received: by 2002:a17:90a:c28d:: with SMTP id f13mr4426428pjt.163.1644933164641;
        Tue, 15 Feb 2022 05:52:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUuvtMJHu1khNAbVDaMzNWUDumvqg/KOPW0E/a0wLtTfxvHfoBSjUKSKK+z2AuJtw03QwlZqAnzNA/5cphJ48=
X-Received: by 2002:a17:90a:c28d:: with SMTP id f13mr4426400pjt.163.1644933164247;
 Tue, 15 Feb 2022 05:52:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me> <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me> <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com> <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com> <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com> <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com> <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me> <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
In-Reply-To: <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 15 Feb 2022 21:52:32 +0800
Message-ID: <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi/Max

Changing the value to 10 or 15 fixed the timeout issue.
And the reset operation still needs more than 12s on my environment, I
also tried disabling the pi_enable, the reset operation will be back
to 3s, so seems the added 9s was due to the PI enabled code path.

On Mon, Feb 14, 2022 at 8:12 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
> >
> >> Hi Sagi/Max
> >> Here are more findings with the bisect:
> >>
> >> The time for reset operation changed from 3s[1] to 12s[2] after
> >> commit[3], and after commit[4], the reset operation timeout at the
> >> second reset[5], let me know if you need any testing for it, thanks.
> >
> > Does this at least eliminate the timeout?
> > --
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index a162f6c6da6e..60e415078893 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> >  extern unsigned int admin_timeout;
> >  #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
> >
> > -#define NVME_DEFAULT_KATO      5
> > +#define NVME_DEFAULT_KATO      10
> >
> >  #ifdef CONFIG_ARCH_NO_SG_CHAIN
> >  #define  NVME_INLINE_SG_CNT  0
> > --
> >
> or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in
> the connect command
>
> >>
> >> [1]
> >> # time nvme reset /dev/nvme0
> >>
> >> real 0m3.049s
> >> user 0m0.000s
> >> sys 0m0.006s
> >> [2]
> >> # time nvme reset /dev/nvme0
> >>
> >> real 0m12.498s
> >> user 0m0.000s
> >> sys 0m0.006s
> >> [3]
> >> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
> >> Author: Max Gurtovoy <maxg@mellanox.com>
> >> Date:   Tue May 19 17:05:56 2020 +0300
> >>
> >>      nvme-rdma: add metadata/T10-PI support
> >>
> >> [4]
> >> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
> >> Author: Hannes Reinecke <hare@suse.de>
> >> Date:   Fri Apr 16 13:46:20 2021 +0200
> >>
> >>      nvme: sanitize KATO setting-
> >
> > This change effectively changed the keep-alive timeout
> > from 15 to 5 and modified the host to send keepalives every
> > 2.5 seconds instead of 5.
> >
> > I guess that in combination that now it takes longer to
> > create and delete rdma resources (either qps or mrs)
> > it starts to timeout in setups where there are a lot of
> > queues.
>


-- 
Best Regards,
  Yi Zhang

