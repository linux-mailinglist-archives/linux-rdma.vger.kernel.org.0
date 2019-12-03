Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14810F5EF
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 04:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfLCDuo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 22:50:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40322 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfLCDuo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 22:50:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id 6so1985233oix.7
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2019 19:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKPbxfmB1PGBw6TvcuN9gU8taqnju8V9Mq/8x0yxwDQ=;
        b=pLbmb2eSkmMrLrMPfPmOEskc0Prw/wvpMhbR2leZS+czdZCQkbCir0IfrzICOipfRE
         jnEyZWSfmWz5S+tTQTRSLZMlU6T/6kKm8SEsJhWVTpD/VokDfq3q+bzLzUp6Gxy4fWtW
         nM+ek5ar+t8zEf5jxzD++aeCt7+vcLWH5bMZPMkWgUvoT/MMdMZeXPe4Ot7vaL0vLfkg
         T9BSIE4A4L4yAFEN3iSBrtbub8gcWkG1XDSCPgpxIez6iHTyzuGfGFKZvEvj4/wmgwjE
         ks4XT1P+3aJWszxS0NlH5Zc+eCSkQ/Q+v9drK8aUviI9vIzg0TjeTC9dzBMfX4/aB77F
         YyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKPbxfmB1PGBw6TvcuN9gU8taqnju8V9Mq/8x0yxwDQ=;
        b=S9mvm2ji7xdx8TOMYf1RcjqsXR3V+TPvBHnfKddUGkSiOWOc3r4sDNkvo9W0zoQBiZ
         62/Jo3yZ9+QO1vquyGg2sgRSJ1/0HYc4WCY1Oi8mDh1lzhmGB2S9n3n9B/x6u+NAZ/l5
         Dv6jwt8VMAKuo5yIh3SSR3SWKyiqY4D4OG8j2mSG5czP2XlnATcoXs3g78LzJx6KawSY
         6QRpuUOuX9synVE9sIfG/vjZNtfuI/rFu/5/5IV+ft8LkK0shkQ/GVmROvB2Owfyqaby
         gR7mOgNBgXzradLYM4AOKm8E3fRKWVAXRGeAEWz8keKxDDo/gnjsDl/MabxJ8W3wHGG3
         Xd1A==
X-Gm-Message-State: APjAAAV9blVOK3kRw1nSF//Hh9vFH9eNiinpMFRmIo6Nl7l8b4Ctqz5l
        TfnmwbsQiVp8siJsoNJDMItyKYW+xXRx+CPo2A9ukWwm0Aw4Gnr5
X-Google-Smtp-Source: APXvYqzFNXILlSbINpkH0cQeDXWVqxD54NzYCYW2T3wpdRYvd2eNwu9fuEjCpgfgsdWZ5X8utxhiUoyv1Svy8cQXCgI=
X-Received: by 2002:a05:6808:b2d:: with SMTP id t13mr2061521oij.83.1575345043284;
 Mon, 02 Dec 2019 19:50:43 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p> <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p> <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
In-Reply-To: <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Mon, 2 Dec 2019 22:50:32 -0500
Message-ID: <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
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

Hi,

Another datapoint.

