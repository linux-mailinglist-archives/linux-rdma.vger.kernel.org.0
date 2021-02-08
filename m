Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2A4313312
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 14:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBHNQw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 08:16:52 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8759 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBHNQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 08:16:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021398d0000>; Mon, 08 Feb 2021 05:15:57 -0800
Received: from [172.27.14.77] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 13:15:55 +0000
Subject: Re: rdma-core spec weird behavior on Fedora
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Honggang Li <honli@redhat.com>, Itay Aveksis <itayav@nvidia.com>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
References: <20210207080649.GB4656@unreal> <20210208125900.GX4247@nvidia.com>
 <20210208131053.GC20265@unreal>
From:   Alaa Hleihel <alaa@nvidia.com>
Message-ID: <2779ed9e-4072-fe35-796d-b8102e8378f4@nvidia.com>
Date:   Mon, 8 Feb 2021 15:15:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208131053.GC20265@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612790157; bh=D7RnlRPrHIIq2edLdVC9ZDomftqWcMgeUBSAIur1OPw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=NLDSBUAmkT9rntiHj9XKRI1/emQQsjE2XaCR5Vhi/HcJ5dzfy/vsCP0I8EoQrIxQg
         i/KulF1Rpvx1hWetguRNNzCphy9c7v5p7E4X1SlCyrpdgpqhAAbPjLBGnOoddOD8ve
         jy4m19iW1gZeE7noAaX/3quRLjHe5UxKeJI9sB1dg4wjGJCkAVWqW3Av/fLGPXWyq9
         A2hKv8v88PLm3Z4vd4ZZ+c417ozoKsWcnERMCyAfo/T3B+guptSdoOSUwnlg6ib98C
         u6b1oDLOuj3l4RfZi2L1eBBQu0/nqHyoYA4AaoIWs4nidy6unvLyM6GlqSgbYDDer/
         fTbiGXk0tk7nQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08/02/2021 15:10, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, Feb 08, 2021 at 08:59:00AM -0400, Jason Gunthorpe wrote:
>> On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
>>> Hi Honggang,
>>>
>>> Your commit b02de521022a ("redhat: Remove base package dependency from =
all sub-packages")
>>> removes protection from rdma-core when user performs "dnf autoremove".
>>>
>>> Before your patch, systemd was dependent on libibverbs and latter
>>> required rdma-core. After your patch, the last link is lost and
>>> rdma-core marked as orphaned package.
>>>
>>> Any attempt to install rdma-core as standalone package will have the
>>> following errors, due to the library dependency of udevadm.
>>> [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
>>>     libibverbs.so.1 =3D> not found
>>
>> well that makes no sense, since when is udevadm connected to
>> libibverbs?
>>
>> $ ldd `which udevadm`
>>       linux-vdso.so.1 (0x00007ffcc09ef000)
>>       libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000=
)
>>       libkmod.so.2 =3D> /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394b=
ea8000)
>>       libacl.so.1 =3D> /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9=
d000)
>>       libblkid.so.1 =3D> /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f39=
4be46000)
>>       libselinux.so.1 =3D> /lib/x86_64-linux-gnu/libselinux.so.1 (0x0000=
7f394be1b000)
>>       libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0 (0x0000=
7f394bdf8000)
>>       /lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
>>       liblzma.so.5 =3D> /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394b=
dcd000)
>>       libcrypto.so.1.1 =3D> /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00=
007f394baf7000)
>>       libpcre2-8.so.0 =3D> /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x0000=
7f394ba67000)
>>       libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba610=
00)
>=20
> This is from my laptop and it is connected:
>=20
> =E2=9E=9C  kernel git:(m/msix-v6) ldd /sbin/udevadm
>         linux-vdso.so.1 (0x00007fffc4bf2000)
>         libsystemd-shared-246.so =3D> /usr/lib/systemd/libsystemd-shared-=
246.so (0x00007f70f69ef000)
>         libkmod.so.2 =3D> /lib64/libkmod.so.2 (0x00007f70f69c0000)
>         libacl.so.1 =3D> /lib64/libacl.so.1 (0x00007f70f69b6000)
>         libblkid.so.1 =3D> /lib64/libblkid.so.1 (0x00007f70f6981000)
>         libgcc_s.so.1 =3D> /lib64/libgcc_s.so.1 (0x00007f70f6966000)
>         libc.so.6 =3D> /lib64/libc.so.6 (0x00007f70f679b000)
>         libcap.so.2 =3D> /lib64/libcap.so.2 (0x00007f70f6792000)
>         libcrypt.so.2 =3D> /lib64/libcrypt.so.2 (0x00007f70f6758000)
>         libcryptsetup.so.12 =3D> /lib64/libcryptsetup.so.12 (0x00007f70f6=
6e3000)
>         libgcrypt.so.20 =3D> /lib64/libgcrypt.so.20 (0x00007f70f65be000)
>         libidn2.so.0 =3D> /lib64/libidn2.so.0 (0x00007f70f659d000)
>         libip4tc.so.2 =3D> /lib64/libip4tc.so.2 (0x00007f70f6593000)
>         liblz4.so.1 =3D> /lib64/liblz4.so.1 (0x00007f70f6573000)
>         libmount.so.1 =3D> /lib64/libmount.so.1 (0x00007f70f6530000)
>         libcrypto.so.1.1 =3D> /lib64/libcrypto.so.1.1 (0x00007f70f6243000=
)
>         libp11-kit.so.0 =3D> /lib64/libp11-kit.so.0 (0x00007f70f6111000)
>         libpam.so.0 =3D> /lib64/libpam.so.0 (0x00007f70f60ff000)
>         librt.so.1 =3D> /lib64/librt.so.1 (0x00007f70f60f4000)
>         libseccomp.so.2 =3D> /lib64/libseccomp.so.2 (0x00007f70f60d0000)
>         libselinux.so.1 =3D> /lib64/libselinux.so.1 (0x00007f70f60a3000)
>         libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007f70f5fce000)
>         liblzma.so.5 =3D> /lib64/liblzma.so.5 (0x00007f70f5fa2000)
>         libdl.so.2 =3D> /lib64/libdl.so.2 (0x00007f70f5f9b000)
>         libpthread.so.0 =3D> /lib64/libpthread.so.0 (0x00007f70f5f79000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007f70f6d29000)
>         libz.so.1 =3D> /lib64/libz.so.1 (0x00007f70f5f5d000)
>         libattr.so.1 =3D> /lib64/libattr.so.1 (0x00007f70f5f55000)
>         libuuid.so.1 =3D> /lib64/libuuid.so.1 (0x00007f70f5f4c000)
>         libdevmapper.so.1.02 =3D> /lib64/libdevmapper.so.1.02 (0x00007f70=
f5eef000)
>         libssl.so.1.1 =3D> /lib64/libssl.so.1.1 (0x00007f70f5e53000)
>         libargon2.so.1 =3D> /lib64/libargon2.so.1 (0x00007f70f5e4a000)
>         libjson-c.so.5 =3D> /lib64/libjson-c.so.5 (0x00007f70f5e35000)
>         libgpg-error.so.0 =3D> /lib64/libgpg-error.so.0 (0x00007f70f5e100=
00)
>         libunistring.so.2 =3D> /lib64/libunistring.so.2 (0x00007f70f5c8d0=
00)
>         libpcap.so.1 =3D> /lib64/libpcap.so.1 (0x00007f70f5c3e000)

