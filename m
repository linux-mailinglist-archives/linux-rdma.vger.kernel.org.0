Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED7840DD20
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhIPOrA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbhIPOrA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 10:47:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16061C061764
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 07:45:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 6so9347723oiy.8
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CP4scM8pp+DlZTyVyeXfxnSxb/UebNzvQjfUoHlTLZ4=;
        b=CY1t2c5Rnym6zcTPA41ni0M442UCoyLkunbGgIWSBz+jw+xfSLdrRRszlM6T4Sgq+V
         PzrPUhxzgHL9D8RByv7rRv7GTZhPhtMh9b7ZSLFImo1PZfH3P5SGN5oHB5T5oOubN+TP
         qQEKlR7AbdWbe2r7BkUxllgMUSnj8Mx/hBQtFllqFO9McLPad8X3hsDsA1cnyNOYHprL
         7QgsaU5GLO9+8T782w5MOeKfFJbsnED7gDI45bdsj35zjuCJGimddOkkjbDzWGIgNkSE
         wvks59mGfeumKVVybI12SU+8/83NwGO/fHDnaLLbPE12x6sEeTy0qT+JIX/6w0sBpcsc
         P//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CP4scM8pp+DlZTyVyeXfxnSxb/UebNzvQjfUoHlTLZ4=;
        b=AfXHUr+da8+50cO7Rx6aw2OPctjdsZ/yPD3pFvLppTrabl2qH/CpZsVkfoWh5SQfO1
         JIUBiOAFOJwgQRqaeAltb2q3dKjZKNS8xmkcF9t8ToHjCD4huu4++6U3617ZWbt1179+
         F0HgGKt6e1pN0O3E1pxxqNR+NkgzHakHT9vDFGx6kCeMnwmyE2ocn49uIDjp4WiQHBxX
         ekFgyMAm0xZiWoBOkpfFmsDatlLf9Qzc3VXOGKQjWWue7g4z2gIZd8+Gcw2/yDF7VKXy
         e6eXEkppLL9q9h59ZGLM/cJ1zADBPtr8YwcTXc27kiaORwPc71peGO8bkzf2Bh5ip1Sp
         5gkQ==
X-Gm-Message-State: AOAM530xjDP6qiRQtgka87uVRUDyAj9VyvIGYQ3nYX0Rg3Dr/jY0GxWq
        G9rbl5wYbDokl5pFwsKh1Jw+LknCuQvQuMnO9QKXKg==
X-Google-Smtp-Source: ABdhPJzhCBi6agDZfIOvDRZ9K7XlaQFyPijNiXmAorcRe1UK5wu9Bnw8IT4dtXXUykZlq0kXsoEUsvmci9+5w4h2FI0=
X-Received: by 2002:aca:f189:: with SMTP id p131mr9723425oih.128.1631803539118;
 Thu, 16 Sep 2021 07:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ffdae005cc08037e@google.com> <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com> <20210916130459.GJ3544071@ziepe.ca>
In-Reply-To: <20210916130459.GJ3544071@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Sep 2021 16:45:27 +0200
Message-ID: <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 16 Sept 2021 at 15:05, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Sep 16, 2021 at 09:43:19AM +0200, Dmitry Vyukov wrote:
> > On Wed, 15 Sept 2021 at 21:36, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Sep 15, 2021 at 05:41:22AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://g=
it.kern..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11fd67e=
d300000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D37df9ef=
5660a8387
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddc3dfba01=
0d7671e05f5
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU =
Binutils for Debian) 2.35.1
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
> > >
> > > #syz dup: KASAN: use-after-free Write in addr_resolve (2)
> > >
> > > Frankly, I still can't figure out how this is happening
> > >
> > > RDMA_USER_CM_CMD_RESOLVE_IP triggers a background work and
> > > RDMA_USER_CM_CMD_DESTROY_ID triggers destruction of the memory the
> > > work touches.
> > >
> > > rdma_addr_cancel() is supposed to ensure that the work isn't and won'=
t
> > > run.
> > >
> > > So to hit this we have to either not call rdma_addr_cancel() when it
> > > is need, or rdma_addr_cancel() has to be broken and continue to allow
> > > the work.
> > >
> > > I could find nothing along either path, though rdma_addr_cancel()
> > > relies on some complicated properties of the workqueues I'm not
> > > entirely positive about.
> >
> > I stared at the code, but it's too complex to grasp it all entirely.
> > There are definitely lots of tricky concurrent state transitions and
> > potential for unexpected interleavings. My bet would be on some tricky
> > hard-to-trigger thread interleaving.
>
> From a uapi perspective the entire thing is serialized with a mutex..
>
> > The only thing I can think of is adding more WARNINGs to the code to
> > check more of these assumptions. But I don't know if there are any
> > useful testable assumptions...
>
> Do you have any idea why we can't get a reproduction out of syzkaller
> here?
>
> I feel less comfortable with syzkaller's debug output, can you give
> some idea what it might be doing concurrently?

