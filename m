Return-Path: <linux-rdma+bounces-8716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465ADA624F4
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 03:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC77A4C9A
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF618A6AD;
	Sat, 15 Mar 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgHBmX0b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392F2E3381;
	Sat, 15 Mar 2025 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007200; cv=none; b=REFpuAd55dAOZVrm1NOoCcN4KVgdHPE32Gzga78BF3wCPITS0ECi/SHN2vfVkc0pqzVtL62e9zJk+sIK2sbHej8Ylw5TjIT4Jg+P6M+bM3yrhNTt8MZS9rkgqEVGQPqWTk7Naf6DDJqqw7e4qfKWb41ufGCrPBpqf1cSMmiqJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007200; c=relaxed/simple;
	bh=eR93LZRlkXRjdcAsjbfSSbp6FVhZd4WDgyK33xzGa7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZMyGc88eTpcmkR5Ht1LIcTReBrWvKZZW86QO8JenUCMPS7uj6bSg+wfaNx34o1rqj/ucxsXHVjWqC1OOc1q0i3VZBUaJO/6S3mKvW4F1rZSYb+IqA/uNm18zFMrgUjTBDYkp+CqZwEQPOaF1JkRiGtVRRwTQs/tancUE3AfXgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgHBmX0b; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22398e09e39so58655435ad.3;
        Fri, 14 Mar 2025 19:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742007197; x=1742611997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWfH6bImCkbZLbOYe4CWpozlOiw44fSYAmXL+4VOHVc=;
        b=fgHBmX0bDfoMH6UWB7m1pxmJ5AtjtB2UpDhe5f7jmGdsZRRVTOhOy4BV+0KH5rQ1C3
         0HDw9s5shjBbi672Phau1yUUHzr3ux+eP+OSj0NnRWy4UlpVVnPzsYO9PFL9Jx0coJi1
         hr+rn/oqG3RKan7gSTXbGnJDMO5ZJ54JC8viT8ahm4p/olzfjj1jWfdrs+zuOlpRAVzn
         U1wg2dmHOp8657QGUi3fWDdupWiU0RfB16Cq88UVLLRWdQKPPzNCic5BHGouNtyze9sJ
         /0xcSklUrQsvN74h5N/FfUViaQuJiWLCr6+YGXDWaAHWHM+fQ0JkyNRRzD6fGc2RzzQ/
         Ljcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007197; x=1742611997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWfH6bImCkbZLbOYe4CWpozlOiw44fSYAmXL+4VOHVc=;
        b=FeLF3GDsAINEwQDqSCILl+fCtQc7WshxV2qsuUK5huSTdypnseiOqR+zU8yUx4E0B3
         2Mn3Wpxi6RHqJr6TGhqLGv489qzA+BjA6FLch+J7PBu5hlBeYxWOvfsQdSnQzGm9aHv+
         ZXpyXNPcgoHx8h46mBRMLP56Mal1/vud8SM0la4EW+aSsObE5sclzrF3Ko9On/bHlu4S
         rdaz15Hz2bYxx02IbPE+scgO5Id0znJhdSMBe/xaac5iTBLJjCE8j16rkc5ekSCsl9Pn
         mTBqMqcC64YiFHoUprtSk2/VaGTvQhGix1pOcShx0AejtY2bkkLtQKm+2Hm9REr/62fI
         ev/g==
X-Forwarded-Encrypted: i=1; AJvYcCU+rRXwS8cxsLu7crW78wwLJ4o3rHnLREfOM0pqwEhuZtiSwjqutvaU28PUXFb81FJrxNUtdkZoOzA=@vger.kernel.org, AJvYcCUNt40ap5qT9rStrAyiFs5Cx8qiNA7N/Cb3Hr/Fa9eHcFpr6evS9VlI9PFh1NtkNBEUb/V6zezG@vger.kernel.org, AJvYcCXRddIXqPu/6mVWBem9A7Zffs+hq1Tv7S1Ece/LmoWJ+iEMiE7g1W1qKeGEgsjBmmtjFgNBE/GfP46CyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpv8TQ4q3IdtqL74HrOJsXsZNG0iIdm2eznKy9JI4+nRLmJNa
	cxd8xHqhsYYf3sMdxb38Ccpsfq5GsXxoqg2mSL7hL75im6f+Kwaj
