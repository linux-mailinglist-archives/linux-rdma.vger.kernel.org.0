Return-Path: <linux-rdma+bounces-17848-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDOJC03hr2nkdAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17848-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:15:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 819972481DB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFD1230927C9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0343CEEF;
	Tue, 10 Mar 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6+Cn7gA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A513C3BF9;
	Tue, 10 Mar 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133658; cv=none; b=WCaQR4fK3w4x/sCfUqgzgr7XowXe47F4iVTXx3q/Pvid2gJ5iI+Z3AZ0JkPK6ic84eQYygHvhYeREaUZ/QeHuaEeDW+W8pgriXnDxjsiMO54wdOIgvDdnc/EiTmC5wDhvjcqxmcZtC6c9I149mRddl7LjJSBoaDvFpj5je8cjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133658; c=relaxed/simple;
	bh=tKgVoXuW1Tq5xZXw+M+691E3NQ1lD8UVb3M83asaN/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJI50fPev3WNd/NL28a6/Zm0uEVYWfyOkjeixkG0ZN+S61gQYwGtjgCaVapnYfvtefUDL72MvlK/kSrd7rieejddzm4HGAFteUSn5vBKRoGL3VTDVDyl+GC2KBLVL/jJGpWCx1CtQgF8V2/qgqQqDn8rPh022rUvEyEpxPDhh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6+Cn7gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527AEC2BC86;
	Tue, 10 Mar 2026 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133658;
	bh=tKgVoXuW1Tq5xZXw+M+691E3NQ1lD8UVb3M83asaN/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6+Cn7gAC1nLXcR+T8W1h7NIEsW0+HUnlmMtZQD7jVQpXq2ww89DPdrqDGWbXBk7Z
	 e7IDxqpjjN+OCgYe4yf+P6cMjIxjzwuMgpIKKdMmDqmv2DuVpFBkPwz+fZu/5D/JBX
	 Rs4aGP9H9Ck2XcSJ9qG987/DuCdlUV4kfA80BRzAvb7+W1pGPaXdLKpWJc7s31qB/e
	 kWj8sKLcmIGBjVnCYRiz7ybsJyI4YlZukfWZ17C/xRwPP07MWEIeOlng50y95cKa/O
	 wrEqHiKBbDgUO4tRAV0DwsBB4hh3Vwv1lGpfaY2d7v8AN23GC7fdQ+mjv9CXa1ZCep
	 Dr37CrJ+T8yog==
Date: Tue, 10 Mar 2026 11:07:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
Message-ID: <20260310090733.GA12611@unreal>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal>
 <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
X-Rspamd-Queue-Id: 819972481DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17848-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> On Mon, Mar 9, 2026 at 3:37 PM Leon Romanovsky <leon@kernel.org> wrote:
> > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > On Mon, Mar 9, 2026 at 7:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > From Chiara:
> > > >
> > > > This patch set introduces a new LSM hook to validate firmware commands
> > > > triggered by userspace before they are submitted to the device. The hook
> > > > runs after the command buffer is constructed, right before it is sent
> > > > to firmware.
> > > >
> > > > The goal is to allow a security module to allow or deny a given command
> > > > before it is submitted to firmware. BPF LSM can attach to this hook
> > > > to implement such policies. This allows fine-grained policies for different
> > > > firmware commands.
> > > >
> > > > In this series, the new hook is called from RDMA uverbs and from the fwctl
> > > > subsystem. Both the uverbs and fwctl interfaces use ioctl, so an obvious
> > > > candidate would seem to be the file_ioctl hook. However, the userspace
> > > > attributes used to build the firmware command buffer are copied from
> > > > userspace (copy_from_user()) deep in the driver, depending on various
> > > > conditions. As a result, file_ioctl does not have the information required
> > > > to make a policy decision.
> > > >
> > > > This newly introduced hook provides the command buffer together with relevant
> > > > metadata (device, command class, and a class-specific device identifier), so
> > > > security modules can distinguish between different command classes and devices.
> > > >
> > > > The hook can be used by other drivers that submit firmware commands via a command
> > > > buffer.
> > >
> > > Hi Leon,
> > >
> > > At the link below, you'll find guidance on submitting new LSM hooks.
> > > Please take a look and let me know if you have any questions.
> > >
> > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-hooks
> >
> > I assume that you are referring to this part:
> 
> I'm referring to all of the guidance, but yes, at the very least that
> is something that I think we need to see in a future revision of this
> patchset.
> 
> >  * New LSM hooks must demonstrate their usefulness by providing a meaningful
> >    implementation for at least one in-kernel LSM. The goal is to demonstrate
> >    the purpose and expected semantics of the hooks. Out of tree kernel code,
> >    and pass through implementations, such as the BPF LSM, are not eligible
> >    for LSM hook reference implementations.
> >
> > The point is that we are not inspecting a kernel call, but the FW mailbox,
> > which has very little meaning to the kernel. From the kernel's perspective,
> > all relevant checks have already been performed, but the existing capability
> > granularity does not allow us to distinguish between FW_CMD1 and FW_CMD2.
> 
> It might help if you could phrase this differently, as I'm not
> entirely clear on your argument.  LSMs are not limited to enforcing
> access controls on requests the kernel understands (see the SELinux
> userspace object manager concept), and the idea of access controls
> with greater granularity than capabilities is one of the main reasons
> people look to LSMs for access control (SELinux, AppArmor, Smack,
> etc.).

I should note that my understanding of LSM is limited, so some parts of my
answers may be inaccurate.

What I am referring to is a different level of granularity — specifically,
the internals of the firmware commands. In the proposed approach, BPF
programs would make decisions based on data passed through the mailbox.
That mailbox format varies across vendors, and may even differ between
firmware versions from the same vendor.

> 
> > Here we propose a generic interface that can be applied to all FWCTL
> > devices without out-of-tree kernel code at all.
> 
> I expected to see a patch implementing some meaningful support for
> access controls using these hooks in one of the existing LSMs, I did
> not see that in this patchset.

In some cases, the mailbox is forwarded from user space unchanged, but
in others the kernel modifies it before submitting it to the FW.

For example, at line 1140 we update the UID field, which indicates the
process to which the request belongs. This field is managed by the
kernel to ensure that user processes cannot access FW internals of other
processes.

1108 static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OTHER)( 
1109         struct uverbs_attr_bundle *attrs)            
1110 {                                                   
1111         struct mlx5_ib_ucontext *c;                
1112         struct mlx5_ib_dev *dev;                  
1113         void *cmd_in = uverbs_attr_get_alloced_ptr( 
1114                 attrs, MLX5_IB_ATTR_DEVX_OTHER_CMD_IN);

<...>

1121         int uid; 

<...>

1128         uid = devx_get_uid(c, cmd_in); 
1129         if (uid < 0)
1130                 return uid;                                                                                                                                                                              

<...>

1140         MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid); 
1141         err = security_fw_validate_cmd(cmd_in, cmd_in_len, &dev->ib_dev.dev, 
1142                                        FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
1143         if (err)
1144                 return err; 
1145                            
1146         err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out, cmd_out_len);      

Could you point me to the LSM that would be best suited for performing  
checks of this kind?

Thanks

> 
> --
> paul-moore.com