It looks like a very hard to trigger race (few crashes, no reproducer,
but KASAN reports look sensible). That's probably the reason syzkaller
can't create a reproducer.
From the log it looks like it was triggered by one of these programs
below. But I tried to reproduce manually and had no success.
We are currently doing some improvements to race triggering code in
syzkaller, and may try to use this as a litmus test to see if
syzkaller will do any better:
https://github.com/google/syzkaller/issues/612#issuecomment-920961538

Answering your question re what was running concurrently with what.
Each of the syscalls in these programs can run up to 2 times and
ultimately any of these calls can race with any. Potentially syzkaller
can predict values kernel will return (e.g. id's) before kernel
actually returned them. I guess this does not restrict search area for
the bug a lot...


11:16:53 executing program 3:
write$RDMA_USER_CM_CMD_CONNECT(0xffffffffffffffff,
&(0x7f0000000280)=3D{0x6, 0x118, 0xfa00, {{0xfffffff7, 0x6a492eae,
"e0e55819482a40c1c535b72b0bc0bc5e4478995957e1d0fe2311a39ee3960d3488407d52fb=
ef30809118fcbaef590c27d04918aa1348b409d45ba277d9f73bd18868a9c4fde7560288298=
bde7e9a96c1ef280ca62f4a6f591a2181f2e3d3cf52212fa5ae101aa1bf975763cef32e3a2c=
73b79d0af1d2e58b82243731e6082cab1cb1c643b7bbec2e6d45bca8a6980f148aaefb71f19=
33ffa50534b83267139b2324e51ffecb57959bf7e98b60516cebc8f05838a7976cef33b6441=
0626c14dca7dcb22f0902aeb045b88656268a6dd922d6a0e7b7002e8ea90020650dced31905=
0db3130089e5011994d90340a93088e0a8b03ea61ac3f53312342b3d6e038ae",
0xfc, 0xe1, 0xb2, 0xd0, 0x7, 0x40, 0x0, 0x1}}}, 0x120)
r0 =3D openat$pfkey(0xffffffffffffff9c, &(0x7f00000001c0), 0x80800, 0x0)
r1 =3D syz_io_uring_setup(0x1c7, &(0x7f0000000080)=3D{0x0, 0x0, 0x0, 0x0,
0x7f, 0x0, r0}, &(0x7f00007b6000/0x2000)=3Dnil,
&(0x7f0000ffd000/0x3000)=3Dnil, &(0x7f0000000140)=3D<r2=3D>0x0,
&(0x7f0000000100)=3D<r3=3D>0x0)
socketpair$unix(0x1, 0x5, 0x0, &(0x7f0000000040)=3D{0xffffffffffffffff,
<r4=3D>0xffffffffffffffff})
r5 =3D openat(0xffffffffffffff9c,
&(0x7f0000000000)=3D'/proc/self/exe\x00', 0x0, 0x0)
mmap(&(0x7f0000000000/0x800000)=3Dnil, 0x800000, 0x0, 0x12, r5, 0x0)
r6 =3D openat$rdma_cm(0xffffffffffffff9c, &(0x7f0000000540), 0x2, 0x0)
write$RDMA_USER_CM_CMD_CREATE_ID(r6, &(0x7f0000000080)=3D{0x0, 0x18,
0xfa00, {0xffffffffffffffff,
&(0x7f0000000000)=3D{<r7=3D>0xffffffffffffffff}, 0x13f}}, 0x20)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r6, &(0x7f0000000100)=3D{0x3, 0x40,
0xfa00, {{}, {0xa, 0x0, 0x0, @mcast2}, r7}}, 0x48)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r6, &(0x7f0000000180)=3D{0x3, 0x40,
0xfa00, {{0xa, 0x0, 0x0, @local}, {0xa, 0x0, 0x0, @mcast1}, r7}},
0x48)
write$RDMA_USER_CM_CMD_DESTROY_ID(r6, &(0x7f0000000280)=3D{0x1, 0x10,
0xfa00, {&(0x7f0000000240), r7}}, 0x18)
write$RDMA_USER_CM_CMD_CONNECT(r5, &(0x7f00000003c0)=3D{0x6, 0x118,
0xfa00, {{0x9, 0x9,
"f703ff619e427c1d7d50fc023c22feb64ea5083376891585a4a8b539bead7f61210a9010d8=
8379b67ebe7a1fc77fbdd4dccaec4b498eafe4b08e7e5b28e9fe54606f87e9618b9ade4e28b=
66e04c73fe4660de33c075bb9b1a43c59e485dcc259fb21fed21380f9ec2c61e8d29b606978=
6e8bc3da0f3bded0acd13548d2d76af6e701a258307fbce30c0f452b6a25f39209c830fe557=
de6f1fb3fdfe4347be3a9fdfeaca47b97e333a266013beef7cb7d7ea746bca1d3a929747a26=
9df24d019e3e413309e58095182dd5dc3c8a088e94abf8d5cd389749cc80e4e452c8dabe7ea=
add8144e2c4392e35c1b5ad3369ee7b2f855e5ebe9bdc0e8a464e8a9e4f54c0",
0x2, 0xff, 0x1, 0x8f, 0x6, 0x3, 0x6}, r7}}, 0x120)
syz_io_uring_submit(r2, r3,
&(0x7f0000000180)=3D@IORING_OP_READ=3D@pass_buffer=3D{0x16, 0x4, 0x0,
@fd=3Dr4, 0x0, &(0x7f0000000000)=3D""/7, 0x7}, 0x0)
syz_io_uring_submit(r2, r3,
&(0x7f0000002f80)=3D@IORING_OP_LINK_TIMEOUT=3D{0xf, 0x0, 0x0, 0x0, 0x0,
&(0x7f0000000240)=3D{0x0, 0x3938700}}, 0x10000007)
io_uring_enter(r1, 0x45f5, 0x0, 0x0, 0x0, 0xf5ff)



