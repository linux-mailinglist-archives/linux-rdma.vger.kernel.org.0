Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6115C36F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 16:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBMPlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 10:41:16 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:38355 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbgBMPlM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 10:41:12 -0500
Received: by mail-qv1-f49.google.com with SMTP id g6so2809012qvy.5
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jT3cAplalBsHXqFQEQezOBdWGmXbVIEQoDbco060oc=;
        b=h/Ek4/ymxuamoS1q3MBblRuZLjAf88LX71IRn2aGdnwjAJ43aFz2Ytd72zMhch0HOP
         VYPnTKqbyzHMLrO1dB2OFvwoJyT8VT7ncKWPQf/rkQzaF6GtZQZROyTB5Qncglhvvxtr
         4xUvoeZwckri4mg6/CszVtbLYWWcDRlDUFuaK1u6hurBmgYEPQM9lWT7UFtei0SYMc3E
         1vOw3EaAMcUgsKcs4HWGpJGZdQ+Jz3ZRzLufw9l0RCyQ/Mi021hnXI229SBFTouXTTVh
         h3EUNiVHhjmrH5uszPwaQ2JfhbuN/xC4mTHIde7CN6Ze+lAyPrkqXY/vx3p96JEC6+d+
         NoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jT3cAplalBsHXqFQEQezOBdWGmXbVIEQoDbco060oc=;
        b=bdAN1P5SFLKY1TiRbEXuLKtxZcsKTpDbMRn/IzHykOPp5qmM77UVbFDHK+zVLSSgBQ
         D3KWNv4MoD8ofVPiFBRhLY9+0s8JMVBlXClH+Jgvj9o2pKO76UuvHGu9IhTVZabKyN3O
         t5SJKrFWWR8PKlauDYn7BFIcNOOkG5EA2uf1zedciGoNyxFcPV9Kyd1HAEfDiHjXI4Gm
         KR523w0/2nMnu6TL0exxC2L3ZMntu2I3A8xTatcnnVuo/kwH1hSw3w/lAwey/Gnu/ok4
         HLzHe1S6vBr7cwnG4pK0hZ27KE320L5uAA+y2MupUkaJ+OSMvji4nFV6hBg+ASTj1Mbx
         tsZA==
X-Gm-Message-State: APjAAAXX+rn0zFapVTCbRezLl4LvQJ09gIQLTr2lteNSIxGtknRQ6Nt+
        1sC7gwbr1YoPUQmifKNyXXJ05A==
X-Google-Smtp-Source: APXvYqx62tqS+BPFVJXCaiCayzyjfsOvlr5t3l7kK9/NFz3+376Ie16gtHhiuaTtjBnERjRrvz+ujw==
X-Received: by 2002:a05:6214:146e:: with SMTP id c14mr12338636qvy.82.1581608471867;
        Thu, 13 Feb 2020 07:41:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v82sm1520396qka.51.2020.02.13.07.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 07:41:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2Gc2-0005W6-Mv; Thu, 13 Feb 2020 11:41:10 -0400
Date:   Thu, 13 Feb 2020 11:41:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Alex @ Mellanox" <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Message-ID: <20200213154110.GJ31668@ziepe.ca>
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
 <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
 <CAFgAxU80+feEEtaRYFYTHwTMSE6Edjq0t0siJ0W06WSyD+Cy3A@mail.gmail.com>
 <b0414c43-c035-aa90-9f89-7ec6bba9e119@talpey.com>
 <CAFgAxU-LW+t17frRnNOYgoaqJEwffRPfFDasOPjbyVmuxj8AXA@mail.gmail.com>
 <09478db9-28ca-65fe-1424-b0229a514bbb@talpey.com>
 <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 10:26:09AM -0500, Tom Talpey wrote:

> > If both src & dst ports are in the high value range you loss those
> > hash bits in the masking.
> > If src & dst port are both 0xE000, your masked hash equals 0. You'll
> > get the same hash if both ports are equal 0xF000.
> 
> Sure, but this is because it's a 20-bit hash of a 32-bit object. There
> will always be collisions, this is just one example. My concern is the
> statistical spread of the results. I argue it's not changed by the
> proposed bit-folding, possibly even damaged.

I've always thought that 'folding' by modulo results in an abnormal
statistical distribution

The point here is not collisions but to have a hash distribution which
is generally uniform for the input space.

Alex, it would be good to make a quick program to measure the
uniformity of the distribution..

Jason