Check if libpcap was built with rdma support.
# nm /lib64/libpcap.so.1 | grep ibv

That's probably what pulled the libibverbs dependency.

Alaa

>         libffi.so.6 =3D> /lib64/libffi.so.6 (0x00007f70f5c33000)
>         libaudit.so.1 =3D> /lib64/libaudit.so.1 (0x00007f70f5c04000)
>         libeconf.so.0 =3D> /lib64/libeconf.so.0 (0x00007f70f5bfa000)
>         libm.so.6 =3D> /lib64/libm.so.6 (0x00007f70f5ab4000)
>         libpcre2-8.so.0 =3D> /lib64/libpcre2-8.so.0 (0x00007f70f5a1d000)
>         libudev.so.1 =3D> /lib64/libudev.so.1 (0x00007f70f59f2000)
>         libibverbs.so.1 =3D> /lib64/libibverbs.so.1 (0x00007f70f59cf000)
>         libcap-ng.so.0 =3D> /lib64/libcap-ng.so.0 (0x00007f70f59c7000)
>         libnl-route-3.so.200 =3D> /lib64/libnl-route-3.so.200 (0x00007f70=
f5944000)
>         libnl-3.so.200 =3D> /lib64/libnl-3.so.200 (0x00007f70f5921000)
> =E2=9E=9C  kernel git:(m/msix-v6) cat /etc/os-release
> NAME=3DFedora
> VERSION=3D"33 (Workstation Edition)"
> ID=3Dfedora
> VERSION_ID=3D33
> VERSION_CODENAME=3D""
> PLATFORM_ID=3D"platform:f33"
> PRETTY_NAME=3D"Fedora 33 (Workstation Edition)"
> ANSI_COLOR=3D"0;38;2;60;110;180"
> LOGO=3Dfedora-logo-icon
> CPE_NAME=3D"cpe:/o:fedoraproject:fedora:33"
> HOME_URL=3D"https://fedoraproject.org/"
> DOCUMENTATION_URL=3D"https://docs.fedoraproject.org/en-US/fedora/f33/syst=
em-administrators-guide/"
> SUPPORT_URL=3D"https://fedoraproject.org/wiki/Communicating_and_getting_h=
elp"
> BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
> REDHAT_BUGZILLA_PRODUCT=3D"Fedora"
> REDHAT_BUGZILLA_PRODUCT_VERSION=3D33
> REDHAT_SUPPORT_PRODUCT=3D"Fedora"
> REDHAT_SUPPORT_PRODUCT_VERSION=3D33
> PRIVACY_POLICY_URL=3D"https://fedoraproject.org/wiki/Legal:PrivacyPolicy"
> VARIANT=3D"Workstation Edition"
> VARIANT_ID=3Dworkstation
>=20
>=20
>>
>> Jason

