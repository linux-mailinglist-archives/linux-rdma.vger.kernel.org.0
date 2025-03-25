Return-Path: <linux-rdma+bounces-8933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C5A70365
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E33918959B1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045B259CA2;
	Tue, 25 Mar 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i1ho4XVe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F5208AD
	for <linux-rdma@vger.kernel.org>; Tue, 25 Mar 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911984; cv=none; b=WdscE+13xPGQ2AjCWThjzGf6zQ6VN9qH1SpTd7UyA7/mbdLB0Els7zqQtiFnCSsOspo5DyuKHCEszh1XhkadToH9Qdj4Bnh51LjxpVAVysmGZf+mtnkmtWN/msQCcCCt90WYsfnAZp+sZBsVNQJ0kwTWGdhOkoVMiUuIhZz179E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911984; c=relaxed/simple;
	bh=wdYcblkdTlodNxKotagg9w4ITXN7HJcuhluELxuJ9l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoN6vtgdhGs6QK9dADw6w9fKoAN5gX16oMsgJ2NPfZKxl55y0/MSRYpb9m0s1a6Y/PBeTLe5xKcchFgK0a81GUcFB8jA41C5bEhL+QkNNeetSSOH8udfxGM1HHbhF2bf02V8c0l6KVIJtijgeLRPUyUXQbYd8bpdwC+hmONUr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=i1ho4XVe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22548a28d0cso118891015ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 Mar 2025 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1742911982; x=1743516782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpLg8K1NGJ9cRCtq2vjOTqpDTiDZuMi/GoIzRfbYSwk=;
        b=i1ho4XVeCXDCRmXsSMCCOTAwVk3kYgSO52sycmY6HIu94v96OGS/we6a/rIQci/yWo
         To31CnUzlCoUgvnXFcJ7cbA0ozrECZRjBlnxp87wNlra8QOTfCnpNEj0vF9ctv4oDN5F
         etC4BAlHtuanGYO7Z32n1vDRN7E5xrKG6V2+HGLFnmnCpHD15pDX3Jyw15SI9ITaMFWo
         05AIH88TW9tHc6G0aPrkO+WqiEo7CsuLtLPB8r9zLkOmD6oEs/B0Cl0i3Yxe9kts6wQ3
         3MMzSv5KKnjzFfee2HeHVXMv3/sUZNvfZQR7IHIoGWXnXkhRF+M5ZKMNs/W6nfkeUcBm
         AXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911982; x=1743516782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpLg8K1NGJ9cRCtq2vjOTqpDTiDZuMi/GoIzRfbYSwk=;
        b=rSM/XAMhguI5/Tl4SZ6giL9lxEUUyQ9qqYUebUTtEGWZJGkEn0FZvDWhzUCcQkbpWB
         /1HpkO2eDwDuMvuoB2LctZKAsFkZZCaK53dLE//sVGEwsrQj/Pjin5heXv2U7TZuOMze
         U78EoR3s+gb+/4L3RevGPe9kWO/362o8LRV29INrQIcyo7VA4tBn2rp4wZ3EmhsfbHrr
         AnJ0AdKtXUsRkLe6yEvk8jzVojdoOE1Xo0blIHpZDj0A+WX1iVGLUZEPCaoyG+bFj2M3
         GnyP3bIa6Ufeh88rh1Lr2wgW0kXX4lZZTe6sbNp3ND4S1LqMDNDDqz0HumPPlecYhGg8
         EjyA==
X-Forwarded-Encrypted: i=1; AJvYcCV1eDiwTK7yRnbtH7Pa6BkMz+tdbrap9RINH9+IofZVUlsG2DmLESy4Nmo1IUNXenMjfJyqFWzBbXb6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kWJspW89B24YTpe3Y5D3AXLNZ/DnUKIUFwzmNEUJ0h11VnWt
	u/619p2pxH6GYvLY90naa0xJZHnBbXJlpeA0hgt4jttGOuy2QUcit/Bq+OKgyFfiXanU4b9lz45
	qKK1052FATf+zE7KFqKGlC1OKfSD5SOS03kK6
