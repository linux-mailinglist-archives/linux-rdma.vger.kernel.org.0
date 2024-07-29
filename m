Return-Path: <linux-rdma+bounces-4062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB593F206
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 11:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA5287689
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E10142915;
	Mon, 29 Jul 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKWNOSN/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473B140395;
	Mon, 29 Jul 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247144; cv=none; b=CFG67ZKzJWsshBlvLbG0U2U7f9apnX4yoa84MTmkX0hzSPmGb/g12GErSRIfUALjgS5EoPCj8iVdQSq7jq8TLQR7cSl9p2P79k7bq34pwHPcQyVfsFOMN7iYQayE7z7f9VLNA7pGZrr8E+WLKMoWVc0oIkHXvm3sv7HpoZ9DPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247144; c=relaxed/simple;
	bh=5kTus1I7Nt+WvAq5wzyLhAV283K/Y40gIZ15wrLviW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsloseriFp5cbSXbf/MCLucGX4bixA6fuW+DyRwT2Ym0W7FYbMszDYaE+j7gpJms/npW2WB36BRyGQxdaWt3hMJxkxbdEZts+3udX95ImUzriSmvqXpLn0xHGmP+lb9zGVK0Uu+mh+dMb6iIT//XrDZ1Fxyq7fT3u3y/i/HCsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKWNOSN/; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f6bc491759so982523e0c.0;
        Mon, 29 Jul 2024 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722247141; x=1722851941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=579OA2hqZmU+H679x705opc54w9QaD/GJ943o2R24Jw=;
        b=OKWNOSN/SIfwGT/schNoZl8FCCb/BMOhYp5pJF8tVSlxD8Rbo5hscwKUKvdkyJFaor
         aIQEsLROgDRalD5NgmGozaG1zmngIiO1sixYA+nZkTqu3UYDPTCL/rh5EAttcid9kJ5J
         6bW2PJ75p61A2SewMiY2ZCmdRvWMPhPTYWs3mhrAXWC6p2hOEP7eSoCTCjtfBPvlVu6V
         JjLvT8qWKUdaGg5ao4tAkMrXsXxyAfR9bfBfbKN6KeE73bHzl/aUvvasV6qF03A67ZxM
         1eo+CAXb7YOacvy0qUS363WKqbAMbceQt4ecMFsQVHixrztQRzQjEU0hS8JHs12abaaC
         lW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722247141; x=1722851941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=579OA2hqZmU+H679x705opc54w9QaD/GJ943o2R24Jw=;
        b=dpQl/X5a8coHz/vdmFVqv4H5gHsO/3bEvAmQIIN3OctxgoIqHxaf6Jabh0vmvLxfBN
         k60PuOsEW7UuVEJoOKszfK1p6/mnRWEnWRDd8S6h3vUIM39fXbfa3e+TvsZ9vHwRr7ra
         qp6SDU6dFMFR7uzaou69fjoqBabe3s8hE7JPIRIeiRPPL/bWxjO5VfiPAlkxynf82px+
         rCEppmII9t8wKSRxenE9zOkPkv25t49AoHxfiRoTO2QgKsOLqnImf3756+EYDB2XVo49
         Ip356qm112y9JxBjDfkBqeJpzwHNQEMxZTTwdV/r60m5vS/CvCt7KodU+BlbowdHGQim
         fl+A==
X-Forwarded-Encrypted: i=1; AJvYcCWnVvqzhYL5a0H2BA8VFDg5+fTiOUeFpWRs/FYyR0kZL1WLDzt4he7tUDxPiIszUSINvV6J52GJREARnciGVpB6fat5y+D0oVp0AB6ZIcFwB5tYTmjRQUtu4xU3jLOvBGvs7cZ1nzSexjZQWUXPmnD1YXIaLMK5Y0UVYeT6UQ==
X-Gm-Message-State: AOJu0YzJu9Rd+20GNasLPP664yQ7SlDa57p1kqGpgPhyFV+04qnC7TTc
	shUVqh25vCKM3TT0dDzL0vDpEvL8Ztj///bN5Npqsuwf9rNKCbd5SUEFlI4TjGvdU4JY+aDcjET
	h5dpkYXksPwtxmGN9n04GCKvEjIQ=
