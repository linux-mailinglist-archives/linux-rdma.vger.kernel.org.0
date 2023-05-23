Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D4370D27C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 05:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjEWDr7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 23:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEWDr5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 23:47:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5834690;
        Mon, 22 May 2023 20:47:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f850b32caso724531166b.3;
        Mon, 22 May 2023 20:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684813674; x=1687405674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGv2tvCAelKMVdl9Jrt7LyVFLT4u3IAhYBxmAvNwueo=;
        b=Xweigfw0hGPVUqUR+g5/hVr0hlcRHPYFAiwsFnf6HPblCdQsSM9CPBBD4X2c9uZNS8
         PmEPu1AYOU8M3s3uiTTUkPOuSNtMX4fJUe9B0LkYGzMcx7WeZE+kraT+WOb1iZW3nGuY
         vDqItGc01Y5Xum1RU6gZIC1lsVq5n2S/fyfJ7fGh8tmVvoll5/PTI+x90uDTSjcY6YXk
         +Q4EBtto3SmoqlNYYAE8J6xOVXN8ayTkyJiVEBzvfIcFKrWqRULvi1scQDLo8fcVaFXW
         KTu5msLGtTtprxLXYXsm16bQglmgeR0liDx7pXASPwZO3srr+4lt68hczSFAMpdoaQRl
         EYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684813674; x=1687405674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGv2tvCAelKMVdl9Jrt7LyVFLT4u3IAhYBxmAvNwueo=;
        b=ZiHyyyJgHOlgtt+sinHlVad27K3wkOSX1C8D9dN1utfOvcxENjV2wM4EMUoj1PYC0B
         dJFQfKP8xEsM05vWONPTuvL1sAQ//uz07gkAzjQNHb1PyDVi27mhHa0n2TmUgKD5okFn
         waGNzSRz9SG/mmBNi11qxx/Me6XO43lsReTkS+URyzaUoilZpe08BbFwKCwbbf9jJjKi
         Rr7cx4jzkX+FVPM+6PLtbX+fc+bt2qU2qWqfRUdMBn9FOechUb3t2+KiwzQM+tEjhToF
         YOGlPdmRgiVS4spOD9OP5JjgnYhohd+YvUk0Qxo4j3zZai6xj2pE6ra3ZGAoolH5QUQ0
         qB7Q==
X-Gm-Message-State: AC+VfDxCWTgedx2H8RmkAcxuT1mEF1A7JuqIMpfw7BJ4nlIedgPFQymx
        YuRcKCUenWeQ+gKaqG3WLF0OATgcQ/2UQyjLhN4xnrnj
X-Google-Smtp-Source: ACHHUZ5ODcCBswm+saEKFLRl9ltHY9z55Y+0jCZ4Nt0J9jSHlFeDjKmTngiXpIGwgp5Wjs1jtvR+edKW0DIxfD8leSw=
X-Received: by 2002:a17:907:3e92:b0:969:e88a:6071 with SMTP id
 hs18-20020a1709073e9200b00969e88a6071mr11627236ejc.61.1684813674454; Mon, 22
 May 2023 20:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a589d005fc52ee2d@google.com> <13528f21-0f36-4fa2-d34f-eecee6720bc1@linux.dev>
In-Reply-To: <13528f21-0f36-4fa2-d34f-eecee6720bc1@linux.dev>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 23 May 2023 11:47:39 +0800
Message-ID: <CAD=hENeCo=-Pk9TWnqxOWP9Pg-JXWk6n6J19gvPo9_h7drROGg@mail.gmail.com>
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 23, 2023 at 10:26=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux=
.dev> wrote:
>
>
>
> On 5/23/23 10:13, syzbot wrote:
> > Hello,
> >
> > syzbot tried to test the proposed patch but the build/boot failed:
> >
> > failed to apply patch:
> > checking file drivers/infiniband/sw/rxe/rxe_qp.c
> > patch: **** unexpected end of file in patch

This is not the root cause. The fix is not good.

Zhu Yanjun

> >
> >
> >
> > Tested on:
> >
> > commit:         56518a60 RDMA/hns: Modify the value of long message lo.=
.
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma=
.git for-rc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Deba589d8f49c7=
3d356da
> > compiler:
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D132bea5a=
280000
> >
>
> Sorry, let me attach the temp patch.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> for-rc
