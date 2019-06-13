Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0CF438DE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfFMPJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:09:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41889 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbfFMPJM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 11:09:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id 33so14784170qtr.8
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJfLZE5UZTU6x3qU+lIPPsXLCLkv4pp7jNH3cy3l6yY=;
        b=ml3SmH5Hfmod46F81nMyG2P0NizdvJanAF7CyNFSkveEoGx2Z4cNoOL+Fto0ge6x1Y
         JWF+MVW+3PILplBORK4V5CJNNQszkF1sfJ32ynl6XITtsV+ghGNggffuklXEwdgRtY5H
         a/2jtAD9y2LEnWOX5n9mnScX0C/8WiTjSz6XqRdCPyRJi3Amxo9n8wg75s7b1bIWFIDn
         T3Ib+FZ66vb5sdgan8v4rH2ZxWS+KgAdyBosWcGbnQ4LXTdtsmAUAJhta0DiPTKAU1Mj
         Xs4/9FtrByNBEE8tH/VXcnn7LoUL09P6UY69gwBNbo+4Na5hQIkYWTka7rPSrvHPDN7y
         fplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJfLZE5UZTU6x3qU+lIPPsXLCLkv4pp7jNH3cy3l6yY=;
        b=Rfijd9W+16iUOBluRjSU7yPbRAWlpZHSi1Y0XaRXQpTpM7Fm1LOMJxQNvtsDlXnPoz
         RRSaZrv5Z1uvhUpaWxTXMp3QRZIu+8DeXcc1aBZEcyHQP0qZ6qPPg49gaZrmmPuaRXTE
         Xq7qMLTJ5cT1RBmRvHZXe/dq9kuOA4Ln9yU/7AlFSmZXZsvELdnq58PkHq6nUHfeUEiJ
         N99HT9Su8S12iSAQkBEOIAMsIpkm62lvcc9hEPulxGaaVfN3lnL4Pln/IeHFHLlg9lA6
         nTRs3NNo7aQgeGu2bNgDsMtUeXCukP16qH0KaH3p1Sh63X4MpKe+FyCAhzyFNGOgEUrL
         adCA==
X-Gm-Message-State: APjAAAUTJJc+QXUxpMmi9z2kCEwFM+euqptmoCs4/akjZ3xVtboSFs5q
        ZrfZxMpxwdxBHu3vUvgmx4pwCA==
X-Google-Smtp-Source: APXvYqyu+moY+mQF7g9DtJo06R1tzb7IdUz9DJ0JxTebf+F6pZff3NDQRwABkToIx5H7RYsxHMlPHQ==
X-Received: by 2002:a0c:d0d4:: with SMTP id b20mr4136829qvh.38.1560438551211;
        Thu, 13 Jun 2019 08:09:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b5sm1701652qkk.45.2019.06.13.08.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:09:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbRLi-0001pQ-2I; Thu, 13 Jun 2019 12:09:10 -0300
Date:   Thu, 13 Jun 2019 12:09:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-rdma@vger.kernel.org
Subject: Re: receive side CRC computation in siw.
Message-ID: <20190613150910.GA22901@ziepe.ca>
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <20190612152116.GI3876@ziepe.ca>
 <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
 <20190612201345.GP3876@ziepe.ca>
 <20bd1d9d-5ca7-abb0-2d66-ea765b03550e@talpey.com>
 <20190612205917.GQ3876@ziepe.ca>
 <ca2b4441-f98f-46f8-a8e8-37013205dc0b@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca2b4441-f98f-46f8-a8e8-37013205dc0b@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 07:35:30AM -0400, Tom Talpey wrote:
> > It may not be expressly specified as part of the IBA, but it is
> > certainly wrong from a system design perspective.
> 
> I disagree, because the RDMA design specifically addresses this by
> exposing only objects which are connection-specific. Meaning, the
> application can only harm its own RDMA state, and cannot impact
> other connections or the RNIC itself.

Allowing an application to forge CRC errors is certainly not 'only
harm its own RDMA state'.

Jason
