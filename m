Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04819132947
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgAGOtJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 09:49:09 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33469 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGOtI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 09:49:08 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so52833290ioh.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 06:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xURPOfyF2UK2ImfN0jV4a8KRwy9Nblqyu9sgwhGxs5s=;
        b=Jvncn3tijiI+u+3cvBj5W7Gb8ZHassVRprsVHpn6hdwsYUoJIf0J0zpAeyjjlzCKeH
         nY+P3BP7Dw5q/F2TclcXczu+dhVPWcEesVllGg3V5LCZB1c/N5KqP2tOmpf9j7VMdQpK
         KngmC4wGP2sX/E4BgHtDXa4zfoHX1IAC4kUp07/Odh23+CKkbfvPlLgEj7v/4Gl+BrTZ
         2Vz+p8Oh5sXHSdNTbR4adTEz/1Zk5t8Lz9bx9c9jDMpuMPCAV2bhUfsgs8ABaF4ERObH
         H+0nTbLsW1JugC37ccnnPMklDcH6g0yRp2vwGwKe0YuxHWinMCKYlxDscq+FsSIayYy1
         eLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xURPOfyF2UK2ImfN0jV4a8KRwy9Nblqyu9sgwhGxs5s=;
        b=sBr1fEV675AzZ/dLmmL7sITgOLomjA8oAPrcB1Z0omk8UG5mR+U5w8LO8XH5WxI/rX
         Lt304PdpR3f/ixfdMxC38ZyuAt5DAmyeEV/cpncqwHd1/awGWPvcEQOj6X/5jCQan3GN
         /hkFzQpZfClm3yjQv4Wd3momqYwSn8ls3nXA60F4hZDoyH/UWmjdjJFxAdd43bj30+Th
         KjDr1b34KLPcmwk0V6IbfHzJ55LtlDhLll5O/1JzZFmn1oe2JGr8+5QwqFiJT5NMCdjr
         Wxd91p9zcDnP/cHizkWq1N9QE9nLmhTuxrnzRL0EIGGTgCdMT4AXQTxACPyXnk41ueow
         q6jA==
X-Gm-Message-State: APjAAAUVV0fRJHK6kvpHo76XiQHPlO9rCaInapZYiM9CVY5ED+mtJca3
        dKHewKhQdgoiYnp38k9hYllCkFAAmCOmY1X97CpuMWVxNMqsLg==
X-Google-Smtp-Source: APXvYqwETYMrSMTjdRtdmgSUVl74ByetyxJrK526VXRrVqCE2iVr2NU5SXb6JOM2nA3EHkb6x606TcaLA6Rbh2tg4BE=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr75006830ioh.22.1578408548041;
 Tue, 07 Jan 2020 06:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-15-jinpuwang@gmail.com>
 <1ad8b279-1a45-1d70-39c7-acd42f28abca@acm.org>
In-Reply-To: <1ad8b279-1a45-1d70-39c7-acd42f28abca@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 15:48:57 +0100
Message-ID: <CAMGffEnzoo7Y-Bh4F7ZDONr1kE3U20Btr=763rQyiYu=+YMosA@mail.gmail.com>
Subject: Re: [PATCH v6 14/25] rtrs: a bit of documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 31, 2019 at 12:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > diff --git a/drivers/infiniband/ulp/rtrs/README b/drivers/infiniband/ulp/rtrs/README
>
> Other kernel driver documentation exists under the Documentation/
> directory. Should this README file perhaps be moved to a subdirectory of
> the Documentation/ directory?
I did check most of the drivers are in the drivers directory eg:
find ./ -name README
./fs/reiserfs/README
./fs/qnx4/README
./fs/qnx6/README
./fs/cramfs/README
./Documentation/ABI/README
./Documentation/virt/kvm/devices/README
./README
./tools/usb/usbip/README
./tools/virtio/ringtest/README
./tools/virtio/virtio-trace/README
./tools/power/pm-graph/README
./tools/power/cpupower/README
./tools/memory-model/README
./tools/memory-model/scripts/README
./tools/memory-model/litmus-tests/README
./tools/testing/vsock/README
./tools/testing/ktest/examples/README
./tools/testing/selftests/ftrace/README
./tools/testing/selftests/arm64/signal/README
./tools/testing/selftests/arm64/README
./tools/testing/selftests/android/ion/README
./tools/testing/selftests/zram/README
./tools/testing/selftests/livepatch/README
./tools/testing/selftests/net/forwarding/README
./tools/testing/selftests/futex/README
./tools/testing/selftests/tc-testing/README
./tools/thermal/tmon/README
./tools/build/tests/ex/empty2/README
./tools/perf/tests/attr/README
./tools/perf/pmu-events/README
./tools/perf/scripts/perl/Perf-Trace-Util/README
./tools/io_uring/README
./net/decnet/README
./scripts/ksymoops/README
./scripts/selinux/README
./arch/powerpc/boot/README
./arch/m68k/q40/README
./arch/m68k/ifpsp060/README
./arch/m68k/fpsp040/README
./arch/parisc/math-emu/README
./arch/x86/math-emu/README
./drivers/bcma/README
./drivers/char/mwave/README
./drivers/staging/nvec/README
./drivers/staging/wlan-ng/README
./drivers/staging/axis-fifo/README
./drivers/staging/fbtft/README
./drivers/staging/fsl-dpaa2/ethsw/README
./drivers/staging/goldfish/README
./drivers/staging/gs_fpgaboot/README
./drivers/staging/comedi/drivers/ni_routing/README
./drivers/net/wireless/marvell/mwifiex/README
./drivers/net/wireless/marvell/libertas/README

>
> > +****************************
> > +InfiniBand Transport (RTRS)
> > +****************************
>
> The abbreviation does not match the full title. Do you agree that this
> is confusing?
>
> > +RTRS is used by the RNBD (Infiniband Network Block Device) modules.
>
> Is RNBD an RDMA or an InfiniBand network block device?
will fix.
>
> > +
> > +==================
> > +Transport protocol
> > +==================
> > +
> > +Overview
> > +--------
> > +An established connection between a client and a server is called rtrs
> > +session. A session is associated with a set of memory chunks reserved on the
> > +server side for a given client for rdma transfer. A session
> > +consists of multiple paths, each representing a separate physical link
> > +between client and server. Those are used for load balancing and failover.
> > +Each path consists of as many connections (QPs) as there are cpus on
> > +the client.
> > +
> > +When processing an incoming rdma write or read request rtrs client uses memory
>
> A quote from
> https://linuxplumbersconf.org/event/4/contributions/367/attachments/331/555/LPC_2019_RMDA_MC_IBNBD_IBTRS_Upstreaming.pdf:
> "Only RDMA writes with immediate". Has the wire protocol perhaps been
> changed such that both RDMA reads and writes are used? I haven't found
> any references to RDMA reads in the "IO path" section in this file. Did
> I perhaps overlook something?
>
> Thanks,
>
> Bart.
We do not use RDMA_READ, only RDMA_WRITE/RDMA_WRITE_WITH_IMM/SEND_WITH_IMM
SEND_WITH_IMM was used only when always_invalidate=Y.
Will extend the document.

Thanks Bart.
