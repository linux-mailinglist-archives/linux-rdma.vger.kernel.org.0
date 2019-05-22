Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74888264BE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 15:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfEVNbV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 09:31:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33994 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVNbV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 09:31:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so2326248qtp.1
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ubdejyfFBgV0NIxa0IaMgmmvtyVegJ/ZkuYOW157514=;
        b=NnLmXtPSYzEceOMQoRuWP641qVudVzMW/19gOubjZtrfqkVgACXGNZGkAHUrdNft+I
         ksdn37dKuYdktj9doBrCiEPsz0V8bp+UVQHTUw8K5Iqh/X3/Hgw0JD+wZWg9E95TVlM8
         xVGtdPjZqu3HBDl7nJksSB4AR5wSejgoKnBsjtWswL+O/IoQ+FEwEHk2fsjzCcreHHpQ
         J1TkC17gnQ9Ds/mQ99v9yvh9GNNI4DPboDc0RtFmOoCqw0FSNn63iTXmhaT5kOYEk4c2
         TZxIT0ojvgvQVxkrDoSRaAlOjnmBWmabYzF0FKZHm4nwuM3zdglaVBX9Uv/wqZfTcAyM
         38FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ubdejyfFBgV0NIxa0IaMgmmvtyVegJ/ZkuYOW157514=;
        b=Iazo2UHvnNi+ZCUUa6TFAazNazPla+Uqlvp7yT+IBqZYd6hlZNY4C2PejgKEVZTCGi
         o1ibFJ+mlGb7VmpuI3QwGKznbtSXO5/7JUvPHeguf4YQeKNMAyXz9+Qs7WMETJtMS85/
         YhenL2DnEkU54yrnLJu2s4ORA5tkndZ1mNFSggI/g2kawGPH/6KCatucFdHK1hNfbgTG
         C4h/aP/CtohY/e0cryeI/rPyryh/1sAh93GzCDIVLYjwLqfOMf7zEw7/N0OwWeoUfUny
         +iUZyqTB2dnJEPjizOxr9fWa2SFBN/ytJbXSFw0L8BBnmhYhWCAnCaQrw6SOnBe1qW6q
         rpBw==
X-Gm-Message-State: APjAAAW5KwmGTQnFlkmCkRCx+SV3xjxzFEvUuTwXKh2brBkZv3MZDI14
        ygUq36oluRrNBk9LF+hLFNtc4Q==
X-Google-Smtp-Source: APXvYqwJBzVXElj5c4CEyiXemjFUDGrp0sPhHNjY1cro2RgiSRoG/pIZ08A4USaFwYxK9AjHZvFDyg==
X-Received: by 2002:a0c:d642:: with SMTP id e2mr70526469qvj.5.1558531880156;
        Wed, 22 May 2019 06:31:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id l16sm10242130qtj.60.2019.05.22.06.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:31:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTRKx-0002aV-9y; Wed, 22 May 2019 10:31:19 -0300
Date:   Wed, 22 May 2019 10:31:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/core: Avoid panic when port_data isn't
 initialized
Message-ID: <20190522133119.GB6054@ziepe.ca>
References: <20190522072340.9042-1-kamalheib1@gmail.com>
 <20190522121513.GA6054@ziepe.ca>
 <970f7a5caea09680b8bd7861ce43782fc34c127d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970f7a5caea09680b8bd7861ce43782fc34c127d.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 03:42:47PM +0300, Kamal Heib wrote:
> On Wed, 2019-05-22 at 09:15 -0300, Jason Gunthorpe wrote:
> > On Wed, May 22, 2019 at 10:23:40AM +0300, Kamal Heib wrote:
> > > A panic could occur when calling ib_device_release() and port_data
> > > isn't initialized, To avoid that a check was added to verify that
> > > port_data isn't NULL.
> > 
> > This is a terrible commit message, describe the case that causes
> > this.
> > 
> 
> This happen if assign_name() return failure when called from
> ib_register_device() - The following panic will happen and in every
> function that touches the port_data's data members.

Then this should be the commit message, with the oops.

> > The check should be in ib_device_release(), not in the functions.
> > 
> > Jason
>
> Why?

Because if the device has not progressed to be setup enough we
shouldn't be freeing things that aren't started yet.

However, it is a bit weird because the cache_release was intended to
not have dependencies - but the cache also can't be started until the
port_data is setup

The real problem is that we can't allocate the port data during
ib_alloc_device..

Jason
