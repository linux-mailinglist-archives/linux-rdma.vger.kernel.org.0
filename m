Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D536E0DE8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDMNBI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDMNBH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 09:01:07 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7D975A
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 06:01:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id eh14so4214850qvb.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681390863; x=1683982863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0Z9I/nBaPKwjrYP3aPlKGTLeJBePRKbY8a7jiglWzw=;
        b=fS2biBM1rohHOyfPyuPrX9uBAXdYqMIcruYiHB+LcBN7/Y6lVrMMQSN3j/RzLBlZ4P
         EvhHS/F0qfD2gVmo/vbaiMbqrmoPrPEysGr0q5zu8lRH/3P1bqF1x5g3BwM8ygjNinT3
         YHmHzJEBtv6vdy0G4x4+jxyWCAP5Aca+NJ8Py6uVAtW/Cylr88ucyzRKlnKrzzIbvpcU
         udKDNViLYXHyoLY8ozV1v1Gpj1H2nEdAwi3zMG4LmeRrKPzoTMDD8heLp2fH9HLgIB3w
         QACMOGbUfa2di/qe9nlQVTirAtd3I6UFuk4gtmTkZPpEpZygv4PhK5mW3ohT+k5fbSX0
         saXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390863; x=1683982863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0Z9I/nBaPKwjrYP3aPlKGTLeJBePRKbY8a7jiglWzw=;
        b=QnPZ7YpoHgV/KghadawGdeGgEkODjOBNTARs0Gf1L8rZY7YHCuLfDmuC6t5lPP11+n
         uPu9+b66lyDiTvdoxejwYaVypTe2P220xCCg2lx4ay+AC1kjUkQYjW74Sb4R4OTwLX8O
         QElJ7cQWh1Wc+9sT/Og355b1wF7ULm2kKhdeEh3ZVdRXbc1Wvb0SGGprOzvL2oNLvkC+
         tKjymkDL4aOMcV3mk2z5d384FPUcxwXB6PDIn/sZbx+Kx0Ia4fTzVKK6bvfNkcFEkqyZ
         YQ7Hp+iuTSGu7DaZ7Yh0EL1qzg8AuOgHfSYfD1Yew/05+0kT+Cf6fRNTp7o6/2o+kRi+
         mYpg==
X-Gm-Message-State: AAQBX9flnpmix75lzSFNS2niSPR1Bau8AaPB9HYyBo63wja7lhEQfdOT
        V95bOARq9ucA0BeUAatuzc3m7U1pt9EMfUvrQDw=
X-Google-Smtp-Source: AKy350aT1uxeu3VjETYMskfBU06YRcv3WmR0Wmpwq05wAcxiTf/YkvgIau5skttAiUxiP00QpoXHApr6J3yym4sR71c=
X-Received: by 2002:ad4:4b64:0:b0:5ef:51c4:3f05 with SMTP id
 m4-20020ad44b64000000b005ef51c43f05mr215768qvx.4.1681390863221; Thu, 13 Apr
 2023 06:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230214060634.427162-1-yanjun.zhu@intel.com> <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com> <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
In-Reply-To: <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Thu, 13 Apr 2023 13:00:50 +0000
Message-ID: <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net namespace
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, jgg@ziepe.ca, leon@kernel.org,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Do you make tests nvme + mlx5 + net ns in your host? Can it work?

Sort of, but not really.  In our last test, we configured a virtual
function and put it in the netns context, but also configured a
physical function outside the netns context.  TCP NVMe connections
always used the correct interface.

However, the RoCEv2 NVMe connection always used the physical function,
regardless of the user space netns context of the nvme-cli process.
When we ran "ip link set <physical function> down" the RoCEv2 NVMe
connections stopped working, but TCP NVMe connections were fine.
We'll be doing more tests today to make sure we're not doing something
wrong.

Thanks,
Mark




On Thu, Apr 13, 2023 at 7:22=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2023/4/13 5:01, Mark Lehrer =E5=86=99=E9=81=93:
> >> the fabrics device and writing the host NQN etc.  Is there an easy way
> >> to prove that rdma_resolve_addr is working from userland?
> > Actually I meant "is there a way to prove that the kernel
> > rdma_resolve_addr() works with netns?"
>
> I think rdma_resolve_addr can work with netns because rdma on mlx5 can
> work well with netns.
>
> I do not delve into the source code. But IMO, this function should be
> used in rdma on mlx5.
>
> >
> > It seems like this is the real problem.  If we run commands like nvme
> > discover & nvme connect within the netns context, the system will use
> > the non-netns IP & RDMA stacks to connect.  As an aside - this seems
> > like it would be a major security issue for container systems, doesn't
> > it?
>
> Do you make tests nvme + mlx5 + net ns in your host? Can it work?
>
> Thanks
>
> Zhu Yanjun
>
> >
> > I'll investigate to see if the fabrics module & nvme-cli have a way to
> > set and use the proper netns context.
> >
> > Thanks,
> > Mark
