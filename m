Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF14B49ED
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 11:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbiBNKCP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 05:02:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbiBNKBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 05:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 921551C13D
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 01:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644832076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2qt3+FoK96nE1glGYDfvHEmytroL36t21/ibFTNEps=;
        b=I3tCx2NzDNA1q6vIs7LOkp2j0mXmFAeGrU/xHQ5uRLC68yPNEZ7NsSULKabC5ywni1SsF4
        dkwcLxbrSo9W43cYZUTK3hMfF86ckJRiISjxKNhkwZF71SOD5RCjNMj6upl2uc0vK0htis
        JR7aKpD+0U+s5lYgjWcPDT7kn63t+RQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-c75S6v5FMK6C5IeyQWz09w-1; Mon, 14 Feb 2022 04:47:55 -0500
X-MC-Unique: c75S6v5FMK6C5IeyQWz09w-1
Received: by mail-pf1-f199.google.com with SMTP id e18-20020aa78252000000b004df7a13daeaso11394123pfn.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 01:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2qt3+FoK96nE1glGYDfvHEmytroL36t21/ibFTNEps=;
        b=eQ9zclF/BTwULF/IJ1TuhtDX+KWZNyYj2tpj5qKPr2PMrUAFwdfzkHWgM/8iP4L/pN
         /KAhqKjJ3863AGGWXCmooaHVS2zRtBcC3k60yqEuMaekpfrUtMfNd65kUp2Ahl0wdtXQ
         XDqfL6rorev0FanU0LHUS/mq1PIiGtqphZ2DBKp5pDbSuImPSaA/3aYIOjOENmBp8GiL
         KWc8CoAnBxRRAfaDhfFaUTtV96xXeEhFCRwPRCw//dRHjgSUKVzc193PHKoTUzow/cmM
         p9+tiBT/W2QrfjFb+DHDbP/Tcoj7yusHRMOGCgmXEG4LRpC47Pc27uxEjA0fSA+6Jf3V
         AvIQ==
X-Gm-Message-State: AOAM530KwBsmIhSuLQkdV5UfrxZ2mj4haz2SGBKefyRoPjGq6EJpLhpD
        P5/TkpfPYIsM45xjwqZiloXgl6JECE8buJpXXjjzRwp3XkvV1bcK/FIzFxzYiYKHbVLgwJeq89V
        UOPpzFaBREqSJE1P5ADxuFO+YFqIyPHlq3n+2Ng==
X-Received: by 2002:a17:90b:4c8e:: with SMTP id my14mr303751pjb.71.1644832073353;
        Mon, 14 Feb 2022 01:47:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQupS/3/0kv1fHvOOXQWpZzGEaHDzvb3gSL3UfrXE+v/ScWqXHLMS34+5bhifcaRICK6lLTkW+L/Vg/M6cE5Q=
X-Received: by 2002:a17:90b:4c8e:: with SMTP id my14mr303737pjb.71.1644832073109;
 Mon, 14 Feb 2022 01:47:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me> <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me> <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me> <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me> <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com> <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com> <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com> <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
In-Reply-To: <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 14 Feb 2022 17:47:40 +0800
Message-ID: <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
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
Here are more findings with the bisect:

The time for reset operation changed from 3s[1] to 12s[2] after
commit[3], and after commit[4], the reset operation timeout at the
second reset[5], let me know if you need any testing for it, thanks.

[1]
# time nvme reset /dev/nvme0

real 0m3.049s
user 0m0.000s
sys 0m0.006s
[2]
# time nvme reset /dev/nvme0

real 0m12.498s
user 0m0.000s
sys 0m0.006s
[3]
commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
Author: Max Gurtovoy <maxg@mellanox.com>
Date:   Tue May 19 17:05:56 2020 +0300

    nvme-rdma: add metadata/T10-PI support

[4]
commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
Author: Hannes Reinecke <hare@suse.de>
Date:   Fri Apr 16 13:46:20 2021 +0200

    nvme: sanitize KATO setting-

[5]
# time nvme reset /dev/nvme0

real 0m12.628s
user 0m0.000s
sys 0m0.006s
# time nvme reset /dev/nvme0

real 1m15.617s
user 0m0.000s
sys 0m0.006s
#dmesg
[ 1866.068377] nvme nvme0: creating 40 I/O queues.
[ 1870.367851] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[ 1870.370949] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.202:4420
[ 1930.981494] nvme nvme0: resetting controller
[ 1939.316131] nvme nvme0: creating 40 I/O queues.
[ 1943.605427] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[ 1953.708327] nvme nvme0: resetting controller
[ 2024.985591] nvme nvme0: I/O 7 QID 0 timeout
[ 2024.990979] nvme nvme0: Property Set error: 881, offset 0x14
[ 2025.031069] nvme nvme0: creating 40 I/O queues.
[ 2029.321798] nvme nvme0: mapped 40/0/0 default/read/poll queues.