X-Gm-Gg: ASbGnctYvi24QUjfgZoIUZ0BSyJTkppwBzgSJWufj3UuwCT3QQB++Pr0cY51ltSnAs5
	ikG46JtGuMLyxV6kKv67ZvHAtoKmQRUU108R+kxTkT1Fa5rnS8bSF8asfG52dbC1cQ2hsLm1ZOE
	G/WuKnU2S4LMHEK+UcNzTXZgegFw==
X-Google-Smtp-Source: AGHT+IFinBu8r13wk7C7hAR9zaJnk06Ni/jMsTJ6xAl/H1Tu1n9Qu0hdA8jORpgKJxl5AgO7M89LpMIVsAKaUC3lKMc=
X-Received: by 2002:a17:903:2f47:b0:224:376:7a21 with SMTP id
 d9443c01a7336-22780e0969cmr254612715ad.42.1742911981538; Tue, 25 Mar 2025
 07:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal> <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal> <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal> <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
 <20250318224912.GB9311@nvidia.com> <CAM0EoMkVz8HfEUg33hptE91nddSrao7=6BzkUS-3YDyHQeOhVw@mail.gmail.com>
 <20250319191946.GP9311@nvidia.com>
In-Reply-To: <20250319191946.GP9311@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Mar 2025 10:12:49 -0400
X-Gm-Features: AQ5f1JpA7w4xQkO4LbkDYyOR2FUtIGA4T5wP8DF0LmO6GJam-cM0fME5dR41nxU
Message-ID: <CAM0EoM=7ac-A=ErU_PojZuuB4eHnoe-CdPxBi3x9d+=PxikfgA@mail.gmail.com>
Subject: Re: Netlink vs ioctl WAS(Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Nikolay Aleksandrov <nikolay@enfabrica.net>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Shrijeet Mukherjee <shrijeet@enfabrica.net>, alex.badea@keysight.com, 
	eric.davis@broadcom.com, rip.sohan@amd.com, David Ahern <dsahern@kernel.org>, 
	bmt@zurich.ibm.com, roland@enfabrica.net, 
	Winston Liu <winston.liu@keysight.com>, dan.mihailescu@keysight.com, kheib@redhat.com, 
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com, 
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com, 
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com, 
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:19=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Mar 19, 2025 at 02:21:23PM -0400, Jamal Hadi Salim wrote:
>
> > Curious how you guarantee that a "destroy" will not fail under OOM. Do
> > you have pre-allocated memory?
>
> It just never allocates memory? Why would a simple system call like a
> destruction allocate any memory?

You need to at least construct the message parameterization in user
space which would require some memory, no? And then copy_from_user
would still need memory to copy to?
I am probably missing something basic.

> > > Overall systems calls here should either succeed or fail and be the
> > > same as a NOP. No failure that actually did something and then create=
s
> > > some resource leak or something because userspace didn't know about
> > > it.
> >
> > Yes, this is how netlink works as well. If a failure to delete an
> > object occurs then every transient state gets restored. This is always
> > the case for simple requests(a delete/create/update). For requests
> > that batch multiple objects there are cases where there is no
> > unwinding.
>
> I'm not sure that is complely true, like if userspace messes up the
> netlink read() side of the API and copy_to_user() fails then you can
> get these inconsistencies. In the RDMA model even those edge case are
> properly unwound, just like a normal system call would.
>

For a read() to fail at say copy_to_user() feels like your app or
system must be in really bad shape.
A contingency plan could be to replay the message from the app/control
plane and hope you get an "object doesnt exist" kind of message for a
failed destroy msg.
Or IMO restart the app or system and try to recover/cleanup from
scratch to build a good known state.
IOW, while unwinding is more honorable, unless it comes for cheap it
may not be worth it.
Regardless: How would RDMA unwind in such a case?

> > Makes sense. So ioctls with TLVs ;->
> > I am suspecting you don't have concepts of TLVs inside TLVs for
> > hierarchies within objects.
>
> No, it has not been needed yet, or at least the cases that have come
> up have been happy to use arrays of structs for the nesting. The
> method calls themselves don't tend to have that kind of challenging
> structure for their arguments.
>

ok.
Not sure if this applies to you: Netlink good practise is to ensure
any structs exchanged are 32b aligned and in cases they are not mostly
adding explicit pads.
Fun back in the day on tc when everything worked on x86 then failures
galore on esoteric architectures(I remember trying to run on a switch
which had a PPC cpu with 8B alignmennt). I am searching my brain cells
for what the failures were but getting ENOENT; i think it was more the
way TLV alignment was structured although it could have been offsets
of different fields ended in the wrong place, etc.

> > > RDMA also has special infrastructure to split up the TLV space betwee=
n
> > > core code and HW driver code which is a key feature and necessary par=
t
> > > of how you'd build a user/kernel split driver.
> >
> > The T namespace is split between core code and driver code?
> > I can see that as being useful for debugging maybe? What else?
>
> RDMA is all about having a user/kernel driver co-design.  This means a
> driver has code in a userspace library and code in the kernel that
> work together to implement the functionality. The userspace library
> should be thought of as an extension of the kernel driver into
> userspace.
>
> So, there is alot of traffic between the two driver components that is
> just private and unique to the driver. This is what the driver
> namespace is used for.
>
> For instance there is a common method call to create a queue. The
> queue has a number of core parameters like depth, and address, then it
> calls the driver and there are bunch of device specific parameters
> too, like say queue entry format.
>
> Every driver gets to define its own parameters best suited to its own
> device and its own user/kernel split.
>

I think i got it, to reword what you said:
When you say "driver" you mean "control/provisioning plane" activity
between a userspace control app and kernel objects which likely extend
to hardware (as opposed to datapath send/receive kind activity).
That you have a set of common, agreed-to attributes and then each
vendor would add their own (separate namespace) attributes?
The control app issuing a request would first invoke some common
interface which would populate the applicable common TLVs for that
request then call into a vendor interface to populate vendor specific
attributes.
And in the kernel, some common code would process the common
attributes then pass on the vendor specific data to a vendor driver.

If my reading is right, some comments:
1) You can achieve this fine with netlink. My view of the model is you
would have a T (call it VendorData, which is is defined within the
common namespace) that puts the vendor specific TLVs within a
hierarchy. i.e.
when constructing or parsing the VendorData you invoke vendor specific
extensions.

