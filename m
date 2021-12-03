Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3454671B8
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 06:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355412AbhLCFsR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Dec 2021 00:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231182AbhLCFsR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Dec 2021 00:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638510293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JObZNcaq14I1X6v3JA5gpfRbVqsnF0MHvnfNJ+fO4eM=;
        b=ISPAA6GuHUTejnvkXlRqa1bOeCen+5GM7jZe1ABjT+zeH4rxxJ2NOXQw3lLvEjeo4zNHDn
        M1gtcvTV64HpgRhf9A1ssMID9JF3zQXDS3V5yOvZLj6CQ1Bu/DS3SLm9rZqJNYK6LwbKrY
        XNFGTbn98zooZGheus8ykkPwMUmSgPc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-iY-LT2dBMzi7eZ74DFqMrg-1; Fri, 03 Dec 2021 00:44:51 -0500
X-MC-Unique: iY-LT2dBMzi7eZ74DFqMrg-1
Received: by mail-yb1-f198.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so4295892ybe.21
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 21:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JObZNcaq14I1X6v3JA5gpfRbVqsnF0MHvnfNJ+fO4eM=;
        b=LEi/Wl+b+NpRiUaVw7OZ+cL3rgKrFO48tPpiZXQvTLIjaXPKqj2JBH/nkpAoJV2TVw
         /eiR00OiXsEf0qF7FQ1fs7pnDjRQwNu8CK+8c35rQs+7WejbyuojAe4ZMBolslCr5MnY
         QjOvL8OCnYEcuLy8HAJB+XhtcfMChgbo7nhUkM2SkvKShzVfI2wx2MqV3da25vrxdHVi
         GYAKvJlQrMSDdqOgNNPLeU/F1biYsJ3AQVMPvWdAkykd4eY7TE1v0H5ITNqFHqqncpki
         KVhrgzpXaXmC46A9so51GCttH3SQkHShWGYOAO35GJMfophPMcWltl/R0NoZHKCmX03d
         ERwg==
X-Gm-Message-State: AOAM531MOsNs6sUyIAhKv0WUBps5xiBLX9qiFwkrLcogyjK0+edug4lY
        y4Bmb+TxXmPDvcC2oAyTdoZ4iUOCS3bv35oldn6BIuK0ho3E5jbvfIDlv0qBpU6oQwRcweUWolu
        N9UnWZCeVHWByXIyGWmEjCrUwlHCrKD4NRKnJrw==
X-Received: by 2002:a25:d7c3:: with SMTP id o186mr19928373ybg.104.1638510291096;
        Thu, 02 Dec 2021 21:44:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGCnBdqyHpB9ojg6hXk6rzRVAd5so4zqcXZEQFNGsJoWdXdo8b9xanaAucDlGw5FwqYdwUZ9exqxFfMf2eaMg=
X-Received: by 2002:a25:d7c3:: with SMTP id o186mr19928346ybg.104.1638510290783;
 Thu, 02 Dec 2021 21:44:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
 <8d41da04-717e-8116-c091-83393990dd84@acm.org> <OF4D7FCC28.F58B98B9-ON0025879F.00670323-0025879F.00687303@ibm.com>
