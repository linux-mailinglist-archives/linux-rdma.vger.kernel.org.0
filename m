Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CFB4C7F01
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Mar 2022 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiCAAHG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 19:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCAAHG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 19:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14C848BF54
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 16:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646093182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9r0dAhRjqtyEd4NJeg51OL+Q4X6eROFSL4oCKDCHoLo=;
        b=AJhGcx39BNo7wAPY33gt4XgVqOg4ekPo9DF6kBSkWq0yuf/DYexJMofC1H89x9OZ/VKago
        nzWKqmK+iZg2C2Pmgq2xZHoajDsB3LZPUH/ZAQXkNXyFtk1QO7Af3j8DgKrrsx+xA8ZWwI
        8guYD5wGKCfkoGMy0mP3hkrE2WZEezk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-WbkaHcKAPPa-aeS1gCQgwg-1; Mon, 28 Feb 2022 19:06:20 -0500
X-MC-Unique: WbkaHcKAPPa-aeS1gCQgwg-1
Received: by mail-pf1-f200.google.com with SMTP id a22-20020aa79716000000b004e16e3cc5fcso8600195pfg.11
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 16:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r0dAhRjqtyEd4NJeg51OL+Q4X6eROFSL4oCKDCHoLo=;
        b=AeaMhCM8KM0vKoGOtrdM/6Fx3+u6IBvokiQGTnsmCICE9cRSINSn7rZ2Ruzzflw1PW
         jzIVAe3v6rqaPS2gOt2mT4jPVy/RPPCccTh1HVEq9S/HXWesRD9VyF9GKOP7ZK7iQMGw
         xPsNyu9ZEizvKnmV8zOvV2L6rqlOLKPY9uTAQ3QS0ihuILD3s40HwrwnVXoWojZUvN3r
         13i6vpvb4U8cu2RPRi0KjQcy6xlxZcLiKAeB6HZOmbbzl0vMY3bvfZO+OIBPJfRpFMmg
         C4+WTDx2x9CLuyoLml4tsORNRiG/deAThZdVE/ajvoEcUir55kP/6dOMuFMZ87ofM3WY
         3eOg==
X-Gm-Message-State: AOAM533KDwhmHf0q6KoOVubPQ6BSDdPUix7d16vaA9YzKkfniIXWm4zJ
        XUaAgXR8JNOVVSoWxl7lPMa3aAkgg9Kz38mBcoF7rynn4bO2Qn4XFFROyZYzef0Zq4HJlqhGliX
        wYhtnax96bMUCAbw1Oc+/hiFDo0L2ogzURFOwUA==
X-Received: by 2002:a63:7150:0:b0:372:e0e0:f1a4 with SMTP id b16-20020a637150000000b00372e0e0f1a4mr19272005pgn.507.1646093179410;
        Mon, 28 Feb 2022 16:06:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaVTGdWuPPIH5cmpDafn9OiK/Bs8DFAs+J48mTpKqMyfqZCi565KVv+/qQs09tnHxhA4CsrKSsYiY+qZXPOR8=
X-Received: by 2002:a63:7150:0:b0:372:e0e0:f1a4 with SMTP id
 b16-20020a637150000000b00372e0e0f1a4mr19271978pgn.507.1646093179085; Mon, 28
 Feb 2022 16:06:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com> <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com> <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com> <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com> <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com> <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me> <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com> <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
In-Reply-To: <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 1 Mar 2022 08:06:07 +0800
Message-ID: <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 6:04 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> Hi Yi Zhang,
>
> thanks for testing the patches.
>
> Can you provide more info on the time it took with both kernels ?

Hi Max
Sorry for the late response, here are the test results/dmesg on
debug/non-debug kernel with your patch:
debug kernel: timeout
# time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
real    0m16.956s
user    0m0.000s
sys     0m0.237s
# time nvme reset /dev/nvme0
real    1m33.623s
user    0m0.000s
sys     0m0.024s
# time nvme disconnect-all
real    1m26.640s
user    0m0.000s
sys     0m9.969s

host dmesg:
https://pastebin.com/8T3Lqtkn
target dmesg:
https://pastebin.com/KpFP7xG2

non-debug kernel: no timeout issue, but still 12s for reset, and 8s
for disconnect
host:
# time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn

real    0m4.579s
user    0m0.000s
sys     0m0.004s
# time nvme reset /dev/nvme0

