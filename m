Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB661391DB
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfFGQYd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:24:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39588 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbfFGQYc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 12:24:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so1604662qkd.6
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RF2U79PSY9O6J/T638DfornWeYDHnSZlzeDWWIyddfI=;
        b=MX2uoLyCWJXBB8LOKU9I9FBJiL5GWg4AMSwZOaEFy5Z/GMVm3CPgsLyhTMGtoMZzAX
         WvdrZRBHGtdOpzfav+/ma066dZ2a3f46xbyMjFlx9HtBsGuNEfijItePiyHWuFJUR3aV
         pDSfPlu5tEuqIzOGzdbQp1Hm8B0R9sYhq0efj7kFabV3r9BlQJPaTq/06AUADNeHPX8B
         vRKB6u8XYYY/N+EZeRf5YPq/1GHCJsQF4MxDtXmSC6v5EHHGbhWnpPrCCzdcY7OUu1yE
         VZOo0tFIah6bL93+jrmO7EE8G2YxgfPfj+uE+KCgXsmGJsznA4zvBaCzr1Ozlvm0zMJK
         wxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RF2U79PSY9O6J/T638DfornWeYDHnSZlzeDWWIyddfI=;
        b=ZHDmkGfpQ+0cRjMMaJTr2SEdR0xmLpUdfNqK4onmAXs1GYDEUWIpQeyGElyJ7cwtne
         141/BZXuNUt8i6ZonymHa+Fh+qls3n6YwdeB/TffLa3xxAluhZOS/+gYFhNX84P4PigI
         McdZpIuFUn+GTU9aTRUN6Fk7kxZZDy3k9Zg1sraPO6wkuiCSGm5BnmVfMwZNI+XSNhvY
         zt/T8rXB3cEs+F0rBrY42xdui8sInfSqc/88zyuxpGkjhXiiCiT/nMuOHNcFZkyXxa+s
         Of7bhru3K0Gv66pUw1wii7ZU8/d+xzV8SJowilFA/kbOiAzsDMigvCKFZ/A0N1WoN+Nn
         Bl+g==
X-Gm-Message-State: APjAAAWj9Md5hcm1IDMNOHBn2+3T2iMQ2o5vYGQIle1dQtx2d8HWVDTd
        NySauewP1AQPEU2TasKYLHFFebGvjIiNdA==
X-Google-Smtp-Source: APXvYqwQPohyZZpu6DigWmr67r+FYzh6VARQvMJh2U/vPdG2uRiWTFK1ESJBn2wO8ZSQRKoKr+3LRA==
X-Received: by 2002:a37:a0d:: with SMTP id 13mr45363881qkk.273.1559924671510;
        Fri, 07 Jun 2019 09:24:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f16sm1080225qth.46.2019.06.07.09.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:24:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZHfK-0000pD-Ie; Fri, 07 Jun 2019 13:24:30 -0300
Date:   Fri, 7 Jun 2019 13:24:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Cc:     Faisal Latif <faisal.latif@intel.com>, larrystevenwise@gmail.com
Subject: RFC: Remove nes
Message-ID: <20190607162430.GL14802@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since we have gained another two (EFA, SIW) drivers lately, I'd really
like to remove NES as we have in the past for other drivers.

This hardware was proposed to be removed at the last purge, but I
think that Steve still wanted to keep it for some reason. I suppose
that has changed now.

If I recall the reasons for removal were basically:
 - Does not support modern FRWR, which is now becoming mandatory for ULPs
 - Does not support 64 bit physical addresses, so is useless on modern
   servers
 - Possibly nobody has even loaded the module in years. Wouldn't be
   surprised to learn it is broken with all the recent churn.

Remarkably there still seem to be cards in ebay though..

Jason
