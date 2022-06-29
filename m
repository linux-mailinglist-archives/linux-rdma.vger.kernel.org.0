Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAECB560953
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 20:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiF2Sof (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2Soe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 14:44:34 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3CB24BE7
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 11:44:34 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c1so26138817qvi.11
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0UCjZD007QlM4Rkw1tIY/mdObNFKbEJd+O1drBuj5KQ=;
        b=SaSpHw4Xs1mtpOCDVdoS6JlHJHtUJKDFNmdz5YCfv5Pu3+2vBAaB95PN20ck8fL3N3
         /B4Wk2ZlwlYSZ4tzOwZFknNEPqTwcWmeo/tOgQuKsLp4E53LDiSgalgJLU9QtZtQAdBz
         udJMmGr0H9iBhs7KWMum2SzIV8B8j5AByFyeRs2gMJYNQF0lqkob+sq3mVL1ivBRPfOb
         /Ui4TR4sJyba99/x8njMBPxS010We8NstNAUAemr3mYk5ebu3re0J93AeeIYIkX3RyHb
         NNaTo0h0ZTnhJEGYTb8vnpWWjWNjn/OP/kiaXdL4v110EIPckkcRmgaLu/+TaEH1Bc+X
         TiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0UCjZD007QlM4Rkw1tIY/mdObNFKbEJd+O1drBuj5KQ=;
        b=ZRPzDtfrgvNkQz9q1NH6pj5He8GEhUDOD8G5sgwn+emGuxxF1mqCB8dBSP8+l4evSE
         E3EJgwxsAxbQJjAO9nsqGWB0CcMrdFUtxY9hmpSZGgLaetun06ibLelrt/HHK1aA23xo
         NsWoiokft0DeRsbGaNGbyOoo8nIID8Ltx/ZnnkQJZjlqDPRdmdxDoYuTs2NBRy48r95c
         15ZrZXHTbkj8wNAiU+CKWxg3EyYXQBlgqIIv/YMdWZc+cbtgNKSYdYy5/+Y/9J2KlKda
         ay1uc1fb2CJi+Cv3nRJwMwVZl1xha5f+MMaUABHKYwCu+VWrgKoppI+RBb3RaXCP9o0u
         M+Vw==
X-Gm-Message-State: AJIora/I9S7L+kNXrXMKaupGdckQO1SY0L+HlWQ/3KdZ7M98VAMHmzJ/
        HqpASkzqzwFKwV/7Kmhbsnd1oA==
X-Google-Smtp-Source: AGRyM1tptSPKAsOwTe+r9c9Uf0kuZlrCU1i6nZlp3AEuEpoNPWxYldjJVZf8Au5i63ZbzjUCAfBUFw==
X-Received: by 2002:ac8:588f:0:b0:31b:f63e:c901 with SMTP id t15-20020ac8588f000000b0031bf63ec901mr3850664qta.679.1656528273380;
        Wed, 29 Jun 2022 11:44:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id dz8-20020a05620a2b8800b006b141dd9746sm1818713qkb.110.2022.06.29.11.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6cfw-003bqp-Ds; Wed, 29 Jun 2022 15:44:32 -0300
Date:   Wed, 29 Jun 2022 15:44:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Md Haris Iqbal <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare keys according to the
 MR access
Message-ID: <20220629184432.GW23621@ziepe.ca>
References: <20220629164946.521293-1-haris.phnx@gmail.com>
 <20220629183445.GV23621@ziepe.ca>
 <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 29, 2022 at 06:40:07PM +0000, Pearson, Robert B wrote:
> 
> > If the rkey's and lkeys are always the same why do we store them twice in the mr ?
> 
> They are not always the same currently. If you request remote access they are the same if you don't rkey is set to zero.
> You could, of course, check both the keys and the access bits but that is not the way it is written currently.

Storing the rkey instead of checking the flags seems like a weird
obfuscation to me..

Jason