In-Reply-To: <OF4D7FCC28.F58B98B9-ON0025879F.00670323-0025879F.00687303@ibm.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 3 Dec 2021 13:44:39 +0800
Message-ID: <CAHj4cs_47Zr0HWJHGyZfuMmVBu-we-OaWNDrASXXv9G_4M62sw@mail.gmail.com>
Subject: Re: Re: [bug report] blktests srp/011 hang at "ib_srpt
 srpt_disconnect_ch_sync:still waiting ..."
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 3, 2021 at 3:01 AM Bernard Metzler <BMT@zurich.ibm.com> wrote:
>
> -----"Bart Van Assche" <bvanassche@acm.org> wrote: -----
>
> >To: "Yi Zhang" <yi.zhang@redhat.com>, "RDMA mailing list"
> ><linux-rdma@vger.kernel.org>
> >From: "Bart Van Assche" <bvanassche@acm.org>
> >Date: 12/02/2021 07:43PM
> >Subject: [EXTERNAL] Re: [bug report] blktests srp/011 hang at
> >"ib_srpt srpt_disconnect_ch_sync:still waiting ..."
> >
> >On 12/1/21 12:55 AM, Yi Zhang wrote:
> >> [root@gigabyte-r120-11 blktests]# use_siw=1 ./check srp/011
> >-------------> hang
> >
> >Hi Yi,
> >
> >Does this only occur with the siw driver or also with the rdma_rxe
> >driver?
> >
> >If this hang occurs with both drivers, how about bisecting this
> >issue? I
> >have not yet run into this issue with the rdma_rxe driver and Linus'
> >master
> >branch.
Hi Bart
This only reproduced with siw.
Maybe it's related to the num of network interfaces, I just found this
issue only can be reproduced when the system has 3(or greater) up
network interfaces, and cannot be reproduced with two up network
interfaces.
And from ps, seems was hang at removing the srpt target:
[root@gigabyte-r120-11 ~]# ps aux | grep rm
root         232  0.0  0.0      0     0 ?        I<   00:20   0:00
[acpi_thermal_pm]
root       10198  0.2  0.0   5240   776 pts/0    D+   00:37   0:00
rmdir /sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/0x1c1b0d9db02f00000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/0x1c1b0d9db03000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/0x1c1b0d9db03100000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/0x1c1b0d9db03200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/0x1c1b0d9db03300000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/0xa0369f79eb2000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/0xa0369f79eb2200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/10.19.240.47
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/10.19.243.129
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/10.19.243.242
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f:fe80:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031:fe80:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db02f00000000000000000000/0x1c1b0d9db02f00000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032:fe80:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/0x1c1b0d9db02f00000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/0x1c1b0d9db03000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/0x1c1b0d9db03100000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/0x1c1b0d9db03200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/0x1c1b0d9db03300000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/0xa0369f79eb2000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/0xa0369f79eb2200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/10.19.240.47
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/10.19.243.129
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/10.19.243.242
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f:fe80:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031:fe80:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03000000000000000000000/0x1c1b0d9db03000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032:fe80:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/0x1c1b0d9db02f00000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/0x1c1b0d9db03000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/0x1c1b0d9db03100000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/0x1c1b0d9db03200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/0x1c1b0d9db03300000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/0xa0369f79eb2000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/0xa0369f79eb2200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/10.19.240.47
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/10.19.243.129
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/10.19.243.242
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f:fe80:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031:fe80:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03100000000000000000000/0x1c1b0d9db03100000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032:fe80:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/0x1c1b0d9db02f00000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/0x1c1b0d9db03000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/0x1c1b0d9db03100000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/0x1c1b0d9db03200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/0x1c1b0d9db03300000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/0xa0369f79eb2000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/0xa0369f79eb2200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/10.19.240.47
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/10.19.243.129
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/10.19.243.242
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f:fe80:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031:fe80:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03200000000000000000000/0x1c1b0d9db03200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032:fe80:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/0x1c1b0d9db02f00000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/0x1c1b0d9db03000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/0x1c1b0d9db03100000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/0x1c1b0d9db03200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/0x1c1b0d9db03300000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/0xa0369f79eb2000000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/0xa0369f79eb2200000000000000000000
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/10.19.240.47
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/10.19.243.129
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/10.19.243.242
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f:fe80:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031:fe80:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0x1c1b0d9db03300000000000000000000/0x1c1b0d9db03300000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032:fe80:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/0x1c1b0d9db02f00000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/0x1c1b0d9db03000000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/0x1c1b0d9db03100000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/0x1c1b0d9db03200000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/0x1c1b0d9db03300000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/0xa0369f79eb2000000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/0xa0369f79eb2200000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/10.19.240.47
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/10.19.243.129
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/10.19.243.242
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f:fe80:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031:fe80:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0xa0369f79eb2000000000000000000000/0xa0369f79eb2000000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032:fe80:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/0x1c1b0d9db02f00000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/0x1c1b0d9db03000000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/0x1c1b0d9db03100000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/0x1c1b0d9db03200000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/0x1c1b0d9db03300000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/0xa0369f79eb2000000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/0xa0369f79eb2200000000000000000000
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/10.19.240.47
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/10.19.243.129
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/10.19.243.242
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b02f:fe80:1e1b:0dff:fe9d:b02f
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b031:fe80:1e1b:0dff:fe9d:b031
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032
/sys/kernel/config/target/srpt/0xa0369f79eb2200000000000000000000/0xa0369f79eb2200000000000000000000/acls/2620:0052:0000:13f0:1e1b:0dff:fe9d:b032:fe80:1e1b:0dff:fe9d:b032

# cat /proc/10198/stack
[<0>] __switch_to+0x150/0x1b0
[<0>] srpt_close_session+0x80/0xe4 [ib_srpt]
[<0>] target_shutdown_sessions+0x128/0x150 [target_core_mod]
[<0>] core_tpg_del_initiator_node_acl+0x7c/0x130 [target_core_mod]
[<0>] target_fabric_nacl_base_release+0x30/0x40 [target_core_mod]
[<0>] config_item_cleanup+0x60/0x160
[<0>] config_item_put+0x6c/0x120
[<0>] configfs_rmdir+0x24c/0x3f0
[<0>] vfs_rmdir+0x8c/0x210
[<0>] do_rmdir+0x174/0x1a0
[<0>] __arm64_sys_unlinkat+0x74/0x90
[<0>] invoke_syscall+0x50/0x120
[<0>] el0_svc_common.constprop.0+0x4c/0x100
[<0>] do_el0_svc+0x34/0xa0
[<0>] el0_svc+0x30/0xd0
[<0>] el0t_64_sync_handler+0xa4/0x130
[<0>] el0t_64_sync+0x1a4/0x1a8


> >
>
> I can't get it broken for siw nor rxe. Though for rxe is see
> quite some
>
> 'ib_srpt receiving failed for ioctx 00000000nnnnnnnn with status 5'
>
> Yi, what is the architecture you are running on?
> Maybe you can try switching on dynamic debugging for the siw module
> and send me the dmesg trace for the hang? Of course it
> will not hang with all the prints ;)

I reproduced it on one aarch64 server, here is the full log with
dynamic siw debug, can you try with one server which has 3 network
interfaces as I mentioned above.
https://pastebin.com/8XMLdeT0


>
> Bernard.
>


-- 
Best Regards,
  Yi Zhang

