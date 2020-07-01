Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6D2116AC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgGAXcy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 19:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgGAXcx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jul 2020 19:32:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ACEC08C5DB
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2020 16:32:53 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e64so22017199iof.12
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2020 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ncquM6OLcDeIT53Omca9Xzz77nlIMO4GAeOb4K+UNvw=;
        b=SEfMRkGL1dgrNwrNHH5+/9DC3GB+zivUGhrMlo1GxPGOPKMTJqjzoM225ylK8VPZJh
         zGVJFG1ejaNt694aa67M/WUNQA0B/74fV4lDTx857gVb/+Jav1Dj765JjgQruRZYJD0t
         QLmmRFbHLIkdCTakrpES4owCe/bmLXRi3rUeTzvxZJ9Mzh5UqplLWYcgTL457x2zXHcn
         DiwtV9rMB4ahwWgOaOf8kzvw4wpIMBykUhi5RM6ZH47ehNEvzdhLkqWnkDuUkHAA8J3I
         9qTPWKa7gkR80wy+t9v7hUUXhvtUbz0wc57G2oIi9me1DYS6SLWrB0Xen7TrtP5pKYYo
         VrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncquM6OLcDeIT53Omca9Xzz77nlIMO4GAeOb4K+UNvw=;
        b=YyiywLkCB3ii+oAfAqNq86kMcZ3zgbj/XUi6xgkFXzW/MNpylCaUJ5kj/3IqZG1anX
         et9zvxcXRaibh8KZzY+BiRD2SGXwVo59e1rN+M5mVYBk59ZV+CsmnboUiUAJOX7bn6Am
         sF06xFQY8r0RbOIjOHDo4YlD2F1RzabWnlT04ufY59s+Qyt+IUP+5u5RLqzGfa7VTtqB
         ydoNJU5bOg+tRf2/VkPi1JcGYaXoYj7tUqjN4ih1rv2hyn8oHM6yHOjVp+niGy4oSBmu
         roFclk5aI7HVv4DHEhJUD7hrT/bfcCTVG+gBdO4mRoL4D8MSWveLjRUBL9aSoS9LreKI
         2x+Q==
X-Gm-Message-State: AOAM5301EV2BVyJ7rD0vXLFrMacSXD4OhjYY/FrtMvg4zd9KYMqb1Kcj
        fJi7xjRj2H30G+jg4h4OtpHXXA==
X-Google-Smtp-Source: ABdhPJwiZ4rUdX/u3oCt6f2yg2mn2UIJs4lLCQsH2KJcwpJVSl8MVKj0VLkOemvJamByUlmtP1x5ng==
X-Received: by 2002:a6b:8d04:: with SMTP id p4mr4722342iod.174.1593646372855;
        Wed, 01 Jul 2020 16:32:52 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s190sm4204807ilc.28.2020.07.01.16.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 16:32:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jqmDi-002glx-PJ; Wed, 01 Jul 2020 20:32:50 -0300
Date:   Wed, 1 Jul 2020 20:32:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, Fred Oh <fred.oh@linux.intel.com>,
        lee.jones@linaro.org
Subject: Re: [net-next v4 10/12] ASoC: SOF: Introduce descriptors for SOF
 client
Message-ID: <20200701233250.GP25301@ziepe.ca>
References: <fe44419b-924c-b183-b761-78771b7d506d@linux.intel.com>
 <s5h5zcistpb.wl-tiwai@suse.de>
 <20200527071733.GB52617@kroah.com>
 <20200629203317.GM5499@sirena.org.uk>
 <20200629225959.GF25301@ziepe.ca>
 <20200630103141.GA5272@sirena.org.uk>
 <20200630113245.GG25301@ziepe.ca>
 <936d8b1cbd7a598327e1b247441fa055d7083cb6.camel@linux.intel.com>
 <20200630172710.GJ25301@ziepe.ca>
 <20200701095049.GA5988@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701095049.GA5988@sirena.org.uk>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 01, 2020 at 10:50:49AM +0100, Mark Brown wrote:
> On Tue, Jun 30, 2020 at 02:27:10PM -0300, Jason Gunthorpe wrote:
> 
> > I wonder if SW_MFD might me more apt though? Based on Mark's remarks
> > current MFD is 'hw' MFD where the created platform_devices expect a
> > MMIO pass through, while this is a MFD a device-specific SW
> > interfacing layer.
> 
> Another part of this is that there's not a clean cut over between MMIO
> and not using any hardware resources at all - for example a device might
> be connected over I2C but use resources to distribute interrupts to
> subdevices.

How does the subdevice do anything if it only received an interrupt?

That sounds rather more like virtual bus's use case..

Jason
