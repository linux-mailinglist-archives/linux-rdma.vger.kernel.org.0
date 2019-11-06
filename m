Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B018F1C25
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 18:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfKFRJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 12:09:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36854 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfKFRJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 12:09:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id y10so27691173qto.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 09:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s0wXjoECgJEHI557PFr2vQvssP7tqwtDmiQYgTbhvN0=;
        b=gnJoFtlLinE56nooky0YFHJkFLOMnARKcXM1iSYkZttFs73V70gFsM+OZhcHnzjHih
         XHaPtqwk00l1UL9EWuwfHuJ6e4j3Ucb2NvAC+PJDaafcOingCXTxmFkd0zgilspa7ebW
         NZZ84GDCX4svHE09ZvJCLpkPb5xu9XBWqoTg1G6zmLgpyj5hioSXONmEGGscPhtmsYTk
         MZ8wMh6BYLt+P/dT6rD3FKPy4UW1rkUXSBRNak9Bx0wkXA5QcQK3r1iKhtQkngu5IY+P
         PfxBTRc+t0cv7LrJDbMNUJj2QrA1uOQyB7dKrQhX8gFBpAr1kWMOne8Aywe9SCEzybpk
         rZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0wXjoECgJEHI557PFr2vQvssP7tqwtDmiQYgTbhvN0=;
        b=SAEc/FUKgI9A7hj2UUqA71r3EwJXuWLgMxskleOSU2VYFHICA52jX6AsBNtJO0Wd3V
         q1Z6+W65lcbx8BYIHi0F1zifaNxkSsGfdXJNLUvDCJzp0TPsLdIcf/gS1vy/RLcCRTPm
         o4jkxCp6FIcYWjO36DYIG63lXWcFMHCPOffjZLpoUNGkc+8iHmbcGr/hVH1xwPAE8PcN
         na5y7ZZLA1V93kgRTl6EqpMzNgKOjn0Jmd1G57HbCNhccVZVV2s1w8pzYmIdPlrJFxil
         OZvc5fqTTMQjn0lxR+le0kSquDGmQ0RZ3fr0sPat7o/wkNgOYGXpuw1PzIpEQOxdfk/R
         xlsg==
X-Gm-Message-State: APjAAAWKBDS51+0I3XrqTosZDvp7vs91QZDNDDbWXb16If+J+yAz/UUi
        6Z+pses+cDBgQ5c7fJ+2ajESyQ==
X-Google-Smtp-Source: APXvYqx5YmDlLJQOZPI5Rtg40K544LuG+AoOAQRvJHUShD+rfmlTutHQT8iqFQ9pF7rUo2ucIPeX8w==
X-Received: by 2002:ac8:6b07:: with SMTP id w7mr3514223qts.348.1573060151757;
        Wed, 06 Nov 2019 09:09:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k3sm15244544qtf.68.2019.11.06.09.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 09:09:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSOnu-0004x2-IU; Wed, 06 Nov 2019 13:09:10 -0400
Date:   Wed, 6 Nov 2019 13:09:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v12 rdma-next 0/8] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Message-ID: <20191106170910.GC15851@ziepe.ca>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191105204144.GB19938@ziepe.ca>
 <MN2PR18MB318254AD4C7254E12BE970ECA1790@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB318254AD4C7254E12BE970ECA1790@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 01:04:58PM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > 
> > On Wed, Oct 30, 2019 at 11:44:09AM +0200, Michal Kalderon wrote:
> > > This patch series uses the doorbell overflow recovery mechanism
> > > introduced in commit 36907cd5cd72 ("qed: Add doorbell overflow
> > > recovery mechanism") for rdma ( RoCE and iWARP )
> > >
> > > The first six patches modify the core code to contain helper functions
> > > for managing mmap_xa inserting, getting and freeing entries. The code
> > > was based on the code from efa driver.
> > > There is still an open discussion on whether we should take this even
> > > further and make the entire mmap generic. Until a decision is made, I
> > > only created the database API and modified the efa, qedr, siw driver
> > > to use it. The functions are integrated with the umap mechanism.
> > >
> > > The doorbell recovery code is based on the common code.
> > >
> > > rdma-core pull request #493 was closed for now, once kernel series is
> > > accepted will be reopend.
> > >
> > > This series applies over the wip/jgg-for-next branch and not the
> > > for-next since it contains the series:
> > > RDMA/qedr: Fix memory leaks and synchronization
> > > https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__www.spinics.net_l
> > > ists_linux-
> > 2Drdma_msg85242.html&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=7Y
> > > unNpwaTtA-
> > c31OjGDRljIVVAwuEHIfekR2HBOc7Ss&m=L5mJN0hgrbvf3DM5YqnWV_SP8x
> > > T4w4-
> > EglZvbLfNeac&s=vhHBEGZnBPmT8qnK6mkfWyDGgjuTscDayoTdsqEe4Sk&e=
> > >
> > > SIW driver was reviewed, tested and signed-off by Bernard Metzler.
> > 
> > Since we are on v12 now, let us get this done. I added this diff to the series.
> > Mostly just renaming, indenting, the notes I gave already (to all drivers) and
> > probably a few other things I forgot
> > 
> > Here is the series with everything reflowed hopefully properly:
> > 
> > https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__github.com_jgunthorpe_linux_commits_rdma-
> > 5Fmmap&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=7YunNpwaTtA-
> > c31OjGDRljIVVAwuEHIfekR2HBOc7Ss&m=L5mJN0hgrbvf3DM5YqnWV_SP8xT
> > 4w4-EglZvbLfNeac&s=Msa-
> > ckgjuOMPVTodTsdmuiOIg88xQUn0zXYiXybrGv4&e=
> > 
> > Please let me know if I messed it up, otherwise I'll apply this in a few days.
> Thanks Jason. One small comment is that the length field was removed from siw + efa 
> But not qedr_user_mmap_entry, I can also send a patch after to fix this. 
> And one small insignificant typo below
> 
> Other than that all fixes look good, thanks.
> Tested-by: Michal Kalderon <michal.kalderon@marvell.com>

Okay, applied to for-next

Thanks,
Jason
