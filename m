Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFC03FEE42
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbhIBNDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbhIBNDO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 09:03:14 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3BC061757
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 06:02:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c10so1865814qko.11
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UCu55kiJCX6mJViRmr/eENMHpPFVeqIo7LOJv0CLC+4=;
        b=GPYJbsKBPZHk7YRefO5swT16U9j6xnzSPnHDbTB+xcq11Ss+h2as1vkTZWsPPPGISs
         mf/a5FfbnuO50Hxkrh0/pPSjSc6HpWjfJ3lQDDSjn1J2d5DSEXx4G7YNfQ6xAEQTw3aE
         ZuYPDxV4HYoVOt50H0haNwwYrTCfRu6leMuqsc+9skMfyla4yn8/S73ZzL0nSfISko9w
         8N8OSpd0q82sHMrEz10Vv4p3WTJT/gScUEMc04N5augiKoSJby9E9kmWDQq2Q93V3Lkt
         9iCDocMXSaQrUPwRmAPatBvEylLdzXRQ1BgIZeoyj7f+Ro5BK/TX/rcvFEK40ZWDFUqh
         R2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCu55kiJCX6mJViRmr/eENMHpPFVeqIo7LOJv0CLC+4=;
        b=NO8InT95VB1084vpK4NLxdFegcWUUTVGLlhPKJgnfPmLyfj7wBfXwrabwxTlZSa49l
         aIK2CXVeSSpnlOdnnWL2oEociAVAeSkicdVpjMFPInOJ6QE7WxjxPcIlrHjpSAVywhYA
         T4g/OI3rT2TwSgkjfXqfcecK2ohLWCdkigdmM4rTTuoeADii0OCka3ZXVpYig9UZaAz6
         vgKSnQ4+16PHah2t3xlMbmF5S1s5xeiGe6O91HG7JrSrY63KMVfsTkDS4VKx6VlO9jQR
         t+KiaZlY7Z1sRJaiSKR0LhFtJvshgP3pSPQzAZDyz5yyaI9hTIIufRqO7k3ksTEBnRDG
         J58A==
X-Gm-Message-State: AOAM533ZstcjFrReTOlJVTDlA+gTNgT72oLmYOuTekQMN3xoucXJVeEq
        cmbLs6+1NsK63AhsgMARR+iJ5ury7MeO7Q==
X-Google-Smtp-Source: ABdhPJyL2WDSeNZlzKCOWstVlPJ5pP/UeeuwWi6oRpzbxZLiS1OME6ngV6gWTzdqahh99zWnePDm0g==
X-Received: by 2002:a05:620a:15e8:: with SMTP id p8mr3067520qkm.27.1630587735114;
        Thu, 02 Sep 2021 06:02:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j18sm1354866qke.75.2021.09.02.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:02:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mLmM9-00AJnb-CL; Thu, 02 Sep 2021 10:02:13 -0300
Date:   Thu, 2 Sep 2021 10:02:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: rdma link add NAME type rxe netdev IFACE stopped working
Message-ID: <20210902130213.GT1200268@ziepe.ca>
References: <f1c73298-b37f-8589-bdb1-a727c3b7c844@gmail.com>
 <b4a1e866-95ed-7bf1-f9da-bca5700db7e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a1e866-95ed-7bf1-f9da-bca5700db7e1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 01, 2021 at 10:25:25PM -0500, Bob Pearson wrote:
> On 9/1/21 10:04 PM, Bob Pearson wrote:
> > rdma link has started to fail today reporting an error as follows after working before.
> > 
> > bob@ubunto-21:~$ sudo rdma link add rxe0 type rxe netdev enp0s3
> > 
> > error: Invalid argument
> > 
> > bob@ubunto-21:
> > 
> > Nothing has changed in the past day or two except I pulled recent changes into rdma-core. This runs after
> > typing
> > 
> > export LD_LIBRARY_PATH=/home/bob/src/rdma-core/build/lib/:/usr/local/lib:/usr/lib
> > 
> > which is also the same. Any ideas?
> > 
> > Bob
> > 
> 
> Update. I then recompiled the kernel after pulling latest changes
> and now it works. In theory this shouldn't be necessary. The kernel
> APIs should be beckwards compatible.

I don't think anything has changed here in a long time, so I have no
guess

'rdma link' has no relation to rdma-core either

Perhaps your kernel got in a bad state?

Jason
