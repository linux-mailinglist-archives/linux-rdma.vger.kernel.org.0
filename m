Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09153EFA14
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 07:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhHRFbI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 01:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbhHRFbI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 01:31:08 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C7C061764
        for <linux-rdma@vger.kernel.org>; Tue, 17 Aug 2021 22:30:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id w22-20020a056830411600b0048bcf4c6bd9so1345940ott.8
        for <linux-rdma@vger.kernel.org>; Tue, 17 Aug 2021 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQwS2RmRK5/K9FRuvip/E8i6e8PV350rtHh4i/F6PvA=;
        b=RoonnfWNxGg34QJv0EENvNAfskfPF1s676HnRefH3Nm6PTg5JomewiRp546aERrny8
         dMD5DpaIvF8XkaGFNCeds1UMhtQT+k1wivApK/AvbYP7HCnWm3LMkqBMqYBj0mZ3I2st
         vJ1oFpjZJ+Tl7EstNABmcUKKzBc3pt+EL3yhism2W3WQ0TdIyeqaWNAMvMAE+hniUbbl
         h35fe/EZPMizgPG5rutX0uGo8zZUl/S2Rp5JyD7yitadxQvkueM35Em0lBSp+MHodUv2
         5s8MGZlAvgDiI3Efn5jyDVblZQrnd3wMJXcwOl3//h+CyQzMON0yNmoeJC3qUM7a543A
         uePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQwS2RmRK5/K9FRuvip/E8i6e8PV350rtHh4i/F6PvA=;
        b=S7TQEpL+Py+8+OjzUp8fpYdmXW/ecNJZoPjrxOUMQXrD8l07a29IG3spkv+YK5n1c6
         hR7O3GW7DY1wSqS3u7zl9dWHp6TtMVRA+TLv1MQyOBWKYSly9SwqSeUMwSRk9K9TqWvN
         uV4iYuS9rQqSJDesORBCW7ef7D8XJSDpU9jDL1gX7E4M3AJZTvSJnMQmiYW3OOmfeS4e
         iklFQGcoMRLSOdUTPr1mMOpN2e279+1DV6cgKqvvULt95iMmOiEGEzlIXj+NSOaSjAxc
         /szlXl1A7zPIlxJW9lw6h+vu4nZ/Ewv3myce/PpOxQ4olNj6xkyDe60p79N8vu75FENS
         q99w==
X-Gm-Message-State: AOAM531ySf+0fqHuGha36ukH1Stc1CbBi2ZcH0/gqhkqxByCmmgV4k7e
        Kl4Duy8m3MLS37kd7dC3LiSu/Y8gCdkZFEjE0UM=
X-Google-Smtp-Source: ABdhPJznZa9XZ7d0+a5LirBLWlTrL6Cb0569TMrxoLLrvjgXwTyP6ITquN2WTBLDRI8h+12fIDugyQnyiJpz3jZu/rQ=
X-Received: by 2002:a9d:541:: with SMTP id 59mr3749140otw.278.1629264632885;
 Tue, 17 Aug 2021 22:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_M_PJ-7U3QdUxG5=Ce56mBP+WUwko2JqBO6gu_3CqJwQ@mail.gmail.com>
 <CAD=hENeOwY-EgELJox7WkrJEdR-4tTS5VvFULWibxbRSB9OWww@mail.gmail.com>
