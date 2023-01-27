Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656E867EACD
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjA0QY2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 11:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjA0QYW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 11:24:22 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20B483978
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 08:24:18 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d13so4202945qvj.8
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoS/cuefm8gfbXxArI60oCJTttcKlUniDlg8xjjB9DU=;
        b=jeu0trqk+fh8WQahSHmriHaDTJnFdLFEFzd5ebYmkwpc/j6yw3SYqcjfZcAYr2i+/y
         7NReRDnWEayzNtcchg02UOsLFVlM632o4D5L399CIiZp5f8sb1TGPxzEYUmvby4pTbGZ
         dvUotCRSIyXZ8wJnPF241+83nchXGaeLDKN/rMLIsGTPT9/ERHmIh52i7giWbmH50VDM
         +xLpbAbwAhx1iztW0XkIqc5TNJVDNDT9fjVZxSyL7/Eam+We8O7vPRV0SH1Slax/HB7z
         hfqc3ZPVlKDDMVXuJMVawRKievmNq77D2DFF7JKpRrn3/LHcxNlVSw6QmLTPjcHEDFLH
         dRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoS/cuefm8gfbXxArI60oCJTttcKlUniDlg8xjjB9DU=;
        b=vjdX2LcGPCDY6NnXF0ehxGJ58fnSdW0tr5wJQxHqaLmelj32vqw2SgsYDzFcfQOqhJ
         j/wnFZgQ55BDffYNVbzoHfC/wuEqB9X1LYeJ7Hp/WdjJDmY6EmAY/mU72E2rBk8aCMvx
         ay1xQTA+ThEHJIevRWY5BSQbd+/uX80Fu7YWbeYPhtGKFP2nRbuo8i59XqL7MY6kySIC
         QimIyEbBTQmrZhAHHlH45or40/3+PwzBzY8fqkm8f47aYS4FyCaIgD0wJVk9pSvSNEo7
         3wH/zaDVo6/lF59BvFjFkngQCDM4ycKIgQqhMfVGbzvb6yZ0kGKoh8njI/NeGIYrSbRP
         FvEw==
X-Gm-Message-State: AO0yUKUpGywGxp320dsdrGbvxwUxKIV8mKOBc0LIG1siyzqr7muZ2fK8
        zQUksZqKPaK3BvBQ3Npg4LI6JA==
X-Google-Smtp-Source: AK7set/1Tdl3GS7FEIG/w+TOxge3JBF7lxdruz2IVK9AowfGo38RE7zSL0Mb/t3zEdAEMkHkVV3DcA==
X-Received: by 2002:a05:6214:240e:b0:535:666b:b83f with SMTP id fv14-20020a056214240e00b00535666bb83fmr11069668qvb.20.1674836657895;
        Fri, 27 Jan 2023 08:24:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id c202-20020a379ad3000000b0071a02d712b0sm520941qke.99.2023.01.27.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:24:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pLRWS-000C7d-Nd;
        Fri, 27 Jan 2023 12:24:16 -0400
Date:   Fri, 27 Jan 2023 12:24:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: Handle zero length cases correctly
Message-ID: <Y9P6sLy5697JYLTz@ziepe.ca>
References: <20230119190653.6363-1-rpearsonhpe@gmail.com>
 <CAD=hENcdkWchRrvH+KXLXZoaQcZPpnCdV9V9T9mmzkJ13DJKUA@mail.gmail.com>
 <20809b59-0d7f-b6b0-e51c-026a78f07a86@gmail.com>
 <CAD=hENd0HiapsN-iTkAamdy+diFYf4GhP+hnSsfOSwMvMjxY1A@mail.gmail.com>
 <TYCPR01MB8455A47C60CB11ACCB111A2AE5C89@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <eb7ce00d-7fea-7b5e-9af6-b8ebbb5592df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7ce00d-7fea-7b5e-9af6-b8ebbb5592df@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 24, 2023 at 04:03:34PM -0600, Bob Pearson wrote:

> Depending on what Jason does with the xarray based mr change this patch may have to
> be sent in again since it doesn't commute with that patch set. I have a newer version
> that applies after the zarray patches and will send it if they get accepted.

Please post the new version

Jason
