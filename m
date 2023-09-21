Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30887A988C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjIURtz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjIURto (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:49:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCDA59966;
        Thu, 21 Sep 2023 10:20:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso20977861fa.0;
        Thu, 21 Sep 2023 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316832; x=1695921632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DxCGm7i3dYjdPe0Jz5PxJDZuAzH5vpZWnHHkkMyf0=;
        b=P/3AdJUcIJUSZFnqG2WLk7AqI9pyv0n/7dfWF15/ij7K0k5ruTrd8er4oegBOaNJpt
         9kHttLkwTDJido+yFenfFrDahQyfbguwwxHA8SHa6aZxmpgx/RtcrcbthawEGrv/QOfB
         /4bAwz5zZGXHloXhWCOITmEBgf2LmgfZhZWMu1y+rXn9r8cGmr9wgg9nYJH6ZS4DC8Ia
         GpUA1pw7C7PkWVRQZNCHwi6avRcFctxINRIAjmtXW7USLzLKhZvsbAi9wMJYtkOoYtvH
         tnN/nyGLwSSrEFg6UF2/OAzlOmrizNJzWfxc8o6CmRu7hqkbyVmI40RTrg+Xm0AuOfgw
         HX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316832; x=1695921632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DxCGm7i3dYjdPe0Jz5PxJDZuAzH5vpZWnHHkkMyf0=;
        b=pdd0JDrLBVHxcuEHS2hev2W3Z9FIBRADAYpcTjzLMmvG/8ncoalUNMa0B40Zo+qBhv
         SFQLT3PWkFUEUCo3FgB6p+A9wXlm/glm2D90PMEyCtzyatzSYb7nBSA63qiPaekhq70d
         5rw/aCw9JoVxEWh0c+efXgSh6amNFkVk6RxOPDvFuXj2MkS6zwmovL0G5SRchorVYOC2
         ZGH5CtMo8yFEK5VIpwOLAwNZrkKlxoklb28EuTxpKl4wGbLLl8SG9qUXM54GZJrCebgq
         hhIVFFfB0P7ltc4/B4yfWd7l6trbjOZH/LNseUtwQT+lCySVr1ryS8fqLiY3JCtkXb5/
         MKnA==
X-Gm-Message-State: AOJu0YxfrjYB0E070zSUNmAs6/kF1aXv5iJh5321vPTzzxarrbzg3JpW
        vYXInBv4YSXOcX5ptOF3jjZ/b1eP1uVIiggeEQGS+Hf3X8M=
X-Google-Smtp-Source: AGHT+IG4wa4P3EV2VWqYbwr4mrLUiPjm3uQOB/NfeSQg20MaTE2IygaTWD5sEtvOZetepMpVTgGww62MHr5i7tZ8gHQ=
X-Received: by 2002:a1c:6a04:0:b0:405:1baf:cedd with SMTP id
 f4-20020a1c6a04000000b004051bafceddmr4882760wmc.1.1695306222038; Thu, 21 Sep
 2023 07:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com> <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org> <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org> <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev> <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev> <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev> <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org> <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org> <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
In-Reply-To: <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
From:   Rain River <rain.1986.08.12@gmail.com>
Date:   Thu, 21 Sep 2023 22:23:07 +0800
Message-ID: <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 21, 2023 at 2:53=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> On 9/20/23 12:22, Bart Van Assche wrote:
> > On 9/20/23 10:18, Bob Pearson wrote:
> >> But I have also seen the same behavior in the siw driver which is
> >> completely independent.
> >
> > Hmm ... I haven't seen any hangs yet with the siw driver.
>
> I was on Ubuntu 6-9 months ago. Currently I don't see hangs on either.
> >
> >> As mentioned above at the moment Ubuntu is failing rarely. But it used=
 to fail reliably (srp/002 about 75% of the time and srp/011 about 99% of t=
he time.) There haven't been any changes to rxe to explain this.
> >
> > I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueu=
e
> > support for rxe tasks")?
>
> That change happened well before the failures went away. I was seeing fai=
lures at the same rate with tasklets
> and wqs. But after updating Ubuntu and the kernel at some point they all =
went away.

I made tests on the latest Ubuntu with the latest kernel without the
commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
The latest kernel is v6.6-rc2, the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
workqueue support for rxe tasks") is reverted.
I made blktest tests for about 30 times, this problem does not occur.

So I confirm that without this commit, this hang problem does not
occur on Ubuntu without the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
workqueue support for rxe tasks").

Nanthan

>
> >
> > Thanks,
> >
> > Bart.
>
>