X-Gm-Gg: ASbGncuv9Burj1e47grpvaAOu9XbZBFcMOsNZSiTChC9gh5Ac+IQaEqdhKBrNNulQUe
	3JkKCN7CBbPRxtPi9svEH31lHFTF5S4WmnxVK67mNwBH0oF55EEcttXXXqk19cQxemsZjo5fBFy
	b/xGAiAyU1CIZUVGC1QbeGTyISQTJ3sHmRswDEidNx30IZx2ZHCqIgwFco871lg3okk196WxZpS
	kYdT3H502168NZvQv0u42R4tGD/HstpfoUaWGoAOwDlD9xsLry00omzeMcoiMnpI/1HlnTd03T0
	56qxdMl8xgx4u+CfeMgNNuqWcXB1W1dJocCn6cudfLzu
X-Google-Smtp-Source: AGHT+IE6Iql60XIt+gyPnbUDg2LZTerymiHvTH4NS0pEMRMXxBFYdxGO+Cg6+zY+2sVuDhT1S7l0lQ==
X-Received: by 2002:a17:902:e886:b0:211:e812:3948 with SMTP id d9443c01a7336-225e08597f2mr69697315ad.0.1742007196768;
        Fri, 14 Mar 2025 19:53:16 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm35641445ad.149.2025.03.14.19.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 19:53:15 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7B98040ED645; Sat, 15 Mar 2025 09:53:12 +0700 (WIB)
Date: Sat, 15 Mar 2025 09:53:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 6/8] fwctl: Add documentation
Message-ID: <Z9TrmM9yZpNpOMr4@archie.me>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <6-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ofAJjAS7QeYnLRxw"
Content-Disposition: inline
In-Reply-To: <6-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>


--ofAJjAS7QeYnLRxw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 08:26:34PM -0400, Jason Gunthorpe wrote:
> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/=
userspace-api/fwctl/fwctl.rst
> new file mode 100644
> index 00000000000000..8c586a8f677d5b
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -0,0 +1,284 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +fwctl subsystem
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Jason Gunthorpe
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Modern devices contain extensive amounts of FW, and in many cases, are l=
argely
> +software-defined pieces of hardware. The evolution of this approach is l=
argely a
> +reaction to Moore's Law where a chip tape out is now highly expensive, a=
nd the
> +chip design is extremely large. Replacing fixed HW logic with a flexible=
 and
> +tightly coupled FW/HW combination is an effective risk mitigation agains=
t chip
> +respin. Problems in the HW design can be counteracted in device FW. This=
 is
> +especially true for devices which present a stable and backwards compati=
ble
> +interface to the operating system driver (such as NVMe).
> +
> +The FW layer in devices has grown to incredible size and devices frequen=
tly
> +integrate clusters of fast processors to run it. For example, mlx5 devic=
es have
> +over 30MB of FW code, and big configurations operate with over 1GB of FW=
 managed
> +runtime state.
> +
> +The availability of such a flexible layer has created quite a variety in=
 the
> +industry where single pieces of silicon are now configurable software-de=
fined
> +devices and can operate in substantially different ways depending on the=
 need.
> +Further, we often see cases where specific sites wish to operate devices=
 in ways
