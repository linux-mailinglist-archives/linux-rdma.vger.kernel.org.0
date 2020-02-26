Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D824170056
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBZNnM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 08:43:12 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:33959 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZNnM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 08:43:12 -0500
Received: by mail-qt1-f180.google.com with SMTP id l16so2261924qtq.1
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mVPlBRi9QHJAhwAQKlQpWWgekEW8kGnFLm4EXP6uAI=;
        b=RHeizfLc4SxgixhZ+tYz3wIlc10Heh0G+TbcNQl9RCpcKI3BG9C4xr0GMiBrl7HUQr
         eu2brQqm4mKlS5DVnSwLMHDndVyS9OifYBGU6KmCab7ayMMyoVaNUsi6UQUN2cEhJcu0
         3rp57r6sCJmNgcsFIOBO45LE85ovfDlrpcTDKXvCfjeJI/LrVckQDu+4hpxx7tZU1mE4
         LNRznDGlHca3luArsDdaezfU8A9IJESVZCaF0FkPGgPIKZH+SVLiuPzsHcf6wI+SmOs4
         VQdVDK36FDobbttPahfKtiYybUY4RM+nTP2vCSNDTL4QccyJHGozz03SzIHA2P4s+ekd
         obYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mVPlBRi9QHJAhwAQKlQpWWgekEW8kGnFLm4EXP6uAI=;
        b=dhBhkIdXHULBdkS3gfo5ciRCVWiyNI5sC20Ct8PIFj6j/4XOunQ5IFBSnvt8gBElno
         GPqqVseyohyKw11ODk3fPJYjNwaarcdQled3xdE2Tjlu1YUlfwH7QelbBbx9x1/yaqhu
         NhuKOPqzJjPRZdI5mjvT5BbEI3CAXUHQ7C4IsPoXBOhyemdutl0dfc1adumZmhh0Nq4i
         JqOBXWqWlHsYUqPjRru+O/INguFwYfEDXYEMT4SSEynZ8Goy2ijjQoInbE80YMErbLXu
         2B/fHOsDlLhzFkJ9BBL2Quo49TANNxBRhVnBXAY0Zk7tDuWafF1laeGiFZr8Udg4WE//
         +6GA==
X-Gm-Message-State: APjAAAXB0fqBUWs/uWBldlzPYuo8A+jpwskg61aeRYphN14WsPZvnh3v
        jgYQAInskBG/chG3I8vtY5cRZdPShAMOUw==
X-Google-Smtp-Source: APXvYqwHD6flFzXKrMf0P6AOyH2YhmVO+ZCIcgBlJFHi5CxYqW6Ny0jgkuv+zkonCC6P3TFSelBvKA==
X-Received: by 2002:aed:35e4:: with SMTP id d33mr5153477qte.389.1582724591340;
        Wed, 26 Feb 2020 05:43:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f7sm1082359qtj.92.2020.02.26.05.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 05:43:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j6wxy-000085-8A; Wed, 26 Feb 2020 09:43:10 -0400
Date:   Wed, 26 Feb 2020 09:43:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haim Boozaglo <haimbo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200226134310.GX31668@ziepe.ca>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
> 
> 
> On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > Hi all,
> > > 
> > > When running "ibstat" or "ibstat -l", the output of CA device list
> > > is displayed in an unsorted order.
> > > 
> > > Before pull request #561, ibstat displayed the CA device list sorted in
> > > alphabetical order.
> > > 
> > > The problem is that users expect to have the output sorted in alphabetical
> > > order and now they get it not as expected (in an unsorted order).
> > 
> > Really? Why? That doesn't look like it should happen, the list is
> > constructed out of readdir() which should be sorted?
> > 
> > Do you know where this comes from?
> > 
> > Jason
> > 
> 
> readdir() gives us struct by struct and doesn't keep on alphabetical order.
> Before pull request #561 ibstat have used this API of libibumad:
> int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
> 
> This API used this function:
> n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
> 
> scandir() can return a sorted CA device list in alphabetical order.

Oh what a weird unintended side effect.

Resolving it would require adding a sorting pass on a linked
list.. Will you try?

Jason
