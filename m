Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80B63BB76
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Nov 2022 09:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiK2IZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Nov 2022 03:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiK2IZu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Nov 2022 03:25:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709C25655D
        for <linux-rdma@vger.kernel.org>; Tue, 29 Nov 2022 00:25:49 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l11so18744870edb.4
        for <linux-rdma@vger.kernel.org>; Tue, 29 Nov 2022 00:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZUenHtKPq2dIPRKUI4YkE7MjW2g3QtOJmpKI+2Qn3o=;
        b=gGK456z2WRLaCXHOwMFdHGvfFgJhaWZsmslL7bufWhOQ0Q3qvX2aDgMOi2ja03RCnm
         NdGvjr2n7dxWMSrxhGxBdIDl2jZOfrD+2k5vRWjBh5RgWepcfx9WRx+rVxCdxMmtSCqd
         RP5hOThgGUF9OdBm1kFhEu9uyjFMq+6Q85Jk+ZycXXoZpEz8zRoxJtLtFqJ8+ncqgmhm
         4wc2jc5c5JUviaUDl6qOKs8yb5XJn9HImWIJkxqXQPGYXgq9hGuxNfpbERnf/C8bffkT
         ML/3rEOdCUgRGrRo5SkoyK/r5egDu0LQAvOSnhyiAZR2pCv3GOE3KrvNcIuwQQNDcWF6
         6mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZUenHtKPq2dIPRKUI4YkE7MjW2g3QtOJmpKI+2Qn3o=;
        b=n7ocqVYDPeUrRjhzqSIFLeQuNkJZv3n8AJSrH+DGquu2WIkzb+oTtEizuTiDXWA5rw
         vWY08dIM0POmaZQxcSXB6OqEp49uGtstR015Mk1QH49Yh2T3Jq+64dhuoyV1bxNJ/D2/
         YVEi+FThtRYMLnaTRqSqxRQjFK0BgWvFyooLS68+0XR6S2pYvMIoHLImkF5DA35KtpD8
         W9h4yTF+6K35nMqjMK7xO9+d6TwodmbEI1EhSF962yyhXozFMZ4fUlfHNa4W5gluc3G/
         WjS3uP5dtW4pGCr5HmK+Rw1fYAHWnWmQupsqvLORorf317mdGoG8q7i7xz2JWToHRwFK
         xB1w==
X-Gm-Message-State: ANoB5pnu4cIclo8xT3YTJbRvczlTtamGJH7bKBx1FzCRL9luK0dxRFnw
        SeRed3kLPY5ZY0b9DBoHEw5tYg==
X-Google-Smtp-Source: AA0mqf7oggbm0ZvKv+OkUU5+fbdLpbPP1G+n+KZSETJmKURydZSHzYM/yx9a/+JnxN4LXSIHKdvoZQ==
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id t33-20020a056402242100b00461524fa8f4mr50312403eda.260.1669710347875;
        Tue, 29 Nov 2022 00:25:47 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402065700b0046778ce5fdfsm5962890edx.10.2022.11.29.00.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:25:47 -0800 (PST)
Date:   Tue, 29 Nov 2022 09:25:46 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Taras Chornyi <tchornyi@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Shannon Nelson <snelson@pensando.io>, drivers@pensando.io,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Vadim Fedorenko <vadfed@fb.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Shalom Toledo <shalomt@mellanox.com>,
        linux-crypto@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
        Jiri Pirko <jiri@mellanox.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hao Chen <chenhao288@hisilicon.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Shijith Thotton <sthotton@marvell.com>
Subject: Re: [PATCH net-next v5 2/4] net: devlink: remove
 devlink_info_driver_name_put()
Message-ID: <Y4XCCl6F+N2w+ngn@nanopsycho>
References: <20221129000550.3833570-1-mailhol.vincent@wanadoo.fr>
 <20221129000550.3833570-3-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129000550.3833570-3-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Nov 29, 2022 at 01:05:48AM CET, mailhol.vincent@wanadoo.fr wrote:
>Now that the core sets the driver name attribute, drivers are not
>supposed to call devlink_info_driver_name_put() anymore. Remove it.
>
>Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

I agree with Jacob that this could be easily squashed to the previous
patch. One way or another:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