real    0m12.778s
user    0m0.000s
sys     0m0.006s
# time nvme reset /dev/nvme0

real    0m12.793s
user    0m0.000s
sys     0m0.006s
# time nvme reset /dev/nvme0

real    0m12.808s
user    0m0.000s
sys     0m0.006s
# time nvme disconnect-all

real    0m8.348s
user    0m0.000s
sys     0m0.189s

>
> The patches don't intend to decrease this time but re-start the KA in
> early stage - as soon as we create the AQ.
>
> I guess we need to debug it offline.
>
> On 2/21/2022 12:00 PM, Yi Zhang wrote:
> > Hi Max
> >
> > The patch fixed the timeout issue when I use one non-debug kernel,
> > but when I tested on debug kernel with your patches, the timeout still
> > can be triggered with "nvme reset/nvme disconnect-all" operations.
> >
> > On Tue, Feb 15, 2022 at 10:31 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >> Thanks Yi Zhang.
> >>
> >> Few years ago I've sent some patches that were supposed to fix the KA
> >> mechanism but eventually they weren't accepted.
> >>
> >> I haven't tested it since but maybe you can run some tests with it.
> >>
> >> The attached patches are partial and include only rdma transport for
> >> your testing.
> >>
> >> If it work for you we can work on it again and argue for correctness.
> >>
> >> Please don't use the workaround we suggested earlier with these patches.
> >>
> >> -Max.
> >>
> >> On 2/15/2022 3:52 PM, Yi Zhang wrote:
> >>> Hi Sagi/Max
> >>>
> >>> Changing the value to 10 or 15 fixed the timeout issue.
> >>> And the reset operation still needs more than 12s on my environment, I
> >>> also tried disabling the pi_enable, the reset operation will be back
> >>> to 3s, so seems the added 9s was due to the PI enabled code path.
> >>>
> >>> On Mon, Feb 14, 2022 at 8:12 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>> On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
> >>>>>> Hi Sagi/Max
> >>>>>> Here are more findings with the bisect:
> >>>>>>
> >>>>>> The time for reset operation changed from 3s[1] to 12s[2] after
> >>>>>> commit[3], and after commit[4], the reset operation timeout at the
> >>>>>> second reset[5], let me know if you need any testing for it, thanks.
> >>>>> Does this at least eliminate the timeout?
> >>>>> --
> >>>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> >>>>> index a162f6c6da6e..60e415078893 100644
> >>>>> --- a/drivers/nvme/host/nvme.h
> >>>>> +++ b/drivers/nvme/host/nvme.h
> >>>>> @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> >>>>>    extern unsigned int admin_timeout;
> >>>>>    #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
> >>>>>
> >>>>> -#define NVME_DEFAULT_KATO      5
> >>>>> +#define NVME_DEFAULT_KATO      10
> >>>>>
> >>>>>    #ifdef CONFIG_ARCH_NO_SG_CHAIN
> >>>>>    #define  NVME_INLINE_SG_CNT  0
> >>>>> --
> >>>>>
> >>>> or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in
> >>>> the connect command
> >>>>
> >>>>>> [1]
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 0m3.049s
> >>>>>> user 0m0.000s
> >>>>>> sys 0m0.006s
> >>>>>> [2]
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 0m12.498s
> >>>>>> user 0m0.000s
> >>>>>> sys 0m0.006s
> >>>>>> [3]
> >>>>>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
> >>>>>> Author: Max Gurtovoy <maxg@mellanox.com>
> >>>>>> Date:   Tue May 19 17:05:56 2020 +0300
> >>>>>>
> >>>>>>        nvme-rdma: add metadata/T10-PI support
> >>>>>>
> >>>>>> [4]
> >>>>>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
> >>>>>> Author: Hannes Reinecke <hare@suse.de>
> >>>>>> Date:   Fri Apr 16 13:46:20 2021 +0200
> >>>>>>
> >>>>>>        nvme: sanitize KATO setting-
> >>>>> This change effectively changed the keep-alive timeout
> >>>>> from 15 to 5 and modified the host to send keepalives every
> >>>>> 2.5 seconds instead of 5.
> >>>>>
> >>>>> I guess that in combination that now it takes longer to
> >>>>> create and delete rdma resources (either qps or mrs)
> >>>>> it starts to timeout in setups where there are a lot of
> >>>>> queues.
> >
> >
>


-- 
Best Regards,
  Yi Zhang

