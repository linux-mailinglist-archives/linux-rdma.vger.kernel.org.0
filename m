Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D11ADD55
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgDQM2f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728234AbgDQM2a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 08:28:30 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579D3C061A10
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:28:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c63so2151585qke.2
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aZefJ2eeeg5YJ8LbNLwmZ0QsC9kKV35KaDs/t6j0M1g=;
        b=K9+oC8zpTs7eoXwYoNCM97j0wAjePnqvg1MIHJIH7ous//tMV1Jr3cBr+kIJfIT6tw
         3OcVpAAq67QKQZkGQMvO3bNsWwbJBnCUPX+HM2kSXjzzVPxyBC33diZFfVD7g36eaQ8V
         qfI7KDcfKd2QX+EUZ3jdUHgnHovu2cehHa1LIeWfd5uLrxhCooatkyANNHv7afAV7XJT
         obDDx3gIJGnGLvMi6zrE6ny3daHSgAl4TGZNNZtepoDTUoHKeOtld3APKqR8zMhi0jaR
         hYAiqzB2jOWifkzgQ5CnHvC62GPxGS/ig8I2V4XV7ODMhCnKVLz6AW73AfOwbKI5YsJ5
         eQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aZefJ2eeeg5YJ8LbNLwmZ0QsC9kKV35KaDs/t6j0M1g=;
        b=YrxJwyDwcx+uz80oOH9IFtW7PHx6rphDFAlFjxrVg80I60v++sgQDKplDtpcGlA7or
         vlC/ADS9oE/+QacrD9R+27p8ppUn3lGv0atN95Zc8AlxkJnGNEssmQ/AriUr0SoDUQSM
         DPyuO+ItU0BCVp17BMoYm+iIsIJ1mstyeXqY/TiXPC8EONhnjU3Y7xOLkVULRZZIeLnn
         YwbjPBXxtI8f6lCHT4LVE9D4XPmYwIKgF6rzeX8HI9B4NXh72zPceskkPGEJ08fNyTOL
         S2y9eYCpY2aWgYZmr5+XAY1rgtwSljzK5bgTcapaOWKIwcyik/XWOgLWZXrSHgxqiXoJ
         j9XA==
X-Gm-Message-State: AGi0PubRXy3eFHJEAFnUfL03rUKs7eXym/BpYZPD+y/xfXiUakrb9M2R
        l7v+MBZNTx1WNUX/Yb89eZtydQ==
X-Google-Smtp-Source: APiQypJ1vYJs1OcOpG6NFzpsPpo2EzISzAbbiESS6yc0Q6fShvvLk7GfaJtAZP1aoEPPARaV+dFckA==
X-Received: by 2002:a05:620a:39b:: with SMTP id q27mr3018858qkm.94.1587126509481;
        Fri, 17 Apr 2020 05:28:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u17sm8223117qka.0.2020.04.17.05.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 05:28:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPQ6d-0006gf-52; Fri, 17 Apr 2020 09:28:27 -0300
Date:   Fri, 17 Apr 2020 09:28:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, leon@kernel.org,
        kieran.bingham+renesas@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, jernej.skrabec@siol.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Kconfig: Introduce "uses" keyword
Message-ID: <20200417122827.GD5100@ziepe.ca>
References: <20200417011146.83973-1-saeedm@mellanox.com>
 <87v9ly3a0w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9ly3a0w.fsf@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 09:23:59AM +0300, Jani Nikula wrote:

> Which means that would have to split up to two. Not ideal, but
> doable.

Why is this not ideal?

I think the one per line is easier to maintain (eg for merge
conflicts) and easier to read than a giant && expression.

I would not complicate things further by extending the boolean
language..

Jason
