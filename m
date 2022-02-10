Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06414B1810
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 23:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbiBJWXV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 17:23:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbiBJWXV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 17:23:21 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3482188
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 14:23:17 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e140so434170ybh.9
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OcU1WRz0rHV14DjvNIKcFjBgJhw/4l/GjcD5YxfoD+M=;
        b=IbYvEV1cBVJQ4158GE4mzG0Offp6kDoKSLlEjlxVPk2zjlsH+iPTljiCurxbYlJUJE
         ksEJdFUD9wdcz4zFifZYenTG0474lMKX5N20w8zZ6FRHBzIbQi6LeXddJrm1QogUXgjB
         x4/N4v7ZO7wpb35g3NAER5NKLgraP3bXvAAiA6+3Jff1L39HYVzT/mrKLDhNjCVUi7Ms
         r5YJcblM+xQG4BVXHcgh+M+DMSIJ34EUOSPbcrxljVr64h7CxkgLiZ+d7wTM/JhfVRof
         amc9baiPaAPQgYO58ShCGIIHAxKmXB+ahyVzuiQmPAovo1BBVB2sC7AR+6gZ0FGmr20S
         9Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OcU1WRz0rHV14DjvNIKcFjBgJhw/4l/GjcD5YxfoD+M=;
        b=D1TOl0MwxmbAKpQ/WJvCw4HIys+uZicfgL4r+//JMFJjUalX+OaQL7qA382AdSTXFB
         crwVSktStFITrfimAGusHuwF45TTtfd+3Cr7dWAVkCIIK3PCe6BvuJPdV/VUd7wsImPy
         nElv1p7DFIjfaA8S6y7HrKpSAk3/i3hszapQMYOkb13LEa2Vu4faBWW76e+woKzoEvve
         SR2EyTL92uqX3vPge2EW0q73FwUrVMkWu6NKqJwLqYDuo3UAuKgt5WBuE7ULEdejGrWL
         NCwVzAK3bce/gGXSJS1N/8PpL8DhoAWHWO+EUMirfIrxtHq4pTO7r1yCH/ki3Cum4c1h
         t9BA==
X-Gm-Message-State: AOAM532+CXUo1qf0zWRwo8wqo4sjL2GkIj9LHscQtMoZQNkt/9FSrOU2
        1XfJ/Wb99Q/1LcpkS7Cx2UF7AHR7IMzHGMpLhVP0NDWJ
X-Google-Smtp-Source: ABdhPJw+aCj/tlbv75sBCz1mnzIQLo5IHDflvYfzyS43FBfKmEP6CA6TXXAaWdEL5kENa7MYRt3w/uri9OnQilkE0so=
X-Received: by 2002:a25:ae68:: with SMTP id g40mr9574572ybe.350.1644531796652;
 Thu, 10 Feb 2022 14:23:16 -0800 (PST)
MIME-Version: 1.0
References: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
 <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <11e71fc4-6194-9290-df0e-f062af91cc8c@linux.dev>
In-Reply-To: <11e71fc4-6194-9290-df0e-f062af91cc8c@linux.dev>
From:   Christian Blume <chr.blume@gmail.com>
Date:   Fri, 11 Feb 2022 11:23:05 +1300
Message-ID: <CAGP7Hd7h7Z0mfrhUeHcO3ZAVnMd52Go0ihOvO792RCM_tyDh-g@mail.gmail.com>
Subject: Re: Soft-RoCE performance
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

Thanks for clarifying! I am looking forward to testing larger MTUs
with the new functionality!

Cheers,
Christian

On Fri, Feb 11, 2022 at 3:04 AM Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>
> =E5=9C=A8 2022/2/10 13:13, Pearson, Robert B =E5=86=99=E9=81=93:
> > Christian,
> >
> > There are two key differences between TCP and soft RoCE. Most important=
ly TCP can use a 64KiB MTU which is fragmented by TSO or GSO if your NIC do=
esn't support TSO while soft RoCE is limited by the protocol to a 4KiB payl=
oad. With overhead for headers you need a link MTU of about 4096+256. If yo=
ur application is going between soft RoCE and hard RoCE you have to live wi=
th this limit and compute ICRC on each packet. Checking is optional since R=
oCE packets have a crc32 checksum from ethernet. If you are using soft RoCE=
 to soft RoCE you can ignore both ICRC calculations and with a patch increa=
se the MTU above 4KiB. I have measured write performance up to around 35 GB=
/s
>
> Thanks, I have also reached the big bandwidth with the same methods.
> How about latency of soft roce?
>
> Zhu Yanjun
>
>
> in local loopback on a single 12 core box (AMD 3900x) using 12 IO
> threads, 16KB MTU, and ICRC disabled for 1MB messages. This is on head
> of tree with some patches not yet upstream.
> >
> > Bob Pearson
> > rpearsonhpe@gmail.com
> > rpearson@hpe.com
> >
> >
> > -----Original Message-----
> > From: Christian Blume <chr.blume@gmail.com>
> > Sent: Wednesday, February 9, 2022 9:34 PM
> > To: RDMA mailing list <linux-rdma@vger.kernel.org>
> > Subject: Soft-RoCE performance
> >
> > Hello!
> >
> > I am seeing that Soft-RoCE has much lower throughput than TCP. Is that =
expected? If not, are there typical config parameters I can fiddle with?
> >
> > When running iperf I am getting around 300MB/s whereas it's only around=
 100MB/s using ib_write_bw from perftests.
> >
> > This is between two machines running Ubuntu20.04 with the 5.11 kernel.
> >
> > Cheers,
> > Christian
>
