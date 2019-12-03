Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFFE10F561
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 04:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLCDEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 22:04:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44552 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCDEc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 22:04:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id x3so1584703oto.11
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2019 19:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jnaclaqfzAkmDR3Cu1ofNJy4AR7awuVd0ddciKZbp4=;
        b=K2rskJEvIWjUrD7kECs4sxJuVEJ0IrqrDPEJmivCsLKd2q61VRzZ4iOf/cLlWWLYtu
         bStH58lVwxcAXOqcDri8Ynx0a0OjZ5cErIxedqGkcd0sG+L7kaGYe16tBlYcyqmHZKXz
         plGezh+ql6k/rQz9nO+1RH9/JPEupNQuauMba+CYjm3G1OtuvI0hjlPWLVgcpErX/M0y
         bHBqvGh5og5wXYw36GrBe2bDxanWqR4x7bPNraTpfAyfRLbYt08Fc03m4uN0M7Gh5Xjf
         ma7xw37wsoHIczYOhProLlTLlWsy03ts2m7sM7mGbSyv0eO4UJl1nJLHQ4oTjYoJgjey
         Z3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jnaclaqfzAkmDR3Cu1ofNJy4AR7awuVd0ddciKZbp4=;
        b=KdNaPlthnNJUtJUaaaiUGGrhSAygAxUgseH3/R5DAsI5iL8gyRuVE/SHW1feqqgAUI
         IdbctspE358BZygDAh0zOs1AlR98Ei77ggOBfKR1vUuOMHjrIDkaBI9yRjeWooogQaOV
         EtoK2ULMforg2oqnm0Ur27YyaKCTDKRqpjorpACr8ERwHPMoZRY5YBZp+plpR5lGBd2s
         CPE1P9y7PugO01KUdcDLRx1iGcOlp2CIvKG8TDEJe068/xcEBm+wkfOzi2yFGHlSWwch
         Nn7NmcnWF0jUyqGnMUSVJww9fVyFO9GHtpBs/27/FWrSlPCqOrWJBdZqKwOUzOB3W8/n
         P0fw==
X-Gm-Message-State: APjAAAXRE20x6q8DetO8i6M6g6YKqu7/53Vts2Ox8ZSFi8/5xfsLW1YY
        Ewm0oiPNWunk5hsogK9lzIolRSzzHLxZCScVXwkZqg==
X-Google-Smtp-Source: APXvYqxNlSvg3UaFUbLQWR0iK/r3j7Gv5v3hDDaubdyjaqiiJPDkc5/m2Wnctz7S8wlPdCcPH9M+N/idA6WzQ2daIGU=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr1808096otd.266.1575342271203;
 Mon, 02 Dec 2019 19:04:31 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p> <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p> <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
In-Reply-To: <20191203005849.GB25002@ming.t460p>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Mon, 2 Dec 2019 22:04:20 -0500
Message-ID: <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Ming,

The log you requested with the (arg4 & 512 != 0) predicate did not
match anything. However, I checked specifically for the offset of "76"
and came up with the following stack traces:

# /usr/share/bcc/tools/trace -K 'bio_add_page ((arg4 == 76)) "%d %d",
arg3, arg4 '
PID     TID     COMM            FUNC             -
7782    7782    kworker/19:1H   bio_add_page     512 76
        bio_add_page+0x1 [kernel]
        sbc_execute_rw+0x28 [kernel]
        __target_execute_cmd+0x2e [kernel]
        target_execute_cmd+0x1c1 [kernel]
        iscsit_execute_cmd+0x1e7 [kernel]
        iscsit_sequence_cmd+0xdc [kernel]
        isert_recv_done+0x780 [kernel]
        __ib_process_cq+0x78 [kernel]
        ib_cq_poll_work+0x29 [kernel]
        process_one_work+0x179 [kernel]
        worker_thread+0x4f [kernel]
        kthread+0x105 [kernel]
        ret_from_fork+0x1f [kernel]

14475   14475   kworker/13:1H   bio_add_page     4096 76
        bio_add_page+0x1 [kernel]
        sbc_execute_rw+0x28 [kernel]
        __target_execute_cmd+0x2e [kernel]
        target_execute_cmd+0x1c1 [kernel]
        iscsit_execute_cmd+0x1e7 [kernel]
        iscsit_sequence_cmd+0xdc [kernel]
        isert_recv_done+0x780 [kernel]
        __ib_process_cq+0x78 [kernel]
        ib_cq_poll_work+0x29 [kernel]
        process_one_work+0x179 [kernel]
        worker_thread+0x4f [kernel]
        kthread+0x105 [kernel]
        ret_from_fork+0x1f [kernel]

Thanks,
Steve

On Mon, Dec 2, 2019 at 7:59 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Dec 02, 2019 at 01:42:15PM -0500, Stephen Rust wrote:
> > Hi Ming,
> >
> > > I may get one machine with Mellanox NIC, is it easy to setup & reproduce
> > > just in the local machine(both host and target are setup on same machine)?
> >
> > Yes, I have reproduced locally on one machine (using the IP address of
> > the Mellanox NIC as the target IP), with iser enabled on the target,
> > and iscsiadm connected via iser.
> >
> > e.g.:
> > target:
> > /iscsi/iqn.20.../0.0.0.0:3260> enable_iser true
> > iSER enable now: True
> >
> >   | |   o- portals
> > ....................................................................................................
> > [Portals: 1]
> >   | |     o- 0.0.0.0:3260
> > ...................................................................................................
> > [iser]
> >
> > client:
> > # iscsiadm -m node -o update --targetname <target> -n
> > iface.transport_name -v iser
> > # iscsiadm -m node --targetname <target> --login
> > # iscsiadm -m session
> > iser: [3] 172.16.XX.XX:3260,1
> > iqn.2003-01.org.linux-iscsi.x8664:sn.c46c084919b0 (non-flash)
> >
> > > Please try to trace bio_add_page() a bit via 'bpftrace ./ilo.bt'.
> >
> > Here is the output of this trace from a failed run:
> >
> > # bpftrace lio.bt
> > modprobe: FATAL: Module kheaders not found.
> > Attaching 3 probes...
> > 512 76
> > 4096 0
> > 4096 0
> > 4096 0
> > 4096 76
>
> The above buffer might be the reason, 4096 is length, and 76 is the
> offset, that means the added buffer crosses two pages, meantime the
> buffer isn't aligned.
>
> We need to figure out why the magic 76 offset is passed from target or
> driver.
>
> Please install bcc and collect the following log:
>
> /usr/share/bcc/tools/trace -K 'bio_add_page ((arg4 & 512) != 0) "%d %d", arg3, arg4 '
>
>
> Thanks,
> Ming
>
