Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD53B179F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 12:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFWKDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 06:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhFWKDd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 06:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624442476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQR3kWoDpNUY1FDcAA8oN8bLTedbRvN61RpEng3B+UE=;
        b=AgtqrTvj4NnsFFP/SnpRshvP1qVZ0/+KVPjP0D7lzDPpVERi+2K6nUG7T1ks77TQzh1Stf
        Nhw8jWOEPl0unSB/KfEUa5NJYCrjS+yfhFCzkehvI+2yNqeIM/u8ADcIil3FpPN7rVkwoD
        BCslMyBFN9Mb51bQ05krUiOiRbFWWuE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-JHWvGQyWNXeM8CcV_R6UMA-1; Wed, 23 Jun 2021 06:01:14 -0400
X-MC-Unique: JHWvGQyWNXeM8CcV_R6UMA-1
Received: by mail-qk1-f200.google.com with SMTP id t131-20020a37aa890000b02903a9f6c1e8bfso1858642qke.10
        for <linux-rdma@vger.kernel.org>; Wed, 23 Jun 2021 03:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQR3kWoDpNUY1FDcAA8oN8bLTedbRvN61RpEng3B+UE=;
        b=FYN0f3RW1CZN2+r0Wcv4z2skyH76Ws3E5fRViBfEDcGWtRFqUOAkn2as1LXYLMdUV2
         z17zqK/JU9tn7VWjx2WRvgtMPEYFWo8ZtRs6qagDJyny71EKpTdM1hrbClsuKkh5k7wp
         2fDSxaKeWN5F66Oa7jSmQq9gXsyhsfT786C58Wsdrc6ZsR5/41xqI73r8N5kAkcOrH03
         LcIxUopS0NU0uqxeS1ZfhIB7YfZnmOaD3aKzt9jVl+3N4NA/529bMF2aO/ss7iWnDzvG
         9FKuE/2rfEXvrqMsDadMqt2pGr6vDM015HHqebbGSqj8hBHql90em9UHJJfe7jtWrKVe
         hBNA==
X-Gm-Message-State: AOAM531z7gHxm2kI7MBVDT1t7Z3BrSnUwYR5MiUo4iJR1q17SwLCZtOj
        GFni3kLMOMvp2kpR2iH+dUNIzcEDBLB8S1XsV/vqUbWjsgVOm4FFaz6/1C2c9q8GZwbM4DKhz5L
        MAJ1lsBXXWqI0AconOhWqs0om/nlqpUj4fMNTow==
X-Received: by 2002:a25:3d87:: with SMTP id k129mr10932196yba.205.1624442473922;
        Wed, 23 Jun 2021 03:01:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8fNfj6F1w3LldNmDx1Cyu+8eqR0Cir+Zc+au7eaqC0bnW59h79EsFCMVOJxkRMwAFLote6T7IhBVGoDP73LU=
X-Received: by 2002:a25:3d87:: with SMTP id k129mr10932175yba.205.1624442473708;
 Wed, 23 Jun 2021 03:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
In-Reply-To: <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 23 Jun 2021 18:01:00 +0800
Message-ID: <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

Gentle ping here, this issue still exists on latest 5.13-rc7

# time nvme reset /dev/nvme0

real 0m12.636s
user 0m0.002s
sys 0m0.005s
# time nvme reset /dev/nvme0

real 0m12.641s
user 0m0.000s
sys 0m0.007s
# time nvme reset /dev/nvme0

real 1m16.133s
user 0m0.000s
sys 0m0.007s

On Sat, May 22, 2021 at 12:27 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Sat, May 22, 2021 at 2:00 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Hi
> > > I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
> > > help check it?
> > > Thanks.
> > >
> > > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > > real 0m10.678s
> > > user 0m0.000s
> > > sys 0m0.000s
> > > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > > real 1m11.530s
> > > user 0m0.000s
> > > sys 0m0.000s
> > >
> > > target:
> > > $ dmesg | grep nvme
> > > [  276.891454] nvmet: creating controller 1 for subsystem testnqn for
> > > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > > [  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > > [  287.399317] nvmet: ctrl 1 fatal error occurred!
> > > [  348.412672] nvmet: creating controller 1 for subsystem testnqn for
> > > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > >
> > > client:
> > > $ dmesg | grep nvme
> > > [  281.704475] nvme nvme0: creating 40 I/O queues.
> > > [  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > > [  353.187809] nvme nvme0: I/O 8 QID 0 timeout
> > > [  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
> > > [  353.226082] nvme nvme0: creating 40 I/O queues.
> > > [  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >
> > It appears that there is an admin timeout that is either triggered
> > by the reset or unrelated.
> >
> > Can you run nvme reset /dev/nvme0 instead so we can see the "resetting
> > controller" print?
> >
> Yes, here is the log:
> ------------------------0
> + nvme reset /dev/nvme0
> real 0m10.737s
> user 0m0.004s
> sys 0m0.004s
> ------------------------1
> + nvme reset /dev/nvme0
> real 1m11.335s
> user 0m0.002s
> sys 0m0.005s
>
> target:
> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [  944.900051] nvmet: ctrl 1 fatal error occurred!
> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
>
> client:
> [  857.264029] nvme nvme0: resetting controller
> [  864.115369] nvme nvme0: creating 40 I/O queues.
> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [  868.001673] nvme nvme0: resetting controller
> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
> [  935.438080] nvme nvme0: creating 40 I/O queues.
> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>
>
> --
> Best Regards,
>   Yi Zhang