> +that are highly specialized and require applications that have been tail=
ored to
> +their unique configuration.
> +
> +Further, devices have become multi-functional and integrated to the poin=
t they
> +no longer fit neatly into the kernel's division of subsystems. Modern
> +multi-functional devices have drivers, such as bnxt/ice/mlx5/pds, that s=
pan many
> +subsystems while sharing the underlying hardware using the auxiliary dev=
ice
> +system.
> +
> +All together this creates a challenge for the operating system, where de=
vices
> +have an expansive FW environment that needs robust device-specific debug=
ging
> +support, and FW-driven functionality that is not well suited to =E2=80=
=9Cgeneric=E2=80=9D
> +interfaces. fwctl seeks to allow access to the full device functionality=
 from
> +user space in the areas of debuggability, management, and first-boot/nth=
-boot
> +provisioning.
> +
> +fwctl is aimed at the common device design pattern where the OS and FW
> +communicate via an RPC message layer constructed with a queue or mailbox=
 scheme.
> +In this case the driver will typically have some layer to deliver RPC me=
ssages
> +and collect RPC responses from device FW. The in-kernel subsystem driver=
s that
> +operate the device for its primary purposes will use these RPCs to build=
 their
> +drivers, but devices also usually have a set of ancillary RPCs that don'=
t really
> +fit into any specific subsystem. For example, a HW RAID controller is pr=
imarily
> +operated by the block layer but also comes with a set of RPCs to adminis=
ter the
> +construction of drives within the HW RAID.
> +
> +In the past when devices were more single function, individual subsystem=
s would
> +grow different approaches to solving some of these common problems. For =
instance
> +monitoring device health, manipulating its FLASH, debugging the FW,
> +provisioning, all have various unique interfaces across the kernel.
> +
> +fwctl's purpose is to define a common set of limited rules, described be=
low,
> +that allow user space to securely construct and execute RPCs inside devi=
ce FW.
> +The rules serve as an agreement between the operating system and FW on h=
ow to
> +correctly design the RPC interface. As a uAPI the subsystem provides a t=
hin
> +layer of discovery and a generic uAPI to deliver the RPCs and collect the
> +response. It supports a system of user space libraries and tools which w=
ill
> +use this interface to control the device using the device native protoco=
ls.
> +
> +Scope of Action
> +---------------
> +
> +fwctl drivers are strictly restricted to being a way to operate the devi=
ce FW.
> +It is not an avenue to access random kernel internals, or other operatin=
g system
> +SW states.
> +
> +fwctl instances must operate on a well-defined device function, and the =
device
> +should have a well-defined security model for what scope within the phys=
ical
> +device the function is permitted to access. For instance, the most compl=
ex PCIe
> +device today may broadly have several function-level scopes:
> +
> + 1. A privileged function with full access to the on-device global state=
 and
> +    configuration
> +
> + 2. Multiple hypervisor functions with control over itself and child fun=
ctions
> +    used with VMs
> +
> + 3. Multiple VM functions tightly scoped within the VM
> +
> +The device may create a logical parent/child relationship between these =
scopes.
> +For instance a child VM's FW may be within the scope of the hypervisor F=
W. It is
> +quite common in the VFIO world that the hypervisor environment has a com=
plex
> +provisioning/profiling/configuration responsibility for the function VFIO
> +assigns to the VM.
> +
> +Further, within the function, devices often have RPC commands that fall =
within
> +some general scopes of action (see enum fwctl_rpc_scope):
> +
> + 1. Access to function & child configuration, FLASH, etc. that becomes l=
ive at a
> +    function reset. Access to function & child runtime configuration tha=
t is
> +    transparent or non-disruptive to any driver or VM.
> +
> + 2. Read-only access to function debug information that may report on FW=
 objects
