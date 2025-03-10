Return-Path: <linux-rdma+bounces-8546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584EA5A665
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A5618916F7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394A01CEEBE;
	Mon, 10 Mar 2025 21:46:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7FB1D63ED;
	Mon, 10 Mar 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643215; cv=none; b=K3lIbaTCsSoA7OZ6b7vkX8iJCUWmKmZiPkMZ40+6osTyqb5QOlT++i7qGFzaNot+qxH9TYKh1axkRbtw1xLo09U+CrwXSJC/hK+UEOvlIE2zX/0Kr5iC/CtFeydiTgFumYmveTbCM4/VWR1NfC1yWMIfFk21Yzn9fVE+lN7NR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643215; c=relaxed/simple;
	bh=NKDzj9L6JZj8+6yS6hJWjHEFEY5ssOW60gAzYyk4KI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyYP9l44WkETsn2IsQpt1//ul5FCaErTGURTxyPZ94tLMUoxVNvpmYsnxwj+nb6BAfDM/RX0tBpSkcsNEe2ttIocb1qBW4qnu8SM0N+AhzgzmFz5tGV8Z6XUj6XszMchW5hGkJydm6DYvAEdd66AnxxAHZiCOXkl9jRA4P/SOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 3FA5E14DC; Mon, 10 Mar 2025 16:46:50 -0500 (CDT)
Date: Mon, 10 Mar 2025 16:46:50 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: Re: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Message-ID: <20250310214650.GB195898@mail.hallyn.com>
References: <20250308180602.129663-1-parav@nvidia.com>
 <20250310133110.GA190312@mail.hallyn.com>
 <CY8PR12MB71956080B3EDF49B2090E636DCD62@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71956080B3EDF49B2090E636DCD62@CY8PR12MB7195.namprd12.prod.outlook.com>

On Mon, Mar 10, 2025 at 02:47:53PM +0000, Parav Pandit wrote:
> Hi,
> 
> > From: Serge E. Hallyn <serge@hallyn.com>
> > Sent: Monday, March 10, 2025 7:01 PM
> > 
> > On Sat, Mar 08, 2025 at 08:06:02PM +0200, Parav Pandit wrote:
> > > A process running in a non-init user namespace possesses the
> > > CAP_NET_RAW capability. However, the patch cited in the fixes tag
> > > checks the capability in the default init user namespace.
> > > Because of this, when the process was started by Podman in a
> > > non-default user namespace, the flow creation failed.
> > >
> > > Fix this issue by checking the CAP_NET_RAW networking capability in
> > > the owner user namespace that created the network namespace.
> > 
> > Hi,
> > 
> > you say
> > 
> >  > Fix this issue by checking the CAP_NET_RAW networking capability  > in the
> > owner user namespace that created the network namespace.
> > 
> > But in fact you are checking the CAP_NET_RAW against the user's network
> > namespace.  
> I didn't understand your comment.
> The fix takes the current process's network namespace by referring to current->nsproxy->net_ns.
> Each net ns has its owning user namespace who has created it.
> So the patch is checking caps in the such user namespace.
> 
> Can you please elaborate?

It looks like it got straightened out later with Eric's reply.  Please
let me know if that's not the case.

-serge

