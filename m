Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09120F4A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfEPTlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 15:41:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33004 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEPTlT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 15:41:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id p18so2495506qkk.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IPz3d6OagyC2dFi6j/aPMTF/+zzkP41+Id/EUpFQv0Q=;
        b=akOCPxXU+ZJsJg5Yo9mbdSZMvaopqquxcG+MZT9Yr9bbHPeCDHrPSY1L0s3HBnkUkc
         63THaDfJAbCHWM5bbvk2sguv4fivHXHIywuxxqq91yHrLKK+cBTrpKwNqhem3QXagbYn
         UE2fiv/PJrhWP/Ol6oFsFyZ9IJ6sVZQs06h+VqXFCWiA1StS2j+K9h3BMil9JHT1Wk+W
         vp+/csgyxEZQvOR26BQ401YYXz6MIYPffh4A3OwyqgqDZONvRgAzJL9pn06rWEiq1Clv
         2JbsHb5LJ0i5DrUODrg5CF+48BJQX5Ybjc6ysSFRAnEpALOtBesaNhCyk90h2FBZFVK2
         dkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IPz3d6OagyC2dFi6j/aPMTF/+zzkP41+Id/EUpFQv0Q=;
        b=OJMcapJxmxxa54BNsghMfD35GTaT1ABvOZlt8RrDG0ofgAIt9jZp/mP6nRrc4eIDfS
         czgm0rGhsib+jwzhonyOF/tbhkz1tJDrIFgZTcEq+OuHMvhACFiVpBL2A6JmohYoZ89X
         dk6PLqvZFs/Y0hMmKpsrrVXI7/splXCWatAUfgFXWj8q6sovn51lZufAROynS0ipiZp5
         P8Od3dsD2R5hfz+hnQsvGtuXBKmqNn+1Ru0S1NBQzvbzakDWDEa47Bq6qKimtUvMBkBf
         im1NzOzfVZn880U83rmOWKmCPabRDaj0reVRBzcvJYR48xu8Ei1gm0QBNzBGtdS/pR/3
         A+aw==
X-Gm-Message-State: APjAAAVRL8X/Mr2bhxK3CShNNUZ5VUtFict4ytaROquX4YHLZmQ2oYSq
        F+G/P73S/C1WgQgHRkGsDt9nxyMwrpw=
X-Google-Smtp-Source: APXvYqxggxm+cnuxhxz4QhhLbcQf79yrcSqsxl3H0mhirFzaJZldnUZ16ra9Wqmm2ZJmCjIKEwT32A==
X-Received: by 2002:a37:4f10:: with SMTP id d16mr25458544qkb.71.1558035678093;
        Thu, 16 May 2019 12:41:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f33sm4589474qtf.64.2019.05.16.12.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 12:41:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hRMFh-0007hj-7v; Thu, 16 May 2019 16:41:17 -0300
Date:   Thu, 16 May 2019 16:41:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core 06/20] build: Support rst as a man page option
Message-ID: <20190516194117.GH22587@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
 <20190514234936.5175-7-jgg@ziepe.ca>
 <20190516164734.GC6026@mtr-leonro.mtl.com>
 <20190516165149.GG22587@ziepe.ca>
 <20190516192529.GD6026@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516192529.GD6026@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 10:25:29PM +0300, Leon Romanovsky wrote:
> On Thu, May 16, 2019 at 01:51:49PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 16, 2019 at 07:47:34PM +0300, Leon Romanovsky wrote:
> > > On Tue, May 14, 2019 at 08:49:22PM -0300, Jason Gunthorpe wrote:
> > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > >
> > > > infiniband-diags uses rst as a man page preprocessor, so add it along side
> > > > pandoc in the build system.
> > >
> > > Why don't we convert RST to MD prior to integrating infiniband-diags
> > > into rdma-core, instead of introducing extra dependency and complexity?
> >
> > The ibdiags stuff uses RST's #include feature extensively and
> > unwinding all of that is simply too hard. Maybe someday we can do it.
> 
> Doesn't pandoc handle such conversion? Anyway you are introducing some
> tooling to do some conversion on the flight.

I didn't try to make pandoc work, that might be a future effort.

pandoc and rst2man have various differences.

Jason
