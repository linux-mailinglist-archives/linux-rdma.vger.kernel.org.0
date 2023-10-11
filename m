Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FE7C46C2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 02:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjJKAeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 20:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344336AbjJKAeX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 20:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0CF8E
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 17:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696984416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaJBo428ZUy3fj7afO1E6n1PG/j2MHC964fehV0oms8=;
        b=gqM/4JLE3IGKE44iE5ArgluEro6ZJTPKXmoYgzinL0WZ+9T2IgY/DFv+C5MGAVpusCh+ag
        yEz//Q8th+oXBmmNcOQj3rSh12Gnx7/ai7hmUQQMWlPmdnOOgJVqbvuyuJq1uBMUw+m67B
        3J3/Craan6WB0y4yHXKtKzudF2/VUvU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-7wlZnJENMIKb2_e0_DOa6Q-1; Tue, 10 Oct 2023 20:33:34 -0400
X-MC-Unique: 7wlZnJENMIKb2_e0_DOa6Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27cf1a54fafso904317a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 17:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696984414; x=1697589214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaJBo428ZUy3fj7afO1E6n1PG/j2MHC964fehV0oms8=;
        b=ix7cs6WpFuXn4VpR41dSFy+se1imbcNj5nEvapg4VX99BniOiISaMS9Yul5Z6LjJO2
         bAsTbKNHD/1p3/Qm+P96nLFz9KWWmrqbSneY6K0O+tqqtB1zCTXeaZ7Kj3fWNXsExa6i
         H5vFTyVn9rC5FIjeaXMXf+Chqi9ErrRl45fMbOPuZkDDXJpnOv2wMMeiZyFLIcNIAc6r
         YgCS+zmN3E6/KnmVTzke9VpakzKjLJA2+TqQmSF79qaZCsfJK1RPS3493HTftS2b6Bro
         6zGgukA9s16W5rqItd5F4ukP4rvSAL9bjMTOg89SRxd0ocQIKbZQZ0Sg9+nx1WSJBWKz
         FlkA==
X-Gm-Message-State: AOJu0YyTjkh8mkhahzNBuyeNp9dgVLJCkue6VgyQBiyNyJ+QZxJ3asJc
        n4HVoNFrxuAEmPhgr+oI+rmNvwPYBKrxhy3R+Hl84KQGDZ7vlXf0t/JBCgRKFq+OQfprAXuvBin
        Vdbazm1oto9aY/f/gfNlzSP3gGAxaIV5SA00KtA==
X-Received: by 2002:a17:90b:fc6:b0:27c:edd5:6137 with SMTP id gd6-20020a17090b0fc600b0027cedd56137mr3056246pjb.25.1696984413798;
        Tue, 10 Oct 2023 17:33:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3DpFZmNsguyzer/PzjEv+/4jzFSws6Y4mDYjrfvrzIAiMgkT6+e7WG1/JhClId+fFehfYOq/LeE7JV4x8f9I=
X-Received: by 2002:a17:90b:fc6:b0:27c:edd5:6137 with SMTP id
 gd6-20020a17090b0fc600b0027cedd56137mr3056229pjb.25.1696984413368; Tue, 10
 Oct 2023 17:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8hVFz=3OkVBrfZ3PCHU3fWN=+GpH40PvAs49CZ3-pJvg@mail.gmail.com>
 <54acca3e-ef7b-40be-867f-061544197557@linux.dev> <20231010113542.GH3952@nvidia.com>
 <d2f41bf8-45dc-4937-a3a9-b05d422499cf@linux.dev>
In-Reply-To: <d2f41bf8-45dc-4937-a3a9-b05d422499cf@linux.dev>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 11 Oct 2023 08:33:21 +0800
Message-ID: <CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com>
Subject: Re: [bug report][bisected] rdma_rxe: blktests srp lead kernel panic
 with 64k page size
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Robert Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 10, 2023 at 9:37=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2023/10/10 19:35, Jason Gunthorpe =E5=86=99=E9=81=93:
> > On Tue, Oct 10, 2023 at 06:41:17PM +0800, Zhu Yanjun wrote:
> >> =E5=9C=A8 2023/10/9 12:35, Yi Zhang =E5=86=99=E9=81=93:
> >>> Hello
> >>>
> >>> blktests srp lead kernel panic[2] on aarch64 when the kernel enabled
> >>> CONFIG_ARM64_64K_PAGES, bisect shows it was introduced from commit[1]=
,
> >>> pls help check it and let me know if you need any info/testing for it=
, thanks.
> >>>
> >>> [1]
> >>> commit 325a7eb85199ec9c5b5a7af812f43ea16b735569
> >>> Author: Bob Pearson <rpearsonhpe@gmail.com>
> >>> Date:   Thu Jan 19 17:59:36 2023 -0600
> >>>
> >>>       RDMA/rxe: Cleanup page variables in rxe_mr.c
> >>>
> >>>       Cleanup usage of mr->page_shift and mr->page_mask and introduce
> >>>       an extractor for mr->ibmr.page_size. Normal usage in the kernel
> >>>       has page_mask masking out offset in page rather than masking ou=
t
> >>>       the page number. The rxe driver had reversed that which was con=
fusing.
> >>>       Implicitly there can be a per mr page_size which was not unifor=
mly
> >>>       supported.
> >>>
> >>>       Link: https://lore.kernel.org/r/20230119235936.19728-6-rpearson=
hpe@gmail.com
> >>>       Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>       Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >>>
> >> Hi, Yi
> >>
> >> I delved into the commit. And the commit can not be reverted cleanly. =
So I
> >> made the following diff to try to revert this commit. After this commi=
t is
> >> applied, rping can work well.

Hi Yanjun

With the change, the blktests srp works now.

> > We can't keep reverting things for what are probably small bugs. Fix
> > the issues please!
>
>
> This is not an official commit. Because the reporter mentioned that the
> commit causes this problem,
>
> we just confirmed that. If we confirmed that this commit is the root
> cause, we will analyze this commit,
>
> then fix it.
>
> Zhu Yanjun
>
>
> >
> > Jason
>

--
Best Regards,
  Yi Zhang

