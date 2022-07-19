Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D385157A35A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiGSPjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiGSPjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 11:39:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757DC5A16A
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 08:39:53 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g1so10686168qki.7
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hOY4CuQZcGE5+DiEJO7y8J3c5vg/AkJQXHGmscUeoYc=;
        b=Em71Qmq9o6LE6CoGPVSgydM0JCQURVbeF7iSLQUMNBLqBxaKNag09j+SPusSdf3Lm7
         yXqtzk3cUnOmK646jIwo2TRZF6aEl23mnzuo7i+KdAjIJ1QBV0jZH7Dqoe+qVhMuAg/Y
         Pr8C5vkAMZB5PkkuvHlN/lvjWLX+PXX+WQ5H6wiw3voPU3sRJQWaepogW2vhlN9YVh53
         NTz4ZiLW8l43K1BSWUAopyOn4uEqZFtNia7RA2oTW4GqXYuCq+agYSjnW0tGc1JEsTje
         SsmRwH+K9L/IAHTkmanimqk3MyqEY+CbL75S1yW9u6yA1Om/Eulc0XSiiP4VsPlLqFhN
         VLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hOY4CuQZcGE5+DiEJO7y8J3c5vg/AkJQXHGmscUeoYc=;
        b=NIwJ9uGhulJl7buK3I6otPuZyoXlQSO5y2aPCcUQ2qpLTFclT8c6mAwvV4EEMMZYRx
         2pMGBGaEqDtiQ+r/i4u5VjZBVHAvehSL2JBozzUrF/kY0Tkgw+I8AMN8f2pqEcqLhJg9
         GhUXBlpbJ2v4Yz+koasceng0GzHopiEyWbfgXfTXFvEhEv0V0c67vrb4K2qBy0tp6taE
         CzOrRsV27RGkJ1Z4BjAguhWTMnOhvCvbZhAOJCI2l4Gg/pq/ZCMF2z2f0j0SbedQ9/hp
         t97fxPDaCJKyH7QF/Njc0P/5XteDLA7O41uiPSXcLMWpV0UX76KvBb51lFGS6Z5v1LdP
         TAuw==
X-Gm-Message-State: AJIora/Xu62srBF0E8OG5zf2DNZuDrpwOrY0DtuWCtz6PjtIq2iHDA6P
        aDs922nA++cQEventJ8oOaDlgw==
X-Google-Smtp-Source: AGRyM1ubY1Snyi4CgyTbowBekYHuXwEbWCTnyMyOed8scTtWtvtdfjS3amI0YoUS7hjIBzl0q4JHlQ==
X-Received: by 2002:a37:b483:0:b0:6b5:8688:5299 with SMTP id d125-20020a37b483000000b006b586885299mr20854022qkf.147.1658245192575;
        Tue, 19 Jul 2022 08:39:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a410800b006b5e533e954sm7453151qko.5.2022.07.19.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:39:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oDpKB-000mo6-AH; Tue, 19 Jul 2022 12:39:51 -0300
Date:   Tue, 19 Jul 2022 12:39:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Message-ID: <20220719153951.GK5049@ziepe.ca>
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
 <20220712090110.GL2338@kadam>
 <20220719125434.GG5049@ziepe.ca>
 <20220719130125.GB2316@kadam>
 <7075158a-64c1-8f69-7de1-9a60ee914f05@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7075158a-64c1-8f69-7de1-9a60ee914f05@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 19, 2022 at 05:36:36PM +0200, Christophe JAILLET wrote:
> Le 19/07/2022 à 15:01, Dan Carpenter a écrit :
> > On Tue, Jul 19, 2022 at 09:54:34AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 12, 2022 at 12:01:10PM +0300, Dan Carpenter wrote:
> > > 
> > > > Best not to use any auto-formatting tools.  They are all bad.
> > > 
> > > Have you tried clang-format? I wouldn't call it bad..
> > 
> > I prefered Christophe's formatting to clang's.  ;)
> 
> checkpatch.pl only gives hints and should not blindly be taken as THE
> reference, but:

Oh, I think alot of people don't agree with that one, I know I don't.

Jason
