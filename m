Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0866725C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGLPaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 11:30:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36457 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfGLPaf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 11:30:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so8493610qtc.3
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YJ/+LW14h5PFSqCKr1eb/ddIgOkInv8e3XJEl7TjNcs=;
        b=YB+N3Q0nAevDPPyqzdRro0hFF255pqhq3sxHdslRe/U73Yzr0Iy5IvejuL7iEoNq4v
         ZS17zDqipea0ycOS+2aZwAbOnlf2d1H+55hNqY/Hg1h2oWylLuRCIg5qZOvy9MlFis9y
         soia7URUHky/SUl2qq91vz2DmE0hJRZUGOjH8LDKIQ217zh9Aj0v9kz0leXfj+zdr5GB
         TgiWzrQG2Et8HS5SZfphuZfqg3q1KPhKzELe3xOLHbQRYgWLnP+XYQ4/U2fk6Kp2mD5h
         rc/XKR9FjKNljo14zb8Ng4SKEULSgwUlQ04qvm/Ho5KUP7+gkRUtpgMxOh0NPqUwiq/N
         X7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJ/+LW14h5PFSqCKr1eb/ddIgOkInv8e3XJEl7TjNcs=;
        b=ZVFVfr/eco/ECiPqD/M9ZfGVH4A2z9JnFLFPBgZ7WwbZUTe7H7IqYeQBztexFgExZ3
         ye6m4Jg43d60QwGe8C5K/akTgRXJTUtwTz81IL8zirZh9p90i2z0Fv5N7GInAtaO01V+
         Ip1s5zae8L2um21J7LmgpfiKGtTy8PA9Y0f8wzvR+LqgDxSla429u6xhtPQiH+9L5wr9
         wWHEZZRjYXzYSld3FvGxFiRfgRpt4IkO9Fk+cYm1pqVKPxcSUrxso41m3v81R8LGuLH3
         Y7I08T33Bv4j9Uqasq/Axbyf+5LwYhUMks4TO97VolSj1By59X+ihjRngqnbk4uTq2nf
         1Bug==
X-Gm-Message-State: APjAAAVMC+dmb6c62Q1G41mtYYAGMISU5fClzKSPvGQcgVhWNNNJXlHA
        RL0MCYmZ5sKMl4NhjzlB8boP5Q==
X-Google-Smtp-Source: APXvYqzzTtDX3314BAZra1NA9rbfqxeByCyDxshGoomklGXOLXWgmHSeRnm1XFBKa1tSqpmNah/FvA==
X-Received: by 2002:a0c:d610:: with SMTP id c16mr7361366qvj.22.1562945433793;
        Fri, 12 Jul 2019 08:30:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i5sm3306946qtp.20.2019.07.12.08.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 08:30:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlxVI-0002Sf-VE; Fri, 12 Jul 2019 12:30:32 -0300
Date:   Fri, 12 Jul 2019 12:30:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>,
        "monis@mellanox.com" <monis@mellanox.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: User SIW fails matching device
Message-ID: <20190712153032.GH27512@ziepe.ca>
References: <20190712142718.GA26697@chelsio.com>
 <20190712143546.GD27512@ziepe.ca>
 <20190712152418.GA16331@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712152418.GA16331@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 08:54:20PM +0530, Potnuri Bharat Teja wrote:
