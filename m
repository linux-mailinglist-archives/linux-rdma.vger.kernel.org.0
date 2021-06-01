Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEEA396E5F
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhFAH6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhFAH6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 03:58:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874D1C061574
        for <linux-rdma@vger.kernel.org>; Tue,  1 Jun 2021 00:57:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l1so20260928ejb.6
        for <linux-rdma@vger.kernel.org>; Tue, 01 Jun 2021 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7nCI4/SzKqn6GRjiFkeoeZzFwp/C5gtw/RgQJDoXHcs=;
        b=LjQpi7hAJTNobr7+wU2h61JTntpFnuCzyAC0FxmDPWu39FTqU3u5beh9x6rE27PRIf
         FX5dMwcvC+f+ESzQRxapnhY12IqagWjOnCS7K7TW+H6NA1mWpAf551L38bGDCDYEB7Ec
         XmI180nvRmxNuculWnsHLnaTpABOklXZ6q75pUzF6EhM29nXMFyl5607Prs1MAgULWWy
         hOiCPeXXu4MzsNoO0pVZIcC76feoVyJUBt+FBiFDLwDbakCTxJ0cFPq25XqPLju951+d
         6rG2+KfthzblLKDueRW5dHtPpa1k3O2U7jgZnhH6bHZ4I8R9LUQi8bQyRYSZkCIbf9n1
         xpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7nCI4/SzKqn6GRjiFkeoeZzFwp/C5gtw/RgQJDoXHcs=;
        b=t7GHwxwvWaM/78rGcEW1PvitPqaGdQRPisbubd+QMjEgvGlNSD6fPYCEYg3tDjHhz5
         xMpceaosf949ZhNpd1hCr+ntw0cpD64aDuOp+3tgn4PDkYDZEi1PcrhW99ppvg/0663/
         EXurA2xW/MOEIIM3a1iteDzVG1VIjqy2WogrYunvgXV7qPfSmYKepZgDMIFrMBd5C2vZ
         pTxL4p1FYtbM+sN+SUh6F5JucYquNvJTzFE6WgNOKDTXyUESxX89CwXgV2MMqleDlN4H
         1er0J4K/8X4jJQmKtbHXZ1DX5GytqcVtg4UpwZKkqLLEzmaaUjuxWl8psIMfB8JIMQsL
         eIRg==
X-Gm-Message-State: AOAM5318n4uxTLEgdSE2Pu4ZS+NdM3MOQYA4qHn0Z/F6skVeOT8NhiAo
        41SZdxGnFz/NFmEMWHt1e+k=
X-Google-Smtp-Source: ABdhPJyg162hz77xTb4EcXsd4h9ZODitz0MKfcdSU9xyRL5hd2d3ZlbYU9C5rv/0NrWRZbyUNM+YSQ==
X-Received: by 2002:a17:906:15c2:: with SMTP id l2mr27369229ejd.348.1622534219180;
        Tue, 01 Jun 2021 00:56:59 -0700 (PDT)
Received: from smtpclient.apple ([2.53.54.8])
        by smtp.gmail.com with ESMTPSA id a7sm7825580edr.15.2021.06.01.00.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 00:56:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   kamal heib <kamalheib1@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
Date:   Tue, 1 Jun 2021 10:56:57 +0300
Message-Id: <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
X-Mailer: iPhone Mail (18E212)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>=20
> =EF=BB=BFOn Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmail.com> w=
rote:
>>=20
>> To avoid the following failure when trying to load the rdma_rxe module
>> while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
>> before trying to create the IPv6 UDP tunnel.
>>=20
>> $ modprobe rdma_rxe
>> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
>=20
> About this problem, this link:
> https://patchwork.kernel.org/project/linux-rdma/patch/20210413234252.12209=
-1-yanjun.zhu@intel.com/
> also tries to solve ipv6 problem.
>=20
> Zhu Yanjun
>=20

Yes, but this patch is fixing the problem more cleanly and I=E2=80=99ve test=
ed it.

Could you please review and ACK this patch?

Thanks,
Kamal


>>=20
>> Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>> ---
>> drivers/infiniband/sw/rxe/rxe_net.c | 14 ++++++++------
>> 1 file changed, 8 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/=
rxe/rxe_net.c
>> index 01662727dca0..f353fc18769f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -617,12 +617,14 @@ static int rxe_net_ipv6_init(void)
>> {
>> #if IS_ENABLED(CONFIG_IPV6)
>>=20
>> -       recv_sockets.sk6 =3D rxe_setup_udp_tunnel(&init_net,
>> -                                               htons(ROCE_V2_UDP_DPORT),=
 true);
>> -       if (IS_ERR(recv_sockets.sk6)) {
>> -               recv_sockets.sk6 =3D NULL;
>> -               pr_err("Failed to create IPv6 UDP tunnel\n");
>> -               return -1;
>> +       if (ipv6_mod_enabled()) {
>> +               recv_sockets.sk6 =3D rxe_setup_udp_tunnel(&init_net,
>> +                                       htons(ROCE_V2_UDP_DPORT), true);
>> +               if (IS_ERR(recv_sockets.sk6)) {
>> +                       recv_sockets.sk6 =3D NULL;
>> +                       pr_err("Failed to create IPv6 UDP tunnel\n");
>> +                       return -1;
>> +               }
>>        }
>> #endif
>>        return 0;
>> --
>> 2.26.3
>>=20