In-Reply-To: <CAD=hENeOwY-EgELJox7WkrJEdR-4tTS5VvFULWibxbRSB9OWww@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 18 Aug 2021 13:30:21 +0800
Message-ID: <CAD=hENfMKGEJHQvkpDtE4-Z0thT5rK2QuRksoN_O679umhRdEw@mail.gmail.com>
Subject: Re: [bug report] rdma_rxe doesn't work with blktests on 5.14.0-rc6
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-nvme@lists.infradead.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 1:09 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Wed, Aug 18, 2021 at 12:57 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hello
> >
> > I found rdma_rxe doesn't work with blktests on the latest upstream, is
> > it a known issue, feel free to let me know if you need any info/test
> > for it, thanks.
> >
> > # nvme_trtype=rdma ./check nvme/008
> > nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
> >     runtime  0.323s  ...  0.329s
> >     --- tests/nvme/008.out 2021-08-18 00:18:35.380345954 -0400
> >     +++ /root/blktests/results/nodev/nvme/008.out.bad 2021-08-18
> > 00:35:11.126723074 -0400
> >     @@ -1,5 +1,7 @@
> >      Running nvme/008
> >     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >     +Failed to write to /dev/nvme-fabrics: Cannot allocate memory
> >     +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
> >     +cat: /sys/block/n1/uuid: No such file or directory
> >     ...
> >     (Run 'diff -u tests/nvme/008.out
> > /root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)
> >
> >
> > [  981.382774] run blktests nvme/008 at 2021-08-18 00:33:21
> > [  981.470796] rdma_rxe: loaded
> > [  981.474338] infiniband eno1_rxe: set active
> > [  981.474340] infiniband eno1_rxe: added eno1
> > [  981.476737] eno2 speed is unknown, defaulting to 1000
> > [  981.481803] eno2 speed is unknown, defaulting to 1000
> > [  981.486865] eno2 speed is unknown, defaulting to 1000
> > [  981.492862] infiniband eno2_rxe: set down
> > [  981.492864] infiniband eno2_rxe: added eno2
> > [  981.492904] eno2 speed is unknown, defaulting to 1000
> > [  981.497957] eno2 speed is unknown, defaulting to 1000
> > [  981.504338] eno2 speed is unknown, defaulting to 1000
> > [  981.510442] eno3 speed is unknown, defaulting to 1000
> > [  981.515509] eno3 speed is unknown, defaulting to 1000
> > [  981.520580] eno3 speed is unknown, defaulting to 1000
> > [  981.526600] infiniband eno3_rxe: set down
> > [  981.526601] infiniband eno3_rxe: added eno3
> > [  981.526640] eno3 speed is unknown, defaulting to 1000
> > [  981.531693] eno3 speed is unknown, defaulting to 1000
> > [  981.538052] eno2 speed is unknown, defaulting to 1000
> > [  981.543115] eno3 speed is unknown, defaulting to 1000
> > [  981.549088] eno4 speed is unknown, defaulting to 1000
> > [  981.554149] eno4 speed is unknown, defaulting to 1000
> > [  981.559211] eno4 speed is unknown, defaulting to 1000
> > [  981.565201] infiniband eno4_rxe: set down
> > [  981.565203] infiniband eno4_rxe: added eno4
> > [  981.565242] eno4 speed is unknown, defaulting to 1000
> > [  981.570306] eno4 speed is unknown, defaulting to 1000
> > [  981.576724] eno2 speed is unknown, defaulting to 1000
> > [  981.581785] eno3 speed is unknown, defaulting to 1000
> > [  981.586848] eno4 speed is unknown, defaulting to 1000
> > [  981.599312] loop0: detected capacity change from 0 to 2097152
> > [  981.612261] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  981.614215] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
> > [  981.622586] nvmet: creating controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> > [  981.622830] nvme nvme0: creating 32 I/O queues.
> > [  981.634860] nvme nvme0: failed to initialize MR pool sized 128 for
> > QID 32         ----------------------- failed here
>
> Recently a lot of commits are merged into linux upstream, can you let
> us know the kernel version
> on which this problem occurs?

I mean, the earliest kernel version on which this problem occurs.

Zhu Yanjun

>
> Thanks
>
> Zhu Yanjun
>
>
> > [  981.772647] eno2 speed is unknown, defaulting to 1000
> > [  981.641676] nvme nvme0: rdma connection establishment failed (-12)
> > [  981.777715] eno3 speed is unknown, defaulting to 1000
> > [  981.782780] eno4 speed is unknown, defaulting to 1000
> > [  981.799443] rdma_rxe: unloaded
> >
> > --
> > Best Regards,
> >   Yi Zhang
> >