> On Friday, July 07/12/19, 2019 at 20:05:46 +0530, Jason Gunthorpe wrote:
> > On Fri, Jul 12, 2019 at 07:57:19PM +0530, Potnuri Bharat Teja wrote:
> > > Hi all,
> > > I observe the following behavior on one of my machines configured for siw.
> > > 
> > > Issue:
> > > SIW device gets wrong device ops (HW/real rdma driver device ops) instead of
> > > siw device ops due to improper device matching.
> > > 
> > > Root-cause:
> > > In libibverbs, during user cma initialisation, for each entry from the driver 
> > > list, sysfs device is checked for matching name or device.
> > > If the siw/rxe driver is at the head of the list, then sysfs device matches 
> > > properly with the corresponding siw driver and gets the corresponding siw/rxe 
> > > device ops. Now, If the siw/rxe driver is after the real HW driver cxgb4/mlx5 
> > > respectively in the driver list, then siw sysfs device matches pci device and 
> > > wrongly gets the device ops of HW driver (cxgb4/mlx5).
> > > 
> > > Below debug prints from verbs_register_driver() and driver_list entries, where 
> > > siw is after cxgb4. I see verbs alloc context landing in cxgb4_alloc_context 
> > > instead of siw_alloc_context, thus breaking user siw.
> > > 
> > > <debug> verbs_register_driver_22: 184: driver 0x176e370
> > > <debug> verbs_register_driver_22: 185: name ipathverbs
> > > <debug> verbs_register_driver_22: 184: driver 0x176f6a0
> > > <debug> verbs_register_driver_22: 185: name cxgb4
> > > <debug> verbs_register_driver_22: 184: driver 0x176fd50
> > > <debug> verbs_register_driver_22: 185: name cxgb3
> > > <debug> verbs_register_driver_22: 184: driver 0x1777020
> > > <debug> verbs_register_driver_22: 185: name rxe
> > > <debug> verbs_register_driver_22: 184: driver 0x1770a30
> > > <debug> verbs_register_driver_22: 185: name siw
> > > <debug> verbs_register_driver_22: 184: driver 0x1771120
> > > <debug> verbs_register_driver_22: 185: name mlx4
> > > <debug> verbs_register_driver_22: 184: driver 0x1771990
> > > <debug> verbs_register_driver_22: 185: name mlx5
> > > <debug> verbs_register_driver_22: 184: driver 0x1771ff0
> > > <debug> verbs_register_driver_22: 185: name efa
> > > 
> > > <debug> try_drivers: 372: driver 0x176e370, sysfs_dev 0x1776b20, name: ipathverbs
> > > <debug> try_drivers: 372: driver 0x176f6a0, sysfs_dev 0x1776b20, name: cxgb4
> > > <debug> try_drivers: 372: driver 0x176fd50, sysfs_dev 0x1776b20, name: cxgb3
> > > <debug> try_drivers: 372: driver 0x1777020, sysfs_dev 0x1776b20, name: rxe
> > > <debug> try_drivers: 372: driver 0x1770a30, sysfs_dev 0x1776b20, name: siw
> > > <debug> try_drivers: 372: driver 0x1771120, sysfs_dev 0x1776b20, name: mlx4
> > > <debug> try_drivers: 372: driver 0x1771990, sysfs_dev 0x1776b20, name: mlx5
> > > <debug> try_drivers: 372: driver 0x1771ff0, sysfs_dev 0x1776b20, name: efa
> > > 
> > > Proposed fix:
> > > I have the below fix that works. It adds siw/rxe driver to the HEAD of the 
> > > driver list and the rest to the tail. I am not sure if this fix is the ideal 
> > > one, so I am attaching it to this mail.
> > 
> > Update your rdma-core to latest and this will be fixed fully by using
> > netlink to match the siw device..
> > 
> I pulled the latest rdma-core, still see the issue.
> 
> commit 7ef6077ec3201f661458297fea776746ba752843 (HEAD, upstream/master)
> Merge: 837954ff677c 95934b61a74e
> Author: Jason Gunthorpe <jgg@mellanox.com>
> Date:   Thu Jul 11 16:18:06 2019 -0300
> 
>     Merge pull request #539 from jgunthorpe/netlink
> 
>         Use netlink to learn about ibdevs and their related chardevs
> 
> 
> Is there any corresponding kernel change or package dependency? I am currently 
> on Doug's wip/dl-for-next branch.

That should be good enough for the kernel.. Hmm.. The siw stuff didn't
get updated, you need this rdma-core patch too. Please confirm

diff --git a/providers/siw/siw.c b/providers/siw/siw.c
index 23e4dd976caf84..41f33fa16123e9 100644
--- a/providers/siw/siw.c
+++ b/providers/siw/siw.c
@@ -907,7 +907,7 @@ static void siw_device_free(struct verbs_device *vdev)
 }
 
 static const struct verbs_match_ent rnic_table[] = {
-	VERBS_NAME_MATCH("siw", NULL),
+	VERBS_DRIVER_ID(RDMA_DRIVER_SIW),
 	{},
 };
 
