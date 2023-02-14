Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818A696882
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 16:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjBNPvI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 10:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjBNPvH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 10:51:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719F10F6;
        Tue, 14 Feb 2023 07:51:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so16113857wrg.13;
        Tue, 14 Feb 2023 07:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzAUyHtfoHuSnIcDKMQpUmStqp8uBg0Ef5hbSbh32Pc=;
        b=M1Jn2v07w8RE5r5b6Kx65c7YeYnFWwStF19DpbwmUBYCvawZakOcHpsuaJ9rh3Uiwa
         rZBRh00UDb+YpTbzYnpgeBRhZk2SQpKcLSmcHPIVnYep1O05Zr5yw9orZfGGB18MKgi6
         01JIPf8tVY6fCKQ0KCr9TVBLinKFpm3ndCMrPOfdAc4S1s/mgdezqyQOrTcFM3iTvWbP
         cGndravD15y78TQFvGKfI2EW+FVuehN9TDtxiu5vihswWzU5Dp26B8uNyWR1wDhgGHXR
         1rbiq2uRWU6MplUCDTlaOEpW3lJP6yYD1cYmIOYReXfZXsyfLY6Hl53IgMtn/Z3myu3z
         jz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzAUyHtfoHuSnIcDKMQpUmStqp8uBg0Ef5hbSbh32Pc=;
        b=PYrVDveSUtQq2iU0MiC/aSeqs/8I381KkG99u4EktwlwJoYI5xzu6qkcfMLC+mRANd
         8QexbiKLJeiAFkQOyivJpLRpyjsZ94/tIpH+SpwG/e9rcWdAxipwY9zlUBKH1T82x9Cj
         HBTmfaebkddCWK+0NGGTHddGblaGnvifusHfIC5VaA5QYfDHnhAD7UobDS4L8lDvhQBk
         mqx3IVXLAQxpJBCIeoBGgdohtzeJyvu7TapMr2fX6MVjXpYZweSW2jlf3Q3a+JMaWVL0
         Tb91balrb6mMMWVN13OoH3u4YHS04N5sD2Z16mf0WbGelF5GkaGEXBeGpgQPZIfKrLvg
         iCcQ==
X-Gm-Message-State: AO0yUKVTQoCiIHnhyzXnsH3L5Qs9Pb3t2m+Tkx6JE+xEyuei3z+CLkM5
        gGxYo4Esnt4L1LZBNdHUsIc=
X-Google-Smtp-Source: AK7set+Et6EXBwEJ4gK6KhDjAWS7SBFOOZDLF5vFM5RbW56sXRp/GXJ3A+Qqlyw/EpF5z+Lm80TbVQ==
X-Received: by 2002:a5d:6652:0:b0:2c5:56f7:51ec with SMTP id f18-20020a5d6652000000b002c556f751ecmr2590115wrw.1.1676389864679;
        Tue, 14 Feb 2023 07:51:04 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b002c559def236sm4681612wrx.57.2023.02.14.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:51:04 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:51:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Steve Wise <larrystevenwise@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb4: potential NULL dereference in
 c4iw_fill_res_cm_id_entry()
Message-ID: <Y+ut5OhZFnIO2JtZ@kadam>
References: <Y+utb9JSKpgAeiWC@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+utb9JSKpgAeiWC@kili>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 14, 2023 at 06:49:03PM +0300, Dan Carpenter wrote:
> This condition needs to match the previous "if (epcp->state == LISTEN) {"
> exactly to avoid a NULL dereference of either "listen_ep" or "ep". The
> problem is that "epcp" has been re-assigned so just testing
> "if (epcp->state == LISTEN) {" a second time is not sufficient.
> 
> Fixes: 116aeb887371 ("iw_cxgb4: provide detailed provider-specific CM_ID information")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> >From static analysis, not from testing.  It's possible that the current
> code works but this change makes it more Obviously Correct[tm].
> 

Oops.  I accidentally sent this twice.  Sorry!

regards,
dan carpenter

