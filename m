Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAEF42BDF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfFLQP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 12:15:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43702 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfFLQP0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 12:15:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so5891742qtj.10
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=paGHCTOWr6l7bHibRWC/XApw0xdEDt07/RrUptJSS20=;
        b=XkwYaZjL/ZXb332KhDCY3d42o8leXtyoYjCHc5NwozYhvOCYt91OTT/FGM8dAJx0y2
         g06Cuy78RRtoBRgdQILzIw2Pf5ZOhMt3Rv4vbN1JZ6oodJDuF9+VIkdEpbvB3L00WGcx
         SJr0NnHdVNrzG2gjiV2idN1BkSpu0/ka5IJC+1XDJLaPncWtQnfMv033EaEJHvUbfM5Q
         Sx+rotYna4PET9hpDSVlpz4YGr4d92QlrjnGrTK4HWpe8IGB318bVC1wCvhvHJUbv2xp
         ojrwz6a+Bv0Y+vWlW4ZcXLAHkWPai44czAc6m/GcdsiUGL0mpGkhEz5NIcJg+pIwk9AB
         +LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=paGHCTOWr6l7bHibRWC/XApw0xdEDt07/RrUptJSS20=;
        b=YJLgnAowSzurOdwGNoVktN38nQmfbaU6vtUDaJgMubGUO+4MHDg5i6Mi2f+4Jm/orp
         KmItSS2e9Fgtjql0JIxgRJODr7FIZoqt9aVfICo3ewVjyvUMiwHwUvEWEOWGwzKbqmXS
         y2Rf7fxOgwwTNymmmwn/Gjy+QodoASoNfxpFmdetFmi3B93nkfKDQyMPysKCgpWX0rBd
         UNSop1xaJSnBagU9ra7WkGjMsclFnotkN013LjpR43KyfhohWA28/VcQvlelx418ooY9
         MSn+7+tuowtRReD8AqQWO/QA85YJ/zVc6AgyFnL6zeWpNRmQHOetMQ/uCuzDP9aGFYsa
         alzw==
X-Gm-Message-State: APjAAAXH/WiLdcCnIrrBIWs5yo0QVZJ0QOtfr3/TCYbIu7l0heXVtK5d
        ZMTsvmVg/xjfheJ4+8HlBRkgng==
X-Google-Smtp-Source: APXvYqyzYODiP/rMpbP9oOQFCMp6eD/sEKlRUMtgvWIeM4/ovb9V8TW1dut45EooIlOWofNDykYPgg==
X-Received: by 2002:aed:2a39:: with SMTP id c54mr72115876qtd.272.1560356125650;
        Wed, 12 Jun 2019 09:15:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d31sm170516qta.39.2019.06.12.09.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:15:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb5uG-0004KI-NE; Wed, 12 Jun 2019 13:15:24 -0300
Date:   Wed, 12 Jun 2019 13:15:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Elrod <elrodc@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Failed to enable unit: Unit file rdma.service does not exist
Message-ID: <20190612161524.GK3876@ziepe.ca>
References: <CA+pTmbCAd47NbJ0=QxwUHZRtyqdx61sFv6P8nyRPtxi-mk_A4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+pTmbCAd47NbJ0=QxwUHZRtyqdx61sFv6P8nyRPtxi-mk_A4Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 01:23:12AM -0500, Chris Elrod wrote:
> - Linux distribution and version
> Clear Linux (29870)
> 
> - Linux Kernel and version
> 5.1.8
> 
> - InfiniBand hardware and firmware version
> Hardware version: MCX354A-FCBT (FDR)
> Firmware version: 2.42.5000
> 
> Problem:
> $ systemctl enable rdma
> Failed to enable unit: Unit file rdma.service does not exist.
> 
> More background:
> I have 3 computers and 3 cards. Each card has 2 ports, so I'd like to
> directly link each computer and use infiniband with (Open)MPI.
> 
> Clear Linux's package manager provides rdma and rdma-core, but doesn't
> provide rdma.service. I do not see a /usr/libexec/rdma-init-kernel,
> either.
> (Same story with other packages, like opensm).
> I made a comment on the Clear Linux community forum, and was told:
> 
> """Upstream does not provide these files, and this is explained by the
> age of the project and the amount of development activity.

rdma.service is obsolete. It is only provided for redhat to support
old redhat conventions. We should be removing it now from latest
Fedora.

The default install of rdma-core should provide all the systemd stuff
you need.

Jason
