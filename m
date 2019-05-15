Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053131F1EF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfEOL6u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 07:58:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33440 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfEOLPz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 07:15:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so2773852qtf.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2019 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JtU8ruv1GE4RhovcGNcThNHYTygKY7xC9mWHV7+OXjA=;
        b=EjLoQp1SUE+auB0zAT/lYTVYFvg8me0ScPG12Hyk2HZlTequQx3X2M38tpU2AIIelN
         GqMODRnnkvTLfzKHZQ+J3oY0HyIeTjs07mAr0Ho3lm9a8Rq8wqiuJYHpJmrqypcK/8Ju
         ksnAa40eJLh1u160konZu0v/gQwg7/l2gYpuksDryDzbHoEfXsZ9fyVcKJrusN+M71Lg
         FLCzm+Tqvs2Erb1Ls9+RHax8VFasg20uy7UqYo1VraXYaOPGdbsbqZCfJs5hTw4fb6FH
         59DZNkBQABDKYDc+UYXHuXGzqhz4tUATe7ttdt4NDj5H5H0X+Q+a9Kanzw/zNE1FtNOM
         a72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtU8ruv1GE4RhovcGNcThNHYTygKY7xC9mWHV7+OXjA=;
        b=jHQlsXgoKYVpehIiZFcPkAEnlYtMJ+AWuYa/e39DPerP1SfiQ4nmL2a/zeisr3CQwC
         gcM/bYdoANxC/Dj8VXBNwCmOaK8p4qRO3UWjXBeCp6m31c3QcHkYwO/yNmXUCIjIUc3g
         P+ZUXj9p0UNv53oVGRu4s2/wiAorYY2gOI0IR46byXzbzzYp71Xk7v59y1IZDevcxUyq
         L8N+GJXV5Vh+QPYxgNhOxqFHppLUnkFZCM8FdOTri7S/mqYr4RCiSINR8XRiOnXk+max
         pu/p21uupfETpfxCSLsKHA7vYd9EECpO2bA/Z242DzqVi8rnrVpSadaBYYvRiBhvo03d
         3sOg==
X-Gm-Message-State: APjAAAVHyXk01nhgIQqK/yA6lFmm5si8V9aFmA0TXBs8Yh1sIIRs6sR6
        TiTo9gvgsb22L3t4eLypyY2VWQ==
X-Google-Smtp-Source: APXvYqw+XIYYmIyn6S0slBeZhpu1FnzXEy9GywfIss+gBknyxWQEMVrFaD9YHX6Sy3I/1oNRzplhAw==
X-Received: by 2002:ac8:253d:: with SMTP id 58mr16645106qtm.244.1557918954591;
        Wed, 15 May 2019 04:15:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v22sm1312987qtj.29.2019.05.15.04.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 04:15:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQrt3-00088L-2l; Wed, 15 May 2019 08:15:53 -0300
Date:   Wed, 15 May 2019 08:15:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core 1/5] cbuild: Make pyverbs build with epel
Message-ID: <20190515111553.GA30791@ziepe.ca>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-2-jgg@ziepe.ca>
 <20190515052947.GF5225@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515052947.GF5225@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 08:29:47AM +0300, Leon Romanovsky wrote:
> On Tue, May 14, 2019 at 08:30:24PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > For some reason cmake3 installs python3.6, but EPEL only has cython
> > built for python3.4. Convice the python3 link to be python3.4 so cmake
> > finds it without hassles.
> 
> It depends on our definition of cbuild.
> If we say that cbuild purpose is to build packages for given platform,
> such hack will be appropriate.
> If we say that cbuild purpose is to test and ensure that packages are
> built for given platform, such hack will hide the problem that rdma-core
> won't be possible to package there.

The EPEL target is for developer use - developers that need to use
cython should pass in the PYTHON_EXECUTABLE environment variable to
get the right version on EPEL.

Jason
