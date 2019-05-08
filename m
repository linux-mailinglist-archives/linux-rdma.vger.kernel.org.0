Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02A1179F0
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfEHNIi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:08:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44439 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEHNIi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 09:08:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id w25so3239751qkj.11
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GzaFKlfK6lPnwi0OhB1DWRND4MOpZ+D0Th0SAqJeb7U=;
        b=jrocCX2kmNd0k7LUpXA2d+2fQ9HuebMzMKWZ7k+6sVx5nH23noX2Fv+iuucZ3Jm2Mp
         Awb5I9ji0mu1nhPPtkdmGEHlbSerpBWM+irjPNwb/w9liW84xJUlIPoQf2JTVAuWylIX
         gHv3PrtyFn+Ah0gcgpUDfOhWSN+lo4EP13QoHDAqN0ckr4i8PMiYQlCMm/9GDRxzGE3B
         mjgw42aWHiBxIzr5jt/Pivq0pv34Pc2esiS0OSHBslcRrA4SeVSd0Nblg8uTo0GZBgXo
         oLCHdnhJEeu9V4C/0kMjDsnE7ttac4f/FOLRJqYuw2NLLE18VrMDXlqJDVQ2uiIHD+JE
         Ex8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GzaFKlfK6lPnwi0OhB1DWRND4MOpZ+D0Th0SAqJeb7U=;
        b=k7YEqM5XylAxPEsvIAhOhF0DWHDONf9m2CqzJQzej+M3xntLX/+mDSEM+dOWiBPXF9
         aXFpnIpW+csiwcL2RnQTcTharR4B1abujP7P5Y1NlOQpP2H7dBLMMpDvd/k95hyyLp7E
         49UMH0hWFWLp3wBtAxtUFBmJwx1yy2nqWrwzZgzhGMwIq/lFKkLRCQAWd1EMVRrLxOn9
         OiwzRrA2nkSZNl+7i5qmH5BTs7aFzVr0mfkEe0kw31TIJCyj54uprZdiSxvD/5+e33CC
         0Zft+qFIzksQFC9a1Hvej2/T7NsyQ+GVEaMg8uSxtAAeyhFIoKGEXgLl8U8L6V3MKxgl
         NoRg==
X-Gm-Message-State: APjAAAUtSmSiSBq7/vVQiBPaAsVlD3qnYYB2UpDdL7nwqjBOORRqwJ9V
        9I9hMttl9oGjamIMks9cFiXTMK01Ulk=
X-Google-Smtp-Source: APXvYqwXpYb5XrcLcH86JZ1jEN6FxkDvFmtm9YozOKQ7CIJ/4easA3/8gPuPp+llmQIdVxo+2HK/4A==
X-Received: by 2002:a05:620a:141a:: with SMTP id d26mr11026872qkj.238.1557320917104;
        Wed, 08 May 2019 06:08:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 67sm8524356qtc.29.2019.05.08.06.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 06:08:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hOMJG-00011C-Ad; Wed, 08 May 2019 10:08:34 -0300
Date:   Wed, 8 May 2019 10:08:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 02/12] SIW main include file
Message-ID: <20190508130834.GA32282@ziepe.ca>
References: <20190507170943.GI6201@ziepe.ca>
 <20190505170956.GH6938@mtr-leonro.mtl.com>
 <20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
 <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
 <OFE6341395.7491F9CF-ON002583F4.002BAA7E-002583F4.002CAD7E@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE6341395.7491F9CF-ON002583F4.002BAA7E-002583F4.002CAD7E@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 08:07:59AM +0000, Bernard Metzler wrote:
> >> >> Memory access keys and QP IDs are generated as random
> >> >> numbers, since both are exposed to the application.
> >> >> Since XArray is not designed for sparsely distributed
> >> >> id ranges, I am still in favor of IDR for these two
> >> >> resources.
> >
> >IDR and xarray have identical underlying storage so this is nonsense
> >
> >No new idr's or radix tree users will be accepted into rdma.... Use
> >xarray
> >
> Sounds good to me! I just came across that introductory video from Matthew,
> where he explicitly stated that xarray will be not very efficient if the
> indices are not densely clustered. But maybe this is all far beyond the
> 24bits of index space a memory key is in. So let me drop that IDR thing
> completely, while handling randomized 24 bit memory keys.

xarray/idr is a poor choice to store highly unclustered random data

I'm not sure why this is a problem, shouldn't the driver be in control
of mkey assignment? Just use xa_alloc_cyclic and it will be
sufficiently clustered to be efficient.

Jason
