Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD55D164B40
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSQ6D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 11:58:03 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33345 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSQ6D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 11:58:03 -0500
Received: by mail-qv1-f68.google.com with SMTP id ek2so502686qvb.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 08:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQ+Q+kgtGsaunnkMDG90s8siK/SunXcw/NsEpFdg5HQ=;
        b=fKvCxVSj+EbNWXgPujE1+G8D6FZ2N+IxoP8t/MpOS8Ym3+1NFlJqEfLgJuSXX1CRnl
         5Wyspj1sUUQ1yJ/3iuzSMx9fYpX69iRMpcBWdJMQPb3LSczZW40gMHadG/YmEvQJmWym
         61OI+R4reNumnLigEkscAP5r7PgdM8Vl741A+o/sUKQwrGXfz02GkymOQydxM7oQI2c+
         wi2L5uIBwRHKRsWw4g5JPZJvn3Gc1IwtjIccZtlw0CLCBnAlYIY8wXqVwKAeOrjfP+4b
         pPEbONUQGEVZe05uJahBVhdTl95QRGhX9EfzOYEWBcSxx0BWlsNMf4oCWzfqqxG2Zn5T
         q8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQ+Q+kgtGsaunnkMDG90s8siK/SunXcw/NsEpFdg5HQ=;
        b=RLt0gm0QFcjAMRYMZ1wO587a1ZlklBcG1BJQ+wax4y6nvTiW5DEW2qkmuiC8JNJI8N
         CJ2A0UYwpiN3Npg9UPZVYKLPgzTKfoQ1UHjGFr6VXR+ecdGkqWuvh46zAp6Cw5prSxI5
         jNljHcQNgKmYHHTdijc2DCPXoPi3zHg0s+YUb5LQFAaWH0DW2A+0DWSv/ieetJ5FMOSn
         mjD+0E33C6yLzjFap8r07e2BqoScnpXIKsLri0N9gSCQfKmCRF/yJu7whshFZDzRGcrW
         3On34vi/U61W1e5I68KHsszaCxj1PpfC+nxOhdWCwkoT8dEa+avcX5zrP8JoGNlEHSPy
         IOgw==
X-Gm-Message-State: APjAAAW/piSeJNRDk+Kv9CSmMEGvhs2gduF7/wP5quTl/QSeTiahjJaw
        2EjiOd1wzgU5LgpgMLi1QQngLg==
X-Google-Smtp-Source: APXvYqzcgcFV7210H7HHj8aLJBMm+ntG4o2wUYQ0gxgvJ0rTVlzhIOOfIjIHvVjc0eTy2s6ZbgIk8A==
X-Received: by 2002:a05:6214:9d2:: with SMTP id dp18mr21341622qvb.98.1582131481771;
        Wed, 19 Feb 2020 08:58:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x3sm275715qts.35.2020.02.19.08.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 08:58:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4Sfg-0005CW-6K; Wed, 19 Feb 2020 12:58:00 -0400
Date:   Wed, 19 Feb 2020 12:58:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: RDMA device renames and node description
Message-ID: <20200219165800.GS31668@ziepe.ca>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
 <20200219071129.GD15239@unreal>
 <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 09:14:06AM -0500, Dennis Dalessandro wrote:

> > ABI breakage is a strong word, luckily enough it is not defined at all.
> > We never considered dmesg prints, device names, device ordering as an
> > ABI. You can't rely on debug features too, they can disappear too.
> 
> Agree, it is a strong word and we can call it what you want. The point is
> you should be able to rely on the node description not being changed out
> from under you unnecessarily though. We aren't talking about a debug feature
> here but a core feature to real world deployments.

People really use the node description as some stable name? And then
they put the HCA name in it? Why?

Is that some thing unique to the OPA subnet manager?

I don't recall people complaining about this when we introduced
rdma-ndd by default and changed all the node descriptions away from
the kernel default.

Also don't forget the whole thing about the node description is
inherently racey, so relying on it is Rather A Bad Idea.

Should we change the default format string of rdma-ndd to something
else?

Jason
