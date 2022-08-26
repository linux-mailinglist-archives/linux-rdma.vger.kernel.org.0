Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0461A5A28B8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbiHZNiC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344244AbiHZNiB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 09:38:01 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4350DCFC9
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 06:37:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e28so1239742qts.1
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vjjGUrRaJpldyM8ULFW4UXIjKO3b9o+e5HQfHfkGqHw=;
        b=LcB/E2x6vJB1gai+4FDvzf9W+kwcKi79/arVAKkVe1NemvUr2FIq0uayWKLaNOLW4V
         oKXEOx0IIBUJkrNtMB1X6X3LKXANeWTNA6bsRpCU6J+WMazXovsZ32M0Qc3e8kbCnDVk
         IPlIhh7snBsHOlhaoBK/NCsJGr+HBqLXWTy/MiiurYDyHyyCLyc++78C/bwA3PEyv1ar
         jibk6si8E1MjKezJ1eSd7BuvexlocEGu8SWPE8s5y3wLhCxcta6IxVI7hntqoAJbFnef
         KsbfAmfQ53DUSfRW1U/8/jhdYDnR5BHpYs1p+grqoIl+yUNvxC8lCbiJSbEyCtpHY0FA
         qrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vjjGUrRaJpldyM8ULFW4UXIjKO3b9o+e5HQfHfkGqHw=;
        b=Szj9+1hYudwJbQDRghD4bGHTONUP/DZ/XFYIPWka28j8VbP+xV5JyzO5Ckeb4wHV/P
         NDIWejjFfxwnonrrwpmJwUoQcXNnp9AZMwkA+1eveHzVoM10rc/XLeUNHX/Dn9/hIhtV
         IhlLofTbn1HWiTM6293NNEN7/wR0CSFH7yTqIZDa809iySTyTT4ppOTyuXbI6NtYqyCa
         1tWhKxb2yx5maljPRoQ1DlxnjJ7OcQ+HU/GZHzhH271aO7MADAMDHeW3sxlgalWed1kP
         HfWQYq/d+JBMmCr3mXH5On5KprBj59tICmDieYdwR+JNP71Lh4SHw+IywvJc2b1yMxR9
         KiEA==
X-Gm-Message-State: ACgBeo182Q8yDXXeHAMF1liUurHQFR0B0P/bhssQZ4ikMabN2/qzRDC4
        H3dSAytg7QJOfd6OLYsILEe3CQ==
X-Google-Smtp-Source: AA6agR4hxjJ7gmu+g0QGWHOhKtVxBAMWENHdm5kbwM2lbDnSH7b3b0P5o41Ehxnz+yCJzxoGRRA63Q==
X-Received: by 2002:ac8:5853:0:b0:343:7b95:96ff with SMTP id h19-20020ac85853000000b003437b9596ffmr8047722qth.386.1661521077865;
        Fri, 26 Aug 2022 06:37:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id m1-20020a05620a290100b006bb2cd2f6d1sm1780898qkp.127.2022.08.26.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 06:37:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oRZX1-000Oh2-PZ;
        Fri, 26 Aug 2022 10:37:55 -0300
Date:   Fri, 26 Aug 2022 10:37:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>, tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        Wenpeng Liang <liangwenpeng@huawei.com>
Subject: Re: [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
Message-ID: <YwjMs4wKm7CHzTuf@ziepe.ca>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 05, 2022 at 07:46:13AM +0000, Li Zhijian wrote:
> Hey folks,
> 
> It's been a long time since the 3rd, in the meantime, some RXE regressions have
> been fixed by comminity. So It'd like to post my 4th version. feedbacks are
> very welcome :).

I think enough work is done to start going forward with new features

Are there any comments on this series?

Jason
