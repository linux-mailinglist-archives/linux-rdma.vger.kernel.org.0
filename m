Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE51C7992
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgEFSl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbgEFSl2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 14:41:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC5C061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 11:41:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so3672023wmj.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=g0JqTyoUc633rGUIgQ5P0pJUtOcR1DRZBsjdAD2dQ60=;
        b=fSPWRRfq1so36bU044rxvfLykMmpCUFM80vEkLD9v45lLT0GUOpvn1gRJ9lwi9vv0M
         /a8hQgZwDemzRA7dcpH/tsF3VAVjeY4G1k202f4ht9v3Ed2hteWIMV7fy6FDJarb/CXR
         w0ceM4uYhwljviM5Cm3CiXrWYJsJDvOoIL7X9VGq1Wmpgi5GqTB83vIOGgkqXB9psQBQ
         ioLBEmrDiBTXqSpZ8DNr3fo3g6Kd5tR6vmLxDJxcPDdEpZ/e/bVXISy843yDLm7cdUtD
         1LUB3ysUT4aWX34jInvCeVhb6qirg//bSBd9rAlethdoL5SZfRUJCRtehaEd5lTWPNTw
         uc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=g0JqTyoUc633rGUIgQ5P0pJUtOcR1DRZBsjdAD2dQ60=;
        b=KZaEvgs2VXB+FLryw/F2RG+aEyR69Y29xj7OtWrtXNin6PJDRHR5663N8nW9OuRZ1C
         SgmL5JPPjUnjrcIv4TS4+3/p2YoDsvQUgw9LU8p5qiUDRPWBXMJ2UYLFDy2Cvfm5Jp1t
         TGcFNX8lldOKHhtLvS3KLdp1TH5EU4id2KHJ3Goj4gHKPietqYJLmXAaeBBSfRr13Or0
         BnuOgabCTnxlzwJeDVRJbFPzeGIYRkh7l+xJk6K2MDIpYCmaY8aRor1dz8rMBgYrSxNZ
         nyD5hcet2s+SfaqF7ElMQTli8uYsXEJDjlQ0SRVu7hVHA9ZV2BUiKP6u1ijliIQEhqUg
         6YPw==
X-Gm-Message-State: AGi0PuZEn+cUZ06r2Usmy5OI/ZdHRuAUTbW4AyXSZ3DXP1Ep2D0QgXU4
        0ke9gP1OYq0sYSWarDqC/0ZETg==
X-Google-Smtp-Source: APiQypLcmcNOTwgQHnjwwZnJBNv3TNku5WgQJRWGhwkVyzmPjdzKt00xaBgcW0nPGXEjECKwzwx4aA==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr5868115wmd.178.1588790486174;
        Wed, 06 May 2020 11:41:26 -0700 (PDT)
Received: from localhost ([37.46.46.239])
        by smtp.gmail.com with ESMTPSA id g24sm4259976wrb.35.2020.05.06.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 11:41:25 -0700 (PDT)
Date:   Wed, 6 May 2020 21:41:23 +0300
From:   jackm <jackm@dev.mellanox.co.il>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        ferasda@mellanox.com, mohammadkab@mellanox.com, moshet@mellanox.com
Subject: Re: [PATCH rdma-rc v1] IB/core: Fix potential NULL pointer
 dereference in pkey cache
Message-ID: <20200506214123.0000121c@dev.mellanox.co.il>
In-Reply-To: <20200506180936.GI26002@ziepe.ca>
References: <20200506053213.566264-1-leon@kernel.org>
        <20200506144344.GA8875@ziepe.ca>
        <20200506165608.GA4600@unreal>
        <20200506180936.GI26002@ziepe.ca>
Organization: Mellanox
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 6 May 2020 15:09:36 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> > > > +out:
> > > > +	ib_cache_release_one(device);
> > > > +	return err;  
> > >
> > > ib_cache_release_once can be called only once, and it is always
> > > called by ib_device_release(), it should not be called here  
> > 
> > It doesn't sound right if we rely on ib_device_release() to unwind
> > error in ib_cache_setup_one(). I don't think that we need to return
> > from ib_cache_setup_one() without cleaning it.  
> 
> We do as ib_cache_release_one() cannot be called multiple times
> 
> The general design of all this pre-registration stuff is that the
> release function does the clean up and the individual functions should
> not error unwind cleanup done in the unconditional release.
> 
> Other schemes were too complicated
> 
> Jason

What about calling gid_table_release_one(device) instead of
ib_cache_release_one(device) in the error flow ?

gid_table_release_one() calls gid_table_release -- which frees the
gid table and sets its pointer to NULL.

Then, if ib_cache_release_one is called later, gid_table_release_one()
will simply do nothing (it calls gid_table_release, which returns
without doing anything if the table pointer argument is NULL -- which
it will be).

Thus, unlike ib_cache_release_one() -- gid_table_release_one() is
callable multiple times.

This also has the advantage of unwinding the gid_table_setup_one() in
the ib_cache_setup_one() error flow -- which is a symmetric unwind.

-Jack
