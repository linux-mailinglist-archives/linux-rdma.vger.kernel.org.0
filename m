Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944AB79841F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjIHIeg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjIHIee (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 04:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3FF1BEE
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694162022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqeB+pTrr5cAsMJlHRRYIfDbkrEe51St3WRx29ZRt+8=;
        b=fDv1uytGnmibHc3tflS/U1TDfP+POtDroWpHfMoAnnjdAydUCuWJdtCO4ie1z1FTsT1OOd
        TV8moAD7Cw+y3pYzj8XswvHIXa5sHB21J9SshwmCOy+rePP0EddrSjLmxoBbi2z9/tCiF8
        p6c/06mKh7yXSm8+XEbpS6xY8HhcrWc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Fsl4gbNJN2eHw8JBV-7B2A-1; Fri, 08 Sep 2023 04:33:41 -0400
X-MC-Unique: Fsl4gbNJN2eHw8JBV-7B2A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27359a369ceso2310698a91.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 Sep 2023 01:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694162019; x=1694766819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqeB+pTrr5cAsMJlHRRYIfDbkrEe51St3WRx29ZRt+8=;
        b=dylPoRFeAA29HUtlwPI0I+KYoJaT1rFUzWaRLUDfGkJh98CPzza89VdIqdRCCyGr7C
         8xfpOv3FLgrWa9xAAXbCaIUmx5k7JyiJunM5+XRZCZXx+lzLhM1wfoO0J91epoM3DsD7
         nsslPMG8OKU8vMfe+1S8vJ6LwyPuDfJgX1nCQ52bSLgOFvqqVznmlqSYOJ/9yqQR7v2f
         W88T55AJa7wTnhw23rpZu/nCd9FYULk8Edwf/oAmBPOAXg4w0auct5nF9Niqn2n7EF67
         UfLzQ/EATP+9NEip34wnTNbfnD0JUD8JW45GSJ7+Kwb+nUTIngIbHSjb4ng036eEZYuZ
         C6Dg==
X-Gm-Message-State: AOJu0Yy0aYCh0xVHPMTN6OlONTzws4Cp8lKpQcIPp5GKpRzc4EnbRWkD
        Hgpaa9welnlz/dzGi7RAEJeQC0Z6frqrxLl4dNxM/uoftH68F27h+MwTTIsC8kUE0QHhQ23fYda
        bM6KxCVGF21lI6+lVUOtgFj1pnAKV1lMAbp3y1A==
X-Received: by 2002:a17:90b:1958:b0:26b:698f:dda7 with SMTP id nk24-20020a17090b195800b0026b698fdda7mr2020738pjb.32.1694162019274;
        Fri, 08 Sep 2023 01:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnxfmKX2g9vghEPKjgyoluc2e9Bckn2aupy7SigWNAC+otlv3y6h8ZCDlvkcm+fPk0NRQjfhuXPyLiFsMDtEw=
X-Received: by 2002:a17:90b:1958:b0:26b:698f:dda7 with SMTP id
 nk24-20020a17090b195800b0026b698fdda7mr2020727pjb.32.1694162019003; Fri, 08
 Sep 2023 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca> <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca> <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
 <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
 <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com> <a9f6556e-c42b-4be3-819c-06cc302605e7@suse.de>
In-Reply-To: <a9f6556e-c42b-4be3-819c-06cc302605e7@suse.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 8 Sep 2023 16:33:27 +0800
Message-ID: <CAHj4cs97MYvh2DsdaHb+h7XiKNCOHG=ne-88X8CJJ4u1uYB5yw@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during cma_iw_handler
To:     Hannes Reinecke <hare@suse.de>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 8, 2023 at 3:18=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 9/7/23 09:47, Yi Zhang wrote:
> > Seems I reproduced this issue[3] when I run [1] on the latest
> > linux-block/for-next with kernel config[2].
> >
> > [1]nvme_trtype=3Drdma ./check nvme/
> >
> > [2] https://pastebin.com/u9fh7dbX
> >
> But isn't this the same issue as the circular locking discussed earlier?

Sorry, maybe I mixed up the issues here, There are three issues here:

1. "BUG:KASAN: slab-use-after-free at mutex_lock() in
cma_iw_handler()." which Shin'ichiro mentioned in this patch and
triggered by nvme/rdma nvme/030 nvme/031 use siw

2. nvme/tcp circular locking on install_queue which could be fixed by:
https://lore.kernel.org/linux-nvme/20230810132006.129365-1-hare@suse.de/
https://lore.kernel.org/linux-nvme/20230726142939.10062-1-guoqing.jiang@lin=
ux.dev/

3. circular locking at rdma_destroy_id+0x17/0x20 [rdma_cm] which was
already filed last year but still not get one solution:
https://lore.kernel.org/linux-rdma/CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=3DRQ-=
7Jgcf1-6h+2SQ@mail.gmail.com/


>
> Can you check if the patch
> 'nvmet-tcp: avoid circular locking dependency on install_queue()'
> fixes this issue, too?
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>
--
Best Regards,
  Yi Zhang