I enabled "isert_debug" tracing and re-ran the test. Here is a small
snippet of the debug data. FWIW, the "length of 76" in the "lkey
mismatch" is a pattern that repeats quite often during the exchange.


Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: DMA:
0x10a6457000, iSCSI opcode: 0x01, ITT: 0x00000023, flags: 0x81 dlen: 0
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: ISER ISCSI_CTRL PDU
Dec 03 03:41:12 host-2 kernel: isert: __isert_create_send_desc:
tx_desc 000000009bbe54ca lkey mismatch, fixing
Dec 03 03:41:12 host-2 kernel: isert: isert_init_tx_hdrs: Setup
tx_sg[0].addr: 0x4ce45010 length: 76 lkey: 0x80480
Dec 03 03:41:12 host-2 kernel: isert: isert_put_response: Posting SCSI Response
Dec 03 03:41:12 host-2 kernel: isert: isert_send_done: Cmd 00000000238f9047
Dec 03 03:41:12 host-2 kernel: isert: isert_unmap_tx_desc: unmap
single for tx_desc->dma_addr
Dec 03 03:41:12 host-2 kernel: isert: isert_put_cmd: Cmd 00000000238f9047
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: DMA:
0x10a645a000, iSCSI opcode: 0x01, ITT: 0x00000024, flags: 0xa1 dlen:
512
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: ISER ISCSI_CTRL PDU
Dec 03 03:41:12 host-2 kernel: isert: isert_handle_scsi_cmd: Transfer
Immediate imm_data_len: 512
Dec 03 03:41:12 host-2 kernel: isert: __isert_create_send_desc:
tx_desc 000000004b902cb9 lkey mismatch, fixing
Dec 03 03:41:12 host-2 kernel: isert: isert_init_tx_hdrs: Setup
tx_sg[0].addr: 0x4ce55b70 length: 76 lkey: 0x80480
Dec 03 03:41:12 host-2 kernel: isert: isert_put_response: Posting SCSI Response
Dec 03 03:41:12 host-2 kernel: isert: isert_send_done: Cmd 0000000069929548
Dec 03 03:41:12 host-2 kernel: isert: isert_unmap_tx_desc: unmap
single for tx_desc->dma_addr
Dec 03 03:41:12 host-2 kernel: isert: isert_put_cmd: Cmd 0000000069929548
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: DMA:
0x10a645d000, iSCSI opcode: 0x01, ITT: 0x00000025, flags: 0x81 dlen: 0
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: ISER ISCSI_CTRL PDU
Dec 03 03:41:12 host-2 kernel: isert: __isert_create_send_desc:
tx_desc 000000006d694fe9 lkey mismatch, fixing
Dec 03 03:41:12 host-2 kernel: isert: isert_init_tx_hdrs: Setup
tx_sg[0].addr: 0x4ce56140 length: 76 lkey: 0x80480
Dec 03 03:41:12 host-2 kernel: isert: isert_put_response: Posting SCSI Response
Dec 03 03:41:12 host-2 kernel: isert: isert_send_done: Cmd 00000000a666ae3c
Dec 03 03:41:12 host-2 kernel: isert: isert_unmap_tx_desc: unmap
single for tx_desc->dma_addr
Dec 03 03:41:12 host-2 kernel: isert: isert_put_cmd: Cmd 00000000a666ae3c
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: DMA:
0x10a6460000, iSCSI opcode: 0x01, ITT: 0x00000026, flags: 0x81 dlen: 0
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: ISER ISCSI_CTRL PDU
Dec 03 03:41:12 host-2 kernel: isert: __isert_create_send_desc:
tx_desc 00000000dd22ea75 lkey mismatch, fixing
Dec 03 03:41:12 host-2 kernel: isert: isert_init_tx_hdrs: Setup
tx_sg[0].addr: 0x4ce5e6f0 length: 76 lkey: 0x80480
Dec 03 03:41:12 host-2 kernel: isert: isert_put_response: Posting SCSI Response
Dec 03 03:41:12 host-2 kernel: isert: isert_send_done: Cmd 000000009b63dcb0
Dec 03 03:41:12 host-2 kernel: isert: isert_unmap_tx_desc: unmap
single for tx_desc->dma_addr
Dec 03 03:41:12 host-2 kernel: isert: isert_put_cmd: Cmd 000000009b63dcb0
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: DMA:
0x10a6463000, iSCSI opcode: 0x01, ITT: 0x00000027, flags: 0xc1 dlen: 0
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: ISER_RSV:
read_stag: 0x4000009a read_va: 0xac29e6800
Dec 03 03:41:12 host-2 kernel: isert: isert_recv_done: ISER ISCSI_CTRL PDU
Dec 03 03:41:12 host-2 kernel: isert: isert_put_datain: Cmd:
00000000fe3d39bf RDMA_WRITE data_length: 32
Dec 03 03:41:12 host-2 kernel: isert: __isert_create_send_desc:
tx_desc 00000000f5f10cf7 lkey mismatch, fixing
Dec 03 03:41:12 host-2 kernel: isert: isert_init_tx_hdrs: Setup
tx_sg[0].addr: 0x4ce56710 length: 76 lkey: 0x80480
Dec 03 03:41:12 host-2 kernel: isert: isert_put_datain: Cmd:
00000000fe3d39bf posted RDMA_WRITE for iSER Data READ rc: 0
Dec 03 03:41:12 host-2 kernel: isert: isert_send_done: Cmd 00000000fe3d39bf
Dec 03 03:41:12 host-2 kernel: isert: isert_unmap_tx_desc: unmap
single for tx_desc->dma_addr
Dec 03 03:41:12 host-2 kernel: isert: isert_put_cmd: Cmd 00000000fe3d39bf

[snip]

I could post the whole isert debug log somewhere if you'd like?

Thanks,
Steve

On Mon, Dec 2, 2019 at 10:26 PM Stephen Rust <srust@blockbridge.com> wrote:
>
> > oops, it should have been (arg4 & 511) != 0.
>
> Yep, there they are:
>
> # /usr/share/bcc/tools/trace -K 'bio_add_page ((arg4 & 511) != 0) "%d
> %d", arg3, arg4'
> PID     TID     COMM            FUNC             -
> 7411    7411    kworker/31:1H   bio_add_page     512 76
>         bio_add_page+0x1 [kernel]
>         sbc_execute_rw+0x28 [kernel]
>         __target_execute_cmd+0x2e [kernel]
>         target_execute_cmd+0x1c1 [kernel]
>         iscsit_execute_cmd+0x1e7 [kernel]
>         iscsit_sequence_cmd+0xdc [kernel]
>         isert_recv_done+0x780 [kernel]
>         __ib_process_cq+0x78 [kernel]
>         ib_cq_poll_work+0x29 [kernel]
>         process_one_work+0x179 [kernel]
>         worker_thread+0x4f [kernel]
>         kthread+0x105 [kernel]
>         ret_from_fork+0x1f [kernel]
>
> 7753    7753    kworker/26:1H   bio_add_page     4096 76
>         bio_add_page+0x1 [kernel]
>         sbc_execute_rw+0x28 [kernel]
>         __target_execute_cmd+0x2e [kernel]
>         target_execute_cmd+0x1c1 [kernel]
>         iscsit_execute_cmd+0x1e7 [kernel]
>         iscsit_sequence_cmd+0xdc [kernel]
>         isert_recv_done+0x780 [kernel]
>         __ib_process_cq+0x78 [kernel]
>         ib_cq_poll_work+0x29 [kernel]
>         process_one_work+0x179 [kernel]
>         worker_thread+0x4f [kernel]
>         kthread+0x105 [kernel]
>         ret_from_fork+0x1f [kernel]