X-Google-Smtp-Source: AGHT+IFm7unA/zZPS+dyT2ETbj+CLdpBNY4s+5QPOpSPv8EisDxmtEzlCudoxN9gLJ+pfdkkdVpC2/JL2Nr1sFjf8nI=
X-Received: by 2002:a05:6122:3c53:b0:4ec:f6f2:f1cd with SMTP id
 71dfb90a1353d-4f6e697214cmr3719929e0c.9.1722247140407; Mon, 29 Jul 2024
 02:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com> <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>
 <20240722111834.GC13497@pendragon.ideasonboard.com> <CAPybu_1SiMmegv=4dys+1tzV6=PumKxfB5p12ST4zasCjwzS9g@mail.gmail.com>
 <20240725200142.GF14252@pendragon.ideasonboard.com> <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
 <20240726105936.GC28621@pendragon.ideasonboard.com> <CAPybu_1y7K940ndLZmy+QdfkJ_D9=F9nTPpp=-j9HYpg4AuqqA@mail.gmail.com>
 <20240728171800.GJ30973@pendragon.ideasonboard.com>
In-Reply-To: <20240728171800.GJ30973@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 29 Jul 2024 11:58:43 +0200
Message-ID: <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 7:18=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Jul 26, 2024 at 05:40:16PM +0200, Ricardo Ribalda Delgado wrote:
> > On Fri, Jul 26, 2024 at 12:59=E2=80=AFPM Laurent Pinchart wrote:
> > > On Fri, Jul 26, 2024 at 10:04:33AM +0200, Ricardo Ribalda Delgado wro=
te:
> > > > On Thu, Jul 25, 2024 at 10:02=E2=80=AFPM Laurent Pinchart wrote:
> > > > > On Mon, Jul 22, 2024 at 01:56:11PM +0200, Ricardo Ribalda Delgado=
 wrote:
> > > > > > On Mon, Jul 22, 2024 at 1:18=E2=80=AFPM Laurent Pinchart wrote:
> > > > > > > On Mon, Jul 22, 2024 at 12:42:52PM +0200, Ricardo Ribalda Del=
gado wrote:
> > > > > > > > On Sun, Jul 21, 2024 at 9:25=E2=80=AFPM Laurent Pinchart wr=
ote:
> > > > > > > > > On Tue, Jul 09, 2024 at 03:15:13PM -0700, Dan Williams wr=
ote:
> > > > > > > > > > James Bottomley wrote:
> > > > > > > > > > > > The upstream discussion has yielded the full spectr=
um of positions on
> > > > > > > > > > > > device specific functionality, and it is a topic th=
at needs cross-
> > > > > > > > > > > > kernel consensus as hardware increasingly spans cro=
ss-subsystem
> > > > > > > > > > > > concerns. Please consider it for a Maintainers Summ=
it discussion.
> > > > > > > > > > >
> > > > > > > > > > > I'm with Greg on this ... can you point to some of th=
e contrary
> > > > > > > > > > > positions?
> > > > > > > > > >
> > > > > > > > > > This thread has that discussion:
> > > > > > > > > >
> > > > > > > > > > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@n=
vidia.com
> > > > > > > > > >
> > > > > > > > > > I do not want to speak for others on the saliency of th=
eir points, all I
> > > > > > > > > > can say is that the contrary positions have so far not =
moved me to drop
> > > > > > > > > > consideration of fwctl for CXL.
> > > > > > > > > >
> > > > > > > > > > Where CXL has a Command Effects Log that is a reasonabl=
e protocol for
> > > > > > > > > > making decisions about opaque command codes, and that C=
XL already has a
> > > > > > > > > > few years of experience with the commands that *do* nee=
d a Linux-command
> > > > > > > > > > wrapper.
> > > > > > > > > >
> > > > > > > > > > Some open questions from that thread are: what does it =
mean for the fate
> > > > > > > > > > of a proposal if one subsystem Acks the ABI and another=
 Naks it for a
