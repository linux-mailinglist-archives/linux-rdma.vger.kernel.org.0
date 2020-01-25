Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAE1497B4
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 21:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAYUD4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 15:03:56 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43361 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAYUD4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jan 2020 15:03:56 -0500
Received: by mail-yb1-f194.google.com with SMTP id k15so2856109ybd.10
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jan 2020 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+wFR3uZ7e0CICi8LfcAYyqdeb4KUrt+Mb5OmETzXu5E=;
        b=JJtn7j3xDVvedsbRs8Ed9T9UN0QrBCW1uIN/BtAlGsZYj+Rht4sud23zWQeTxJkCT2
         v9XniTAJdPxGGj6t/EwjuAdVCzrlJLU3KiPj3wd3kXyEVDpFdEGJXK1OesnirIzoT2A9
         A/ojCkIdBLCscOo4OsTiNALC85E1LMmdF0cdc++3lRjHl2N92f5i8ZHbIE0xXSjTLe9U
         e2ULsnrbJluDAsDh2zFDbkQD4+QisDbAhhyPkYGznd3EOKiBsU22CY1MiWgHK1bN7dZG
         qlDJNHLqfH5i8qCZjpNJiZ7JJrbecffzBBu/XZH9PGLnIdDM+/TRjaM0OlgTGw4lPj/u
         9DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+wFR3uZ7e0CICi8LfcAYyqdeb4KUrt+Mb5OmETzXu5E=;
        b=bYXBZETcOf27toPciUPxj9qYI2tb9fy6bCuXhHJlotwOrvrCp19Bt7THS5c9BJ9Cbz
         avJKDyzp3n3AIXH1K5bF16/bIqWPh/CStDcFIt8Uj0d4pXSDCavPrd9SbJPJSoWEzpxZ
         s4lYqoLIv49lnD/wfwwT2n50fVLFi63ZCHLenSlXxNQkgkoX/YkM2otbg86F/ZAZI4n9
         78GZMaEwTQd+4cZLWLuAiPaEBhs2gXAogJU+Es2FcbJWpPbvL9k9u8chgjoIqNS4Tx+E
         ZWd0mUFMsZcC29ZUh4LGeG+kZuDJdmADcv4kz6g0xQYr2cHu68w8XjjbhynY2o+D+Qjv
         OPjg==
X-Gm-Message-State: APjAAAWo/KpVp0uzmMWNPrSOluACNHMSylpdUB7PdmNYw5j8ME3uLnzn
        3JbnC2D6xqL9f4JTISoAvMrGPA==
X-Google-Smtp-Source: APXvYqxGQJmCncjdVi8znycpkisKQz2cjNv0VOpDaKV8xxLumxTrblILa3t7ZXxesuBgeKH+lDB+Ig==
X-Received: by 2002:a25:8486:: with SMTP id v6mr7249499ybk.409.1579982634976;
        Sat, 25 Jan 2020 12:03:54 -0800 (PST)
Received: from ziepe.ca ([199.167.24.140])
        by smtp.gmail.com with ESMTPSA id u127sm3814391ywb.68.2020.01.25.12.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 12:03:54 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ivRen-0003Kx-R5; Sat, 25 Jan 2020 16:03:49 -0400
Date:   Sat, 25 Jan 2020 16:03:49 -0400
From:   Jason <jgg@ziepe.ca>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        leon@kernel.org
Subject: Re: [PATCH for-rc v2] IB/mlx4: Fix leak in id_map_find_del
Message-ID: <20200125200349.GA12627@jggl>
References: <20200123155521.1212288-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200123155521.1212288-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 23, 2020 at 04:55:21PM +0100, Håkon Bugge wrote:
> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
> 
> Since the VF drivers have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
> 
> Following the RDMA Connection Manager (CM) protocol, it is clear when
> an entry has to evicted from the cache. When a DREP is sent from
> mlx4_ib_multiplex_cm_handler(), id_map_find_del() is called. Similar
> when a REJ is received by the mlx4_ib_demux_cm_handler(),
> id_map_find_del() is called.
> 
> This function wipes out the TID in use from the IDR or XArray and
> removes the id_map_entry from the table.
> 
> In short, it does everything except the topping of the cake, which is
> to remove the entry from the list and free it. In other words, for the
> REJ case enumerated above, one id_map_entry will be leaked.
> 
> For the other case above, a DREQ has been received first. The
> reception of the DREQ will trigger queuing of a delayed work to delete
> the id_map_entry, for the case where the VM doesn't send back a DREP.
> 
> In the normal case, the VM _will_ send back a DREP, and
> id_map_find_del() will be called.
> 
> But this scenario introduces a secondary leak. First, when the DREQ is
> received, a delayed work is queued. The VM will then return a DREP,
> which will call id_map_find_del(). As stated above, this will free the
> TID used from the XArray or IDR. Now, there is window where that
> particular TID can be re-allocated, lets say by an outgoing REQ. This
> TID will later be wiped out by the delayed work, when the function
> id_map_ent_timeout() is called. But the id_map_entry allocated by the
> outgoing REQ will not be de-allocated, and we have a leak.
> 
> Both leaks are fixed by removing the id_map_find_del() function and
> only using schedule_delayed(). Of course, a check in
> schedule_delayed() to see if the work already has been queued, has
> been added.
> 
> Another benefit of always using the delayed version for deleting
> entries, is that we do get a TimeWait effect; a TID no longer in use,
> will occupy the XArray or IDR for CM_CLEANUP_CACHE_TIMEOUT time,
> without any ability of being re-used for that time period.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---

Applied to for-next, I think we are probably done with -rc right now, and it
doesn't have a fixes line or stable cc anyhow.

I added

Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")

Though

Jason