2) Hopefully the vendor extensions are in the minority. Otherwise the
complexity of someone writing an app to control multiple vendors would
be challenging over time as different vendors add more attributes. I
cant imagine a commonly used utility like iproute2/tc being invoked
with "when using broadcom then use foo=3Dx bar=3Dy" apply but when using
intel use "goo=3Dx-1 and gah=3Dy-2".

3) A Pro/con to #2 depending on which lens you use:  it could be
"innnovation" or "vendor lockin" - depends on the community i.e on the
one hand a vendor could add features faster and is not bottlenecked by
endless mailing list discussions but otoh, said vendor may not be in
any hurry to move such features to the common path (because it gives
them an advantage).

> Building a split user/kernel driver is complicated and uAPI is one of
> the biggest challenges :\
>
> > > > - And as Nik mentioned: The new (yaml)model-to-generatedcode approa=
ch
> > > > that is now common in generic netlink highly reduces developer effo=
rt.
> > > > Although in my opinion we really need this stuff integrated into to=
ols
> > > > like iproute2..
> > >
> > > RDMA also has a DSL like scheme for defining schema, and centralized
> > > parsing and validation. IMHO it's capability falls someplace between
> > > the old netlink policy stuff and the new YAML stuff.
> > >
> >
> > I meant the ability to start with a data model and generate code as
> > being useful.
> > Where can i find the RDMA DSL?
>
> It is done with the C preprocessor instead of an external YAML
> file. Look at drivers/infiniband/core/uverbs_std_types_mr.c at the
> end. It describes a data model, but it is elaborated at runtime into
> an efficient parse tree, not by using a code generator.
>
> The schema is more classical object oriented RPC type scheme where you
> define objects, methods and then method parameters. The objects have
> an entire kernel side infrastructure to manage their lifecycle and the
> attributes have validation and parsing done prior to reaching the C
> function implementing the method.
>
> I always thought it was netlink inspired, but more suited to building
> a uAPI out of. Like you get actual system call names (eg
> UVERBS_METHOD_REG_DMABUF_MR) that have actual C functions implementing
> them. There is special help to implement object allocation and
> destruction functions, and freedom to have as many methods per object
> as make sense.
>