> > > > > > > > > > device that crosses subsystem functionality? Would a cy=
nical hardware
> > > > > > > > > > response just lead to plumbing an NVME admin queue, or =
CXL mailbox to
> > > > > > > > > > get device-specific commands past another subsystem's o=
bjection?
> > > > > > > > >
> > > > > > > > > My default answer would be to trust the maintainers of th=
e relevant
> > > > > > > > > subsystems (or try to convince them when you disagree :-)=
). Not only
> > > > > > > > > should they know the technical implications best, they sh=
ould also have
> > > > > > > > > a good view of the whole vertical stack, and the implicat=
ions of
> > > > > > > > > pass-through for their ecosystem. This may result in a si=
ngle NAK
> > > > > > > > > overriding ACKs, but we could also try to find technical =
solutions when
> > > > > > > > > we'll face such issues, to enforce different sets of rule=
s for the
> > > > > > > > > different functions of a device.
> > > > > > > > >
> > > > > > > > > Subsystem hopping is something we're recently noticed for=
 camera ISPs,
> > > > > > > > > where a vendor wanted to move from V4L2 to DRM. Technical=
 reasons for
> > > > > > > > > doing so were given, and they were (in my opinion) rather=
 excuses. The
> > > > > > > > > unspoken real (again in my opinion) reason was to avoid d=
ocumenting the
> > > > > > > > > firmware interface and ship userspace binary blobs with n=
o way for free
> > > > > > > > > software to use all the device's features. That's somethi=
ng we have been
> > > > > > > > > fighting against for years, trying to convince vendors th=
at they can
> > > > > > > > > provide better and more open camera support without the w=
orld
> > > > > > > > > collapsing, with increasing success recently. Saying amen=
 to
> > > > > > > > > pass-through in this case would be a huge step back that =
would hurt
> > > > > > > > > users and the whole ecosystem in the short and long term.
> > > > > > > >
> > > > > > > > In my view, DRM is a more suitable model for complex ISPs t=
han V4L2:
> > > > > > >
> > > > > > > I know we disagree on this topic :-) I'm sure we'll continue =
the
> > > > > > > conversation, but I think the technical discussion likely bel=
ongs to a
> > > > > > > different mail thread.
> > > > > > >
> > > > > > > > - Userspace Complexity: ISPs demand a highly complex and ev=
olving API,
> > > > > > > > similar to Vulkan or OpenGL. Applications typically need a =
framework
> > > > > > > > like libcamera to utilize ISPs effectively, much like Mesa =
for
> > > > > > > > graphics cards.
> > > > > > > >
> > > > > > > > - Lack of Standardization: There's no universal standard fo=
r ISPs;
> > > > > > > > each vendor implements unique features and usage patterns. =
DRM
> > > > > > > > addresses this through vendor-specific IOCTLs
> > > > > > > >
> > > > > > > > - Proprietary Architectures: Vendors often don't fully disc=
lose their
> > > > > > > > hardware architectures. DRM cleverly only necessitates a Me=
sa
> > > > > > > > implementation, not comprehensive documentation.
> > > > > > >
> > > > > > > This point isn't technical and is more on-topic for this mail=
 thread.
> > > > > > >
> > > > > > > V4L2 doesn't require hundreds of pages of comprehensive docum=
entation in
> > > > > > > text form. An open-source userspace implementation that cover=
s the
> > > > > > > feature set exposed by the driver is acceptable in place of
> > > > > > > documentation (provided, of course, that the userspace code w=
ouldn't be
> > > > > > > deliberately obfuscated). This is similar in spirit to the ru=
le for GPU
> > > > > > > DRM drivers.
> > > > > >
> > > > > > In DRM vendors typically define a custom IOCTL per driver to pa=
ss
> > > > > > command buffers.
> > > > > > Only the command buffer structure, and a mesa implementation us=
ing
> > > > > > that command buffer to support the standard features is require=
d.
> > > > > >
> > > > > > In V4l2 custom IOCTLs are discouraged. Random command buffers c=
annot
> > > > > > be passed from userspace, they are typically formed in the driv=
er from
> > > > > > a strictly checked struct.
> > > > >
> > > > > V4L2 has a mechanism to pass buffers between userspace and kernel=
space,
> > > > > and that mechanism is used in mainline drivers to pass camera ISP
> > > > > parameters. They're not called "command buffers" but that's just =
a
> > > > > difference in terminology. The technical means to pass command bu=
ffers
> > > > > to the driver is thus there, I see no meaningful difference with =
DRM.
> > > > > Where things can differ is in the contents of those buffers, and =
the
> > > > > requirements for documentation or open userspace implementations,=
 but
