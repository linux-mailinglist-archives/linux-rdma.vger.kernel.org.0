Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6BDECC257
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfJDSL5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:11:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38340 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJDSL4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:11:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so9785293qta.5
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmBZ7mMc6d5EXLu244ECbFm8FQY1S5NFMi38+HxC64c=;
        b=MMVw7yRF2VKOW6othfIIe7kAwgI4Z4UwT2S36VEELeTerkhsOi17+S1qUqwXaUPKld
         VOdIkI7nuBTpftQDcMu2uB09g2Jc8tlhWHKOnPQgrbO4WkVygxyUCJaf35ILVh8YTtZA
         eeH5aJuHRGzPVmsNs8NYFnz4usnrxLgf76/a2FQ1ZB2o0DMjX72u2F8DyEdwIwhKl/q9
         +iYHqvwqcJQa+N3JYnkRhdQvIXIdy+ZJLht/J4aAYv7DYKSMC6A+vIA+Vus0M7kzluJ/
         TL9l152aUE74nWs+mWBbmcmlmzqEpHmy4xxYw0Q6UDzCyKmlHbRKrsDc88N0kPCrBsWs
         SOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmBZ7mMc6d5EXLu244ECbFm8FQY1S5NFMi38+HxC64c=;
        b=qYwErbKVdrPe86DEmLJU6GLsnH7pTlFnzImvs9nBJch2FmJm4ScMTP+s5APoP1RGaj
         mJXWVmRFiFvfUXucH1EdPhHTD3iQ8I27Lt6bbTBRv+rIS1C+GXdjpkVWT31FCCrkd/N4
         8gEpUKB/Iqg6Vk2thon3L5/KsFfLwZaDvpIuIS1V5Ic5gvbVroqom079a3LuFuH0ObFw
         +G5xhGFjYNRv2hlUaAxYo+AkLtn+7JR5cdOg5OZv1WihOYoN+87VYadoavUgs5I+1XNY
         7Jsdy69+yoHjW/uDSy7OM1RNXmMiDfDITCXNDTSPrFfJNFNcPImRxXGzp2/4IBhjholZ
         zzrw==
X-Gm-Message-State: APjAAAW5QJ2Q9O1ko0+CfJHNd3BH0Tf+0/URa2ZoigyzWqDlRKAlvqzH
        +hrRRwrIKbHcsO38oDki8SwTbg==
X-Google-Smtp-Source: APXvYqyb2F+x0YGUW3wUU8dfWuCIECEi1/ii7Vn5axYLA1jT5iYP1bx1qCKfVrVlbcRnulkYJlVaGg==
X-Received: by 2002:aed:3ef2:: with SMTP id o47mr17037858qtf.314.1570212715965;
        Fri, 04 Oct 2019 11:11:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id l189sm3048907qke.69.2019.10.04.11.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:11:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGS3X-0005Sa-07; Fri, 04 Oct 2019 15:11:55 -0300
Date:   Fri, 4 Oct 2019 15:11:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Message-ID: <20191004181154.GA20868@ziepe.ca>
References: <20190930074252.20133-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930074252.20133-1-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 01:12:52PM +0530, Potnuri Bharat Teja wrote:
> remove iw_cxgb3 module from kernel as the corresponding HW Chelsio T3 has
> reached EOL.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>

Applied to for-next

Please also send a PR to delete cxgb3 from rdma-core

Thanks,
Jason
