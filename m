Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9308E38D386
	for <lists+linux-rdma@lfdr.de>; Sat, 22 May 2021 06:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhEVE3P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 May 2021 00:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhEVE3P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 May 2021 00:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621657671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3iPfp8v43BKfwbs3sPZW9HPPg81McHGYvPwCxny2veU=;
        b=PD2xY9JRHQ9vdsyTmWx/ptyXyjZIWBrnoen7/g/SE2lUC6P6twm1CZPmbNLpoA5uQ/IUFw
        x/Lrwi8jDhO4f4jloltA5cYgks3rhrm0MVHXg6KUj4Fd99LA5NncK/9QNfMsKELCsYsTWj
        0mmbMWBpvXbsnSm593oXOTYVHtOwBnc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-TFlhnpcfNKmqVwMxmplP3A-1; Sat, 22 May 2021 00:27:49 -0400
X-MC-Unique: TFlhnpcfNKmqVwMxmplP3A-1
Received: by mail-yb1-f198.google.com with SMTP id 67-20020a2502460000b0290519eb75af1bso7945062ybc.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 21:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iPfp8v43BKfwbs3sPZW9HPPg81McHGYvPwCxny2veU=;
        b=Ko5JJGD63/v08HTWjPsXWO5xmfjxcoPnip+wsUfBPf/7eDs54aCpc8dvoTW03Ub2yy
         Mc41KPdsMMUHUljiDZNLXNF6p6H5c8t2NAD4RvmakWSsp5VW61zRUIejGu2abcgA/BJ1
         5QGIY39YveW1fAbOJ73hpQTgCxLmNRapDVhLdF8AqbkS94Yl3IoqhAPdCTmgHkp8M48n
         GuV2dFk2dJ1+EySwF24cU9Zsru/fTmgixfA4Klasx+FSUNMISTF73vJIbTr4psEFG5DE
         ddSzkUVEeD5991z3Q65mY3KNZQanEr8wSYy2j6KFrBG6CiuxoKTcfWmdliD1QtDcqZzf
         lQdg==
X-Gm-Message-State: AOAM531NGj7d+b8OEySmkugaPc3w33vm8+EtnTAdUVfW69crLK5Ndn0+
        CgMDP6s3ALshQep5z9fuvSXuJqjB0yHleWDW5xCJgqxkleWJlGOYYIMPpkzz6Py7SUYqBnzR5PC
        4XpnsuQ5E4gLslYLDLE0DqU2ivJgfEVKOBLt16Q==
X-Received: by 2002:a25:ba92:: with SMTP id s18mr21648657ybg.438.1621657668649;
        Fri, 21 May 2021 21:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB9s7qElD6UZO9OFRpEJaHTfHen0r3cGWVOD/6DD7nB5MAyOeymhIT4KqnhtVKoOp40ft4c8L0kLL4JeJY4No=
X-Received: by 2002:a25:ba92:: with SMTP id s18mr21648638ybg.438.1621657668428;
 Fri, 21 May 2021 21:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
In-Reply-To: <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 22 May 2021 12:27:36 +0800
Message-ID: <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 22, 2021 at 2:00 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hi
> > I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
> > help check it?
> > Thanks.
> >
> > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > real 0m10.678s
> > user 0m0.000s
> > sys 0m0.000s
> > $ time echo 1 >/sys/block/nvme0n1/device/reset_controller
> > real 1m11.530s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > target:
> > $ dmesg | grep nvme
> > [  276.891454] nvmet: creating controller 1 for subsystem testnqn for
> > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > [  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > [  287.399317] nvmet: ctrl 1 fatal error occurred!
> > [  348.412672] nvmet: creating controller 1 for subsystem testnqn for
> > NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> >
> > client:
> > $ dmesg | grep nvme
> > [  281.704475] nvme nvme0: creating 40 I/O queues.
> > [  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > [  353.187809] nvme nvme0: I/O 8 QID 0 timeout
> > [  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
> > [  353.226082] nvme nvme0: creating 40 I/O queues.
> > [  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>
> It appears that there is an admin timeout that is either triggered
> by the reset or unrelated.
>
> Can you run nvme reset /dev/nvme0 instead so we can see the "resetting
> controller" print?
>
Yes, here is the log:
------------------------0
+ nvme reset /dev/nvme0
real 0m10.737s
user 0m0.004s
sys 0m0.004s
------------------------1
+ nvme reset /dev/nvme0
real 1m11.335s
user 0m0.002s
sys 0m0.005s

target:
[  934.306016] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
[  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  944.900051] nvmet: ctrl 1 fatal error occurred!
[ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.

client:
[  857.264029] nvme nvme0: resetting controller
[  864.115369] nvme nvme0: creating 40 I/O queues.
[  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  868.001673] nvme nvme0: resetting controller
[  935.396789] nvme nvme0: I/O 9 QID 0 timeout
[  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
[  935.438080] nvme nvme0: creating 40 I/O queues.
[  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.


-- 
Best Regards,
  Yi Zhang

