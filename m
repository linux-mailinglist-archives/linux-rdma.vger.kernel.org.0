Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B642E22F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE2QVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 12:21:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41394 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE2QVr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 12:21:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id m18so1847287qki.8
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VR2xIVjeFoIDnTk+v1rLSWavlYJiSWLM8rXI+0jnq7U=;
        b=dOTe+0UqDsC6Qkb8oUsMiD+bX4JJ4nxvAPzjqEmpcEEUXQFKgHn3gBZklRY1jufA/S
         B2gbsBc4QmgDrOIE+ulti191sF7w38xUdnKnCdY+6TFlPgEc1zVD1uDbZilDKO+YLvcq
         OffsJW9NOajlIXQzZkAHMB7XWVPB+n/f28m6i3QvNuhoOtjtydMJgaX1/B3tO9kFsR/J
         /2njPNYPOmCozsVnI164mrIeSkB2naZWXNOx+5Ah3g2Ut7LWYjNA2TUe/a6+ng8dkQTn
         TBnwwMpTq0SrtKsKU4l0/gXm12Z85PbyV6K6LKoV8MI+3DwjLHtX8QJ+xmyRPGpWqATy
         al3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VR2xIVjeFoIDnTk+v1rLSWavlYJiSWLM8rXI+0jnq7U=;
        b=IM/qNE+qPsRuscXeQikaOIPxTZZtqLnGwvUgqIh2L4N2iCuiqCMfAGWXLsJCEVbbaN
         ZzhNBNpp2aAz2bSlOZwhwOktTj6uoS1njdCc6WLJ+dhX3ot2736Q+PRQIhhBA31JZz1r
         SD5rnpPEmLOic4q3S0L2/nXnsY4N/Z8MGTYWnCG6ss/z/aXGfYfKRwALEMF48L690iJd
         /Tg6XmHlPmKuQzcKiYCP7EFW8XWzxz2zAVYiWI9KT4Gq4RUHiLEdOUyWbT5YNh/IXV3v
         yemWz10Vm0iHDaxd2/AISpcrTk4G1uZ9uA/HDeVT+MUyuKQPkiYIdsFE/91/l9LavLj/
         P4Cw==
X-Gm-Message-State: APjAAAXVncafuwPSeFY4JiWBjsxSZpNyg2CZD5Jk/U4Xe0+81AP9QUzf
        8XLTEnDCohwu8CbTzzfx8rPcWQ==
X-Google-Smtp-Source: APXvYqxTsTibmqmvZVaPrC+yAHtcRbkj9oUKlHGHpF2P+DdDCAwc22d+355F1j4YLvlGxo5WOXuYkA==
X-Received: by 2002:a37:9904:: with SMTP id b4mr8455424qke.159.1559146906189;
        Wed, 29 May 2019 09:21:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q24sm9072653qtq.58.2019.05.29.09.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 09:21:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hW1Kj-0004mS-E0; Wed, 29 May 2019 13:21:45 -0300
Date:   Wed, 29 May 2019 13:21:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/6] EFA updates 2019-05-28
Message-ID: <20190529162145.GA18348@ziepe.ca>
References: <20190528124618.77918-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528124618.77918-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 03:46:12PM +0300, Gal Pressman wrote:
> Hi,
> 
> This series introduces misc updates that were discussed on-list to the
> EFA driver.
> 
> I've sent this series to for-rc as EFA is a new driver and there's no
> real regression danger here, but I'm fine with applying these changes to
> for-next instead.
> 
> Thanks,
> Gal
> 
> Gal Pressman (6):
>   RDMA/efa: Remove MAYEXEC flag check from mmap flow

This is the only one worth going to -rc

>   RDMA/efa: Use kvzalloc instead of kzalloc with fallback
>   RDMA/efa: Remove unneeded admin commands abort flow
>   RDMA/efa: Use rdma block iterator in chunk list creation
>   RDMA/efa: Remove unused includes

This went to for-next

>   RDMA/efa: Use API to get contiguous memory blocks aligned to device
>     supported page size

This one needs some discussion

Thanks,
Jason