> +    in the function & child, including FW objects owned by other kernel
> +    subsystems.
> +
> + 3. Write access to function & child debug information strictly compatib=
le with
> +    the principles of kernel lockdown and kernel integrity protection. T=
riggers
> +    a kernel Taint.
> +
> + 4. Full debug device access. Triggers a kernel Taint, requires CAP_SYS_=
RAWIO.
> +
> +User space will provide a scope label on each RPC and the kernel must en=
force the
> +above CAPs and taints based on that scope. A combination of kernel and F=
W can
> +enforce that RPCs are placed in the correct scope by user space.
> +
> +Denied behavior
> +---------------
> +
> +There are many things this interface must not allow user space to do (wi=
thout a
> +Taint or CAP), broadly derived from the principles of kernel lockdown. S=
ome
> +examples:
> +
> + 1. DMA to/from arbitrary memory, hang the system, compromise FW integri=
ty with
> +    untrusted code, or otherwise compromise device or system security and
> +    integrity.
> +
> + 2. Provide an abnormal =E2=80=9Cback door=E2=80=9D to kernel drivers. N=
o manipulation of kernel
> +    objects owned by kernel drivers.
> +
> + 3. Directly configure or otherwise control kernel drivers. A subsystem =
kernel
> +    driver can react to the device configuration at function reset/drive=
r load
> +    time, but otherwise must not be coupled to fwctl.
> +
> + 4. Operate the HW in a way that overlaps with the core purpose of anoth=
er
> +    primary kernel subsystem, such as read/write to LBAs, send/receive of
> +    network packets, or operate an accelerator's data plane.
> +
> +fwctl is not a replacement for device direct access subsystems like uacc=
e or
> +VFIO.
> +
> +Operations exposed through fwctl's non-taining interfaces should be fully
> +sharable with other users of the device. For instance exposing a RPC thr=
ough
> +fwctl should never prevent a kernel subsystem from also concurrently usi=
ng that
> +same RPC or hardware unit down the road. In such cases fwctl will be less
> +important than proper kernel subsystems that eventually emerge. Mistakes=
 in this
> +area resulting in clashes will be resolved in favour of a kernel impleme=
ntation.
> +
> +fwctl User API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/uapi/fwctl/fwctl.h
> +
> +sysfs Class
> +-----------
> +
> +fwctl has a sysfs class (/sys/class/fwctl/fwctlNN/) and character devices
> +(/dev/fwctl/fwctlNN) with a simple numbered scheme. The character device
> +operates the iotcl uAPI described above.
> +
> +fwctl devices can be related to driver components in other subsystems th=
rough
> +sysfs::
> +
> +    $ ls /sys/class/fwctl/fwctl0/device/infiniband/
> +    ibp0s10f0
> +
> +    $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
> +    fwctl0/
> +
> +    $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
> +    dev  device  power  subsystem  uevent
> +
> +User space Community
> +--------------------
> +
> +Drawing inspiration from nvme-cli, participating in the kernel side must=
 come
> +with a user space in a common TBD git tree, at a minimum to usefully ope=
rate the
> +kernel driver. Providing such an implementation is a pre-condition to me=
rging a
> +kernel driver.
> +
> +The goal is to build user space community around some of the shared prob=
lems
> +we all have, and ideally develop some common user space programs with so=
me
> +starting themes of:
> +
> + - Device in-field debugging
> +
> + - HW provisioning
> +
> + - VFIO child device profiling before VM boot
> +
> + - Confidential Compute topics (attestation, secure provisioning)
> +
> +that stretch across all subsystems in the kernel. fwupd is a great examp=
le of
> +how an excellent user space experience can emerge out of kernel-side div=
ersity.
> +
> +fwctl Kernel API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: drivers/fwctl/main.c
> +   :export:
> +.. kernel-doc:: include/linux/fwctl.h
> +
> +fwctl Driver design
> +-------------------
> +
> +In many cases a fwctl driver is going to be part of a larger cross-subsy=
stem
> +device possibly using the auxiliary_device mechanism. In that case sever=
al
> +subsystems are going to be sharing the same device and FW interface laye=
r so the
> +device design must already provide for isolation and cooperation between=
 kernel