I took a quick look at what you pointed to. It's RPC-ish (just like
_most_ of netlink use is) - so similar roots. IOW, you end up with
methods like create_myfoo() and create_mybar()
Two things:
1) I am not a fan of the RPC approach because it has a higher
developer effort when adding new features. Based on my experience, I
am a fan of CRUD(Create Read Update Delete) - and with netlink i also
get for free the subscribe/publish parts; to be specific _all you
need_ are CRUDPS methods i.e 6 methods tops (which never change). You
can craft any objects to conform to those interfaces. Example, you can
have create(myfoo) not being syntactically different from
create(mybar). This simplifies the data model immensely (and allows
for better automation). Unfortunately the gprcs and thrifts out there
have permeated RPC semantics everywhere(thrift being slightly better
IMO).

2) Using C as the modelling sounds like a good first start to someone
who knows C well but tbh, those macros hurt my eyes for a bit (and i
am someone who loves macro witchcraft). The big advantage IMO of using
yaml or json is mostly the available tooling, example being polyglot.
I am not sure if that is a requirement in RDMA.

> > I dont know enough about RDMA infra to comment but iiuc, you are
> > saying that it is the control infrastructure (that sits in
> > userspace?), that does all those things you mention, that is more
> > important.
>
> There is an entire object model in the kernel and it is linked into
> the schema.
>
> For instance in the above example we have a schema for an object
> method like this:
>
> DECLARE_UVERBS_NAMED_METHOD(
>         UVERBS_METHOD_REG_DMABUF_MR,
>         UVERBS_ATTR_IDR(UVERBS_ATTR_REG_DMABUF_MR_HANDLE,
>                         UVERBS_OBJECT_MR,
>                         UVERBS_ACCESS_NEW,
>                         UA_MANDATORY),
>         UVERBS_ATTR_IDR(UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE,
>                         UVERBS_OBJECT_PD,
>                         UVERBS_ACCESS_READ,
>                         UA_MANDATORY),
>
> That says it accepts two object handles MR and PD as input to the
> method call.
>
> The core code keeps track of all these object handles, validates the
> ID number given by userspace is refering to the correct object, of the
> correct type, in the correct state. Locks things against concurrent
> destruction, and then gives a trivial way for the C method
> implementation to pick up the object pointer:
>
>         struct ib_pd *pd =3D
>                 uverbs_attr_get_obj(attrs, UVERBS_ATTR_REG_DMABUF_MR_PD_H=
ANDLE);
>
> Which can't fail because everything was already checked before we get
> here.  This is all designed to greatly simplify and make robust the
> method implementations that are often in driver code.
>

Again, I could be missing something but the semantics seem to be the
same as netlink.

BTW, do you do fuzzy testing with this? In the old days the whole
netlink infra assumed a philosophy of "we give you the gun, if you
want to shoot yourself in the small toe then go ahead".
IOW, there was no assumption of people doing stupid things - and that
stupid things will only harm them.  Now we have hostile actors,
syzkaller and bounty hunters creating all kinds of UAFs and trying to
trick the kernel into some funky state just because....

cheers,
jamal

