Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEB10799A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVUsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 15:48:23 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45058 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUsW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 15:48:22 -0500
Received: by mail-qv1-f67.google.com with SMTP id d12so1495926qvv.12
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2019 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lKiS2bVVtAH0Ri1BGP5OV/VrL24IfLJ5kGLiWHRw/iI=;
        b=CpP7f8fNUzh6wzWdvzWEKJStKlafopiQDcRmp9pNSRrvK1JadDkJjue1/rYl2jSepT
         TiYtetgcUI7rUltfWOSqQNS3LZXOU3lf6yiOPujV7IwQpDhqNJtpeXuoj7En8q8CFKoL
         CwHfci0/PgXc+UfoKoCSeW4EJhDo+OTcrb3btFdsLjoZmLwQZNqSbrsEXJjd9C/562J4
         pSQq2oUMo38+bHChjLJvsgr9xzs30Puwr5LUlenTlvVVZ9c7s2WlnNjj+4/pVGmCf4Ov
         ZAUwHOEOj+kiwOjsCPKokUO2aEW9/eKw8ZkMT0OFK2sdQotcrMoak56dDTPmfCaIr7DJ
         b1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKiS2bVVtAH0Ri1BGP5OV/VrL24IfLJ5kGLiWHRw/iI=;
        b=rQACYJ/OWuKIlCqmfTF2etGHq0Ts2Fya0Kd0Ga38eOPVTGDs/xOiWzKPrBw8Fh5YJ1
         iUY5/i/wnyl/IAVbCfEyQFOx/geXLODf/KGTJatFqK5h/sUlmYe8g4JyNTrqxTMer0b6
         wvzAvIa5HUj7i6YNd84oW6chIY2dHZkiLNClS+0pum9S/6eMepYXiwmSKy9uDYjl43hv
         +HDEvdGTAZg9qOQBJuKqjzS3p84PYU7gEynAX6d4lDazCAbLTTFvZEqZIl663oFwvArQ
         ooYLx+1LuIsW6Ea1nWmTxhuVEg6L4+BvzCGApaYBisL3QgVUtzh0o8P5833eiN1pfplY
         iwKQ==
X-Gm-Message-State: APjAAAXExPjJ8IhagajL7rTXYSZ2SOnhkFWKpo2cBgfLNyJrqQrtVavN
        goxhjVYxOWpxZTDlU0R+qMWZhw==
X-Google-Smtp-Source: APXvYqwyaN3r3UlX0kP6ZuBn7o8FbI1mjjcQ6Ws9Osja3Kk/CN+L/i91Fxr5+PcgBUdeycpPQR29yQ==
X-Received: by 2002:a0c:b620:: with SMTP id f32mr15980677qve.186.1574455701758;
        Fri, 22 Nov 2019 12:48:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r48sm4081668qte.49.2019.11.22.12.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 12:48:21 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYFqm-00063X-Q6; Fri, 22 Nov 2019 16:48:20 -0400
Date:   Fri, 22 Nov 2019 16:48:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Refactor codes of CQ
Message-ID: <20191122204820.GA23252@ziepe.ca>
References: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 10:34:49AM +0800, Weihang Li wrote:
> This series redefine/rename/remove some interfaces to improve readability
> and maintainability of codes of CQ in hip08.
> 
> The 4th patch has conflict with "RDMA/hns: Add support for reporting wc
> as software mode", will send a rebased one if any of them was applied.
> 
> Yixian Liu (4):
>   RDMA/hns: Redefine interfaces used in creating cq
>   RDMA/hns: Redefine the member of hns_roce_cq struct
>   RDMA/hns: Rename the functions used inside creating cq
>   RDMA/hns: Delete unnecessary callback functions for cq

Applied to for-next, thanks

Jason
