Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB620EFDB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgF3HwU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 03:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgF3HwU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 03:52:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A687420768;
        Tue, 30 Jun 2020 07:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593503540;
        bh=VRWIDB0oPdxyG19ZLLXC3WI7NqsoZ30PrPIvPKdiAAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2mVS51qT1VZSiufxOKFZPdBcPt7Yn4P0evUCSaqNC0M5UUh4jBoeYT+TDY67UWrCh
         2VoUF89WVw1H3Tff8pNFmS+43ppGmR+59co8OJDvq7IMxRZaVLV5aJS9DTMZ8cTI8i
         af9m1l27UpN9Yk0H8HcDr+8DtK8A/lBhRqQSVh0I=
Date:   Tue, 30 Jun 2020 10:52:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: CFP for RDMA minisummit at virtual LPC 2020
Message-ID: <20200630075216.GD17857@unreal>
References: <MW3PR11MB455515AF0D14A0C07360AFCDE5930@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB455515AF0D14A0C07360AFCDE5930@MW3PR11MB4555.namprd11.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 26, 2020 at 07:16:02PM +0000, Xiong, Jianxin wrote:
> > Hi,
> >
> > I will be short.
> >
> > Please send me/Jason/Doug/"mailing list" the topics which you would like to discuss at RDMA minisummit at LPC 2020 which will be virtual this year.
> >
> > Thanks
>
> We would like to have discussion on RDMA and PCI peer-to-peer for GPU applications, using DMABUF.

Thanks, it is indeed good topic to discuss.
Please submit this topic on the LPC site, so it won't be lost.

Thanks

>
> Thanks,
>
> Jianxin
