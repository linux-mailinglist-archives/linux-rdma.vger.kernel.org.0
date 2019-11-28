Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB910C3CD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2019 06:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfK1FwK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Nov 2019 00:52:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37755 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfK1FwJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Nov 2019 00:52:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so5526519otn.4;
        Wed, 27 Nov 2019 21:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=MdEQJsY/Utok4Nn4+LSSZV9QETD4DTsPXrGDp9ayac4=;
        b=Z3NN7fiHFI9tkEJAgOlXc51rDZn+xxgMgdk7rPkm9wgF4Zz+vN7+/qRf7w68iU0HqU
         tR53nYsKhSUS7MzbIxv1z6l+WafuABRpWjliag64+oXmT44ZS5s56lTO+6mrhoWRRsju
         Klbt3nY54+8Li5g0+aYbfmu6ZHajsExFHUw6OPuvB8ExHiXpU92jAQ0+7vIJpGvNxEEH
         2q6aY+dRWWDRM9igBG52X1ZAwdREsfDG8xlB0q+lXOKvImYblnPlueY10Nuwh0ThP1rP
         f8WmfTQ4vJ/qa2CibOatlR+zpSJiYoGsEw6rdOep/88R8M8qMnlJ5DgQiMgjUGnSGboZ
         MeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=MdEQJsY/Utok4Nn4+LSSZV9QETD4DTsPXrGDp9ayac4=;
        b=b185ckKuy5QCIcV2HuLwvIY1GGHiCZj+5/l0XUI+SaWEtGS9omfZ42BVxf5aiuR0TZ
         mixibzGPcY1q1ndu63hLJ7l4THwXV91rWgkzQ8RJDu6Ly1lQu36wsvqrRuEyaKKOAQS6
         utYLgHPcUzk2yukOc8n49DxUo8lLTywqaAhY1wEvuMJo/4P2gaOQr4QUOeNQV4Jzbodj
         cyRJo4ICmndHcKR2FNnthxiIliexkjzXVajhonMzDdhOvZ3uciv7S+pE0qbsdHekJwAZ
         dD3yoFKop5nJ1jYkMTfdkyDBQXx5JFUJcfnXjbWItviG5digyfhYNVzhIBAhkfP6BbSA
         e/Sw==
X-Gm-Message-State: APjAAAWq9pyysncPKCRHqbODvUnQWeCV6+TnC7smM7pJDEB2rgyksyaq
        mHJjtKW1jI59p+REdO+bB1K5ajOBCrdaZ2GSGl8=
X-Google-Smtp-Source: APXvYqzInsY7hophOQP2+nEZGGNXBok7RANKqxBeOZYae1OgjLLxGPRqV70MTIeInLmoCGA432X8l3eaGcInyEDdSxg=
X-Received: by 2002:a05:6830:1158:: with SMTP id x24mr6121936otq.109.1574920328102;
 Wed, 27 Nov 2019 21:52:08 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p> <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <CAAFE1bdGCx96tLKgSkNf7=MDZEZMnC==PJghpsRctvZpPLaX5w@mail.gmail.com>
In-Reply-To: <CAAFE1bdGCx96tLKgSkNf7=MDZEZMnC==PJghpsRctvZpPLaX5w@mail.gmail.com>
Reply-To: Rob.Townley@gmail.com
From:   Rob Townley <rob.townley@gmail.com>
Date:   Wed, 27 Nov 2019 23:51:56 -0600
Message-ID: <CA+VdTb-HTXidfFVmzV2ynJgOGdmb-Ps=j9vQfZ-iZBPFm4RWJg@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Interesting case to follow as there are many types of RamDisks.  The
common tmpfs kind will use its RAM allocation and all free harddrive
space.

The ramdisk in CentOS 7 backed by LIO will overflow its size in RAM
and fill up all remaining free space on spinning platters.  So if the
RamDisk is 4GB out of 192GB RAM in the lightly used machine. Free
filesystem space is 16GB.  Writes to the 4GB RamDisk will only error
out at 21GB when there is no space left on filesystem.

dd if=/dev/zero of=/dev/iscsiRamDisk
Will keep writing way past 4GB and not stop till hardrive is full
which is totally different than normal disks.

Wonder what exact kind of RamDisk is in that kernel?

On Wed, Nov 27, 2019 at 10:26 PM Stephen Rust <srust@blockbridge.com> wrote:
>
> [Apologies for dup, re-sending without text formatting to lists]
>
> Hi,
>
> Thanks for your reply.
>
> I agree it does seem surprising that the git bisect pointed to this
> particular commit when tracking down this issue.
>
> > Stephen, could you share us how you setup the ramdisk in your test?
>
> The ramdisk we export in LIO is a standard "brd" module ramdisk (ie:
> /dev/ram*). We configure it as a "block" backstore in LIO, not using
> the built-in LIO ramdisk.
>
> LIO configuration is as follows:
>
>   o- backstores .......................................................... [...]
>   | o- block .............................................. [Storage Objects: 1]
>   | | o- Blockbridge-952f0334-2535-5fae-9581-6c6524165067
> [/dev/ram-bb.952f0334-2535-5fae-9581-6c6524165067.cm2 (16.0MiB)
> write-thru activated]
>   | |   o- alua ............................................... [ALUA Groups: 1]
>   | |     o- default_tg_pt_gp ................... [ALUA state: Active/optimized]
>   | o- fileio ............................................. [Storage Objects: 0]
>   | o- pscsi .............................................. [Storage Objects: 0]
>   | o- ramdisk ............................................ [Storage Objects: 0]
>   o- iscsi ........................................................ [Targets: 1]
>   | o- iqn.2009-12.com.blockbridge:rda:1:952f0334-2535-5fae-9581-6c6524165067:rda
>  [TPGs: 1]
>   |   o- tpg1 ...................................... [no-gen-acls, auth per-acl]
>   |     o- acls ...................................................... [ACLs: 1]
>   |     | o- iqn.1994-05.com.redhat:115ecc56a5c .. [mutual auth, Mapped LUNs: 1]
>   |     |   o- mapped_lun0  [lun0
> block/Blockbridge-952f0334-2535-5fae-9581-6c6524165067 (rw)]
>   |     o- luns ...................................................... [LUNs: 1]
>   |     | o- lun0
> [block/Blockbridge-952f0334-2535-5fae-9581-6c6524165067
> (/dev/ram-bb.952f0334-2535-5fae-9581-6c6524165067.cm2)
> (default_tg_pt_gp)]
>   |     o- portals ................................................ [Portals: 1]
>   |       o- 0.0.0.0:3260 ............................................... [iser]
>
> > > > Could you explain a bit what is iSCSI attached with iSER / RDMA? Is the
> > > > actual transport TCP over RDMA? What is related target driver involved?
>
> iSER is the iSCSI extension for RDMA, and it is important to note that
> we have _only_ reproduced this when the writes occur over RDMA, with
> the target portal in LIO having enabled "iser". The iscsi client
> (using iscsiadm) connects to the target directly over iSER. We use the
> Mellanox ConnectX-5 Ethernet NICs (mlx5* module) for this purpose,
> which utilizes RoCE (RDMA over Converged Ethernet) instead of TCP.
>
> The identical ramdisk configuration using TCP/IP target in LIO has
> _not_ reproduced this issue for us.
>
> > > > /usr/share/bcc/tools/stackcount -K rd_execute_rw
>
> I installed bcc and used the stackcount tool to trace rd_execute_rw,
> but I suspect because we are not using the built-in LIO ramdisk this
> did not catch anything. Are there other function traces we can provide
> for you?
>
> Thanks,
> Steve
