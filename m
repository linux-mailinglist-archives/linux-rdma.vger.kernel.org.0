Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEB39200
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfFGQ3E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:29:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34240 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbfFGQ3E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 12:29:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id t64so1628323qkh.1
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RfRK+ekNywqACS8bXF5+1rPkcEcOxB5GMJwKX8UrKlE=;
        b=Qk17rSusyBrcDvpHxC3qyo2jlv6AbqiU2n0MYgP5u7mqsYnnHuZ/Zzx68WM/TokP4m
         4qBfwd4nyi98QK6j5Uh4dpI5S/eMbtjQSRAZUt+sj/0i4unMTKRIm4HOmbcBapG72klS
         ss9BYxeHNY6lhap72cvxlfo4tVgnBOe+F7z0a3l/sP+E++7SCdGHfKeWjHs8O3yPQL8G
         1/3zXASQNKCdOYN52dh3nd7vx7d4mRYVK82WmCmgAkvhyFB3+n2nFOcFkTTAzb1x8Wm/
         SahZr9yosS5Pr09X2YxWoFIhvmSgf46KgV790PHapA0URMaB/Xgp5Dh22z+qTfu6dY8Q
         0rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RfRK+ekNywqACS8bXF5+1rPkcEcOxB5GMJwKX8UrKlE=;
        b=ZwAumFGe6HSsApiVbDqZqZf1kTKJMeqzOrdBP0IVCyZanymAY+FvqsENpdZBz4ZkHo
         tHijS5JOBUP/byFTx/23byxWo6JAxHp5fOgfNiZN2LFZFKv4axQ6puX2LTcCXqrNbcMp
         Yh3wlKNrp3MOkbJjPHKK3Yk1TkmVSXi+E9AVQABcF7FpPeWPdjvl+OnBqCm+xrEaoCei
         NcjDCD71XNL/xyLVfCIFmJGueCnsDaCS+a9sor4UgERtZqJ+zOPISXyzZ4CmxhmfG1BR
         s7iIpkC8CzD4no+hD+wopRgnGOktnjH0PQxefqhZvvEP85OwUUAdNbSbIM/4QEhAp2pX
         SyNg==
X-Gm-Message-State: APjAAAW7t4v63R5PTfRbz2g8BM5aNnT6ZapQdKmFaN0qfq+rvWzt2has
        0Sg0KWyNJ53T0cJ2kI6KnfOiH2WutCHv9w==
X-Google-Smtp-Source: APXvYqwz77/M68QndiXQE+7kmU9WM6bTqTZhzhfNgg9Vylli0pF+QPN/XXdeo9r84fuDFY37vZrDKg==
X-Received: by 2002:a05:620a:35e:: with SMTP id t30mr44830939qkm.14.1559924943733;
        Fri, 07 Jun 2019 09:29:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d123sm1404216qkb.94.2019.06.07.09.29.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:29:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZHji-0000tN-Si
        for linux-rdma@vger.kernel.org; Fri, 07 Jun 2019 13:29:02 -0300
Date:   Fri, 7 Jun 2019 13:29:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: linux-rdma on lore.kernel.org
Message-ID: <20190607162902.GM14802@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I would like to see linux-rdma archived on lore.kernel.org.

To do this we need to provide the best historical archive we can.

Those of you that have subscribed to this list for a long time may
have this in a gmail account, perhaps.

Konstantin has some directions here:

https://korg.wiki.kernel.org/userdoc/lore

Thanks,
Jason