> > > > > that's not a technical question.
> > > >
> > > > There are two things here:
> > > >
> > > > - The political/strategic/philosophical/religious aspect: The indus=
try
> > > > definitely prefers the strategic requirements imposed by DRM. In fa=
ct
> > > > some vendors had some huge legal troubles when they had tried to
> > > > follow v4l2 requirements.
> > >
> > > That's I'm willing to debate.
> > >
> > > > - The technical aspect: DRM is more mature when it comes to
> > > > sending/receiving buffers to the hardware, and an ISP looks *much*
> > > > more similar to an accel device or a GPU than a UVC camera.
> > >
> > > But this I don't agree with. I think we should forgo the technical
> > > discussion and stop pretending that DRM is better for this use case f=
rom
> > > a technical point of view, and focus on the other aspect of the
> > > discussion. (We can of course reopen the technical discussion if new
> > > concrete arguments emerge.)
> >
> > I disagree. ISP devices are EXACTLY the same as accel devices.
>
> I'm sorry, but this kind of argument makes me wonder if you know how
> ISPs work :-(

Laurent, you know for a while and I am not new in this area. Let's
keep the discussion civil. Can we?

>
> > I suspect that you want to avoid them handled in DRM because then you
> > prefer the v4l2 openness requirements.
>
> I certainly prefer that, but I also think we would end up having the
> exact same openness requirement with DRM. That's at least what I would
> aim for.
>
> I do also suspect that you want to handle ISPs in DRM only because you
> believe it would give vendors a free pass-through card, and that the
> technical arguments you brought up in the discussions are just a
> distraction.

Let's put it this way:

If tomorrow a vendor sends to the ML a camera stack that looks like this:

- V4L2 driver for capture
- DRM driver for ISP
- Libcamera implementation with open algorithms
- Everything released with an Open Licence
- The camera stack is production ready: Meaning that it could be
included without any vendor blob in a distro like ChromeOS.

Would you NACK it because the vendor did not release the calibration softwa=
re?
Would you NACK it because the vendor could also release another userspace?

That NACK will benefit the users? in what timeframe? Another decade?

Does the rest of the kernel community agree on that? I thought that we
were doing Linux for world domination :)


>
> > There are no technical benefit
> > from v4l2 for using ISPs:
> >
> > ```
> > Everyone agrees that the current V4L2 API is not very suitable for the
> > current generation of ISPs: it is too cumbersome.
> > ```
> > https://linuxtv.org/news.php?entry=3D2022-11-14-1.hverkuil
>
> And we've improved the situation since then, and landed/landing more ISP
> drivers. There's further ongoing improvements pending.

We are indeed improving, but I still agree with the original statement.

>
> > > > > > > > Our current approach of pushing back against vendors, inste=
ad of
> > > > > > > > seeking compromise, has resulted in the vast majority of th=
e market
> > > > > > > > (99% if not more) relying on out-of-tree drivers. This leav=
es users
> > > > > > > > with no options for utilizing their cameras outside of Andr=
oid.
> > > > > > > >
> > > > > > > > DRM allows a hybrid model, where:
> > > > > > > > - Open Source Foundation: Standard use cases are covered by=
 a fully