> +subsystems. fwctl should fit into that same model.
> +
> +Part of the driver should include a description of how its scope restric=
tions
> +and security model work. The driver and FW together must ensure that RPCs
> +provided by user space are mapped to the appropriate scope. If the valid=
ation is
> +done in the driver then the validation can read a 'command effects' repo=
rt from
> +the device, or hardwire the enforcement. If the validation is done in th=
e FW,
> +then the driver should pass the fwctl_rpc_scope to the FW along with the=
 command.
> +
> +The driver and FW must cooperate to ensure that either fwctl cannot allo=
cate
> +any FW resources, or any resources it does allocate are freed on FD clos=
ure.  A
> +driver primarily constructed around FW RPCs may find that its core PCI f=
unction
> +and RPC layer belongs under fwctl with auxiliary devices connecting to o=
ther
> +subsystems.
> +
> +Each device type must be mindful of Linux's philosophy for stable ABI. T=
he FW
> +RPC interface does not have to meet a strictly stable ABI, but it does n=
eed to
> +meet an expectation that userspace tools that are deployed and in signif=
icant
> +use don't needlessly break. FW upgrade and kernel upgrade should keep wi=
dely
> +deployed tooling working.
> +
> +Development and debugging focused RPCs under more permissive scopes can =
have
> +less stabilitiy if the tools using them are only run under exceptional
> +circumstances and not for every day use of the device. Debugging tools m=
ay even
> +require exact version matching as they may require something similar to =
DWARF
> +debug information from the FW binary.
> +
> +Security Response
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The kernel remains the gatekeeper for this interface. If violations of t=
he
> +scopes, security or isolation principles are found, we have options to l=
et
> +devices fix them with a FW update, push a kernel patch to parse and bloc=
k RPC
> +commands or push a kernel patch to block entire firmware versions/device=
s.
> +
> +While the kernel can always directly parse and restrict RPCs, it is expe=
cted
> +that the existing kernel pattern of allowing drivers to delegate validat=
ion to
> +FW to be a useful design.
> +
> +Existing Similar Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The approach described in this document is not a new idea. Direct, or ne=
ar
> +direct device access has been offered by the kernel in different areas f=
or
> +decades. With more devices wanting to follow this design pattern it is b=
ecoming
> +clear that it is not entirely well understood and, more importantly, the
> +security considerations are not well defined or agreed upon.
> +
> +Some examples:
> +
> + - HW RAID controllers. This includes RPCs to do things like compose dri=
ves into
> +   a RAID volume, configure RAID parameters, monitor the HW and more.
> +
> + - Baseboard managers. RPCs for configuring settings in the device and m=
ore
> +
> + - NVMe vendor command capsules. nvme-cli provides access to some monito=
ring
> +   functions that different products have defined, but more exist.
> +
> + - CXL also has a NVMe-like vendor command system.
> +
> + - DRM allows user space drivers to send commands to the device via kern=
el
> +   mediation
> +
> + - RDMA allows user space drivers to directly push commands to the device
> +   without kernel involvement
> +
> + - Various =E2=80=9Craw=E2=80=9D APIs, raw HID (SDL2), raw USB, NVMe Gen=
eric Interface, etc.
> +
> +The first 4 are examples of areas that fwctl intends to cover. The latte=
r three
> +are examples of denied behavior as they fully overlap with the primary p=
urpose
> +of a kernel subsystem.
> +
> +Some key lessons learned from these past efforts are the importance of h=
aving a
> +common user space project to use as a pre-condition for obtaining a kern=
el
> +driver. Developing good community around useful software in user space i=
s key to
> +getting companies to fund participation to enable their products.

The doc looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ofAJjAS7QeYnLRxw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9TrkgAKCRD2uYlJVVFO
o7IZAQDI06rKnNf9M7npajFRJXXva8zW4lEMmmDX0guBiK9p8wEAxQP/CVIwlJdS
b1h7Rb4lazEoe+UYCH1Z5g6H2j/V5gk=
=lJ3A
-----END PGP SIGNATURE-----

--ofAJjAS7QeYnLRxw--