11:16:55 executing program 4:
r0 =3D openat$rdma_cm(0xffffffffffffff9c, &(0x7f0000000540), 0x2, 0x0)
write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000080)=3D{0x0, 0x18,
0xfa00, {0xffffffffffffffff,
&(0x7f0000000000)=3D{<r1=3D>0xffffffffffffffff}, 0x13f}}, 0x20)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000100)=3D{0x3, 0x40,
0xfa00, {{0xa, 0xfffd}, {0xa, 0x0, 0x10000000, @ipv4=3D{'\x00',
'\xff\xff', @broadcast}, 0x3}, r1, 0xfffffffe}}, 0x48)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000180)=3D{0x3, 0x40,
0xfa00, {{0xa, 0x2, 0x0, @ipv4=3D{'\x00', '\xff\xff', @multicast2}},
{0xa, 0x0, 0x0, @initdev=3D{0xfe, 0x88, '\x00', 0x1, 0x0}}, r1}}, 0xd5)
write$RDMA_USER_CM_CMD_DESTROY_ID(r0, &(0x7f0000000280)=3D{0x1, 0x10,
0xfa00, {&(0x7f0000000240), r1}}, 0x18)
write$RDMA_USER_CM_CMD_BIND_IP(0xffffffffffffffff,
&(0x7f0000000000)=3D{0x2, 0x28, 0xfa00, {0x0, {0xa, 0x4e23, 0x9,
@ipv4=3D{'\x00', '\xff\xff', @rand_addr=3D0x64010102}, 0x100}, r1}}, 0x30)
openat$qrtrtun(0xffffffffffffff9c, &(0x7f0000002740), 0x101002)
io_setup(0x8, &(0x7f0000000600)=3D<r2=3D>0x0)
clock_getres(0xfffffffffffffffd, 0x0)
r3 =3D openat$hwrng(0xffffffffffffff9c, &(0x7f0000000040), 0x400, 0x0)
r4 =3D openat$vcsa(0xffffffffffffff9c, &(0x7f00000002c0), 0x8000, 0x0)
r5 =3D openat$rdma_cm(0xffffffffffffff9c, &(0x7f0000000540), 0x2, 0x0)
write$RDMA_USER_CM_CMD_CREATE_ID(r5, &(0x7f0000000080)=3D{0x0, 0x18,
0xfa00, {0xffffffffffffffff,
&(0x7f0000000000)=3D{<r6=3D>0xffffffffffffffff}, 0x13f}}, 0x20)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r5, &(0x7f0000000100)=3D{0x3, 0x40,
0xfa00, {{}, {0xa, 0x0, 0x0, @mcast2}, r6}}, 0x48)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r5, &(0x7f0000000180)=3D{0x3, 0x40,
0xfa00, {{0xa, 0x0, 0x0, @local}, {0xa, 0x0, 0x0, @mcast1}, r6}},
0x48)
write$RDMA_USER_CM_CMD_DESTROY_ID(r5, &(0x7f0000000280)=3D{0x1, 0x10,
0xfa00, {&(0x7f0000000240), r6}}, 0x18)
pipe2(&(0x7f0000000340)=3D{<r7=3D>0xffffffffffffffff}, 0x800)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r7, &(0x7f0000000380)=3D{0x3, 0x40,
0xfa00, {{0xa, 0x4e23, 0x8, @remote, 0x3ff}, {0xa, 0x4e22, 0x8000,
@initdev=3D{0xfe, 0x88, '\x00', 0x1, 0x0}, 0x8}, r1, 0x1f}}, 0x48)
write$RDMA_USER_CM_CMD_LISTEN(r4, &(0x7f0000000300)=3D{0x7, 0x8, 0xfa00,
{r6, 0x8}}, 0x10)
io_submit(r2, 0x1, &(0x7f0000000200)=3D[&(0x7f00000000c0)=3D{0x0, 0x0,
0x0, 0x1, 0x0, 0xffffffffffffffff,
&(0x7f0000000400)=3D"03a0a445bc5d7a9d6c", 0x9, 0x7fffffff, 0x0, 0x0,
r3}])
