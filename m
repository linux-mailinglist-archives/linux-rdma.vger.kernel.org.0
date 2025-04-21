Return-Path: <linux-rdma+bounces-9623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFEA94B92
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 05:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F67B7A29AF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 03:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753882571A6;
	Mon, 21 Apr 2025 03:13:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3D2AF11;
	Mon, 21 Apr 2025 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745205206; cv=none; b=eNMsvrPIooyzaU+ezylc62K+6BUDXHPOtYgNNT3buBoRPEPby66Ht6UQkr1gkV9e6TQaEYK8gyJZ+An+5T1ZERiHudbucw0+uMd7q/Ufl+PDtPJyT4LwQk8t4AuxObrWZSSWOOdwbQma0S8mpREmQKUIlX7U1uZWvvG0ZwPgaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745205206; c=relaxed/simple;
	bh=DGKXx6NAQgM6C+8Fsi2EeXAdX5/lAXsTwPqKFGe0M4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJF7kd/QKuuMvV/E3smXdpfL4+XnP1ItdkAaQ0CYybCBH6J991QFoRqYTi52yJ/N2t/NrJrUUgfhg4FA4ViBeaX/z1gFvz1T7jxpF0GtkKx6an4FouNvsHWHxhOOenNT7CZa4msuIdj87b9ynq9+hADvnzUjQGNflI8yVySaZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 4C8F8E37; Sun, 20 Apr 2025 22:13:20 -0500 (CDT)
Date: Sun, 20 Apr 2025 22:13:20 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"serge@hallyn.com" <serge@hallyn.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250421031320.GA579226@mail.hallyn.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>

On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> Hi Eric, Jason,

Hi,

I'm jumping back up the thread as I think this email best details the
things I'm confused about :)  Three questions below in two different
stanzas.

> To summarize,
> 
> 1. A process can open an RDMA resource (such as a raw QP, raw flow entry, or similar 'raw' resource)
> through the fd using ioctl(), if it has the appropriate capability, which in this case is CAP_NET_RAW.

Why does it need CAP_NET_RAW to create the resource, if the resource won't
be usable by a process without CAP_NET_RAW later anyway?  Is that legacy
for the read/write (vs ioctl) case?  Or is it to limit the number of
opened resources?  Or some other reason?

Is the resource which is created tied to the net namespce of the process
which created it?

> This is similar to a process that opens a raw socket.
> 
> 2. Given that RDMA uses ioctl() for resource creation, there isn't a security concern surrounding
> the read()/write() system calls.
> 
> 3. If process A, which does not have CAP_NET_RAW, passes the opened fd to another privileged
> process B, which has CAP_NET_RAW, process B can open the raw RDMA resource.
> This is still within the kernel-defined security boundary, similar to a raw socket.
> 
> 4. If process A, which has the CAP_NET_RAW capability, passes the file descriptor to Process B, which does not have CAP_NET_RAW, Process B will not be able to open the raw RDMA resource.
> 
> Do we agree on this Eric?
> 
> Assuming yes, to extend this, further,
> 
> 5. the process's capability check should be done in the right user namespace.
> (instead of current in default user ns).
> The right user namespace is the one which created the net namespace.

"the one which created THE net namespace" - which net namespace?   The
one in which the process which created the resource belonged, or the
one in which the current process (calling ioctl) belongs?

> This is because rdma networking resources are governed by the net namespace.
> 
> Above #5 aligns with the example from existing kernel doc snippet below [1] and few kernel examples of [2].
> 
> For example, suppose that a process attempts to change
>        the hostname (sethostname(2)), a resource governed by the UTS
>        namespace.  In this case, the kernel will determine which user
>        namespace owns the process's UTS namespace, and check whether the
>        process has the required capability (CAP_SYS_ADMIN) in that user
>        namespace.
> 
> [1] https://man7.org/linux/man-pages/man7/user_namespaces.7.html
> 
> [2] examples snippet that follows above guidance of #5.
> 
> File: drivers/infiniband/core/device.c  
> Function: ib_device_set_netns_put()
> For net namespace:
> 
>          if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
>                  ret = -EPERM;
>                  goto ns_err;
>          }
>  
> File: fs/namespace.c 
> For mount namespace:
>         if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
>                 goto out;
>         if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
>                 goto out;
>  
> For uts ns:
>  static int utsns_install(struct nsset *nsset, struct ns_common *new)
>  {
>          struct nsproxy *nsproxy = nsset->nsproxy;
>          struct uts_namespace *ns = to_uts_ns(new);
> 
>          if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
>              !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
>                  return -EPERM;
>  
> For net ns:
> File: net/core/dev_ioctl.c
>          case SIOCSHWTSTAMP:
>                  if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>                          return -EPERM;
>                  fallthrough;
>  
> static int do_arpt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
> {
>          int ret;
> 
>          if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
>                  return -EPERM;