> > > > > > > > open-source stack.
> > > > > > > > - Vendor Differentiation: Vendors retain the freedom to imp=
lement
> > > > > > > > proprietary features (e.g., automatic makeup) as closed sou=
rce.
> > > > > > >
> > > > > > > V4L2 does as well, you can implement all kind of closed-sourc=
e ISP
> > > > > > > control algorithms in userspace, as long as there's an open-s=
ource
> > > > > > > implementation that exercises the same hardware features. A g=
ood analogy
> > > > > >
> > > > > > Is it really mandatory to have an open-source 3A algorithm? I t=
hought
> > > > > > defining the input and output from the algorithm was good enoug=
h.
> > > > >
> > > > > What really matters is documenting the ISP parameters with enough
> > > > > details to allow for the implementation of open-source userspace =
code.
> > > > > Once you have that, 3A is quite simple. You can refine it (especi=
ally
> > > > > AWB) to great length, for instance using NPUs to compute paramete=
rs, and
> > > > > there's absolutely no issue with such userspace implementations b=
eing
> > > > > closed.
> > > > >
> > > > > In practice, some vendors prefer documenting the parameters by wr=
iting
> > > > > an open-source userspace implementation, partly maybe because dev=
elopers
> > > > > are more familiar writing code than formal documentation. I would=
 be
> > > > > fine either way, as long as there's enough information to make us=
e of
> > > > > the ISP.
> > > >
> > > > Even with vendor passthrough there is still a need to provide a ful=
l
> > > > open source implementation (probably based on libcamera).
> > >
> > > We have a different interpretation of "full" :-) I want to aim for
> > > "full" to cover all the features exposed by the driver UAPI. There co=
uld
> > > be some exceptions that we can discuss if there are compeling argumen=
ts,
> > > but that would result in a 99% coverage, not a 20%, 50% or 80% covera=
ge.
> >
> > Full means that I can use my camera using debian main and nothing more
> > than that.  It is a pretty accepted description of what fully open
> > means.
>
> Thanks to the soft ISP support we've just landed in libcamera, and the
> IPU6 ISYS driver merged in mainline, you will be able to use your camera
> with Debian main as soon as it integrates recent enough versions of the
> kernel and libcamera packages. I hope you don't consider that as full
> support.

It is not "full support" because it is missing a lot of the basic
characteristics..

Why don't you want to describe what are the objective characteristics
that an Open Camera stack should have?

Asking vendors to fulfill a set of characteristics is more realistic
than asking them to document the ISP hardware, the ISP algos,  the
calibration files, the calibration tools...


>
> > > > So you will have enough information to use all the common
> > > > functionality of a camera.
> > > >
> > > > > > AFAIK for some time there was no ipu3 open source algorithm, an=
d the
> > > > > > driver has been upstream.
> > > > >
> > > > > It sneaked in before we realized we had to enforce rules :-) That=
's
> > > > > actually a good example, when we wrote open-source userspace supp=
ort, we
> > > > > realized that the level of documentation included in the IPU3 ker=
nel
> > > > > header was nowhere close to what was needed to make use of the de=
vice.
> > > > >
> > > > > > > for people less familiar with ISPs is shader compilers, GPU v=
endors are
> > > > > > > free to ship closed-source implementations that include more
> > > > > > > optimizations, as long as the open-source, less optimized imp=
lementation
> > > > > > > covers the same GPU ISA, so that open-source developers can a=
lso work on
> > > > > > > optimizing it.
> > > > > >
> > > > > > I believe a more accurate description is that in v4l2 is that w=
e
> > > > > > expect that all the registers, device architecture and behaviou=
r to be
> > > > > > documented and accessed with standard IOCTLs. Anything not docu=
mented
> > > > > > cannot be accessed by userspace.
> > > > > >
> > > > > > In DRM their concern is that there is a fully open source
> > > > > > implementation that the user can use. Vendors have custom IOCTL=
s and
> > > > > > they can offer proprietary software for some use cases.
> > > > >
> > > > > Custom ioctls are not closed secrets in DRM, so comparing custom =
ioctls
> > > > > vs. standard ioctls isn't very relevant to this discussion. I rea=
lly
> > > > > don't see how this would be about ioctls, it's about making the f=
eatured
> > > > > exposed by the drivers, through whatever means a particular subsy=
stem
> > > > > allows, usable by open userspace.
> > > > >
> > > > > > > Thinking that DRM would offer a free pass-through path compar=
ed to V4L2
> > > > > > > doesn't seem realistic to me. Both subsystems will have simil=
ar rules.
> > > > > >
> > > > > > DRM does indeed allow vendors to pass random command buffers an=
d they
> > > > > > will be sent to the hardware. We cannot do that in v4l2.
> > > > >
> > > > > You can pass a command buffer to a V4L2 device and have the drive=
r send
> > > > > it to the device firmware (ISPs using real command buffers usuall=
y run a
> > > > > firmware). If you want the driver to be merged upstream, you have=
 to
> > > > > document the command buffer in enough details.
> > > >
> > > > Documenting with "enough details" is not enough. In V4L2, we have t=
o
> > > > deeply inspect every single buffer to make sure that it is not send=
ing
> > > > an unknown combination of command+arguments, or in other situations=
 we
> > > > construct the command buffer in the driver.
> > > >
> > > > > > I might be wrong, but GPU drivers do not deeply inspect the com=
mand
> > > > > > buffers to make sure that they do not use any feature not cover=
ed by
> > > > > > mesa.
> > > > >
> > > > > That's correct, but I don't think that's relevant. The GPU market=
 has
> > > > > GLSL and Vulkan. An open-source compliant implementation will end=
 up
> > > > > exercising a very very large part of the device ISA, command subm=
ission
> > > > > mechanism and synchronization primitives, if not all of it. There=
's
> > > > > little a vendor would keep under the hood and use in closed-sourc=
e
> > > > > userspace only. For cameras, there's no standard userspace API th=
at
> > > > > covers by design a very large part of what is the ISP equivalent =
of a
> > > >
> > > > Libcamera supports Camera HAL3, gstreamer, v4l2, pipewire...
> > >
> > > Those are not comparable to GLSL or Vulkan, they are much higher leve=
l.
> > >
> > > > If we are afraid of vendors providing "toy" implemententations to p=
ass
> > > > the openness requirements, we can add more features/tests to
> > > > libcamera.
> > > >
> > > > And at the end of the day, there will be humans deciding if what a
> > > > vendor has provided is good enough or not.
> > > >
> > > > > GPU ISA. Even "command buffers" are not a proper description of t=
he
> > > > > parameters the vast majority of ISPs consume.
> > > >
> > > > Modern ISPs are definitely going in the direction of "command buffe=
rs"
> > >
> > > Examples please, with technical details. I've seen this argument bein=
g
> > > used for at least a year, with very little evidence. There are ISPs t=
hat
> > > are more programmable than others, but in practice firmwares mostly
> > > expose fixed functions, not ISA-level programmability.
> >
> > You have not seen many programmable ISPs in v4l2 because they cannot
> > be supported with v4l2.
>
> I have not seen many programmable ISPs, period. I would like to see
> concrete examples of those ISPs, with technical details of the hardware
> and firmware, disregarding which kernel API we would use.

Just to name one with some public details, Synopsys has a family of devices=
:
https://www.synopsys.com/dw/ipdir.php?ds=3Dev7x-vision-processors
You can do standard ISP + AI with one core, pretty cool.

Most of the time, Camera ISPs are nothing more than DSPs plus a
firmware with the computer vision algos.

If there is no framework to use a programmable ISP, vendors will keep
putting everything on the firmware and exposing parameters.

>
> > Instead vendors have to create huge firmwares that limits the
> > capability of the device.
> > I do not want to look into those firmwares.
> >
> > > > > > > > This approach would allow billions of users to access their=
 hardware
> > > > > > > > more securely and with in-tree driver support. Our current =
stubborn
> > > > > > > > pursuit of an idealistic goal has already negatively impact=
ed both
> > > > > > > > users and the ecosystem.
> > > > > > > >
> > > > > > > > The late wins, in my opinion, cannot scale to the consumer =
market, and
> > > > > > > > Linux will remain a niche market for ISPs.
> > > > > > > >
> > > > > > > > If such a hybrid model goes against Linux goals, this is so=
mething
> > > > > > > > that should be agreed upon by the whole community, so we ha=
ve the same
> > > > > > > > criteria for all subsystems.
>
> --
> Regards,
>
> Laurent Pinchart



--=20
Ricardo Ribalda

